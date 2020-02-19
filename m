Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B35C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D395B2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D395B2464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MVH-00063e-1d
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1j4MPq-0003g7-TW
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert.uytterhoeven@gmail.com>) id 1j4MPp-0005O9-IJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39269)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1j4MPp-0005Kl-DH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so22578804oty.6
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 02:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GJAqVwXdCZXPTne0AiTX4Fk1uxObKIcjDphAbJJ660k=;
 b=GjB4EWWCy+XOF7cjspH19iyHv3nbnC82rxaAEOwyMTvnn6+LNJTen8t4XfL77TPelg
 ZjOUhqVWuh4qIvRpPjm+yngEyrdwIbKkez6EvDaOM3gkt/EvirpZpAC8vAH6wkmx/Dmb
 m8PoPZyBrp20PDXtLjsBVKGr0sEv3g1NQZ3/MFuXOdYDud+lgAgNRNqt+Ls7Ro1sCTg0
 rwbFAoH12idjjlTxTKw8j8Djr0oz2qH+ysA+RxvGhnz8qC7jy36GtBRdlLCZBbos9w5k
 Qpl3sVH0r5jdnB174meyYPn3XAvCvBbdy6Tz/HAtyDSuZ9K8J0K6f523tGdhgiUTe4Rx
 VBIw==
X-Gm-Message-State: APjAAAU6/IxX0x89FeuHa0ryLY1nJgDjKYwfxAPfWQ9c9T24npoNFE0E
 Ht4JP32yJEWv3nBRrHcJ60D4TPSRHUdfdKPYGY4=
X-Google-Smtp-Source: APXvYqzZrdQJH/Cfn4il9kL1X9oAi45ce4JPx5PKjIVPqq1ze44X+v1H30gqpKR+Zhq1zOgAfO3sVmnLElkeTuTigJI=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr4220978otk.145.1582107430981; 
 Wed, 19 Feb 2020 02:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-3-geert+renesas@glider.be>
In-Reply-To: <20200218151812.7816-3-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Feb 2020 11:17:00 +0100
Message-ID: <CAMuHMdVzkN5c1P3=xD5BzC=R-O8fWJfMRdDtWxcTLO0TUy5n1Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] gpiolib: Add support for GPIO line table lookup
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
 Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 4:18 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Currently GPIOs can only be referred to by GPIO controller and offset in
> GPIO lookup tables.
>
> Add support for looking them up by line name.
> Rename gpiod_lookup.chip_label to gpiod_lookup.key, to make it clear
> that this field can have two meanings, and update the kerneldoc and
> GPIO_LOOKUP*() macros.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

> --- a/include/linux/gpio/machine.h
> +++ b/include/linux/gpio/machine.h
> @@ -20,8 +20,9 @@ enum gpio_lookup_flags {
>
>  /**
>   * struct gpiod_lookup - lookup table
> - * @chip_label: name of the chip the GPIO belongs to
> - * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO
> + * @key: either the name of the chip the GPIO belongs to, or the GPIO line name
> + * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO, or
> + *              U16_MAX to indicate that @key is a GPIO line name
>   * @con_id: name of the GPIO from the device's point of view
>   * @idx: index of the GPIO in case several GPIOs share the same name
>   * @flags: bitmask of gpio_lookup_flags GPIO_* values
> @@ -30,7 +31,7 @@ enum gpio_lookup_flags {
>   * functions using platform data.
>   */
>  struct gpiod_lookup {
> -       const char *chip_label;
> +       const char *key;
>         u16 chip_hwnum;
>         const char *con_id;
>         unsigned int idx;

This needs an update in the documentation:

--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -113,13 +113,15 @@ files that desire to do so need to include the
following header::
 GPIOs are mapped by the means of tables of lookups, containing instances of the
 gpiod_lookup structure. Two macros are defined to help declaring such
mappings::

-       GPIO_LOOKUP(chip_label, chip_hwnum, con_id, flags)
-       GPIO_LOOKUP_IDX(chip_label, chip_hwnum, con_id, idx, flags)
+       GPIO_LOOKUP(key, chip_hwnum, con_id, flags)
+       GPIO_LOOKUP_IDX(key, chip_hwnum, con_id, idx, flags)

 where

-  - chip_label is the label of the gpiod_chip instance providing the GPIO
-  - chip_hwnum is the hardware number of the GPIO within the chip
+  - key is either the label of the gpiod_chip instance providing the GPIO, or
+    the GPIO line name
+  - chip_hwnum is the hardware number of the GPIO within the chip, or U16_MAX
+    to indicate that key is a GPIO line name
   - con_id is the name of the GPIO function from the device point of view. It
        can be NULL, in which case it will match any function.
   - idx is the index of the GPIO within the function.


Furthermore, a few drivers populate the gpiod_lookup members directly,
instead of using the convenience macros:

    arch/arm/mach-integrator/impd1.c
    drivers/i2c/busses/i2c-i801.c
    drivers/mfd/sm501.c

Either they have to be updated s/chip_label/key/, or start using the macros,
e.g.

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1444,9 +1444,9 @@ static int i801_add_mux(struct i801_priv *priv)
                return -ENOMEM;
        lookup->dev_id = "i2c-mux-gpio";
        for (i = 0; i < mux_config->n_gpios; i++) {
-               lookup->table[i].chip_label = mux_config->gpio_chip;
-               lookup->table[i].chip_hwnum = mux_config->gpios[i];
-               lookup->table[i].con_id = "mux";
+               lookup->table[i] = (struct gpiod_lookup)
+                       GPIO_LOOKUP(mux_config->gpio_chip,
+                                   mux_config->gpios[i], "mux", 0);
        }
        gpiod_add_lookup_table(lookup);
        priv->lookup = lookup;

Do you have any preference?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

