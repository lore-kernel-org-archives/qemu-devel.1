Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4331C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89484215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89484215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioNg4-0008VU-LE
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 03:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ioNfW-00085Z-62
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ioNfU-0008Qu-V1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:23:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1ioNfU-0008Q6-QN
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:23:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so48873856otp.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 00:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHzx9oIm8dg3P3nAkMNDZNXQcdUHwPZVhWt4WLorDDs=;
 b=d23YCJG3mKY8jLf7+enJk3baorlEhwNY2b40UFjG++dz0TU0KsLRAN5lwD9UHajgMY
 cOBIvbC5mvi/Jhz2A4addZf2S72enTxZD3IPqRzHYghOa5Jb4HBAYa7WgMLsUW3Vi3LZ
 nHNenQoKBKBTf+hnraHCS8nuzTI5nqZ8vi038kuBqHL1fKV3SZdAGT+g9Y2GWMgcUSvJ
 L62JchNVSmkt+dRcSaOSIA+vrTlOBk/oHveAqu67hH0DKyi1FP3BF410gf70Eo9c0Po/
 0bPJitJMJJ5vSY3ZkVYXbke7fSa+tAH3+5y1lEAl4fqHjT2l1nUNBs0iFe621i4fVi2H
 jZ0w==
X-Gm-Message-State: APjAAAWfZpWCv3DL1pXFQKq7O/Mz/RRC1Y07xdCj4DzDVXC2oFlynAAT
 grt1JkF4AVRNotguDQyDtgCPHbNc4SzuvwCHhpQ=
X-Google-Smtp-Source: APXvYqxZfWCvC2DArnr5YYOlNTu+kHHp6uV+60W8n8M+iR8ajrYCZBArT5eRAfUPNTXNYH8DRrkE60PZKONNJiX/Ig4=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr116835949otm.297.1578298999867; 
 Mon, 06 Jan 2020 00:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
 <CACRpkdaW7nmpE99FAvBDBTmkTZOTQ5WdM=JbMzBTLk7cbLRXPw@mail.gmail.com>
 <CAMuHMdVbk5S__8OK-zNXmiW66=WVA8Jzyc=hUvf_hJSU=u9TFg@mail.gmail.com>
 <CACRpkda8QD_tDA=YVDRNVnHd8QHs-yHBTzZuJHsnocgMdxv9cA@mail.gmail.com>
In-Reply-To: <CACRpkda8QD_tDA=YVDRNVnHd8QHs-yHBTzZuJHsnocgMdxv9cA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Jan 2020 09:23:08 +0100
Message-ID: <CAMuHMdUGGcjoX8TDDS5qGLtJZxizUK=BpasSQK3t1K-dhEgZCg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.68
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Linus,

On Sat, Jan 4, 2020 at 1:38 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> Sorry for slowness... christmas.

Np. Happy New Year!

> On Thu, Dec 12, 2019 at 4:24 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Dec 12, 2019 at 3:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > > +         This can serve the following purposes:
> > > > +           1. Assign a collection of GPIOs to a user, or export them to a
> > > > +              virtual machine,
> > >
> > > This is ambiguous. What is a "user"? A process calling from
> > > userspace? A device tree node?
> >
> > A user is an entity with a UID, typically listed in /etc/passwd.
> > This is similar to letting some, not all, people on the machine access
> > the CD-ROM drive.
>
> Ah I get it. Maybe we can say "assign permissions for a collection
> of GPIOs to a user".

OK

> > > I would write "assign a collection of GPIO lines from any lines on
> > > existing physical GPIO chips to form a new virtual GPIO chip"
> > >
> > > That should be to the point, right?
> >
> > Yes, that's WHAT it does. The WHY is the granular access control.
>
> So I guess we can write both?

OK.

> > > > +           3. Provide a generic driver for a GPIO-operated device, to be
> > > > +               controlled from userspace using the GPIO chardev interface.
> > >
> > > I don't understand this, it needs to be elaborated. What is meant
> > > by a "GPIO-operated device" in this context? Example?
> >
> > E.g. a motor. Or a door opener.
> >
> >         door-opener {
> >                 compatible = "mydoor,opener";
> >
> >                 gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> >         };
> >
> > You don't need a full-featured kernel driver for that, so just bind the
> > gpio-aggregator to the door-opener, and control it through libgpiod.
>
> Yep it's a perfect industrial control example, I get it.
>
> Maybe we should blurb something about industrial control?

OK.

> The rest I think we cleared out else I will see it when I review again.

The remaining discussion point is "GPIO Repeater in Device Tree", i.e.
the GPIO inverter usecase, which might be solved better by adding a
GPIO_INVERTED flag.

Shall I rip that out, incorporate review comments, and report?

Thanks!



--
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

