Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC224C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A322075B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="BaCLydAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A322075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGp0Q-0006k9-GD
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kGovn-0000ZB-BV; Fri, 11 Sep 2020 15:41:59 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:60348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kGovk-0001mJ-Uc; Fri, 11 Sep 2020 15:41:59 -0400
Received: from [172.17.10.18] (unknown [172.17.10.18])
 by beetle.greensocs.com (Postfix) with ESMTPSA id ECB6021C77;
 Fri, 11 Sep 2020 19:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1599853314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lxewNur1PGAwBIACWpkDj7T2JQcCii1xCQ+32TcRzNA=;
 b=BaCLydALxJxSi6Ng5dUQFRHXDAmgfFLCFUnA4jQckLC19v34IxS6RJFgOPC3NpjVIxXFgm
 /SvfFUwEfKUcftP/aHQ58zy6yT79pgguTsUxMn1CEdX0aBbkftcL92cL8laxjnAj+/ij0e
 +5wL6WaMBnonTDC2L1kTW/ZxWnuNmEo=
Subject: Re: [PATCH v5 1/7] hw/misc/led: Add a LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-2-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <7bd2327c-324f-a975-3a23-2a6a5dd45a53@greensocs.com>
Date: Fri, 11 Sep 2020 21:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910205429.727766-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:41:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 10:54 PM, Philippe Mathieu-Daudé wrote:
> Add a LED device which can be connected to a GPIO output.
> They can also be dimmed with PWM devices. For now we do
> not implement the dimmed mode, but in preparation of a
> future implementation, we start using the LED intensity.
> 
> LEDs are limited to a fixed set of colors.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   include/hw/misc/led.h |  84 +++++++++++++++++++++++++
>   hw/misc/led.c         | 142 ++++++++++++++++++++++++++++++++++++++++++
>   MAINTAINERS           |   6 ++
>   hw/misc/Kconfig       |   3 +
>   hw/misc/meson.build   |   1 +
>   hw/misc/trace-events  |   3 +
>   6 files changed, 239 insertions(+)
>   create mode 100644 include/hw/misc/led.h
>   create mode 100644 hw/misc/led.c
> 
> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
> new file mode 100644
> index 00000000000..f5afaa34bfb
> --- /dev/null
> +++ b/include/hw/misc/led.h
> @@ -0,0 +1,84 @@
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
> +/**
> + * LEDColor: Color of a LED
> + *
> + * This set is restricted to physically available LED colors.
> + *
> + * LED colors from 'Table 1. Product performance of LUXEON Rebel Color
> + * Line' of the 'DS68 LUXEON Rebel Color Line' datasheet available at:
> + * https://www.lumileds.com/products/color-leds/luxeon-rebel-color/
> + */
> +typedef enum {          /* Coarse wavelength range */
> +    LED_COLOR_VIOLET,   /* 425 nm */
> +    LED_COLOR_BLUE,     /* 475 nm */
> +    LED_COLOR_CYAN,     /* 500 nm */
> +    LED_COLOR_GREEN,    /* 535 nm */
> +    LED_COLOR_AMBER,    /* 590 nm */
> +    LED_COLOR_ORANGE,   /* 615 nm */
> +    LED_COLOR_RED,      /* 630 nm */
> +} LEDColor;
> +
> +typedef struct LEDState {
> +    /* Private */
> +    DeviceState parent_obj;
> +    /* Public */
> +
> +    uint8_t intensity_percent;
> +
> +    /* Properties */
> +    char *description;
> +    char *color;
> +} LEDState;
> +
> +/**
> + * led_set_intensity: Set the intensity of a LED device
> + * @s: the LED object
> + * @intensity_percent: intensity as percentage in range 0 to 100.
> + */
> +void led_set_intensity(LEDState *s, unsigned intensity_percent);
> +
> +/**
> + * led_get_intensity:
> + * @s: the LED object
> + *
> + * Returns: The LED intensity as percentage in range 0 to 100.
> + */
> +unsigned led_get_intensity(LEDState *s);
> +
> +/**
> + * led_set_state: Set the state of a LED device
> + * @s: the LED object
> + * @is_emitting: boolean indicating whether the LED is emitting
> + *
> + * This utility is meant for LED connected to GPIO.
> + */
> +void led_set_state(LEDState *s, bool is_emitting);
> +
> +/**
> + * led_create_simple: Create and realize a LED device
> + * @parentobj: the parent object
> + * @color: color of the LED
> + * @description: description of the LED (optional)
> + *
> + * Create the device state structure, initialize it, and
> + * drop the reference to it (the device is realized).
> + */
> +LEDState *led_create_simple(Object *parentobj,
> +                            LEDColor color,
> +                            const char *description);
> +
> +#endif /* HW_MISC_LED_H */
> diff --git a/hw/misc/led.c b/hw/misc/led.c
> new file mode 100644
> index 00000000000..89acd9acbb7
> --- /dev/null
> +++ b/hw/misc/led.c
> @@ -0,0 +1,142 @@
> +/*
> + * QEMU single LED device
> + *
> + * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/led.h"
> +#include "trace.h"
> +
> +#define LED_INTENSITY_PERCENT_MAX   100
> +
> +static const char *led_color_name[] = {
> +    [LED_COLOR_VIOLET]  = "violet",
> +    [LED_COLOR_BLUE]    = "blue",
> +    [LED_COLOR_CYAN]    = "cyan",
> +    [LED_COLOR_GREEN]   = "green",
> +    [LED_COLOR_AMBER]   = "amber",
> +    [LED_COLOR_ORANGE]  = "orange",
> +    [LED_COLOR_RED]     = "red",
> +};
> +
> +static bool led_color_name_is_valid(const char *color_name)
> +{
> +    for (size_t i = 0; i < ARRAY_SIZE(led_color_name); i++) {
> +        if (strcmp(color_name, led_color_name[i]) == 0) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +void led_set_intensity(LEDState *s, unsigned intensity_percent)
> +{
> +    if (intensity_percent > LED_INTENSITY_PERCENT_MAX) {
> +        intensity_percent = LED_INTENSITY_PERCENT_MAX;
> +    }
> +    trace_led_set_intensity(s->description, s->color, intensity_percent);
> +    s->intensity_percent = intensity_percent;
> +}
> +
> +unsigned led_get_intensity(LEDState *s)
> +{
> +    return s->intensity_percent;
> +}
> +
> +void led_set_state(LEDState *s, bool is_emitting)
> +{
> +    led_set_intensity(s, is_emitting ? LED_INTENSITY_PERCENT_MAX : 0);
> +}
> +
> +static void led_reset(DeviceState *dev)
> +{
> +    LEDState *s = LED(dev);
> +
> +    led_set_state(s, false);
> +}
> +
> +static const VMStateDescription vmstate_led = {
> +    .name = TYPE_LED,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(intensity_percent, LEDState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void led_realize(DeviceState *dev, Error **errp)
> +{
> +    LEDState *s = LED(dev);
> +
> +    if (s->color == NULL) {
> +        error_setg(errp, "property 'color' not specified");
> +        return;
> +    } else if (!led_color_name_is_valid(s->color)) {
> +        error_setg(errp, "property 'color' invalid or not supported");
> +        return;
> +    }
> +    if (s->description == NULL) {
> +        s->description = g_strdup("n/a");
> +    }
> +}
> +
> +static Property led_properties[] = {
> +    DEFINE_PROP_STRING("color", LEDState, color),
> +    DEFINE_PROP_STRING("description", LEDState, description),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void led_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "LED";
> +    dc->vmsd = &vmstate_led;
> +    dc->reset = led_reset;
> +    dc->realize = led_realize;
> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    device_class_set_props(dc, led_properties);
> +}
> +
> +static const TypeInfo led_info = {
> +    .name = TYPE_LED,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(LEDState),
> +    .class_init = led_class_init
> +};
> +
> +static void led_register_types(void)
> +{
> +    type_register_static(&led_info);
> +}
> +
> +type_init(led_register_types)
> +
> +LEDState *led_create_simple(Object *parentobj,
> +                            LEDColor color,
> +                            const char *description)
> +{
> +    g_autofree char *name = NULL;
> +    DeviceState *dev;
> +
> +    dev = qdev_new(TYPE_LED);
> +    qdev_prop_set_string(dev, "color", led_color_name[color]);
> +    if (!description) {
> +        static unsigned undescribed_led_id;
> +        name = g_strdup_printf("undescribed-led-#%u", undescribed_led_id++);
> +    } else {
> +        qdev_prop_set_string(dev, "description", description);
> +        name = g_ascii_strdown(description, -1);
> +        name = g_strdelimit(name, " #", '-');
> +    }
> +    object_property_add_child(parentobj, name, OBJECT(dev));
> +    qdev_realize_and_unref(dev, NULL, &error_fatal);
> +
> +    return LED(dev);
> +}
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d0a5e91e4f..ca7f47aa936 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1951,6 +1951,12 @@ F: docs/specs/vmgenid.txt
>   F: tests/qtest/vmgenid-test.c
>   F: stubs/vmgenid.c
>   
> +LED
> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
> +S: Maintained
> +F: include/hw/misc/led.h
> +F: hw/misc/led.c
> +
>   Unimplemented device
>   M: Peter Maydell <peter.maydell@linaro.org>
>   R: Philippe Mathieu-Daudé <f4bug@amsat.org>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 92c397ca07a..5c151fa3a83 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -126,6 +126,9 @@ config AUX
>   config UNIMP
>       bool
>   
> +config LED
> +    bool
> +
>   config MAC_VIA
>       bool
>       select MOS6522
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index e1576b81cf9..26f6dd037dc 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -11,6 +11,7 @@ softmmu_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
>   softmmu_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
>   softmmu_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
>   softmmu_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
> +softmmu_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
>   
>   # ARM devices
>   softmmu_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 066752aa900..76c9ddb54fe 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -214,6 +214,9 @@ via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size
>   grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>   grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
>   
> +# led.c
> +led_set_intensity(const char *color, const char *desc, uint8_t intensity_percent) "LED desc:'%s' color:%s intensity: %u%%"
> +
>   # pca9552.c
>   pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
>   pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
> 

