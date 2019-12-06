Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D706C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C8820706
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C8820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idH61-0006pP-0A
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1idFEl-0001qv-70
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1idFEj-0001PA-5l
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:42 -0500
Received: from mail.ispras.ru ([83.149.199.45]:53758)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1idFEi-0001KP-Ny
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:09:41 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 5E71B540081;
 Fri,  6 Dec 2019 14:32:17 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Aleksandar Markovic'" <aleksandar.m.mail@gmail.com>
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-6-mrolnik@gmail.com>
 <000c01d542cf$d8476a00$88d63e00$@ru>
 <CAL1e-=h70Hrs7fFEBMgzhrq3HKhxuy9qGQg5148jJ1ACALSThg@mail.gmail.com>
In-Reply-To: <CAL1e-=h70Hrs7fFEBMgzhrq3HKhxuy9qGQg5148jJ1ACALSThg@mail.gmail.com>
Subject: RE: [Qemu-devel] [PATCH v27 5/8] target/avr: Add limited support for
 USART and 16 bit timer peripherals
Date: Fri, 6 Dec 2019 14:32:12 +0300
Message-ID: <004401d5ac28$d37bc170$7a734450$@ru>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0045_01D5AC41.F8C8F970"
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: ru
Thread-Index: AdWrVpJ1KnWzxR93TgKTqY4duGAvxAA0QWbQ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: richard.henderson@linaro.org, 'Sarah Harris' <S.E.Harris@kent.ac.uk>,
 'Michael Rolnik' <mrolnik@gmail.com>, qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0045_01D5AC41.F8C8F970
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=20

From: Aleksandar Markovic [mailto:aleksandar.m.mail@gmail.com]=20
Sent: Thursday, December 05, 2019 1:27 PM
To: Pavel Dovgalyuk
Cc: Michael Rolnik; qemu-devel@nongnu.org; richard.henderson@linaro.org; =
Sarah Harris; philmd@redhat.com
Subject: Re: [Qemu-devel] [PATCH v27 5/8] target/avr: Add limited =
support for USART and 16 bit timer peripherals

=20



On Thursday, July 25, 2019, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:

> From: Qemu-devel [mailto:qemu-devel-bounces+patchwork-qemu-
> devel=3Dpatchwork.kernel.org@nongnu.org] On Behalf Of Michael Rolnik
> From: Sarah Harris <S.E.Harris@kent.ac.uk>
>=20
> These were designed to facilitate testing but should provide enough =
function to be useful in
> other contexts.

USART is very useful for testing, but to which model of AVR is belongs?
We also started implementation of USART and other devices in our =
internship program,
using prior version of your patches.
There were other register addresses for the registers and some of them =
even intersect
making read/write logic more complex (we looked at Atmega8).

You also mix the board and the SoC into one file, making =
hardware-on-chip harder to reuse.

I think that the structure can be revised in the following way:
Board -> SoC -> Devices

=20

Pavel,

=20

By "structure", did you mean structure of patches?

=20

I mean structure of files/qobjects.

=20

Let's say, after the all ISA instruction patches are introduced, we =
first introduce one real board of our choice (only infrastructure, with =
almost empty content, than devices on that board, than the corresponding =
SoC/MCU infrastucture, than device in that SoC.

=20

Additional boards would follow the same pattern, potentially reusing =
already implemented devices, or whole SoC/MCU.

=20

That=E2=80=99s why we tried to join peripherals and CPU into SoC/MCU =
=E2=80=93 for reusing the hardware configuration.

=20

One more question:

=20

We already saw that devices within SoC/MCUs for AVR platform exibit =
great variation. First, there are around 17 generation of AVR cores =
(avr1, avr2, ... xmega7). Than, there is, I think 600+ SoC/MCU models =
(hard to believe, but true). Each SoC defines its devices, and in =
potentially different way (not only its starting address, but real =
differences in terms of functionality). I thought that at least for a =
particular core, the devices would be defined in a consistent way, but =
even that is not true - for example ADC for a SoC having core X can be =
significantly different that ADC for another SoC having the same core X.

=20

How to deal with such avalanche of devices? How to organize and maintain =
27 significantly different versions of ADC; and 53 significantly =
different versions of Watchdogs (the numbers are invented by me, but are =
likely to describe the situation well)?

=20

I hope, that the differences will be rather small and allow making =
simple flag switches like in mips/translate.c, when decoding depends on =
CPU features.

In the opposite case we can create several instances of the device =
implementations.

=20

=20

Best regards,

=20

Aleksandar

=20

=20

=20

=20

Board includes SoC, loads the firmware, and adds some external =
peripheral devices, if needed.

SoC includes embedded peripherals. It dispatches IO memory accesses and =
passes them
to the devices. In this case you can have different register addresses =
for different SoCs, but
the embedded device emulation code can be mostly the same for simple =
devices like USART.

> Only a subset of the functions of each peripheral is implemented, =
mainly due to the lack of a
> standard way to handle electrical connections (like GPIO pins).

We did not got too much results, you can check for our changes here: =
https://github.com/Dovgalyuk/qemu/tree/avr8

But we can help you in development of better version of the patches and =
split the work
for making this platform more usable.


Pavel Dovgalyuk



=20

Pavel Dovgalyuk

=20


------=_NextPart_000_0045_01D5AC41.F8C8F970
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta =
name=3DGenerator content=3D"Microsoft Word 12 (filtered =
medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:2.0cm 42.5pt 2.0cm 3.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DRU link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><div =
style=3D'border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt'><div><div style=3D'border:none;border-top:solid #B5C4DF =
1.0pt;padding:3.0pt 0cm 0cm 0cm'><p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> =
Aleksandar Markovic [mailto:aleksandar.m.mail@gmail.com] =
<br><b>Sent:</b> Thursday, December 05, 2019 1:27 PM<br><b>To:</b> Pavel =
Dovgalyuk<br><b>Cc:</b> Michael Rolnik; qemu-devel@nongnu.org; =
richard.henderson@linaro.org; Sarah Harris; =
philmd@redhat.com<br><b>Subject:</b> Re: [Qemu-devel] [PATCH v27 5/8] =
target/avr: Add limited support for USART and 16 bit timer =
peripherals<o:p></o:p></span></p></div></div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><br><br>On =
Thursday, July 25, 2019, Pavel Dovgalyuk &lt;<a =
href=3D"mailto:dovgaluk@ispras.ru">dovgaluk@ispras.ru</a>&gt; =
wrote:<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt'>&gt; From: Qemu-devel [mailto:<a =
href=3D"mailto:qemu-devel-bounces+patchwork-qemu-">qemu-devel-bounces+pat=
chwork-qemu-</a><br>&gt; devel=3D<a =
href=3D"mailto:patchwork.kernel.org@nongnu.org">patchwork.kernel.org@nong=
nu.org</a>] On Behalf Of Michael Rolnik<br>&gt; From: Sarah Harris =
&lt;<a =
href=3D"mailto:S.E.Harris@kent.ac.uk">S.E.Harris@kent.ac.uk</a>&gt;<br>&g=
t; <br>&gt; These were designed to facilitate testing but should provide =
enough function to be useful in<br>&gt; other contexts.<br><br>USART is =
very useful for testing, but to which model of AVR is belongs?<br>We =
also started implementation of USART and other devices in our internship =
program,<br>using prior version of your patches.<br>There were other =
register addresses for the registers and some of them even =
intersect<br>making read/write logic more complex (we looked at =
Atmega8).<br><br>You also mix the board and the SoC into one file, =
making hardware-on-chip harder to reuse.<br><br>I think that the =
structure can be revised in the following way:<br>Board -&gt; SoC -&gt; =
Devices<o:p></o:p></p><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>Pavel,<o:p></o:p></p></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>By &quot;structure&quot;, did you mean structure of =
patches?<span lang=3DEN-US><o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>I mean structure of files/qobjects.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><div><p =
class=3DMsoNormal>Let's say, after the all ISA instruction patches are =
introduced, we first introduce one real board of our choice (only =
infrastructure, with almost empty content, than devices on that board, =
than the corresponding SoC/MCU infrastucture, than device in that =
SoC.<o:p></o:p></p></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>Additional boards would follow the same pattern, =
potentially reusing already implemented devices, or whole =
SoC/MCU.<o:p></o:p></p></div><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>That=E2=80=99s why we tried to join peripherals and CPU into SoC/MCU =
=E2=80=93 for reusing the hardware =
configuration.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><div><p class=3DMsoNormal>One more =
question:<o:p></o:p></p></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>We already saw that devices within SoC/MCUs for AVR =
platform exibit great variation. First, there are around 17 generation =
of AVR cores (avr1, avr2, ... xmega7). Than, there is, I think 600+ =
SoC/MCU models (hard to believe, but true). Each SoC defines its =
devices, and in potentially different way (not only its starting =
address, but real differences in terms of functionality). I thought that =
at least for a particular core, the devices would be defined in a =
consistent way, but even that is not true - for example ADC for a SoC =
having core X can be significantly different that ADC for another SoC =
having the same core X.<o:p></o:p></p></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>How to deal with such avalanche of devices? How to =
organize and maintain 27 significantly different versions of ADC; and 53 =
significantly different versions of Watchdogs (the numbers are invented =
by me, but are likely to describe the situation well)?<span =
lang=3DEN-US><o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>I hope, that the differences will be rather small and allow making =
simple flag switches like in mips/translate.c, when decoding depends on =
CPU features.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>In the opposite case we can create several instances of the device =
implementations.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><div><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div><div><p =
class=3DMsoNormal>Best regards,<o:p></o:p></p></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>Aleksandar<o:p></o:p></p></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div><div><p =
class=3DMsoNormal>&nbsp;<o:p></o:p></p></div><blockquote =
style=3D'border:none;border-left:solid #CCCCCC 1.0pt;padding:0cm 0cm 0cm =
6.0pt;margin-left:4.8pt;margin-right:0cm'><p class=3DMsoNormal =
style=3D'margin-bottom:12.0pt'><span lang=3DEN-US>Board includes SoC, =
loads the firmware, and adds some external peripheral devices, if =
needed.<br><br></span>SoC includes embedded peripherals. It dispatches =
IO memory accesses and passes them<br>to the devices. In this case you =
can have different register addresses for different SoCs, but<br>the =
embedded device emulation code can be mostly the same for simple devices =
like USART.<br><br>&gt; Only a subset of the functions of each =
peripheral is implemented, mainly due to the lack of a<br>&gt; standard =
way to handle electrical connections (like GPIO pins).<br><br>We did not =
got too much results, you can check for our changes here: <a =
href=3D"https://github.com/Dovgalyuk/qemu/tree/avr8" =
target=3D"_blank">https://github.com/Dovgalyuk/qemu/tree/avr8</a><br><br>=
But we can help you in development of better version of the patches and =
split the work<br>for making this platform more usable.<br><br><br>Pavel =
Dovgalyuk<br><br><span lang=3DEN-US><o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'>Pavel Dovgalyuk<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US =
style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:#1F497=
D'><o:p>&nbsp;</o:p></span></p></blockquote></div></div></div></div></bod=
y></html>
------=_NextPart_000_0045_01D5AC41.F8C8F970--


