Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC94CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8687121655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8687121655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPmb-0000VZ-Kg
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ifPlt-00005R-OS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ifPlr-000774-HC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:48:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1ifPlr-00074S-Az
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:48:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id o9so2249602ote.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=voZVPNoSy4a8bMYdTcCablMq5CNO8vg9KUaW07IxqF0=;
 b=B8AR3oqVBR8n6jBYVr6V4/wE1vVUDly0e9Ty8Na2fFY37pQYBVwa9c/RZAuJSy5hFe
 UAK+nFPhlOksp1p5YALq31lf8DcExKz0y2imdw2f6HDUfu2FWS4AIsGsmnYlzeoEn9Ji
 xdd2pjfsmP9JcV82WcUMuEX8YHPBJdTnuW9uzQVGrRu/ncYHLnPgfIeM5WGj0QCKlwxy
 d3iF7ZlpisSBpBY0T7j3rRvdSHA+dO9rwr/FlEf1PLMZwOVtJJRpDSdkqOye8Lr/7nGq
 AIz3C9XqTyeG2jsszii7t56i54XkzyQyyspinrlRHKvoyj3gph38TmPvFCQWST0O+k6X
 Hnrw==
X-Gm-Message-State: APjAAAVD0BdRjOcmjJpSxmYlzdZt0wlSBlnlPXZHp9RO7vGgHqlkGez/
 1Lh9T2dfIkpjPL5PInkhGPS77Z3FPzdeWipLRTU=
X-Google-Smtp-Source: APXvYqzkSI69hH3nkOuTuzoZ5DVB2dOkFajJLW18qhY+01LkXcbQ2mLFjldvRytBCaRPVXRqDE7Vp+g1Jzj78r5O+Hc=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr8660446ots.250.1576162129675;
 Thu, 12 Dec 2019 06:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-7-geert+renesas@glider.be>
 <CACRpkdb1XZAeSThxWmJtnm80T4aPufXV2UvJdVdgnw-TJe3trg@mail.gmail.com>
In-Reply-To: <CACRpkdb1XZAeSThxWmJtnm80T4aPufXV2UvJdVdgnw-TJe3trg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Dec 2019 15:48:38 +0100
Message-ID: <CAMuHMdV+Ww5Y9G7+bS-SyHtm4dC89V37yuaYvrS3kYW=PRTkFA@mail.gmail.com>
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

On Thu, Dec 12, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > +The GPIO Aggregator allows access control for individual GPIOs, by aggregating
> > +them into a new gpio_chip, which can be assigned to a group or user using
> > +standard UNIX file ownership and permissions.  Furthermore, this simplifies and
> > +hardens exporting GPIOs to a virtual machine, as the VM can just grab the full
> > +GPIO controller, and no longer needs to care about which GPIOs to grab and
> > +which not, reducing the attack surface.
> > +
> > +Aggregated GPIO controllers are instantiated and destroyed by writing to
> > +write-only attribute files in sysfs.
>
> I suppose virtual machines will have a lengthy config file where
> they specify which GPIO lines to pick and use for their GPIO
> aggregator, and that will all be fine, the VM starts and the aggregator
> is there and we can start executing.
>
> I would perhaps point out a weakness as with all sysfs and with the current
> gpio sysfs: if a process creates an aggregator device, and then that
> process crashes, what happens when you try to restart the process and
> run e.g. your VM again?
>
> Time for a hard reboot? Or should we add some design guidelines for
> these machines so that they can cleanly tear down aggregators
> previously created by the crashed VM?

No, the VM does not create the aggregator.

The idea is for the user to create one or more aggregators, set up
permissions on /dev/gpiochipX, and launch the VM, passing the aggregated
/dev/gpiochipX as parameters.
If the VM crashes, just launch it again.

Destroying the aggregators is a manual and independent process, after
the VM has exited.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

