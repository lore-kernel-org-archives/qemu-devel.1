Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8348C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FF4214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYTDu33S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FF4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPbC-0004o4-Ie
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1ifPa1-0003zl-7v
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1ifPa0-0002zg-54
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:36:37 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1ifPZz-0002xS-SY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:36:36 -0500
Received: by mail-lj1-x241.google.com with SMTP id s22so2534925ljs.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 06:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mFBaysu79yDikUBKmCJOSK+/KcLNsfSxo1Kg6RMTYzo=;
 b=CYTDu33S/uRKGhVT7parvwID0Z4EEkvon8ISEhgQg581I+1vygWkVRJfIX6VyR90IP
 5s90on/IBWtzNCkfiPg7uk+yBQZZgeRl/SRSDr7c+w33usVVyP+MJiAG1YhQEWLjO/Lm
 P/0CD0GARye2OYMRl25h1tC04+CXoKFn2YTnfaKWCVyq0RUQtJskTe7aNXDDUW4mR74/
 t7GoesEcr1oPDRiIJXWl4xt+DmU6FKcdogFEPM7GJ0MbM1/bRU5TyZ/4OU2CRtiJtNg9
 8b733kTi7YVBHa42ZnE/qE1MABlz/YuyRm0mRdXrwoA54K3MFcLxF9VgrBgIm71NLVT5
 m2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mFBaysu79yDikUBKmCJOSK+/KcLNsfSxo1Kg6RMTYzo=;
 b=DWx/vmX+g18Teoz0Z/A8FYeNAFub9p2YIn//cX6ZRxQaPQIatYXyAqKCov2ziV7IFO
 XkJs8xYaEFyoMs7QxCTuOLqVZ4UcLKUkRl+9n03/2ShQ4KIdm2GKlQXcBMNzY1KKHSP0
 4fov2yO24gJMxg5QBkqemlmbBZM12ABOGcigtlOQbYi+e4v8ETq/BM9ZHiOsR2moOOgD
 MaPh1Q/3RrOFbzLPG8Fzo9rcY0sfw/5ROe9SubDa5/WuLmAW9cDLb0juMGBL6ekmz9CA
 y+cyIxeX1gEom27nCxzPU+rTVM62cbc2GwBaLvtqrZ6/xOw9n1F/9DvC22g0LOiLVWg5
 Ijtg==
X-Gm-Message-State: APjAAAUgT7+6hCTOMf6Jat7JIRYiU2zn1TC24+ba3RN0cxBLGrrBibpB
 kwO+G88UBgKs5bIffWi/jo+9wDbTcDJeAiVJEbuPxA==
X-Google-Smtp-Source: APXvYqz/zPYVnRmIpLFYccngv9dixRG8YUx2SGeQvmu/20Gvhakgo9h/gmYehDYbcCI+QIDTfrgweSqbzBJTINCecCM=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr6119798ljh.183.1576161394471; 
 Thu, 12 Dec 2019 06:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-3-geert+renesas@glider.be>
 <CACRpkdYyY0eGipdK6ixZxLtdJ5px=U2mOa79VZb00NEEAEL=6g@mail.gmail.com>
 <CAMuHMdVL2w=DzOHTh-Tq6NZLTNUKxUneMi3wX71Z83mdsy3LTA@mail.gmail.com>
In-Reply-To: <CAMuHMdVL2w=DzOHTh-Tq6NZLTNUKxUneMi3wX71Z83mdsy3LTA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2019 15:36:22 +0100
Message-ID: <CACRpkdZ0geBk4oBkjb3w9kep-jWMUdpegngspN0yhKRaNY0ZKQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpiolib: Add support for gpiochipN-based table
 lookup
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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

On Thu, Dec 12, 2019 at 2:33 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Dec 12, 2019 at 2:20 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Currently GPIO controllers can only be referred to by label in GPIO
> > > lookup tables.
> > >
> > > Add support for looking them up by "gpiochipN" name, with "N" either the
> > > corresponding GPIO device's ID number, or the GPIO controller's first
> > > GPIO number.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > What the commit message is missing is a rationale, why is this needed?
>
> Right. To be added: so they can be looked up in the GPIO lookup table
> using either the chip's label, or the "gpiochipN" name.

After reading the aggregator/forwarder driver I am not convinced
that this is needed at all and I think this patch can be dropped,
but check my review and see what you think!

Thanks,
Linus Walleij

