Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35284C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 06:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64112073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 06:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHBAhojr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64112073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtPgD-0003Dj-7k
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 02:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtPfN-0002Z0-El; Thu, 09 Jul 2020 02:04:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtPfL-0005xp-9P; Thu, 09 Jul 2020 02:04:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id 22so582929wmg.1;
 Wed, 08 Jul 2020 23:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t6tjk4y/j7cTHwvUNzZE5Q7IqL+U4IKUs2s12gG2aBM=;
 b=nHBAhojr8Ue+2mKXcwpjWZ1N87JXL3qDsbc+B97LV0B3rYfbaHOiaZMw5NEqPQyq5W
 XguTzDUvVgbENrYAAnaJWnG90asgAtBJ6iPiTmEv2Ecf2mErbAnFYLgVR2wUtMqyTLCY
 MezZ1wAyDkkJaVnedi8Ljifgky97MkVGWzm8Ykjl8b7Fs3qoxwlCgsXaPzulbEecAU4A
 xjJ6D+bjhCU95JLuosznOGWyK/+TW5njnOeWS7/DPrTbU6YHxxKla1FyD/cbJFXyn+jG
 WsnxHYg5tFjySKyuD5EApYqSxdIa8mnxyRsXBY8P26lQBSrrF4b7QU8maE1jhRZCG3PT
 F2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t6tjk4y/j7cTHwvUNzZE5Q7IqL+U4IKUs2s12gG2aBM=;
 b=MokQNTTZDmIXxEynKI0r+1suQCGeiPC0o8Mxk3oWD0M19OK4aCGbrEA6bGK8Tsxu9i
 385jN6HXQw4p8QEX2Q7aIR3nZ9uOV6sto8LXFdP8Hp6u0o1v+FU15jKf0J1YHvpOH0Rr
 3p/BekUNxEElUVgNYtRVTtay++qrClNsBC8ZJTl70DtweQzdvFSU2P9teF2B1z14efT7
 MvKrQqWH/r+4iuV/ZhekA/oVQT1oS+/o4G2I0PYwv9cgOg9rAhe0KewAqZvDOc1hpuP3
 42TGtoZH/LjEfP5Q/zO5v6jxX13vEKXyNpu+Rc7Y1jvakh8p4JJDauv208RFroT3tCaC
 rUmw==
X-Gm-Message-State: AOAM532RY0xk0pQCjK96CUynJZenui0b5s3QYvNK7nwGWRKQUZZKvQm7
 kG4en2SfvTPzR55SL+okO9Q=
X-Google-Smtp-Source: ABdhPJwiVL2W+BXF5SEP6kUvyyNUqzf+QcfS7DIKmjO4Ep7kku2vc0wHIdeiyED4TqujXqrjjeA+wA==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr12405541wmk.175.1594274652095; 
 Wed, 08 Jul 2020 23:04:12 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id l3sm3556688wrx.22.2020.07.08.23.04.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 23:04:11 -0700 (PDT)
Subject: Re: [PATCH v5 01/11] hw/misc: Add NPCM7xx System Global Control
 Registers device model
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-2-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2fe8ea5e-56de-f57f-6146-8355125daa7f@amsat.org>
Date: Thu, 9 Jul 2020 08:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709003608.3834629-2-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Avi.Fishman@nuvoton.com, qemu-devel@nongnu.org, kfting@nuvoton.com,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 2:35 AM, Havard Skinnemoen wrote:
> Implement a device model for the System Global Control Registers in the
> NPCM730 and NPCM750 BMC SoCs.
> 
> This is primarily used to enable SMP boot (the boot ROM spins reading
> the SCRPAD register) and DDR memory initialization; other registers are
> best effort for now.
> 
> The reset values of the MDLR and PWRON registers are determined by the
> SoC variant (730 vs 750) and board straps respectively.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  include/hw/misc/npcm7xx_gcr.h |  76 ++++++++++++
>  hw/misc/npcm7xx_gcr.c         | 226 ++++++++++++++++++++++++++++++++++
>  MAINTAINERS                   |   8 ++
>  hw/arm/Kconfig                |   3 +
>  hw/misc/Makefile.objs         |   1 +
>  hw/misc/trace-events          |   4 +
>  6 files changed, 318 insertions(+)
>  create mode 100644 include/hw/misc/npcm7xx_gcr.h
>  create mode 100644 hw/misc/npcm7xx_gcr.c
> 
> diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm7xx_gcr.h
> new file mode 100644
> index 0000000000..4884676be2
> --- /dev/null
> +++ b/include/hw/misc/npcm7xx_gcr.h
> @@ -0,0 +1,76 @@
> +/*
> + * Nuvoton NPCM7xx System Global Control Registers.
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +#ifndef NPCM7XX_GCR_H
> +#define NPCM7XX_GCR_H
> +
> +#include "exec/memory.h"
> +#include "hw/sysbus.h"
> +
> +enum NPCM7xxGCRRegisters {
> +    NPCM7XX_GCR_PDID,
> +    NPCM7XX_GCR_PWRON,
> +    NPCM7XX_GCR_MFSEL1          = 0x0c / sizeof(uint32_t),
> +    NPCM7XX_GCR_MFSEL2,
> +    NPCM7XX_GCR_MISCPE,
> +    NPCM7XX_GCR_SPSWC           = 0x038 / sizeof(uint32_t),
> +    NPCM7XX_GCR_INTCR,
> +    NPCM7XX_GCR_INTSR,
> +    NPCM7XX_GCR_HIFCR           = 0x050 / sizeof(uint32_t),
> +    NPCM7XX_GCR_INTCR2          = 0x060 / sizeof(uint32_t),
> +    NPCM7XX_GCR_MFSEL3,
> +    NPCM7XX_GCR_SRCNT,
> +    NPCM7XX_GCR_RESSR,
> +    NPCM7XX_GCR_RLOCKR1,
> +    NPCM7XX_GCR_FLOCKR1,
> +    NPCM7XX_GCR_DSCNT,
> +    NPCM7XX_GCR_MDLR,
> +    NPCM7XX_GCR_SCRPAD3,
> +    NPCM7XX_GCR_SCRPAD2,
> +    NPCM7XX_GCR_DAVCLVLR        = 0x098 / sizeof(uint32_t),
> +    NPCM7XX_GCR_INTCR3,
> +    NPCM7XX_GCR_VSINTR          = 0x0ac / sizeof(uint32_t),
> +    NPCM7XX_GCR_MFSEL4,
> +    NPCM7XX_GCR_CPBPNTR         = 0x0c4 / sizeof(uint32_t),
> +    NPCM7XX_GCR_CPCTL           = 0x0d0 / sizeof(uint32_t),
> +    NPCM7XX_GCR_CP2BST,
> +    NPCM7XX_GCR_B2CPNT,
> +    NPCM7XX_GCR_CPPCTL,
> +    NPCM7XX_GCR_I2CSEGSEL,
> +    NPCM7XX_GCR_I2CSEGCTL,
> +    NPCM7XX_GCR_VSRCR,
> +    NPCM7XX_GCR_MLOCKR,
> +    NPCM7XX_GCR_SCRPAD          = 0x013c / sizeof(uint32_t),
> +    NPCM7XX_GCR_USB1PHYCTL,
> +    NPCM7XX_GCR_USB2PHYCTL,
> +    NPCM7XX_GCR_NR_REGS,
> +};
> +
> +typedef struct NPCM7xxGCRState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion iomem;
> +
> +    uint32_t regs[NPCM7XX_GCR_NR_REGS];
> +
> +    uint32_t reset_pwron;
> +    uint32_t reset_mdlr;
> +    uint32_t reset_intcr3;
> +} NPCM7xxGCRState;
> +
> +#define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
> +#define NPCM7XX_GCR(obj) OBJECT_CHECK(NPCM7xxGCRState, (obj), TYPE_NPCM7XX_GCR)
> +
> +#endif /* NPCM7XX_GCR_H */
> diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
> new file mode 100644
> index 0000000000..9934cd238d
> --- /dev/null
> +++ b/hw/misc/npcm7xx_gcr.c
> @@ -0,0 +1,226 @@
> +/*
> + * Nuvoton NPCM7xx System Global Control Registers.
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/misc/npcm7xx_gcr.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +
> +#include "trace.h"
> +
> +static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] = {
> +    [NPCM7XX_GCR_PDID]          = 0x04a92750,   /* Poleg A1 */
> +    [NPCM7XX_GCR_MISCPE]        = 0x0000ffff,
> +    [NPCM7XX_GCR_SPSWC]         = 0x00000003,
> +    [NPCM7XX_GCR_INTCR]         = 0x0000035e,
> +    [NPCM7XX_GCR_HIFCR]         = 0x0000004e,
> +    [NPCM7XX_GCR_INTCR2]        = (1U << 19),   /* DDR initialized */
> +    [NPCM7XX_GCR_RESSR]         = 0x80000000,
> +    [NPCM7XX_GCR_DSCNT]         = 0x000000c0,
> +    [NPCM7XX_GCR_DAVCLVLR]      = 0x5a00f3cf,
> +    [NPCM7XX_GCR_SCRPAD]        = 0x00000008,
> +    [NPCM7XX_GCR_USB1PHYCTL]    = 0x034730e4,
> +    [NPCM7XX_GCR_USB2PHYCTL]    = 0x034730e4,
> +};
> +
> +static uint64_t npcm7xx_gcr_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint32_t reg = offset / sizeof(uint32_t);
> +    NPCM7xxGCRState *s = opaque;
> +
> +    if (reg >= NPCM7XX_GCR_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
> +                      __func__, (unsigned int)offset);

Maybe use HWADDR_PRIx instead of casting to int?

> +        return 0;
> +    }
> +
> +    trace_npcm7xx_gcr_read(offset, s->regs[reg]);
> +
> +    return s->regs[reg];
> +}
> +
> +static void npcm7xx_gcr_write(void *opaque, hwaddr offset,
> +                              uint64_t v, unsigned size)
> +{
> +    uint32_t reg = offset / sizeof(uint32_t);
> +    NPCM7xxGCRState *s = opaque;
> +    uint32_t value = v;
> +
> +    trace_npcm7xx_gcr_write(offset, value);
> +
> +    if (reg >= NPCM7XX_GCR_NR_REGS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: offset 0x%04x out of range\n",
> +                      __func__, (unsigned int)offset);
> +        return;
> +    }
> +
> +    switch (reg) {
> +    case NPCM7XX_GCR_PDID:
> +    case NPCM7XX_GCR_PWRON:
> +    case NPCM7XX_GCR_INTSR:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: register @ 0x%04x is read-only\n",
> +                      __func__, (unsigned int)offset);
> +        return;
> +
> +    case NPCM7XX_GCR_RESSR:
> +    case NPCM7XX_GCR_CP2BST:
> +        /* Write 1 to clear */
> +        value = s->regs[reg] & ~value;
> +        break;
> +
> +    case NPCM7XX_GCR_RLOCKR1:
> +    case NPCM7XX_GCR_MDLR:
> +        /* Write 1 to set */
> +        value |= s->regs[reg];
> +        break;
> +    };
> +
> +    s->regs[reg] = value;
> +}
> +
> +static const struct MemoryRegionOps npcm7xx_gcr_ops = {
> +    .read       = npcm7xx_gcr_read,
> +    .write      = npcm7xx_gcr_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid      = {
> +        .min_access_size        = 4,
> +        .max_access_size        = 4,
> +        .unaligned              = false,
> +    },
> +};
> +
> +static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)

2nd user of this new API, nice :)

> +{
> +    NPCM7xxGCRState *s = NPCM7XX_GCR(obj);
> +
> +    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> +
> +    switch (type) {
> +    case RESET_TYPE_COLD:
> +        memcpy(s->regs, cold_reset_values, sizeof(s->regs));
> +        s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
> +        s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
> +        s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
> +        break;
> +    }
> +}
> +
> +static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
> +{
> +    NPCM7xxGCRState *s = NPCM7XX_GCR(dev);
> +    uint64_t dram_size;
> +    Error *err = NULL;
> +    Object *obj;
> +
> +    obj = object_property_get_link(OBJECT(dev), "dram-mr", &err);
> +    if (!obj) {
> +        error_setg(errp, "%s: required dram-mr link not found: %s",
> +                   __func__, error_get_pretty(err));
> +        return;
> +    }
> +    dram_size = memory_region_size(MEMORY_REGION(obj));
> +
> +    /* Power-on reset value */
> +    s->reset_intcr3 = 0x00001002;
> +
> +    /*
> +     * The GMMAP (Graphics Memory Map) field is used by u-boot to detect the
> +     * DRAM size, and is normally initialized by the boot block as part of DRAM
> +     * training. However, since we don't have a complete emulation of the
> +     * memory controller and try to make it look like it has already been
> +     * initialized, the boot block will skip this initialization, and we need
> +     * to make sure this field is set correctly up front.
> +     *
> +     * WARNING: some versions of u-boot only looks at bits 8 and 9, so 2 GiB or
> +     * more of DRAM will be interpreted as 128 MiB.

I'd say u-boot is right in wrapping at 2GB, as more DRAM is
un-addressable.

> +     *
> +     * https://github.com/Nuvoton-Israel/u-boot/blob/2aef993bd2aafeb5408dbaad0f3ce099ee40c4aa/board/nuvoton/poleg/poleg.c#L244
> +     */
> +    if (dram_size >= 2 * GiB) {

See my comment in this series on the machine patch.

> +        s->reset_intcr3 |= 4 << 8;
> +    } else if (dram_size >= 1 * GiB) {
> +        s->reset_intcr3 |= 3 << 8;
> +    } else if (dram_size >= 512 * MiB) {
> +        s->reset_intcr3 |= 2 << 8;
> +    } else if (dram_size >= 256 * MiB) {
> +        s->reset_intcr3 |= 1 << 8;
> +    } else if (dram_size >= 128 * MiB) {
> +        s->reset_intcr3 |= 0 << 8;
> +    } else {
> +        error_setg(errp,
> +                   "npcm7xx_gcr: DRAM size %" PRIu64
> +                   " is too small (need 128 MiB minimum)",
> +                   dram_size);

Ah, so you could add the same error for >2GB. Easier.

Preferably using HWADDR_PRIx, and similar error for >2GB:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        return;
> +    }
> +}
> +
> +static void npcm7xx_gcr_init(Object *obj)
> +{
> +    NPCM7xxGCRState *s = NPCM7XX_GCR(obj);
> +
> +    memory_region_init_io(&s->iomem, obj, &npcm7xx_gcr_ops, s,
> +                          TYPE_NPCM7XX_GCR, 4 * KiB);
> +    sysbus_init_mmio(&s->parent, &s->iomem);
> +}
> +
> +static const VMStateDescription vmstate_npcm7xx_gcr = {
> +    .name = "npcm7xx-gcr",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, NPCM7xxGCRState, NPCM7XX_GCR_NR_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static Property npcm7xx_gcr_properties[] = {
> +    DEFINE_PROP_UINT32("disabled-modules", NPCM7xxGCRState, reset_mdlr, 0),
> +    DEFINE_PROP_UINT32("power-on-straps", NPCM7xxGCRState, reset_pwron, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "NPCM7xx System Global Control Registers";
> +    dc->realize = npcm7xx_gcr_realize;
> +    dc->vmsd = &vmstate_npcm7xx_gcr;
> +    rc->phases.enter = npcm7xx_gcr_enter_reset;
> +
> +    device_class_set_props(dc, npcm7xx_gcr_properties);
> +}
> +
> +static const TypeInfo npcm7xx_gcr_info = {
> +    .name               = TYPE_NPCM7XX_GCR,
> +    .parent             = TYPE_SYS_BUS_DEVICE,
> +    .instance_size      = sizeof(NPCM7xxGCRState),
> +    .instance_init      = npcm7xx_gcr_init,
> +    .class_init         = npcm7xx_gcr_class_init,
> +};
> +
> +static void npcm7xx_gcr_register_type(void)
> +{
> +    type_register_static(&npcm7xx_gcr_info);
> +}
> +type_init(npcm7xx_gcr_register_type);
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42388f1de2..43173a338a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -723,6 +723,14 @@ S: Odd Fixes
>  F: hw/arm/musicpal.c
>  F: docs/system/arm/musicpal.rst
>  
> +Nuvoton NPCM7xx
> +M: Havard Skinnemoen <hskinnemoen@google.com>
> +M: Tyrone Ting <kfting@nuvoton.com>
> +L: qemu-arm@nongnu.org
> +S: Supported
> +F: hw/*/npcm7xx*
> +F: include/hw/*/npcm7xx*
> +
>  nSeries
>  M: Andrzej Zaborowski <balrogg@gmail.com>
>  M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4a224a6351..192a8dec3b 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -354,6 +354,9 @@ config XLNX_VERSAL
>      select VIRTIO_MMIO
>      select UNIMP
>  
> +config NPCM7XX
> +    bool
> +
>  config FSL_IMX25
>      bool
>      select IMX
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 5aaca8a039..40a9d1c01e 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -51,6 +51,7 @@ common-obj-$(CONFIG_IMX) += imx_rngc.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
>  common-obj-$(CONFIG_MAINSTONE) += mst_fpga.o
> +common-obj-$(CONFIG_NPCM7XX) += npcm7xx_gcr.o
>  common-obj-$(CONFIG_OMAP) += omap_clk.o
>  common-obj-$(CONFIG_OMAP) += omap_gpmc.o
>  common-obj-$(CONFIG_OMAP) += omap_l4.o
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index ebea53735c..48e2d54c49 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -107,6 +107,10 @@ mos6522_set_sr_int(void) "set sr_int"
>  mos6522_write(uint64_t addr, uint64_t val) "reg=0x%"PRIx64 " val=0x%"PRIx64
>  mos6522_read(uint64_t addr, unsigned val) "reg=0x%"PRIx64 " val=0x%x"
>  
> +# npcm7xx_gcr.c
> +npcm7xx_gcr_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
> +npcm7xx_gcr_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
> +
>  # stm32f4xx_syscfg
>  stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %d, Line: %d; Level: %d"
>  stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
> 

