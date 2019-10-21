Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F492067B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2E9lJeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F492067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMeRE-0000hG-HD
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 16:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMeQX-00009r-IW
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMeQV-0003Gx-SM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:37:17 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMeQV-0003Gb-Fr; Mon, 21 Oct 2019 16:37:15 -0400
Received: by mail-lj1-x243.google.com with SMTP id n14so14764296ljj.10;
 Mon, 21 Oct 2019 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y0imO85UQUZUpBMSCf/VPCjnJwKMkzt/zQlbfwT/TW4=;
 b=k2E9lJeLXA996WM9WuZwTU8G5LSQyTqEZjdkyptlo7YKjcxVfPnlWhsqfb64YxgcK3
 z6M2xqmJ0o902de80sC+1GwxIegnPWtqYFPj2gGTjj+xPU5IQBZekIgSANL0MbH3vEMC
 +QRJNyTTY1YkuIBSCDvsQ0/mFzs8Xr7/GVGpJ1rb1pnU7Zt3AsGuZt8XyeUtvQT1yaTX
 20tq+Wi5JjERwoEN9vQFeUej2ptiNzSoUJ0Zbvt1NjOcKKeqJEUmQGfKNtQ00rEvDYUb
 SSQVDR3QCtv4AAYhdQ34TsTB+OPPqfcBe5pc/vz9mV3nfjE58HMwJHSS62zOpE4dCMmM
 uxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y0imO85UQUZUpBMSCf/VPCjnJwKMkzt/zQlbfwT/TW4=;
 b=k6HSeDXgq2U854GQurgjHeEx0wTr5DKC/x49hN6xvj9q1SWNenM0P4QUHCmzU4zGgx
 iA3dxvRcvXIglHXQqbtLHfrCrA7Z2XBwAf9u4Z34UlL94y312wmVYt1gOTqtZowoL1py
 +/FbrQVkwhxYS2lTFqP7EPUTweCHnfSofZq6cfH2mLJG8duuIcjjFy1yM3d5dxjIQ+dY
 eELoJkfOgs/GEbW6VdNcVuCrFLCnJ2G6haOy/o3zSyFYiONz3RaAD2H7wLbsLZYg+gOu
 tuEJkjCN2D7K96U8Au0tE7TNK0wYhrVujFzBewKDNsz0WejFRBHfCJNqjomw8+GslFkI
 ggtQ==
X-Gm-Message-State: APjAAAWhzIcOCxNzVXcPHnXl+qyTlfajSn4V3ZrwZe42FHGkAmxoAMhO
 GAITZNvPPaZSqK1INkQ5HHap4stgaNJlYWXh6pk=
X-Google-Smtp-Source: APXvYqwnUlcFtsLnr4QZ50E5IuNzyzmCncbAezdhK3I9QxyJMuqmsgpMMQaSjZOrwoiHATEa/Qnk4kNSx+I6g6C1gyE=
X-Received: by 2002:a2e:9604:: with SMTP id v4mr16735467ljh.101.1571690233855; 
 Mon, 21 Oct 2019 13:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <20191019234715.25750-4-f4bug@amsat.org>
In-Reply-To: <20191019234715.25750-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:31:48 -0700
Message-ID: <CAKmqyKNHTrOWfyuzG+s=iZ-AifD_OzDrTgvXGCXqXa2bsZiPOg@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] hw/timer/bcm2835: Add the BCM2835 SYS_timer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 4:47 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Add the 64-bit free running timer. Do not model the COMPARE register
> (no IRQ generated).
> This timer is used by Linux kernel and recently U-Boot:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clocksource/bcm2835_timer.c?h=3Dv3.7
> https://github.com/u-boot/u-boot/blob/v2019.07/include/configs/rpi.h#L19
>
> Datasheet used:
> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.p=
df
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2:
> - Add status/compare* registers
> - Add vmstate and reset handler
>
> checkpatch warning:
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> This is OK because the regex are:
>
>   F: hw/*/bcm283*
>   F: include/hw/*/bcm283*
> ---
>  hw/timer/Makefile.objs            |   1 +
>  hw/timer/bcm2835_systmr.c         | 166 ++++++++++++++++++++++++++++++
>  hw/timer/trace-events             |   5 +
>  include/hw/timer/bcm2835_systmr.h |  33 ++++++
>  4 files changed, 205 insertions(+)
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
> index 0000000000..49b40b55f9
> --- /dev/null
> +++ b/hw/timer/bcm2835_systmr.c
> @@ -0,0 +1,166 @@
> +/*
> + * BCM2835 SYS timer emulation
> + *
> + * Copyright (C) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +#include "qemu/log.h"
> +#include "qemu/timer.h"
> +#include "hw/timer/bcm2835_systmr.h"
> +#include "hw/registerfields.h"
> +#include "migration/vmstate.h"
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
> +static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
> +{
> +    bool enable =3D !!s->reg.status;
> +
> +    trace_bcm2835_systmr_irq(enable);
> +    qemu_set_irq(s->irq, enable);
> +}
> +
> +static void bcm2835_systmr_update_compare(BCM2835SystemTimerState *s,
> +                                          unsigned timer_index)
> +{
> +    /* TODO fow now, since neither Linux nor U-boot use these timers. */
> +    qemu_log_mask(LOG_UNIMP, "COMPARE register %u not implemented\n",
> +                  timer_index);
> +}
> +
> +static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
> +                                    unsigned size)
> +{
> +    BCM2835SystemTimerState *s =3D BCM2835_SYSTIMER(opaque);
> +    uint64_t r =3D 0;
> +
> +    switch (offset) {
> +    case A_CTRL_STATUS:
> +        r =3D s->reg.status;
> +        break;
> +    case A_COMPARE0 ... A_COMPARE3:
> +        r =3D s->reg.compare[(offset - A_COMPARE0) >> 2];
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
> +    trace_bcm2835_systmr_read(offset, r);
> +
> +    return r;
> +}
> +
> +static void bcm2835_systmr_write(void *opaque, hwaddr offset,
> +                                 uint64_t value, unsigned size)
> +{
> +    BCM2835SystemTimerState *s =3D BCM2835_SYSTIMER(opaque);
> +
> +    trace_bcm2835_systmr_write(offset, value);
> +    switch (offset) {
> +    case A_CTRL_STATUS:
> +        s->reg.status &=3D ~value; /* Ack */
> +        bcm2835_systmr_update_irq(s);
> +        break;
> +    case A_COMPARE0 ... A_COMPARE3:
> +        s->reg.compare[(offset - A_COMPARE0) >> 2] =3D value;
> +        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
> +        break;
> +    case A_COUNTER_LOW:
> +    case A_COUNTER_HIGH:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read-only ofs 0x%" HWADDR_PR=
Ix "\n",
> +                      __func__, offset);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PRIx =
"\n",
> +                      __func__, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2835_systmr_ops =3D {
> +    .read =3D bcm2835_systmr_read,
> +    .write =3D bcm2835_systmr_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void bcm2835_systmr_reset(DeviceState *dev)
> +{
> +    BCM2835SystemTimerState *s =3D BCM2835_SYSTIMER(dev);
> +
> +    s->reg.status =3D 0;
> +    for (size_t i =3D 0; i < ARRAY_SIZE(s->reg.compare); i++) {
> +        s->reg.compare[i] =3D 0;
> +    }

Can we use meset (or the glib version) here instead?

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +}
> +
> +static void bcm2835_systmr_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM2835SystemTimerState *s =3D BCM2835_SYSTIMER(dev);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_systmr_ops,
> +                          s, "bcm2835-sys-timer", 0x20);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> +}
> +
> +static const VMStateDescription bcm2835_systmr_vmstate =3D {
> +    .name =3D "bcm2835_sys_timer",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
> +        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState, 4),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void bcm2835_systmr_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D bcm2835_systmr_realize;
> +    dc->reset =3D bcm2835_systmr_reset;
> +    dc->vmsd =3D &bcm2835_systmr_vmstate;
> +}
> +
> +static const TypeInfo bcm2835_systmr_info =3D {
> +    .name =3D TYPE_BCM2835_SYSTIMER,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(BCM2835SystemTimerState),
> +    .class_init =3D bcm2835_systmr_class_init,
> +};
> +
> +static void bcm2835_systmr_register_types(void)
> +{
> +    type_register_static(&bcm2835_systmr_info);
> +}
> +
> +type_init(bcm2835_systmr_register_types);
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index db02a9142c..0aa399ac69 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -87,3 +87,8 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x =
value 0x%08x"
>  pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>  pl031_alarm_raised(void) "alarm raised"
>  pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
> +
> +# bcm2835_systmr.c
> +bcm2835_systmr_irq(bool enable) "timer irq state %u"
> +bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset =
0x%" PRIx64 " data 0x%" PRIx64
> +bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offse=
t 0x%" PRIx64 " data 0x%" PRIx64
> diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835=
_systmr.h
> new file mode 100644
> index 0000000000..c0bc5c8127
> --- /dev/null
> +++ b/include/hw/timer/bcm2835_systmr.h
> @@ -0,0 +1,33 @@
> +/*
> + * BCM2835 SYS timer emulation
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +    OBJECT_CHECK(BCM2835SystemTimerState, (obj), TYPE_BCM2835_SYSTIMER)
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +
> +    struct {
> +        uint32_t status;
> +        uint32_t compare[4];
> +    } reg;
> +} BCM2835SystemTimerState;
> +
> +#endif
> --
> 2.21.0
>
>

