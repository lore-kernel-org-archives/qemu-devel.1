Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A3C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DB220719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAM3YCcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DB220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZkE-0005FW-Ub
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jHZjV-0004pX-9B
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jHZjS-0007xh-GB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:08:08 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jHZjS-0007sP-05
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:08:06 -0400
Received: by mail-lj1-x242.google.com with SMTP id f20so8044172ljm.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qAyBvgO4bOnc2gaynrGXEwwg2q9+bev/7Krv5slmOVU=;
 b=qAM3YCcZs+npTx9BPPePlvKxpXslhpkUmEgugnm4zAlkgCuERkzo5/Ny5AqJKWuNI0
 ee9NxL1Vene0EIe9MIIcEKVSNl3ELO9DzQV1v6OPZG/ymJS0GzpS5HpxEvajOFYGjLg/
 8hTPoBBa+SZXYZv6GDDVEZOCIWiZqN1g2fSUO5WXwcWQv99jmowC0bv5jm8HQyAY9R0W
 WdBbuyvVCJZ2oMFZsQJAT+IreTv93hXErVplWvMb+uKMkrZFThR29bTqy3mIrEYIHPb1
 cOi1OYNIA3oIG4m5I6aUIgAH2xkWc7L3IilysL0bNP6jOWASQMrsZRbeWVUn4aYTPotV
 ivYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qAyBvgO4bOnc2gaynrGXEwwg2q9+bev/7Krv5slmOVU=;
 b=e18uRxqMIMzyLoVtFw3IZbMDZH8m2Z1LC1y9NihrLXa37HIw/uLiO+kdRa6LyPB6dl
 pV6WNX9D/Tok/pzZqQUq9xvOo0vClo8heoJtOn3kgy5uNb7Xl7G2FR9nl4pGdzbrif5/
 eQWFbIwVKkYOWucciaNwbg1uzFoUOwDexWv+nu98kqGmuJyySr1RuPxUObrpMQtm46GJ
 IYXAUzfvKwgZSWZViJiyJ0LlsYVmpLloaSMGBbmkNwpmq+Aie6wND9bkAtvxy/buVrdY
 jUqeIkZ77B+px1fYyCpb1WptITBH7hWshO2wARU5TH5ut/NzDz5hXo62VyXKdEYCmIJz
 6gvw==
X-Gm-Message-State: AGi0PuZPzOVCYcFdtjugbqWVTzu0IAyUOEbO9/Hzlk3ceQE+akcMY4Q7
 PnJ/tH1WQwpBX+zgRvBz9Zeup84NWrwiuTYTVpZ+gA==
X-Google-Smtp-Source: APiQypKkTPp+fGz1ypK0j7lnjDyL1kGteAfWqjf8dTuHziw1bMtpKGCBe6kauaYbNGvlyl7GaC+Y5sCmhx3hwF0rDz8=
X-Received: by 2002:a05:651c:28a:: with SMTP id
 b10mr3830382ljo.223.1585256882978; 
 Thu, 26 Mar 2020 14:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
In-Reply-To: <20200324135653.6676-1-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Mar 2020 22:07:51 +0100
Message-ID: <CACRpkdb=AVvyo6EOigKv+t5L4U=VjJ-16_ERimDvVWuCiU4Mxg@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] ARM: integrator: impd1: Use GPIO_LOOKUP() helper
 macro
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 2:57 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> impd1_probe() fills in the GPIO lookup table by manually populating an
> array of gpiod_lookup structures.  Use the existing GPIO_LOOKUP() helper
> macro instead, to relax a dependency on the gpiod_lookup structure's
> member names.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> While this patch is a dependency for "[PATCH v6 4/8] gpiolib: Add
> support for GPIO lookup by line name", it can be applied independently.
> But an Acked-by would be nice, too.

I simply applied this patch for v5.7 in the GPIO tree since I am the
maintainer of this platform, and I might want to change stuff around
Integrator next cycle so it's good to have this covered.

Yours,
Linus Walleij

