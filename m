Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E1C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DC2205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ii/xyrCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DC2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqsV-0007fN-77
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHqqi-0005zo-8h
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHqqf-00081F-T8
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:52:27 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHqqf-0007zR-Ju
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:52:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so19702091wrm.12
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WLiiRBIRvaaizD7vYMDHZjHnVHBD4mW6HSx+S/n82xQ=;
 b=ii/xyrCegLRywaZ+A2ze0ellAP/s+EYCBQAWQTwg1QSgwJvRi2UzLVZh3kGxbctAub
 Hbl07LA0l1AXg+OwhtIHsf0BV8P5V/YzqGVvNRbhQoN41W4+8G+7EwMkkX3onKj/t3HB
 4PKAcqx/+I5CiB57S1OWX9CA+Fg/XnwFBjdQTQMoTWdfoT80M4OjReZwgBxYgifuFfoS
 h7OPeQ9mQbZ9wjG78phXy9IBaDh7dwEgVKlLC4bjUg72C1Hj1i02vSFvXHnp3rStUJqy
 u4tgDJk7yVG6WyBzH5Fv9deZ2XKYQYS2WcisoygbOS73WvQ9k0CIF3rEZqdwQDd0cqB5
 zUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WLiiRBIRvaaizD7vYMDHZjHnVHBD4mW6HSx+S/n82xQ=;
 b=JClhn8J009YgGjb9EDcfu5D9wABboOpg5+QnDVQX2MYzdmJTZIfQrD96vl8bRwH7sd
 7d7cgUdrFREux896ex2FNj1CQ1LdD89uHTjEgcoVZJD7RTl6OpjgtF3TdFwKGM4Q9j9i
 ltsn94iAqzzjvBufrrA+hpJSeJnyZgoSkHvGwVCr1jLGV5fGlkh3tA745JXXr6NQA9HU
 iUFIBS3Hu1b4UAIcnXlWBCnrfJWQzrit7PjTn1GgG/KyrRcNEpjDVkhBywOTJV6txV6k
 4JbwAQXTmNGK+/50cKUCL3ZQqQ41+WITQzcC1OLGk0J2MCBb8daZqEDRIkL4OoLeHgU0
 XoMg==
X-Gm-Message-State: APjAAAUfQZbQ5qpnrJf5jPYky9687wiVnbt9BxzaSnvJAATL/WZ9CG0i
 FpecELMjJo/jOJxUlpG7gqOjRg==
X-Google-Smtp-Source: APXvYqwVNDqxUnFVhYISe+Y/V8rbDDkSV/iXAfLpfaI+Gn9Zx8rH5l6Y81mpR99bKpcc592L0MZHng==
X-Received: by 2002:a05:6000:186:: with SMTP id
 p6mr25382660wrx.136.1570546344010; 
 Tue, 08 Oct 2019 07:52:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n8sm5878693wma.7.2019.10.08.07.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 07:52:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 80D901FF87;
 Tue,  8 Oct 2019 15:52:22 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-11-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 10/19] hw/timer/bcm2835: Add the BCM2835 SYS_timer
In-reply-to: <20190926173428.10713-11-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 15:52:22 +0100
Message-ID: <87tv8ji921.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Add the 64-bit free running timer. Do not model the COMPARE register
> (no IRQ generated).
> This timer is used by U-Boot and recent Linux kernels:
> https://github.com/u-boot/u-boot/blob/v2019.07/include/configs/rpi.h#L19
>
> Datasheet used:
> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.p=
df
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Since which kernels? 4.19 seems to use it.
>
> checkpatch warning:
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> This is OK because the regex are:
>
>   F: hw/*/bcm283*
>   F: include/hw/*/bcm283*
> ---
>  hw/timer/Makefile.objs            |   1 +
>  hw/timer/bcm2835_systmr.c         | 100 ++++++++++++++++++++++++++++++
>  hw/timer/trace-events             |   4 ++
>  include/hw/timer/bcm2835_systmr.h |  30 +++++++++
>  4 files changed, 135 insertions(+)
>  create mode 100644 hw/timer/bcm2835_systmr.c
>  create mode 100644 include/hw/timer/bcm2835_systmr.h
>
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 123d92c969..696cda5905 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -47,3 +47,4 @@ common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>  common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
>  common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
>  common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_systmr.o
> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
> new file mode 100644
> index 0000000000..c4d2b488bd
> --- /dev/null
> +++ b/hw/timer/bcm2835_systmr.c
> @@ -0,0 +1,100 @@
> +/*
> + * BCM2835 SYS timer emulation
> + *
> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 or
> + * (at your option) any later version.
> + *
> + * Datasheet: BCM2835 ARM Peripherals (C6357-M-1398)
> + * https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Periphera=
ls.pdf
> + *
> + * Only the free running 64-bit counter is implemented.
> + * The 4 COMPARE registers and the interruption are not implemented.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "qemu/log.h"
> +#include "hw/registerfields.h"
> +#include "hw/timer/bcm2835_systmr.h"
> +#include "trace.h"
> +
> +REG32(CTRL_STATUS,  0x00)
> +REG32(COUNTER_LOW,  0x04)
> +REG32(COUNTER_HIGH, 0x08)
> +REG32(COMPARE0,     0x0c)
> +REG32(COMPARE1,     0x10)
> +REG32(COMPARE2,     0x14)
> +REG32(COMPARE3,     0x18)
> +
> +static uint64_t bcm2835_sys_timer_read(void *opaque, hwaddr offset,
> +                                       unsigned size)
> +{
> +    uint64_t r =3D 0;
> +
> +    switch (offset) {
> +    case A_CTRL_STATUS:
> +    case A_COMPARE0 ... A_COMPARE3:

Probably worth a LOG_UNIMP in here if we are not going to do it.

> +        break;
> +    case A_COUNTER_LOW:
> +    case A_COUNTER_HIGH:
> +        /* Free running counter at 1MHz */
> +        r =3D qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
> +        r >>=3D 8 * (offset - A_COUNTER_LOW);
> +        r &=3D UINT32_MAX;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PRIx =
"\n",
> +                      __func__, offset);
> +        break;
> +    }
> +    trace_bcm2835_sys_timer_read(offset, r);
> +
> +    return r;
> +}
> +
> +static void bcm2835_sys_timer_write(void *opaque, hwaddr offset,
> +                                    uint64_t value, unsigned size)
> +{
> +    trace_bcm2835_sys_timer_write(offset, value);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx "\n",
> +                  __func__, offset);
> +}
> +
> +static const MemoryRegionOps bcm2835_sys_timer_ops =3D {
> +    .read =3D bcm2835_sys_timer_read,
> +    .write =3D bcm2835_sys_timer_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void bcm2835_sys_timer_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    BCM2835SysTimerState *s =3D BCM2835_SYSTIMER(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &bcm2835_sys_timer_ops,
> +                          s, "bcm2835-sys-timer", 0x20);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static const TypeInfo bcm2835_sys_timer_info =3D {
> +    .name =3D TYPE_BCM2835_SYSTIMER,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(BCM2835SysTimerState),
> +    .instance_init =3D bcm2835_sys_timer_init,
> +};
> +
> +static void bcm2835_sys_timer_register_types(void)
> +{
> +    type_register_static(&bcm2835_sys_timer_info);
> +}
> +
> +type_init(bcm2835_sys_timer_register_types);
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index db02a9142c..81967a1a19 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -87,3 +87,7 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x =
value 0x%08x"
>  pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>  pl031_alarm_raised(void) "alarm raised"
>  pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
> +
> +# bcm2835_systmr.c
> +bcm2835_sys_timer_read(uint64_t offset, uint64_t data) "timer read: offs=
et 0x%" PRIx64 " data 0x%" PRIx64
> +bcm2835_sys_timer_write(uint64_t offset, uint64_t data) "timer write: of=
fset 0x%" PRIx64 " data 0x%" PRIx64
> diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835=
_systmr.h
> new file mode 100644
> index 0000000000..6ac7f8ec5a
> --- /dev/null
> +++ b/include/hw/timer/bcm2835_systmr.h
> @@ -0,0 +1,30 @@
> +/*
> + * BCM2835 SYS timer emulation
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 or
> + *  (at your option) any later version.
> + */
> +
> +#ifndef BCM2835_SYSTIMER_H
> +#define BCM2835_SYSTIMER_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/irq.h"
> +
> +#define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
> +#define BCM2835_SYSTIMER(obj) \
> +    OBJECT_CHECK(BCM2835SysTimerState, (obj), TYPE_BCM2835_SYSTIMER)
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +} BCM2835SysTimerState;
> +
> +#endif


--
Alex Benn=C3=A9e

