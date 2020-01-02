require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
  html = open(index_url)
  website = Nokogiri::HTML(html)
 
  students = []
  
  website.css("div.student-card").each do |student|
    
    deets = {}
    
      deets[:name] = student.css("h4.student-name").text
      deets[:location] = student.css("p.student-location").text
      deets[:profile_url] = student.css("a").attribute("href").value
    
    students << deets
    
  end 
  students
  end

  def self.scrape_profile_page(profile_url)
  
  html = open(profile_url)
  profilepage = Nokogiri::HTML(html)
    
      profiledeets = {}
      
      profilepage.css("div.social-icon-container").each do |icon|
        if icon.attribute("href").value.include?("twitter")
          profiledeets[:twitter] = icon.attribute("href").value 
      elsif icon.attribute("href").value.include?("github")
          profiledeets[:github] = icon.attribute("href").value 
      elsif icon.attribute("href").value.include?("linkedin")
          profiledeets[:linkedin] = icon.attribute("href").value
      else icon.attribute("href").value
    end
  end
 
 
      profiledeets[:profile_quote] = profilepage.css("div.vitals-text-container div").text
      profiledeets[:bio] = profilepage.css("div.description-holder").text
    profiledeets
    
  end

end

