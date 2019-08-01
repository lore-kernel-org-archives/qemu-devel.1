Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37278C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 08:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02FF214DA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 08:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAXRWo8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02FF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht6en-0006FG-Qm
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 04:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55232)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <linus.walleij@linaro.org>) id 1ht6eK-0005Xu-UM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1ht6eJ-0000ap-N2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:41:24 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1ht6eJ-0000Zr-E2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:41:23 -0400
Received: by mail-lj1-x242.google.com with SMTP id z28so14298429ljn.4
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+4DBMF2Zte9lbb8+gtbY6RWDlcSP8w6E9Z0ywxOOvw4=;
 b=YAXRWo8X6F6wz5PKvmW08QL99wEuNQNPC5fMWRNuSkxkey+SRqTz9XGN9NJGP9eqYa
 Q0tF6b9ViA3a5SI3rST4Ne8tyz/WLlCbLKkL5wiimdTe9b+DeXm/7MeRNV65yOKZwcVs
 jUika+QzRTGYMdg8tGJ4oRQmSWd7MRITrJMcjb97yPHoSwKEP48fU32H/asZVahdnK95
 ClDMx1P/8TFgXbIC3P0k4UHKa8gQNXcDCLxQxGYd+HQg10ROWqJmC4WTV0vmXCAV6fMX
 sCUWduO8Raz+EY5MiehROp2QugR+GmK/OY2fxXJ+DmHk4a0nsQy3OgUgj2DWbaAkVSEz
 tbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+4DBMF2Zte9lbb8+gtbY6RWDlcSP8w6E9Z0ywxOOvw4=;
 b=btSnAR/Kih/gySQxAt3tjmgUQQK6OftpPbd8CMtUedA8AVjp6qJelF/9FSYO0v/xdB
 O4VHU8BMDOQYpuysVs+xc/5QMoxzZnqiVKkgu7K/3Hz83/UMBRTrAuc5cQrbn8Cw8Y3u
 t/IRsGXaWf5IAFC1vT2Z0MMGxilobtFR6SAgKERYxbEkGO2gcktb/unWzdT7qWV1VRuO
 +60dky4ngOoC9ECvEzfaSd0TX8CEGV7IdlkPGNBOCrr6Y+q66mdkQMobCUQBVIg2g5fw
 3WeoH4lCWw/MODcxmVswtV0tR1UAj8G0Cz6hSSeGng/2G+tiOS8CSozYRqaEfN2JIJkb
 PVOg==
X-Gm-Message-State: APjAAAXGcdBqmPh3fNGUI2WlSW89MYNa656hlcSZV6j4sqYG+nAe7AVe
 H1tDNLzlg3bAeXCqSaElLz3iU7bOP2lL0S6jpv73Qw==
X-Google-Smtp-Source: APXvYqxHEo1NnEuEea/EVgMvvV8QMVqO2H6dE9nSCXlcgxLIpX1H4/F1RTRXNMP6rHMR7tplWY1KPvxie4hjSNzYZAo=
X-Received: by 2002:a2e:8756:: with SMTP id q22mr68107000ljj.108.1564648881037; 
 Thu, 01 Aug 2019 01:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
In-Reply-To: <20190705160536.12047-1-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Aug 2019 10:41:09 +0200
Message-ID: <CACRpkdY6qAUkQW4YHN9HskvZS2P-viWYTHSb28ECh1p+itU=4Q@mail.gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Marc Zyngier <marc.zyngier@arm.com>, christoffer.dall@arm.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH RFC] gpio: Add Virtual Aggregator GPIO
 Driver
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Alexander Graf <agraf@suse.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert!

Thanks for this very interesting patch!

On Fri, Jul 5, 2019 at 6:05 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> GPIO controllers are exported to userspace using /dev/gpiochip*
> character devices.  Access control to these devices is provided by
> standard UNIX file system permissions, on an all-or-nothing basis:
> either a GPIO controller is accessible for a user, or it is not.
> Currently no mechanism exists to control access to individual GPIOs.

Yes, I did that decision deliberately, as the chip is one device
and the base system control is usually on a per-device granularity.
At one point some people were asking for individual GPIO line
permissions in the character device and my argument was something
like why can't I have individual control over the access rights on a block
device or the pixels on a graphics device then.

Jokes aside, filesystems do provide access control over individual
blocks on a block device in a way. So it is further up the stack.

The same goes for this: something above the GPIO chip provide
more granular access control, and as such it fits the need very well.

> Hence add a virtual GPIO driver to aggregate existing GPIOs (up to 32),
> and expose them as a new gpiochip.  This is useful for implementing
> access control, and assigning a set of GPIOs to a specific user.
> Furthermore, it would simplify and harden exporting GPIOs to a virtual
> machine, as the VM can just grab the full virtual GPIO controller, and
> no longer needs to care about which GPIOs to grab and which not,
> reducing the attack surface.

Excellent approach.

I would even go so far as to call it "gpio-virtualization" or
"gpio-virtualized" rather than "gpio-virtual" so it is clear what the
intended usecase is. We have a bit of confusion in the kernel
because people misuse the word "virtual" left and right, like for
"virtual IRQ number" (Linux IRQ numbers) which are just some
random number space, but not really "virtual", it's a semantic
disease similar to the confusion of using the word "manual" in
computer code.

Here it is however used correctly! (Maybe for the first time.)

> Virtual GPIO controllers are instantiated by writing to the "new_device"
> attribute file in sysfs:
>
>     $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
>            "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
>             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
>
> Likewise, virtual GPIO controllers can be destroyed after use:
>
>     $ echo gpio-virt-agg.<N> \
>             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device

I suppose this is the right way to use sysfs.

I would check with some virtualization people (paged Marc Zyngier
and Christoffer Dall) so they can say whether this is the way any
virtual machine wants to populate its local GPIO chip for
use with a certain machine.

If QEMU can deal in a simple and straight-forward way with this
I see it quickly becoming a very useful tool for industrial automation
where you want to run each control system in isolation and just
respawn the virtual machine if something goes wrong.

Since this might be very popular we need some scrutiny but the
concept as a whole is very appetizing!

Yours,
Linus Walleij

