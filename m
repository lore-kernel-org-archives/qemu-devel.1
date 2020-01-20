Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED851C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C630A2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C630A2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itTSp-00070C-VB
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1itTRi-0005zM-0W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1itTRe-0004N6-A6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:34:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1itTRe-0004Md-5s
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:34:06 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so27969278oin.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 01:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4UGZULGX+YbThMmtUsP+6rz+ppDz5uP2ldQfl/P5Icg=;
 b=Q2YCy9oGlEIzyhYbgoI6KlBMwvQI3Hso1V9hWMueWpDncDosKbI7enBTZH9k7jR0p+
 oQ+L5k+U+ZjywTWeal7t6UAVq2GrGYM+0/RzWeOjYkh3DXDr9Y1lrXSRsxPIbp5EZx0u
 P0Qkfcd5QYIn8SdfDF33G1U+ElU/YuqIpWdN1/AMKVm8V6aMxdgxdAQhieikc1XpwQwr
 Gv7+e8DUID7X8O+j9lTn/GhPeXkKEhdehJTT5myEaE8CpmfB1E5kzbOXxhL6L4K/1oY+
 t47jKUGs8o9uDeKjGEtTM5RBp9jSLAjwe2LudgTSGGD5CFktuC3ndZYqooy574fy3Cwa
 xEmg==
X-Gm-Message-State: APjAAAWW6d6mG242dFbL8H2Zb0jmW1hWnySJkLYHaLciqNfNZllkNZDx
 KZ87FHREReS3hbEsB2uqFCR/h7i42B3WdJWXaFI=
X-Google-Smtp-Source: APXvYqzKSRFvw6ji0gpORenZnjRNgTgsQRPZg2pYUM0CIPBoLJXTQJmTGSvG1PbarmgxudUhQ+JfoPFk+YrYJBaAPTE=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr11682717oia.148.1579512844618; 
 Mon, 20 Jan 2020 01:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20200118014632.GA14644@lxhi-065.adit-jv.com>
In-Reply-To: <20200118014632.GA14644@lxhi-065.adit-jv.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Jan 2020 10:33:53 +0100
Message-ID: <CAMuHMdUUc17n0TxOrtQNby+ZiHDpz-aEh-ncnkz50vcwQe6z6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] gpio: Add GPIO Aggregator/Repeater
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Eugeniu Rosca <roscaeugeniu@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eugeniu,

On Sat, Jan 18, 2020 at 2:46 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> On Wed, Nov 27, 2019 at 09:42:46AM +0100, Geert Uytterhoeven wrote:
> >   - Create aggregators:
> >
> >     $ echo e6052000.gpio 19,20 \
> >         > /sys/bus/platform/drivers/gpio-aggregator/new_device

> The only unexpected thing is seeing below messages (where gpiochip99 and
> gpiochip22 are inexisting gpiochip names, mistakenly provided on command
> line prior to passing the correct name):
>
> root@rcar-gen3:~# echo gpiochip6 12-13 > /sys/bus/platform/drivers/gpio-aggregator/new_device
> [  915.572905] gpio-aggregator gpio-aggregator.0: cannot find GPIO chip gpiochip99, deferring
> [  915.584224] gpio-aggregator gpio-aggregator.2: cannot find GPIO chip gpiochip99, deferring
> [  915.865281] gpio-aggregator gpio-aggregator.29: cannot find GPIO chip gpiochip22, deferring
>
> Obviously, in the above case, due to a typo in the names, the gpio
> chips will never be found, no matter how long gpio-aggregator defers

Indeed, that is expected behavior: you have created platform devices
referring to resources that are not available.

> their probing. Unfortunately, the driver will continuously emit those
> messages, upon each successfully created/aggregated gpiochip. I built

That is expected behavior, too: every time the driver core manages to
bind a device to a driver, it will retry all previously deferred probes,
in the hope they can be satisfied by the just bound device.

Note that you can destroy these bogus devices, using e.g.

    # echo gpio-aggregator.0 > \
    /sys/bus/platform/drivers/gpio-aggregator/delete_device

> gpio-aggregator as a loadable module, if that's relevant.

Modular or non-modular shouldn't matter w.r.t. this behavior.
Although unloading the module should get rid of the cruft.

> Another comment is that, while the series _does_ allow specifying
> gpio lines in the DTS (this would require a common compatible string
> in gpio_aggregator_dt_ids[] and in the DTS node) and while those lines
> are indeed exposed to userspace, based on my testing, these same gpio
> lines are marked as "used/reserved" by the kernel. This means that
> operating on those gpio pins from userspace will not be possible.
> For instance, gpioget/gpioset return "Device or resource busy":
>
> gpioget: error reading GPIO values: Device or resource busy
> gpioset: error setting the GPIO line values: Device or resource busy
>
> I guess Harish will be unhappy about that, as his expectation was that
> upon merging gpio-aggregator with gpio-inverter, he will be able to
> describe GPIO polarity and names in DTS without "hogging" the pins.
> Perhaps this can be supplemented via an add-on patch later on?

When aggregating GPIO lines, the original GPIO lines are indeed marked
used/reserved, so you cannot use them from userspace.
However, you are expected to use them through the newly created virtual
gpiochip representing the aggregated GPIO lines.

You can try this using the "door" example in
Documentation/admin-guide/gpio/gpio-aggregator.rst, after replacing
gpio2 {19,20} by gpio6 {12,13} to suit your H3ULCB.

> For the whole series (leaving the above findings to your discretion):
>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

