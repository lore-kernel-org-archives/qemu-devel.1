Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD115C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892FC20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=otaya.cc header.i=@otaya.cc header.b="dMJSYpHE";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Zcdw+/j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892FC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=otaya.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDbq-0002WI-Mw
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51128)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>)
 id 1ihDZY-0008V0-87
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>)
 id 1ihDZW-0006Gl-VH
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:11:36 -0500
Received: from a2-58.smtp-out.eu-west-1.amazonses.com ([54.240.2.58]:49632)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>)
 id 1ihDZW-0006GQ-Ln
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=auqtvni3oo3zufd433jxeubuthqipmnf; d=otaya.cc; t=1576591892;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id;
 bh=2mY4D/MTNp5kt4HChaYOr2zyp2xgGqoZthCDP3+ehw8=;
 b=dMJSYpHEy8B5ocgxeDfLw/P3XYGaG58NFBVw6h3DgubESAHE3pqBy1HtEn1uz2nF
 uSNHloOjYglWmucE7eLZAL7hPd3Xtj2l8LJH/+lTmIuJjLYhtIpk0CoToWQm5OWBDNH
 CcjcJuTauAlvFR6/sIhIGiloizqVt2tx6LvlOqHw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1576591892;
 h=Subject:From:To:Date:Mime-Version:Content-Type:References:Message-Id:Feedback-ID;
 bh=2mY4D/MTNp5kt4HChaYOr2zyp2xgGqoZthCDP3+ehw8=;
 b=Zcdw+/j5FFkmzDxqx9AjMvZOQR9acsn5h1IyB/b8M7+On1s5KXy0wRLw8U2pWETL
 Zxpi443PLIt0xfkPWDFIZiHl63nLYg2JjweefFZcPuRsWGnleXPl4PTd9iCxo65Eynb
 ub4NLoDQ8vx3N5zgOOOtUKjCHz93U2aSDwAVZGMk=
Subject: Vote against removing the bluetooth subsystem from Quemu.
From: =?UTF-8?Q?Andreas_Scheucher?= <andreas.scheucher@otaya.cc>
To: =?UTF-8?Q?qemu-devel=40nongnu=2Eorg?= <qemu-devel@nongnu.org>
Date: Tue, 17 Dec 2019 14:11:32 +0000
Mime-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="=_j8e-BRAMz7OplUrUQiBxIlL8RlE7jhYOBkyNz0aIlDlUQXaQ"
References: <mail.3cd9c49a-989a-40c1-b627-b2197ff912ce@storage.wm.amazon.com> 
 <mail.3cd9c49a-989a-40c1-b627-b2197ff912ce@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdW044AMfmNtcu/UQ42OOcO+6ZZpmg==
Thread-Topic: Vote against removing the bluetooth subsystem from Quemu.
Message-ID: <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2019.12.17-54.240.2.58
Feedback-ID: 1.eu-west-1.b24dn6frgCi6dh20skzbuMRr7UL8M6Soir/3ogtEjHQ=:AmazonSES
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 54.240.2.58
X-Mailman-Approved-At: Tue, 17 Dec 2019 09:12:39 -0500
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

This is a multi-part message in MIME format. Your mail reader does not
understand MIME message format.
--=_j8e-BRAMz7OplUrUQiBxIlL8RlE7jhYOBkyNz0aIlDlUQXaQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

=C2=A0
I found following note in the Qemu documentation: This option and the who=
le bluetooth subsystem is considered as deprecated. If you still use it, =
please send a mail to=C2=A0qemu-devel@nongnu.org <mailto:qemu-devel@nongn=
u.org> =C2=A0where you describe your usecase.

=C2=A0
Here I am :)

=C2=A0
As GPU passthrough is becoming more and more common (to run Linux / Windo=
ws / Mac OS X simultaneously on the same host to prevent multiboot) on de=
sktop systems, support for the use of the host Bluetooth device in Quemu =
VMs for sure will be a common use case: https://www.reddit.com/r/VFIO/

=C2=A0
For me personally I just want to set up a setup supporting Windows & Linu=
x to use the first strong nVidia GPU for occasional gaming on Windows and=
 video editing with DaVinci Resolve under CentOs.

On the second AMD GPU I plan to install a Mac OS X VM, which for sure nee=
ds some Bluetooth support for a Magic Mouse 2 and maybe a Bluetooth Keybo=
ard.

=C2=A0
For sure Mac OS X in a VM is not the most common use case, but should wor=
k fine following some reports. And considering the prices for Apple hardw=
are, a GPU solution with moderate expensive hardware seems to be a reason=
able solution for many use cases.

=C2=A0
Thanks for considering my use case and vote.

=C2=A0
Best regards,

Andreas=20

=C2=A0
=C2=A0
=C2=A0

--=_j8e-BRAMz7OplUrUQiBxIlL8RlE7jhYOBkyNz0aIlDlUQXaQ
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mi=
crosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:wo=
rd" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D=
"http://www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type c=
ontent=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D=
"Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:#0563C1;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:#954F72;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri",sans-serif;
=09color:windowtext;}
=2EMsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri",sans-serif;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:70.85pt 70.85pt 56.7pt 70.85pt;}
div.WordSection1
=09{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3D"#0563=
C1" vlink=3D"#954F72"><div class=3DWordSection1><p class=3DMsoNormal><spa=
n lang=3DDE>Hello,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3D=
DE><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal>I found following not=
e in the Qemu documentation: <i>This option and the whole bluetooth subsy=
stem is considered as deprecated. If you still use it, please send a mail=
 to&nbsp;<a href=3D"mailto:qemu-devel@nongnu.org"><span style=3D'color:wi=
ndowtext;text-decoration:none'>qemu-devel@nongnu.org</span></a>&nbsp;wher=
e you describe your usecase.<o:p></o:p></i></p><p class=3DMsoNormal><o:p>=
&nbsp;</o:p></p><p class=3DMsoNormal>Here I am :)<o:p></o:p></p><p class=3D=
MsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>As GPU passthrough is=
 becoming more and more common (to run Linux / Windows / Mac OS X simulta=
neously on the same host to prevent multiboot) on desktop systems, suppor=
t for the use of the host Bluetooth device in Quemu VMs for sure will be =
a common use case: <a href=3D"https://www.reddit.com/r/VFIO/">https://www=
=2Ereddit.com/r/VFIO/</a><o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;<=
/o:p></p><p class=3DMsoNormal>For me personally I just want to set up a s=
etup supporting Windows &amp; Linux to use the first strong nVidia GPU fo=
r occasional gaming on Windows and video editing with DaVinci Resolve und=
er CentOs.<o:p></o:p></p><p class=3DMsoNormal>On the second AMD GPU I pla=
n to install a Mac OS X VM, which for sure needs some Bluetooth support f=
or a Magic Mouse 2 and maybe a Bluetooth Keyboard.<o:p></o:p></p><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>For sure Mac OS X =
in a VM is not the most common use case, but should work fine following s=
ome reports. And considering the prices for Apple hardware, a GPU solutio=
n with moderate expensive hardware seems to be a reasonable solution for =
many use cases.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><=
p class=3DMsoNormal>Thanks for considering my use case and vote.<o:p></o:=
p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Best=
 regards,<o:p></o:p></p><p class=3DMsoNormal>Andreas <o:p></o:p></p><p cl=
ass=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:=
p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
--=_j8e-BRAMz7OplUrUQiBxIlL8RlE7jhYOBkyNz0aIlDlUQXaQ--

