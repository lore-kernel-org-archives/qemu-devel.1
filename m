Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635B0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 02:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280C522B51
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 02:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKnAOBum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280C522B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmpIP-0003aY-Fb
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 22:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmpHc-00032U-0k
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 22:00:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmpHZ-0000xy-TD
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 22:00:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id r18so6426821pgk.11
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 19:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Eu2ltL/J/UEiR6+pkgX4KilzggFxN5V/18+9DpZHl1w=;
 b=mKnAOBumxHCaSGrXEmoWPhXJiDVgLS8lp9145JmYNKOMjBT56La9CF0AcYw9npRRqA
 1SaoFPUDbAHMr9T9i788wu+6oqAV3qYCqxZ69Hjq6BWQUwZha8hnPD5jJPJVSKINysGj
 tZJw57PeWKBY3O8u4k1ViatbaN/3EYCHHDXFZjr1XiwlfUFmtKcWKDExBNaAUzk68mUl
 AE479Y3vZwQnlRb6uirS2I9xIVtX+z5NFxBwjucX0C5dXrKN8CCxeUMHwPRFzEerDwHH
 OSmawIo5llwJA+pQe5DJ8Ex3i3XlLHgapkSsWsCcTDupL8dJvQptRirl37/DBZpmEFB+
 qVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Eu2ltL/J/UEiR6+pkgX4KilzggFxN5V/18+9DpZHl1w=;
 b=eD6FToQyvECtzbSJjvlCGEcc3sKVPE7K+W3IpCWp1c+Mt8Hbo+NE1Vx5QnNaJMKgIA
 J4hB1H+MwIJtM6XkSv9QTbLyFR+2jUO6Lc1/LI2x3fxEOE5PS1kjTpVsYjNgRyiVCPhg
 jjQ/GKh5MvNTXhuasK2IWpCJEW6PmzvseVrExmmICRWi0nzjFB7E4baMr/TG0seY9j2b
 5kBh5MMDBFty6NdUDTebdex5OvmHWgkpQPkP/y7X4vC2fd0b/iAAHxM6/CXyWWbjJLaE
 E8tOUadKh5eJuhFe+rg6/ATtc9pekwWx8bv3rnkdGm4ToxI7dK/BEDY431Tt1+Ox4pfQ
 6asQ==
X-Gm-Message-State: AOAM533tqWr9eH/avbA5JY8yGL+we3sNOwtj57xEn75+PlpVHt4viFO1
 9FvEPylQ6ka5l7gn8rClS38jtA==
X-Google-Smtp-Source: ABdhPJxotbnXe2lDgVShxVx+UFKkqrv2oJ01++ky2FYvWS3tGilbdJqaPQradFyIJ5ixkj2B5QYIIA==
X-Received: by 2002:a63:5b63:: with SMTP id l35mr7958823pgm.34.1592704828254; 
 Sat, 20 Jun 2020 19:00:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j16sm1639455pgb.33.2020.06.20.19.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 19:00:27 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] hw/misc: Add a LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2cc97dc-87c8-5cc8-e0fb-026cf80c25fa@linaro.org>
Date: Sat, 20 Jun 2020 19:00:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620230719.32139-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/20 4:07 PM, Philippe Mathieu-Daudé wrote:
> Add a LED device which can be connected to a GPIO output.
> LEDs are limited to a set of colors.
> They can also be dimmed with PWM devices. For now we do
> not implement the dimmed mode, but in preparation of a
> future implementation, we start using the LED intensity.
> When used with GPIOs, the intensity can only be either
> minium or maximum. This depends of the polarity of the
> GPIO.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/misc/led.h |  79 +++++++++++++++++++++++++++
>  hw/misc/led.c         | 121 ++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS           |   6 +++
>  hw/misc/Kconfig       |   3 ++
>  hw/misc/Makefile.objs |   1 +
>  hw/misc/trace-events  |   3 ++
>  6 files changed, 213 insertions(+)
>  create mode 100644 include/hw/misc/led.h
>  create mode 100644 hw/misc/led.c
> 
> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
> new file mode 100644
> index 0000000000..821ee1247d
> --- /dev/null
> +++ b/include/hw/misc/led.h
> @@ -0,0 +1,79 @@
> +/*
> + * QEMU single LED device
> + *
> + * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef HW_MISC_LED_H
> +#define HW_MISC_LED_H
> +
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_LED "led"
> +#define LED(obj) OBJECT_CHECK(LEDState, (obj), TYPE_LED)
> +
> +typedef enum {
> +    LED_COLOR_UNKNOWN,
> +    LED_COLOR_RED,
> +    LED_COLOR_ORANGE,
> +    LED_COLOR_AMBER,
> +    LED_COLOR_YELLOW,
> +    LED_COLOR_GREEN,
> +    LED_COLOR_BLUE,
> +    LED_COLOR_VIOLET, /* PURPLE */
> +    LED_COLOR_WHITE,
> +    LED_COLOR_COUNT
> +} LEDColor;

Is color especially interesting, given that we only actually "display" the
color via tracing?

> +/* Definitions useful when a LED is connected to a GPIO */
> +#define LED_RESET_INTENSITY_ACTIVE_LOW  UINT16_MAX
> +#define LED_RESET_INTENSITY_ACTIVE_HIGH 0U
> +
> +typedef struct LEDState {
> +    /* Private */
> +    DeviceState parent_obj;
> +    /* Public */
> +
> +    /* Properties */
> +    char *description;
> +    char *color;

The enumeration is unused by the actual device, it would seem?

> +/**
> + * led_set_intensity: set the state of a LED device
> + * @s: the LED object
> + * @is_on: boolean indicating whether the LED is emitting
> + *
> + * This utility is meant for LED connected to GPIO.
> + */
> +void led_set_state(LEDState *s, bool is_on);

Comment mismatch.


> +void led_set_intensity(LEDState *s, uint16_t new_intensity)
> +{
> +    trace_led_set_intensity(s->description ? s->description : "n/a",
> +                            s->color, new_intensity);

Why not default description upon reset/realize?

> +static void led_realize(DeviceState *dev, Error **errp)
> +{
> +    LEDState *s = LED(dev);
> +
> +    if (s->color == NULL) {
> +        error_setg(errp, "property 'color' not specified");
> +        return;
> +    }
> +}

Indeed, why not insist that description is set?  If a board is forced to say
that the led is red, should it not also be forced to label it?

> +static Property led_properties[] = {
> +    DEFINE_PROP_STRING("color", LEDState, color),

It would appear that one can set any color via properties, including "plaid".
So if you do want the char *color field, what's the point in the enum?

> +# led.c
> +led_set_intensity(const char *color, const char *desc, uint16_t intensity) "LED desc:'%s' color:%s intensity: 0x%04"PRIx16

Is 0...65535 the best set of intensities?
Is that more valuable than e.g. a percentage?


r~

