Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B10C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BD42084D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="DmmmDTgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BD42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaAgI-0007rh-BQ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 22:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <uli@fpond.eu>) id 1iaAed-0005z0-IS
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <uli@fpond.eu>) id 1iaAeb-0004gy-GH
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:39:43 -0500
Received: from mo6-p03-ob.smtp.rzone.de ([2a01:238:20a:202:5303::12]:13181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <uli@fpond.eu>) id 1iaAea-0004ZV-IF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574912377;
 s=strato-dkim-0002; d=fpond.eu;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=ovvWqqCqtCKN+01XuykkLwFdsy5R9BqiNVQImuwx8zI=;
 b=DmmmDTgd0U4oIG5s6OlVAvE4e41K6XWoX0Jwy5o+Ma+H4xAK1cGtosW0Kl22+nR0df
 g93Dm39k0clWbFuu5Jny93Uu80BkHPYkfgl1yccHP2+p78gHw4lMehT/Z/b11VVspKjJ
 Jef1qbtGTKZoPoSe/Z8WtlbHdJ7YsLzs0CFUO9oym5LhTgPuzPpPRrAQisvxlICMLsyH
 3Zb+GTtzrZIKMmmSzgj4plpR3jQpJk1FefBkGg2gKllkB6KzEkVUPlYicFdGbpR1IPR0
 MB6trIx3B/NVURgrCsYQ/pknEy6JZI+SNeEBq+EYZ1PEHtAmNTOU4LY8uIQMXM0eiTft
 I8pQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de by smtp-ox.front (RZmta 46.0.0 AUTH)
 with ESMTPSA id 604beevAS3db2Iu
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 28 Nov 2019 04:39:37 +0100 (CET)
Date: Thu, 28 Nov 2019 04:39:37 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Message-ID: <1708272897.1467701.1574912377195@webmail.strato.com>
In-Reply-To: <20191127084253.16356-5-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-5-geert+renesas@glider.be>
Subject: Re: [PATCH v3 4/7] dt-bindings: gpio: Add gpio-repeater bindings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev22
X-Originating-IP: 112.198.74.215
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5303::12
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
> Add Device Tree bindings for a GPIO repeater, with optional translation
> of physical signal properties.  This is useful for describing explicitly
> the presence of e.g. an inverter on a GPIO line, and was inspired by the
> non-YAML gpio-inverter bindings by Harish Jenny K N
> <harish_kandiga@mentor.com>[1].
> 
> Note that this is different from a GPIO Nexus Node[2], which cannot do
> physical signal property translation.
> 
> While an inverter can be described implicitly by exchanging the
> GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags, this has its limitations.
> Each GPIO line has only a single GPIO_ACTIVE_* flag, but applies to both
> th provider and consumer sides:
>   1. The GPIO provider (controller) looks at the flags to know the
>      polarity, so it can translate between logical (active/not active)
>      and physical (high/low) signal levels.
>   2. While the signal polarity is usually fixed on the GPIO consumer
>      side (e.g. an LED is tied to either the supply voltage or GND),
>      it may be configurable on some devices, and both sides need to
>      agree.  Hence the GPIO_ACTIVE_* flag as seen by the consumer must
>      match the actual polarity.
>      There exists a similar issue with interrupt flags, where both the
>      interrupt controller and the device generating the interrupt need
>      to agree, which breaks in the presence of a physical inverter not
>      described in DT (see e.g. [3]).
> 
> [1] "[PATCH V4 2/2] gpio: inverter: document the inverter bindings"
>     https://lore.kernel.org/linux-gpio/1561699236-18620-3-git-send-email-harish_kandiga@mentor.com/
> 
> [2] Devicetree Specification v0.3-rc2, Section 2.5
>     https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.3-rc2
> 
> [3] "[PATCH] wlcore/wl18xx: Add invert-irq OF property for physically
>     inverted IRQ"
>     https://lore.kernel.org/linux-renesas-soc/20190607172958.20745-1-erosca@de.adit-jv.com/
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  .../bindings/gpio/gpio-repeater.yaml          | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-repeater.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-repeater.yaml b/Documentation/devicetree/bindings/gpio/gpio-repeater.yaml
> new file mode 100644
> index 0000000000000000..efdee0c3be43f731
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-repeater.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-repeater.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO Repeater
> +
> +maintainers:
> +  - Harish Jenny K N <harish_kandiga@mentor.com>
> +  - Geert Uytterhoeven <geert+renesas@glider.be>
> +
> +description:
> +  This represents a repeater for one or more GPIOs, possibly including physical
> +  signal property translation (e.g. polarity inversion).
> +
> +properties:
> +  compatible:
> +    const: gpio-repeater
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  gpios:
> +    description:
> +      Phandle and specifier, one for each repeated GPIO.
> +
> +  gpio-line-names:
> +    description:
> +      Strings defining the names of the GPIO lines going out of the GPIO
> +      controller.
> +
> +required:
> +  - compatible
> +  - "#gpio-cells"
> +  - gpio-controller
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  # Device node describing a polarity inverter for a single GPIO
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    inverter: gpio-repeater {
> +        compatible = "gpio-repeater";
> +        #gpio-cells = <2>;
> +        gpio-controller;
> +        gpios = <&gpio 95 GPIO_ACTIVE_LOW>;
> +    };
> -- 
> 2.17.1
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

