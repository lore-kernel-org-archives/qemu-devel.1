Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ABAC18E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C83206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C83206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH28h-0007U2-Nl
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdelvare@suse.de>) id 1jH27t-0006vV-Ly
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdelvare@suse.de>) id 1jH27r-0005nE-UF
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:15:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdelvare@suse.de>) id 1jH27r-0005kw-No
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:15:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 950E3ABD1;
 Wed, 25 Mar 2020 09:15:01 +0000 (UTC)
Date: Wed, 25 Mar 2020 10:14:57 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v6 2/8] i2c: i801: Use GPIO_LOOKUP() helper macro
Message-ID: <20200325101457.0fff5bb9@endymion>
In-Reply-To: <20200324135653.6676-2-geert+renesas@glider.be>
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-2-geert+renesas@glider.be>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 14:56:47 +0100, Geert Uytterhoeven wrote:
> i801_add_mux() fills in the GPIO lookup table by manually populating an
> array of gpiod_lookup structures.  Use the existing GPIO_LOOKUP() helper
> macro instead, to relax a dependency on the gpiod_lookup structure's
> member names.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-i2c@vger.kernel.org
> ---
> While this patch is a dependency for "[PATCH v6 4/8] gpiolib: Add
> support for GPIO lookup by line name", it can be applied independently.
> But an Acked-by would be nice, too.
> 
> Cover letter and full series at
> https://lore.kernel.org/r/20200324135328.5796-1-geert+renesas@glider.be/
> 
> v6:
>   - New.
> ---
>  drivers/i2c/busses/i2c-i801.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index ca4f096fef749302..8e64a71bea684cc7 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -1444,9 +1444,9 @@ static int i801_add_mux(struct i801_priv *priv)
>  		return -ENOMEM;
>  	lookup->dev_id = "i2c-mux-gpio";
>  	for (i = 0; i < mux_config->n_gpios; i++) {
> -		lookup->table[i].chip_label = mux_config->gpio_chip;
> -		lookup->table[i].chip_hwnum = mux_config->gpios[i];
> -		lookup->table[i].con_id = "mux";
> +		lookup->table[i] = (struct gpiod_lookup)
> +			GPIO_LOOKUP(mux_config->gpio_chip,
> +				    mux_config->gpios[i], "mux", 0);
>  	}
>  	gpiod_add_lookup_table(lookup);
>  	priv->lookup = lookup;

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

