Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5EAC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437C52084D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="RElu+7fG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437C52084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaAfR-0006fL-58
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 22:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <uli@fpond.eu>) id 1iaAdo-0005W7-RA
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <uli@fpond.eu>) id 1iaAdn-0003Up-Jm
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:38:52 -0500
Received: from mo6-p02-ob.smtp.rzone.de ([2a01:238:20a:202:5302::3]:23458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <uli@fpond.eu>) id 1iaAdm-0003M4-Rz
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574912324;
 s=strato-dkim-0002; d=fpond.eu;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=nvzO8rqYdXuIPjP0LXy5wKBL7E3Y7S8VI2AMrtpVuGw=;
 b=RElu+7fGYs17YLIkwHHM6JS7HVpIvHfaxnXxf051pj2ZoqtWYRJmFTu6rqxFXpKiwL
 YCcAcJUq87M0n9x4ruuumATOoZE9aXxYO4e5U13kvIu/HsZsJ1lPg7YrefA4DpzGL06Z
 oGDa0SXSo96fyozoOayu/5FBso/tmkPrqUBWw+C+C4pKFr69xNmF8e9r5ZL6VgXkN2JD
 Syv3Dru9sFvooHNvRynsRMNgtj4+dkARe+tPKNz7eaghcFH9qHV4GvcIBYXtEAUeb+cd
 dues/px0Ghn+PRIzDPMltzCMM4bPSHKXxodO8X+qQOHhZAzfk5bDpukeR6pNNRorA1ws
 0b0g==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de by smtp-ox.front (RZmta 46.0.0 AUTH)
 with ESMTPSA id 604beevAS3cd2Io
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 28 Nov 2019 04:38:39 +0100 (CET)
Date: Thu, 28 Nov 2019 04:38:39 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Message-ID: <1936168849.1467696.1574912319589@webmail.strato.com>
In-Reply-To: <20191127084253.16356-2-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-2-geert+renesas@glider.be>
Subject: Re: [PATCH v3 1/7] gpiolib: Add GPIOCHIP_NAME definition
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev22
X-Originating-IP: 112.198.74.215
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5302::3
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
> The string literal "gpiochip" is used in several places.
> Add a definition for it, and use it everywhere, to make sure everything
> stays in sync.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  drivers/gpio/gpiolib-sysfs.c | 7 +++----
>  drivers/gpio/gpiolib.c       | 4 ++--
>  drivers/gpio/gpiolib.h       | 2 ++
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index fbf6b1a0a4fae6ce..23e3d335cd543d53 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -762,10 +762,9 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
>  		parent = &gdev->dev;
>  
>  	/* use chip->base for the ID; it's already known to be unique */
> -	dev = device_create_with_groups(&gpio_class, parent,
> -					MKDEV(0, 0),
> -					chip, gpiochip_groups,
> -					"gpiochip%d", chip->base);
> +	dev = device_create_with_groups(&gpio_class, parent, MKDEV(0, 0), chip,
> +					gpiochip_groups, GPIOCHIP_NAME "%d",
> +					chip->base);
>  	if (IS_ERR(dev))
>  		return PTR_ERR(dev);
>  
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index dce0b31f4125a6b3..c9e47620d2434983 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1419,7 +1419,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>  		ret = gdev->id;
>  		goto err_free_gdev;
>  	}
> -	dev_set_name(&gdev->dev, "gpiochip%d", gdev->id);
> +	dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
>  	device_initialize(&gdev->dev);
>  	dev_set_drvdata(&gdev->dev, gdev);
>  	if (chip->parent && chip->parent->driver)
> @@ -5105,7 +5105,7 @@ static int __init gpiolib_dev_init(void)
>  		return ret;
>  	}
>  
> -	ret = alloc_chrdev_region(&gpio_devt, 0, GPIO_DEV_MAX, "gpiochip");
> +	ret = alloc_chrdev_region(&gpio_devt, 0, GPIO_DEV_MAX, GPIOCHIP_NAME);
>  	if (ret < 0) {
>  		pr_err("gpiolib: failed to allocate char dev region\n");
>  		bus_unregister(&gpio_bus_type);
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index ca9bc1e4803c2979..a4a759920faa48ab 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -16,6 +16,8 @@
>  #include <linux/module.h>
>  #include <linux/cdev.h>
>  
> +#define GPIOCHIP_NAME	"gpiochip"
> +
>  /**
>   * struct gpio_device - internal state container for GPIO devices
>   * @id: numerical ID number for the GPIO chip
> -- 
> 2.17.1
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

