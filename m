Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FDC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E7321556
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjhCuaJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E7321556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNgv-0007nl-MA
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFNgO-0007CH-7v; Mon, 07 Sep 2020 16:24:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFNgM-0002GP-BR; Mon, 07 Sep 2020 16:24:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id z9so15188860wmk.1;
 Mon, 07 Sep 2020 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qJ0HzX9L9PdOn/tmbJa+FDM6ybFev8Io6r70iYfxrOc=;
 b=rjhCuaJ0UdMXkqNRTKgLM9RrKnmH2KeF/xGxA2RXvJMrLxD+bDTWiu2gQ7D58wakEy
 EwF2UxXHC8nssnHlUDxnKMdgE/fyjDZPt8RIgKCzFkoq+toYHnMMOAk7+/CQD6lzdTo5
 xnS0kBmXnkqrkqwHXldr2eqngGlCDEnBVjXJk1jXCGQJvmBafqrvmhPxs2siBAJRIojO
 /6kJMskh9znZALRbeTZRq+0yGKu84NsngI5crliherohNOgZq9wkLK82Ex74tsNAbVEm
 Z2+sgkuv1SbV2jtTiQRTMglcbKIgYsGVbk1lFGB5kPba/sV0UXR73LIOxPTdH6UbtUtx
 2mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qJ0HzX9L9PdOn/tmbJa+FDM6ybFev8Io6r70iYfxrOc=;
 b=YXqxrg+SDLjyviHVxIW2YTjai+MutbBPjb+LzlxOr6RZVwjoCU75YzDhADXu2Yurcj
 2akjvZtBRMUPzo5tePQS+wN/xmXb6PqYlBVqt06V3iodxQ28xf22X1EsdmWV0coMG5Ce
 Hqg1jM7G63IqIUiVP8WXAAKgrY7YohCvux9dmyP//Ta0HmQvGYwjTDPRwE9ub9MLzkdf
 72caQKGRaWzmNi85c+xNmidWiJ3/fdTpHc3iYKL0blyepJIo7EC4QuCKnv3jmYhDk8Wh
 UAfttbSd5rx0f/qY4t5ajdw+bNvUWg+kmH0cR2Rp1/BwMkq2OCZrbrFpaehTErb6zvUg
 OgxA==
X-Gm-Message-State: AOAM530qwnYVnkK189smfgs9diNqda1u3OzW3Z6q+LCELU3JYSRhh+FS
 fp/t/ogBRIjSFOb3Ynq+m+w=
X-Google-Smtp-Source: ABdhPJwBqR8yKoQ+7Z7JVv9GpSdEspg21ufZiCVrNtcyK20bdgHbOPZzp87JDkv5sXOjfvWSnUCFqw==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr939494wme.96.1599510244482;
 Mon, 07 Sep 2020 13:24:04 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f1sm29392440wrt.20.2020.09.07.13.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 13:24:03 -0700 (PDT)
Subject: Re: [PATCH v4 1/8] hw/misc/led: Add a LED device
To: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org
References: <20200907163257.46527-1-f4bug@amsat.org>
 <20200907163257.46527-2-f4bug@amsat.org>
 <451e8d25-ecb5-c3e2-64aa-8582f2f47a25@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad0701b2-e772-2b4a-283a-ec4bb02c6a6b@amsat.org>
Date: Mon, 7 Sep 2020 22:24:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <451e8d25-ecb5-c3e2-64aa-8582f2f47a25@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.825,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 10:03 PM, Luc Michel wrote:
> Hi Philippe,
> 
> On 9/7/20 6:32 PM, Philippe Mathieu-Daudé wrote:
>> Add a LED device which can be connected to a GPIO output.
>> They can also be dimmed with PWM devices. For now we do
>> not implement the dimmed mode, but in preparation of a
>> future implementation, we start using the LED intensity.
>>
>> LEDs are limited to a fixed set of colors.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   include/hw/misc/led.h |  84 +++++++++++++++++++++++++
>>   hw/misc/led.c         | 142 ++++++++++++++++++++++++++++++++++++++++++
>>   MAINTAINERS           |   6 ++
>>   hw/misc/Kconfig       |   3 +
>>   hw/misc/meson.build   |   1 +
>>   hw/misc/trace-events  |   3 +
>>   6 files changed, 239 insertions(+)
>>   create mode 100644 include/hw/misc/led.h
>>   create mode 100644 hw/misc/led.c
...
>> +/**
>> + * led_set_intensity: set the intensity of a LED device
>> + * @s: the LED object
>> + * @intensity: intensity as percentage in range 0 to 100.
> @intensity_percent
> 
>> + */
>> +void led_set_intensity(LEDState *s, unsigned intensity_percent);
>> +
>> +/**
>> + * led_get_intensity:
>> + * @s: the LED object
>> + *
>> + * Returns: The LED intensity as percentage in range 0 to 100.
>> + */
>> +unsigned led_get_intensity(LEDState *s);
>> +
>> +/**
>> + * led_set_intensity: set the state of a LED device
> led_set_state
> 
>> + * @s: the LED object
>> + * @is_on: boolean indicating whether the LED is emitting
> @is_emitting
> 
>> + *
>> + * This utility is meant for LED connected to GPIO.
>> + */
>> +void led_set_state(LEDState *s, bool is_emitting);
>> +
>> +/**
>> + * led_create_simple: Create and realize a LED device
>> + * @parent: the parent object
> @parentobj
> 
>> + * @color: color of the LED
>> + * @description: description of the LED (optional)
>> + *
>> + * Create the device state structure, initialize it, and
>> + * drop the reference to it (the device is realized).
>> + */
>> +LEDState *led_create_simple(Object *parentobj,
>> +                            LEDColor color,
>> +                            const char *description);
>> +
>> +#endif /* HW_MISC_LED_H */
>> diff --git a/hw/misc/led.c b/hw/misc/led.c
>> new file mode 100644
>> index 00000000000..f2140739b68
>> --- /dev/null
>> +++ b/hw/misc/led.c
>> @@ -0,0 +1,142 @@
>> +/*
>> + * QEMU single LED device
>> + *
>> + * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "migration/vmstate.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/misc/led.h"
>> +#include "trace.h"
>> +
>> +#define LED_INTENSITY_PERCENT_MAX   100
>> +
>> +static const char *led_color_name[] = {
>> +    [LED_COLOR_VIOLET]  = "violet",
>> +    [LED_COLOR_BLUE]    = "blue",
>> +    [LED_COLOR_CYAN]    = "cyan",
>> +    [LED_COLOR_GREEN]   = "green",
>> +    [LED_COLOR_AMBER]   = "amber",
>> +    [LED_COLOR_ORANGE]  = "orange",
>> +    [LED_COLOR_RED]     = "red",
>> +};
>> +
>> +static bool led_color_name_is_valid(const char *color_name)
>> +{
>> +    for (size_t i = 0; i < ARRAY_SIZE(led_color_name); i++) {
>> +        if (led_color_name[i] && strcmp(color_name,
>> led_color_name[i]) == 0) {
> 
> Why are you checking led_color_name[i] here?

It could happen in v3 but not now, thanks for catching this :)

I'll address your comment and respin after few days.

> 
> Otherwise, seems good to me.
> 
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>

Thanks!

