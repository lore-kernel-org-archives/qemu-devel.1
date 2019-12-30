Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D2C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881F1206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP6Y5gOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881F1206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilzd0-0003ny-Nw
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 13:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilzc1-0003J8-0a
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilzbz-0002lb-HC
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:17:52 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:42038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilzbz-0002lT-Ce
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:17:51 -0500
Received: by mail-qk1-x742.google.com with SMTP id z14so25559033qkg.9
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 10:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PnB9FlAn3vQNu11n4XgWkl/HLe/S2sfTOY+tVF85AVc=;
 b=XP6Y5gOoETNeMyIiCf7HUqlTGpmQOUu22VJcEtPjoY9IAto6LgmoXZXanuQAeZ0M2A
 8CnedeUj2CNO1UIt0CxcZpi8qRhEL/Lly3lYaBMEDcrAS/OG8gMLfFVKpmiuJDv069B8
 XlRWeONvgpP+d3tVYhC4EYqE8eWENM3pL8IxUpIz+6etfrHhqpQoC7kK0Vz1sgfvOZhi
 4EeD9So6hWnXpChfFf1vVuFSFkjqahEM64Cx5xH78v1WC6v2f3Jhx0rNi/hspaIxFUos
 TyQTc26NKfPx2sGtMdWTkSg2hmkqSPtpAPkFf0LqIy+3NupZN18G2G3wbgHc8YaGEpY5
 ih1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PnB9FlAn3vQNu11n4XgWkl/HLe/S2sfTOY+tVF85AVc=;
 b=gAtZscj2hZZ4Alb0KTXuoZ395q+eh4c88DYh2vVIU6ZyDqQaeL1jFn52FQ86auniuo
 mTNYGZPc5YbEbyvyaT/hIuVI5jofbyhs2i01o4Xvxvycn0S1J889oM2HgW819697H93L
 mxvTrNlahmorrw+6OizwfkvWTPoadMyYRw0eIKeZTeyz6IBZfVczfSSF1paet676/FI2
 4UyhMm6TcE1Ad902ru+9AboR8M3mvP1UbUpaKOI0LgqT0X/cgT6cv1RAVFll4j29+aqV
 w+rSVr8FAv3aFc6Y22Qj7jRaPnrGGFBVUadqTQHzYeEePZwap4oqfYRsywwzMjH7Xuap
 jiyw==
X-Gm-Message-State: APjAAAU9cC2XA0dtGxxyzQySH9pgR6u4edKuuBVRww/cZc/PduFCkqAP
 eq0cM4NJUEJAoxWBOrEVI3nLTiqBNAMcYjJV/SU=
X-Google-Smtp-Source: APXvYqy7vn0AKYcaf7fnztoa+5IN1gsYD6TGnG0hsoA1krAF3Vti75UEPaMPBri2tZddKg1JF69dgvq2tzrcUAzgfNM=
X-Received: by 2002:a37:4a8b:: with SMTP id
 x133mr51314606qka.181.1577729870660; 
 Mon, 30 Dec 2019 10:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20191229224505.24466-1-f4bug@amsat.org>
In-Reply-To: <20191229224505.24466-1-f4bug@amsat.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 30 Dec 2019 20:17:08 +0200
Message-ID: <CAK4993jswyYwanXZ4G4y4XwJ6nrtSLXZjvsE+LK+KRJASpe9Kw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] hw/avr: Introduce the Arduino boards
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000007e0b77059aefdcae"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007e0b77059aefdcae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe.

Thank you for joining the effort.

Regards,
Michael Rolnik


On Mon, Dec 30, 2019 at 12:45 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi,
>
> This series add the arduino boards, aiming at removing the
> 'sample' board that doesn't follow any specification.
>
> Since v2:
> - rebased on Michael's v40
>
> Since v1:
> - Addressed Igor comments
> - Addressed Aleksandar comments
> - Fixed UART issue (was due to IRQ shifted by 2 in CPU)
>
> TODO after merge is:
> - Extract Timer8 common parts from Timer16
> - Add GPIOs
> - Connect LED to GPIO on Arduino
> - Plug to Scratch (See http://s4a.cat/).
>   (I plan to purpose that as a GSoC idea).
>
> Michael, thank you for having insisted with this port during so long!
>
> Regards,
>
> Phil.
>
> Series available at https://gitlab.com/philmd/qemu/commits/arduino-v3
>
> Regards,
>
> Phil.
>
> Based-on: <20191229215158.5788-1-mrolnik@gmail.com>
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05309.html
>
> Philippe Mathieu-Daud=C3=A9 (8):
>   hw/char/avr: Reduce USART I/O size
>   hw/timer/avr_timer16: Rename memory region debugging name
>   hw/avr: Add some ATmega microcontrollers
>   hw/avr: Add some Arduino boards
>   tests/boot-serial-test: Test some Arduino boards (AVR based)
>   tests/acceptance: Do not set the machine type manually
>   tests/acceptance: Keep multilines comment consistent with other tests
>   tests/acceptance: Test the Arduino MEGA2560 board
>
>  hw/avr/atmega.h                  |  48 ++++
>  hw/avr/arduino.c                 | 177 ++++++++++++
>  hw/avr/atmega.c                  | 464 +++++++++++++++++++++++++++++++
>  hw/char/avr_usart.c              |   2 +-
>  hw/timer/avr_timer16.c           |   6 +-
>  tests/boot-serial-test.c         |   2 +
>  hw/avr/Makefile.objs             |   2 +
>  tests/acceptance/machine_avr6.py |  11 +-
>  8 files changed, 701 insertions(+), 11 deletions(-)
>  create mode 100644 hw/avr/atmega.h
>  create mode 100644 hw/avr/arduino.c
>  create mode 100644 hw/avr/atmega.c
>
> --
> 2.21.0
>
>

--=20
Best Regards,
Michael Rolnik

--0000000000007e0b77059aefdcae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Philippe.<div><br></div><div>Thank you for joining the =
effort.</div><div><br></div><div>Regards,</div><div>Michael Rolnik<br><div>=
<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Mon, Dec 30, 2019 at 12:45 AM Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
This series add the arduino boards, aiming at removing the<br>
&#39;sample&#39; board that doesn&#39;t follow any specification.<br>
<br>
Since v2:<br>
- rebased on Michael&#39;s v40<br>
<br>
Since v1:<br>
- Addressed Igor comments<br>
- Addressed Aleksandar comments<br>
- Fixed UART issue (was due to IRQ shifted by 2 in CPU)<br>
<br>
TODO after merge is:<br>
- Extract Timer8 common parts from Timer16<br>
- Add GPIOs<br>
- Connect LED to GPIO on Arduino<br>
- Plug to Scratch (See <a href=3D"http://s4a.cat/" rel=3D"noreferrer" targe=
t=3D"_blank">http://s4a.cat/</a>).<br>
=C2=A0 (I plan to purpose that as a GSoC idea).<br>
<br>
Michael, thank you for having insisted with this port during so long!<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
Series available at <a href=3D"https://gitlab.com/philmd/qemu/commits/ardui=
no-v3" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/philmd/qemu/=
commits/arduino-v3</a><br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
Based-on: &lt;<a href=3D"mailto:20191229215158.5788-1-mrolnik@gmail.com" ta=
rget=3D"_blank">20191229215158.5788-1-mrolnik@gmail.com</a>&gt;<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05309.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2019-12/msg05309.html</a><br>
<br>
Philippe Mathieu-Daud=C3=A9 (8):<br>
=C2=A0 hw/char/avr: Reduce USART I/O size<br>
=C2=A0 hw/timer/avr_timer16: Rename memory region debugging name<br>
=C2=A0 hw/avr: Add some ATmega microcontrollers<br>
=C2=A0 hw/avr: Add some Arduino boards<br>
=C2=A0 tests/boot-serial-test: Test some Arduino boards (AVR based)<br>
=C2=A0 tests/acceptance: Do not set the machine type manually<br>
=C2=A0 tests/acceptance: Keep multilines comment consistent with other test=
s<br>
=C2=A0 tests/acceptance: Test the Arduino MEGA2560 board<br>
<br>
=C2=A0hw/avr/atmega.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 48 ++++<br>
=C2=A0hw/avr/arduino.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 177 ++++++++++++<br>
=C2=A0hw/avr/atmega.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 464 +++++++++++++++++++++++++++++++<br>
=C2=A0hw/char/avr_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0hw/timer/avr_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A06 +-<br>
=C2=A0tests/boot-serial-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +<br>
=C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +<br>
=C2=A0tests/acceptance/machine_avr6.py |=C2=A0 11 +-<br>
=C2=A08 files changed, 701 insertions(+), 11 deletions(-)<br>
=C2=A0create mode 100644 hw/avr/atmega.h<br>
=C2=A0create mode 100644 hw/avr/arduino.c<br>
=C2=A0create mode 100644 hw/avr/atmega.c<br>
<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div></div></div>

--0000000000007e0b77059aefdcae--

