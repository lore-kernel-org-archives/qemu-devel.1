Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BCC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 21:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E24320714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 21:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRSIg1Qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E24320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHwcd-0005Dc-Kr
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 17:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jHwbx-0004nm-EY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jHwbw-0004ka-Ar
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:33:53 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jHwbw-0004jy-01
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:33:52 -0400
Received: by mail-lf1-x143.google.com with SMTP id e7so9095288lfq.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 14:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dzvDwMUyG06J3AV5cwO/m7cs6Sh4fmPAAPA7hxTv980=;
 b=gRSIg1QwEzIrjZsOKmca5lM0DJGUPgYdVr2fCBp18i17PUM79/QbUfa9whxB1yleIu
 19uOZ+GytcxmNRc+uGdfToX3iDfx/vj5Kkp0opY6r+xrlOGCbN5MmsDlz21KklP+n7hQ
 MpylNrstB6SstKltT48fN3JOCTPNt4jT6z/fjF0dX9tM8PbnFU0oJer4qREeeUNAKSpX
 6MKL5IavYbzJ1uANrnLVHQGFD6Y5HLW5QSK2FzMDh807/dLrnRAMUw/QJgFrV0cgo2Q+
 Qet9m7dtlAssP+WFw0OjcCXKeYbPU6jo6nm6uKCq3kYu0//UDnT30vx9p2BejYcVUvZh
 ZO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dzvDwMUyG06J3AV5cwO/m7cs6Sh4fmPAAPA7hxTv980=;
 b=Fqjpz6OmUJs+sLPZdNBhAlJ6m1FW4yVlfgscxUgK0nP4TyzWESBimYC6rGwcUJCYTm
 5AxArTjph61bDKO/Gc1jaV3M24kUvYrZxmOfznFJ5Jfu/lIO8ASfYBGORat3pcr3Onc6
 oiQpT16yDnJz+ckO5gVeRnvKu4SIEfWgOijy5ORKFNsKcsLZe3OF6pXtGS5O/wJI4jq0
 SokuCC1RUqaqHwMRaQ4joK9oIotwoGo3uqhf14iFOSycx0SknVmAwg4ls9EHk4dNI7MR
 uZcA/3dEdaFNWcpMIcohf3afMjTnn/eSthIFXY3eBw/qAHdm5TqfSBSu0rF+2nA3FXlS
 7LRQ==
X-Gm-Message-State: AGi0PuaeEq/JO04D4bvGu3QiqTtQSm0pC15oL7wCOQrJqVgVm2d1wUMz
 sQt84Yc1plBRDhtA1ygziLjkvGfrgwE1hKeiQMAEXQ==
X-Google-Smtp-Source: APiQypLPB2bx74iqYlIDZcf1TI5kqtkeuL4BUeP6Olm1S22lCTiyT7KkrzX0yGdpEq6wWOI9W+VlzHcPMEoWS21Y4Is=
X-Received: by 2002:a19:be92:: with SMTP id o140mr740571lff.217.1585344830265; 
 Fri, 27 Mar 2020 14:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-5-geert+renesas@glider.be>
 <CACRpkdZuQrPqFPyoop9pv6MVwqwz_C6ZNKMxWqSFXdAMkhbsvQ@mail.gmail.com>
 <CAMuHMdVpiO+KGRTF=83kubuuJF2p8TJhWe_X32amSTa6bXsCxg@mail.gmail.com>
In-Reply-To: <CAMuHMdVpiO+KGRTF=83kubuuJF2p8TJhWe_X32amSTa6bXsCxg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Mar 2020 22:33:38 +0100
Message-ID: <CACRpkdaG0Fd7rpfqO6p0j9RL3T-whCof=YewH=rR3Bwe89KeUA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] gpiolib: Introduce gpiod_set_config()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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

On Fri, Mar 27, 2020 at 9:45 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Mar 26, 2020 at 10:26 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Mar 24, 2020 at 2:57 PM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > The GPIO Aggregator will need a method to forward a .set_config() call
> > > to its parent gpiochip.  This requires obtaining the gpio_chip and
> > > offset for a given gpio_desc.  While gpiod_to_chip() is public,
> > > gpio_chip_hwgpio() is not, so there is currently no method to obtain the
> > > needed GPIO offset parameter.
> > >
> > > Hence introduce a public gpiod_set_config() helper, which invokes the
> > > .set_config() callback through a gpio_desc pointer, like is done for
> > > most other gpio_chip callbacks.
> > >
> > > Rewrite the existing gpiod_set_debounce() helper as a wrapper around
> > > gpiod_set_config(), to avoid duplication.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v6:
> > >   - New.
> >
> > This is nice, I tried to actually just apply this (you also sent some
> > two cleanups that I tried to apply) byt Yue's cleanup patch
> > commit d18fddff061d2796525e6d4a958cb3d30aed8efd
> > "gpiolib: Remove duplicated function gpio_do_set_config()"
> > makes none of them apply :/
>
> /me confused.
>
> That commit was reverted later, so it shouldn't matter.
>
> I have just verified, and both my full series and just this single
> patch, do apply fine to all of current gpio/for-next, linus/master, and
> next-20200327.  They even apply fine to gpio/for-next before or after
> the two cleanups I sent, too.
>
> What am I missing?

Ah I see, it is because my development branch is based on
v5.6-rc1. So I have to merge in a later -rc where this revert
is applied so that this applies.

Yours,
Linus Walleij

