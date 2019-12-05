Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58B7C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 21:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E3D20707
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 21:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E3D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icyLo-0007k1-OS
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 16:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robherring2@gmail.com>) id 1icyKz-0007KV-LW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robherring2@gmail.com>) id 1icyKx-0006Ys-8J
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:07:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robherring2@gmail.com>)
 id 1icyKu-0006Vf-Ve
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 16:06:57 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so3880685oth.10
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 13:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kfZJgMdMZnEWqYp4l6MRhDa+lgrmX+5UPFpYfdvrZFQ=;
 b=hu4NuF61mLNQ1XTH8h98XOhu/TJVr+XJY53IXwMk8qHLFtwECUJ+A7aPagvwLseywM
 6Nco+tkyyy2QWwQfsJEZ39W0IF+dkRfar5TgqokhAN2LvYW1AmvHe1jj8t6O7SJ7qCiP
 8QzkseDHlw+0B0Wfuo4y4IpqQ6xJc14ueKGQVMmFvI1BchjZu1ctiFHt/DpF9mzhmZdS
 i2sSTGV6TQVHWejoG9/L58E2v1As0/Xe5B63bsza/mnJ+KRl/7gE1n3jwhLzMHiweCb7
 8MWWFAtTbvFzluRZiBC7QYyzqE3mwVGhjEOoG5IUudB4CP/711l7TWDZs9KZvm5npTeG
 kSCw==
X-Gm-Message-State: APjAAAUgF8l2TtjY52z/HHBHolNYDL/S7lJ2TP3pk6vf4IehjyuGvUZ1
 ply5S4kQqX0g2HEGvzCv/g==
X-Google-Smtp-Source: APXvYqz+giNRZ8MeXlmxtPAkMj15JPvC0Xm4AbR1+kfJ6wADHeXGxnfrjZfPcXGkJATVHVwmwkF53w==
X-Received: by 2002:a9d:75c7:: with SMTP id c7mr2839523otl.181.1575580014993; 
 Thu, 05 Dec 2019 13:06:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r25sm3819723otk.22.2019.12.05.13.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 13:06:54 -0800 (PST)
Date: Thu, 5 Dec 2019 15:06:53 -0600
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3 4/7] dt-bindings: gpio: Add gpio-repeater bindings
Message-ID: <20191205210653.GA29969@bogus>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127084253.16356-5-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.68
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Phil Reid <preid@electromag.com.au>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-doc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org,
 Harish Jenny K N <harish_kandiga@mentor.com>, linux-gpio@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 09:42:50AM +0100, Geert Uytterhoeven wrote:
> Add Device Tree bindings for a GPIO repeater, with optional translation
> of physical signal properties.  This is useful for describing explicitly
> the presence of e.g. an inverter on a GPIO line, and was inspired by the
> non-YAML gpio-inverter bindings by Harish Jenny K N
> <harish_kandiga@mentor.com>[1].
> 
> Note that this is different from a GPIO Nexus Node[2], which cannot do
> physical signal property translation.

It can't? Why not? The point of the passthru mask is to not do 
translation of flags, but without it you are always doing translation of 
cells.

> 
> While an inverter can be described implicitly by exchanging the
> GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags, this has its limitations.
> Each GPIO line has only a single GPIO_ACTIVE_* flag, but applies to both
> th provider and consumer sides:
>   1. The GPIO provider (controller) looks at the flags to know the
>      polarity, so it can translate between logical (active/not active)
>      and physical (high/low) signal levels.
>   2. While the signal polarity is usually fixed on the GPIO consumer
>      side (e.g. an LED is tied to either the supply voltage or GND),
>      it may be configurable on some devices, and both sides need to
>      agree.  Hence the GPIO_ACTIVE_* flag as seen by the consumer must
>      match the actual polarity.
>      There exists a similar issue with interrupt flags, where both the
>      interrupt controller and the device generating the interrupt need
>      to agree, which breaks in the presence of a physical inverter not
>      described in DT (see e.g. [3]).

Adding an inverted flag as I've suggested would also solve this issue.

> 
> [1] "[PATCH V4 2/2] gpio: inverter: document the inverter bindings"
>     https://lore.kernel.org/linux-gpio/1561699236-18620-3-git-send-email-harish_kandiga@mentor.com/
> 
> [2] Devicetree Specification v0.3-rc2, Section 2.5
>     https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3-rc2
> 
> [3] "[PATCH] wlcore/wl18xx: Add invert-irq OF property for physically
>     inverted IRQ"
>     https://lore.kernel.org/linux-renesas-soc/20190607172958.20745-1-erosca@de.adit-jv.com/
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

