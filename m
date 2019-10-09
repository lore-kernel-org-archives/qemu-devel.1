Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE7BECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF7020679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0IuCXn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF7020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFlN-0002on-Vp
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iI9ni-0005xV-Um
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iI9nh-00079t-3W
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 07:06:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40711)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iI9ng-00078y-Qu; Wed, 09 Oct 2019 07:06:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id h4so2350429wrv.7;
 Wed, 09 Oct 2019 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nzmgl8chC2EBQZOlHe9JCwW5SDbT1V6/vDCyrlUt0EY=;
 b=d0IuCXn5cb6eS9o7vHnaQz+IazpcWBNOM5099Paist2p8LL3qZ71Upv6KW1dHHFkXo
 02/9PEZepRspo6et1V4e2qUWykOjUacBSsGSy1Y3e0wDhIX8Yx3Jq6W7iDvbuB96X0eb
 Z4NhJRGEtHi9rKuvZU2PJ4KrP6cWxvJcZz05vUA9pFtUJfT+PIDYLl+A0hZS0IHiYWc3
 ix64qK+RWWxfJmbTAi+g6c/1c2LNprkTdx/yI8DAi30+jaScm19wrouEpXe+G6olsn0S
 q8JmAQZlIdx/83TJ5REByJz9oqmA+kvJbonNr8SVrSwBDtPlJ3eMVxuTiQNLPmKJlorl
 Cg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nzmgl8chC2EBQZOlHe9JCwW5SDbT1V6/vDCyrlUt0EY=;
 b=DQlQ0rMN/1y/h+MEAqGRzf1wpwr5yV5RaUnuAI+z6RYGTvGrUECp3ET3pr4P+4Bpq5
 BY19/UcniXGQol5HMBP+gjfzvrnXoTiIcKKxg2ZfIGrEoEs1MjP0PzwWhtXPdIkBfqLQ
 fJcaaP/6nNIFDuGg/VQfFzG6kpEFqOMqn8VOLVs988PgeLhjNuyrLRVfUSdAVIsBWFFW
 MKoFfpZcFDbwrT52PJrjDF4+hmBmmItnR9JzRjpkw9L5itz0K5jKe7DW9+ZTc4qejtJk
 tA+w5iKODrzwgp4ylyBk8uujLmjh6UZ8+4TwXA8cV1Adi5TITHoaJAdcQyS5Xs9pfHa5
 qgaQ==
X-Gm-Message-State: APjAAAW1am3a4AWplg+kMWwsw3OOYUZESR99MwvC03OS0C1VaBSmwkXv
 mJhyhKmyGwxmwnuypfZNWC0=
X-Google-Smtp-Source: APXvYqxa4QHzPccGiL3QrzEF9melrwv68AS2yKfAdHnnrRi1AiCbYAYLCc/H4/g5ALAFim+P/PtJmg==
X-Received: by 2002:a5d:6250:: with SMTP id m16mr2369738wrv.322.1570619195483; 
 Wed, 09 Oct 2019 04:06:35 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id v16sm1755230wrt.12.2019.10.09.04.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 04:06:34 -0700 (PDT)
Subject: Re: [PATCH 10/19] hw/timer/bcm2835: Add the BCM2835 SYS_timer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-11-f4bug@amsat.org> <87tv8ji921.fsf@linaro.org>
 <40327e41-3f13-1099-7ad2-1b64557d0d68@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <75421f6b-4b17-71e4-4fc1-31a2103ad2c7@amsat.org>
Date: Wed, 9 Oct 2019 13:06:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <40327e41-3f13-1099-7ad2-1b64557d0d68@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>, Pekka Enberg <penberg@iki.fi>,
 Guenter Roeck <linux@roeck-us.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 4:53 PM, Philippe Mathieu-Daudé wrote:
> On 10/8/19 4:52 PM, Alex Bennée wrote:
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>
>>> Add the 64-bit free running timer. Do not model the COMPARE register
>>> (no IRQ generated).
>>> This timer is used by U-Boot and recent Linux kernels:
>>> https://github.com/u-boot/u-boot/blob/v2019.07/include/configs/rpi.h#L19
>>>
>>> Datasheet used:
>>> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf 
>>>
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>> Since which kernels? 4.19 seems to use it.
>>>
>>> checkpatch warning:
>>> WARNING: added, moved or deleted file(s), does MAINTAINERS need 
>>> updating?
>>> This is OK because the regex are:
>>>
>>>    F: hw/*/bcm283*
>>>    F: include/hw/*/bcm283*
>>> ---
>>>   hw/timer/Makefile.objs            |   1 +
>>>   hw/timer/bcm2835_systmr.c         | 100 ++++++++++++++++++++++++++++++
>>>   hw/timer/trace-events             |   4 ++
>>>   include/hw/timer/bcm2835_systmr.h |  30 +++++++++
>>>   4 files changed, 135 insertions(+)
>>>   create mode 100644 hw/timer/bcm2835_systmr.c
>>>   create mode 100644 include/hw/timer/bcm2835_systmr.h
>>>
>>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>>> index 123d92c969..696cda5905 100644
>>> --- a/hw/timer/Makefile.objs
>>> +++ b/hw/timer/Makefile.objs
>>> @@ -47,3 +47,4 @@ common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>>>   common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
>>>   common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
>>>   common-obj-$(CONFIG_MSF2) += mss-timer.o
>>> +common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
>>> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
>>> new file mode 100644
>>> index 0000000000..c4d2b488bd
>>> --- /dev/null
>>> +++ b/hw/timer/bcm2835_systmr.c
>>> @@ -0,0 +1,100 @@
>>> +/*
>>> + * BCM2835 SYS timer emulation
>>> + *
>>> + * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 or
>>> + * (at your option) any later version.
>>> + *
>>> + * Datasheet: BCM2835 ARM Peripherals (C6357-M-1398)
>>> + * 
>>> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf 
>>>
>>> + *
>>> + * Only the free running 64-bit counter is implemented.
>>> + * The 4 COMPARE registers and the interruption are not implemented.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/timer.h"
>>> +#include "qemu/log.h"
>>> +#include "hw/registerfields.h"
>>> +#include "hw/timer/bcm2835_systmr.h"
>>> +#include "trace.h"
>>> +
>>> +REG32(CTRL_STATUS,  0x00)
>>> +REG32(COUNTER_LOW,  0x04)
>>> +REG32(COUNTER_HIGH, 0x08)
>>> +REG32(COMPARE0,     0x0c)
>>> +REG32(COMPARE1,     0x10)
>>> +REG32(COMPARE2,     0x14)
>>> +REG32(COMPARE3,     0x18)
>>> +
>>> +static uint64_t bcm2835_sys_timer_read(void *opaque, hwaddr offset,
>>> +                                       unsigned size)
>>> +{
>>> +    uint64_t r = 0;
>>> +
>>> +    switch (offset) {
>>> +    case A_CTRL_STATUS:
>>> +    case A_COMPARE0 ... A_COMPARE3:
>>
>> Probably worth a LOG_UNIMP in here if we are not going to do it.

Checking the datasheet again, returning 0 is correct (as long as the 
gest doesn't write them) since we don't implement the COMPARE registers.

I'll see if I can implement them.

>>> +        break;
>>> +    case A_COUNTER_LOW:
>>> +    case A_COUNTER_HIGH:
>>> +        /* Free running counter at 1MHz */
>>> +        r = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
>>> +        r >>= 8 * (offset - A_COUNTER_LOW);
>>> +        r &= UINT32_MAX;
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" 
>>> HWADDR_PRIx "\n",
>>> +                      __func__, offset);
>>> +        break;
>>> +    }
>>> +    trace_bcm2835_sys_timer_read(offset, r);
>>> +
>>> +    return r;
>>> +}
>>> +
>>> +static void bcm2835_sys_timer_write(void *opaque, hwaddr offset,
>>> +                                    uint64_t value, unsigned size)
>>> +{
>>> +    trace_bcm2835_sys_timer_write(offset, value);
>>> +
>>> +    qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx "\n",
>>> +                  __func__, offset);
>>> +}
>>> +
>>> +static const MemoryRegionOps bcm2835_sys_timer_ops = {
>>> +    .read = bcm2835_sys_timer_read,
>>> +    .write = bcm2835_sys_timer_write,
>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>> +    .impl = {
>>> +        .min_access_size = 4,
>>> +        .max_access_size = 4,
>>> +    },
>>> +};
>>> +
>>> +static void bcm2835_sys_timer_init(Object *obj)
>>> +{
>>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>> +    BCM2835SysTimerState *s = BCM2835_SYSTIMER(obj);
>>> +
>>> +    memory_region_init_io(&s->iomem, obj, &bcm2835_sys_timer_ops,
>>> +                          s, "bcm2835-sys-timer", 0x20);
>>> +    sysbus_init_mmio(sbd, &s->iomem);
>>> +    sysbus_init_irq(sbd, &s->irq);
>>> +}
>>> +
>>> +static const TypeInfo bcm2835_sys_timer_info = {
>>> +    .name = TYPE_BCM2835_SYSTIMER,
>>> +    .parent = TYPE_SYS_BUS_DEVICE,
>>> +    .instance_size = sizeof(BCM2835SysTimerState),
>>> +    .instance_init = bcm2835_sys_timer_init,
>>> +};
>>> +
>>> +static void bcm2835_sys_timer_register_types(void)
>>> +{
>>> +    type_register_static(&bcm2835_sys_timer_info);
>>> +}
>>> +
>>> +type_init(bcm2835_sys_timer_register_types);
>>> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
>>> index db02a9142c..81967a1a19 100644
>>> --- a/hw/timer/trace-events
>>> +++ b/hw/timer/trace-events
>>> @@ -87,3 +87,7 @@ pl031_read(uint32_t addr, uint32_t value) "addr 
>>> 0x%08x value 0x%08x"
>>>   pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>>>   pl031_alarm_raised(void) "alarm raised"
>>>   pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
>>> +
>>> +# bcm2835_systmr.c
>>> +bcm2835_sys_timer_read(uint64_t offset, uint64_t data) "timer read: 
>>> offset 0x%" PRIx64 " data 0x%" PRIx64
>>> +bcm2835_sys_timer_write(uint64_t offset, uint64_t data) "timer 
>>> write: offset 0x%" PRIx64 " data 0x%" PRIx64
>>> diff --git a/include/hw/timer/bcm2835_systmr.h 
>>> b/include/hw/timer/bcm2835_systmr.h
>>> new file mode 100644
>>> index 0000000000..6ac7f8ec5a
>>> --- /dev/null
>>> +++ b/include/hw/timer/bcm2835_systmr.h
>>> @@ -0,0 +1,30 @@
>>> +/*
>>> + * BCM2835 SYS timer emulation
>>> + *
>>> + * Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> + *
>>> + *  This program is free software; you can redistribute it and/or 
>>> modify
>>> + *  it under the terms of the GNU General Public License version 2 or
>>> + *  (at your option) any later version.
>>> + */
>>> +
>>> +#ifndef BCM2835_SYSTIMER_H
>>> +#define BCM2835_SYSTIMER_H
>>> +
>>> +#include "hw/sysbus.h"
>>> +#include "hw/irq.h"
>>> +
>>> +#define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
>>> +#define BCM2835_SYSTIMER(obj) \
>>> +    OBJECT_CHECK(BCM2835SysTimerState, (obj), TYPE_BCM2835_SYSTIMER)
>>> +
>>> +typedef struct {
>>> +    /*< private >*/
>>> +    SysBusDevice parent_obj;
>>> +
>>> +    /*< public >*/
>>> +    MemoryRegion iomem;
>>> +    qemu_irq irq;
>>> +} BCM2835SysTimerState;
>>> +
>>> +#endif
>>
>>
>> -- 
>> Alex Bennée
>>

