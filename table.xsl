<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method ="html" media-type ="text/html"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>Arrivals on HTML format</title>
		    <link rel="stylesheet" href="styles.css" type="text/css" />
      </head>
      <body>
        <h1>
          <center>Arrivals</center>
        </h1>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match ="arrivalTable">
    <xsl:apply-templates select ="flight">
      <xsl:sort select ="arrival/flightTime/time[@type='current']"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match ="flight">
    <xsl:apply-templates select ="number"/>
    <xsl:if test ="position()=last()">
      <hr/>
      <p class="graytext">Total <xsl:value-of select ="last()"/> entries in target XML document</p>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match ="number">
    <table border="1" width="100%">
        <tr>
          <td width="20%">
            <h3>
              <xsl:value-of select = "."/>
            </h3>
          </td>
          <td width="20%">
            <b>from </b>
              <xsl:value-of select = "../departure/depAirport/airport"/>
          </td>
          <td width="20%">
              <xsl:apply-templates select ="../departure/flightTime"/>
          </td>
         <td width="20%">
              <xsl:apply-templates select = "../arrival/arrAirport"/>
          </td>
          <td width="20%">
              <xsl:apply-templates select ="../arrival/flightTime"/>
          </td>
        </tr>
    </table>
  </xsl:template>
  
  <xsl:template match ="flightTime">
    <table border="0" width="100%">
     <xsl:for-each select ="time">
        <tr>
          <td width="40%">
            <xsl:choose>
              <xsl:when test ="@type='plan'"><p class="bluetext">Plan</p></xsl:when>
              <xsl:when test ="@type='current'"><p class="greentext">Current</p></xsl:when>
              <xsl:when test ="@type='prognosis'"><p class="greentext">Prognosis</p></xsl:when>
              <xsl:otherwise><p class="graytext">New info</p></xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="60%">
            <xsl:value-of select ="."/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  
  <xsl:template match ="arrAirport">
    <table border="0" width="100%">
     <xsl:for-each select ="airport">
        <tr>
          <td width="40%">
            <xsl:choose>
              <xsl:when test ="@type='changed'"><p class="redtext">Change</p></xsl:when>
              <xsl:when test ="@type='arrival'"><p class="greentext">Current</p></xsl:when>
              <xsl:when test ="@type='other'"><p class="graytext">New info</p></xsl:when>
            </xsl:choose>
          </td>
          <td width="60%">
            <xsl:value-of select ="."/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  
</xsl:stylesheet> 
