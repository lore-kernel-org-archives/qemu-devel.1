Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4A0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 00:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAE420684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 00:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBseH/zZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAE420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNnHE-00011h-4f
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 20:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iNnG3-0007V7-KJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 20:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iNnG1-0003td-Je
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 20:15:11 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iNnFw-0003qB-T7; Thu, 24 Oct 2019 20:15:05 -0400
Received: by mail-lf1-x144.google.com with SMTP id q28so172245lfa.5;
 Thu, 24 Oct 2019 17:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q/0pfwHDYitc8TIvfh7pSX4cxFlC3UvQL1TsayvnXio=;
 b=PBseH/zZL8U9FqtV71DntwgmXwLkgwg1UDep0+Fw37Ntowaoya8HKKeCVuNDoAmTVx
 lVJnZ1n9qYoHUpVk7b0VuyUGMEW3VnxiZVp83+JK533SSmbKqocKibNp+uOx4ees7ULT
 on697fAi3c9NvCnwT602usv0JUqTzFmgdBzuhD9L3iXn/6DTYYs4/ec7EFL6HsFHIogf
 83dc26XGZvuUDqHl4sqYlqvwnXPVdMt7mNSyLE0nrhVK2LoMMh3Ddrsd1O5ijpLeZCmY
 hq1uxn4dANQ/45NbSbcPXEO36f6w2VhgVNSLkrQKklvLMddmsaKVzq3zJJ92pLko2cn8
 TADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q/0pfwHDYitc8TIvfh7pSX4cxFlC3UvQL1TsayvnXio=;
 b=DaIs5ssVCn+FDvjhjqqgNVo/LoqXnAQbTDhBehh9wJrjleMuv07Fu8PreiB0ddyCQo
 Joo2EjokhB4VEHOmbWyPpuHwnf3r53S8SustlpBBsAlzdYP/EvQXVLsi3fIDUW71f5In
 BkIvwsyfOvrtiShWL/inDao4OmzzhW3OpMv+1FEmdkPFCBH5hXxgJgZcysEUiSofq0Aw
 LcBvdbkStaEjIbpfCE7tmw8iotX85noiRY65IFkcPaXbmVyiTHJb2885XvVbYeIntdW0
 AfoanRNkR4cN805bj1j46DSUy2ZSBn1mabUbsdKR2hX3F9S4BCXqMV+xD9Q4cAOvj3Nr
 sD/A==
X-Gm-Message-State: APjAAAWThdBEkMv1MU8nCMNbFI7UhVmc1Bc1oYbCQw1ZoSScOxC85xCM
 5JjHAr4RCkM6IjD3Yvmh2i4rjPjS/02F7jAERTI=
X-Google-Smtp-Source: APXvYqwGYTtFtiR7uF1yfmRzcpuYtA3Or6OBOIn6ma1aOG/zaCT4548nb2hS/smhfavk9o77+wmb0blGFliwOD07K78=
X-Received: by 2002:a19:f018:: with SMTP id p24mr488087lfc.93.1571962501887;
 Thu, 24 Oct 2019 17:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191023063620.35104-1-anup.patel@wdc.com>
 <20191023063620.35104-2-anup.patel@wdc.com>
In-Reply-To: <20191023063620.35104-2-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Oct 2019 17:09:41 -0700
Message-ID: <CAKmqyKM5yO_KBfcmXyQgaQoCxegQOK_D_uzJMG7AcGPp=iHm1A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hw: rtc: Add Goldfish RTC device
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 22, 2019 at 11:37 PM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> This patch adds model for Google Goldfish virtual platform RTC device.
>
> We will be adding Goldfish RTC device to the QEMU RISC-V virt machine
> for providing real date-time to Guest Linux. The corresponding Linux
> driver for Goldfish RTC device is already available in upstream Linux.
>
> For now, VM migration support is available but untested for Goldfish RTC
> device. It will be hardened in-future when we implement VM migration for
> KVM RISC-V.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/rtc/Kconfig                  |   3 +
>  hw/rtc/Makefile.objs            |   1 +
>  hw/rtc/goldfish_rtc.c           | 288 ++++++++++++++++++++++++++++++++
>  hw/rtc/trace-events             |   4 +
>  include/hw/timer/goldfish_rtc.h |  46 +++++
>  5 files changed, 342 insertions(+)
>  create mode 100644 hw/rtc/goldfish_rtc.c
>  create mode 100644 include/hw/timer/goldfish_rtc.h
>
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 45daa8d655..bafe6ac2c9 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -21,3 +21,6 @@ config MC146818RTC
>
>  config SUN4V_RTC
>      bool
> +
> +config GOLDFISH_RTC
> +    bool
> diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
> index 8dc9fcd3a9..aa208d0d10 100644
> --- a/hw/rtc/Makefile.objs
> +++ b/hw/rtc/Makefile.objs
> @@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
>  obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_rtc.o
> +common-obj-$(CONFIG_GOLDFISH_RTC) += goldfish_rtc.o
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> new file mode 100644
> index 0000000000..f49a8e4489
> --- /dev/null
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -0,0 +1,288 @@
> +/*
> + * Goldfish virtual platform RTC
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + *
> + * For more details on Google Goldfish virtual platform refer:
> + * https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "hw/timer/goldfish_rtc.h"
> +#include "migration/vmstate.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "qemu/timer.h"
> +#include "sysemu/sysemu.h"
> +#include "qemu/cutils.h"
> +#include "qemu/log.h"
> +
> +#include "trace.h"
> +
> +#define RTC_TIME_LOW            0x00
> +#define RTC_TIME_HIGH           0x04
> +#define RTC_ALARM_LOW           0x08
> +#define RTC_ALARM_HIGH          0x0c
> +#define RTC_IRQ_ENABLED         0x10
> +#define RTC_CLEAR_ALARM         0x14
> +#define RTC_ALARM_STATUS        0x18
> +#define RTC_CLEAR_INTERRUPT     0x1c
> +
> +static void goldfish_rtc_update(GoldfishRTCState *s)
> +{
> +    qemu_set_irq(s->irq, (s->irq_pending & s->irq_enabled) ? 1 : 0);
> +}
> +
> +static void goldfish_rtc_interrupt(void *opaque)
> +{
> +    GoldfishRTCState *s = (GoldfishRTCState *)opaque;
> +
> +    s->alarm_running = 0;
> +    s->irq_pending = 1;
> +    goldfish_rtc_update(s);
> +}
> +
> +static uint64_t goldfish_rtc_get_count(GoldfishRTCState *s)
> +{
> +    return s->tick_offset + (uint64_t)qemu_clock_get_ns(rtc_clock);
> +}
> +
> +static void goldfish_rtc_clear_alarm(GoldfishRTCState *s)
> +{
> +    timer_del(s->timer);
> +    s->alarm_running = 0;
> +}
> +
> +static void goldfish_rtc_set_alarm(GoldfishRTCState *s)
> +{
> +    uint64_t ticks = goldfish_rtc_get_count(s);
> +    uint64_t event = s->alarm_next;
> +
> +    if (event <= ticks) {
> +        goldfish_rtc_clear_alarm(s);
> +        goldfish_rtc_interrupt(s);
> +    } else {
> +        /*
> +         * We should be setting timer expiry to:
> +         *     qemu_clock_get_ns(rtc_clock) + (event - ticks)
> +         * but this is equivalent to:
> +         *     event - s->tick_offset
> +         */
> +        timer_mod(s->timer, event - s->tick_offset);
> +        s->alarm_running = 1;
> +    }
> +}
> +
> +static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
> +                                  unsigned size)
> +{
> +    GoldfishRTCState *s = (GoldfishRTCState *)opaque;

This shouldn't be cast, use GOLDFISH_RTC(opaque) instead

> +    uint64_t r = 0;
> +
> +    switch (offset) {
> +    case RTC_TIME_LOW:
> +        r = goldfish_rtc_get_count(s) & 0xffffffff;
> +        break;
> +    case RTC_TIME_HIGH:
> +        r = goldfish_rtc_get_count(s) >> 32;
> +        break;
> +    case RTC_ALARM_LOW:
> +        r = s->alarm_next & 0xffffffff;
> +        break;
> +    case RTC_ALARM_HIGH:
> +        r = s->alarm_next >> 32;
> +        break;
> +    case RTC_IRQ_ENABLED:
> +        r = s->irq_enabled;
> +        break;
> +    case RTC_ALARM_STATUS:
> +        r = s->alarm_running;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%x\n", __func__, (uint32_t)offset);
> +        break;
> +    }
> +
> +    trace_goldfish_rtc_read(offset, r);
> +
> +    return r;
> +}
> +
> +static void goldfish_rtc_write(void *opaque, hwaddr offset,
> +                               uint64_t value, unsigned size)
> +{
> +    GoldfishRTCState *s = (GoldfishRTCState *)opaque;

Same applies here.

> +    uint64_t current_tick, new_tick;
> +
> +    switch (offset) {
> +    case RTC_TIME_LOW:
> +        current_tick = goldfish_rtc_get_count(s);
> +        new_tick = current_tick & (0xffffffffULL << 32);
> +        new_tick |= value;
> +        s->tick_offset += new_tick - current_tick;
> +        break;
> +    case RTC_TIME_HIGH:
> +        current_tick = goldfish_rtc_get_count(s);
> +        new_tick = current_tick & 0xffffffffULL;
> +        new_tick |= (value << 32);
> +        s->tick_offset += new_tick - current_tick;
> +        break;
> +    case RTC_ALARM_LOW:
> +        s->alarm_next &= (0xffffffffULL << 32);
> +        s->alarm_next |= value;
> +        goldfish_rtc_set_alarm(s);
> +        break;
> +    case RTC_ALARM_HIGH:
> +        s->alarm_next &= 0xffffffffULL;
> +        s->alarm_next |= (value << 32);
> +        break;
> +    case RTC_IRQ_ENABLED:
> +        s->irq_enabled = (uint32_t)(value & 0x1);
> +        goldfish_rtc_update(s);
> +        break;
> +    case RTC_CLEAR_ALARM:
> +        goldfish_rtc_clear_alarm(s);
> +        break;
> +    case RTC_CLEAR_INTERRUPT:
> +        s->irq_pending = 0;
> +        goldfish_rtc_update(s);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%x\n", __func__, (uint32_t)offset);
> +        break;
> +    }
> +
> +    trace_aspeed_rtc_write(offset, value);

This must be a typo.

Alistair

> +}
> +
> +static int goldfish_rtc_pre_save(void *opaque)
> +{
> +    uint64_t delta;
> +    GoldfishRTCState *s = opaque;
> +
> +    /*
> +     * We want to migrate this offset, which sounds straightforward.
> +     * Unfortunately, we cannot directly pass tick_offset because
> +     * rtc_clock on destination Host might not be same source Host.
> +     *
> +     * To tackle, this we pass tick_offset relative to vm_clock from
> +     * source Host and make it relative to rtc_clock at destination Host.
> +     */
> +    delta = qemu_clock_get_ns(rtc_clock) -
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tick_offset_vmstate = s->tick_offset + delta;
> +
> +    return 0;
> +}
> +
> +static int goldfish_rtc_post_load(void *opaque, int version_id)
> +{
> +    uint64_t delta;
> +    GoldfishRTCState *s = opaque;
> +
> +    /*
> +     * We extract tick_offset from tick_offset_vmstate by doing
> +     * reverse math compared to pre_save() function.
> +     */
> +    delta = qemu_clock_get_ns(rtc_clock) -
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tick_offset = s->tick_offset_vmstate - delta;
> +
> +    return 0;
> +}
> +
> +static const MemoryRegionOps goldfish_rtc_ops = {
> +    .read = goldfish_rtc_read,
> +    .write = goldfish_rtc_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4
> +    }
> +};
> +
> +static const VMStateDescription goldfish_rtc_vmstate = {
> +    .name = TYPE_GOLDFISH_RTC,
> +    .version_id = 1,
> +    .pre_save = goldfish_rtc_pre_save,
> +    .post_load = goldfish_rtc_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
> +        VMSTATE_UINT64(alarm_next, GoldfishRTCState),
> +        VMSTATE_UINT32(alarm_running, GoldfishRTCState),
> +        VMSTATE_UINT32(irq_pending, GoldfishRTCState),
> +        VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void goldfish_rtc_reset(DeviceState *dev)
> +{
> +    GoldfishRTCState *s = GOLDFISH_RTC(dev);
> +    struct tm tm;
> +
> +    timer_del(s->timer);
> +
> +    qemu_get_timedate(&tm, 0);
> +    s->tick_offset = mktimegm(&tm);
> +    s->tick_offset *= NANOSECONDS_PER_SECOND;
> +    s->tick_offset -= qemu_clock_get_ns(rtc_clock);
> +    s->tick_offset_vmstate = 0;
> +    s->alarm_next = 0;
> +    s->alarm_running = 0;
> +    s->irq_pending = 0;
> +    s->irq_enabled = 0;
> +}
> +
> +static void goldfish_rtc_realize(DeviceState *d, Error **errp)
> +{
> +    SysBusDevice *dev = SYS_BUS_DEVICE(d);
> +    GoldfishRTCState *s = GOLDFISH_RTC(d);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
> +                          "goldfish_rtc", 0x1000);
> +    sysbus_init_mmio(dev, &s->iomem);
> +
> +    sysbus_init_irq(dev, &s->irq);
> +
> +    s->timer = timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
> +}
> +
> +static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = goldfish_rtc_realize;
> +    dc->reset = goldfish_rtc_reset;
> +    dc->vmsd = &goldfish_rtc_vmstate;
> +}
> +
> +static const TypeInfo goldfish_rtc_info = {
> +    .name          = TYPE_GOLDFISH_RTC,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(GoldfishRTCState),
> +    .class_init    = goldfish_rtc_class_init,
> +};
> +
> +static void goldfish_rtc_register_types(void)
> +{
> +    type_register_static(&goldfish_rtc_info);
> +}
> +
> +type_init(goldfish_rtc_register_types)
> diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
> index d6749f4616..0bfaa26cb8 100644
> --- a/hw/rtc/trace-events
> +++ b/hw/rtc/trace-events
> @@ -17,3 +17,7 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
>  # aspeed-rtc.c
>  aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
>  aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
> +
> +# goldfish_rtc.c
> +goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
> +goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
> diff --git a/include/hw/timer/goldfish_rtc.h b/include/hw/timer/goldfish_rtc.h
> new file mode 100644
> index 0000000000..dfb6d70b86
> --- /dev/null
> +++ b/include/hw/timer/goldfish_rtc.h
> @@ -0,0 +1,46 @@
> +/*
> + * Goldfish virtual platform RTC
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + *
> + * For more details on Google Goldfish virtual platform refer:
> + * https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_TIMER_GOLDFISH_RTC_H
> +#define HW_TIMER_GOLDFISH_RTC_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_GOLDFISH_RTC "goldfish_rtc"
> +#define GOLDFISH_RTC(obj) \
> +OBJECT_CHECK(GoldfishRTCState, (obj), TYPE_GOLDFISH_RTC)
> +
> +typedef struct GoldfishRTCState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    QEMUTimer *timer;
> +    qemu_irq irq;
> +
> +    uint64_t tick_offset;
> +    uint64_t tick_offset_vmstate;
> +    uint64_t alarm_next;
> +    uint32_t alarm_running;
> +    uint32_t irq_pending;
> +    uint32_t irq_enabled;
> +} GoldfishRTCState;
> +
> +#endif
> --
> 2.17.1
>
>

