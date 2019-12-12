Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECED214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSsBUJhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECED214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPCx-0000nZ-4N
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1ifOOp-0003Kc-UF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1ifOOo-0005Lf-GP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:20:59 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1ifOOo-0005Iu-7K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:20:58 -0500
Received: by mail-lj1-x242.google.com with SMTP id u17so2271527lja.4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 05:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hg7Wl/6CET3pvbTGNm/tGvdeGMQk6gSudBEEyfBygCo=;
 b=SSsBUJhxA1aRWawSyAxOR8XEmSe8IeDhUogI22JjnRdTk3guoUUCNE18wU5spaIBSN
 Tge40xKNTf2c46f/Ct3PtBV62vLDyTgN2F3kU/LEPoq1BJ2nnzBXF8JYtD2eEX1mqIJz
 rW7wDkFNi5MxHljIDydZyIjHe6qK9dZp/ZzKZFTU8OzgxhvVNWUmlr/+DUAbJCPCYqdT
 SZmfh20Q3fi5Bhn0MuHL9ePyN6uLVtDrP1daGTkTkZZvu5ew56B9/mLwobAy+2/ftSrB
 0Q9aN+TRxhkjgCuoZ7lNHssuUGfAJkwH65uRfr9oM3Du3HhN0ra9yv9gV/v3pVzTcRo0
 0k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hg7Wl/6CET3pvbTGNm/tGvdeGMQk6gSudBEEyfBygCo=;
 b=lAvZLoBzIzxLNCVVUfVYczuZFUzRPff70Q4Rm9eYmHwxJj+23/HYvFzTwVzviHJH/R
 fFME/grfjGDmYLl5TjQXnlXjHHuQYVlu4o75meIq2OsarFD7fEQd5bRsdtlGRmESQ91t
 /393kzYwj03jb0FEjwQWXNnrJvTsSI2m7UlkPYSH7ZP/4tDnOqw25Z3hSodiJh70cP9G
 MKIawyn+VFY+qW7sAOmlhBuUlSrJzHoR8Tm+Acn8fzvtAQwwVY/+bgiALXpwDVAdaGjE
 1KGSPzlE29CwTSJRQ4+/hM8t+H3qvNyep6mA494vCfk1V3fkM0kk6JZDoBfudtHszYeo
 WSkg==
X-Gm-Message-State: APjAAAV9wpFmYcC1N4upwHWqMQYvUe0+hYfS6cNkzjtsFy78VO/ktkWw
 wWKYpJvAYOAkQNycOW6a14sI4CgB9WdDp15beAia3Q==
X-Google-Smtp-Source: APXvYqw5fhzsAgc+HL+XC84iHcSjemi0g8V+vxBZMQOSmUPecN5cY5o5jyiYAB8ZURwvkZwuG5+myIg9qUaLJdi8vHI=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr5871004ljh.183.1576156856527; 
 Thu, 12 Dec 2019 05:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-3-geert+renesas@glider.be>
In-Reply-To: <20191127084253.16356-3-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Dec 2019 14:20:45 +0100
Message-ID: <CACRpkdYyY0eGipdK6ixZxLtdJ5px=U2mOa79VZb00NEEAEL=6g@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpiolib: Add support for gpiochipN-based table
 lookup
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert!

On Wed, Nov 27, 2019 at 9:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently GPIO controllers can only be referred to by label in GPIO
> lookup tables.
>
> Add support for looking them up by "gpiochipN" name, with "N" either the
> corresponding GPIO device's ID number, or the GPIO controller's first
> GPIO number.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

What the commit message is missing is a rationale, why is this needed?

> If this is rejected, the GPIO Aggregator documentation must be updated.
>
> The second variant is currently used by the legacy sysfs interface only,
> so perhaps the chip->base check should be dropped?

Anything improving the sysfs is actively discouraged by me.
If it is just about staying compatible it is another thing.

> +static int gpiochip_match_id(struct gpio_chip *chip, void *data)
> +{
> +       int id = (uintptr_t)data;
> +
> +       return id == chip->base || id == chip->gpiodev->id;
> +}
>  static struct gpio_chip *find_chip_by_name(const char *name)
>  {
> -       return gpiochip_find((void *)name, gpiochip_match_name);
> +       struct gpio_chip *chip;
> +       int id;
> +
> +       chip = gpiochip_find((void *)name, gpiochip_match_name);
> +       if (chip)
> +               return chip;
> +
> +       if (!str_has_prefix(name, GPIOCHIP_NAME))
> +               return NULL;
> +
> +       if (kstrtoint(name + strlen(GPIOCHIP_NAME), 10, &id))
> +               return NULL;
> +
> +       return gpiochip_find((void *)(uintptr_t)id, gpiochip_match_id);

Isn't it easier to just  augment the existing match function to
check like this:

static int gpiochip_match_name(struct gpio_chip *chip, void *data)
{
        const char *name = data;

        if (!strcmp(chip->label, name))
               return 0;
        return !strcmp(dev_name(&chip->gpiodev->dev), name);
}

We should I guess also add some kerneldoc to say we first
match on the label and second on dev_name().

Yours,
Linus Walleij

