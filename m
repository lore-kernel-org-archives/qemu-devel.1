Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72452C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0002084D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="W1lZd6RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0002084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaAfe-0006tk-Be
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 22:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <uli@fpond.eu>) id 1iaAdu-0005Z6-Vt
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <uli@fpond.eu>) id 1iaAdt-0003k4-QR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:38:58 -0500
Received: from mo6-p02-ob.smtp.rzone.de ([2a01:238:20a:202:5302::2]:28300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <uli@fpond.eu>) id 1iaAdt-0003fj-J0
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574912335;
 s=strato-dkim-0002; d=fpond.eu;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=va5LV254c4pnUOB90TgtULX8HfyB7kptyTfdt98+XQ0=;
 b=W1lZd6ROgJkHpvB2vrObHztoe5P/QoryMHJrhiM5vdSwhwRHackMQiH/o0zhNYzbmF
 HSkqyEYOdlZVUplRctX+ZqQ9a6AMI4O88mlF5ddPmQwa4JlpAyko3Q7/C7DBi4Jatt+i
 hJZfnvCsnrXYfMbZk/5UO9V090yHYeJtkDXzb3Rt2nAfTwAwbc0ur4BejLwSg41Hhhca
 o1xPziQ4i8UaiHmOSy93mgimg3fd8hLumg/bdixoShr9h2MKtHFAt3c0C2J0tQWBnT5o
 YxBzoAwahz2dWJoqlgS/3lfgZYi/n5NIWjCdQQV17oT/yba3fQekE5M4R7X1nGvQYiyK
 M20A==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de by smtp-ox.front (RZmta 46.0.0 AUTH)
 with ESMTPSA id 604beevAS3ct2Ip
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 28 Nov 2019 04:38:55 +0100 (CET)
Date: Thu, 28 Nov 2019 04:38:55 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Message-ID: <1979629875.1467698.1574912335764@webmail.strato.com>
In-Reply-To: <20191127084253.16356-3-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-3-geert+renesas@glider.be>
Subject: Re: [PATCH v3 2/7] gpiolib: Add support for gpiochipN-based table
 lookup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev22
X-Originating-IP: 112.198.74.215
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5302::2
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 linux-doc@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On November 27, 2019 at 9:42 AM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> Currently GPIO controllers can only be referred to by label in GPIO
> lookup tables.
> 
> Add support for looking them up by "gpiochipN" name, with "N" either the
> corresponding GPIO device's ID number, or the GPIO controller's first
> GPIO number.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> If this is rejected, the GPIO Aggregator documentation must be updated.
> 
> The second variant is currently used by the legacy sysfs interface only,
> so perhaps the chip->base check should be dropped?
> 
> v3:
>   - New.
> ---
>  drivers/gpio/gpiolib.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index c9e47620d2434983..d24a3d79dcfe69ad 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1746,9 +1746,29 @@ static int gpiochip_match_name(struct gpio_chip *chip, void *data)
>  	return !strcmp(chip->label, name);
>  }
>  
> +static int gpiochip_match_id(struct gpio_chip *chip, void *data)
> +{
> +	int id = (uintptr_t)data;
> +
> +	return id == chip->base || id == chip->gpiodev->id;
> +}
> +
>  static struct gpio_chip *find_chip_by_name(const char *name)
>  {
> -	return gpiochip_find((void *)name, gpiochip_match_name);
> +	struct gpio_chip *chip;
> +	int id;
> +
> +	chip = gpiochip_find((void *)name, gpiochip_match_name);
> +	if (chip)
> +		return chip;
> +
> +	if (!str_has_prefix(name, GPIOCHIP_NAME))
> +		return NULL;
> +
> +	if (kstrtoint(name + strlen(GPIOCHIP_NAME), 10, &id))
> +		return NULL;
> +
> +	return gpiochip_find((void *)(uintptr_t)id, gpiochip_match_id);
>  }
>  
>  #ifdef CONFIG_GPIOLIB_IRQCHIP
> -- 
> 2.17.1
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

