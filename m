Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF31C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED93F2464F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcAwK8CE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED93F2464F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icoTp-0001el-2M
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 05:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icoSa-0000eG-UT
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icoSR-0000Kq-5F
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:34:05 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1icoSP-0000Iv-9s
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:34:01 -0500
Received: by mail-oi1-x241.google.com with SMTP id k196so2291883oib.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 02:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=UOcyw9V0S2GVTnOhR5OYeln+64ofSXjPae2ZAtBJbsQ=;
 b=HcAwK8CEYTLSegyT2OlYqZ2bZsimGsTutWknleeYaFEAqajuFv77YCJOUhyrMx6oix
 AZcPCzlIB+en0iqMfP8Lq7eqCW9sLkYLlWpA69i3yQZKzPqkjIXqeBReE/lGfL4pe85K
 9cJgTv0t6l3cziZYm0B4t6uzOfuMXxiWkQBWJ6ffzVqg8ScNs40K5M3AAI67XthQT8OQ
 qz4Nk0FIBfLXoh4qnDgmz4+UO4j/KTcTg7zqc2h8hK3eYIzOarKb3A2UHj+phJD6x20w
 xobNkCyfKWSLpNDr5aGIjLh/bTa8y0d4DWyoOcht6TEciSAWz/ogBztlHEbZjwK+cXvV
 y3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=UOcyw9V0S2GVTnOhR5OYeln+64ofSXjPae2ZAtBJbsQ=;
 b=fhQMI1ihr4M9wdsGTriidmQ5LWsyd6drCjHVJxOIxyqN6HI6F+I69TOUzutUfh9zWN
 euGYWwFEshlhrXZCuQkAaIMMM0hxrUcC99ltqKUMfHQOupg7xV2A0yxT407cdH/dCdTR
 JW2IvScfpqhcVnayxBdjTCBG5tadXJfVdMfzP9fw5COWdRu0inKi0A7f9ggpSTclQOSF
 xd8qsY/wyoeU+WTmp25qAySISuO9AzNffWOx1Qdxhtt5jej46xx2LN7z532JAgYIhVNJ
 LnjrI9wT+EHNV/Ij3x9fZu4gQgivAQJisZRoYFUYxBklHfJ3OTemBf54AHNLZzAuU5Jd
 cx7w==
X-Gm-Message-State: APjAAAWUOnSRmNM6Xg4sK5gbomWR8hgWvvXIr1+lcCUD72tk3Iho/F07
 U0o/Yf4YoN5OQMn7zkj9/9+XED3hpMuUBrtdm3Q=
X-Google-Smtp-Source: APXvYqxG8XmNqjCtRVOPePIvTD8gNDiHDFHlBeXg3hC6ded5WyRFffmLQqb2GuMXWIquGY9lWL9EjeV/CMCgj/BDqnQ=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr6672676oic.62.1575542039049; 
 Thu, 05 Dec 2019 02:33:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 5 Dec 2019 02:33:58 -0800 (PST)
In-Reply-To: <CAL1e-=h70Hrs7fFEBMgzhrq3HKhxuy9qGQg5148jJ1ACALSThg@mail.gmail.com>
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-6-mrolnik@gmail.com>
 <000c01d542cf$d8476a00$88d63e00$@ru>
 <CAL1e-=h70Hrs7fFEBMgzhrq3HKhxuy9qGQg5148jJ1ACALSThg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 5 Dec 2019 11:33:58 +0100
Message-ID: <CAL1e-=i6qjd2hwNqpV3eWmhN-QozC2c7jJnsns0JjGpLb+-Ppg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v27 5/8] target/avr: Add limited support for
 USART and 16 bit timer peripherals
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000090fb7a0598f27752"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000090fb7a0598f27752
Content-Type: text/plain; charset="UTF-8"

On Thursday, December 5, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Thursday, July 25, 2019, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>
>> > From: Qemu-devel [mailto:qemu-devel-bounces+patchwork-qemu-
>> > devel=patchwork.kernel.org@nongnu.org] On Behalf Of Michael Rolnik
>> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
>> >
>> > These were designed to facilitate testing but should provide enough
>> function to be useful in
>> > other contexts.
>>
>> USART is very useful for testing, but to which model of AVR is belongs?
>> We also started implementation of USART and other devices in our
>> internship program,
>> using prior version of your patches.
>> There were other register addresses for the registers and some of them
>> even intersect
>> making read/write logic more complex (we looked at Atmega8).
>>
>> You also mix the board and the SoC into one file, making hardware-on-chip
>> harder to reuse.
>>
>> I think that the structure can be revised in the following way:
>> Board -> SoC -> Devices
>>
>>
> Pavel,
>
> By "structure", did you mean structure of patches?
>
> Let's say, after the all ISA instruction patches are introduced, we first
> introduce one real board of our choice (only infrastructure, with almost
> empty content, than devices on that board, than the corresponding SoC/MCU
> infrastucture, than device in that SoC.
>
> Additional boards would follow the same pattern, potentially reusing
> already implemented devices, or whole SoC/MCU.
>
> One more question:
>
> We already saw that devices within SoC/MCUs for AVR platform exibit great
> variation. First, there are around 17 generation of AVR cores (avr1, avr2,
> ... xmega7). Than, there is, I think 600+ SoC/MCU models (hard to believe,
> but true). Each SoC defines its devices, and in potentially different way
> (not only its starting address, but real differences in terms of
> functionality). I thought that at least for a particular core, the devices
> would be defined in a consistent way, but even that is not true - for
> example ADC for a SoC having core X can be significantly different that ADC
> for another SoC having the same core X.
>
> How to deal with such avalanche of devices? How to organize and maintain
> 27 significantly different versions of ADC; and 53 significantly different
> versions of Watchdogs (the numbers are invented by me, but are likely to
> describe the situation well)?
>
>
Peter, may I ask you the same questions?

I have a strong impression we here need to think colectively.

Yours,

Aleksandar



> Best regards,
>
> Aleksandar
>
>
>
>
>
>> Board includes SoC, loads the firmware, and adds some external peripheral
>> devices, if needed.
>>
>> SoC includes embedded peripherals. It dispatches IO memory accesses and
>> passes them
>> to the devices. In this case you can have different register addresses
>> for different SoCs, but
>> the embedded device emulation code can be mostly the same for simple
>> devices like USART.
>>
>> > Only a subset of the functions of each peripheral is implemented,
>> mainly due to the lack of a
>> > standard way to handle electrical connections (like GPIO pins).
>>
>> We did not got too much results, you can check for our changes here:
>> https://github.com/Dovgalyuk/qemu/tree/avr8
>>
>> But we can help you in development of better version of the patches and
>> split the work
>> for making this platform more usable.
>>
>>
>> Pavel Dovgalyuk
>>
>>
>>

--00000000000090fb7a0598f27752
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, December 5, 2019, Aleksandar Markovic &lt;<a href=3D"m=
ailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><br><br>On Thursday, July 25, 2019, Pa=
vel Dovgalyuk &lt;<a href=3D"mailto:dovgaluk@ispras.ru" target=3D"_blank">d=
ovgaluk@ispras.ru</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt; Fro=
m: Qemu-devel [mailto:<a href=3D"mailto:qemu-devel-bounces+patchwork-qemu-"=
 target=3D"_blank">qemu-devel-bounces+<wbr>patchwork-qemu-</a><br>
&gt; devel=3D<a href=3D"mailto:patchwork.kernel.org@nongnu.org" target=3D"_=
blank">patchwork.kernel.org@<wbr>nongnu.org</a>] On Behalf Of Michael Rolni=
k<br>
&gt; From: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" target=
=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; <br>
&gt; These were designed to facilitate testing but should provide enough fu=
nction to be useful in<br>
&gt; other contexts.<br>
<br>
USART is very useful for testing, but to which model of AVR is belongs?<br>
We also started implementation of USART and other devices in our internship=
 program,<br>
using prior version of your patches.<br>
There were other register addresses for the registers and some of them even=
 intersect<br>
making read/write logic more complex (we looked at Atmega8).<br>
<br>
You also mix the board and the SoC into one file, making hardware-on-chip h=
arder to reuse.<br>
<br>
I think that the structure can be revised in the following way:<br>
Board -&gt; SoC -&gt; Devices<br>
<br></blockquote><div><br></div><div>Pavel,</div><div><br></div><div>By &qu=
ot;structure&quot;, did you mean structure of patches?</div><div><br></div>=
<div>Let&#39;s say, after the all ISA instruction patches are introduced, w=
e first introduce one real board of our choice (only infrastructure, with a=
lmost empty content, than devices on that board, than the corresponding SoC=
/MCU infrastucture, than device in that SoC.</div><div><br></div><div>Addit=
ional boards would follow the same pattern, potentially reusing already imp=
lemented devices, or whole SoC/MCU.</div><div><br></div><div>One more quest=
ion:</div><div><br></div><div>We already saw that devices within SoC/MCUs f=
or AVR platform exibit great variation. First, there are around 17 generati=
on of AVR cores (avr1, avr2, ... xmega7). Than, there is, I think 600+ SoC/=
MCU models (hard to believe, but true). Each SoC defines its devices, and i=
n potentially different way (not only its starting address, but real differ=
ences in terms of functionality). I thought that at least for a particular =
core, the devices would be defined in a consistent way, but even that is no=
t true - for example ADC for a SoC having core X can be significantly diffe=
rent that ADC for another SoC having the same core X.</div><div><br></div><=
div>How to deal with such avalanche of devices? How to organize and maintai=
n 27 significantly different versions of ADC; and 53 significantly differen=
t versions of Watchdogs (the numbers are invented by me, but are likely to =
describe the situation well)?</div><div><br></div></blockquote><div><br></d=
iv><div>Peter, may I ask you the same questions?</div><div><br></div><div>I=
 have a strong impression we here need to think colectively.</div><div><br>=
</div><div>Yours,</div><div><br></div><div>Aleksandar</div><div><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div>Best regards,</div><div=
><br></div><div>Aleksandar</div><div><br></div><div><br></div><div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
Board includes SoC, loads the firmware, and adds some external peripheral d=
evices, if needed.<br>
<br>
SoC includes embedded peripherals. It dispatches IO memory accesses and pas=
ses them<br>
to the devices. In this case you can have different register addresses for =
different SoCs, but<br>
the embedded device emulation code can be mostly the same for simple device=
s like USART.<br>
<br>
&gt; Only a subset of the functions of each peripheral is implemented, main=
ly due to the lack of a<br>
&gt; standard way to handle electrical connections (like GPIO pins).<br>
<br>
We did not got too much results, you can check for our changes here: <a hre=
f=3D"https://github.com/Dovgalyuk/qemu/tree/avr8" target=3D"_blank">https:/=
/github.com/Dovgalyuk/q<wbr>emu/tree/avr8</a><br>
<br>
But we can help you in development of better version of the patches and spl=
it the work<br>
for making this platform more usable.<br>
<br>
<br>
Pavel Dovgalyuk<br>
<br>
<br>
</blockquote>
</blockquote>

--00000000000090fb7a0598f27752--

