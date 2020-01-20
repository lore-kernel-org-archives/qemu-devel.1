Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BEBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550DF20882
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550DF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVxz-00019l-9J
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <erosca@de.adit-jv.com>) id 1itVxI-0000f0-8b
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <erosca@de.adit-jv.com>) id 1itVxG-00021j-NG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:14:56 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:37203)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <erosca@de.adit-jv.com>)
 id 1itVxG-0001xb-D8
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:14:54 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id C7E013C00C5;
 Mon, 20 Jan 2020 13:14:50 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bta2hz3l_WGv; Mon, 20 Jan 2020 13:14:42 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id AC1BB3C04C1;
 Mon, 20 Jan 2020 13:14:42 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 20 Jan
 2020 13:14:42 +0100
Date: Mon, 20 Jan 2020 13:14:39 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 0/7] gpio: Add GPIO Aggregator/Repeater
Message-ID: <20200120121439.GA24951@lxhi-065.adit-jv.com>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20200118014632.GA14644@lxhi-065.adit-jv.com>
 <CAMuHMdUUc17n0TxOrtQNby+ZiHDpz-aEh-ncnkz50vcwQe6z6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUc17n0TxOrtQNby+ZiHDpz-aEh-ncnkz50vcwQe6z6w@mail.gmail.com>
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
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Eugeniu Rosca <roscaeugeniu@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>, "open
 list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert,

On Mon, Jan 20, 2020 at 10:33:53AM +0100, Geert Uytterhoeven wrote:
> On Sat, Jan 18, 2020 at 2:46 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > The only unexpected thing is seeing below messages (where gpiochip99 and
> > gpiochip22 are inexisting gpiochip names, mistakenly provided on command
> > line prior to passing the correct name):
> >
> > root@rcar-gen3:~# echo gpiochip6 12-13 > /sys/bus/platform/drivers/gpio-aggregator/new_device
> > [  915.572905] gpio-aggregator gpio-aggregator.0: cannot find GPIO chip gpiochip99, deferring
> > [  915.584224] gpio-aggregator gpio-aggregator.2: cannot find GPIO chip gpiochip99, deferring
> > [  915.865281] gpio-aggregator gpio-aggregator.29: cannot find GPIO chip gpiochip22, deferring
> >
> > Obviously, in the above case, due to a typo in the names, the gpio
> > chips will never be found, no matter how long gpio-aggregator defers
> 
> Indeed, that is expected behavior: you have created platform devices
> referring to resources that are not available.

Got it. Sounds reasonable to me.

> 
> > their probing. Unfortunately, the driver will continuously emit those
> > messages, upon each successfully created/aggregated gpiochip. I built
> 
> That is expected behavior, too: every time the driver core manages to
> bind a device to a driver, it will retry all previously deferred probes,
> in the hope they can be satisfied by the just bound device.
> 
> Note that you can destroy these bogus devices, using e.g.
> 
>     # echo gpio-aggregator.0 > \
>     /sys/bus/platform/drivers/gpio-aggregator/delete_device

Yep, I can get rid of the bogus devices this way. Thanks!

> 
> > gpio-aggregator as a loadable module, if that's relevant.
> 
> Modular or non-modular shouldn't matter w.r.t. this behavior.
> Although unloading the module should get rid of the cruft.

Yes, indeed!

> 
> > Another comment is that, while the series _does_ allow specifying
> > gpio lines in the DTS (this would require a common compatible string
> > in gpio_aggregator_dt_ids[] and in the DTS node) and while those lines
> > are indeed exposed to userspace, based on my testing, these same gpio
> > lines are marked as "used/reserved" by the kernel. This means that
> > operating on those gpio pins from userspace will not be possible.
> > For instance, gpioget/gpioset return "Device or resource busy":
> >
> > gpioget: error reading GPIO values: Device or resource busy
> > gpioset: error setting the GPIO line values: Device or resource busy
> >
> > I guess Harish will be unhappy about that, as his expectation was that
> > upon merging gpio-aggregator with gpio-inverter, he will be able to
> > describe GPIO polarity and names in DTS without "hogging" the pins.
> > Perhaps this can be supplemented via an add-on patch later on?
> 
> When aggregating GPIO lines, the original GPIO lines are indeed marked
> used/reserved, so you cannot use them from userspace.
> However, you are expected to use them through the newly created virtual
> gpiochip representing the aggregated GPIO lines.
> 
> You can try this using the "door" example in
> Documentation/admin-guide/gpio/gpio-aggregator.rst, after replacing
> gpio2 {19,20} by gpio6 {12,13} to suit your H3ULCB.

Confirmed. The example works like a charm. One difference between
the runtime-created and DTS-created gpiochips is the name:
 - gpio-aggregator.<number>, for the ones created via sysfs
 - <name-of-DTS-node>, for the ones created via DTS

Seeing this behavior on my target, I believe the expectations of
Harish should be met w/o any major limitations.

> 
> > For the whole series (leaving the above findings to your discretion):
> >
> > Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

The recent [v3] discussion actually applies to [v4], for which I did
review and testing. Will relay the signatures to the latest version.

Thank you very much.

-- 
Best Regards,
Eugeniu

