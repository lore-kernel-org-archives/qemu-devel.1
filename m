Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E88206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E88206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic9Aw-0002s1-II
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1ic166-00070L-85
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1ic164-0005R6-Jw
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:51:42 -0500
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:9757)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Harish_Kandiga@mentor.com>)
 id 1ic164-0005NG-8y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:51:40 -0500
IronPort-SDR: flc7+XsGPmNvGLlrZdJgOQtFi54JYuKQBmV1vxoytG1Y+QS+rWwoPwFYy6e3EG9XkC2iyS1U/i
 9grvamY5IRFB9gW+CNZRpLt1FWHojHA+Yw8R3VIddhDCdQPXDz9xfjNwZgZz8ojwwObqDrONin
 YVyyJPsHyFBGiD5guUxbKl2VyL1XGVyxKoPzGW9qN1gWjP9FuK9KZqs0+Eo9oH1m1oYkCFFFko
 vEzKmhgLjs7nfVP5Wtm6j7lwCTipYmyZghmRTIUrrF+8UNDUKEbzDDAjgjil3L7NPDIrZpj6T9
 FkE=
X-IronPort-AV: E=Sophos;i="5.69,272,1571731200"; d="scan'208";a="43750706"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 02 Dec 2019 21:51:38 -0800
IronPort-SDR: i8krjONcTTsnPkHY7SRiGdPmITr+0xNAXFXEgjkJWTG1D1tRaDcT2sdw0OnXTIXhUqEDFgzvAR
 dttKo+ORd63AvM4to/DyzDuJF57oI5Vi7/iYpzrQEkc3xIqj3eJT457bxirU8BrDkuqz8apUvw
 JxXTyf13gnmnt2Ln1nepE0IY1Dr7ZC1/mxI+i6nWcNIcJmX2GgkCgi2Uo1v6wmGd1b+yqVAN9T
 0VLnn5Y5apijUzN7Hq0gIyZaQmf5LOaoYKcT6i2bJwuZAsOGE6Kp5TQMK0MgNeNdOFviPXHdfV
 l0k=
Subject: Re: [PATCH v3 4/7] dt-bindings: gpio: Add gpio-repeater bindings
To: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-5-geert+renesas@glider.be>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <11ae473f-cee1-241b-174c-915dc46209b1@mentor.com>
Date: Tue, 3 Dec 2019 11:21:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127084253.16356-5-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.137.252
X-Mailman-Approved-At: Tue, 03 Dec 2019 09:05:26 -0500
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


On 27/11/19 2:12 PM, Geert Uytterhoeven wrote:
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


just a suggestion: giving a gpio-line-names in the example would look useful.


