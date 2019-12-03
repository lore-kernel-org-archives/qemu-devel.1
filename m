Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03820C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8632B2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8632B2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic3QM-0006MD-Hi
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 03:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ic3Nu-0005aO-AU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1ic3Nt-00027n-42
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:18:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1ic3Ns-00025O-Re
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:18:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id i4so2174436otr.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 00:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gBtOE1GdWf2jzATlRbrF8r8Pac6d5nQ4OzH7cwGAR94=;
 b=SMpzwVKdXsvY+kCM4v7JFL2aNSVmmch4m/h1wCooZwJ8RNE9q6o3zZZ8yQ13jYExy3
 vTLNibpvEjZNcNcR2Qqx3vpEd+qc8bFioh4FxkxsBhfiU+dQo6oM5Rse9EAhnI0Ocp5J
 zyyJDPADW/PM60CiiMb7FA2WyNV4LEHmZa36l64P8dwwHTUChB9i+AE9pMsBP8NO097f
 MRig4551KtUpnWHj3jVn+oymL+xcX72esInwPbM79pypyV2cMrGHG73084rHjr82V/HO
 mL9ekbd5Lti0tGfOa1qW95s6lENTZj5L0HT1GIMUGXsuot/cTT9hfOzh3KhnTG0og5Q3
 C3Gw==
X-Gm-Message-State: APjAAAVnVbfX01mDvTgogdPzxUY/A9v+ZE3ti4PT5xz9q17IK9QmRGHo
 ecHbEpj6oHSO3Daf7L2ZwkEbhfszk2SsW+tiXK0=
X-Google-Smtp-Source: APXvYqzBuvWMWrwsEDDhZ2tcNfeX7um84g4QQ5ld7WP0VV8LQtkLVFpjZhnV4oe+jaJ4tYQpo65700XzoJh4+uCOqZU=
X-Received: by 2002:a9d:3a37:: with SMTP id j52mr2353717otc.39.1575361089532; 
 Tue, 03 Dec 2019 00:18:09 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
 <585c4ad9-31fc-e87e-07c4-b8d6aa09c7e4@mentor.com>
In-Reply-To: <585c4ad9-31fc-e87e-07c4-b8d6aa09c7e4@mentor.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Dec 2019 09:17:58 +0100
Message-ID: <CAMuHMdW-n8ao7t7156WYxRg7v8+ojXsRgHGUOax=9nBo2F5xOw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
To: Harish Jenny K N <harish_kandiga@mentor.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
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
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Alexander Graf <graf@amazon.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Harish,

On Tue, Dec 3, 2019 at 6:42 AM Harish Jenny K N
<harish_kandiga@mentor.com> wrote:
> > +static int gpio_aggregator_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct gpio_desc **descs;
> > +     struct gpiochip_fwd *fwd;
> > +     int i, n;
> > +
> > +     n = gpiod_count(dev, NULL);
> > +     if (n < 0)
> > +             return n;
> > +
> > +     descs = devm_kmalloc_array(dev, n, sizeof(*descs), GFP_KERNEL);
> > +     if (!descs)
> > +             return -ENOMEM;
> > +
> > +     for (i = 0; i < n; i++) {
> > +             descs[i] = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
>
> can you please add this check as well as we need to return EPROBE_DEFER.
>
> if (desc[i] == ERR_PTR(-ENOENT))
> <                 return -EPROBE_DEFER;

So gpiod_get_index() nevers return -EPROBE_DEFER, but returns -ENOENT
instead?
How can a driver distinguish between "GPIO not found" and "gpiochip driver
not yet initialized"?
Worse, so the *_optional() variants will return NULL in both cases, too, so
the caller will always fall back to optional GPIO not present?

Or am I missing something?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

