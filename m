Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF029C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD50421774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD50421774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMfm-0006sM-Tl
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaLf1-0004pP-Ju
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaLR7-0005t6-CY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 10:10:30 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:46874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Bilal_Wasim@mentor.com>)
 id 1iaLR6-0005Nl-QZ; Thu, 28 Nov 2019 10:10:29 -0500
IronPort-SDR: 0Qx/Hmk2Tm0jkHE9VaqRqg/re2aQRSOq5gcaUZwPGuCVTNKrKeaZ3z76CQtkYICti6U/vnR/2Z
 J7hY4TssFUIHoBaNYCSHItVtwiwfLk6dgaQ9Su9/yOBpUAkRVoQJMjYzzheemapP77fW5Df4Uy
 vMwe7AkINgDQJ4I3tM/wkHvVdFZHqwz3j5KU8SyQRoNmTlx5KLM7XwCL2Gxq9hO7afrDLsslEF
 XI4OcPB9jV+XsW0pFPe8t0CUYklEBco6JU5/inHA2gTWFZIHFsMTCV8KZrzG4QCVVJE48EUO21
 Q6E=
X-IronPort-AV: E=Sophos;i="5.69,253,1571731200"; d="scan'208,217";a="43544433"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 28 Nov 2019 07:10:21 -0800
IronPort-SDR: SN3mSj21GxZ1A4a2j+Wrih5vVWVzNqZIjEf3/7D7+s7JRVevWrGzC0whS3U+fPrj8vzbuVudWO
 /R1pdP/0L+QWZy8MNymyIEAuFEpBffRmSqEIhFlH9cggRgiEOSrG6QdoQa3nuU43okf0Dt8Cx2
 kkSq1ngXLXJuP7diHpP2k6fAyjjZYcM1m8TDoawSKZcskAxvSX2UVlY8lLx38xqFytFaFP0YC+
 BVdaQOjxNWvcWIlhBbZ8VTmyyW0DePQZ+TznhihHzkp9K3NZ4Xca1NBgZ6zBpSrJ2DsNBexIPb
 RA8=
From: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] Updating the GEM MAC IP to properly filter out the multicast
 addresses
Thread-Topic: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Thread-Index: AdWl/aPyGC40ldXeTIuqOxj9pJGCcw==
Date: Thu, 28 Nov 2019 15:10:16 +0000
Message-ID: <2632212d4c8a40bead72ffdcf288e600@SVR-IES-MBX-03.mgc.mentorg.com>
Accept-Language: en-GB, en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: multipart/alternative;
 boundary="_000_2632212d4c8a40bead72ffdcf288e600SVRIESMBX03mgcmentorgco_"
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.98
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_2632212d4c8a40bead72ffdcf288e600SVRIESMBX03mgcmentorgco_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[PATCH] Updating the GEM MAC IP to properly filter out the multicast
addresses. The current code makes a bad assumption that the most-significan=
t
byte of the MAC address is used to determine if the address is multicast or
unicast, but in reality only a single bit is used to determine this. This
caused IPv6 to not work.. Fix is now in place and has been tested with
ZCU102-A53 / IPv6 on a TAP interface. Works well..

Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
---
hw/net/cadence_gem.c | 18 ++++++++++++------
1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b8be73d..f8bcbb3 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -315,6 +315,12 @@
 #define GEM_MODID_VALUE 0x00020118
+/* IEEE has specified that the most significant bit of the most significan=
t byte be used for
+ * distinguishing between Unicast and Multicast addresses.
+ * If its a 1, that means multicast, 0 means unicast.   */
+#define IS_MULTICAST(address)           (((address[0] & 0x01) =3D=3D 0x01)=
 ? 1 : 0)
+#define IS_UNICAST(address)             (!IS_MULTICAST(address))
+
static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *des=
c)
{
     uint64_t ret =3D desc[0];
@@ -690,21 +696,21 @@ static int gem_mac_address_filter(CadenceGEMState *s,=
 const uint8_t *packet)
     }
     /* Accept packets -w- hash match? */
-    if ((packet[0] =3D=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HA=
SH)) ||
-        (packet[0] !=3D 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH=
))) {
+    if ((IS_MULTICAST(packet) && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HAS=
H)) ||
+        (IS_UNICAST(packet)   && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HAS=
H))) {
         unsigned hash_index;
         hash_index =3D calc_mac_hash(packet);
         if (hash_index < 32) {
             if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
-                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACCEP=
T :
-                                           GEM_RX_UNICAST_HASH_ACCEPT;
+                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCEPT=
 :
+                                              GEM_RX_UNICAST_HASH_ACCEPT;
             }
         } else {
             hash_index -=3D 32;
             if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
-                return packet[0] =3D=3D 0x01 ? GEM_RX_MULTICAST_HASH_ACCEP=
T :
-                                           GEM_RX_UNICAST_HASH_ACCEPT;
+                return IS_MULTICAST(packet) ? GEM_RX_MULTICAST_HASH_ACCEPT=
 :
+                                              GEM_RX_UNICAST_HASH_ACCEPT;
             }
         }
     }
--
2.9.3


--_000_2632212d4c8a40bead72ffdcf288e600SVRIESMBX03mgcmentorgco_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">[PATCH] Updating the GEM MAC IP to properly filter o=
ut the multicast<o:p></o:p></p>
<p class=3D"MsoNormal">addresses. The current code makes a bad assumption t=
hat the most-significant<o:p></o:p></p>
<p class=3D"MsoNormal">byte of the MAC address is used to determine if the =
address is multicast or<o:p></o:p></p>
<p class=3D"MsoNormal">unicast, but in reality only a single bit is used to=
 determine this. This<o:p></o:p></p>
<p class=3D"MsoNormal">caused IPv6 to not work.. Fix is now in place and ha=
s been tested with<o:p></o:p></p>
<p class=3D"MsoNormal">ZCU102-A53 / IPv6 on a TAP interface. Works well..<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Bilal Wasim &lt;bilal_wasim@mentor.co=
m&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">hw/net/cadence_gem.c | 18 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;------<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 12 insertions(&#43;), 6 deletions(-)=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_g=
em.c<o:p></o:p></p>
<p class=3D"MsoNormal">index b8be73d..f8bcbb3 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/net/cadence_gem.c<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/hw/net/cadence_gem.c<o:p></o:p></p=
>
<p class=3D"MsoNormal">@@ -315,6 &#43;315,12 @@<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#define GEM_MODID_VALUE 0x00020118<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&#43;/* IEEE has specified that the most significant=
 bit of the most significant byte be used for<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * distinguishing between Unicast and Multicast=
 addresses.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; * If its a 1, that means multicast, 0 means un=
icast.&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#define IS_MULTICAST(address)&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((address[0] &amp; 0x01) =3D=3D=
 0x01) ? 1 : 0)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#define IS_UNICAST(address)&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!IS_MULTICAST(address=
))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">static inline uint64_t tx_desc_get_buffer(CadenceGEM=
State *s, uint32_t *desc)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; uint64_t ret =3D desc[0];<o=
:p></o:p></p>
<p class=3D"MsoNormal">@@ -690,21 &#43;696,21 @@ static int gem_mac_address=
_filter(CadenceGEMState *s, const uint8_t *packet)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Accept packets -w- =
hash match? */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; if ((packet[0] =3D=3D 0x01 &amp;=
&amp; (s-&gt;regs[GEM_NWCFG] &amp; GEM_NWCFG_MCAST_HASH)) ||<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (packet[=
0] !=3D 0x01 &amp;&amp; (s-&gt;regs[GEM_NWCFG] &amp; GEM_NWCFG_UCAST_HASH))=
) {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; if ((IS_MULTICAST(packet) &a=
mp;&amp; (s-&gt;regs[GEM_NWCFG] &amp; GEM_NWCFG_MCAST_HASH)) ||<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (IS_=
UNICAST(packet)&nbsp;&nbsp; &amp;&amp; (s-&gt;regs[GEM_NWCFG] &amp; GEM_NWC=
FG_UCAST_HASH))) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uns=
igned hash_index;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;hash_index =3D calc_mac_hash(packet);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(hash_index &lt; 32) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (s-&gt;regs[GEM_HASHLO] &amp; (1&lt;&lt;hash_index)=
) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return packet[0] =3D=3D 0x01 ? GEM_=
RX_MULTICAST_HASH_ACCEPT :<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GEM_RX_UNICAST_HASH_ACC=
EPT;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IS_MULTICAST(packet) ? G=
EM_RX_MULTICAST_HASH_ACCEPT :<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G=
EM_RX_UNICAST_HASH_ACCEPT;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; hash_index -=3D 32;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (s-&gt;regs[GEM_HASHHI] &amp; (1&lt;&lt;hash_index)=
) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return packet[0] =3D=3D 0x01 ? GEM_=
RX_MULTICAST_HASH_ACCEPT :<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GEM_RX_UNICAST_HASH_ACC=
EPT;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IS_MULTICAST(packet) ? G=
EM_RX_MULTICAST_HASH_ACCEPT :<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G=
EM_RX_UNICAST_HASH_ACCEPT;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.9.3<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_2632212d4c8a40bead72ffdcf288e600SVRIESMBX03mgcmentorgco_--

