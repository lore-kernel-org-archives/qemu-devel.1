Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA00C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 05:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B383212F5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 05:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcI46Zdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B383212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZTzI-0007YE-C0
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 01:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hZTyS-000770-Lm
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 01:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hZTyN-0001BG-Pn
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 01:33:04 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44647)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hZTyN-00019S-3Q
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 01:32:59 -0400
Received: by mail-ot1-x344.google.com with SMTP id b7so3800238otl.11
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 22:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=E3iGkl34Sw8spIlK3owQUxMfryR/MzFTNeK4bbhy2IE=;
 b=tcI46ZdmKQn6A+Oq+qPWKxzNYcsrYkIlwN/wZutOJAYIIDXgLpu4aAvgft3mrWD2WM
 8Bjp1n2F5E3VckLRtvn+1qKCXhHnaGz/NEl6WJ+UvDiKl9QSb0Ico0cQWIqWps6ZX0PW
 e1PNHXbWGXoagPoOlLQ4jD8qLEBH7mIx65MwDXMaiGAF9lYFCHtHQjCZdM639D3bkHJo
 Am1ymWqGz/outpHRscKLWXgF6OHF+9ICziRvl+K1u7hRTxrRISfE93TptD46am+tKRZy
 4pKIV5A5AqwkdEscxtu9VqsBI/UFJASN1TA9nwGDMwgehOjWNw3o0WL8CGwc/FI8V4Y8
 c/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=E3iGkl34Sw8spIlK3owQUxMfryR/MzFTNeK4bbhy2IE=;
 b=VjXKb/M6OdW5umtZ+5Is+1sQ1cLWDRJ9z08BXNYJbi+th91PygRqoee25GyWQIxgol
 Eulu7FOGNfEiCptISk7q59HQceQBLUR845//9gdlpftjWoQRQ64gkwgVxqoiujbbmbyK
 R0tyG64mlJOznD1EWnfjlgtudsj9EBejs5cRzNEEBdAk+V4H9vJe/h4FYNFYY8BnXveg
 T2KP9EhDGkAZflpM7XUd5/4n6eavjfhPlrZ5kly7Jpsrbr2/1Rpit1+dEVbbRF2P9y/s
 8nWkgtLCsxRbmTM4AEUClIJAR4peu6+JkAj3YlAXignBf3KD3ML2CYkhCD1UeQsyCAHt
 7WAQ==
X-Gm-Message-State: APjAAAXQaElqMCcxiFz1x0WPzihxm987XEvEWR6iY/isKcXqE4hA5IpP
 xr0hq5q9EXTMu4L3bnS9oSnbidjFDOBwaAbzlQI=
X-Google-Smtp-Source: APXvYqwbnq7iDMaZhbGaqu7pAjF7e84izasJoS+uPTKcDm5dY92VYQfH3J38K8hOAJ1eMjTBQmvFRHwfYaKVlwLphRs=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr7741232otl.341.1559971977347; 
 Fri, 07 Jun 2019 22:32:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
 Fri, 7 Jun 2019 22:32:56 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
 Fri, 7 Jun 2019 22:32:56 -0700 (PDT)
In-Reply-To: <1559828732-23081-2-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1559828732-23081-1-git-send-email-mateja.marjanovic@rt-rk.com>
 <1559828732-23081-2-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 8 Jun 2019 07:32:56 +0200
Message-ID: <CAL1e-=jzqMODPivxcAqrVYDDMVtwMcQQQkbpi-F_EQ61fcntLA@mail.gmail.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, philmd@redhat.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] target/mips: Add implementation of DSPRAM
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
Cc: arikalo@wavecomp.com, aurelien@aurel32.net, amarkovic@wavecomp.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 6, 2019 3:49 PM, "Mateja Marjanovic" <mateja.marjanovic@rt-rk.com>
wrote:
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Add support for DSPRAM (Data Scratch Pad RAM). It still needs
> some minor fixing, but the structure is right.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Please consider splitting the patch into several logical units.

Adding Philippe.

Thanks,
Aleksandar

>  default-configs/mips-softmmu-common.mak |   1 +
>  hw/mips/cps.c                           |  28 +++++-
>  hw/misc/Makefile.objs                   |   1 +
>  hw/misc/mips_dspram.c                   | 153
++++++++++++++++++++++++++++++++
>  include/hw/mips/cps.h                   |   2 +
>  include/hw/misc/mips_dspram.h           |  46 ++++++++++
>  target/mips/cpu.h                       |   9 +-
>  target/mips/internal.h                  |   3 +-
>  target/mips/op_helper.c                 |  14 +++
>  target/mips/translate.c                 |   8 ++
>  target/mips/translate_init.inc.c        |   2 +
>  11 files changed, 262 insertions(+), 5 deletions(-)
>  create mode 100644 hw/misc/mips_dspram.c
>  create mode 100644 include/hw/misc/mips_dspram.h
>
> diff --git a/default-configs/mips-softmmu-common.mak
b/default-configs/mips-softmmu-common.mak
> index ded7498..d3f85b0 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -35,6 +35,7 @@ CONFIG_ISA_TESTDEV=y
>  CONFIG_EMPTY_SLOT=y
>  CONFIG_MIPS_CPS=y
>  CONFIG_MIPS_ITU=y
> +CONFIG_MIPS_DSPRAM=y
>  CONFIG_I2C=y
>  CONFIG_R4K=y
>  CONFIG_MALTA=y
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index fc97f59..0205556 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -90,7 +90,8 @@ static void mips_cps_realize(DeviceState *dev, Error
**errp)
>
>      cpu = MIPS_CPU(first_cpu);
>      env = &cpu->env;
> -    saar_present = (bool)env->saarp;
> +    saar_present = env->saarp;
> +    bool dspram_present = env->dspramp;
>
>      /* Inter-Thread Communication Unit */
>      if (itu_present) {
> @@ -102,7 +103,8 @@ static void mips_cps_realize(DeviceState *dev, Error
**errp)
>          object_property_set_bool(OBJECT(&s->itu), saar_present,
"saar-present",
>                                   &err);
>          if (saar_present) {
> -            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void
*)&env->CP0_SAAR);
> +            qdev_prop_set_ptr(DEVICE(&s->itu), "saar",
> +                              (void *) &env->CP0_SAAR[0]);
>          }
>          object_property_set_bool(OBJECT(&s->itu), true, "realized",
&err);
>          if (err != NULL) {
> @@ -113,6 +115,28 @@ static void mips_cps_realize(DeviceState *dev, Error
**errp)
>          memory_region_add_subregion(&s->container, 0,
>
sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->itu), 0));
>      }
> +    env->dspram = g_new0(MIPSDSPRAMState, 1);
> +
> +    /* Data Scratch Pad RAM */
> +    if (dspram_present) {
> +        if (!saar_present) {
> +            error_report("%s: DSPRAM requires SAAR registers", __func__);
> +            return;
> +        }
> +        object_initialize(&s->dspram, sizeof(MIPSDSPRAMState),
> +                          TYPE_MIPS_DSPRAM);
> +        qdev_set_parent_bus(DEVICE(&s->dspram), sysbus_get_default());
> +        qdev_prop_set_ptr(DEVICE(&s->dspram), "saar",
> +                          &env->CP0_SAAR[1]);
> +        object_property_set_bool(OBJECT(&s->dspram), true, "realized",
&err);
> +        if (err != NULL) {
> +            error_report("%s: DSPRAM initialisation failed", __func__);
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        memory_region_add_subregion(&s->container, 0,
> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dspram),
0));
> +    }
>
>      /* Cluster Power Controller */
>      object_initialize(&s->cpc, sizeof(s->cpc), TYPE_MIPS_CPC);
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 74c91d2..37c4108 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -60,6 +60,7 @@ obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
>  obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
>  obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
>  obj-$(CONFIG_MIPS_ITU) += mips_itu.o
> +obj-$(CONFIG_MIPS_DSPRAM) += mips_dspram.o
>  obj-$(CONFIG_MPS2_FPGAIO) += mps2-fpgaio.o
>  obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
>
> diff --git a/hw/misc/mips_dspram.c b/hw/misc/mips_dspram.c
> new file mode 100644
> index 0000000..9bc155b
> --- /dev/null
> +++ b/hw/misc/mips_dspram.c
> @@ -0,0 +1,153 @@
> +/*
> + * Data Scratch Pad RAM
> + *
> + * Copyright (c) 2017 Imagination Technologies
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <
http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "qemu/log.h"
> +#include "exec/exec-all.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/misc/mips_dspram.h"
> +
> +static void raise_exception(int excp)
> +{
> +    current_cpu->exception_index = excp;
> +    cpu_loop_exit(current_cpu);
> +}
> +
> +static uint64_t dspram_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    MIPSDSPRAMState *s = (MIPSDSPRAMState *)opaque;
> +
> +    switch (size) {
> +    case 1:
> +    case 2:
> +        raise_exception(EXCP_AdEL);
> +        return 0;
> +    case 4:
> +        return *(uint32_t *) &s->ramblock[addr % (1 << s->size)];
> +    case 8:
> +        return *(uint64_t *) &s->ramblock[addr % (1 << s->size)];
> +    }
> +    return 0;
> +}
> +
> +static void dspram_write(void *opaque, hwaddr addr, uint64_t data,
> +                         unsigned size)
> +{
> +    MIPSDSPRAMState *s = (MIPSDSPRAMState *)opaque;
> +
> +    switch (size) {
> +    case 1:
> +    case 2:
> +        raise_exception(EXCP_AdES);
> +        return;
> +    case 4:
> +        *(uint32_t *) &s->ramblock[addr % (1 << s->size)] = (uint32_t)
data;
> +        break;
> +    case 8:
> +        *(uint64_t *) &s->ramblock[addr % (1 << s->size)] = data;
> +        break;
> +    }
> +}
> +
> +void dspram_reconfigure(struct MIPSDSPRAMState *dspram)
> +{
> +    MemoryRegion *mr = &dspram->mr;
> +    hwaddr address;
> +    bool is_enabled;
> +
> +    address = ((*(uint64_t *) dspram->saar) & 0xFFFFFFFE000ULL) << 4;
> +    is_enabled = *(uint64_t *) dspram->saar & 1;
> +
> +    memory_region_transaction_begin();
> +    memory_region_set_size(mr, (1 << dspram->size));
> +    memory_region_set_address(mr, address);
> +    memory_region_set_enabled(mr, is_enabled);
> +    memory_region_transaction_commit();
> +}
> +
> +static const MemoryRegionOps dspram_ops = {
> +    .read = dspram_read,
> +    .write = dspram_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .unaligned = false,
> +    }
> +};
> +
> +static void mips_dspram_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    MIPSDSPRAMState *s = MIPS_DSPRAM(obj);
> +
> +    memory_region_init_io(&s->mr, OBJECT(s), &dspram_ops, s,
> +                          "mips-dspram", (1 << s->size));
> +    sysbus_init_mmio(sbd, &s->mr);
> +}
> +
> +static void mips_dspram_realize(DeviceState *dev, Error **errp)
> +{
> +    MIPSDSPRAMState *s = MIPS_DSPRAM(dev);
> +
> +    /* some error handling here */
> +
> +    s->ramblock = g_malloc0(1 << s->size);
> +}
> +
> +static void mips_dspram_reset(DeviceState *dev)
> +{
> +    MIPSDSPRAMState *s = MIPS_DSPRAM(dev);
> +
> +    *(uint64_t *) s->saar = s->size << 1;
> +    memset(s->ramblock, 0, (1 << s->size));
> +}
> +
> +static Property mips_dspram_properties[] = {
> +    DEFINE_PROP_PTR("saar", MIPSDSPRAMState, saar),
> +    /* default DSPRAM size is 64 KB */
> +    DEFINE_PROP_SIZE("size", MIPSDSPRAMState, size, 0x10),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void mips_dspram_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->props = mips_dspram_properties;
> +    dc->realize = mips_dspram_realize;
> +    dc->reset = mips_dspram_reset;
> +}
> +
> +static const TypeInfo mips_dspram_info = {
> +    .name          = TYPE_MIPS_DSPRAM,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(MIPSDSPRAMState),
> +    .instance_init = mips_dspram_init,
> +    .class_init    = mips_dspram_class_init,
> +};
> +
> +static void mips_dspram_register_types(void)
> +{
> +    type_register_static(&mips_dspram_info);
> +}
> +
> +type_init(mips_dspram_register_types);
> diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
> index aab1af9..a637036 100644
> --- a/include/hw/mips/cps.h
> +++ b/include/hw/mips/cps.h
> @@ -25,6 +25,7 @@
>  #include "hw/intc/mips_gic.h"
>  #include "hw/misc/mips_cpc.h"
>  #include "hw/misc/mips_itu.h"
> +#include "hw/misc/mips_dspram.h"
>
>  #define TYPE_MIPS_CPS "mips-cps"
>  #define MIPS_CPS(obj) OBJECT_CHECK(MIPSCPSState, (obj), TYPE_MIPS_CPS)
> @@ -41,6 +42,7 @@ typedef struct MIPSCPSState {
>      MIPSGICState gic;
>      MIPSCPCState cpc;
>      MIPSITUState itu;
> +    MIPSDSPRAMState dspram;
>  } MIPSCPSState;
>
>  qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
> diff --git a/include/hw/misc/mips_dspram.h b/include/hw/misc/mips_dspram.h
> new file mode 100644
> index 0000000..ee99e17
> --- /dev/null
> +++ b/include/hw/misc/mips_dspram.h
> @@ -0,0 +1,46 @@
> +/*
> + * Data Scratch Pad RAM
> + *
> + * Copyright (c) 2017 Imagination Technologies
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <
http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef MIPS_DSPRAM_H
> +#define MIPS_DSPRAM_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_MIPS_DSPRAM "mips-dspram"
> +#define MIPS_DSPRAM(obj) OBJECT_CHECK(MIPSDSPRAMState, (obj),
TYPE_MIPS_DSPRAM)
> +
> +typedef struct MIPSDSPRAMState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    /* 2 ^ SIZE */
> +    uint64_t size;
> +
> +    MemoryRegion mr;
> +
> +    /* SAAR */
> +    bool saar_present;
> +    void *saar;
> +
> +    /* ramblock */
> +    uint8_t *ramblock;
> +} MIPSDSPRAMState;
> +
> +#endif /* MIPS_DSPRAM_H */
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index a10eeb0..8b15e6c 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -445,6 +445,7 @@ struct TCState {
>
>  };
>
> +struct MIPSDSPRAMState;
>  struct MIPSITUState;
>  typedef struct CPUMIPSState CPUMIPSState;
>  struct CPUMIPSState {
> @@ -1021,8 +1022,8 @@ struct CPUMIPSState {
>      uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
>      uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus
*/
>      uint64_t insn_flags; /* Supported instruction set */
> -    int saarp;
> -
> +    bool saarp;
> +    bool dspramp;
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>
> @@ -1039,6 +1040,7 @@ struct CPUMIPSState {
>      QEMUTimer *timer; /* Internal timer */
>      struct MIPSITUState *itu;
>      MemoryRegion *itc_tag; /* ITC Configuration Tags */
> +    struct MIPSDSPRAMState *dspram;
>      target_ulong exception_base; /* ExceptionBase input to the core */
>  };
>
> @@ -1181,6 +1183,9 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq,
int level);
>  /* mips_itu.c */
>  void itc_reconfigure(struct MIPSITUState *tag);
>
> +/* mips_dspram.c */
> +void dspram_reconfigure(struct MIPSDSPRAMState *dspram);
> +
>  /* helper.c */
>  target_ulong exception_resume_pc (CPUMIPSState *env);
>
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 8f6fc91..650bddd 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -61,7 +61,8 @@ struct mips_def_t {
>      target_ulong CP0_EBaseWG_rw_bitmask;
>      uint64_t insn_flags;
>      enum mips_mmu_types mmu_type;
> -    int32_t SAARP;
> +    bool SAARP;
> +    bool DSPRAMP;
>  };
>
>  extern const struct mips_def_t mips_defs[];
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index c921032..5136e33 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1614,7 +1614,14 @@ void helper_mtc0_saar(CPUMIPSState *env,
target_ulong arg1)
>                  itc_reconfigure(env->itu);
>              }
>              break;
> +        case 1:
> +            if (env->dspram) {
> +                dspram_reconfigure(env->dspram);
> +            }
> +            break;
>          }
> +    } else {
> +        helper_raise_exception(env, EXCP_RI);
>      }
>  }
>
> @@ -1631,7 +1638,14 @@ void helper_mthc0_saar(CPUMIPSState *env,
target_ulong arg1)
>                  itc_reconfigure(env->itu);
>              }
>              break;
> +        case 1:
> +            if (env->dspram) {
> +                dspram_reconfigure(env->dspram);
> +            }
> +            break;
>          }
> +    } else {
> +        helper_raise_exception(env, EXCP_RI);
>      }
>  }
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index c79fa1e..40584e9 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -31383,6 +31383,8 @@ void cpu_state_reset(CPUMIPSState *env)
>      env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
>      env->msair = env->cpu_model->MSAIR;
>      env->insn_flags = env->cpu_model->insn_flags;
> +    env->saarp = env->cpu_model->SAARP;
> +    env->dspramp = env->cpu_model->DSPRAMP;
>
>  #if defined(CONFIG_USER_ONLY)
>      env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
> @@ -31537,6 +31539,12 @@ void cpu_state_reset(CPUMIPSState *env)
>          msa_reset(env);
>      }
>
> +    /* DSPRAM */
> +    if (env->dspramp) {
> +        /* Fixed DSPRAM size with Default Value */
> +        env->CP0_SAAR[1] = 0x10 << 1;
> +    }
> +
>      compute_hflags(env);
>      restore_fp_status(env);
>      restore_pamask(env);
> diff --git a/target/mips/translate_init.inc.c
b/target/mips/translate_init.inc.c
> index bf559af..4c49a0e 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -760,6 +760,8 @@ const mips_def_t mips_defs[] =
>          .PABITS = 48,
>          .insn_flags = CPU_MIPS64R6 | ASE_MSA,
>          .mmu_type = MMU_TYPE_R4000,
> +        .SAARP = 1,
> +        .DSPRAMP = 1,
>      },
>      {
>          .name = "Loongson-2E",
> --
> 2.7.4
>
>
