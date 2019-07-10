Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF6C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE21720651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE21720651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9kg-00088L-G6
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40187)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1hl9jn-0007JO-20
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1hl9jl-0003k2-8P
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:22:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1hl9jf-0003AD-OF
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:22:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so1620884otq.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hi6thLRzPp31ZNlrsqTMD+L4AfM17N+VHGvoPv6ISh0=;
 b=CDJplNngd/qu5tW3fm38W8lXIAhEIusRnnnfwBqeZppeB+iGaGiEvC1irQZi6shkLu
 qL8IST0uZIz6MtmeX1z1I+6LFLR2NhYw2Ilh0d/eNNFuJI6kDbkjKSvlSgQw1gxOTMxj
 UpMrdwLBs7aTyW+EcsdbMoU1c9U6l6bh4UTiyRf4NT2bz4djllJhLrnpRIh705CpkjxC
 0Y/fxvgWNBYN2zn031P5S4JYlNkVnfKd+BboObVqyN9CcgIx8R+/zD9tl4F6ZwJjJ4nY
 VZFvYCZp0phAU1N13km5p6rz0BxY/0OPLL4Bg9T1QMV8vIfiHuwmd44lOg/6C3V21h7Y
 IqWA==
X-Gm-Message-State: APjAAAUpG1mAhml1merj2cp9iiPuJWZGcQeRUkigLqu3Xzg7GACjFi7O
 sFyr0/5VPsCWiMcrJXBfR2b87lXQLPrp9lwYjeI=
X-Google-Smtp-Source: APXvYqzIrZRSgRuX2Gq/mfmOXQ1oI1Q7/uvrG+ybtkgYq5mYPQ7do0oaeBVqu00kbw6aDN/dGT0IC7t5vSteaZXtVsY=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr8348445otk.107.1562754106044; 
 Wed, 10 Jul 2019 03:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <8500a069-9e29-d6ad-e5e4-22d5a3eead59@electromag.com.au>
In-Reply-To: <8500a069-9e29-d6ad-e5e4-22d5a3eead59@electromag.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Jul 2019 12:21:35 +0200
Message-ID: <CAMuHMdWLcr0pf-ZM3+iWQGwDLB2xoHAZaeCKAjtEVEaiNed63Q@mail.gmail.com>
To: Phil Reid <preid@electromag.com.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

On Wed, Jul 10, 2019 at 4:00 AM Phil Reid <preid@electromag.com.au> wrote:
> On 6/07/2019 00:05, Geert Uytterhoeven wrote:
> > GPIO controllers are exported to userspace using /dev/gpiochip*
> > character devices.  Access control to these devices is provided by
> > standard UNIX file system permissions, on an all-or-nothing basis:
> > either a GPIO controller is accessible for a user, or it is not.
> > Currently no mechanism exists to control access to individual GPIOs.
> >
> > Hence add a virtual GPIO driver to aggregate existing GPIOs (up to 32),
> > and expose them as a new gpiochip.  This is useful for implementing
> > access control, and assigning a set of GPIOs to a specific user.
> > Furthermore, it would simplify and harden exporting GPIOs to a virtual
> > machine, as the VM can just grab the full virtual GPIO controller, and
> > no longer needs to care about which GPIOs to grab and which not,
> > reducing the attack surface.
> >
> > Virtual GPIO controllers are instantiated by writing to the "new_device"
> > attribute file in sysfs:
> >
> >      $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
> >             "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
> >              > /sys/bus/platform/drivers/gpio-virt-agg/new_device
> >
> > Likewise, virtual GPIO controllers can be destroyed after use:
> >
> >      $ echo gpio-virt-agg.<N> \
> >              > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
> >
>
> Nice.
> This provides similar functionality to the "gpio inverter" driver currently on the list.
> Other than being just a buffer.

Indeed, both drivers forward GPIO calls, but the gpio inverter modifies
some parameters passed.

The way the drivers obtain references to GPIOs is different, though: the
inverter driver obtains a fixed description from DT, while the virtual
aggregator receives the description at runtime, from sysfs.

But perhaps both drivers could share some code?

> Would it be possible to do the lookup via line names?

Doesn't the fact that a GPIO has a line name means that it is in use, and
thus cannot be aggregated and exported to another user?

Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

