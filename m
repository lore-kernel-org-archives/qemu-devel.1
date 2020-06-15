Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C422920663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVsAEpss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C422920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jknAb-0004Xc-18
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 07:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkn9h-0003qq-4k; Mon, 15 Jun 2020 07:19:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkn9f-0006Fx-Ej; Mon, 15 Jun 2020 07:19:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id l17so14249448wmj.0;
 Mon, 15 Jun 2020 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rOmIHbZe5kQiQji9jANHWdGJtWBuqiztPhVjYLwrD+I=;
 b=FVsAEpssir+hzoHh1OwyfFGZTpALAGnyKkP0tDFOewQdy3II7eOPIyUh3FQAAAneei
 0xw9LMILnY7CVGnRU8PiuYFWayMV5YCci4VrwMfNuVWPrYfI+oZvao+bhgVn2a+SM2/O
 mtu20YB6RnCcU4v7VyxV0MBzahmTIuDft3HETs0T4bMhF3I+DA4ciHx48oUgQPevxm3T
 Dl8bce5ANcsvhpPoUadVGYT6yziAZyQMsa81cemllXkp/vBJKsn5NXXXhoayJGzSVSTY
 j5BgWjEqSO29Hdn+mlfzyqbAN4Tk66RB7L5hQzYcUVoo+Dn3UnEnSvzCmikOiPKBP1q1
 yEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rOmIHbZe5kQiQji9jANHWdGJtWBuqiztPhVjYLwrD+I=;
 b=jvZhAALyHzHgkibKLgBxBww7lPAzGaRCuw/I/MWJXpJYZdabOGvMhwXzxepTZOfW9W
 NUxzBUMIhKFUhHTQOUYojSvD4fFt1jc+UyZGpYddgoMbmyEg9NtCbFMwXgrpm8Sd2ODv
 371n0FU+dhnSLMnS3BZTPg6XqgaE3M67aVYRPZaaCEQD5OFfFmwanVS2UOwgnu0HK3ef
 fCfAvHSsPTKXXVyaOSj0L/7eBVI/+IPvCLRr+QPbezkguTnnixRIiZXMm6oQGTQEaxdB
 5bndCILmP6cOl2UgOzjLF6huy2HjSNClf9bf7l1ndiVGxww5Z4ZkequJRCHwOAM5t0q2
 wsJQ==
X-Gm-Message-State: AOAM530yirIR0UB7z8uTe3LGgycyMXqMetNh9Bm5pnVDUjSVfGKQx7jr
 xlkgSLfDg0sah1Iz+X6S3TA=
X-Google-Smtp-Source: ABdhPJw7X/5aSXD22JqOPkljy91TfeZFTJbAPV4zxOZNtTA5n6i0XHj4H/0BRmvqslEIHCWRe/NzAA==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr12449678wmi.65.1592219993535; 
 Mon, 15 Jun 2020 04:19:53 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s2sm21072576wmh.11.2020.06.15.04.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 04:19:52 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/5] hw/misc: Add a LED device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200612175440.9901-1-f4bug@amsat.org>
 <20200612175440.9901-2-f4bug@amsat.org> <20200615105544.GG2883@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4fa46a7c-7769-3712-c580-46af066abe29@amsat.org>
Date: Mon, 15 Jun 2020 13:19:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200615105544.GG2883@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 12:55 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-DaudÃ© (f4bug@amsat.org) wrote:
>> A LED device can be connected to a GPIO output.
>>
>> Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>> ---
>>  include/hw/misc/led.h | 30 ++++++++++++++++
>>  hw/misc/led.c         | 84 +++++++++++++++++++++++++++++++++++++++++++
>>  MAINTAINERS           |  6 ++++
>>  hw/misc/Kconfig       |  3 ++
>>  hw/misc/Makefile.objs |  1 +
>>  hw/misc/trace-events  |  3 ++
>>  6 files changed, 127 insertions(+)
>>  create mode 100644 include/hw/misc/led.h
>>  create mode 100644 hw/misc/led.c
>>
>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
>> new file mode 100644
>> index 0000000000..427ca1418e
>> --- /dev/null
>> +++ b/include/hw/misc/led.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * QEMU single LED device
>> + *
>> + * Copyright (C) 2020 Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef HW_MISC_LED_H
>> +#define HW_MISC_LED_H
>> +
>> +#include "hw/qdev-core.h"
>> +#include "hw/sysbus.h" /* FIXME remove */
>> +
>> +#define TYPE_LED "led"
>> +#define LED(obj) OBJECT_CHECK(LEDState, (obj), TYPE_LED)
>> +
>> +typedef struct LEDState {
>> +    /* Private */
>> +    SysBusDevice parent_obj; /* FIXME DeviceState */
>> +    /* Public */
>> +
>> +    qemu_irq irq;
> 
> Why an irq?

We model GPIO/IRQ the same way, this is simply a GPIO, right?

It makes modeling easier IMO. This is for visualization purpose.

> 
>> +    uint8_t current_state;
> 
> Is the state of this device boolean or is it a 0..255 0=off, 255=full
> on, analog thing?
> Can an LED device be connected to a PWM device driving a GPIO - what
> happens?

Well I simply wanted to use a boolean, but I need to consider
if we can model intensity here in case of PWM. This is interesting.

> 
> Dave
> 
> 
>> +    /* Properties */
>> +    char *name;
>> +    uint8_t reset_state; /* TODO [GPIO_ACTIVE_LOW, GPIO_ACTIVE_HIGH] */
>> +} LEDState;
>> +
>> +#endif /* HW_MISC_LED_H */
>> diff --git a/hw/misc/led.c b/hw/misc/led.c
>> new file mode 100644
>> index 0000000000..1bae1a34c0
>> --- /dev/null
>> +++ b/hw/misc/led.c
>> @@ -0,0 +1,84 @@
>> +/*
>> + * QEMU single LED device
>> + *
>> + * Copyright (C) 2020 Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "migration/vmstate.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/misc/led.h"
>> +#include "hw/irq.h"
>> +#include "trace.h"
>> +
>> +static void led_set(void *opaque, int line, int new_state)
>> +{
>> +    LEDState *s = LED(opaque);
>> +
>> +    trace_led_set(s->name, s->current_state, new_state);
>> +
>> +    s->current_state = new_state;
>> +}
>> +
>> +static void led_reset(DeviceState *dev)
>> +{
>> +    LEDState *s = LED(dev);
>> +
>> +    led_set(dev, 0, s->reset_state);
>> +}
>> +
>> +static const VMStateDescription vmstate_led = {
>> +    .name = TYPE_LED,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT8(reset_state, LEDState),
> 
> I'm not sure you need to migrate this - this is a property that's set on
> the device, not a dynamic state of the device

Yes you are right.

>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void led_realize(DeviceState *dev, Error **errp)
>> +{
>> +    LEDState *s = LED(dev);
>> +
>> +    if (s->name == NULL) {
>> +        error_setg(errp, "property 'name' not specified");
>> +        return;
>> +    }
>> +
>> +    qdev_init_gpio_in(DEVICE(s), led_set, 1);
>> +}
>> +
>> +static Property led_properties[] = {
>> +    DEFINE_PROP_STRING("name", LEDState, name),
>> +    DEFINE_PROP_UINT8("reset_state", LEDState, reset_state, 0),
> 
> I suggest you add a property for the notional colour; that way any UIs
> that are built can use that as a hint.

Great idea, thanks!

> 
> Dave
> 
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void led_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->desc = "LED";
>> +    dc->vmsd = &vmstate_led;
>> +    dc->reset = led_reset;
>> +    dc->realize = led_realize;
>> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>> +    device_class_set_props(dc, led_properties);
>> +}
>> +
>> +static const TypeInfo led_info = {
>> +    .name = TYPE_LED,
>> +    .parent = TYPE_SYS_BUS_DEVICE, /* FIXME TYPE_DEVICE */
>> +    .instance_size = sizeof(LEDState),
>> +    .class_init = led_class_init
>> +};
>> +
>> +static void led_register_types(void)
>> +{
>> +    type_register_static(&led_info);
>> +}
>> +
>> +type_init(led_register_types)
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3abe3faa4e..10593863dc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1857,6 +1857,12 @@ F: docs/specs/vmgenid.txt
>>  F: tests/qtest/vmgenid-test.c
>>  F: stubs/vmgenid.c
>>  
>> +LED
>> +M: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>> +S: Maintained
>> +F: include/hw/misc/led.h
>> +F: hw/misc/led.c
>> +
>>  Unimplemented device
>>  M: Peter Maydell <peter.maydell@linaro.org>
>>  R: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index bdd77d8020..f60dce694d 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -126,6 +126,9 @@ config AUX
>>  config UNIMP
>>      bool
>>  
>> +config LED
>> +    bool
>> +
>>  config MAC_VIA
>>      bool
>>      select MOS6522
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 5aaca8a039..9efa3c941c 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -91,3 +91,4 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
>>  obj-$(CONFIG_MAC_VIA) += mac_via.o
>>  
>>  common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
>> +common-obj-$(CONFIG_LED) += led.o
>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> index 5561746866..e15b7f7c81 100644
>> --- a/hw/misc/trace-events
>> +++ b/hw/misc/trace-events
>> @@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>>  # grlib_ahb_apb_pnp.c
>>  grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
>>  grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
>> +
>> +# led.c
>> +led_set(const char *name, uint8_t old_state, uint8_t new_state) "led name:'%s' state %d -> %d"
>> -- 
>> 2.21.3
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

