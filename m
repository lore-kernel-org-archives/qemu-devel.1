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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C71C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B342464F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoHg/HE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B342464F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icoOJ-0006TY-5I
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 05:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icoLv-00051j-KW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icoLt-0006gV-I1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:27:19 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1icoLt-0006cd-8h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:27:17 -0500
Received: by mail-ot1-x343.google.com with SMTP id i4so2152944otr.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 02:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=sQ/wIBeezx2XaYzNlNoExTQ+J0cwUEyPsUGYx51Z7P4=;
 b=HoHg/HE59I9MkLABmB+jC0VJZmrVCUxGpA4axzFVgPKHUo59qWUQHBMaOrZRCmZyoy
 8cipbBA81fPLX27dmDWXXepHwTJ+mXW7Wfc9Fep3pfsyDeh+8l4Y7pAl8i3ADiF9QlbZ
 OJKzuLZ35BLIIVcQX5xR69mvoKKcekNhixIa97eq7RmN2qtfLAbI0YnJ4bNKGqyw55NT
 LBqkjkAo+OpUNrgAnDU11shFNoKlkWWUFSyaC52Ou27dGkTmlvKlodpIvY2MZ5BR86Xp
 XZGf1hAjRa1Xw1Wa1Qct7gpB4iG/ADYl4/Sxe4n3Wo7kb33lm5O03GrewGXiT2+tmMYa
 kJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=sQ/wIBeezx2XaYzNlNoExTQ+J0cwUEyPsUGYx51Z7P4=;
 b=EWgwEizMh2kjaScZFIjls64ftzg9ZDPTTlrfXgSn2E2gpUaaY90VpQf6i5RdhqnXM/
 4duAZbRBKE+OsX6UmjKVJOM3/xqpYOe6Wg7FZTYD+h4TC8u8JxQYvjZyr/XPscd6t+aH
 twwK/fDhDYQ1ckazaM4tQaKHludeoOyVej1dWX2EU/ccz3PQshpcwDY4h3mWFKDgvO2g
 MOFud54z6+VJA/c2MGcYjNf7C2vH/TT6iCuVghNh42mJ7oqHeuRU8tpQWMLB4Pu3pJa+
 uen9ld1I2rG4LnieiFMTlWVwlDxzUCwf6EXvNxDtrBX4gEoXlPw8RekzXZGrNiqooiyU
 5AGA==
X-Gm-Message-State: APjAAAVgqfv8WhhEwYgW4NG6dnnZVGl9T9jEGCpMLsqNHKcwFHr5SBJm
 34qYaMVD8j6fNbGutFy1Ak8PN22RxqisZFO2sGk=
X-Google-Smtp-Source: APXvYqwkxiSOmZMhcrRMj2lcEw5JgtGCuBI2K9xzoiIwPJQit0TMO9yjf5ixKyHV1FQfsoAUUDM3ZP5kyTdRTPKVp/o=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr5950777otp.306.1575541636155; 
 Thu, 05 Dec 2019 02:27:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 5 Dec 2019 02:27:15 -0800 (PST)
In-Reply-To: <000c01d542cf$d8476a00$88d63e00$@ru>
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-6-mrolnik@gmail.com>
 <000c01d542cf$d8476a00$88d63e00$@ru>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 5 Dec 2019 11:27:15 +0100
Message-ID: <CAL1e-=h70Hrs7fFEBMgzhrq3HKhxuy9qGQg5148jJ1ACALSThg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v27 5/8] target/avr: Add limited support for
 USART and 16 bit timer peripherals
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Content-Type: multipart/alternative; boundary="0000000000008d4d610598f25f90"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

--0000000000008d4d610598f25f90
Content-Type: text/plain; charset="UTF-8"

On Thursday, July 25, 2019, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:

> > From: Qemu-devel [mailto:qemu-devel-bounces+patchwork-qemu-
> > devel=patchwork.kernel.org@nongnu.org] On Behalf Of Michael Rolnik
> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> >
> > These were designed to facilitate testing but should provide enough
> function to be useful in
> > other contexts.
>
> USART is very useful for testing, but to which model of AVR is belongs?
> We also started implementation of USART and other devices in our
> internship program,
> using prior version of your patches.
> There were other register addresses for the registers and some of them
> even intersect
> making read/write logic more complex (we looked at Atmega8).
>
> You also mix the board and the SoC into one file, making hardware-on-chip
> harder to reuse.
>
> I think that the structure can be revised in the following way:
> Board -> SoC -> Devices
>
>
Pavel,

By "structure", did you mean structure of patches?

Let's say, after the all ISA instruction patches are introduced, we first
introduce one real board of our choice (only infrastructure, with almost
empty content, than devices on that board, than the corresponding SoC/MCU
infrastucture, than device in that SoC.

Additional boards would follow the same pattern, potentially reusing
already implemented devices, or whole SoC/MCU.

One more question:

We already saw that devices within SoC/MCUs for AVR platform exibit great
variation. First, there are around 17 generation of AVR cores (avr1, avr2,
... xmega7). Than, there is, I think 600+ SoC/MCU models (hard to believe,
but true). Each SoC defines its devices, and in potentially different way
(not only its starting address, but real differences in terms of
functionality). I thought that at least for a particular core, the devices
would be defined in a consistent way, but even that is not true - for
example ADC for a SoC having core X can be significantly different that ADC
for another SoC having the same core X.

How to deal with such avalanche of devices? How to organize and maintain 27
significantly different versions of ADC; and 53 significantly different
versions of Watchdogs (the numbers are invented by me, but are likely to
describe the situation well)?

Best regards,

Aleksandar





> Board includes SoC, loads the firmware, and adds some external peripheral
> devices, if needed.
>
> SoC includes embedded peripherals. It dispatches IO memory accesses and
> passes them
> to the devices. In this case you can have different register addresses for
> different SoCs, but
> the embedded device emulation code can be mostly the same for simple
> devices like USART.
>
> > Only a subset of the functions of each peripheral is implemented, mainly
> due to the lack of a
> > standard way to handle electrical connections (like GPIO pins).
>
> We did not got too much results, you can check for our changes here:
> https://github.com/Dovgalyuk/qemu/tree/avr8
>
> But we can help you in development of better version of the patches and
> split the work
> for making this platform more usable.
>
>
> Pavel Dovgalyuk
>
>
>

--0000000000008d4d610598f25f90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, July 25, 2019, Pavel Dovgalyuk &lt;<a href=3D"mailto:d=
ovgaluk@ispras.ru">dovgaluk@ispras.ru</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">&gt; From: Qemu-devel [mailto:<a href=3D"mailto:qemu-devel-bo=
unces+patchwork-qemu-">qemu-devel-bounces+patchwork-qemu-</a><br>
&gt; devel=3D<a href=3D"mailto:patchwork.kernel.org@nongnu.org">patchwork.k=
ernel.org@nongnu.org</a>] On Behalf Of Michael Rolnik<br>
&gt; From: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk">S.E.Ha=
rris@kent.ac.uk</a>&gt;<br>
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
describe the situation well)?</div><div><br></div><div>Best regards,</div><=
div><br></div><div>Aleksandar</div><div><br></div><div><br></div><div><br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
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
/github.com/Dovgalyuk/<wbr>qemu/tree/avr8</a><br>
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

--0000000000008d4d610598f25f90--

