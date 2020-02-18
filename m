Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3E6C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A0921D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m5/39nMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A0921D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47eg-0001OP-DG
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rdunlap@infradead.org>) id 1j47dK-0000n9-Uw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rdunlap@infradead.org>) id 1j47dJ-00082Z-FP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:30:10 -0500
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:48592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rdunlap@infradead.org>)
 id 1j47dJ-0007tG-9l
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=wMqtvVtD8RrRuein7/mpaQL8yemoq3/xOYht63VaNdA=; b=m5/39nMtZTbYmnxnpWfY0UNdUI
 0cb6S1TlahYe11rJEWIN+zmbDpQpiSOGLTAUTINGruiYBtzQHBG7aPKjRDowRpNJzckUjM6Y9feZ5
 qUVuhmjjHaQiRwcu7n6gVcN65e2NmZmrSXwFwGEOM/vFhvRaEz/abbKA67iZvrj4S5vT8bqzjKvmD
 v901S0XF0zfdcbhHNwszhXNUfoJm1Ya4Y/4nf+4EasGQlZ/XM5i96YBf0NaxXRSHXLJ4Rn0mPRWEj
 RHOnvgSjqdWppzpwmq1woWR9r8Bc5Y8MVFTty3jXN1qxJAF+4OSKRgr4bteHIE9ijEdL9bunVdgYO
 YjCNixcg==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j47dA-0005i6-G1; Tue, 18 Feb 2020 18:30:00 +0000
Subject: Re: [PATCH v5 4/5] docs: gpio: Add GPIO Aggregator documentation
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
References: <20200218151812.7816-1-geert+renesas@glider.be>
 <20200218151812.7816-5-geert+renesas@glider.be>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e2530fff-a17c-ae90-ba92-360b828582da@infradead.org>
Date: Tue, 18 Feb 2020 10:29:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218151812.7816-5-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:7c80:54:e::133
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
 linux-doc@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert,

Just a few comments. Please see below.


On 2/18/20 7:18 AM, Geert Uytterhoeven wrote:
> Document the GPIO Aggregator, and the two typical use-cases.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
> v5:
>   - Add Reviewed-by, Tested-by,
>   - Fix inconsistent indentation.
> 
> v4:
>   - Add Reviewed-by,
>   - Drop controversial GPIO repeater,
>   - Clarify industrial control use case,
>   - Fix typo s/communicated/communicate/,
>   - Replace abstract frobnicator example by concrete door example with
>     gpio-line-names,
> 
> v3:
>   - New.
> ---
>  .../admin-guide/gpio/gpio-aggregator.rst      | 102 ++++++++++++++++++
>  Documentation/admin-guide/gpio/index.rst      |   1 +
>  2 files changed, 103 insertions(+)
>  create mode 100644 Documentation/admin-guide/gpio/gpio-aggregator.rst
> 
> diff --git a/Documentation/admin-guide/gpio/gpio-aggregator.rst b/Documentation/admin-guide/gpio/gpio-aggregator.rst
> new file mode 100644
> index 0000000000000000..114f72be33c2571e
> --- /dev/null
> +++ b/Documentation/admin-guide/gpio/gpio-aggregator.rst
> @@ -0,0 +1,102 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +GPIO Aggregator
> +===============
> +
> +The GPIO Aggregator allows to aggregate GPIOs, and expose them as a new

"allows" really wants an object following the verb [although the kernel sources
and docs have many cases of it not having an object].  Something like

                       allows {you, one, someone, users, a user} to aggregate

> +gpio_chip.  This supports the following use cases.
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

Does the above command tell the user that the new device is named
"gpio-aggregator.0", as used below?


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
> +Generic GPIO Driver
> +-------------------
> +
> +The GPIO Aggregator can also be used as a generic driver for a simple
> +GPIO-operated device described in DT, without a dedicated in-kernel driver.
> +This is useful in industrial control, and is not unlike e.g. spidev, which
> +allows to communicate with an SPI device from userspace.

   allows {choose an object} to communicate

> +
> +Binding a device to the GPIO Aggregator is performed either by modifying the
> +gpio-aggregator driver, or by writing to the "driver_override" file in Sysfs.
> +
> +Example: If "door" is a GPIO-operated device described in DT, using its own
> +compatible value::
> +
> +	door {
> +		compatible = "myvendor,mydoor";
> +
> +		gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>,
> +			<&gpio2 20 GPIO_ACTIVE_LOW>;
> +		gpio-line-names = "open", "lock";
> +	};
> +
> +it can be bound to the GPIO Aggregator by either:
> +
> +1. Adding its compatible value to ``gpio_aggregator_dt_ids[]``,
> +2. Binding manually using "driver_override":
> +
> +.. code-block:: bash
> +
> +    echo gpio-aggregator > /sys/bus/platform/devices/door/driver_override
> +    echo door > /sys/bus/platform/drivers/gpio-aggregator/bind


HTH. Thanks.
-- 
~Randy


