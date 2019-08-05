Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9495AC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9D720880
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4W9SBDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9D720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huagM-0006SA-Mw
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 06:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50244)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <linus.walleij@linaro.org>) id 1huafz-00062O-8Y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1huafy-0000LP-21
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:57:15 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1huafx-0000Gf-Ms
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:57:14 -0400
Received: by mail-lj1-x242.google.com with SMTP id k18so78880868ljc.11
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TzWdXtLAUrrMBEEWJP4I6zJKWMOnmN0iEzqlYudmigQ=;
 b=g4W9SBDYNYE5i6F+dksQYRpRO4BX2DMuzPAdV16wK7x2aQ1wGkFgxbu8+Tm/ur7a3i
 fmcqYRfAGMb3NMQvgoiabqFOLHynxWg53UaSlj7K/wrkcAU5FMjV3+Lcf/+sGDDxbnmw
 k7SEsjCRBO7OjRk2s8QOVRy+yoD8ERWCA0PbeB81hAVC5DZkNBXrg3564rgc9pzeW07v
 aHFrc4YuUeKwM2k5K/dv54tQ9x/2x06HRmePnl1L4VhnCeQ03Q8yZvab3XCChSThFnXx
 m9AzVUheQtNyQnM/qz9047gQ6G40pShUOtDkiea2+tKcN0K9jmjGdGJsJWZheJGJaZLm
 tKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TzWdXtLAUrrMBEEWJP4I6zJKWMOnmN0iEzqlYudmigQ=;
 b=ZTUqMV+pZfiLWQHDq8vKWTRmSSIj0Q77+AFdV+VYMdH91/iaoN5J0rrPdpblIUA3NX
 48SNSnG8nTxC61jEbPAPRv3JjiY3g1Z6V7KZGHZ/T5YR6J427qKhuPesxpjqch5wJWnd
 KbAamOMOWELJJWUW/YDVl4jKK0G/xmyAVioPM/jkTLi3M+XleepFqheHG5bQJtTCOakM
 oHReEjFQ8/Lb4sZF3Ree7eNwYoudAs2mDSk4C7Ed6ESmo+vek/58gzTNbofR1xtz1RTB
 HIPYr9ok1g2hN1/p+YBWPLJ/PRYk8uK1c5ZMP/XaUCIht7O7m0F7LE5uE/8J+YtsvfJ6
 SADA==
X-Gm-Message-State: APjAAAXWMWfQcwPiQY5byTHMxxzomGhoqsrIZeMsnszq3THK/zn1JWuW
 h4zvLGeIOZ8y0jc4ePQIkoZ672KcXZxYXjqJX+41jw==
X-Google-Smtp-Source: APXvYqyXFtChkPbm6NCyp23ajAiI62OlDD+/hHiQbm7lI17gWZ6ZJDZrRUyF56jvAOxDqP7Qr/vCARhS5NqWxJ1VRII=
X-Received: by 2002:a05:651c:28c:: with SMTP id
 b12mr13843059ljo.69.1565002630201; 
 Mon, 05 Aug 2019 03:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190705160536.12047-1-geert+renesas@glider.be>
 <CACRpkdY6qAUkQW4YHN9HskvZS2P-viWYTHSb28ECh1p+itU=4Q@mail.gmail.com>
 <dc2016d4-b06c-aa8e-2644-90caa40fbd63@arm.com>
In-Reply-To: <dc2016d4-b06c-aa8e-2644-90caa40fbd63@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2019 12:56:58 +0200
Message-ID: <CACRpkdYeBPuR32+ZVXY0y9XrUyGuEPWEwGuF-r9D3yYa4ANJGw@mail.gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, christoffer.dall@arm.com,
 Alexander Graf <agraf@suse.de>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 5, 2019 at 12:21 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 01/08/2019 09:41, Linus Walleij wrote:

> > I would even go so far as to call it "gpio-virtualization" or
> > "gpio-virtualized" rather than "gpio-virtual" so it is clear what the
> > intended usecase is. We have a bit of confusion in the kernel
> > because people misuse the word "virtual" left and right, like for
> > "virtual IRQ number" (Linux IRQ numbers) which are just some
> > random number space, but not really "virtual", it's a semantic
> > disease similar to the confusion of using the word "manual" in
> > computer code.
>
> I'd drop the notion of "virtual" altogether. Nothing is virtual in this
> thing at all (the GPIOs are very real, from what I gather). Instead (and
> assuming I got it right, which is a long shot), what you have is a
> "synthetic" GPIO controller, made from the GPIOs belonging to other
> controllers. I'd call it "GPIO aggregator".

+1 on this.

Next thing that will predictably follow is a userspace ABI to
create those aggregators and have them go away if the
process creating it dies. Something to think of...

> > If QEMU can deal in a simple and straight-forward way with this
> > I see it quickly becoming a very useful tool for industrial automation
> > where you want to run each control system in isolation and just
> > respawn the virtual machine if something goes wrong.
>
> What the VMM (QEMU, kvmtool) would need to do is to present this as a
> "standard" GPIO IP, and use the backend aggregator to emulate it.
> Certainly doable. The nice part is that all the work is in userspace,
> and thus completely off my plate! ;-)

Yeah there is not really any "standard" GPIO, but if the user is running
e.g. a Versatile Express model, that has a PL061 GPIO, and then
a user would create an "aggregator GPIO" with say 8 lines and
QEMU would pick that up as /dev/gpiochipN and bind it inside
of QEMU to the lines of the virttualized PL061 GPIO controller,
so the machine thinks it is using a PL061 but in reality it is
just 8 GPIO lines on the host computer.

> You also may want to look into not emulating a standard IP, but use
> something virtio-based instead. The ACRN project seems to have something
> like this in progress, but I know nothing about it.

That sounds quite interesting as well.

Then the virtualized machine can just pick this "virtio GPIO" and
some command line switches or config file on the host can
set up and route a GPIO aggregator.

Yours,
Linus Walleij

