Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304E7C00523
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 00:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F336820866
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 00:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuL59PMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F336820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inXTo-0003vD-4y
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 19:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1inXSu-0003NU-Qk
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 19:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1inXSt-0002jy-Em
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 19:38:52 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1inXSt-0002e0-54
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 19:38:51 -0500
Received: by mail-lf1-x141.google.com with SMTP id n25so32938231lfl.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 16:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7uC7JWFx9OYNnl310U+ygwv67SYyeHmDQsyNae/VGhA=;
 b=MuL59PMNVVu75FiAbIkclAny8nz760/4Z2GfHF30DCsopTe93BZOBYrLPjR6gD61X2
 Ia+4C7u+qJ4p2FyZtfAjId1AXzKlKxic1WMzqQg3NK3gBNXV+ez2toaBlaN1/drja0og
 tIKURSFgHmO9j4DdW9Kg1qqGdU8X4KroveTVqF1A7gOlP2tT27bciMW13pYilBQg6pZn
 a+2PY4wz/bporm9hUJNRMPypAoDIa3/U2adVPtQMJv9LEO7KBcF8N+TWsqrpBnJmw+aM
 gkmDtXdZ7UfMFin1mBsGFfPqu0VvKDX866NlPztG0aOz3SZpNjkSJgcIgQz5IArawDNs
 HyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7uC7JWFx9OYNnl310U+ygwv67SYyeHmDQsyNae/VGhA=;
 b=q5KEFXR2/9yf3AaWdUODPXNZc0TvEtsaxnf1banTLHhyhhH2nv7LSuJq1Gb755WuR1
 n5bIFVs/uFs3Q1+edb4h0Lac8Fu2Bj0UJDPcgVJlIXxkOdaSAEBFmjWI8MTdhx2mcw0T
 inehi8bH/r1QKdUUBOrbRuCnWdxFq2326W4CTcgCN7AtokWIlP3EFvYQ9g5TKZvnQGyB
 tnZRQNJ8FaC2zNTdcUJdzIA7+FzkYzcuZ3B1wNhJ4PvDUb+zb9ec6ply81aJLSYBflnO
 aYbJdjFWpi61KMoQhZoc8TF00ifGacrtKu1oLIV0r4bV+wNaye5GwDV3rOMrsbcXKjnD
 jMEQ==
X-Gm-Message-State: APjAAAUKGnlR98ANcBHXk6Ygu6B5NXJFNMm4cl2SM74CKwD5eQnyZvso
 i4owKfvnBtZ12KbIFzYGSION+Cr/J7w0bf++kNC/4A==
X-Google-Smtp-Source: APXvYqx7qnNmzEGHh3l0ybIURRNlv3h+0jMWrPNsddLXYBAWaFoIfBU2PrBmBZ6fwZizOYviRGZkOY/zqCQGjuwVAnQ=
X-Received: by 2002:a19:c0b:: with SMTP id 11mr52456055lfm.135.1578098329258; 
 Fri, 03 Jan 2020 16:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
 <CACRpkdaW7nmpE99FAvBDBTmkTZOTQ5WdM=JbMzBTLk7cbLRXPw@mail.gmail.com>
 <CAMuHMdVbk5S__8OK-zNXmiW66=WVA8Jzyc=hUvf_hJSU=u9TFg@mail.gmail.com>
In-Reply-To: <CAMuHMdVbk5S__8OK-zNXmiW66=WVA8Jzyc=hUvf_hJSU=u9TFg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 4 Jan 2020 01:38:38 +0100
Message-ID: <CACRpkda8QD_tDA=YVDRNVnHd8QHs-yHBTzZuJHsnocgMdxv9cA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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

Sorry for slowness... christmas.

On Thu, Dec 12, 2019 at 4:24 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Dec 12, 2019 at 3:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > > +         This can serve the following purposes:
> > > +           1. Assign a collection of GPIOs to a user, or export them to a
> > > +              virtual machine,
> >
> > This is ambiguous. What is a "user"? A process calling from
> > userspace? A device tree node?
>
> A user is an entity with a UID, typically listed in /etc/passwd.
> This is similar to letting some, not all, people on the machine access
> the CD-ROM drive.

Ah I get it. Maybe we can say "assign permissions for a collection
of GPIOs to a user".

> > I would write "assign a collection of GPIO lines from any lines on
> > existing physical GPIO chips to form a new virtual GPIO chip"
> >
> > That should be to the point, right?
>
> Yes, that's WHAT it does. The WHY is the granular access control.

So I guess we can write both?

> > > +           3. Provide a generic driver for a GPIO-operated device, to be
> > > +               controlled from userspace using the GPIO chardev interface.
> >
> > I don't understand this, it needs to be elaborated. What is meant
> > by a "GPIO-operated device" in this context? Example?
>
> E.g. a motor. Or a door opener.
>
>         door-opener {
>                 compatible = "mydoor,opener";
>
>                 gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>         };
>
> You don't need a full-featured kernel driver for that, so just bind the
> gpio-aggregator to the door-opener, and control it through libgpiod.

Yep it's a perfect industrial control example, I get it.

Maybe we should blurb something about industrial control?

The rest I think we cleared out else I will see it when I review again.

Yours,
Linus Walleij

