Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B5C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF6224125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF6224125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48Gx-0005Z5-4y
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1j48FK-0003zG-TU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:09:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1j48FJ-0000Ll-Ra
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:09:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1j48FI-0000JT-Q8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:09:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so21223705oih.9
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4zbrnNvTNHgXxwjMJnfhT5sGHXVeYA3py+fC4nnQX1g=;
 b=jrOW6pUToU6TNrcDWyxhy0nsi3i9l+JLlr9P6ROo4FPwUF9TPJcO5w//QSxf038rAi
 1R3uVahUXA9hPFt05jN+Und5Ynt+aw1PXWBNKu8a8X1+lmI6ZKCcP61vRsjF1bH3na6J
 0xU/fipLEW8o5My6NBrMwqAtZLDHu0qZZkzAfl7p33L4WSS+EYNEhW3lq2y0ywiMGOf4
 8Z8ttVQULbed19UzXfK7F7rUB1row4JtQgFWSvIurvgUBf4g6nTX1ac/OvLyk68gbcUk
 wkdt4OIeUOsOgMt13eJM/ytQVlNhci7ZEoZvh4s5HUUDbr3rZuFMcLw2W9JNuLIpcT/W
 kc4g==
X-Gm-Message-State: APjAAAUblcjYrwXXA8uuA4o+gg71DtY4g1vDQb4TSKHRRocCqGupz6fg
 aTFdrNiPvtl2fFyAzleCLMCQ5BcKGngWIbl3jIM=
X-Google-Smtp-Source: APXvYqwnKTCIB9GTLLpEL5W7g+LauaFKN7iZKQPh2++RZaJoaT+SssBYOvEoCXI/Jb080pGI7GySD9qCX6q6Z+PF39M=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr2308514oia.102.1582052963942; 
 Tue, 18 Feb 2020 11:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-5-geert+renesas@glider.be>
 <e2530fff-a17c-ae90-ba92-360b828582da@infradead.org>
In-Reply-To: <e2530fff-a17c-ae90-ba92-360b828582da@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2020 20:09:12 +0100
Message-ID: <CAMuHMdU9=vgO6ohoYTQMGjoFzhRy=4hYGjVyRsTK2uoNsU08XQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] docs: gpio: Add GPIO Aggregator documentation
To: Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.193
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
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
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

Thanks for the hint!

> > +             Example: Instantiate a new GPIO aggregator by aggregating GPIO
> > +             19 of "e6052000.gpio" and GPIOs 20-21 of "gpiochip2" into a new
> > +             gpio_chip:
> > +
> > +             .. code-block:: bash
> > +
> > +                 echo 'e6052000.gpio 19 gpiochip2 20-21' > new_device
> > +
>
> Does the above command tell the user that the new device is named
> "gpio-aggregator.0", as used below?

Yes, it will be printed through the kernel log, cfr. the sample session in
the cover letter.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

