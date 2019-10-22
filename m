Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11B9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53E521925
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53E521925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=parsons.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwqw-00048V-NX
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=5198e8e603=alexander.bensch@parsons.com>)
 id 1iMwpx-0003Yi-Hs
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=5198e8e603=alexander.bensch@parsons.com>)
 id 1iMwpt-0005C2-22
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:16:45 -0400
Received: from txdal11mx05.parsons.com ([206.219.199.115]:47982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=5198e8e603=alexander.bensch@parsons.com>)
 id 1iMwpr-0005B8-7T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:16:41 -0400
Received: from pps.filterd (txdal11mx05.parsons.com [127.0.0.1])
 by txdal11mx05.parsons.com (8.16.0.27/8.16.0.27) with SMTP id x9MGA43u009566
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 11:16:37 -0500
Received: from txdal11exch01.parsons.com (txdal11exch01.parsons.com
 [172.21.212.127])
 by txdal11mx05.parsons.com with ESMTP id 2vt44ega1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 11:16:37 -0500
Received: from ALHUN12EXCH01.Parsons.com (10.62.8.71) by
 TXDAL11EXCH01.Parsons.com (172.21.212.127) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3; Tue, 22 Oct 2019 11:16:35 -0500
Received: from ALHUN12EXCH02.Parsons.com (10.62.8.72) by
 ALHUN12EXCH01.Parsons.com (10.62.8.71) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 22 Oct 2019 11:16:31 -0500
Received: from ALHUN12EXCH02.Parsons.com ([10.62.8.72]) by
 ALHUN12EXCH02.Parsons.com ([10.62.8.72]) with mapi id 15.00.1473.003; Tue, 22
 Oct 2019 11:16:31 -0500
From: "Bensch, Alexander" <Alexander.Bensch@parsons.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: MIPS32 - 16550 UART implementation on custom board
Thread-Topic: MIPS32 - 16550 UART implementation on custom board
Thread-Index: AdWI79ChFlP8gTYRSpm5S0W5XJjcZw==
Date: Tue, 22 Oct 2019 16:16:31 +0000
Message-ID: <5921a5c8358e4aa48d199e2fdf7114af@ALHUN12EXCH02.Parsons.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_79ae2783-b6e8-45ab-9e71-54c07b2dade0_Enabled=True;
 MSIP_Label_79ae2783-b6e8-45ab-9e71-54c07b2dade0_SiteId=8d088ff8-7e52-4d0f-8187-dcd9ca37815a;
 MSIP_Label_79ae2783-b6e8-45ab-9e71-54c07b2dade0_Owner=Alexander.Bensch@parsons.com;
 MSIP_Label_79ae2783-b6e8-45ab-9e71-54c07b2dade0_SetDate=2019-10-22T16:16:29.7248865Z;
 MSIP_Label_79ae2783-b6e8-45ab-9e71-54c07b2dade0_Name=Public;
 MSIP_Label_79ae2783-b6e8-45ab-9e71-54c07b2dade0_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_79ae2783-b6e8-45ab-9e71-54c07b2dade0_ActionId=d068c304-9975-4e9b-92a4-3084be31bdcf;
 MSIP_Label_79ae2783-b6e8-45ab-9e71-54c07b2dade0_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.212.10]
Content-Type: multipart/alternative;
 boundary="_000_5921a5c8358e4aa48d199e2fdf7114afALHUN12EXCH02Parsonscom_"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-22_03:, , signatures=0
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

--_000_5921a5c8358e4aa48d199e2fdf7114afALHUN12EXCH02Parsonscom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm trying to use QEMU to emulate a piece of firmware, but I'm having troub=
le getting the UART device to properly update the Line Status Register and =
display the input character.

Details:
Target device: Qualcomm QCA9533 (Documentation here if you're curious<https=
://github.com/Deoptim/atheros/blob/master/QCA9531_V2.0_nowatermark.pdf>)
Target firmware: VxWorks 6.6 with U-Boot bootload
CPU: MIPS 24Kc
Board: mipssim (modified)
Memory: 512MB
Command used: qemu-system-mips -S -s -cpu 24Kc -M mipssim -nographic -bios =
target_image.bin

I have to apologize here, but I am unable to share my source. However, as I=
 am attempting to retool the mipssim board, I have only made minor changes =
to the code, which are as follows:

  *   Rebased bios memory region to 0x1F000000
  *   Changed load_image_targphys() target address to 0x1F000000
  *   Changed $pc initial value to 0xBF000000 (TLB remap of 0x1F000000)
  *   Replaced the mipssim serial_init() call with serial_mm_init(isa, 0x20=
000, env->irq[0], 115200, serial_hd(0), DEVICE_NATIVE_ENDIAN).

While it seems like serial_init() is probably the currently accepted standa=
rd, I wasn't having any luck with remapping it. I noticed the malta board h=
ad no issues outputting on a MIPS test kernel I gave it, so I tried to mimi=
c what was done there. However, I still cannot understand how QEMU works an=
d I am unable to find many good resources that explain it. My slog through =
the source and included docs is ongoing, but in the meantime I was hoping s=
omeone might have some insight into what I'm doing wrong.

The binary loads and executes correctly from address 0xBF000000, but hangs =
when it hits the first UART polling loop. A look at mtree in the QEMU monit=
or shows that the I/O device is mapped correctly to address range 0x1802000=
0-0x1802003f, and when the firmware writes to the Tx buffer, gdb shows the =
character successfully is written to memory. There's just no further action=
 from the serial device to pull that character and display it, so the firmw=
are endlessly polls on the LSR waiting for an update.

Is there something I'm missing when it comes to serial/hardware interaction=
 in QEMU? I would have assumed that remapping all of the existing functiona=
l components of the mipssim board would be enough to at least get serial co=
mmunication working, especially since the target uses the same 16550 UART t=
hat mipssim does. Please let me know if you have any insights. It would be =
helpful if I could find a way to debug QEMU itself with symbols, but at the=
 same time I'm not totally sure what I'd be looking for. Even advice on how=
 to scope down the issue would be useful.

Thank you!

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

--_000_5921a5c8358e4aa48d199e2fdf7114afALHUN12EXCH02Parsonscom_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
/* List Definitions */
@list l0
	{mso-list-id:1923219766;
	mso-list-type:hybrid;
	mso-list-template-ids:1309976598 -858104088 67698691 67698693 67698689 676=
98691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<br>
<br>
I&#8217;m trying to use QEMU to emulate a piece of firmware, but I&#8217;m =
having trouble getting the UART device to properly update the Line Status R=
egister and display the input character.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Details:<o:p></o:p></p>
<p class=3D"MsoNormal">Target device: Qualcomm QCA9533 (<a href=3D"https://=
github.com/Deoptim/atheros/blob/master/QCA9531_V2.0_nowatermark.pdf">Docume=
ntation here if you're curious</a>)<o:p></o:p></p>
<p class=3D"MsoNormal">Target firmware: VxWorks 6.6 with U-Boot bootload<o:=
p></o:p></p>
<p class=3D"MsoNormal">CPU: MIPS 24Kc<o:p></o:p></p>
<p class=3D"MsoNormal">Board: mipssim (modified)<o:p></o:p></p>
<p class=3D"MsoNormal">Memory: 512MB<o:p></o:p></p>
<p class=3D"MsoNormal">Command used: <i>qemu-system-mips -S -s -cpu 24Kc -M=
 mipssim &#8211;nographic -bios target_image.bin</i><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have to apologize here, but I am unable to share m=
y source. However, as I am attempting to retool the mipssim board, I have o=
nly made minor changes to the code, which are as follows:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Rebased
<i>bios </i>memory region to 0x1F000000<o:p></o:p></li><li class=3D"MsoList=
Paragraph" style=3D"margin-left:0in;mso-list:l0 level1 lfo1">Changed
<i>load_image_targphys() </i>target address to 0x1F000000<o:p></o:p></li><l=
i class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 lf=
o1">Changed $pc initial value to 0xBF000000 (TLB remap of 0x1F000000)<o:p><=
/o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:=
l0 level1 lfo1">Replaced the mipssim
<i>serial_init() &shy;</i>call with <i>serial_mm_init(isa, 0x20000, env-&gt=
;irq[0], 115200, serial_hd(0), DEVICE_NATIVE_ENDIAN).
</i><o:p></o:p></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">While it seems like <i>serial_init() </i>is probably=
 the currently accepted standard, I wasn&#8217;t having any luck with remap=
ping it. I noticed the malta board had no issues outputting on a MIPS test =
kernel I gave it, so I tried to mimic what
 was done there. However, I still cannot understand how QEMU works and I am=
 unable to find many good resources that explain it. My slog through the so=
urce and included docs is ongoing, but in the meantime I was hoping someone=
 might have some insight into what
 I&#8217;m doing wrong. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The binary loads and executes correctly from address=
 0xBF000000, but hangs when it hits the first UART polling loop. A look at
<i>mtree</i> in the QEMU monitor shows that the I/O device is mapped correc=
tly to address range 0x18020000-0x1802003f, and when the firmware writes to=
 the Tx buffer,
<i>gdb </i>shows the character successfully is written to memory. There&#82=
17;s just no further action from the serial device to pull that character a=
nd display it, so the firmware endlessly polls on the LSR waiting for an up=
date.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is there something I&#8217;m missing when it comes t=
o serial/hardware interaction in QEMU? I would have assumed that remapping =
all of the existing functional components of the mipssim board would be eno=
ugh to at least get serial communication
 working, especially since the target uses the same 16550 UART that mipssim=
 does. Please let me know if you have any insights. It would be helpful if =
I could find a way to debug QEMU itself with symbols, but at the same time =
I&#8217;m not totally sure what I&#8217;d be
 looking for. Even advice on how to scope down the issue would be useful.<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you!<o:p></o:p></p>
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

--_000_5921a5c8358e4aa48d199e2fdf7114afALHUN12EXCH02Parsonscom_--

