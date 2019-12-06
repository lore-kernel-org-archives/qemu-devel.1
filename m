Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB115C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14EB2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14EB2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGct-0000m4-CH
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1idFPS-0005F7-Sf
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1idFPR-0002O1-3v
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:20:46 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1idFPQ-0002Lz-V0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:20:45 -0500
Received: by mail-yb1-f193.google.com with SMTP id v15so3049057ybp.13
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LnYDT3hI/k51rxu2RaEtNc8OwzQHfHd+q89Ne01SQkk=;
 b=CZ8U7awdq9s4afc0rSq8Q5+Yk8Zvyy61dS+6ce72MCC9ykyFg47e2Hf++3Guh74JbD
 PqMr9IsFFPdp6nZugL8zLcD/w6xX2TBrGbCA8cae/wkIAV6peEm63JDxID8vz4gPiUjA
 pLXyYqb7iIXtQfmr3pwYdQAZ0BTZ3jugEhNwhp3qJiI95owG/jeiCjnJaaIrTGkHjbaJ
 1fMR+kRt9Igi8Q8HsJupuIOyuL/tofUdxWY+lJ2N9qBh+OYaaEJfqFpACiSoQEAsot+X
 0d3PgJV5nMqIRwuAdb4JoTuxNacQipLM8GKxPvXNMHA71ZjQOvr6Yjo3BxpmeiKMU7Ze
 wrqw==
X-Gm-Message-State: APjAAAVi8xWckQliTkAHimvYosvkYh8iqA1ze+3ODpp1w/DY2LmtZvwk
 DOvcp94SfwlUmJCVDzqfdWWl6INv0Gt69es9DE/6vDm3
X-Google-Smtp-Source: APXvYqywT7RKZxy4+aQ3yqIAX1ukNQgZt1Pm6duFwv33bTsc5FszW5c30r7KI+ch+vUt5vv52/IvfRSxlMnY6lawJl4=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr5241089otm.297.1575623875215; 
 Fri, 06 Dec 2019 01:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-5-geert+renesas@glider.be>
 <20191205210653.GA29969@bogus>
In-Reply-To: <20191205210653.GA29969@bogus>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Dec 2019 10:17:43 +0100
Message-ID: <CAMuHMdXKPC7-XaezodwL1Dhvke6PUVSZEbvN-sm3Uh6T61qbhQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: gpio: Add gpio-repeater bindings
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.193
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

On Thu, Dec 5, 2019 at 10:06 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Nov 27, 2019 at 09:42:50AM +0100, Geert Uytterhoeven wrote:
> > Add Device Tree bindings for a GPIO repeater, with optional translation
> > of physical signal properties.  This is useful for describing explicitly
> > the presence of e.g. an inverter on a GPIO line, and was inspired by the
> > non-YAML gpio-inverter bindings by Harish Jenny K N
> > <harish_kandiga@mentor.com>[1].
> >
> > Note that this is different from a GPIO Nexus Node[2], which cannot do
> > physical signal property translation.
>
> It can't? Why not? The point of the passthru mask is to not do
> translation of flags, but without it you are always doing translation of
> cells.

Thanks for pushing me deeper into nexuses!
You're right, you can map from one type to another.
However, you cannot handle the "double inversion" of an ACTIVE_LOW
signal with a physical inverter added:

        nexus: led-nexus {
                #gpio-cells = <2>;
                gpio-map = <0 0 &gpio2 19 GPIO_ACTIVE_LOW>,     // inverted
                           <1 0 &gpio2 20 GPIO_ACTIVE_HIGH>,    // noninverted
                           <2 0 &gpio2 21 GPIO_ACTIVE_LOW>;     // inverted
                gpio-map-mask = <3 0>;
                // default gpio-map-pass-thru = <0 0>;
        };

        leds {
                compatible = "gpio-leds";
                led6-inverted {
                        gpios = <&nexus 0 GPIO_ACTIVE_HIGH>;
                };
                led7-noninverted {
                        gpios = <&nexus 1 GPIO_ACTIVE_HIGH>;
                };
                led8-double-inverted {  // FAILS: still inverted
                        gpios = <&nexus 2 GPIO_ACTIVE_LOW>;
                };
        };

It "works" if the last entry in gpio-map is changed to GPIO_ACTIVE_HIGH.
Still, the consumer would see the final translated polarity, and not the
actual one it needs to program the consumer for.

> > While an inverter can be described implicitly by exchanging the
> > GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags, this has its limitations.
> > Each GPIO line has only a single GPIO_ACTIVE_* flag, but applies to both
> > th provider and consumer sides:
> >   1. The GPIO provider (controller) looks at the flags to know the
> >      polarity, so it can translate between logical (active/not active)
> >      and physical (high/low) signal levels.
> >   2. While the signal polarity is usually fixed on the GPIO consumer
> >      side (e.g. an LED is tied to either the supply voltage or GND),
> >      it may be configurable on some devices, and both sides need to
> >      agree.  Hence the GPIO_ACTIVE_* flag as seen by the consumer must
> >      match the actual polarity.
> >      There exists a similar issue with interrupt flags, where both the
> >      interrupt controller and the device generating the interrupt need
> >      to agree, which breaks in the presence of a physical inverter not
> >      described in DT (see e.g. [3]).
>
> Adding an inverted flag as I've suggested would also solve this issue.

As per your suggestion in "Re: [PATCH V4 2/2] gpio: inverter: document
the inverter bindings"?
https://lore.kernel.org/linux-devicetree/CAL_JsqLp___2O-naU+2PPQy0QmJX6+aN3hByz-OB9+qFvWgN9Q@mail.gmail.com/

Oh, now I understand. I was misguided by Harish' interpretation
https://lore.kernel.org/linux-devicetree/dde73334-a26d-b53f-6b97-4101c1cdc185@mentor.com/
which assumed an "inverted" property, e.g.

    inverted = /bits/ 8 <0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0>;

But you actually meant a new GPIO_INVERTED flag, to be ORed into the 2nd
cell of a GPIO specifier? I.e. add to include/dt-bindings/gpio/gpio.h"

    /* Bit 6 expresses the presence of a physical inverter */
    #define GPIO_INVERTED 64

We need to be very careful in defining to which side the GPIO_ACTIVE_*
applies to (consumer?), and which side the GPIO_INVERTED flag (provider?).
Still, this doesn't help if e.g. a FET is used instead of a push-pull
inverter, as the former needs translation of other flags (which the
nexus can do, the caveats above still applies, though).

Same for adding IRQ_TYPE_INVERTED.

Related issue: how to handle physical inverters on SPI chip select lines,
if the SPI slave can be configured for both polarities?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

