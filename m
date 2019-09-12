Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE2C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57EB206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57EB206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Kyf-0002hN-Ag
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1i8Kwg-0001TB-LZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1i8Kwe-0004RA-Lf
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:59:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1i8Kwc-0004QL-Rf
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:59:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id 11so1191479oix.4
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 01:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=07+QEZTfn9RypDDP0lnGrecYssAORdm1hEOMhmeJ4sQ=;
 b=POeju/hemIh6ueqqfSDLNT8aEZrQR8XgFvXkIKAcrEXdVDLjk70Jamk2SvkbWV4mcd
 7ozLC3Ina0aChn/xLBcNsdzTjC9+tEknnkRX4LuNHZQ9qNXZvWUFlVoIqgf13Z3FGL86
 lSn6QZVBlYxE2WlWZF6IIR4NXqPHu2/HalffaxT/0odmF0pKN0r0SPLPZojURT5F7dix
 yq47J/eOYXDVK1z759QZvmQHmlYqRsDCVaeuM+cVbFr4coy4aYMRo8UnYXfy/9qTmnWK
 8BZGUjsyh9Nw226OLPHTKTSwvW91FB9i7lNHINUSqtVLJipIVcj9gU35bn8zyaAmAVta
 4Ptw==
X-Gm-Message-State: APjAAAVwxD3IIFn+50oI7oelzOw7ivwBMmvmHR971Tqg1RJhT1xPX1FV
 1kPU1AnBIyG4dFgBKI68o25EuaGkebnU2m0Ju8g=
X-Google-Smtp-Source: APXvYqwaLUUcAadCv0DqnSsH8fSMIu/3zsuqD2+TF8HGL+/gSXVIvL0eI/76KPAWOFUO1FnvkEwE9GdgkicOmpaXifE=
X-Received: by 2002:a05:6808:8e3:: with SMTP id
 d3mr7305993oic.153.1568278753086; 
 Thu, 12 Sep 2019 01:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <CACRpkdZstL3PMtLN3VCDmHq7vSNdO0Q8Wf1sYb5VnwCMs=0uJQ@mail.gmail.com>
In-Reply-To: <CACRpkdZstL3PMtLN3VCDmHq7vSNdO0Q8Wf1sYb5VnwCMs=0uJQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Sep 2019 10:59:01 +0200
Message-ID: <CAMuHMdWcxgXfBb9sBNunOwxftO0+pEB3oAHgufyiGUn3B8uv2Q@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
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
Cc: adelva@google.com, Peter Maydell <peter.maydell@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
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

Hi Linus,

On Thu, Sep 12, 2019 at 10:56 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jul 5, 2019 at 5:05 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
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
> >     $ echo "<gpiochipA> <gpioA1> [<gpioA2> ...]"
> >            "[, <gpiochipB> <gpioB1> [<gpioB2> ...]] ...]"
> >             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
> >
> > Likewise, virtual GPIO controllers can be destroyed after use:
> >
> >     $ echo gpio-virt-agg.<N> \
> >             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Aggregating GPIOs and exposing them as a new gpiochip was suggested in
> > response to my proof-of-concept for GPIO virtualization with QEMU[1][2].
> >
> > Sample session on r8a7791/koelsch:
> >
> >   - Disable the leds node in arch/arm/boot/dts/r8a7791-koelsch.dts
> >
> >   - Create virtual aggregators:
> >
> >     $ echo "e6052000.gpio 19 20" \
> >             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
> >
> >     gpio-virt-agg gpio-virt-agg.0: GPIO 0 => e6052000.gpio/19
> >     gpio-virt-agg gpio-virt-agg.0: GPIO 1 => e6052000.gpio/20
> >     gpiochip_find_base: found new base at 778
> >     gpio gpiochip8: (gpio-virt-agg.0): added GPIO chardev (254:8)
> >     gpiochip_setup_dev: registered GPIOs 778 to 779 on device: gpiochip8 (gpio-virt-agg.0)
> >
> >     $ echo "e6052000.gpio 21, e6050000.gpio 20 21 22" \
> >             > /sys/bus/platform/drivers/gpio-virt-agg/new_device
> >
> >     gpio-virt-agg gpio-virt-agg.1: GPIO 0 => e6052000.gpio/21
> >     gpio-virt-agg gpio-virt-agg.1: GPIO 1 => e6050000.gpio/20
> >     gpio-virt-agg gpio-virt-agg.1: GPIO 2 => e6050000.gpio/21
> >     gpio-virt-agg gpio-virt-agg.1: GPIO 3 => e6050000.gpio/22
> >     gpiochip_find_base: found new base at 774
> >     gpio gpiochip9: (gpio-virt-agg.1): added GPIO chardev (254:9)
> >     gpiochip_setup_dev: registered GPIOs 774 to 777 on device: gpiochip9 (gpio-virt-agg.1)
> >
> >   - Adjust permissions on /dev/gpiochip[89] (optional)
> >
> >   - Control LEDs:
> >
> >     $ gpioset gpiochip8 0=0 1=1 # LED6 OFF, LED7 ON
> >     $ gpioset gpiochip8 0=1 1=0 # LED6 ON, LED7 OFF
> >     $ gpioset gpiochip9 0=0     # LED8 OFF
> >     $ gpioset gpiochip9 0=1     # LED8 ON
> >
> >   - Destroy virtual aggregators:
> >
> >     $ echo gpio-virt-agg.0 \
> >             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
> >     $ echo gpio-virt-agg.1 \
> >             > /sys/bus/platform/drivers/gpio-virt-agg/delete_device
> >
> > Thanks for your comments!
> >
> > References:
> >   - [1] "[PATCH QEMU POC] Add a GPIO backend"
> >         (https://lore.kernel.org/linux-renesas-soc/20181003152521.23144-1-geert+renesas@glider.be/)
> >   - [2] "Getting To Blinky: Virt Edition / Making device pass-through
> >          work on embedded ARM"
> >         (https://fosdem.org/2019/schedule/event/vai_getting_to_blinky/)
>
> I'm looping in my friends at Google for this discussion.
>
> They need a virtualized gpio_chip for their Android emulator,
> and their current approach for other devices has been around
> using virtio in most cases and an emulated AC97 for the
> audio case as far as I remember.
>
> It would be great to have their input on this so we can create a
> virtualization/aggregate that works for all.
>
> Please include adelva@google.com on future postings of this!

I've sent v2 yesterday:
https://lore.kernel.org/lkml/20190911143858.13024-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

