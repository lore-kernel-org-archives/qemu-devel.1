Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE425C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12FA20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1ZbV8ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12FA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHa2Q-000681-SE
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jHa1V-0005Wh-CI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jHa1U-0007ak-2n
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:26:45 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jHa1T-0007YK-RF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:26:44 -0400
Received: by mail-lj1-x242.google.com with SMTP id 19so8027029ljj.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K6HhQ5CXYnVrjzdCb0GiH9KRJ8oDBIqHlDAtHtGoEj0=;
 b=R1ZbV8ZHF2uNrvQMw6yLPcZXYX/L1Bi1ZDegFPmpGCQZQxDo4xJstG1+5lxSGccQjM
 DtHC3HQ/jx2YMTytcd6ultwEU/i0RlVnZivmFm9vimqHtelawlsMju+sVKJ7lHhUFclt
 CAT0JwPBKGwAs7QH0zYIR8ngkUu1HqQt+JNM8LA/bSlIAM7ldYL3U3TWwGQQsnl/Hel9
 6kj0OiO6KeusAjhbIL7po4EZAoa2QzUuNNDHmg7OdxCfj5w04nJlHikrm/4rjGHXVBbt
 BztQyx2aUzDzf8VaHiOVqUzXyYasFaATNZCxsfBVkbIyEnDecxq0KQKBEI2iK76fHmnY
 Nh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K6HhQ5CXYnVrjzdCb0GiH9KRJ8oDBIqHlDAtHtGoEj0=;
 b=tVKp1kUzFD7GMVgyeto/URr7Riu90141OOgwHZhirPSGF7HuYq+dmZ5xbmEafg033o
 ojl0pSL6YlwQu03SCBEwhVWTs8nuA6y7DhrA7RZOa2SBpcuF8oQQkhJBFTgJT9X4wl76
 UlV5Jbl/nRCQF1BUMMfXLP7MUegLjElyuwz9W78OMtc3s7uHhDPV3kI9FA/u5N48vi+7
 2NjG3Zzmgj3e9CeteGjG9uEqdk1hLkjV/r+7Cywg+zLQOOEQufyRf4XSvK9wRg8jqsQi
 oYf2lc/J0m1knLtJUJ+ceQFFP/pnH6vUGtj7k8S5Ni+yiz7prqzim4j9qnj2X6Oo6nQs
 alwQ==
X-Gm-Message-State: AGi0PubC1dbowO4RGzoe8NEVKbi+7250mzJiKiOf/D58ChTU92S7INo3
 pJ8Ptk4BZ+n5+j1sdYfzS8ic+Jw9AM8qsQMevyochw==
X-Google-Smtp-Source: APiQypLsy28BzQ4YoJJE2i0gYrneALBvsp4MxQ5uVCHUPAjFEGFTMqFCGi01B7eAtiikChneeDns42u4uM1vGmEAXuk=
X-Received: by 2002:a2e:9c48:: with SMTP id t8mr568502ljj.168.1585258002139;
 Thu, 26 Mar 2020 14:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-5-geert+renesas@glider.be>
In-Reply-To: <20200324135653.6676-5-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Mar 2020 22:26:30 +0100
Message-ID: <CACRpkdZuQrPqFPyoop9pv6MVwqwz_C6ZNKMxWqSFXdAMkhbsvQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] gpiolib: Introduce gpiod_set_config()
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

This is nice, I tried to actually just apply this (you also sent some
two cleanups that I tried to apply) byt Yue's cleanup patch
commit d18fddff061d2796525e6d4a958cb3d30aed8efd
"gpiolib: Remove duplicated function gpio_do_set_config()"
makes none of them apply :/

Yours,
Linus Walleij

