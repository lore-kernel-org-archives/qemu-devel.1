Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B4C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C293520722
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXxu/b/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C293520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZui-0000TM-Vy
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jHZtt-0008T8-TL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jHZts-0007HV-Fi
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:18:53 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jHZtr-0007DS-VS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:18:52 -0400
Received: by mail-lj1-x244.google.com with SMTP id t17so8014929ljc.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BtDnHTuIZQJxreSGmLJQQ8ku1fLzEZvZgsl/IqNsN8A=;
 b=IXxu/b/ZFJBTcuTRbJKkO3+OaHo+Jz796SjBmFajhclIBm/BsLYWIAcx9DtKHieiLy
 tC1vll/WVvRZQ+7qJ8T1OabM2kIqVG9KEwn/gO1uzvwHIs/v6r5PUIM8K2kmGH3MMNXx
 nmCCfjAEtu37RGo2HNzvtF+VDyr/FKocXnWXD6OBMy57AI/ZJMu+S2hSLH5zbmyjmr7E
 sxTlRVJ5vW38t9Cg+zhSbse1W+BZkWRDzYx/Yu4yn+IZzHSViZT5elZgxloQRh/hC7i3
 +w1dTkhKoFmmSYtRXjpmPsSyzvY/Q7+9WKp1e8RMSShyoiYZ9ziRyI4HZbJENIUJqUqy
 2vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BtDnHTuIZQJxreSGmLJQQ8ku1fLzEZvZgsl/IqNsN8A=;
 b=FGG86jHCcd0z9UYoWeJrjDvnOFdgNqpr0lKXyUDzHFaLxDm9WLv7IXKWYyHyL0QC2w
 QMtU5tfU0J9nRxDIOF9MCyiwvfzcb+iYSa02mwHdp7vzzsWhs3bazd3pQqAyQDjiTBXj
 jA+ZAC1nWX8pRWt5shoPPx3gHn1AQeM3/YQeBMiAnuTjD/4Jx/0vWEO0M9NduYJ8zG4G
 X4WpUx5AEKXRDSQg9Wn0foRp5qo5UVs3e5KXvNwigyPBLKRESdXZLXlvOTuyheNp7Gpc
 U11tBrowWt1c4iXMNaH6E8bMo0OyPSrASuifMg9XY5lrKH2NozHod1X+FWcyvzdaC3BY
 Pxnw==
X-Gm-Message-State: AGi0PuZ/e7V5iG9QB1Y+gnGH7f0DHW9ZdP7oAIEQfLNXPMXUdO6i/74S
 GOdEYefp96ombktk2TKlH8WgkH081Kp2zZVgzdDG9w==
X-Google-Smtp-Source: APiQypI3i354cA5ylzgV3u2ROOS/UyX7OA+VdV0fyyDcKpZ9OLsd6Iw0Xj96knvewn3/YsM9fw/zq6pJKSJXERmc8DI=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr5946209ljd.99.1585257530291;
 Thu, 26 Mar 2020 14:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-4-geert+renesas@glider.be>
In-Reply-To: <20200324135653.6676-4-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Mar 2020 22:18:39 +0100
Message-ID: <CACRpkdbN82n3B+Q-QVjB1jLpJAYS19fKukkDXQm3gZsuFFFM_w@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] gpiolib: Add support for GPIO lookup by line name
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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

> Currently a GPIO lookup table can only refer to a specific GPIO by a
> tuple, consisting of a GPIO controller label and a GPIO offset inside
> the controller.
>
> However, a GPIO may also carry a line name, defined by DT or ACPI.
> If present, the line name is the most use-centric way to refer to a
> GPIO.  Hence add support for looking up GPIOs by line name.
>
> Implement this by reusing the existing gpiod_lookup infrastructure.
> Rename gpiod_lookup.chip_label to gpiod_lookup.key, to make it clear
> that this field can have two meanings, and update the kerneldoc and
> GPIO_LOOKUP*() macros.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

I kind of like this approach, however there are things here that
need to be considered: the line name is in no way globally unique,
and I think there are already quite a few GPIO chips that
have the same line names assigned for every instance of that
chip.

gpiochip_set_desc_names() only warns if there is a line with
the same name on the same gpio_chip.

I suppose we need to document that the line name look-up
will be on a first-come-first-served basis: whatever line
we find first with this name is what you will get a reference
to, no matter what chip it is on, and it is possible albeit
not recommended that some other chip has a line with the
same name.

Yours,
Linus Walleij

