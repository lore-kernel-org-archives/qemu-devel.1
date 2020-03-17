Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F771C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C6320658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C6320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEATw-0003eb-8R
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jEASk-0002oN-0O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jEASi-00055n-K0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:32:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jEASi-00051o-Bq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:32:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id 39so5813306otu.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yETyFwQ9Htl1KGbLhFFP34JxwM+8all8kt5P2BYv2cs=;
 b=hVK7KoE6iXOzFo8WLvBB9WDpSNA5Tl3ClCm1Y5/kWAQr55b6wwk8+m0+C8ss9ntGwK
 uiWnqpmdaAUPPW/rl642X1K/kYUfXmRKDmVfiqWR54lkp8PRrS6c7++xvmkCIPSl96Db
 nMVFLYYgXkCSKe7KG8oa8lrrI81ASRouCY/qkeXaJSL1TINTLWfGFRiLoL60fLAi/u79
 ryCW+NIOS5jJZa/5V4PAvrBYsyElQld52MXVGgKDm1pnpFEdG6Qxm41ADkZubTlNYTKn
 OaYA5ap7xJPjfOb6b8bOgak7fSvPOyI8uOVBCIhJiWXHaauurnpiRmnMECEb07XJZpij
 iaFA==
X-Gm-Message-State: ANhLgQ1Ht5QFdnAL4JMhOwlolRMqiP2+2k4Gh43u56Twcmh+gzfvlZp1
 EEc9oa0aoQs6Mo9tgmu0CmnKBd/pX1fqLAj1i+A=
X-Google-Smtp-Source: ADFU+vvQTAgcQxsOpqflnHCgzX47yo6RoUnPbT1ipGmHWNBjNYcXjsyzilFOOHau23AhLSA/+Thi1PZ5zI/u0X1X+7w=
X-Received: by 2002:a9d:1708:: with SMTP id i8mr3337224ota.250.1584444762958; 
 Tue, 17 Mar 2020 04:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-4-geert+renesas@glider.be>
In-Reply-To: <20200218151812.7816-4-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2020 12:32:31 +0100
Message-ID: <CAMuHMdWXJKdD7j6QiRb4fL+fFsyDKpc7aGK-nER=CZd7bxGyPg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] gpio: Add GPIO Aggregator
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.66
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
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> GPIO controllers are exported to userspace using /dev/gpiochip*
> character devices.  Access control to these devices is provided by
> standard UNIX file system permissions, on an all-or-nothing basis:
> either a GPIO controller is accessible for a user, or it is not.
> Currently no mechanism exists to control access to individual GPIOs.
>
> Hence add a GPIO driver to aggregate existing GPIOs, and expose them as
> a new gpiochip.
>
> This supports the following use cases:
>   - Aggregating GPIOs using Sysfs
>     This is useful for implementing access control, and assigning a set
>     of GPIOs to a specific user or virtual machine.
>   - Generic GPIO Driver
>     This is useful for industrial control, where it can provide
>     userspace access to a simple GPIO-operated device described in DT,
>     cfr. e.g. spidev for SPI-operated devices.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ b/drivers/gpio/gpio-aggregator.c

> +static int gpio_fwd_set_config(struct gpio_chip *chip, unsigned int offset,
> +                              unsigned long config)
> +{
> +       struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
> +
> +       chip = fwd->descs[offset]->gdev->chip;
> +       if (chip->set_config)

-       chip = fwd->descs[offset]->gdev->chip;
-       if (chip->set_config)
+       chip = gpiod_to_chip(fwd->descs[offset]);
+       if (chip && chip->set_config)

> +               return chip->set_config(chip, offset, config);

This is not correct: offset should be translated, too, i.e.

    offset = gpio_chip_hwgpio(fwd->descs[offset]);

Which adds a new dependency on "gpiolib.h"...

Is there a better alternative, than providing a public gpiod_set_config()
helper?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

