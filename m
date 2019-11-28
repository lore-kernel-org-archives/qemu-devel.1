Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24615C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23532166E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="EbDoDEIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23532166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaAjm-00033m-0j
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 22:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <uli@fpond.eu>) id 1iaAg3-0007tp-HD
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <uli@fpond.eu>) id 1iaAg1-0006bu-40
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:41:11 -0500
Received: from mo6-p03-ob.smtp.rzone.de ([2a01:238:20a:202:5303::2]:19913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <uli@fpond.eu>) id 1iaAfx-0006Yl-63
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574912463;
 s=strato-dkim-0002; d=fpond.eu;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=YdruPdKAoK6txPA5JOxDAj/vTUfByn2ONRopUgEmExs=;
 b=EbDoDEIHSJuTPoiC6wax6JkBHAFOc6FHqhCmR69V6Z41s8XygDQ8/Ox3uiFYVYX/e/
 VVejnJGzPE43QBWV0eSC8oJSjuawdwDlX+7klqHJIwQUkSYwtnAI8T5ndhq64mxjcYzh
 GKKsZNzjXESnduQGPLupVeXThuVR2HQIEVjy2hcQK8fJXb4Mt1ntRD8wvabgzbQ6+ZYi
 HlmsyvLSSeQQen2Ii8I+MX5gzvnf3U6B0LdSVpSzrzpXclb0OqVBkruQHPdfxhOsCFnS
 0mBqKuznU/HDohtgBCNMmACDmzpa21mCs1gmF6PBLVmAFDcXKplAtBfuLbso5lNIc37C
 VeuQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de by smtp-ox.front (RZmta 46.0.0 AUTH)
 with ESMTPSA id 604beevAS3f32J3
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 28 Nov 2019 04:41:03 +0100 (CET)
Date: Thu, 28 Nov 2019 04:41:02 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Message-ID: <761320534.1467709.1574912462950@webmail.strato.com>
In-Reply-To: <20191127084253.16356-7-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-7-geert+renesas@glider.be>
Subject: Re: [PATCH v3 6/7] docs: gpio: Add GPIO Aggregator/Repeater
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev22
X-Originating-IP: 112.198.74.215
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5303::2
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
> Document the GPIO Aggregator/Repeater, and the three typical use-cases.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  .../admin-guide/gpio/gpio-aggregator.rst      | 111 ++++++++++++++++++
>  Documentation/admin-guide/gpio/index.rst      |   1 +
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/admin-guide/gpio/gpio-aggregator.rst
> 
> diff --git a/Documentation/admin-guide/gpio/gpio-aggregator.rst b/Documentation/admin-guide/gpio/gpio-aggregator.rst
> new file mode 100644
> index 0000000000000000..826146e260253299
> --- /dev/null
> +++ b/Documentation/admin-guide/gpio/gpio-aggregator.rst
> @@ -0,0 +1,111 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +GPIO Aggregator/Repeater
> +========================
> +
> +The GPIO Aggregator/Repeater allows to aggregate GPIOs, and expose them as a
> +new gpio_chip.  This supports the following use cases.
> +
> +
> +Aggregating GPIOs using Sysfs
> +-----------------------------
> +
> +GPIO controllers are exported to userspace using /dev/gpiochip* character
> +devices.  Access control to these devices is provided by standard UNIX file
> +system permissions, on an all-or-nothing basis: either a GPIO controller is
> +accessible for a user, or it is not.
> +
> +The GPIO Aggregator allows access control for individual GPIOs, by aggregating
> +them into a new gpio_chip, which can be assigned to a group or user using
> +standard UNIX file ownership and permissions.  Furthermore, this simplifies and
> +hardens exporting GPIOs to a virtual machine, as the VM can just grab the full
> +GPIO controller, and no longer needs to care about which GPIOs to grab and
> +which not, reducing the attack surface.
> +
> +Aggregated GPIO controllers are instantiated and destroyed by writing to
> +write-only attribute files in sysfs.
> +
> +    /sys/bus/platform/drivers/gpio-aggregator/
> +
> +	"new_device" ...
> +		Userspace may ask the kernel to instantiate an aggregated GPIO
> +		controller by writing a string describing the GPIOs to
> +		aggregate to the "new_device" file, using the format
> +
> +		.. code-block:: none
> +
> +		    [<gpioA>] [<gpiochipB> <offsets>] ...
> +
> +		Where:
> +
> +		    "<gpioA>" ...
> +			    is a GPIO line name,
> +
> +		    "<gpiochipB>" ...
> +			    is a GPIO chip label or name, and
> +
> +		    "<offsets>" ...
> +			    is a comma-separated list of GPIO offsets and/or
> +			    GPIO offset ranges denoted by dashes.
> +
> +		Example: Instantiate a new GPIO aggregator by aggregating GPIO
> +		19 of "e6052000.gpio" and GPIOs 20-21 of "gpiochip2" into a new
> +		gpio_chip:
> +
> +		.. code-block:: bash
> +
> +		    echo 'e6052000.gpio 19 gpiochip2 20-21' > new_device
> +
> +	"delete_device" ...
> +		Userspace may ask the kernel to destroy an aggregated GPIO
> +		controller after use by writing its device name to the
> +		"delete_device" file.
> +
> +		Example: Destroy the previously-created aggregated GPIO
> +		controller "gpio-aggregator.0":
> +
> +		.. code-block:: bash
> +
> +		    echo gpio-aggregator.0 > delete_device
> +
> +
> +GPIO Repeater in Device Tree
> +----------------------------
> +
> +A GPIO Repeater is a node in a Device Tree representing a repeater for one or
> +more GPIOs, possibly including physical signal property translation (e.g.
> +polarity inversion).  This allows to model e.g. inverters in DT.
> +
> +See Documentation/devicetree/bindings/gpio/gpio-repeater.yaml
> +
> +
> +Generic GPIO Driver
> +-------------------
> +
> +The GPIO Aggregator can also be used as a generic driver for a simple
> +GPIO-operated device described in DT, without a dedicated in-kernel driver.
> +This is not unlike e.g. spidev, which allows to communicated with an SPI device
> +from userspace.
> +
> +Binding a device to the GPIO Aggregator is performed either by modifying the
> +gpio-aggregator driver, or by writing to the "driver_override" file in Sysfs.
> +
> +Example: If "frobnicator" is a GPIO-operated device described in DT, using its
> +own compatible value::
> +
> +        frobnicator {
> +                compatible = "myvendor,frobnicator";
> +
> +                gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>,
> +                        <&gpio2 20 GPIO_ACTIVE_LOW>;
> +        };
> +
> +it can be bound to the GPIO Aggregator by either:
> +
> +1. Adding its compatible value to ``gpio_aggregator_dt_ids[]``,
> +2. Binding manually using "driver_override":
> +
> +.. code-block:: bash
> +
> +    echo gpio-aggregator > /sys/bus/platform/devices/frobnicator/driver_override
> +    echo frobnicator > /sys/bus/platform/drivers/gpio-aggregator/bind
> diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
> index a244ba4e87d5398a..ef2838638e967777 100644
> --- a/Documentation/admin-guide/gpio/index.rst
> +++ b/Documentation/admin-guide/gpio/index.rst
> @@ -7,6 +7,7 @@ gpio
>  .. toctree::
>      :maxdepth: 1
>  
> +    gpio-aggregator
>      sysfs
>  
>  .. only::  subproject and html
> -- 
> 2.17.1
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

