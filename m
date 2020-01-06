Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFA5C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F55F20848
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F55F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioNVy-00062J-8w
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 03:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ioNVN-0005Yr-0y
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ioNVL-0002Op-D6
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:12:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1ioNVL-0002Oh-8Y
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:12:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id q3so2088398otr.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 00:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dM6755OiAVxNNT/EGnm6GG38dRM8wbwsdCcOva50lrs=;
 b=sOjcBctJ1y0lMqWHvAcml43X9zG2KSEiqYAhqsiLgNC7y8TJrVEHtrMZqk914gHxGU
 vtRJ/BqERxjcYhSg5DnmUH3xIHlE7kbZw8VcIbdxWCeAJnKqNA1TKTI2JSHc0Ish0kCN
 rk61960UvUyBJVzqysWTe6zdfx8+EfAs1mevmdgu3Abpn76I0XOAZ/IBFbqCt7kpePU4
 +hWMVJzYOT1xPm66b7jWKIIyolwuMBih0YbilvHTHRwVoGkd7OGJQfWX9CYv5fVHLDaS
 quLjl1w2x3jcRvJawxmn/iYKzD8iLIzQS4HYtvI4qSjyA5hO3Mpi6F/fUxAG6VLHOgXL
 lVhQ==
X-Gm-Message-State: APjAAAU4f/tPhP2KcCXYcV+8SdSApeHTeWmx1OcUZgMTmaqkBl3KwSdF
 FSaejEGrKiFUSFhbSgfypGdVZdiYehyD30UYdRg=
X-Google-Smtp-Source: APXvYqwcqgRqO0qXcQwJ8Pd4YYfDxrBjR3JlJCO+GW3JjxN2hl8WLdecJWnREVA5bFyZERrdDquJZt6zjdqazPmx9A0=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr116794369otm.297.1578298370564; 
 Mon, 06 Jan 2020 00:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-5-geert+renesas@glider.be>
 <20191205210653.GA29969@bogus>
 <CAMuHMdXKPC7-XaezodwL1Dhvke6PUVSZEbvN-sm3Uh6T61qbhQ@mail.gmail.com>
 <CAL_JsqJLJPSYroX0mbBUpgWPV0oEvKEUNC-VZt4XFDF8tLuNFA@mail.gmail.com>
In-Reply-To: <CAL_JsqJLJPSYroX0mbBUpgWPV0oEvKEUNC-VZt4XFDF8tLuNFA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Jan 2020 09:12:39 +0100
Message-ID: <CAMuHMdXOJSZUDmn8aeTynN0TKCS5hJR+uMSinOmgbmA8YmsQjw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: gpio: Add gpio-repeater bindings
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
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
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Rob,

On Fri, Dec 6, 2019 at 4:04 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Dec 6, 2019 at 3:17 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Dec 5, 2019 at 10:06 PM Rob Herring <robh@kernel.org> wrote:
> > > On Wed, Nov 27, 2019 at 09:42:50AM +0100, Geert Uytterhoeven wrote:
> > > > Add Device Tree bindings for a GPIO repeater, with optional translation
> > > > of physical signal properties.  This is useful for describing explicitly
> > > > the presence of e.g. an inverter on a GPIO line, and was inspired by the
> > > > non-YAML gpio-inverter bindings by Harish Jenny K N
> > > > <harish_kandiga@mentor.com>[1].
> > > >
> > > > Note that this is different from a GPIO Nexus Node[2], which cannot do
> > > > physical signal property translation.
> > >
> > > It can't? Why not? The point of the passthru mask is to not do
> > > translation of flags, but without it you are always doing translation of
> > > cells.
> >
> > Thanks for pushing me deeper into nexuses!
> > You're right, you can map from one type to another.
> > However, you cannot handle the "double inversion" of an ACTIVE_LOW
> > signal with a physical inverter added:
> >
> >         nexus: led-nexus {
> >                 #gpio-cells = <2>;
> >                 gpio-map = <0 0 &gpio2 19 GPIO_ACTIVE_LOW>,     // inverted
> >                            <1 0 &gpio2 20 GPIO_ACTIVE_HIGH>,    // noninverted
> >                            <2 0 &gpio2 21 GPIO_ACTIVE_LOW>;     // inverted
> >                 gpio-map-mask = <3 0>;
> >                 // default gpio-map-pass-thru = <0 0>;
> >         };
> >
> >         leds {
> >                 compatible = "gpio-leds";
> >                 led6-inverted {
> >                         gpios = <&nexus 0 GPIO_ACTIVE_HIGH>;
> >                 };
> >                 led7-noninverted {
> >                         gpios = <&nexus 1 GPIO_ACTIVE_HIGH>;
> >                 };
> >                 led8-double-inverted {  // FAILS: still inverted
> >                         gpios = <&nexus 2 GPIO_ACTIVE_LOW>;
> >                 };
> >         };
> >
> > It "works" if the last entry in gpio-map is changed to GPIO_ACTIVE_HIGH.
> > Still, the consumer would see the final translated polarity, and not the
> > actual one it needs to program the consumer for.
>
> I'm not really following. Why isn't a double inversion just the same
> as no inversion?

Because the nexus can only mask and/or substitute bits.
It cannot do a XOR operation on the GPIO flags.

> > > > While an inverter can be described implicitly by exchanging the
> > > > GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags, this has its limitations.
> > > > Each GPIO line has only a single GPIO_ACTIVE_* flag, but applies to both
> > > > th provider and consumer sides:
> > > >   1. The GPIO provider (controller) looks at the flags to know the
> > > >      polarity, so it can translate between logical (active/not active)
> > > >      and physical (high/low) signal levels.
> > > >   2. While the signal polarity is usually fixed on the GPIO consumer
> > > >      side (e.g. an LED is tied to either the supply voltage or GND),
> > > >      it may be configurable on some devices, and both sides need to
> > > >      agree.  Hence the GPIO_ACTIVE_* flag as seen by the consumer must
> > > >      match the actual polarity.
> > > >      There exists a similar issue with interrupt flags, where both the
> > > >      interrupt controller and the device generating the interrupt need
> > > >      to agree, which breaks in the presence of a physical inverter not
> > > >      described in DT (see e.g. [3]).
> > >
> > > Adding an inverted flag as I've suggested would also solve this issue.
> >
> > As per your suggestion in "Re: [PATCH V4 2/2] gpio: inverter: document
> > the inverter bindings"?
> > https://lore.kernel.org/linux-devicetree/CAL_JsqLp___2O-naU+2PPQy0QmJX6+aN3hByz-OB9+qFvWgN9Q@mail.gmail.com/
> >
> > Oh, now I understand. I was misguided by Harish' interpretation
> > https://lore.kernel.org/linux-devicetree/dde73334-a26d-b53f-6b97-4101c1cdc185@mentor.com/
> > which assumed an "inverted" property, e.g.
> >
> >     inverted = /bits/ 8 <0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0>;
> >
> > But you actually meant a new GPIO_INVERTED flag, to be ORed into the 2nd
> > cell of a GPIO specifier? I.e. add to include/dt-bindings/gpio/gpio.h"
> >
> >     /* Bit 6 expresses the presence of a physical inverter */
> >     #define GPIO_INVERTED 64
>
> Exactly.

OK, makes sense.

> > We need to be very careful in defining to which side the GPIO_ACTIVE_*
> > applies to (consumer?), and which side the GPIO_INVERTED flag (provider?).
> > Still, this doesn't help if e.g. a FET is used instead of a push-pull
> > inverter, as the former needs translation of other flags (which the
> > nexus can do, the caveats above still applies, though).
>
> Yes. Historically the cells values are meaningful to the provider and
> opaque to the consumer. Standardized cell values changes that
> somewhat. I think we want the active flag to be from the provider's
> prospective because the provider always needs to know. The consumer
> often doesn't need to know. That also means things work without the
> GPIO_INVERTED flag if the consumer doesn't care which is what we have
> today already and we can't go back in time.
>
>
> > Same for adding IRQ_TYPE_INVERTED.
>
> I suppose so, yes.
>
> > Related issue: how to handle physical inverters on SPI chip select lines,
> > if the SPI slave can be configured for both polarities?
>
> Good question. Perhaps in a different way because we have to handle
> both h/w controlled and gpio chip selects.
>
> However, how would one configure the polarity in the device in the
> first place? You have to assert the CS first to give a command to
> reprogram it.

That's indeed true for a simple SPI slave.
But if it is a smarter device (e.g. a generic micro controller), it may use the
system's DTB to configure itself.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

