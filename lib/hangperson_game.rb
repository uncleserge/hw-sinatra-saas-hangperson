class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    
    raise ArgumentError, "Letter is nil" if letter.nil?
    raise ArgumentError, "Letter is empty" if letter.empty?
    raise ArgumentError, "Letter is not a character" unless letter.match(/[a-zA-Z]/)
 
    letter.downcase!
    
    letter.split(//).each do |l|
      return false if (@guesses.include? l) || (@wrong_guesses.include? l)
      if @word.include? letter
        @guesses += letter
      else
        @wrong_guesses +=letter
      end
    end
    true
  end
  
  def word_with_guesses
    return @word.gsub(/./,'-') if @guesses.empty?
    @word.gsub(Regexp.new("[^#{@guesses}]"),'-')
  end
  
  def check_win_or_lose
    return :win if (not @word.empty?) && (self.word_with_guesses == @word)
    return :lose if @wrong_guesses.length > 6
    return :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
