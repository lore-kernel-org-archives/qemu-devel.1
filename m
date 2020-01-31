Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1756CC33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 03:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1C5206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 03:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1C5206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixMhg-0002zk-03
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 22:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixMh0-0002U4-Fl
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 22:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixMgx-0004XU-LZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 22:10:02 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ixMgx-0004XB-Hx
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 22:09:59 -0500
Received: by mail-yw1-f65.google.com with SMTP id l22so3324512ywc.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 19:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0h6IgEdEtMmYyx0iKvyy2g75DudKmWYfqSb4/kcJYP4=;
 b=B07uMoyMGXl55lJ2Jd1NrcOstm2MmkxOjNAMqU+mxritR5fsHS5dJcBxTgDmiYUege
 OXPU70EzyVV8s9xz9HQkvIs/NXt6H4bYsOI7LsPXMllwXh3UjlDfxX+18Wj7fA3059r0
 vBb3mnTpSb2WzGudcO3TwKq61XOZ9rZmseyr0YpLLeLrX3rTcJpnR4xuFKmLgqMhtnF6
 zjnz24p9/Yc4F3/gaAuKvNk7Cl3JCFLyaSwaXdcO+h3TicTnZHNxt/2ymbxBOA9Oc7Fa
 2UJCZpxNvmzfg6TK8tBpAcOECmCksdMvjZTZ3+8abmPNO27/iNisn46YQQGsgYLHoKUt
 TmWg==
X-Gm-Message-State: APjAAAV0rMJlnIEmWPON8Kx9sZuf4QJSqY3I6KQlJtbC4DvM7+i2BTxf
 ZF0/8TPdG08N+xVk9j5vnOY0d8zDyNJ7FTSW28E=
X-Google-Smtp-Source: APXvYqwEPLURj8Lj1z0gOxYQeYrkMULSVhOAV6+rIBlFhs2/oCgUVcxiU+ofJHkgcQGkzxH/uZpEjTet0x0NoNbh/uw=
X-Received: by 2002:a0d:c3c4:: with SMTP id f187mr6416575ywd.201.1580440198712; 
 Thu, 30 Jan 2020 19:09:58 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-25-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=j3b6Gfo4K56=tXc9jbXAy3fou5Dsxq3ns9C89mpuPXxA@mail.gmail.com>
In-Reply-To: <CAL1e-=j3b6Gfo4K56=tXc9jbXAy3fou5Dsxq3ns9C89mpuPXxA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 31 Jan 2020 04:09:47 +0100
Message-ID: <CAAdtpL6F=qbWT7keQxHtacndN+JUM32tyd9vW0ZEEMYYN=a=3g@mail.gmail.com>
Subject: Re: [PATCH rc4 24/29] hw/avr: Add some ATmega microcontrollers
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.65
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

Cc'ing Thomas & Daniel who are not lawyers but tried to explain me few
times how licensing works.

On Fri, Jan 31, 2020 at 2:56 AM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> On Fri, Jan 31, 2020 at 1:03 AM Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> >
> > From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >
> > Add some AVR microcontrollers from the ATmega family:
> >
> >   - middle range: ATmega168 and ATmega328
> >   - high range: ATmega1280 and ATmega2560
> >
> > For product comparison:
> >   https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATmeg=
a328P
> >   https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATmeg=
a2560
> >
> > Datasheets:
> >   http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-1=
68A-PA-328-P-DS-DS40002061A.pdf
> >   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-=
Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf
> >
> > [AM: Remove word 'Atmel' from filenames and all elements of code]
> > Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> > ---
> >  hw/avr/Kconfig       |   5 +
> >  hw/avr/Makefile.objs |   1 +
> >  hw/avr/atmega.c      | 470 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  hw/avr/atmega.h      |  48 ++++++
> >  4 files changed, 524 insertions(+)
> >  create mode 100644 hw/avr/Kconfig
> >  create mode 100644 hw/avr/atmega.c
> >  create mode 100644 hw/avr/atmega.h
> >
> > diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> > new file mode 100644
> > index 0000000..9e6527e
> > --- /dev/null
> > +++ b/hw/avr/Kconfig
> > @@ -0,0 +1,5 @@
> > +config AVR_ATMEGA_MCU
> > +    bool
> > +    select AVR_TIMER16
> > +    select AVR_USART
> > +    select AVR_POWER
> > diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> > index 123f174..af0fdde 100644
> > --- a/hw/avr/Makefile.objs
> > +++ b/hw/avr/Makefile.objs
> > @@ -1 +1,2 @@
> >  obj-y +=3D boot.o
> > +obj-$(CONFIG_AVR_ATMEGA_MCU) +=3D atmega.o
> > diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> > new file mode 100644
> > index 0000000..8cdf28b
> > --- /dev/null
> > +++ b/hw/avr/atmega.c
> > @@ -0,0 +1,470 @@
> > +/*
> > + * QEMU ATmega MCU
> > + *
> > + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> > + *
> > + * This work is licensed under the terms of the GNU GPLv2 or later.
> > + * See the COPYING file in the top-level directory.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
>
> Philippe,
>
> Michael and I already agreed at some moment that the whole target AVR
> should have harmonized licenses, and Sarrah agreed to change her
> license to achieve this. Do you agree to harmonize your licenses with
> the rest of the project? (This would mean changing the preable, but of
> course you remain copyright carrier as is now.)

What license do you want to use? I always use "GPLv2 or later" with
QEMU, mostly following what the others do.

Per https://wiki.qemu.org/License:

  Source files with no licensing information are released under the
GNU General Public License, version 2 or (at your option) any later
version.

Reading about licensing is not fun :(

>
> Thanks,
> Aleksandar

