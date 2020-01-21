Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBFBC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 19:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3062073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 19:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhI3e9DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3062073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itzBL-0005lJ-Sc
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 14:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1itzAL-0004kb-CE
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1itzAJ-0001GV-HK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:26:21 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:36450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1itzAJ-0001F5-Bc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 14:26:19 -0500
Received: by mail-qt1-x842.google.com with SMTP id i13so3633163qtr.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CEWZRd43BT4QBHe21+/JQHigkIqLjY0lg8SjEPHpbDc=;
 b=GhI3e9DGsJ2KnUn/+nItrrNj8iuxYmVyqPmVYaOIGb7EqBOAP2INWXoSZBZDGA56yF
 3OcWKCaPR8Ejx2r/k/KKlE6yt5aNW8PAnhRXgh2if0eToETEgWrkWoskVYQ7GP9UII8S
 aiYKY4E5g3rMdykTj8TrM8w3598NA30C/4TWdKMfOqv8JNCVHpveePNiF2vC0jVNrwbs
 5V67RfP9458yGQ0BYf8QyQ/r1QSZGzSaI1KlETDxRbm3lF3ak45N7n0U8UlDCfuoGFxV
 uJlKaal/FFF+IIBoLbACGX/GUP2rbHLrXsF4L1JyJve6nrRbknWXvG/Z4Rp3alvIsO/j
 5OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CEWZRd43BT4QBHe21+/JQHigkIqLjY0lg8SjEPHpbDc=;
 b=IVWw2iObB0IJhUE+v0ON2xSExu8ntg/NrlWToyLbH1ZSMKu77QlwS34gY7Um0ZL2SN
 QwQ+KgGCMTudVoZDeAAvLCxd83UColBJX0enzX2kYqhTUympOai0eqjYVsI2KAWvg5G0
 eqFW2Kdbvo4VnPBh/DrteQw18bq8kuVrtggUpxDJnLPfkyejTW/NZg4AuTpdMf8gg+bX
 Qe1xY591npGevVdQ9dhJgZG+quseDNAhZtuuXtvfHkLJjA/lOhp89GlWErA3NgYa+1fO
 C70ml+jBzrp6PHuaiflxfwEgqcJ6L45aKwr2sqZ0xue6mnQbHsUgSCOenyyZ9t5fe6l6
 kXFQ==
X-Gm-Message-State: APjAAAUYyqcZ7ppdgJftOg8RlfLUmFKx+aIgUBKJFW2yexAu0Pn1YLXf
 xfNDsy8KdsdwbudqQ+EvmIMb4TyINpYW6VNq3bA=
X-Google-Smtp-Source: APXvYqybNa2gt0EuSXh7YVjeNLrLeLDGwReKdEG3fiVBNEoKkzt81OzrXV07QIrmHvweF19TEeOfiXfK19F2lGAvIDI=
X-Received: by 2002:ac8:41c1:: with SMTP id o1mr6063970qtm.229.1579634777961; 
 Tue, 21 Jan 2020 11:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20200120220107.17825-1-f4bug@amsat.org>
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 21 Jan 2020 21:25:39 +0200
Message-ID: <CAK4993jBdx4WniPqLs2YLUnv5rXhGL2SC9bjbjeVmO5bvkRgoQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] hw/avr: Introduce few Arduino boards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000d0b88d059cab6192"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d0b88d059cab6192
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe.

1. I cannot access https://gitlab.com/philmd/qemu/commits/arduino-v4
2. I merged your series into my workspace using patchwork
3. I payed attention that that you don't use automatic CPU detection (as
suggested by Aleksandar) by reading elf.
4. There is difference between -bios and -kernel (arduino boars crash when
-bios is used, but this seems because I run avr6 on avr5 CPU). I would be
happy if you explained what is the difference between these two arguments.
5. make check-acceptance pass correctly
6. make check-qtest-avr pass correctly


On Tue, Jan 21, 2020 at 12:01 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi,
>
> This series add the arduino boards, aiming at removing the
> 'sample' board that doesn't follow any specification.
>
> Since v3:
> - Rebased on Michael's v41
> - Drop 'extram' unused field (Igor)
> - Renamed devices AVR -> Atmel (Aleksandar)
>   (I haven't renamed structure names to ease review)
>
> Since v2:
> - rebased on Michael's v40
>
> Since v1:
> - Addressed Igor comments
> - Addressed Aleksandar comments
> - Fixed UART issue (was due to IRQ shifted by 2 in CPU)
>
> Since Michael's work is not yet merged, Various of my patches
> - which are trivials or simple renames - could be squashed
> directly on his patches, if we ever care.
> [I believe sending this patches is easier/quicker than keeping
> asking Michael to respin his series infinitely].
>
> Michael, do you mind testing it? The full series is available
> here: https://gitlab.com/philmd/qemu/commits/arduino-v4
>
> Regards,
>
> Phil.
>
> Obsoletes: <20191229224505.24466-1-f4bug@amsat.org>
> Based-on: <20200118191416.19934-1-mrolnik@gmail.com>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg671707.html
>
> Philippe Mathieu-Daud=C3=A9 (18):
>   MAINTAINERS: Move machine test to the machine section (not ARCH one)
>   MAINTAINERS: Move the AVR machines in new section (not within ARM)
>   tests/acceptance: Do not set the machine type manually
>   tests/acceptance: Keep multilines comment consistent with other tests
>   hw/char/avr: Reduce USART I/O size
>   hw/timer/avr_timer16: Rename memory region debugging name
>   hw/misc/avr_mask: Remove unused include
>   hw/avr/Makefile: Use CONFIG_AVR_SAMPLE variable
>   hw/char: Rename avr_usart -> atmel_usart
>   hw/timer: Rename avr_timer16 -> atmel_timer16
>   hw/misc: Rename avr_mask -> atmel_power
>   hw/avr: Introduce ATMEL_ATMEGA_MCU config
>   hw/avr: Add some ATmega microcontrollers
>   hw/avr: Add some Arduino boards
>   tests/boot-serial-test: Test some Arduino boards (AVR based)
>   tests/acceptance: Test the Arduino MEGA2560 board
>   hw/avr: Remove the unrealistic AVR 'sample' board
>   .travis.yml: Run the AVR acceptance tests
>
>  default-configs/avr-softmmu.mak               |   2 +-
>  hw/avr/atmel_atmega.h                         |  48 ++
>  .../hw/char/{avr_usart.h =3D> atmel_usart.h}    |  10 +-
>  include/hw/misc/{avr_mask.h =3D> atmel_power.h} |  11 +-
>  .../timer/{avr_timer16.h =3D> atmel_timer16.h}  |  10 +-
>  hw/avr/arduino.c                              | 175 +++++++
>  hw/avr/atmel_atmega.c                         | 464 ++++++++++++++++++
>  hw/avr/sample.c                               | 295 -----------
>  hw/char/{avr_usart.c =3D> atmel_usart.c}        |   6 +-
>  hw/misc/{avr_mask.c =3D> atmel_power.c}         |   4 +-
>  hw/timer/{avr_timer16.c =3D> atmel_timer16.c}   |  10 +-
>  tests/qtest/boot-serial-test.c                |   3 +-
>  .travis.yml                                   |   2 +-
>  MAINTAINERS                                   |  29 +-
>  hw/avr/Kconfig                                |  11 +-
>  hw/avr/Makefile.objs                          |   3 +-
>  hw/char/Kconfig                               |   2 +-
>  hw/char/Makefile.objs                         |   2 +-
>  hw/misc/Kconfig                               |   2 +-
>  hw/misc/Makefile.objs                         |   2 +-
>  hw/timer/Kconfig                              |   2 +-
>  hw/timer/Makefile.objs                        |   2 +-
>  tests/acceptance/machine_avr6.py              |  11 +-
>  23 files changed, 751 insertions(+), 355 deletions(-)
>  create mode 100644 hw/avr/atmel_atmega.h
>  rename include/hw/char/{avr_usart.h =3D> atmel_usart.h} (93%)
>  rename include/hw/misc/{avr_mask.h =3D> atmel_power.h} (89%)
>  rename include/hw/timer/{avr_timer16.h =3D> atmel_timer16.h} (92%)
>  create mode 100644 hw/avr/arduino.c
>  create mode 100644 hw/avr/atmel_atmega.c
>  delete mode 100644 hw/avr/sample.c
>  rename hw/char/{avr_usart.c =3D> atmel_usart.c} (99%)
>  rename hw/misc/{avr_mask.c =3D> atmel_power.c} (97%)
>  rename hw/timer/{avr_timer16.c =3D> atmel_timer16.c} (98%)
>
> --
> 2.21.1
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000d0b88d059cab6192
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Philippe.<div><br></div><div>1. I cannot access=C2=A0<a=
 href=3D"https://gitlab.com/philmd/qemu/commits/arduino-v4">https://gitlab.=
com/philmd/qemu/commits/arduino-v4</a></div><div>2. I merged your series in=
to my workspace using patchwork</div><div>3. I payed attention=C2=A0that th=
at you don&#39;t use automatic CPU detection (as suggested by Aleksandar) b=
y reading elf.</div><div>4. There is difference between -bios and -kernel (=
arduino boars crash when -bios is used, but this seems because I run avr6 o=
n avr5 CPU). I would be happy if you explained what is the difference betwe=
en these two arguments.</div><div>5.=C2=A0make check-acceptance pass correc=
tly</div><div>6.=C2=A0make check-qtest-avr pass correctly</div><div><br></d=
iv></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Tue, Jan 21, 2020 at 12:01 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
This series add the arduino boards, aiming at removing the<br>
&#39;sample&#39; board that doesn&#39;t follow any specification.<br>
<br>
Since v3:<br>
- Rebased on Michael&#39;s v41<br>
- Drop &#39;extram&#39; unused field (Igor)<br>
- Renamed devices AVR -&gt; Atmel (Aleksandar)<br>
=C2=A0 (I haven&#39;t renamed structure names to ease review)<br>
<br>
Since v2:<br>
- rebased on Michael&#39;s v40<br>
<br>
Since v1:<br>
- Addressed Igor comments<br>
- Addressed Aleksandar comments<br>
- Fixed UART issue (was due to IRQ shifted by 2 in CPU)<br>
<br>
Since Michael&#39;s work is not yet merged, Various of my patches<br>
- which are trivials or simple renames - could be squashed<br>
directly on his patches, if we ever care.<br>
[I believe sending this patches is easier/quicker than keeping<br>
asking Michael to respin his series infinitely].<br>
<br>
Michael, do you mind testing it? The full series is available<br>
here: <a href=3D"https://gitlab.com/philmd/qemu/commits/arduino-v4" rel=3D"=
noreferrer" target=3D"_blank">https://gitlab.com/philmd/qemu/commits/arduin=
o-v4</a><br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
Obsoletes: &lt;<a href=3D"mailto:20191229224505.24466-1-f4bug@amsat.org" ta=
rget=3D"_blank">20191229224505.24466-1-f4bug@amsat.org</a>&gt;<br>
Based-on: &lt;<a href=3D"mailto:20200118191416.19934-1-mrolnik@gmail.com" t=
arget=3D"_blank">20200118191416.19934-1-mrolnik@gmail.com</a>&gt;<br>
<a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg671707.htm=
l" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qemu-d=
evel@nongnu.org/msg671707.html</a><br>
<br>
Philippe Mathieu-Daud=C3=A9 (18):<br>
=C2=A0 MAINTAINERS: Move machine test to the machine section (not ARCH one)=
<br>
=C2=A0 MAINTAINERS: Move the AVR machines in new section (not within ARM)<b=
r>
=C2=A0 tests/acceptance: Do not set the machine type manually<br>
=C2=A0 tests/acceptance: Keep multilines comment consistent with other test=
s<br>
=C2=A0 hw/char/avr: Reduce USART I/O size<br>
=C2=A0 hw/timer/avr_timer16: Rename memory region debugging name<br>
=C2=A0 hw/misc/avr_mask: Remove unused include<br>
=C2=A0 hw/avr/Makefile: Use CONFIG_AVR_SAMPLE variable<br>
=C2=A0 hw/char: Rename avr_usart -&gt; atmel_usart<br>
=C2=A0 hw/timer: Rename avr_timer16 -&gt; atmel_timer16<br>
=C2=A0 hw/misc: Rename avr_mask -&gt; atmel_power<br>
=C2=A0 hw/avr: Introduce ATMEL_ATMEGA_MCU config<br>
=C2=A0 hw/avr: Add some ATmega microcontrollers<br>
=C2=A0 hw/avr: Add some Arduino boards<br>
=C2=A0 tests/boot-serial-test: Test some Arduino boards (AVR based)<br>
=C2=A0 tests/acceptance: Test the Arduino MEGA2560 board<br>
=C2=A0 hw/avr: Remove the unrealistic AVR &#39;sample&#39; board<br>
=C2=A0 .travis.yml: Run the AVR acceptance tests<br>
<br>
=C2=A0default-configs/avr-softmmu.mak=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/avr/atmel_atmega.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 48 ++<br>
=C2=A0.../hw/char/{avr_usart.h =3D&gt; atmel_usart.h}=C2=A0 =C2=A0 |=C2=A0 =
10 +-<br>
=C2=A0include/hw/misc/{avr_mask.h =3D&gt; atmel_power.h} |=C2=A0 11 +-<br>
=C2=A0.../timer/{avr_timer16.h =3D&gt; atmel_timer16.h}=C2=A0 |=C2=A0 10 +-=
<br>
=C2=A0hw/avr/arduino.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 175 +++++++<br>
=C2=A0hw/avr/atmel_atmega.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 464 ++++++++++++++++++<br>
=C2=A0hw/avr/sample.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 295 ----------=
-<br>
=C2=A0hw/char/{avr_usart.c =3D&gt; atmel_usart.c}=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A06 +-<br>
=C2=A0hw/misc/{avr_mask.c =3D&gt; atmel_power.c}=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0hw/timer/{avr_timer16.c =3D&gt; atmel_timer16.c}=C2=A0 =C2=A0|=C2=A0 =
10 +-<br>
=C2=A0tests/qtest/boot-serial-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +-<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 29 +-<br>
=C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
=C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-<br>
=C2=A0hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+-<br>
=C2=A0hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 =
+-<br>
=C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0tests/acceptance/machine_avr6.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 11 +-<br>
=C2=A023 files changed, 751 insertions(+), 355 deletions(-)<br>
=C2=A0create mode 100644 hw/avr/atmel_atmega.h<br>
=C2=A0rename include/hw/char/{avr_usart.h =3D&gt; atmel_usart.h} (93%)<br>
=C2=A0rename include/hw/misc/{avr_mask.h =3D&gt; atmel_power.h} (89%)<br>
=C2=A0rename include/hw/timer/{avr_timer16.h =3D&gt; atmel_timer16.h} (92%)=
<br>
=C2=A0create mode 100644 hw/avr/arduino.c<br>
=C2=A0create mode 100644 hw/avr/atmel_atmega.c<br>
=C2=A0delete mode 100644 hw/avr/sample.c<br>
=C2=A0rename hw/char/{avr_usart.c =3D&gt; atmel_usart.c} (99%)<br>
=C2=A0rename hw/misc/{avr_mask.c =3D&gt; atmel_power.c} (97%)<br>
=C2=A0rename hw/timer/{avr_timer16.c =3D&gt; atmel_timer16.c} (98%)<br>
<br>
-- <br>
2.21.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000d0b88d059cab6192--

