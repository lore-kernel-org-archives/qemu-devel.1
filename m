Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638EBC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3948F205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3948F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqtz-0000Zd-Jw
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHqsK-0007vy-FI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHqsE-0001ah-RE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:54:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHqsE-0001YB-J1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:54:02 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEA1919CFF5
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 14:54:00 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id o10so4406342wrm.22
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 07:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aWbzS96ziQi5mF36h9g7JEe270fSYH2pm8dcQZ3Acbc=;
 b=Mz0QKgt7zGow8fX1vW/aeqDDfM10S8k97aWUVt5Z1ci65LdQH9RDQEd75wZ3Lo6O3h
 2FVKW/gev37EZykvtrTGqQYMJgjXR/TEjEP4bGUFcGYqSQyYiwHSGXHspDIBnyyJmgc2
 irWkyNhVTlwd8QIcD+//a2/X0AXW2WoY7xQZHxHgifwlit1HQEcw/2TVbFgT6f3CCU2B
 GlrdNGYRVKAmPZW+WY3sgqK33Hgj1Yj6nbTQKR74Ne+fsnP2Y+7+8X5xy6L1YZIAzJyQ
 TltTJRKGCAxPUV7Sq/0PhgX1bU5uw30POYJ6ByOmuZrKA/Lm03yUPWYgBTeN6IEqFIT/
 f2lg==
X-Gm-Message-State: APjAAAXfDT4uNaKvFv1ETONH7e3UTz5r4kxTNfaHCQcFrm8jKUD/O8vx
 hdc6c89DMZwUjjC0wkmeDisxcCFmDTi1/4+C+pjFt03GWIfMaRU74gYz6GaZYnzng8RiOVOTJLW
 v9aLJlZ8G9PHRJ+E=
X-Received: by 2002:a5d:574f:: with SMTP id q15mr15716704wrw.362.1570546439631; 
 Tue, 08 Oct 2019 07:53:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+v8jv0WDqevBHznUMDx29ch74rTYZ+uzMuQq9x47hgXZHh4LiuctW2xuyRt75YkD9jjY1GQ==
X-Received: by 2002:a5d:574f:: with SMTP id q15mr15716682wrw.362.1570546439403; 
 Tue, 08 Oct 2019 07:53:59 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id p85sm3746285wme.23.2019.10.08.07.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 07:53:58 -0700 (PDT)
Subject: Re: [PATCH 10/19] hw/timer/bcm2835: Add the BCM2835 SYS_timer
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-11-f4bug@amsat.org> <87tv8ji921.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <40327e41-3f13-1099-7ad2-1b64557d0d68@redhat.com>
Date: Tue, 8 Oct 2019 16:53:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87tv8ji921.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>, Pekka Enberg <penberg@iki.fi>,
 Guenter Roeck <linux@roeck-us.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 4:52 PM, Alex Benn=C3=A9e wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> Add the 64-bit free running timer. Do not model the COMPARE register
>> (no IRQ generated).
>> This timer is used by U-Boot and recent Linux kernels:
>> https://github.com/u-boot/u-boot/blob/v2019.07/include/configs/rpi.h#L=
19
>>
>> Datasheet used:
>> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripheral=
s.pdf
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> Since which kernels? 4.19 seems to use it.
>>
>> checkpatch warning:
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updati=
ng?
>> This is OK because the regex are:
>>
>>    F: hw/*/bcm283*
>>    F: include/hw/*/bcm283*
>> ---
>>   hw/timer/Makefile.objs            |   1 +
>>   hw/timer/bcm2835_systmr.c         | 100 ++++++++++++++++++++++++++++=
++
>>   hw/timer/trace-events             |   4 ++
>>   include/hw/timer/bcm2835_systmr.h |  30 +++++++++
>>   4 files changed, 135 insertions(+)
>>   create mode 100644 hw/timer/bcm2835_systmr.c
>>   create mode 100644 include/hw/timer/bcm2835_systmr.h
>>
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index 123d92c969..696cda5905 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -47,3 +47,4 @@ common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>>   common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
>>   common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
>>   common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
>> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_systmr.o
>> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
>> new file mode 100644
>> index 0000000000..c4d2b488bd
>> --- /dev/null
>> +++ b/hw/timer/bcm2835_systmr.c
>> @@ -0,0 +1,100 @@
>> +/*
>> + * BCM2835 SYS timer emulation
>> + *
>> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License version 2 or
>> + * (at your option) any later version.
>> + *
>> + * Datasheet: BCM2835 ARM Peripherals (C6357-M-1398)
>> + * https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Periph=
erals.pdf
>> + *
>> + * Only the free running 64-bit counter is implemented.
>> + * The 4 COMPARE registers and the interruption are not implemented.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/timer.h"
>> +#include "qemu/log.h"
>> +#include "hw/registerfields.h"
>> +#include "hw/timer/bcm2835_systmr.h"
>> +#include "trace.h"
>> +
>> +REG32(CTRL_STATUS,  0x00)
>> +REG32(COUNTER_LOW,  0x04)
>> +REG32(COUNTER_HIGH, 0x08)
>> +REG32(COMPARE0,     0x0c)
>> +REG32(COMPARE1,     0x10)
>> +REG32(COMPARE2,     0x14)
>> +REG32(COMPARE3,     0x18)
>> +
>> +static uint64_t bcm2835_sys_timer_read(void *opaque, hwaddr offset,
>> +                                       unsigned size)
>> +{
>> +    uint64_t r =3D 0;
>> +
>> +    switch (offset) {
>> +    case A_CTRL_STATUS:
>> +    case A_COMPARE0 ... A_COMPARE3:
>=20
> Probably worth a LOG_UNIMP in here if we are not going to do it.

Correct :)

>> +        break;
>> +    case A_COUNTER_LOW:
>> +    case A_COUNTER_HIGH:
>> +        /* Free running counter at 1MHz */
>> +        r =3D qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
>> +        r >>=3D 8 * (offset - A_COUNTER_LOW);
>> +        r &=3D UINT32_MAX;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PR=
Ix "\n",
>> +                      __func__, offset);
>> +        break;
>> +    }
>> +    trace_bcm2835_sys_timer_read(offset, r);
>> +
>> +    return r;
>> +}
>> +
>> +static void bcm2835_sys_timer_write(void *opaque, hwaddr offset,
>> +                                    uint64_t value, unsigned size)
>> +{
>> +    trace_bcm2835_sys_timer_write(offset, value);
>> +
>> +    qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx "\n",
>> +                  __func__, offset);
>> +}
>> +
>> +static const MemoryRegionOps bcm2835_sys_timer_ops =3D {
>> +    .read =3D bcm2835_sys_timer_read,
>> +    .write =3D bcm2835_sys_timer_write,
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +    .impl =3D {
>> +        .min_access_size =3D 4,
>> +        .max_access_size =3D 4,
>> +    },
>> +};
>> +
>> +static void bcm2835_sys_timer_init(Object *obj)
>> +{
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>> +    BCM2835SysTimerState *s =3D BCM2835_SYSTIMER(obj);
>> +
>> +    memory_region_init_io(&s->iomem, obj, &bcm2835_sys_timer_ops,
>> +                          s, "bcm2835-sys-timer", 0x20);
>> +    sysbus_init_mmio(sbd, &s->iomem);
>> +    sysbus_init_irq(sbd, &s->irq);
>> +}
>> +
>> +static const TypeInfo bcm2835_sys_timer_info =3D {
>> +    .name =3D TYPE_BCM2835_SYSTIMER,
>> +    .parent =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(BCM2835SysTimerState),
>> +    .instance_init =3D bcm2835_sys_timer_init,
>> +};
>> +
>> +static void bcm2835_sys_timer_register_types(void)
>> +{
>> +    type_register_static(&bcm2835_sys_timer_info);
>> +}
>> +
>> +type_init(bcm2835_sys_timer_register_types);
>> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
>> index db02a9142c..81967a1a19 100644
>> --- a/hw/timer/trace-events
>> +++ b/hw/timer/trace-events
>> @@ -87,3 +87,7 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%0=
8x value 0x%08x"
>>   pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x=
"
>>   pl031_alarm_raised(void) "alarm raised"
>>   pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
>> +
>> +# bcm2835_systmr.c
>> +bcm2835_sys_timer_read(uint64_t offset, uint64_t data) "timer read: o=
ffset 0x%" PRIx64 " data 0x%" PRIx64
>> +bcm2835_sys_timer_write(uint64_t offset, uint64_t data) "timer write:=
 offset 0x%" PRIx64 " data 0x%" PRIx64
>> diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2=
835_systmr.h
>> new file mode 100644
>> index 0000000000..6ac7f8ec5a
>> --- /dev/null
>> +++ b/include/hw/timer/bcm2835_systmr.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * BCM2835 SYS timer emulation
>> + *
>> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> + *
>> + *  This program is free software; you can redistribute it and/or mod=
ify
>> + *  it under the terms of the GNU General Public License version 2 or
>> + *  (at your option) any later version.
>> + */
>> +
>> +#ifndef BCM2835_SYSTIMER_H
>> +#define BCM2835_SYSTIMER_H
>> +
>> +#include "hw/sysbus.h"
>> +#include "hw/irq.h"
>> +
>> +#define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
>> +#define BCM2835_SYSTIMER(obj) \
>> +    OBJECT_CHECK(BCM2835SysTimerState, (obj), TYPE_BCM2835_SYSTIMER)
>> +
>> +typedef struct {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +
>> +    /*< public >*/
>> +    MemoryRegion iomem;
>> +    qemu_irq irq;
>> +} BCM2835SysTimerState;
>> +
>> +#endif
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20

