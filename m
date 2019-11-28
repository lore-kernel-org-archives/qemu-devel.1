Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1280BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE6021775
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR79sAqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE6021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaH8y-0000Xq-Tq
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 05:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iaH52-0007S7-CA
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iaH4z-0001IF-5M
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:31:23 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:38648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iaH4y-00013v-Sh
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:31:21 -0500
Received: by mail-qv1-xf43.google.com with SMTP id t5so3290706qvs.5
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t0tTiforbdzkPTOMQUpc2eocwsqaJtS1KuB3NtdQoZ4=;
 b=fR79sAqBlnK7OW5gtXOuoPpxqiFVWaXswv0shWmOogkD3pbBB2KhY4bZin2UG9FTYs
 v1gPNpV0tiJtrjO/Pf2UiFY4o4yVCdo6SF/Kj7ck0oM88HGWQq3WXVBr42uPQ+BJ13HQ
 mz01E8YRhn14xjvU9M9+0E72OkgDbSr3NhbHX0iWtXQSTeuGuLzPBWjQoDzXT2jHkb2/
 OO49RdjlNjq+VLCj64o0MbHoudXKW0jxdwlUV2x4Tt1qPhRyQxumVofQSGM7/CN44od6
 3LLdtXiNrIUAGrzfC7bY8dn7eNDspIoLEhTX6hkc0voUqI49dmnA2j7NK03CjjUQ1gek
 YDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t0tTiforbdzkPTOMQUpc2eocwsqaJtS1KuB3NtdQoZ4=;
 b=KsdLOcoMh9v4oaTLhBcK6FfugTJ4LgAwnxLPSJgvT7cb2nuvFcQzvCDP7J7Nf46sLT
 dzfOh0UhUdQ54xsOHjMCiiCRhxolrrcMF41spVgYuMQwM5lIS00uRaOhMDQkVqA0FueA
 4Rtmp/3iovGCGzAywtoee3fP0VK0YXZ18wRe/je0+EiCjdQLYs5ZDXzrpCfOEyWjg8Tn
 klfRcViuQFCuMZv6kFUG/bzVWATVUdM6Xgnwl4MzHW8XUUAGvDlr5UUFkx0dfWKvwfuo
 wMBpitC8Lhqi9cAbBXAiYQhL53a2Cs73XqvHPiUAwk1d3lb2ooGqiws+nRrbPB0DnZfU
 fylA==
X-Gm-Message-State: APjAAAX6nQkRgLCpngDk6h7yxsDiC7Yepe0YYQpV63zba8d5hNxQvjVb
 KTrRIDluj0lKSaUPU/KgYWm1Zjq0qehmckEHazQ=
X-Google-Smtp-Source: APXvYqxKN1vTUmyHjZjGWZp8ohiKAia528GXQIEaIG/iRU5hs+BSJlJ3TjPRuV7dOcZAtieOy6j4agG4cKTHd/JqTbQ=
X-Received: by 2002:ad4:4cc4:: with SMTP id i4mr10116763qvz.137.1574937077685; 
 Thu, 28 Nov 2019 02:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20191128015030.27543-1-f4bug@amsat.org>
In-Reply-To: <20191128015030.27543-1-f4bug@amsat.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 28 Nov 2019 12:30:09 +0200
Message-ID: <CAK4993jMtP5jTB4JOzRqSxgV8mLH5PTs+uF8-0zdkzVGUodqUA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] hw/avr: Introduce the Arduino board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000000f235b0598659d5e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000f235b0598659d5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe.

This is really good news.

Should I do anything or this will be merged after my stuff goes through?

On Thu, Nov 28, 2019 at 3:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Hi Michael,
>
> I complained I'd rather have QEMU model real hardware, with
> documentation (schematics).
> Since your series is almost ready to get merged, I prefered to
> spend some time now to write down what I wanted. This is mostly
> a rewrite of your board, but matching the Arduino boards.
>
> Some bug slipped in (uart interrupt not raised) but I'm too tired
> to find it, and since I won't have time to look at it the next
> days, I prefer to send this now.
>
> The first part of the series are quick review notes, which you
> should squash in your previous patches.
>
> I still have in my TODO before merge:
> - Fix the USART IRQ bug
> - Split "Add limited support for USART and 16 bit timer peripherals"
>   in 3 patches: USART/Timer16/INTC
>
> And TODO after merge is:
> - Extract Timer8 common parts from Timer16
> - Add GPIOs
> - Connect LED to GPIO on Arduino
>
> Thank you for having insisted with this during so long!
>
> Regards,
>
> Phil.
>
> Based-on: <20191127175257.23480-1-mrolnik@gmail.com>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg661553.html
>
> Philippe Mathieu-Daud=C3=A9 (10):
>   hw/avr: Kludge to fix build failure
>   target/avr: Remove unused include
>   target/avr: Add missing definitions
>   target/avr: Fix IRQ count
>   hw/char/avr: Reduce USART I/O size
>   hw/avr: Add ATmega microcontrollers
>   hw/avr: Add few Arduino boards
>   tests/acceptance: Keep multilines comment consistent with other tests
>   tests/acceptance: Use the ATmega2560 board
>   hw/avr: Remove the 'sample' board
>
>  hw/avr/atmega.h                  |  58 +++++
>  include/hw/char/avr_usart.h      |   2 +
>  target/avr/cpu.h                 |   2 +
>  hw/avr/arduino.c                 | 173 ++++++++++++++
>  hw/avr/atmega.c                  | 379 +++++++++++++++++++++++++++++++
>  hw/avr/sample.c                  | 282 -----------------------
>  hw/char/avr_usart.c              |   2 +-
>  target/avr/cpu.c                 |   2 +-
>  target/avr/helper.c              |   1 -
>  hw/avr/Makefile.objs             |   3 +-
>  tests/acceptance/machine_avr6.py |  10 +-
>  11 files changed, 623 insertions(+), 291 deletions(-)
>  create mode 100644 hw/avr/atmega.h
>  create mode 100644 hw/avr/arduino.c
>  create mode 100644 hw/avr/atmega.c
>  delete mode 100644 hw/avr/sample.c
>
> --
> 2.21.0
>
>

--=20
Best Regards,
Michael Rolnik

--0000000000000f235b0598659d5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Philippe.<div><br></div><div>This is really good=C2=A0n=
ews.=C2=A0</div><div><br></div><div>Should I do anything or this will be me=
rged after my stuff goes=C2=A0through?</div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 28, 2019 at 3:50 AM=
 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@a=
msat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Hi Michael,<br>
<br>
I complained I&#39;d rather have QEMU model real hardware, with<br>
documentation (schematics).<br>
Since your series is almost ready to get merged, I prefered to<br>
spend some time now to write down what I wanted. This is mostly<br>
a rewrite of your board, but matching the Arduino boards.<br>
<br>
Some bug slipped in (uart interrupt not raised) but I&#39;m too tired<br>
to find it, and since I won&#39;t have time to look at it the next<br>
days, I prefer to send this now.<br>
<br>
The first part of the series are quick review notes, which you<br>
should squash in your previous patches.<br>
<br>
I still have in my TODO before merge:<br>
- Fix the USART IRQ bug<br>
- Split &quot;Add limited support for USART and 16 bit timer peripherals&qu=
ot;<br>
=C2=A0 in 3 patches: USART/Timer16/INTC<br>
<br>
And TODO after merge is:<br>
- Extract Timer8 common parts from Timer16<br>
- Add GPIOs<br>
- Connect LED to GPIO on Arduino<br>
<br>
Thank you for having insisted with this during so long!<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
Based-on: &lt;<a href=3D"mailto:20191127175257.23480-1-mrolnik@gmail.com" t=
arget=3D"_blank">20191127175257.23480-1-mrolnik@gmail.com</a>&gt;<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg661553.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg661553.html</a><br>
<br>
Philippe Mathieu-Daud=C3=A9 (10):<br>
=C2=A0 hw/avr: Kludge to fix build failure<br>
=C2=A0 target/avr: Remove unused include<br>
=C2=A0 target/avr: Add missing definitions<br>
=C2=A0 target/avr: Fix IRQ count<br>
=C2=A0 hw/char/avr: Reduce USART I/O size<br>
=C2=A0 hw/avr: Add ATmega microcontrollers<br>
=C2=A0 hw/avr: Add few Arduino boards<br>
=C2=A0 tests/acceptance: Keep multilines comment consistent with other test=
s<br>
=C2=A0 tests/acceptance: Use the ATmega2560 board<br>
=C2=A0 hw/avr: Remove the &#39;sample&#39; board<br>
<br>
=C2=A0hw/avr/atmega.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 58 +++++<br>
=C2=A0include/hw/char/avr_usart.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
=C2=A0hw/avr/arduino.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 173 ++++++++++++++<br>
=C2=A0hw/avr/atmega.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 379 +++++++++++++++++++++++++++++++<br>
=C2=A0hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 282 -----------------------<br>
=C2=A0hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 -<br>
=C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +-<br>
=C2=A0tests/acceptance/machine_avr6.py |=C2=A0 10 +-<br>
=C2=A011 files changed, 623 insertions(+), 291 deletions(-)<br>
=C2=A0create mode 100644 hw/avr/atmega.h<br>
=C2=A0create mode 100644 hw/avr/arduino.c<br>
=C2=A0create mode 100644 hw/avr/atmega.c<br>
=C2=A0delete mode 100644 hw/avr/sample.c<br>
<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000000f235b0598659d5e--

