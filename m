Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6B0C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF88E20661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF88E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYDW-0006gl-JI
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <erosca@de.adit-jv.com>) id 1ipYCQ-0004zq-1H
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <erosca@de.adit-jv.com>) id 1ipYCO-0004w1-Kb
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:50:09 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:39867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <erosca@de.adit-jv.com>)
 id 1ipYCO-0004ek-7z
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:50:08 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id 628BD3C04C0;
 Thu,  9 Jan 2020 14:50:04 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SnVdHi-5nOMk; Thu,  9 Jan 2020 14:49:59 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 0D9103C00B7;
 Thu,  9 Jan 2020 14:49:59 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 9 Jan 2020
 14:49:58 +0100
Date: Thu, 9 Jan 2020 14:49:56 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
Message-ID: <20200109134843.GA2558@lxhi-065.adit-jv.com>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
 <20191203105103.GA20470@x230>
 <CAMuHMdVLaGt5GTXzUbUHrBHn5q--t3JfxO6P_j0GnnhixV+UfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVLaGt5GTXzUbUHrBHn5q--t3JfxO6P_j0GnnhixV+UfA@mail.gmail.com>
X-Originating-IP: [10.72.93.66]
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 93.241.18.167
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>, Jonathan Corbet <corbet@lwn.net>,
 Magnus Damm <magnus.damm@gmail.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
 Eugeniu Rosca <roscaeugeniu@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Phil Reid <preid@electromag.com.au>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert,

On Thu, Jan 09, 2020 at 02:35:10PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 3, 2019 at 11:51 AM Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
> >
> > FWIW/FTR, doing some blind creation and deletion of gpio aggregator
> > chips [1] on R-Car H3ULCB overnight, kmemleak reported once [2]. Not
> > sure this is something 100% reproducible.
> >
> > [1] while true; do \
> >    echo e6055400.gpio 12,13 > /sys/bus/platform/drivers/gpio-aggregator/new_device; \
> >    echo gpio-aggregator.0 > /sys/bus/platform/drivers/gpio-aggregator/delete_device; \
> >    done
> >
> > [2] unreferenced object 0xffff0006d2c2e000 (size 128):
> >   comm "kworker/3:1", pid 55, jiffies 4294676978 (age 38546.676s)
> >   hex dump (first 32 bytes):
> >     00 d9 d2 d3 06 00 ff ff 0c 00 e0 0f ff ff ff ff  ................
> >     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<00000000a8e18c13>] slab_post_alloc_hook+0x8c/0x94
> >     [<000000006f419a4f>] __kmalloc+0x170/0x218
> >     [<0000000060d185ea>] kobj_map+0x78/0x1c0
> >     [<00000000c96645f3>] cdev_add+0x68/0x94
> >     [<00000000a7a5a8ac>] cdev_device_add+0x74/0x90
> >     [<00000000497871d3>] gpiochip_setup_dev+0x84/0x1f0
> >     [<00000000b993f95f>] gpiochip_add_data_with_key+0xbcc/0x11f0
> >     [<00000000fd728c0e>] devm_gpiochip_add_data+0x60/0xa8
> >     [<00000000442e34c1>] gpio_aggregator_probe+0x210/0x3c8
> >     [<00000000076e13fb>] platform_drv_probe+0x70/0xe4
> >     [<00000000de84b58b>] really_probe+0x2d8/0x434
> >     [<00000000c95c9784>] driver_probe_device+0x15c/0x16c
> >     [<00000000afb7dd4f>] __device_attach_driver+0xdc/0x120
> >     [<00000000efa40cae>] bus_for_each_drv+0x12c/0x154
> >     [<00000000c149acef>] __device_attach+0x148/0x1e0
> >     [<00000000a74fd158>] device_initial_probe+0x24/0x30
> 
> This is the allocation of the GPIO character device, which is allocated
> in response to the creation of the GPIO chip, from .probe().
> As that is done using devm_gpiochip_add_data(), the chardev should be
> deallocated automatically by devm_gpio_chip_release() when
> platform_device_unregister() is called.
> 
> Weird...

It might have been a false positive. Kmemleak is not w/o flaws.
I will retest and report later. In any case, it does not look
severe to me.

-- 
Best Regards,
Eugeniu

