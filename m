Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E6C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 19:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAB3215EA
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 19:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o25ukCCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAB3215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTWi7-00008O-KU
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 14:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iTWh2-0007w4-12
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 14:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iTWgy-0006kY-E1
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 14:46:43 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iTWgy-0006jy-8m
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 14:46:40 -0500
Received: by mail-oi1-x243.google.com with SMTP id n14so8208676oie.13
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 11:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=I2TCZj8gVV7tzFNfbE7jiyIAODMCTIyNnma1xzfWy5w=;
 b=o25ukCCAP0MBaVHRVrzLBiO2YO74wxKSBTxZ2VUVZw0MocjZqVAI1ggikQ96AAVa3R
 1GSgWG7NIjO4a5GQYwJsAhUj6EN1xVjMPY1gVaEnvhkbRCQWIuECQ6Ovx8eq1eOZ8jwL
 wSpyOJIDqWiWln9/mA8TF9O/ohKuVkyazEJPCNMDVnIc6LrFxrecVk5Ev3XuWeZLaZrz
 7Z6z9gsCIUluNCVZwumKXzOGu9FvwPdGf5QEz4UxRl5QfO3905aaNgTxYsflX6qIWy+v
 Gl5UenujxoU5u5bnv14gFOxMPCR42F1wd7jSrfBXEyU9dQnDieH54M5AVzJjeA2ZD+co
 JS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=I2TCZj8gVV7tzFNfbE7jiyIAODMCTIyNnma1xzfWy5w=;
 b=Y2kNqoFy4WaRq+dxswfJ1N1PQFb5g9aKHCM2djOv7xVBLfwk/P22/seSflNgG+sKsL
 AP6f8xazlZ1FaqVnWuIUNIoGUsvl+zHmeuy/ppYJVfD0wOHXKUFtXedYYI62KYR+VZ3T
 ED+DFycmckxXH8TwazYj9xSGmdPDk1sJWm08svQ4UaYJhkY4+PjUo2GEaxoxV7LRVqQB
 eEwW45Mj3hn6MrmSUvh8Qpktc5EaZO5sYgUWsq1hsO3cHX1jPuToImANpiLUye9tqRDc
 7o4U+95v+JqM0+0hFqz3ty9E1YiEgcP6vdP+S+pxf+SjR+M4X4cwg2JemuSEF3Kf9sDL
 k1Ag==
X-Gm-Message-State: APjAAAUzVF5abQBWuj2OH29F44wF4/2IoVoWCF26Kf/y0CeJ2WSbn4zn
 8mMIz/jVT6ydq+EXY5ZAWZta5CgEjbkfAn+XjuA=
X-Google-Smtp-Source: APXvYqxN//yLsWN3LMrNMgjkT2Kf0S/pWxmO47qMI2cG3zAVHdAcXzG/ucC+ywwr9/13BqWp7PJ2VFPiqOGRl2lDBCo=
X-Received: by 2002:aca:d17:: with SMTP id 23mr9064162oin.136.1573328798673;
 Sat, 09 Nov 2019 11:46:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:5e89:0:0:0:0:0 with HTTP;
 Sat, 9 Nov 2019 11:46:38 -0800 (PST)
In-Reply-To: <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 9 Nov 2019 20:46:38 +0100
Message-ID: <CAL1e-=hNH6HaKsczgkUdgbt18E2V2Cm6oPhSQewvMKvVTnarbA@mail.gmail.com>
Subject: Re: Looking for issues/features for my first contribution
To: Rajath Shashidhara <rajaths@cs.utexas.edu>
Content-Type: multipart/alternative; boundary="00000000000028f1180596ef28e4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000028f1180596ef28e4
Content-Type: text/plain; charset="UTF-8"

On Friday, November 8, 2019, Rajath Shashidhara <rajaths@cs.utexas.edu>
wrote:

>
> On 07-11-2019 07:33, Aleksandar Markovic wrote:
>
>>
>> I did a quick Google search on datasheets of existing RTC
>> implemtations, and the result is:
>>
>> DS1338: https://datasheets.maximintegrated.com/en/ds/DS1338-DS1338Z.pdf
>> M41T80: https://www.st.com/resource/en/datasheet/m41t80.pdf
>> M48T59: http://www.elektronikjk.pl/elementy_czynne/IC/M48T59V.pdf
>> MC146818: https://www.nxp.com/docs/en/data-sheet/MC146818.pdf
>> PL031: http://infocenter.arm.com/help/topic/com.arm.doc.ddi0224c/
>> real_time_clock_pl031_r1p3_technical_reference_manual_DDI0224C.pdf
>> TWL92230: https://datasheet.octopart.com/TWL92230C-Texas-Instruments-
>> datasheet-150321.pdf
>> Zynq RTC: https://www.xilinx.com/support/documentation/user_guides/
>> ug1085-zynq-ultrascale-trm.pdf
>> (chapter 7)
>>
>
> I have a few questions about this:
> [a] Is there any particular reason that you picked DS3231 ? Linux kernel
> has drivers for DS3232/34 only [1].


>
Hi, Rajath.

No, it doesn't. Linux kernel has a driver for DS3231. Take a closer look.

But, in any case, you base your QEMU emulation on the *datasheet*.

The OS drivers may be helpful, but they are not a reference you base your
solution on. The drivers may be obsolete, incorrect, incomplete, or just
plain wrong. Additionally, as QEMU, of course, supports emulation of
systems running variety of OSs, the existence of the Linux kernel driver is
not a necessary condition for QEMU implementation. QEMU emulates many
systems that Linux never ran on, and could not be run at all.

Sincerely,
Aleksandar


>
>  I did read the datasheets of both 3232 & 3231 and found that they are
> quite similar except for the 236 bytes of SRAM support found only in 3232.
>
> [b] As per the datasheet, DS3231 has a built-in temperature sensor.
> Temperature can be read from a dedicated register. There can be two
> approaches to emulating this: (1) Return a constant temperature value on
> every read (2) Throw a not-supported exception/warning. What is the qemu
> convention for handling such features ?
>
> [c] DS3231 also has programmable square-wave output + 32 KHz output pin.
> M41T80 chip also supports this feature. However, qemu does not support
> emulation of these features [2]. Do I take the same approach ?
>
> Thanks!
> Rajath Shashidhara
>
> References:
> [1] https://elixir.bootlin.com/linux/v5.4-rc6/source/drivers/rtc
> /rtc-ds3232.c
> [2] https://git.qemu.org/?p=qemu.git;a=blob;f=hw/rtc/m41t80.c;h=
> 914ecac8f4db418633d6daf92608cb50f6b89052;hb=HEAD
>

--00000000000028f1180596ef28e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, November 8, 2019, Rajath Shashidhara &lt;<a href=3D"mail=
to:rajaths@cs.utexas.edu">rajaths@cs.utexas.edu</a>&gt; wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><br>
On 07-11-2019 07:33, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
I did a quick Google search on datasheets of existing RTC<br>
implemtations, and the result is:<br>
<br>
DS1338: <a href=3D"https://datasheets.maximintegrated.com/en/ds/DS1338-DS13=
38Z.pdf" target=3D"_blank">https://datasheets.maximintegr<wbr>ated.com/en/d=
s/DS1338-DS1338Z.<wbr>pdf</a><br>
M41T80: <a href=3D"https://www.st.com/resource/en/datasheet/m41t80.pdf" tar=
get=3D"_blank">https://www.st.com/resource/en<wbr>/datasheet/m41t80.pdf</a>=
<br>
M48T59: <a href=3D"http://www.elektronikjk.pl/elementy_czynne/IC/M48T59V.pd=
f" target=3D"_blank">http://www.elektronikjk.pl/ele<wbr>menty_czynne/IC/M48=
T59V.pdf</a><br>
MC146818: <a href=3D"https://www.nxp.com/docs/en/data-sheet/MC146818.pdf" t=
arget=3D"_blank">https://www.nxp.com/docs/en/da<wbr>ta-sheet/MC146818.pdf</=
a><br>
PL031: <a href=3D"http://infocenter.arm.com/help/topic/com.arm.doc.ddi0224c=
/real_time_clock_pl031_r1p3_technical_reference_manual_DDI0224C.pdf" target=
=3D"_blank">http://infocenter.arm.com/help<wbr>/topic/com.arm.doc.ddi0224c/=
<wbr>real_time_clock_pl031_r1p3_<wbr>technical_reference_manual_<wbr>DDI022=
4C.pdf</a><br>
TWL92230: <a href=3D"https://datasheet.octopart.com/TWL92230C-Texas-Instrum=
ents-datasheet-150321.pdf" target=3D"_blank">https://datasheet.octopart.com=
<wbr>/TWL92230C-Texas-Instruments-<wbr>datasheet-150321.pdf</a><br>
Zynq RTC: <a href=3D"https://www.xilinx.com/support/documentation/user_guid=
es/ug1085-zynq-ultrascale-trm.pdf" target=3D"_blank">https://www.xilinx.com=
/support<wbr>/documentation/user_guides/<wbr>ug1085-zynq-ultrascale-trm.pdf=
</a><br>
(chapter 7)<br>
</blockquote>
<br>
I have a few questions about this:<br>
[a] Is there any particular reason that you picked DS3231 ? Linux kernel ha=
s drivers for DS3232/34 only [1].</blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><br></blockquote><div><br></div><div>Hi, Rajath.</div><div><br></div><div=
>No, it doesn&#39;t. Linux kernel has a driver for DS3231. Take a closer lo=
ok.</div><div><br></div><div>But, in any case, you base your QEMU emulation=
 on the *datasheet*.</div><div><br></div><div>The OS drivers may be helpful=
, but they are not a reference you base your solution on. The drivers may b=
e obsolete, incorrect, incomplete, or just plain wrong. Additionally, as QE=
MU, of course, supports emulation of systems running variety of OSs, the ex=
istence of the Linux kernel driver is not a necessary condition for QEMU im=
plementation. QEMU emulates many systems that Linux never ran on, and could=
 not be run at all.</div><div><br></div><div>Sincerely,</div><div>Aleksanda=
r</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
=C2=A0I did read the datasheets of both 3232 &amp; 3231 and found that they=
 are quite similar except for the 236 bytes of SRAM support found only in 3=
232.<br>
<br>
[b] As per the datasheet, DS3231 has a built-in temperature sensor. Tempera=
ture can be read from a dedicated register. There can be two approaches to =
emulating this: (1) Return a constant temperature value on every read (2) T=
hrow a not-supported exception/warning. What is the qemu convention for han=
dling such features ?<br>
<br>
[c] DS3231 also has programmable square-wave output + 32 KHz output pin. M4=
1T80 chip also supports this feature. However, qemu does not support emulat=
ion of these features [2]. Do I take the same approach ?<br>
<br>
Thanks!<br>
Rajath Shashidhara<br>
<br>
References:<br>
[1] <a href=3D"https://elixir.bootlin.com/linux/v5.4-rc6/source/drivers/rtc=
/rtc-ds3232.c" target=3D"_blank">https://elixir.bootlin.com/lin<wbr>ux/v5.4=
-rc6/source/drivers/rtc<wbr>/rtc-ds3232.c</a><br>
[2] <a href=3D"https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/rtc/m41t8=
0.c;h=3D914ecac8f4db418633d6daf92608cb50f6b89052;hb=3DHEAD" target=3D"_blan=
k">https://git.qemu.org/?p=3Dqemu.g<wbr>it;a=3Dblob;f=3Dhw/rtc/m41t80.c;h=
=3D<wbr>914ecac8f4db418633d6daf92608cb<wbr>50f6b89052;hb=3DHEAD</a><br>
</blockquote>

--00000000000028f1180596ef28e4--

