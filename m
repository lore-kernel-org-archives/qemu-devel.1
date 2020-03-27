Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD649C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 21:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762F820714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lahDEBVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762F820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHwg9-0006QG-Mn
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 17:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jHwfZ-00061q-8O
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jHwfY-0008Q8-0Y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:37:36 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jHwfX-0008OE-L4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:37:35 -0400
Received: by mail-lf1-x142.google.com with SMTP id h6so3323730lfp.6
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/6P/ugUG8QPN1PLqi6CLq7SxjX8NFnDCuavJA3Wde1E=;
 b=lahDEBVq+V7MEitEv24mEfdDx+ECSXtHN+KA62Gf5ItiJ1T+tDT8IWT4Oy22V9BsXC
 6JaUyn62gDbbeAweC22pKUYqIidnovzsnM7DZS/3dAC/3/rSk5L52uSrG8+ZEpNokRoF
 DAcc3GvLOC/ssSMB8MQ5gqL2f74Gp6tRux0EURwEZRovg6fD33++EMNMJHG8TpO81M7J
 Mt83QcXquqLJVR9ORbRpZm1ECFmS406DJdA7rkOGaLuwywkPfYQtd7G56RMATPaHmnNG
 GJdQYRUgmxyx9hZzmpIXWlpouQK7AOtyGExNg/CAyJqJkZU/svLfvM9MdHzKmMqw3M9X
 2vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/6P/ugUG8QPN1PLqi6CLq7SxjX8NFnDCuavJA3Wde1E=;
 b=PD27f7XmO7WiA8cACCifDaLy4CkrHFD9qE0TcUxPnmvKsjytDtujlEcySkrPSu/6jv
 mcEfiJR+sLjQSXI+uhA+wNzrbHxFe55e7rB9ms/W6c3Ymd2xj4k+i7wNSG9/TQpZmu7O
 WLxr822VaoNufyGh96jqZhPZNNYYtiDWnIFsuixCL2mYiDTEuanpWLmrVEEsiX0mblHh
 6uvNsSgV+Ks28P1O26jblUrea3BU95miaF6jNsU09Dk6pcwRZhdeaHJJPtVY9zwVt2nY
 SiWu/kzJ2GvgnfXlsc4xxjuh9RGQQxEfrwu/JwUlmEI3MUJrMpQDzKwrN1kMwqwcPgoC
 OIZw==
X-Gm-Message-State: AGi0PuZGA3BMdfCBXP+avS8yDENfW5BgxNi7LmriGXM17Df46VwJPh98
 MuEvniKs4dw9Q5XjSw8TfuuHrq4pojMOOO0Epp5gbg==
X-Google-Smtp-Source: APiQypLBRjm8m9TRh5E1Wf02gWdM2GuN6ua450wAQk3DBPj55sqZgue9A3EKHJXEe1wTh5T/OQvRR8bY8YYI7pRonwA=
X-Received: by 2002:a05:6512:6c4:: with SMTP id u4mr806577lff.89.1585345054013; 
 Fri, 27 Mar 2020 14:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-5-geert+renesas@glider.be>
In-Reply-To: <20200324135653.6676-5-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Mar 2020 22:37:22 +0100
Message-ID: <CACRpkda8Uc7fDbV8EsG+EpDGw35-k+9-U7njhaaQVvhY5rwmcg@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] gpiolib: Introduce gpiod_set_config()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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

On Tue, Mar 24, 2020 at 2:57 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The GPIO Aggregator will need a method to forward a .set_config() call
> to its parent gpiochip.  This requires obtaining the gpio_chip and
> offset for a given gpio_desc.  While gpiod_to_chip() is public,
> gpio_chip_hwgpio() is not, so there is currently no method to obtain the
> needed GPIO offset parameter.
>
> Hence introduce a public gpiod_set_config() helper, which invokes the
> .set_config() callback through a gpio_desc pointer, like is done for
> most other gpio_chip callbacks.
>
> Rewrite the existing gpiod_set_debounce() helper as a wrapper around
> gpiod_set_config(), to avoid duplication.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v6:
>   - New.

Patch applied in preparation for the next kernel cycle
so we get Geert's patch stack down.

Yours,
Linus Walleij

