Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E24C33CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEB92080D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEB92080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXzI-0000Ew-4k
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ipXy9-0007MY-QG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ipXy8-0007pY-IA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:35:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1ipXy8-0007lO-CP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:35:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so5907149qke.10
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 05:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vK5UxuBrViNaXxuMZEsGhiSGSEMvZsYzv98RipTZfGg=;
 b=L/UaqJvOYzervbmDMg/JgGQJppjDRBoFAMtCtnyw/qnE6fQt/3YsAopnov7RkdQjdc
 zyUPF1Bn26MvXMZIJtcNEO8uFS2Y28K7Omn6Jhb0YQrBjhWDhFuHFNjob2HjK8Judral
 lADzlxVpTLzHaZ/bgp6h1QGckcGYR8niEotvKp1TPWnPeDvkfju/htJCacgBGO7Gt9xP
 oBO0dtQbbA6TqF1lrX/ESh3r2YtDEBI4hmh6Qykq7x9tRNbneOJ1Q1GT3RVe09edPtIW
 zihNU0WHqKjt5e0qwmpC3JcMyDhIJcQu/Rtzoj6d6YUB1t9pKZjWYd4+RJmvfGsnqNh5
 mjOw==
X-Gm-Message-State: APjAAAVBZHTh3iwVecqu6pfEvOn8FmUNGJkElfNnbJ4ae0LC1m3EJuDF
 n6xW2NlMNd7dOdEk1uatN1ntSzeQEv0YOPpuHj4=
X-Google-Smtp-Source: APXvYqyRXgYk8j5kdfM4/WS8TEs831mjz2YcxqkRufdK/tyDKS85bDKPS8c3TecGMtuEwZvySvABfGqCivPuJ6qeC0Q=
X-Received: by 2002:a05:620a:134f:: with SMTP id
 c15mr9195003qkl.115.1578576923178; 
 Thu, 09 Jan 2020 05:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be> <20191203105103.GA20470@x230>
In-Reply-To: <20191203105103.GA20470@x230>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jan 2020 14:35:10 +0100
Message-ID: <CAMuHMdVLaGt5GTXzUbUHrBHn5q--t3JfxO6P_j0GnnhixV+UfA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.196
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
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eugeniu,

On Tue, Dec 3, 2019 at 11:51 AM Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
> On Wed, Nov 27, 2019 at 09:42:51AM +0100, Geert Uytterhoeven wrote:
> > +static int gpio_aggregator_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct gpio_desc **descs;
> > +     struct gpiochip_fwd *fwd;
> > +     int i, n;
>
> FWIW/FTR, doing some blind creation and deletion of gpio aggregator
> chips [1] on R-Car H3ULCB overnight, kmemleak reported once [2]. Not
> sure this is something 100% reproducible.
>
> [1] while true; do \
>    echo e6055400.gpio 12,13 > /sys/bus/platform/drivers/gpio-aggregator/new_device; \
>    echo gpio-aggregator.0 > /sys/bus/platform/drivers/gpio-aggregator/delete_device; \
>    done
>
> [2] unreferenced object 0xffff0006d2c2e000 (size 128):
>   comm "kworker/3:1", pid 55, jiffies 4294676978 (age 38546.676s)
>   hex dump (first 32 bytes):
>     00 d9 d2 d3 06 00 ff ff 0c 00 e0 0f ff ff ff ff  ................
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000a8e18c13>] slab_post_alloc_hook+0x8c/0x94
>     [<000000006f419a4f>] __kmalloc+0x170/0x218
>     [<0000000060d185ea>] kobj_map+0x78/0x1c0
>     [<00000000c96645f3>] cdev_add+0x68/0x94
>     [<00000000a7a5a8ac>] cdev_device_add+0x74/0x90
>     [<00000000497871d3>] gpiochip_setup_dev+0x84/0x1f0
>     [<00000000b993f95f>] gpiochip_add_data_with_key+0xbcc/0x11f0
>     [<00000000fd728c0e>] devm_gpiochip_add_data+0x60/0xa8
>     [<00000000442e34c1>] gpio_aggregator_probe+0x210/0x3c8
>     [<00000000076e13fb>] platform_drv_probe+0x70/0xe4
>     [<00000000de84b58b>] really_probe+0x2d8/0x434
>     [<00000000c95c9784>] driver_probe_device+0x15c/0x16c
>     [<00000000afb7dd4f>] __device_attach_driver+0xdc/0x120
>     [<00000000efa40cae>] bus_for_each_drv+0x12c/0x154
>     [<00000000c149acef>] __device_attach+0x148/0x1e0
>     [<00000000a74fd158>] device_initial_probe+0x24/0x30

This is the allocation of the GPIO character device, which is allocated
in response to the creation of the GPIO chip, from .probe().
As that is done using devm_gpiochip_add_data(), the chardev should be
deallocated automatically by devm_gpio_chip_release() when
platform_device_unregister() is called.

Weird...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

