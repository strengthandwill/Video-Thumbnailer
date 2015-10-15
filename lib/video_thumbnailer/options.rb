module VideoThumbnailer
  class Options

    CLI_KEY = {
      size: '-s',
      time_frame: '-ss',
      quality: '-q',
      file_extension: '-c'
    }

    def initialize options
      @ptions = options
    end

    def to_options
      result = @ptions.map do |k, v|
        send(k.to_s, v)
      end
      result << "-vframes 1"
      result.join(' ')
    end

    def rotate value
      case value
      when 90  then %Q(-vf transpose=1)
      when 180 then %Q(-vf vflip )
      when 270 then %Q(-vf transpose=2)
      else
        " "
      end
    end

    def method_missing(name, *args)
      return "#{CLI_KEY[name]} #{args[0]}"
    end
  end
end
