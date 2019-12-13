Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB63AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1755C2465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1755C2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=parsons.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifqBB-0001HP-Kq
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 14:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=7250cc771b=alexander.bensch@parsons.com>)
 id 1ifq9s-0000gT-6z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=7250cc771b=alexander.bensch@parsons.com>)
 id 1ifq9o-0005gg-5g
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:59:23 -0500
Received: from txdal11mx05.parsons.com ([206.219.199.115]:33076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=7250cc771b=alexander.bensch@parsons.com>)
 id 1ifq9n-0005bF-NT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 13:59:20 -0500
Received: from pps.filterd (txdal11mx05.parsons.com [127.0.0.1])
 by txdal11mx05.parsons.com (8.16.0.27/8.16.0.27) with SMTP id xBDIuV2S021765
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 12:59:17 -0600
Received: from txdal11exch03.parsons.com (txdal11exch03.parsons.com
 [172.21.212.129])
 by txdal11mx05.parsons.com with ESMTP id 2wvg5yg1e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 12:59:17 -0600
Received: from ALHUN12EXCH02.Parsons.com (10.62.8.72) by
 TXDAL11EXCH03.Parsons.com (172.21.212.129) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Dec 2019 12:59:16 -0600
Received: from ALHUN12EXCH02.Parsons.com (10.62.8.72) by
 ALHUN12EXCH02.Parsons.com (10.62.8.72) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 13 Dec 2019 12:59:12 -0600
Received: from ALHUN12EXCH02.Parsons.com ([10.62.8.72]) by
 ALHUN12EXCH02.Parsons.com ([10.62.8.72]) with mapi id 15.00.1473.003; Fri, 13
 Dec 2019 12:59:12 -0600
From: "Bensch, Alexander" <Alexander.Bensch@parsons.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: MIPS cache bypass on custom board
Thread-Topic: MIPS cache bypass on custom board
Thread-Index: AdWx5JUoF1XYbuwoTJelobiKKS2/pQ==
Date: Fri, 13 Dec 2019 18:59:12 +0000
Message-ID: <e3c2df7ae90747729a47d5f854e450e5@ALHUN12EXCH02.Parsons.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_5c1e7834-6be8-4780-ac5e-8408bbf8216f_Enabled=True;
 MSIP_Label_5c1e7834-6be8-4780-ac5e-8408bbf8216f_SiteId=8d088ff8-7e52-4d0f-8187-dcd9ca37815a;
 MSIP_Label_5c1e7834-6be8-4780-ac5e-8408bbf8216f_Owner=Alexander.Bensch@parsons.com;
 MSIP_Label_5c1e7834-6be8-4780-ac5e-8408bbf8216f_SetDate=2019-12-13T18:59:08.4722200Z;
 MSIP_Label_5c1e7834-6be8-4780-ac5e-8408bbf8216f_Name=Sensitive;
 MSIP_Label_5c1e7834-6be8-4780-ac5e-8408bbf8216f_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_5c1e7834-6be8-4780-ac5e-8408bbf8216f_ActionId=3fd9e0ec-c65c-4c8f-847d-e9166d1d9365;
 MSIP_Label_5c1e7834-6be8-4780-ac5e-8408bbf8216f_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.212.10]
Content-Type: multipart/related;
 boundary="_004_e3c2df7ae90747729a47d5f854e450e5ALHUN12EXCH02Parsonscom_";
 type="multipart/alternative"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-13_07:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 206.219.199.115
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_004_e3c2df7ae90747729a47d5f854e450e5ALHUN12EXCH02Parsonscom_
Content-Type: multipart/alternative;
	boundary="_000_e3c2df7ae90747729a47d5f854e450e5ALHUN12EXCH02Parsonscom_"

--_000_e3c2df7ae90747729a47d5f854e450e5ALHUN12EXCH02Parsonscom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sensitive

Hi all,

Currently stuck on a problem in QEMU 4.0.0. I'm trying to implement a custo=
m device using a MIPS 24Kc CPU. The device boots from an SPI flash device t=
hat is mapped to 0x9F000000 (physical address 0x1F000000). I got the initia=
l load and execute working by direct loading a flash dump to a MemoryRegion=
 based at 0x1F000000, which worked great until the ROM needed to access the=
 SPI registers that are addressed to 0xBF000000 (also physical address 0x1F=
000000). QEMU cannot differentiate reads and writes to 0xBF000000 from read=
s and writes to 0x9F000000.

Initially I assumed this was a caching problem, as I know that the SPI regi=
sters are located in the KSEG1 memory segment which uses uncached writes, w=
hile the flash mapping is in KSEG0 with cached writes. I also can see that =
QEMU has logic to handle caching in a few source files within targets/mips/=
. However, when I read from addresses in the KSEG1 region, I still see cont=
ents from the KSEG0 region.

My question is whether there is any way to configure a MIPS board such that=
 I can correctly bypass the cache for KSEG1 as expressed by the MIPS docume=
ntation?

Apologies if details are lacking. Please request more info if needed.

Thank you,
Alex Bensch
Performance Testing Engineer
5875 Trinity Parkway, Suite 300
Centreville, Virginia 20120
alexander.bensch@parsons.com<mailto:alexander.bensch@parsons.com>

PARSONS - Envision More
parsons.com<http://www.parsons.com/> | LinkedIn<https://urldefense.proofpoi=
nt.com/v2/url?u=3Dhttps-3A__www.linkedin.com_company_parsons&d=3DBQMFaQ&c=
=3DNwf-pp4xtYRe0sCRVM8_LWH54joYF7EKmrYIdfxIq10&r=3DiZNlh6dnFYPILyq_2-DmjpFM=
BmIHuB7rIGd_TCe7N6M&m=3D98igw8OxyFTtGS3BUxvV0OBEGOU_4VdnJFCmNS3GWsE&s=3DXhj=
Sw-ZCxfOKj0wsh9wUKhkzNvFiYZoTizi-a3CdqXU&e=3D> | Twitter<https://urldefense=
.proofpoint.com/v2/url?u=3Dhttps-3A__twitter.com_ParsonsCorp&d=3DBQMFaQ&c=
=3DNwf-pp4xtYRe0sCRVM8_LWH54joYF7EKmrYIdfxIq10&r=3DiZNlh6dnFYPILyq_2-DmjpFM=
BmIHuB7rIGd_TCe7N6M&m=3D98igw8OxyFTtGS3BUxvV0OBEGOU_4VdnJFCmNS3GWsE&s=3DZA0=
eWpLHALG5opp15aIwjhIriBrfKZFLrGZqU0si4k0&e=3D> | Facebook<https://urldefens=
e.proofpoint.com/v2/url?u=3Dhttps-3A__www.facebook.com_parsonscorporation&d=
=3DBQMFaQ&c=3DNwf-pp4xtYRe0sCRVM8_LWH54joYF7EKmrYIdfxIq10&r=3DiZNlh6dnFYPIL=
yq_2-DmjpFMBmIHuB7rIGd_TCe7N6M&m=3D98igw8OxyFTtGS3BUxvV0OBEGOU_4VdnJFCmNS3G=
WsE&s=3DUcmPD4yGVpnWpnEfR5XfqTV8qgTS6IKitqeqcVbnxHw&e=3D>
[cid:image001.png@01D5B1BB.F6FAA600]


NOTICE: This email message and all attachments transmitted with it may cont=
ain privileged and confidential information, and information that is protec=
ted by, and proprietary to, Parsons Corporation, and is intended solely for=
 the use of the addressee for the specific purpose set forth in this commun=
ication. If the reader of this message is not the intended recipient, you a=
re hereby notified that any reading, dissemination, distribution, copying, =
or other use of this message or its attachments is strictly prohibited, and=
 you should delete this message and all copies and backups thereof. The rec=
ipient may not further distribute or use any of the information contained h=
erein without the express written authorization of the sender. If you have =
received this message in error, or if you have any questions regarding the =
use of the proprietary information contained therein, please contact the se=
nder of this message immediately, and the sender will provide you with furt=
her instructions.

--_000_e3c2df7ae90747729a47d5f854e450e5ALHUN12EXCH02Parsonscom_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Helvetica Neue";}
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
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
<p class=3D"msipheader41d22070" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Franklin Gothic Book;color:#000000">Sens=
itive</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<br>
<br>
Currently stuck on a problem in QEMU 4.0.0. I&#8217;m trying to implement a=
 custom device using a MIPS 24Kc CPU. The device boots from an SPI flash de=
vice that is mapped to 0x9F000000 (physical address 0x1F000000). I got the =
initial load and execute working by direct
 loading a flash dump to a MemoryRegion based at 0x1F000000, which worked g=
reat until the ROM needed to access the SPI registers that are addressed to=
 0xBF000000 (<i>also
</i>physical address 0x1F000000). QEMU cannot differentiate reads and write=
s to 0xBF000000 from reads and writes to 0x9F000000.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Initially I assumed this was a caching problem, as I=
 know that the SPI registers are located in the KSEG1 memory segment which =
uses uncached writes, while the flash mapping is in KSEG0 with cached write=
s. I also can see that QEMU has logic
 to handle caching in a few source files within <i>targets/mips/</i>. Howev=
er, when I read from addresses in the KSEG1 region, I still see contents fr=
om the KSEG0 region.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My question is whether there is any way to configure=
 a MIPS board such that I can correctly bypass the cache for KSEG1 as expre=
ssed by the MIPS documentation?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Apologies if details are lacking. Please request mor=
e info if needed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you,<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Helvetica Neue&quot;;color:#353535">Alex Bensch=
<o:p></o:p></span></b></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.0pt;font-family:&quot;Helvetica Neue&quot;;color:#333333">Performance Te=
sting Engineer<br>
5875 Trinity Parkway, Suite 300<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
10.0pt;font-family:&quot;Helvetica Neue&quot;;color:#333333">Centreville, V=
irginia 20120<br>
</span><span style=3D"color:black"><a href=3D"mailto:alexander.bensch@parso=
ns.com"><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica Neue&qu=
ot;;color:#0563C1">alexander.bensch@parsons.com</span></a></span><span styl=
e=3D"font-size:13.0pt;font-family:&quot;Helvetica Neue&quot;;color:#333333"=
><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
13.0pt;font-family:&quot;Helvetica Neue&quot;;color:#333333">&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><b><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Helvetica Neue&quot;;color:#353535">PARSONS - E=
nvision More</span></b><span style=3D"font-size:10.0pt;font-family:&quot;He=
lvetica Neue&quot;;color:#333333"><br>
</span><span style=3D"color:black"><a href=3D"http://www.parsons.com/"><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Helvetica Neue&quot;;color:#0=
077C8">parsons.com</span></a></span><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Helvetica Neue&quot;;color:#333333">&nbsp;|&nbsp;</span><span st=
yle=3D"color:black"><a href=3D"https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__www.linkedin.com_company_parsons&amp;d=3DBQMFaQ&amp;c=3DNwf-pp=
4xtYRe0sCRVM8_LWH54joYF7EKmrYIdfxIq10&amp;r=3DiZNlh6dnFYPILyq_2-DmjpFMBmIHu=
B7rIGd_TCe7N6M&amp;m=3D98igw8OxyFTtGS3BUxvV0OBEGOU_4VdnJFCmNS3GWsE&amp;s=3D=
XhjSw-ZCxfOKj0wsh9wUKhkzNvFiYZoTizi-a3CdqXU&amp;e=3D"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Helvetica Neue&quot;;color:#0077C8">LinkedIn</=
span></a></span><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica=
 Neue&quot;;color:#333333">&nbsp;|&nbsp;</span><span style=3D"color:black">=
<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__twitter.c=
om_ParsonsCorp&amp;d=3DBQMFaQ&amp;c=3DNwf-pp4xtYRe0sCRVM8_LWH54joYF7EKmrYId=
fxIq10&amp;r=3DiZNlh6dnFYPILyq_2-DmjpFMBmIHuB7rIGd_TCe7N6M&amp;m=3D98igw8Ox=
yFTtGS3BUxvV0OBEGOU_4VdnJFCmNS3GWsE&amp;s=3DZA0eWpLHALG5opp15aIwjhIriBrfKZF=
LrGZqU0si4k0&amp;e=3D"><span style=3D"font-size:10.0pt;font-family:&quot;He=
lvetica Neue&quot;;color:#0077C8">Twitter</span></a></span><span style=3D"f=
ont-size:10.0pt;font-family:&quot;Helvetica Neue&quot;;color:#333333">&nbsp=
;|&nbsp;</span><span style=3D"color:black"><a href=3D"https://urldefense.pr=
oofpoint.com/v2/url?u=3Dhttps-3A__www.facebook.com_parsonscorporation&amp;d=
=3DBQMFaQ&amp;c=3DNwf-pp4xtYRe0sCRVM8_LWH54joYF7EKmrYIdfxIq10&amp;r=3DiZNlh=
6dnFYPILyq_2-DmjpFMBmIHuB7rIGd_TCe7N6M&amp;m=3D98igw8OxyFTtGS3BUxvV0OBEGOU_=
4VdnJFCmNS3GWsE&amp;s=3DUcmPD4yGVpnWpnEfR5XfqTV8qgTS6IKitqeqcVbnxHw&amp;e=
=3D"><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica Neue&quot;=
;color:#0077C8">Facebook</span></a></span><span style=3D"font-size:10.0pt;f=
ont-family:&quot;Helvetica Neue&quot;;color:#0077C8">&nbsp;</span><span sty=
le=3D"font-size:10.0pt;font-family:&quot;Helvetica Neue&quot;;color:#333333=
">&nbsp;&nbsp;&nbsp;</span><span style=3D"font-size:13.0pt;font-family:&quo=
t;Helvetica Neue&quot;;color:#333333">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
13.0pt;font-family:&quot;Helvetica Neue&quot;;color:#333333"><img border=3D=
"0" width=3D"142" height=3D"54" style=3D"width:1.475in;height:.5666in" id=
=3D"Picture_x0020_1" src=3D"cid:image001.png@01D5B1BB.F6FAA600">&nbsp;<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<br>
<div style=3D"font-size:10pt;  font-family: 'Franklin Gothic Book';">NOTICE=
: This email message and all attachments transmitted with it may contain pr=
ivileged and confidential information, and information that is protected by=
, and proprietary to, Parsons Corporation,
 and is intended solely for the use of the addressee for the specific purpo=
se set forth in this communication. If the reader of this message is not th=
e intended recipient, you are hereby notified that any reading, disseminati=
on, distribution, copying, or other
 use of this message or its attachments is strictly prohibited, and you sho=
uld delete this message and all copies and backups thereof. The recipient m=
ay not further distribute or use any of the information contained herein wi=
thout the express written authorization
 of the sender. If you have received this message in error, or if you have =
any questions regarding the use of the proprietary information contained th=
erein, please contact the sender of this message immediately, and the sende=
r will provide you with further
 instructions.</div>
</body>
</html>

--_000_e3c2df7ae90747729a47d5f854e450e5ALHUN12EXCH02Parsonscom_--

--_004_e3c2df7ae90747729a47d5f854e450e5ALHUN12EXCH02Parsonscom_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=25129;
	creation-date="Fri, 13 Dec 2019 18:59:11 GMT";
	modification-date="Fri, 13 Dec 2019 18:59:11 GMT"
Content-ID: <image001.png@01D5B1BB.F6FAA600>
Content-Transfer-Encoding: base64

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
P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/Pgo8eDp4
bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1
LjYtYzA2NyA3OS4xNTc3NDcsIDIwMTUvMDMvMzAtMjM6NDA6NDIgICAgICAgICI+CiAgIDxyZGY6
UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5z
IyI+CiAgICAgIDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiCiAgICAgICAgICAgIHhtbG5z
OnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZGM9
Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIgogICAgICAgICAgICB4bWxuczpwaG90
b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iCiAgICAgICAgICAgIHht
bG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgICAgICAgICB4
bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZl
bnQjIgogICAgICAgICAgICB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4w
L3NUeXBlL1Jlc291cmNlUmVmIyIKICAgICAgICAgICAgeG1sbnM6dGlmZj0iaHR0cDovL25zLmFk
b2JlLmNvbS90aWZmLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmV4aWY9Imh0dHA6Ly9ucy5hZG9i
ZS5jb20vZXhpZi8xLjAvIj4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3No
b3AgQ0MgMjAxNSAoTWFjaW50b3NoKTwveG1wOkNyZWF0b3JUb29sPgogICAgICAgICA8eG1wOkNy
ZWF0ZURhdGU+MjAxNi0wNC0xNVQxNDoyMDo1Mi0wNzowMDwveG1wOkNyZWF0ZURhdGU+CiAgICAg
ICAgIDx4bXA6TW9kaWZ5RGF0ZT4yMDE2LTA2LTE0VDE1OjI1OjE3LTA3OjAwPC94bXA6TW9kaWZ5
RGF0ZT4KICAgICAgICAgPHhtcDpNZXRhZGF0YURhdGU+MjAxNi0wNi0xNFQxNToyNToxNy0wNzow
MDwveG1wOk1ldGFkYXRhRGF0ZT4KICAgICAgICAgPGRjOmZvcm1hdD5pbWFnZS9wbmc8L2RjOmZv
cm1hdD4KICAgICAgICAgPHBob3Rvc2hvcDpDb2xvck1vZGU+MzwvcGhvdG9zaG9wOkNvbG9yTW9k
ZT4KICAgICAgICAgPHBob3Rvc2hvcDpJQ0NQcm9maWxlPnNSR0IgSUVDNjE5NjYtMi4xPC9waG90
b3Nob3A6SUNDUHJvZmlsZT4KICAgICAgICAgPHhtcE1NOkluc3RhbmNlSUQ+eG1wLmlpZDo2N2Yx
NjIzOS03MGZlLTQ5OTAtOTIxZC02NTBhOWNkYmYyMGY8L3htcE1NOkluc3RhbmNlSUQ+CiAgICAg
ICAgIDx4bXBNTTpEb2N1bWVudElEPmFkb2JlOmRvY2lkOnBob3Rvc2hvcDoyNjY1YTExZC03MzBk
LTExNzktYWNlMy1iYmU3YjA4Zjk4Mjg8L3htcE1NOkRvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBN
TTpPcmlnaW5hbERvY3VtZW50SUQ+eG1wLmRpZDoxYzljYTMwNy1jMzJiLTQzZmMtOGFlOC04ZTU2
M2FmOWRlNTA8L3htcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD4KICAgICAgICAgPHhtcE1NOkhpc3Rv
cnk+CiAgICAgICAgICAgIDxyZGY6U2VxPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJz
ZVR5cGU9IlJlc291cmNlIj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmFjdGlvbj5jcmVhdGVk
PC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5p
aWQ6MWM5Y2EzMDctYzMyYi00M2ZjLThhZTgtOGU1NjNhZjlkZTUwPC9zdEV2dDppbnN0YW5jZUlE
PgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE2LTA0LTE1VDE0OjIwOjUyLTA3OjAw
PC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9i
ZSBQaG90b3Nob3AgQ0MgMjAxNSAoTWFjaW50b3NoKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAg
ICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlw
ZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNvbnZlcnRlZDwv
c3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5mcm9tIGFw
cGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nPC9zdEV2dDpwYXJhbWV0
ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6
cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2
ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1w
LmlpZDo0M2FlMWMwZC01MGNkLTQ1YTAtOGEyNi0xMWI0NmI4MGEwYTU8L3N0RXZ0Omluc3RhbmNl
SUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTYtMDQtMTVUMTY6NDA6NDYtMDc6
MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFk
b2JlIFBob3Rvc2hvcCBDQyAyMDE1IChNYWNpbnRvc2gpPC9zdEV2dDpzb2Z0d2FyZUFnZW50Pgog
ICAgICAgICAgICAgICAgICA8c3RFdnQ6Y2hhbmdlZD4vPC9zdEV2dDpjaGFuZ2VkPgogICAgICAg
ICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJS
ZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFj
dGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpiZjU5YzAw
MS04N2MwLTRmODMtODU1Zi0xNjJjNWE1NjgzNzY8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAg
ICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTYtMDYtMTNUMTc6MTM6MTEtMDc6MDA8L3N0RXZ0Ondo
ZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hv
cCBDQyAyMDE1IChNYWNpbnRvc2gpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAg
ICAgICA8c3RFdnQ6Y2hhbmdlZD4vPC9zdEV2dDpjaGFuZ2VkPgogICAgICAgICAgICAgICA8L3Jk
ZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAg
ICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y29udmVydGVkPC9zdEV2dDphY3Rpb24+CiAg
ICAgICAgICAgICAgICAgIDxzdEV2dDpwYXJhbWV0ZXJzPmZyb20gaW1hZ2UvcG5nIHRvIGFwcGxp
Y2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3A8L3N0RXZ0OnBhcmFtZXRlcnM+CiAgICAgICAgICAg
ICAgIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291
cmNlIj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmFjdGlvbj5kZXJpdmVkPC9zdEV2dDphY3Rp
b24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpwYXJhbWV0ZXJzPmNvbnZlcnRlZCBmcm9tIGlt
YWdlL3BuZyB0byBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wPC9zdEV2dDpwYXJhbWV0
ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6
cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2
ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1w
LmlpZDpjY2JmZWI0MS0xMmFkLTRhZDctYjZkNi1iYjY0NmRiYzA2OTU8L3N0RXZ0Omluc3RhbmNl
SUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTYtMDYtMTNUMTc6MTM6MTEtMDc6
MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFk
b2JlIFBob3Rvc2hvcCBDQyAyMDE1IChNYWNpbnRvc2gpPC9zdEV2dDpzb2Z0d2FyZUFnZW50Pgog
ICAgICAgICAgICAgICAgICA8c3RFdnQ6Y2hhbmdlZD4vPC9zdEV2dDpjaGFuZ2VkPgogICAgICAg
ICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJS
ZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFj
dGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDplOTE4ZjY4
Ni1kNjk5LTRjOTItYTA3YS1jNjBhYzc4MTc0ODc8L3N0RXZ0Omluc3RhbmNlSUQ+CiAgICAgICAg
ICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTYtMDYtMTRUMTU6MjU6MTctMDc6MDA8L3N0RXZ0Ondo
ZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFkb2JlIFBob3Rvc2hv
cCBDQyAyMDE1IChNYWNpbnRvc2gpPC9zdEV2dDpzb2Z0d2FyZUFnZW50PgogICAgICAgICAgICAg
ICAgICA8c3RFdnQ6Y2hhbmdlZD4vPC9zdEV2dDpjaGFuZ2VkPgogICAgICAgICAgICAgICA8L3Jk
ZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAg
ICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+Y29udmVydGVkPC9zdEV2dDphY3Rpb24+CiAg
ICAgICAgICAgICAgICAgIDxzdEV2dDpwYXJhbWV0ZXJzPmZyb20gYXBwbGljYXRpb24vdm5kLmFk
b2JlLnBob3Rvc2hvcCB0byBpbWFnZS9wbmc8L3N0RXZ0OnBhcmFtZXRlcnM+CiAgICAgICAgICAg
ICAgIDwvcmRmOmxpPgogICAgICAgICAgICAgICA8cmRmOmxpIHJkZjpwYXJzZVR5cGU9IlJlc291
cmNlIj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmFjdGlvbj5kZXJpdmVkPC9zdEV2dDphY3Rp
b24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpwYXJhbWV0ZXJzPmNvbnZlcnRlZCBmcm9tIGFw
cGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nPC9zdEV2dDpwYXJhbWV0
ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6
cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2
ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1w
LmlpZDo2N2YxNjIzOS03MGZlLTQ5OTAtOTIxZC02NTBhOWNkYmYyMGY8L3N0RXZ0Omluc3RhbmNl
SUQ+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDp3aGVuPjIwMTYtMDYtMTRUMTU6MjU6MTctMDc6
MDA8L3N0RXZ0OndoZW4+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDpzb2Z0d2FyZUFnZW50PkFk
b2JlIFBob3Rvc2hvcCBDQyAyMDE1IChNYWNpbnRvc2gpPC9zdEV2dDpzb2Z0d2FyZUFnZW50Pgog
ICAgICAgICAgICAgICAgICA8c3RFdnQ6Y2hhbmdlZD4vPC9zdEV2dDpjaGFuZ2VkPgogICAgICAg
ICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgPC9yZGY6U2VxPgogICAgICAgICA8L3htcE1N
Okhpc3Rvcnk+CiAgICAgICAgIDx4bXBNTTpEZXJpdmVkRnJvbSByZGY6cGFyc2VUeXBlPSJSZXNv
dXJjZSI+CiAgICAgICAgICAgIDxzdFJlZjppbnN0YW5jZUlEPnhtcC5paWQ6ZTkxOGY2ODYtZDY5
OS00YzkyLWEwN2EtYzYwYWM3ODE3NDg3PC9zdFJlZjppbnN0YW5jZUlEPgogICAgICAgICAgICA8
c3RSZWY6ZG9jdW1lbnRJRD5hZG9iZTpkb2NpZDpwaG90b3Nob3A6MWNmOGU5MzktNzI1My0xMTc5
LWFkMjUtZGMxYTliZmI3ZWZhPC9zdFJlZjpkb2N1bWVudElEPgogICAgICAgICAgICA8c3RSZWY6
b3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6MWM5Y2EzMDctYzMyYi00M2ZjLThhZTgtOGU1NjNh
ZjlkZTUwPC9zdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDwveG1wTU06RGVyaXZl
ZEZyb20+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAg
ICAgICAgIDx0aWZmOlhSZXNvbHV0aW9uPjE1MDAwMDAvMTAwMDA8L3RpZmY6WFJlc29sdXRpb24+
CiAgICAgICAgIDx0aWZmOllSZXNvbHV0aW9uPjE1MDAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRp
b24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+
CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+MTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAgICA8
ZXhpZjpQaXhlbFhEaW1lbnNpb24+MTQyPC9leGlmOlBpeGVsWERpbWVuc2lvbj4KICAgICAgICAg
PGV4aWY6UGl4ZWxZRGltZW5zaW9uPjU0PC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9y
ZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
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

--_004_e3c2df7ae90747729a47d5f854e450e5ALHUN12EXCH02Parsonscom_--

