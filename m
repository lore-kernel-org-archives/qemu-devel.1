Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C505C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7D5208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7D5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BH2-0004ju-FR
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1j5BFo-0003P6-3Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1j5BFm-00016r-Rb
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:34:16 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1j5BFm-00016P-NQ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:34:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so2155116oic.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q0P9tu6IOsuIOQ9cj+JFMIkV9AXW3CYPDjGH2uYPm8M=;
 b=VgkQ5FKw5T6havLsFdbDwyp98hOH1GPW0meFiOsFFtOiHyyzBQyJDVvuUFqQuE+xzc
 rQsMqIRCqWi3co+Ec8GQ+7HAOK41LZOV1wkdmEPjpmGfOaMdHrFI+eo3lgXppu0BDOpo
 Kv+YVQTyKhmHJTRXd66v4vzhDCySSA7LSuJdwiUuulZvA+0kAHWVwgE+7DB3YBXHeJLp
 r5HpTTTllU2JHTu8jlFxSDICne55mKme4t06JzxFYM5jHANl+Gcg8mzP90O99Dwtf8ql
 78vAqtaXfCZsXxv7rdVBGVEd9Yw16vXlsFEWA3xFB3zfP+uYlqf5ZO7+Q7I8qNobj46J
 Di+Q==
X-Gm-Message-State: APjAAAXdhGFFIyOq4shFaU4sOwfQVMmb+Uba+xcnkmDeWVKuH8ff3fk8
 r/2fsIp9ge9FipBJdY8bJyIkhLjewZTWaUKx02Y=
X-Google-Smtp-Source: APXvYqzPNoAH+zVsto1+IiOMGfW8xsdQo0YD/gttJz8Iqi71pUo1KidDfXV90s/3JMzKKHdE/I36dl+GbJbfTmLaY4E=
X-Received: by 2002:aca:c4d2:: with SMTP id u201mr2773907oif.54.1582302853428; 
 Fri, 21 Feb 2020 08:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-5-geert+renesas@glider.be>
 <e2530fff-a17c-ae90-ba92-360b828582da@infradead.org>
In-Reply-To: <e2530fff-a17c-ae90-ba92-360b828582da@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Feb 2020 17:34:02 +0100
Message-ID: <CAMuHMdUFV0nbfrpxY60av2x+UUN62wDiVLbcEG83133aqfFcUQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] docs: gpio: Add GPIO Aggregator documentation
To: Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.196
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
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Randy,

On Tue, Feb 18, 2020 at 7:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/18/20 7:18 AM, Geert Uytterhoeven wrote:
> > Document the GPIO Aggregator, and the two typical use-cases.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- /dev/null
> > +++ b/Documentation/admin-guide/gpio/gpio-aggregator.rst
> > @@ -0,0 +1,102 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +GPIO Aggregator
> > +===============
> > +
> > +The GPIO Aggregator allows to aggregate GPIOs, and expose them as a new
>
> "allows" really wants an object following the verb [although the kernel sources
> and docs have many cases of it not having an object].  Something like
>
>                        allows {you, one, someone, users, a user} to aggregate

Changing to:

    provides a mechanism to aggregate GPIOs

> > +gpio_chip.  This supports the following use cases.
> > +
> > +
> > +Aggregating GPIOs using Sysfs
> > +-----------------------------
> > +
> > +GPIO controllers are exported to userspace using /dev/gpiochip* character
> > +devices.  Access control to these devices is provided by standard UNIX file
> > +system permissions, on an all-or-nothing basis: either a GPIO controller is
> > +accessible for a user, or it is not.
> > +
> > +The GPIO Aggregator allows access control for individual GPIOs, by aggregating

Changing to:

    provides access control for a set of one or more GPIOs

> > +them into a new gpio_chip, which can be assigned to a group or user using
> > +standard UNIX file ownership and permissions.  Furthermore, this simplifies and
> > +hardens exporting GPIOs to a virtual machine, as the VM can just grab the full
> > +GPIO controller, and no longer needs to care about which GPIOs to grab and
> > +which not, reducing the attack surface.

> > +Generic GPIO Driver
> > +-------------------
> > +
> > +The GPIO Aggregator can also be used as a generic driver for a simple
> > +GPIO-operated device described in DT, without a dedicated in-kernel driver.
> > +This is useful in industrial control, and is not unlike e.g. spidev, which
> > +allows to communicate with an SPI device from userspace.
>
>    allows {choose an object} to communicate

Changing to:

    allows the user to communicate

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

