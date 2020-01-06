Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884DEC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F7220848
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 08:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F7220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioNQP-0004GX-Ew
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 03:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ioNPo-0003qQ-2m
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ioNPm-0004M4-Rs
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:07:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1ioNPm-0004LU-NV
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 03:07:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id q3so2070086otr.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 00:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DW1SIti7NHYB1AbqgFvyF14dNMwa3qPTzBW09JetqYs=;
 b=TDfvFiBVrno6poF1zmmxn3/auQ47lTLWOjBuU/UbB9UvBYf3MiJtAGsZobAM48ndmy
 b37nf6prTmZaEB4XIQFyNZpSVPi4JhLs2Tor1vDP+R7XoQKGBcROlcGB5wMct6GhxTSZ
 qh5LsV7Ol2lgVyI1RHNBcOmGXBRRVugiOVzR1I0Hx7Hz5ALL4HnIbQrvhNz67rOjuGWW
 P1k7wAp9aSmS+PN2RTpdiHc6UAks7LZmUZUImmgUO2M6dJu+RKY6Kx8ul392Xfsal2Qo
 iHkIakHQda1DJjxHnJEVansxp+CN4sPh5VwZc8tIYI6quXH8dtz/JedDk1D7jHVOYch4
 TvAw==
X-Gm-Message-State: APjAAAU7sPS0Xd7k9Y/4vQit2ILHX79Hd59kEjF0xpk2vBEAUDWSPWsw
 sHlEPtSllaY+QmYG0ANd2DvfU/0vpZLzIGuYtBo=
X-Google-Smtp-Source: APXvYqxAKJhctUL3mn7UzaLw+sqHKf++PDfXB8dUrOnMMXR6h0t2N8/KpR/0X7vcb8CRnhjsdWQ+ZW4+Y5nwyAvTH3w=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr15235457ots.250.1578298025342; 
 Mon, 06 Jan 2020 00:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-7-geert+renesas@glider.be>
 <CACRpkdb1XZAeSThxWmJtnm80T4aPufXV2UvJdVdgnw-TJe3trg@mail.gmail.com>
 <CAMuHMdV+Ww5Y9G7+bS-SyHtm4dC89V37yuaYvrS3kYW=PRTkFA@mail.gmail.com>
 <CACRpkdZwos9Dtt9E3OkxWf4rqMALNTge5NGduzGm-7MhQyLZuQ@mail.gmail.com>
In-Reply-To: <CACRpkdZwos9Dtt9E3OkxWf4rqMALNTge5NGduzGm-7MhQyLZuQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Jan 2020 09:06:53 +0100
Message-ID: <CAMuHMdWZ7Wh9rq7SGt7edgCXL1e5UwtSUfxLc0exHa-TEB=W5w@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] docs: gpio: Add GPIO Aggregator/Repeater
 documentation
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
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
 Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Linus,

On Sat, Jan 4, 2020 at 1:21 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Dec 12, 2019 at 3:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Dec 12, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
> > > <geert+renesas@glider.be> wrote:
> > > > +The GPIO Aggregator allows access control for individual GPIOs, by aggregating
> > > > +them into a new gpio_chip, which can be assigned to a group or user using
> > > > +standard UNIX file ownership and permissions.  Furthermore, this simplifies and
> > > > +hardens exporting GPIOs to a virtual machine, as the VM can just grab the full
> > > > +GPIO controller, and no longer needs to care about which GPIOs to grab and
> > > > +which not, reducing the attack surface.
> > > > +
> > > > +Aggregated GPIO controllers are instantiated and destroyed by writing to
> > > > +write-only attribute files in sysfs.
> > >
> > > I suppose virtual machines will have a lengthy config file where
> > > they specify which GPIO lines to pick and use for their GPIO
> > > aggregator, and that will all be fine, the VM starts and the aggregator
> > > is there and we can start executing.
> > >
> > > I would perhaps point out a weakness as with all sysfs and with the current
> > > gpio sysfs: if a process creates an aggregator device, and then that
> > > process crashes, what happens when you try to restart the process and
> > > run e.g. your VM again?
> > >
> > > Time for a hard reboot? Or should we add some design guidelines for
> > > these machines so that they can cleanly tear down aggregators
> > > previously created by the crashed VM?
> >
> > No, the VM does not create the aggregator.
> >
> > The idea is for the user to create one or more aggregators, set up
> > permissions on /dev/gpiochipX, and launch the VM, passing the aggregated
> > /dev/gpiochipX as parameters.
> > If the VM crashes, just launch it again.
> >
> > Destroying the aggregators is a manual and independent process, after
> > the VM has exited.
>
> I'm thinking about someone making some industrial application for some
> control of a machinery say a robotic arm.
>
> And do make sure this VM is only controlling these GPIOs related to
> this robotic arm, they create a GPIO aggregator. And we care about
> cases like that since we provide this security argument.
>
> Surely that machine will be rebooted.
>
> Surely they don't have a printed paper with all the commands lying
> at the console, and asking whoever powers it back on to manually
> type it all in again. That feels a bit 1981.
>
> So they will have a script for this I suppose. Possibly in some
> initscript so it is set up on boot. And this script echos stuff
> all over the place to set up the aggregator.
>
> Is this the use case you're thinking of?

Exactly.

And they can configure that by echoing the GPIO specifiers to
/sys/bus/platform/drivers/gpio-aggregator/new_device.

If their system has DT, another option is to describe the device in DT,
and add its compatible value to gpio_aggregator_dt_ids[], cfr. the
frobnicator example.

> I just like to have the whole picture here.

Sure. If anything is still unclear, please let me know!
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

