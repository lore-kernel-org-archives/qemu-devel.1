Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0EBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 20:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B836520771
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 20:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNiSZ22L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn6gz-0008A9-1w
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 16:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn6gJ-0007WQ-BR; Sun, 21 Jun 2020 16:35:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn6gH-0001UU-GP; Sun, 21 Jun 2020 16:35:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id u26so12234717wmn.1;
 Sun, 21 Jun 2020 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+QiGPbdFMlAbX4GMi1npxH4g4wnia0NgzsxKdGmq4o0=;
 b=MNiSZ22Li3OJfvWZZYkI14kCjcrgQo+T7iu7R5ALxFezjjZ8M4QaE2njoRY5HLJFmv
 ZzWqtUTkIXYLD8R54+z+dV2L2/TTAIOdxLMG23k5kQt1HMTR/rNWFIh6zeomGb5WsKqQ
 EZbfFywRJv/kodht+X7d200GCC7MH6Lc9OsIjLVRN4B6Qw2XrKReMlb6beNwCofHeVzJ
 tBBlLs2cKFK56CVZI4rnQe/0Afgst64DTcvUDxYv9yaLzIgFInAh44RQEYySjjZEiED7
 OEp6AeSEps13MeGHDGlbeUeoc3csFwqoCUa3fFAYipjxKaLJaciC1KSBHrm1/FWveUVV
 Bp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+QiGPbdFMlAbX4GMi1npxH4g4wnia0NgzsxKdGmq4o0=;
 b=n5BffULHrIxQTTHtWu90Ai6ycn1IwKg0rvYhaAECKVOfQ6fNsTSmx709+fQMyURo//
 0kwGzk2I1/eJgrWGJvzlePaxHa2y/nSvtDDgWjgZRsBXBQqYBqiXoOg5YnVZrkWcBA4m
 qLAH+BwzXMRgX6TbalVnQqnoExarLK5ZmoP+6NUdPVXsAHmbpRkp6K86C2PEZhfhaJXa
 +zcAoJUjI3AYDKCiVqNKuFbUe1eEAfkSfQ0Q0wV0lf+zaVqclmXBPPPD73Js6sUVLRc+
 K9FLbpbQY1iqRD7r+Ujox980225tgKvGvDbK6A20hDY399PLoaHiAbSMA/wjkZHWriug
 JJtg==
X-Gm-Message-State: AOAM5304D2ssm7BcpLtBWxewg+z6x3s2tB/2uGb8eeXTsc4xG0DZ2PwK
 Ux8P8oEm8qY75g2wp+ZtOBY=
X-Google-Smtp-Source: ABdhPJzIKbFrYruemBIDCkT0bVR1zeGCFzZBwpGyjFyKnnL0WdBf2wk8dEOXy1cHgZjFcuYyxUZ44w==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr15629374wmc.159.1592771706913; 
 Sun, 21 Jun 2020 13:35:06 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l10sm535803wme.1.2020.06.21.13.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 13:35:06 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] hw/misc: Add a LED device
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-2-f4bug@amsat.org>
 <f2cc97dc-87c8-5cc8-e0fb-026cf80c25fa@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dfe79efa-0f77-6e86-c7e4-42fed7756071@amsat.org>
Date: Sun, 21 Jun 2020 22:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f2cc97dc-87c8-5cc8-e0fb-026cf80c25fa@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Hi Richard,

On 6/21/20 4:00 AM, Richard Henderson wrote:
> On 6/20/20 4:07 PM, Philippe Mathieu-Daudé wrote:
>> Add a LED device which can be connected to a GPIO output.
>> LEDs are limited to a set of colors.
>> They can also be dimmed with PWM devices. For now we do
>> not implement the dimmed mode, but in preparation of a
>> future implementation, we start using the LED intensity.
>> When used with GPIOs, the intensity can only be either
>> minium or maximum. This depends of the polarity of the
>> GPIO.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/misc/led.h |  79 +++++++++++++++++++++++++++
>>  hw/misc/led.c         | 121 ++++++++++++++++++++++++++++++++++++++++++
>>  MAINTAINERS           |   6 +++
>>  hw/misc/Kconfig       |   3 ++
>>  hw/misc/Makefile.objs |   1 +
>>  hw/misc/trace-events  |   3 ++
>>  6 files changed, 213 insertions(+)
>>  create mode 100644 include/hw/misc/led.h
>>  create mode 100644 hw/misc/led.c
>>
>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
>> new file mode 100644
>> index 0000000000..821ee1247d
>> --- /dev/null
>> +++ b/include/hw/misc/led.h
>> @@ -0,0 +1,79 @@
>> +/*
>> + * QEMU single LED device
>> + *
>> + * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef HW_MISC_LED_H
>> +#define HW_MISC_LED_H
>> +
>> +#include "hw/qdev-core.h"
>> +
>> +#define TYPE_LED "led"
>> +#define LED(obj) OBJECT_CHECK(LEDState, (obj), TYPE_LED)
>> +
>> +typedef enum {
>> +    LED_COLOR_UNKNOWN,
>> +    LED_COLOR_RED,
>> +    LED_COLOR_ORANGE,
>> +    LED_COLOR_AMBER,
>> +    LED_COLOR_YELLOW,
>> +    LED_COLOR_GREEN,
>> +    LED_COLOR_BLUE,
>> +    LED_COLOR_VIOLET, /* PURPLE */
>> +    LED_COLOR_WHITE,
>> +    LED_COLOR_COUNT
>> +} LEDColor;
> 
> Is color especially interesting, given that we only actually "display" the
> color via tracing?

The idea of this device is to easily visualize events. Currently
via tracing, but eventually an external UI could introspect the
board for devices able to represent visual changes such LEDs, and
automatically display them.
To limit the list of representable object the visualizer has to
support, I prefer to restrict this device to the existing LED
physical colors.

> 
>> +/* Definitions useful when a LED is connected to a GPIO */
>> +#define LED_RESET_INTENSITY_ACTIVE_LOW  UINT16_MAX
>> +#define LED_RESET_INTENSITY_ACTIVE_HIGH 0U
>> +
>> +typedef struct LEDState {
>> +    /* Private */
>> +    DeviceState parent_obj;
>> +    /* Public */
>> +
>> +    /* Properties */
>> +    char *description;
>> +    char *color;
> 
> The enumeration is unused by the actual device, it would seem?

I want to, but it seems having a enum qdev property involves
a lot of code.

> 
>> +/**
>> + * led_set_intensity: set the state of a LED device
>> + * @s: the LED object
>> + * @is_on: boolean indicating whether the LED is emitting
>> + *
>> + * This utility is meant for LED connected to GPIO.
>> + */
>> +void led_set_state(LEDState *s, bool is_on);
> 
> Comment mismatch.
> 
> 
>> +void led_set_intensity(LEDState *s, uint16_t new_intensity)
>> +{
>> +    trace_led_set_intensity(s->description ? s->description : "n/a",
>> +                            s->color, new_intensity);
> 
> Why not default description upon reset/realize?

Yes.

> 
>> +static void led_realize(DeviceState *dev, Error **errp)
>> +{
>> +    LEDState *s = LED(dev);
>> +
>> +    if (s->color == NULL) {
>> +        error_setg(errp, "property 'color' not specified");
>> +        return;
>> +    }
>> +}
> 
> Indeed, why not insist that description is set?  If a board is forced to say
> that the led is red, should it not also be forced to label it?

Because when we don't have access to the hardware schematics,
we can not specify the label. I'll add a comment about this.

> 
>> +static Property led_properties[] = {
>> +    DEFINE_PROP_STRING("color", LEDState, color),
> 
> It would appear that one can set any color via properties, including "plaid".
> So if you do want the char *color field, what's the point in the enum?

Good catch... I will either use an enum propery, or check the
property is in the allowed color names.

> 
>> +# led.c
>> +led_set_intensity(const char *color, const char *desc, uint16_t intensity) "LED desc:'%s' color:%s intensity: 0x%04"PRIx16
> 
> Is 0...65535 the best set of intensities?

You are right. I was thinking of PWM resolution (limiting to
16-bits). This is a different API to model, I mixed.

> Is that more valuable than e.g. a percentage?

Yes, the [0-100] range of integer is sufficient to represent
light intensity =)

Thanks for your review!

Phil.

