Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C464C00523
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 00:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E085621835
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 00:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRnVfA7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E085621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inXD5-0006CX-0X
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 19:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1inXCI-0005mm-NC
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 19:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1inXCH-0001o8-A5
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 19:21:42 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1inXCH-0001gG-0x
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 19:21:41 -0500
Received: by mail-lj1-x244.google.com with SMTP id u71so45390525lje.11
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 16:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a25MTBnzC/TY/vt8zz8+qKKJTGhY6mCF1CmPfY1tykI=;
 b=gRnVfA7FDAgs73jNy22XumTxemh0aYDjK9B1YAV7aDhmr0DazAVJiMp4WVw1bkv31/
 bcATx1sRwYkcsu4O0LQVmlmjSHW5VtsN8kArTfZitHm7x//5M6K3YcSNLlNrU4k2nXBM
 yt6DH6rszExsqnVul0yZCOGTl1phucIVvqvK/Gcklh4kjZC6VQ1xu9ZmRNx0Ik5oj39W
 PUCHY1sxyw3q0Pr498xt9akwnDTU17FpPWdhZ0+b30zgWzvbnxDXRO1SyZ+eSC73LL7M
 4bTSAi5L7Qao6/+sTppkChYPciZ16A05vGdttDOmIm7Rn2KAj85O40F9gtCbP1HMl69m
 XGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a25MTBnzC/TY/vt8zz8+qKKJTGhY6mCF1CmPfY1tykI=;
 b=Msm9jXUPz0Qwq9LNp7XKNnQsJqd8w2fquNwhk1W/PZl+DQ6oWmcI1UirAv0hTlNjsI
 dMQcdThV3SOF10gZ7uaC3QRDI0Fdvo65f/pz0IxX1Z2X7NG8k8oT3EqRwLUN9n0vB5Go
 4vLTvEcLyf8fQpKToJNPQOn0Cvfj3iN6Y1eDslLTtFqorkd9BJouvCcew9aBlHMunh2D
 zDi3WUTE4EvggmkPwKzSr3u7f/5hhRsg2UtbcNd7KhqAfujQYRpedGcBXshE1AMUfHUe
 08E2iajQdbz6yTlbrbHkIXCKOsiyYysJJpLy/wYau9UIaBd8zWajA7JM0I2KeYHI0xR3
 G05w==
X-Gm-Message-State: APjAAAXTHaZWAmBw/DEcJJpd9GJmJMJQJ0UtP2bUXDZkQxg8/xuej2nU
 IYQJsShiCSgjpnjQdvrseNBMoNBf/O5ZCwt1AcSLLQ==
X-Google-Smtp-Source: APXvYqxHT5NBcGXP7l31r/rUzGwxDXqF6xPcQ35bsC0BAshJRd7O7pJFod6OutyDNvKjGim9p9LsFYX1ulkLOKLmCGs=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr51946653ljj.191.1578097298469; 
 Fri, 03 Jan 2020 16:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-7-geert+renesas@glider.be>
 <CACRpkdb1XZAeSThxWmJtnm80T4aPufXV2UvJdVdgnw-TJe3trg@mail.gmail.com>
 <CAMuHMdV+Ww5Y9G7+bS-SyHtm4dC89V37yuaYvrS3kYW=PRTkFA@mail.gmail.com>
In-Reply-To: <CAMuHMdV+Ww5Y9G7+bS-SyHtm4dC89V37yuaYvrS3kYW=PRTkFA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 4 Jan 2020 01:21:27 +0100
Message-ID: <CACRpkdZwos9Dtt9E3OkxWf4rqMALNTge5NGduzGm-7MhQyLZuQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] docs: gpio: Add GPIO Aggregator/Repeater
 documentation
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

On Thu, Dec 12, 2019 at 3:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Dec 12, 2019 at 3:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > +The GPIO Aggregator allows access control for individual GPIOs, by aggregating
> > > +them into a new gpio_chip, which can be assigned to a group or user using
> > > +standard UNIX file ownership and permissions.  Furthermore, this simplifies and
> > > +hardens exporting GPIOs to a virtual machine, as the VM can just grab the full
> > > +GPIO controller, and no longer needs to care about which GPIOs to grab and
> > > +which not, reducing the attack surface.
> > > +
> > > +Aggregated GPIO controllers are instantiated and destroyed by writing to
> > > +write-only attribute files in sysfs.
> >
> > I suppose virtual machines will have a lengthy config file where
> > they specify which GPIO lines to pick and use for their GPIO
> > aggregator, and that will all be fine, the VM starts and the aggregator
> > is there and we can start executing.
> >
> > I would perhaps point out a weakness as with all sysfs and with the current
> > gpio sysfs: if a process creates an aggregator device, and then that
> > process crashes, what happens when you try to restart the process and
> > run e.g. your VM again?
> >
> > Time for a hard reboot? Or should we add some design guidelines for
> > these machines so that they can cleanly tear down aggregators
> > previously created by the crashed VM?
>
> No, the VM does not create the aggregator.
>
> The idea is for the user to create one or more aggregators, set up
> permissions on /dev/gpiochipX, and launch the VM, passing the aggregated
> /dev/gpiochipX as parameters.
> If the VM crashes, just launch it again.
>
> Destroying the aggregators is a manual and independent process, after
> the VM has exited.

I'm thinking about someone making some industrial application for some
control of a machinery say a robotic arm.

And do make sure this VM is only controlling these GPIOs related to
this robotic arm, they create a GPIO aggregator. And we care about
cases like that since we provide this security argument.

Surely that machine will be rebooted.

Surely they don't have a printed paper with all the commands lying
at the console, and asking whoever powers it back on to manually
type it all in again. That feels a bit 1981.

So they will have a script for this I suppose. Possibly in some
initscript so it is set up on boot. And this script echos stuff
all over the place to set up the aggregator.

Is this the use case you're thinking of?

I just like to have the whole picture here.

Yours,
Linus Walleij

