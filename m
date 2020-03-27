Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60245C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C6220714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C6220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkcx-0003wF-DV
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 04:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jHkcG-0003E9-QJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1jHkcF-0001bp-Iu
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:45:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jHkcF-0001ZY-EC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:45:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id c9so8884025otl.12
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 01:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eOBjyRt4JV8Fw0zzDZumBm7LVivMqi17PPfNiqHh3qk=;
 b=OIEn0l7JIvFd0IjSuxob2EizSeU4EJb5J7dYMavmKaQj5hsBKHkxkGdpwiVrvFMJaW
 l6WLszFEQz9hJDiGe3Sd/C7AqKwXnLvsiyt3AonYHGkXWj155XAaTAwvpvOGF75fsheL
 7BjMsopQVHpgp7tBA1VSfOv/i/iwndOPKq4lFDbMM371nYVBky4mfLacu5/ntwEkkNT5
 z+Q7At+OEGW1Z07iPcEhGeB+qJrMoOGk/Zgc+x1uTA2lOcaPuq5IOr29iHcDvnPfBYcR
 51kEh7IKxvHw0x2l1ccGG7YztZQ32Ifzrj7RQfOaFrlbgvOTVhwdPXqDbfvwjqPtogmB
 YJ6A==
X-Gm-Message-State: ANhLgQ3piHxRNxypzJ9+bjVG1BeQO1IsdGXkziix+8zn+EmehQ4Jlt5+
 HzrweYAdsPtafYexR8fVFbL1m+2yh+ula8fU3aQ=
X-Google-Smtp-Source: ADFU+vtagf4b+RAfGcuiioWln2gooMsQamKP8V2Ub80rkt/+u/ChxOOa1j8Iz++kwA+q3IcKZA+D0S4VCVlwIW0ISTU=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr9385922otk.250.1585298722494; 
 Fri, 27 Mar 2020 01:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-5-geert+renesas@glider.be>
 <CACRpkdZuQrPqFPyoop9pv6MVwqwz_C6ZNKMxWqSFXdAMkhbsvQ@mail.gmail.com>
In-Reply-To: <CACRpkdZuQrPqFPyoop9pv6MVwqwz_C6ZNKMxWqSFXdAMkhbsvQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Mar 2020 09:45:11 +0100
Message-ID: <CAMuHMdVpiO+KGRTF=83kubuuJF2p8TJhWe_X32amSTa6bXsCxg@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] gpiolib: Introduce gpiod_set_config()
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
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Linus,

On Thu, Mar 26, 2020 at 10:26 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Mar 24, 2020 at 2:57 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > The GPIO Aggregator will need a method to forward a .set_config() call
> > to its parent gpiochip.  This requires obtaining the gpio_chip and
> > offset for a given gpio_desc.  While gpiod_to_chip() is public,
> > gpio_chip_hwgpio() is not, so there is currently no method to obtain the
> > needed GPIO offset parameter.
> >
> > Hence introduce a public gpiod_set_config() helper, which invokes the
> > .set_config() callback through a gpio_desc pointer, like is done for
> > most other gpio_chip callbacks.
> >
> > Rewrite the existing gpiod_set_debounce() helper as a wrapper around
> > gpiod_set_config(), to avoid duplication.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v6:
> >   - New.
>
> This is nice, I tried to actually just apply this (you also sent some
> two cleanups that I tried to apply) byt Yue's cleanup patch
> commit d18fddff061d2796525e6d4a958cb3d30aed8efd
> "gpiolib: Remove duplicated function gpio_do_set_config()"
> makes none of them apply :/

/me confused.

That commit was reverted later, so it shouldn't matter.

I have just verified, and both my full series and just this single
patch, do apply fine to all of current gpio/for-next, linus/master, and
next-20200327.  They even apply fine to gpio/for-next before or after
the two cleanups I sent, too.

What am I missing?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

