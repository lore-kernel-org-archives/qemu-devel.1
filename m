Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883EAC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F7E2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omlVW2fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F7E2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir5FB-0004Qt-Bs
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 14:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ir5ER-0003t3-6l
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ir5EN-0001KI-Ll
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:18:35 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134]:36813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ir5EN-0001JF-Dh; Mon, 13 Jan 2020 14:18:31 -0500
Received: by mail-il1-x134.google.com with SMTP id b15so9171556iln.3;
 Mon, 13 Jan 2020 11:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BNeu3Zq0fyTmvf3zMhADhTohZfI5yzASIyfZJHhiegs=;
 b=omlVW2fTPQh5hfQmRlMtbTa84zN89iCgm7d07grwACawr0rW/qGcmbCvPOCjtJsvAB
 j0t7wgCBg5AjTOjkWeIiOjPm4iEhYp3CYe3ShLoNHWBA88/A00sqm46VB0yI12QBC4EN
 CO8xuRFVGJGu0ynD1Z5/BY0Gi16iN4m0e1jpJLNLibzC5QZTOyOaM5FshAhbm8gA9zWb
 9eyLPfMAhehmRopJVEM/5YMnthcWVtbWBhf62MqFk84cz9+AZNDuReqlwrMzT8h4M9cl
 JLuV2sDrf8EqV/5E3OOX1IBSPGATJiriqhR9UOKrmWz/dqRBvOaCisTuo1VsN17rPSD4
 sUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BNeu3Zq0fyTmvf3zMhADhTohZfI5yzASIyfZJHhiegs=;
 b=lKQea5eBaxP4w0gYBJP/aa0X5QlJ/7+RRIjJMiFttCBuwHTD26GSNH24Hc2Rgf7IJQ
 d0qzDeEk2/UqfToQubezXOqnOFipmIbLqZssUqv+3f19cS6X0bOy3FIDmItEPeZeyCyM
 n+FCRknRAAhycAdKeu/W3dDftx+6P/iOIqHI0yn9TiPrVUBUaz62sSpSeoUCT7xOOYuB
 ABPJ9dMGjU8yAJG4q7RioymVna5xmzWW5QsXGJ2w1stMHJZWSfWb72yeSvkAd5MixTgC
 AD001/kb+NmO+LkICmyxZ5V8V2cDjiaXteFpDO2LhwNfg4ScUsPA/yrlfVijxWIpYkvC
 XDww==
X-Gm-Message-State: APjAAAXYa66441S+Vwpsf6rFssZkkiBQNtb1bP+3RABdmGvNNkWHvSYK
 SQ+PVydvBu5cMpNGbiOR9ncRXyKyfRptc5oxp+oeog==
X-Google-Smtp-Source: APXvYqxlDlrhIiyAzAERceRgM6HEySH8rveDJuEnlb/51tZCQwNT2m4vIlFpXMT+R4IADaoDjBHMhQACV8QcsQT3wQk=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr15673345ilq.306.1578943110280; 
 Mon, 13 Jan 2020 11:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-4-nieklinnenbank@gmail.com>
In-Reply-To: <20200108200020.4745-4-nieklinnenbank@gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 13 Jan 2020 20:18:19 +0100
Message-ID: <CAPan3Woz1KdHpPA87ZfgzF+GE=RGOFDGdpDD3aMVkuUJwNSQNA@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] hw/arm/allwinner-h3: add Clock Control Unit
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000357a22059c0a5706"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::134
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000357a22059c0a5706
Content-Type: text/plain; charset="UTF-8"

Hi,

Just a friendly reminder for review of this patch and the others in this
series
that don't yet have a reviewed-by tag :-)

Regards,
Niek

On Wed, Jan 8, 2020 at 9:00 PM Niek Linnenbank <nieklinnenbank@gmail.com>
wrote:

> The Clock Control Unit is responsible for clock signal generation,
> configuration and distribution in the Allwinner H3 System on Chip.
> This commit adds support for the Clock Control Unit which emulates
> a simple read/write register interface.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  include/hw/arm/allwinner-h3.h      |   3 +
>  include/hw/misc/allwinner-h3-ccu.h |  67 ++++++++
>  hw/arm/allwinner-h3.c              |   9 +-
>  hw/misc/allwinner-h3-ccu.c         | 243 +++++++++++++++++++++++++++++
>  hw/misc/Makefile.objs              |   1 +
>  5 files changed, 322 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/misc/allwinner-h3-ccu.h
>  create mode 100644 hw/misc/allwinner-h3-ccu.c
>
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index 4e2e6202a9..0dc18b927a 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -43,6 +43,7 @@
>  #include "hw/arm/boot.h"
>  #include "hw/timer/allwinner-a10-pit.h"
>  #include "hw/intc/arm_gic.h"
> +#include "hw/misc/allwinner-h3-ccu.h"
>  #include "target/arm/cpu.h"
>
>  /**
> @@ -59,6 +60,7 @@ enum {
>      AW_H3_SRAM_A1,
>      AW_H3_SRAM_A2,
>      AW_H3_SRAM_C,
> +    AW_H3_CCU,
>      AW_H3_PIT,
>      AW_H3_UART0,
>      AW_H3_UART1,
> @@ -98,6 +100,7 @@ typedef struct AwH3State {
>      ARMCPU cpus[AW_H3_NUM_CPUS];
>      const hwaddr *memmap;
>      AwA10PITState timer;
> +    AwH3ClockCtlState ccu;
>      GICState gic;
>      MemoryRegion sram_a1;
>      MemoryRegion sram_a2;
> diff --git a/include/hw/misc/allwinner-h3-ccu.h
> b/include/hw/misc/allwinner-h3-ccu.h
> new file mode 100644
> index 0000000000..0dcb08ecd1
> --- /dev/null
> +++ b/include/hw/misc/allwinner-h3-ccu.h
> @@ -0,0 +1,67 @@
> +/*
> + * Allwinner H3 Clock Control Unit emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_MISC_ALLWINNER_H3_CCU_H
> +#define HW_MISC_ALLWINNER_H3_CCU_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +
> +/**
> + * @name Constants
> + * @{
> + */
> +
> +/** Highest register address used by CCU device */
> +#define AW_H3_CCU_REGS_MAXADDR  (0x304)
> +
> +/** Total number of known registers */
> +#define AW_H3_CCU_REGS_NUM      (AW_H3_CCU_REGS_MAXADDR /
> sizeof(uint32_t))
> +
> +/** @} */
> +
> +/**
> + * @name Object model
> + * @{
> + */
> +
> +#define TYPE_AW_H3_CCU    "allwinner-h3-ccu"
> +#define AW_H3_CCU(obj) \
> +    OBJECT_CHECK(AwH3ClockCtlState, (obj), TYPE_AW_H3_CCU)
> +
> +/** @} */
> +
> +/**
> + * Allwinner H3 CCU object instance state.
> + */
> +typedef struct AwH3ClockCtlState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    /** Maps I/O registers in physical memory */
> +    MemoryRegion iomem;
> +
> +    /** Array of hardware registers */
> +    uint32_t regs[AW_H3_CCU_REGS_NUM];
> +
> +} AwH3ClockCtlState;
> +
> +#endif /* HW_MISC_ALLWINNER_H3_CCU_H */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index c1ef31e875..b85edaea85 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -34,6 +34,7 @@ const hwaddr allwinner_h3_memmap[] = {
>      [AW_H3_SRAM_A1]    = 0x00000000,
>      [AW_H3_SRAM_A2]    = 0x00044000,
>      [AW_H3_SRAM_C]     = 0x00010000,
> +    [AW_H3_CCU]        = 0x01c20000,
>      [AW_H3_PIT]        = 0x01c20c00,
>      [AW_H3_UART0]      = 0x01c28000,
>      [AW_H3_UART1]      = 0x01c28400,
> @@ -75,7 +76,6 @@ struct AwH3Unimplemented {
>      { "usb2",      0x01c1c000, 4 * KiB },
>      { "usb3",      0x01c1d000, 4 * KiB },
>      { "smc",       0x01c1e000, 4 * KiB },
> -    { "ccu",       0x01c20000, 1 * KiB },
>      { "pio",       0x01c20800, 1 * KiB },
>      { "owa",       0x01c21000, 1 * KiB },
>      { "pwm",       0x01c21400, 1 * KiB },
> @@ -170,6 +170,9 @@ static void allwinner_h3_init(Object *obj)
>                                "clk0-freq", &error_abort);
>      object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
>                                "clk1-freq", &error_abort);
> +
> +    sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
> +                          TYPE_AW_H3_CCU);
>  }
>
>  static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> @@ -278,6 +281,10 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>      memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_C],
>                                  &s->sram_c);
>
> +    /* Clock Control Unit */
> +    qdev_init_nofail(DEVICE(&s->ccu));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
> +
>      /* UART0 */
>      serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
>                     qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0),
> diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c
> new file mode 100644
> index 0000000000..ccf58ccdf2
> --- /dev/null
> +++ b/hw/misc/allwinner-h3-ccu.c
> @@ -0,0 +1,243 @@
> +/*
> + * Allwinner H3 Clock Control Unit emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "hw/misc/allwinner-h3-ccu.h"
> +
> +/* CCU register offsets */
> +enum {
> +    REG_PLL_CPUX             = 0x0000, /* PLL CPUX Control */
> +    REG_PLL_AUDIO            = 0x0008, /* PLL Audio Control */
> +    REG_PLL_VIDEO            = 0x0010, /* PLL Video Control */
> +    REG_PLL_VE               = 0x0018, /* PLL VE Control */
> +    REG_PLL_DDR              = 0x0020, /* PLL DDR Control */
> +    REG_PLL_PERIPH0          = 0x0028, /* PLL Peripherals 0 Control */
> +    REG_PLL_GPU              = 0x0038, /* PLL GPU Control */
> +    REG_PLL_PERIPH1          = 0x0044, /* PLL Peripherals 1 Control */
> +    REG_PLL_DE               = 0x0048, /* PLL Display Engine Control */
> +    REG_CPUX_AXI             = 0x0050, /* CPUX/AXI Configuration */
> +    REG_APB1                 = 0x0054, /* ARM Peripheral Bus 1 Config */
> +    REG_APB2                 = 0x0058, /* ARM Peripheral Bus 2 Config */
> +    REG_DRAM_CFG             = 0x00F4, /* DRAM Configuration */
> +    REG_MBUS                 = 0x00FC, /* MBUS Reset */
> +    REG_PLL_TIME0            = 0x0200, /* PLL Stable Time 0 */
> +    REG_PLL_TIME1            = 0x0204, /* PLL Stable Time 1 */
> +    REG_PLL_CPUX_BIAS        = 0x0220, /* PLL CPUX Bias */
> +    REG_PLL_AUDIO_BIAS       = 0x0224, /* PLL Audio Bias */
> +    REG_PLL_VIDEO_BIAS       = 0x0228, /* PLL Video Bias */
> +    REG_PLL_VE_BIAS          = 0x022C, /* PLL VE Bias */
> +    REG_PLL_DDR_BIAS         = 0x0230, /* PLL DDR Bias */
> +    REG_PLL_PERIPH0_BIAS     = 0x0234, /* PLL Peripherals 0 Bias */
> +    REG_PLL_GPU_BIAS         = 0x023C, /* PLL GPU Bias */
> +    REG_PLL_PERIPH1_BIAS     = 0x0244, /* PLL Peripherals 1 Bias */
> +    REG_PLL_DE_BIAS          = 0x0248, /* PLL Display Engine Bias */
> +    REG_PLL_CPUX_TUNING      = 0x0250, /* PLL CPUX Tuning */
> +    REG_PLL_DDR_TUNING       = 0x0260, /* PLL DDR Tuning */
> +};
> +
> +#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
> +
> +/* CCU register flags */
> +enum {
> +    REG_DRAM_CFG_UPDATE      = (1 << 16),
> +};
> +
> +enum {
> +    REG_PLL_ENABLE           = (1 << 31),
> +    REG_PLL_LOCK             = (1 << 28),
> +};
> +
> +
> +/* CCU register reset values */
> +enum {
> +    REG_PLL_CPUX_RST         = 0x00001000,
> +    REG_PLL_AUDIO_RST        = 0x00035514,
> +    REG_PLL_VIDEO_RST        = 0x03006207,
> +    REG_PLL_VE_RST           = 0x03006207,
> +    REG_PLL_DDR_RST          = 0x00001000,
> +    REG_PLL_PERIPH0_RST      = 0x00041811,
> +    REG_PLL_GPU_RST          = 0x03006207,
> +    REG_PLL_PERIPH1_RST      = 0x00041811,
> +    REG_PLL_DE_RST           = 0x03006207,
> +    REG_CPUX_AXI_RST         = 0x00010000,
> +    REG_APB1_RST             = 0x00001010,
> +    REG_APB2_RST             = 0x01000000,
> +    REG_DRAM_CFG_RST         = 0x00000000,
> +    REG_MBUS_RST             = 0x80000000,
> +    REG_PLL_TIME0_RST        = 0x000000FF,
> +    REG_PLL_TIME1_RST        = 0x000000FF,
> +    REG_PLL_CPUX_BIAS_RST    = 0x08100200,
> +    REG_PLL_AUDIO_BIAS_RST   = 0x10100000,
> +    REG_PLL_VIDEO_BIAS_RST   = 0x10100000,
> +    REG_PLL_VE_BIAS_RST      = 0x10100000,
> +    REG_PLL_DDR_BIAS_RST     = 0x81104000,
> +    REG_PLL_PERIPH0_BIAS_RST = 0x10100010,
> +    REG_PLL_GPU_BIAS_RST     = 0x10100000,
> +    REG_PLL_PERIPH1_BIAS_RST = 0x10100010,
> +    REG_PLL_DE_BIAS_RST      = 0x10100000,
> +    REG_PLL_CPUX_TUNING_RST  = 0x0A101000,
> +    REG_PLL_DDR_TUNING_RST   = 0x14880000,
> +};
> +
> +static uint64_t allwinner_h3_ccu_read(void *opaque, hwaddr offset,
> +                                      unsigned size)
> +{
> +    const AwH3ClockCtlState *s = AW_H3_CCU(opaque);
> +    const uint32_t idx = REG_INDEX(offset);
> +
> +    if (idx >= AW_H3_CCU_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    return s->regs[idx];
> +}
> +
> +static void allwinner_h3_ccu_write(void *opaque, hwaddr offset,
> +                                   uint64_t val, unsigned size)
> +{
> +    AwH3ClockCtlState *s = AW_H3_CCU(opaque);
> +    const uint32_t idx = REG_INDEX(offset);
> +
> +    if (idx >= AW_H3_CCU_REGS_NUM) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    case REG_DRAM_CFG:    /* DRAM Configuration */
> +        val &= ~REG_DRAM_CFG_UPDATE;
> +        break;
> +    case REG_PLL_CPUX:    /* PLL CPUX Control */
> +    case REG_PLL_AUDIO:   /* PLL Audio Control */
> +    case REG_PLL_VIDEO:   /* PLL Video Control */
> +    case REG_PLL_VE:      /* PLL VE Control */
> +    case REG_PLL_DDR:     /* PLL DDR Control */
> +    case REG_PLL_PERIPH0: /* PLL Peripherals 0 Control */
> +    case REG_PLL_GPU:     /* PLL GPU Control */
> +    case REG_PLL_PERIPH1: /* PLL Peripherals 1 Control */
> +    case REG_PLL_DE:      /* PLL Display Engine Control */
> +        if (val & REG_PLL_ENABLE) {
> +            val |= REG_PLL_LOCK;
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset
> 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    }
> +
> +    s->regs[idx] = (uint32_t) val;
> +}
> +
> +static const MemoryRegionOps allwinner_h3_ccu_ops = {
> +    .read = allwinner_h3_ccu_read,
> +    .write = allwinner_h3_ccu_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +    .impl.min_access_size = 4,
> +};
> +
> +static void allwinner_h3_ccu_reset(DeviceState *dev)
> +{
> +    AwH3ClockCtlState *s = AW_H3_CCU(dev);
> +
> +    /* Set default values for registers */
> +    s->regs[REG_INDEX(REG_PLL_CPUX)] = REG_PLL_CPUX_RST;
> +    s->regs[REG_INDEX(REG_PLL_AUDIO)] = REG_PLL_AUDIO_RST;
> +    s->regs[REG_INDEX(REG_PLL_VIDEO)] = REG_PLL_VIDEO_RST;
> +    s->regs[REG_INDEX(REG_PLL_VE)] = REG_PLL_VE_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR)] = REG_PLL_DDR_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH0)] = REG_PLL_PERIPH0_RST;
> +    s->regs[REG_INDEX(REG_PLL_GPU)] = REG_PLL_GPU_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH1)] = REG_PLL_PERIPH1_RST;
> +    s->regs[REG_INDEX(REG_PLL_DE)] = REG_PLL_DE_RST;
> +    s->regs[REG_INDEX(REG_CPUX_AXI)] = REG_CPUX_AXI_RST;
> +    s->regs[REG_INDEX(REG_APB1)] = REG_APB1_RST;
> +    s->regs[REG_INDEX(REG_APB2)] = REG_APB2_RST;
> +    s->regs[REG_INDEX(REG_DRAM_CFG)] = REG_DRAM_CFG_RST;
> +    s->regs[REG_INDEX(REG_MBUS)] = REG_MBUS_RST;
> +    s->regs[REG_INDEX(REG_PLL_TIME0)] = REG_PLL_TIME0_RST;
> +    s->regs[REG_INDEX(REG_PLL_TIME1)] = REG_PLL_TIME1_RST;
> +    s->regs[REG_INDEX(REG_PLL_CPUX_BIAS)] = REG_PLL_CPUX_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_AUDIO_BIAS)] = REG_PLL_AUDIO_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_VIDEO_BIAS)] = REG_PLL_VIDEO_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_VE_BIAS)] = REG_PLL_VE_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR_BIAS)] = REG_PLL_DDR_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH0_BIAS)] = REG_PLL_PERIPH0_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_GPU_BIAS)] = REG_PLL_GPU_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_PERIPH1_BIAS)] = REG_PLL_PERIPH1_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_DE_BIAS)] = REG_PLL_DE_BIAS_RST;
> +    s->regs[REG_INDEX(REG_PLL_CPUX_TUNING)] = REG_PLL_CPUX_TUNING_RST;
> +    s->regs[REG_INDEX(REG_PLL_DDR_TUNING)] = REG_PLL_DDR_TUNING_RST;
> +}
> +
> +static void allwinner_h3_ccu_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    AwH3ClockCtlState *s = AW_H3_CCU(obj);
> +
> +    /* Memory mapping */
> +    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_ccu_ops, s,
> +                          TYPE_AW_H3_CCU, 1 * KiB);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +}
> +
> +static const VMStateDescription allwinner_h3_ccu_vmstate = {
> +    .name = "allwinner-h3-ccu",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AwH3ClockCtlState, AW_H3_CCU_REGS_NUM),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void allwinner_h3_ccu_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->reset = allwinner_h3_ccu_reset;
> +    dc->vmsd = &allwinner_h3_ccu_vmstate;
> +}
> +
> +static const TypeInfo allwinner_h3_ccu_info = {
> +    .name          = TYPE_AW_H3_CCU,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = allwinner_h3_ccu_init,
> +    .instance_size = sizeof(AwH3ClockCtlState),
> +    .class_init    = allwinner_h3_ccu_class_init,
> +};
> +
> +static void allwinner_h3_ccu_register(void)
> +{
> +    type_register_static(&allwinner_h3_ccu_info);
> +}
> +
> +type_init(allwinner_h3_ccu_register)
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index ba898a5781..4abd92dcee 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) += macio/
>
>  common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
>
> +common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
>  common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
>  common-obj-$(CONFIG_NSERIES) += cbus.o
>  common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
> --
> 2.17.1
>
>

-- 
Niek Linnenbank

--000000000000357a22059c0a5706
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Just a friendly reminder=
 for review of this patch and the others in this series</div><div>that don&=
#39;t yet have a reviewed-by tag :-)</div><div><br></div><div>Regards,</div=
><div>Niek<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Jan 8, 2020 at 9:00 PM Niek Linnenbank &lt;<a href=
=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The Clock Cont=
rol Unit is responsible for clock signal generation,<br>
configuration and distribution in the Allwinner H3 System on Chip.<br>
This commit adds support for the Clock Control Unit which emulates<br>
a simple read/write register interface.<br>
<br>
Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.c=
om" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
---<br>
=C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<b=
r>
=C2=A0include/hw/misc/allwinner-h3-ccu.h |=C2=A0 67 ++++++++<br>
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A09 +-<br>
=C2=A0hw/misc/allwinner-h3-ccu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 243 +++=
++++++++++++++++++++++++++<br>
=C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A01 +<br>
=C2=A05 files changed, 322 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-h3-ccu.h<br>
=C2=A0create mode 100644 hw/misc/allwinner-h3-ccu.c<br>
<br>
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h<=
br>
index 4e2e6202a9..0dc18b927a 100644<br>
--- a/include/hw/arm/allwinner-h3.h<br>
+++ b/include/hw/arm/allwinner-h3.h<br>
@@ -43,6 +43,7 @@<br>
=C2=A0#include &quot;hw/arm/boot.h&quot;<br>
=C2=A0#include &quot;hw/timer/allwinner-a10-pit.h&quot;<br>
=C2=A0#include &quot;hw/intc/arm_gic.h&quot;<br>
+#include &quot;hw/misc/allwinner-h3-ccu.h&quot;<br>
=C2=A0#include &quot;target/arm/cpu.h&quot;<br>
<br>
=C2=A0/**<br>
@@ -59,6 +60,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A1,<br>
=C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_A2,<br>
=C2=A0 =C2=A0 =C2=A0AW_H3_SRAM_C,<br>
+=C2=A0 =C2=A0 AW_H3_CCU,<br>
=C2=A0 =C2=A0 =C2=A0AW_H3_PIT,<br>
=C2=A0 =C2=A0 =C2=A0AW_H3_UART0,<br>
=C2=A0 =C2=A0 =C2=A0AW_H3_UART1,<br>
@@ -98,6 +100,7 @@ typedef struct AwH3State {<br>
=C2=A0 =C2=A0 =C2=A0ARMCPU cpus[AW_H3_NUM_CPUS];<br>
=C2=A0 =C2=A0 =C2=A0const hwaddr *memmap;<br>
=C2=A0 =C2=A0 =C2=A0AwA10PITState timer;<br>
+=C2=A0 =C2=A0 AwH3ClockCtlState ccu;<br>
=C2=A0 =C2=A0 =C2=A0GICState gic;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
diff --git a/include/hw/misc/allwinner-h3-ccu.h b/include/hw/misc/allwinner=
-h3-ccu.h<br>
new file mode 100644<br>
index 0000000000..0dcb08ecd1<br>
--- /dev/null<br>
+++ b/include/hw/misc/allwinner-h3-ccu.h<br>
@@ -0,0 +1,67 @@<br>
+/*<br>
+ * Allwinner H3 Clock Control Unit emulation<br>
+ *<br>
+ * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank=
@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software: you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation, either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gn=
u.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/li=
censes/</a>&gt;.<br>
+ */<br>
+<br>
+#ifndef HW_MISC_ALLWINNER_H3_CCU_H<br>
+#define HW_MISC_ALLWINNER_H3_CCU_H<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+<br>
+/**<br>
+ * @name Constants<br>
+ * @{<br>
+ */<br>
+<br>
+/** Highest register address used by CCU device */<br>
+#define AW_H3_CCU_REGS_MAXADDR=C2=A0 (0x304)<br>
+<br>
+/** Total number of known registers */<br>
+#define AW_H3_CCU_REGS_NUM=C2=A0 =C2=A0 =C2=A0 (AW_H3_CCU_REGS_MAXADDR / s=
izeof(uint32_t))<br>
+<br>
+/** @} */<br>
+<br>
+/**<br>
+ * @name Object model<br>
+ * @{<br>
+ */<br>
+<br>
+#define TYPE_AW_H3_CCU=C2=A0 =C2=A0 &quot;allwinner-h3-ccu&quot;<br>
+#define AW_H3_CCU(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_CHECK(AwH3ClockCtlState, (obj), TYPE_AW_H3_CCU)<br>
+<br>
+/** @} */<br>
+<br>
+/**<br>
+ * Allwinner H3 CCU object instance state.<br>
+ */<br>
+typedef struct AwH3ClockCtlState {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
+<br>
+=C2=A0 =C2=A0 /** Maps I/O registers in physical memory */<br>
+=C2=A0 =C2=A0 MemoryRegion iomem;<br>
+<br>
+=C2=A0 =C2=A0 /** Array of hardware registers */<br>
+=C2=A0 =C2=A0 uint32_t regs[AW_H3_CCU_REGS_NUM];<br>
+<br>
+} AwH3ClockCtlState;<br>
+<br>
+#endif /* HW_MISC_ALLWINNER_H3_CCU_H */<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index c1ef31e875..b85edaea85 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -34,6 +34,7 @@ const hwaddr allwinner_h3_memmap[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A1]=C2=A0 =C2=A0 =3D 0x00000000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x00010000,<br>
+=C2=A0 =C2=A0 [AW_H3_CCU]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_H3_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20c00,<=
br>
=C2=A0 =C2=A0 =C2=A0[AW_H3_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_H3_UART1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28400,<br>
@@ -75,7 +76,6 @@ struct AwH3Unimplemented {<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;usb2&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1c000, 4 *=
 KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;usb3&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c1d000, 4 *=
 KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;smc&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c1e000=
, 4 * KiB },<br>
-=C2=A0 =C2=A0 { &quot;ccu&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c20000, 1 *=
 KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;pio&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c20800=
, 1 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;owa&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c21000=
, 1 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;pwm&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c21400=
, 1 * KiB },<br>
@@ -170,6 +170,9 @@ static void allwinner_h3_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;clk0-freq&quot;, &amp;error_abo=
rt);<br>
=C2=A0 =C2=A0 =C2=A0object_property_add_alias(obj, &quot;clk1-freq&quot;, O=
BJECT(&amp;s-&gt;timer),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;clk1-freq&quot;, &amp;error_abo=
rt);<br>
+<br>
+=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;ccu&quot;, &amp;s-&gt;ccu, =
sizeof(s-&gt;ccu),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_AW_H3_CCU);<br>
=C2=A0}<br>
<br>
=C2=A0static void allwinner_h3_realize(DeviceState *dev, Error **errp)<br>
@@ -278,6 +281,10 @@ static void allwinner_h3_realize(DeviceState *dev, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(get_system_memory(), s-&gt;=
memmap[AW_H3_SRAM_C],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;sram_c);<br>
<br>
+=C2=A0 =C2=A0 /* Clock Control Unit */<br>
+=C2=A0 =C2=A0 qdev_init_nofail(DEVICE(&amp;s-&gt;ccu));<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ccu), 0, s-&gt;mem=
map[AW_H3_CCU]);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* UART0 */<br>
=C2=A0 =C2=A0 =C2=A0serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_=
UART0], 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_=
get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART0),<br>
diff --git a/hw/misc/allwinner-h3-ccu.c b/hw/misc/allwinner-h3-ccu.c<br>
new file mode 100644<br>
index 0000000000..ccf58ccdf2<br>
--- /dev/null<br>
+++ b/hw/misc/allwinner-h3-ccu.c<br>
@@ -0,0 +1,243 @@<br>
+/*<br>
+ * Allwinner H3 Clock Control Unit emulation<br>
+ *<br>
+ * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank=
@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
+ *<br>
+ * This program is free software: you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation, either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gn=
u.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/li=
censes/</a>&gt;.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;hw/misc/allwinner-h3-ccu.h&quot;<br>
+<br>
+/* CCU register offsets */<br>
+enum {<br>
+=C2=A0 =C2=A0 REG_PLL_CPUX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x0000, /* PLL CPUX Control */<br>
+=C2=A0 =C2=A0 REG_PLL_AUDIO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x0008, /* PLL Audio Control */<br>
+=C2=A0 =C2=A0 REG_PLL_VIDEO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x0010, /* PLL Video Control */<br>
+=C2=A0 =C2=A0 REG_PLL_VE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x0018, /* PLL VE Control */<br>
+=C2=A0 =C2=A0 REG_PLL_DDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x0020, /* PLL DDR Control */<br>
+=C2=A0 =C2=A0 REG_PLL_PERIPH0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0028=
, /* PLL Peripherals 0 Control */<br>
+=C2=A0 =C2=A0 REG_PLL_GPU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0x0038, /* PLL GPU Control */<br>
+=C2=A0 =C2=A0 REG_PLL_PERIPH1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0044=
, /* PLL Peripherals 1 Control */<br>
+=C2=A0 =C2=A0 REG_PLL_DE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D 0x0048, /* PLL Display Engine Control */<br>
+=C2=A0 =C2=A0 REG_CPUX_AXI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x0050, /* CPUX/AXI Configuration */<br>
+=C2=A0 =C2=A0 REG_APB1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0x0054, /* ARM Peripheral Bus 1 Config */<br>
+=C2=A0 =C2=A0 REG_APB2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0x0058, /* ARM Peripheral Bus 2 Config */<br>
+=C2=A0 =C2=A0 REG_DRAM_CFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x00F4, /* DRAM Configuration */<br>
+=C2=A0 =C2=A0 REG_MBUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0x00FC, /* MBUS Reset */<br>
+=C2=A0 =C2=A0 REG_PLL_TIME0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x0200, /* PLL Stable Time 0 */<br>
+=C2=A0 =C2=A0 REG_PLL_TIME1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0=
x0204, /* PLL Stable Time 1 */<br>
+=C2=A0 =C2=A0 REG_PLL_CPUX_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0220, /* =
PLL CPUX Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_AUDIO_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0224, /* =
PLL Audio Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_VIDEO_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0228, /* =
PLL Video Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_VE_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x022C=
, /* PLL VE Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_DDR_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0230=
, /* PLL DDR Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_PERIPH0_BIAS=C2=A0 =C2=A0 =C2=A0=3D 0x0234, /* PLL P=
eripherals 0 Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_GPU_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x023C=
, /* PLL GPU Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_PERIPH1_BIAS=C2=A0 =C2=A0 =C2=A0=3D 0x0244, /* PLL P=
eripherals 1 Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_DE_BIAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0248=
, /* PLL Display Engine Bias */<br>
+=C2=A0 =C2=A0 REG_PLL_CPUX_TUNING=C2=A0 =C2=A0 =C2=A0 =3D 0x0250, /* PLL C=
PUX Tuning */<br>
+=C2=A0 =C2=A0 REG_PLL_DDR_TUNING=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0260, /* =
PLL DDR Tuning */<br>
+};<br>
+<br>
+#define REG_INDEX(offset)=C2=A0 =C2=A0 (offset / sizeof(uint32_t))<br>
+<br>
+/* CCU register flags */<br>
+enum {<br>
+=C2=A0 =C2=A0 REG_DRAM_CFG_UPDATE=C2=A0 =C2=A0 =C2=A0 =3D (1 &lt;&lt; 16),=
<br>
+};<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 REG_PLL_ENABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (=
1 &lt;&lt; 31),<br>
+=C2=A0 =C2=A0 REG_PLL_LOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D (1 &lt;&lt; 28),<br>
+};<br>
+<br>
+<br>
+/* CCU register reset values */<br>
+enum {<br>
+=C2=A0 =C2=A0 REG_PLL_CPUX_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0000=
1000,<br>
+=C2=A0 =C2=A0 REG_PLL_AUDIO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x00035514,=
<br>
+=C2=A0 =C2=A0 REG_PLL_VIDEO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x03006207,=
<br>
+=C2=A0 =C2=A0 REG_PLL_VE_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x03006207,<br>
+=C2=A0 =C2=A0 REG_PLL_DDR_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0000=
1000,<br>
+=C2=A0 =C2=A0 REG_PLL_PERIPH0_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x00041811,<br>
+=C2=A0 =C2=A0 REG_PLL_GPU_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x0300=
6207,<br>
+=C2=A0 =C2=A0 REG_PLL_PERIPH1_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x00041811,<br>
+=C2=A0 =C2=A0 REG_PLL_DE_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x03006207,<br>
+=C2=A0 =C2=A0 REG_CPUX_AXI_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0001=
0000,<br>
+=C2=A0 =C2=A0 REG_APB1_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x00001010,<br>
+=C2=A0 =C2=A0 REG_APB2_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x01000000,<br>
+=C2=A0 =C2=A0 REG_DRAM_CFG_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0000=
0000,<br>
+=C2=A0 =C2=A0 REG_MBUS_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x80000000,<br>
+=C2=A0 =C2=A0 REG_PLL_TIME0_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x000000FF,=
<br>
+=C2=A0 =C2=A0 REG_PLL_TIME1_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x000000FF,=
<br>
+=C2=A0 =C2=A0 REG_PLL_CPUX_BIAS_RST=C2=A0 =C2=A0 =3D 0x08100200,<br>
+=C2=A0 =C2=A0 REG_PLL_AUDIO_BIAS_RST=C2=A0 =C2=A0=3D 0x10100000,<br>
+=C2=A0 =C2=A0 REG_PLL_VIDEO_BIAS_RST=C2=A0 =C2=A0=3D 0x10100000,<br>
+=C2=A0 =C2=A0 REG_PLL_VE_BIAS_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x10100000,<br>
+=C2=A0 =C2=A0 REG_PLL_DDR_BIAS_RST=C2=A0 =C2=A0 =C2=A0=3D 0x81104000,<br>
+=C2=A0 =C2=A0 REG_PLL_PERIPH0_BIAS_RST =3D 0x10100010,<br>
+=C2=A0 =C2=A0 REG_PLL_GPU_BIAS_RST=C2=A0 =C2=A0 =C2=A0=3D 0x10100000,<br>
+=C2=A0 =C2=A0 REG_PLL_PERIPH1_BIAS_RST =3D 0x10100010,<br>
+=C2=A0 =C2=A0 REG_PLL_DE_BIAS_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x10100000,<br>
+=C2=A0 =C2=A0 REG_PLL_CPUX_TUNING_RST=C2=A0 =3D 0x0A101000,<br>
+=C2=A0 =C2=A0 REG_PLL_DDR_TUNING_RST=C2=A0 =C2=A0=3D 0x14880000,<br>
+};<br>
+<br>
+static uint64_t allwinner_h3_ccu_read(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<=
br>
+{<br>
+=C2=A0 =C2=A0 const AwH3ClockCtlState *s =3D AW_H3_CCU(opaque);<br>
+=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
+<br>
+=C2=A0 =C2=A0 if (idx &gt;=3D AW_H3_CCU_REGS_NUM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: out-o=
f-bounds offset 0x%04x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, (uint32_t)offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return s-&gt;regs[idx];<br>
+}<br>
+<br>
+static void allwinner_h3_ccu_write(void *opaque, hwaddr offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, unsigned =
size)<br>
+{<br>
+=C2=A0 =C2=A0 AwH3ClockCtlState *s =3D AW_H3_CCU(opaque);<br>
+=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
+<br>
+=C2=A0 =C2=A0 if (idx &gt;=3D AW_H3_CCU_REGS_NUM) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: out-o=
f-bounds offset 0x%04x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, (uint32_t)offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 switch (offset) {<br>
+=C2=A0 =C2=A0 case REG_DRAM_CFG:=C2=A0 =C2=A0 /* DRAM Configuration */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val &amp;=3D ~REG_DRAM_CFG_UPDATE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case REG_PLL_CPUX:=C2=A0 =C2=A0 /* PLL CPUX Control */<br>
+=C2=A0 =C2=A0 case REG_PLL_AUDIO:=C2=A0 =C2=A0/* PLL Audio Control */<br>
+=C2=A0 =C2=A0 case REG_PLL_VIDEO:=C2=A0 =C2=A0/* PLL Video Control */<br>
+=C2=A0 =C2=A0 case REG_PLL_VE:=C2=A0 =C2=A0 =C2=A0 /* PLL VE Control */<br=
>
+=C2=A0 =C2=A0 case REG_PLL_DDR:=C2=A0 =C2=A0 =C2=A0/* PLL DDR Control */<b=
r>
+=C2=A0 =C2=A0 case REG_PLL_PERIPH0: /* PLL Peripherals 0 Control */<br>
+=C2=A0 =C2=A0 case REG_PLL_GPU:=C2=A0 =C2=A0 =C2=A0/* PLL GPU Control */<b=
r>
+=C2=A0 =C2=A0 case REG_PLL_PERIPH1: /* PLL Peripherals 1 Control */<br>
+=C2=A0 =C2=A0 case REG_PLL_DE:=C2=A0 =C2=A0 =C2=A0 /* PLL Display Engine C=
ontrol */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (val &amp; REG_PLL_ENABLE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val |=3D REG_PLL_LOCK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: unimplement=
ed write offset 0x%04x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, (uint32_t)offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[idx] =3D (uint32_t) val;<br>
+}<br>
+<br>
+static const MemoryRegionOps allwinner_h3_ccu_ops =3D {<br>
+=C2=A0 =C2=A0 .read =3D allwinner_h3_ccu_read,<br>
+=C2=A0 =C2=A0 .write =3D allwinner_h3_ccu_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+=C2=A0 =C2=A0 .valid =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 .impl.min_access_size =3D 4,<br>
+};<br>
+<br>
+static void allwinner_h3_ccu_reset(DeviceState *dev)<br>
+{<br>
+=C2=A0 =C2=A0 AwH3ClockCtlState *s =3D AW_H3_CCU(dev);<br>
+<br>
+=C2=A0 =C2=A0 /* Set default values for registers */<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_CPUX)] =3D REG_PLL_CPUX_RST;<br=
>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_AUDIO)] =3D REG_PLL_AUDIO_RST;<=
br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_VIDEO)] =3D REG_PLL_VIDEO_RST;<=
br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_VE)] =3D REG_PLL_VE_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DDR)] =3D REG_PLL_DDR_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_PERIPH0)] =3D REG_PLL_PERIPH0_R=
ST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_GPU)] =3D REG_PLL_GPU_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_PERIPH1)] =3D REG_PLL_PERIPH1_R=
ST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DE)] =3D REG_PLL_DE_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_CPUX_AXI)] =3D REG_CPUX_AXI_RST;<br=
>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_APB1)] =3D REG_APB1_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_APB2)] =3D REG_APB2_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_DRAM_CFG)] =3D REG_DRAM_CFG_RST;<br=
>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_MBUS)] =3D REG_MBUS_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_TIME0)] =3D REG_PLL_TIME0_RST;<=
br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_TIME1)] =3D REG_PLL_TIME1_RST;<=
br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_CPUX_BIAS)] =3D REG_PLL_CPUX_BI=
AS_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_AUDIO_BIAS)] =3D REG_PLL_AUDIO_=
BIAS_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_VIDEO_BIAS)] =3D REG_PLL_VIDEO_=
BIAS_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_VE_BIAS)] =3D REG_PLL_VE_BIAS_R=
ST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DDR_BIAS)] =3D REG_PLL_DDR_BIAS=
_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_PERIPH0_BIAS)] =3D REG_PLL_PERI=
PH0_BIAS_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_GPU_BIAS)] =3D REG_PLL_GPU_BIAS=
_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_PERIPH1_BIAS)] =3D REG_PLL_PERI=
PH1_BIAS_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DE_BIAS)] =3D REG_PLL_DE_BIAS_R=
ST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_CPUX_TUNING)] =3D REG_PLL_CPUX_=
TUNING_RST;<br>
+=C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_PLL_DDR_TUNING)] =3D REG_PLL_DDR_TU=
NING_RST;<br>
+}<br>
+<br>
+static void allwinner_h3_ccu_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
+=C2=A0 =C2=A0 AwH3ClockCtlState *s =3D AW_H3_CCU(obj);<br>
+<br>
+=C2=A0 =C2=A0 /* Memory mapping */<br>
+=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp;allw=
inner_h3_ccu_ops, s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_AW_H3_CCU, 1 * KiB);<br>
+=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
+}<br>
+<br>
+static const VMStateDescription allwinner_h3_ccu_vmstate =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;allwinner-h3-ccu&quot;,<br>
+=C2=A0 =C2=A0 .version_id =3D 1,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
+=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, AwH3ClockCtlState, =
AW_H3_CCU_REGS_NUM),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+static void allwinner_h3_ccu_class_init(ObjectClass *klass, void *data)<br=
>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;reset =3D allwinner_h3_ccu_reset;<br>
+=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_h3_ccu_vmstate;<br>
+}<br>
+<br>
+static const TypeInfo allwinner_h3_ccu_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_H3_CCU,<=
br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEVICE,<=
br>
+=C2=A0 =C2=A0 .instance_init =3D allwinner_h3_ccu_init,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(AwH3ClockCtlState),<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_h3_ccu_class_init,<br=
>
+};<br>
+<br>
+static void allwinner_h3_ccu_register(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;allwinner_h3_ccu_info);<br>
+}<br>
+<br>
+type_init(allwinner_h3_ccu_register)<br>
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs<br>
index ba898a5781..4abd92dcee 100644<br>
--- a/hw/misc/Makefile.objs<br>
+++ b/hw/misc/Makefile.objs<br>
@@ -28,6 +28,7 @@ common-obj-$(CONFIG_MACIO) +=3D macio/<br>
<br>
=C2=A0common-obj-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem.o<br>
<br>
+common-obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-ccu.o<br>
=C2=A0common-obj-$(CONFIG_REALVIEW) +=3D arm_sysctl.o<br>
=C2=A0common-obj-$(CONFIG_NSERIES) +=3D cbus.o<br>
=C2=A0common-obj-$(CONFIG_ECCMEMCTL) +=3D eccmemctl.o<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000357a22059c0a5706--

