Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E98DC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BB82166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BB82166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3IbY-00074S-68
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 07:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Iat-0006fm-Ng
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Iaq-0008As-9R
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:27:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Iap-00088h-Oi
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:27:56 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DF318667D
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:27:54 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id z2so1949202wrt.6
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 04:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vptpM4PQtNXOLh4AMOr/xMHeUEO60NvHmjv9Up/Vq/g=;
 b=S7VfbO3tewfpFUGG1UQdV7oZf0JVXf2lhs4vD0zNGnflg9sWtmMSk+CKgjLWL3/jri
 jOjCL5XggxneJXRPlikM+/BaeUiGrMfc+pO9N1NwnKAPaukAMUVmccVojxxFA1d6Nnl7
 2D6DQUVVw79vPBmve+qkQEnt/5YZLnjb39Vbd9bGJwKVuQeKjGnYP7ebTAqS7ugOUsKJ
 e+9Teiu9fDamB+Z1xJ9id7euVYtW0SBL7cXSvhCb5sNJGAw79HtO+2JGKAiRdds2UzVZ
 nEdFGYwimA4XfCU6qJ59cBEGlyyKkTI0PDD/UrCifQmxMNDXbnMtnFYFvtL869WaUGEr
 BcqQ==
X-Gm-Message-State: APjAAAWGcinavbGTuqs0Lzcwc6JAD92aHgOnA4uwZFzVKy+daeE339F4
 1S9ZE4zgn0zLUSHx4FLWIk7EcS/sjBp5hXzl1rUsk/gRQsi2ql0PYwv3MWL7VN8JjX5LxjwF+zJ
 bhJKw/yeJGi/PV6U=
X-Received: by 2002:a05:6000:10cf:: with SMTP id
 b15mr10814331wrx.180.1567078072361; 
 Thu, 29 Aug 2019 04:27:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwOj64Y+IQLWuX1XkdDqCwHFxbWFkEUrGW1KBGPU5Xd09MLzEPogCNXwgGZmEW1j2NCuQgNBg==
X-Received: by 2002:a05:6000:10cf:: with SMTP id
 b15mr10814301wrx.180.1567078072070; 
 Thu, 29 Aug 2019 04:27:52 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id f18sm2209603wrx.85.2019.08.29.04.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 04:27:51 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1566216496-17375-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1212651d-35ad-7c37-abf9-c5b2906be051@redhat.com>
Date: Thu, 29 Aug 2019 13:27:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1566216496-17375-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 01/37] target/mips: Add support for
 DSPRAM
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
Cc: arikalo@wavecomp.com, Yongbok Kim <yongbok.kim@mips.com>,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 8/19/19 2:07 PM, Aleksandar Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> The optional Data Scratch Pad RAM (DSPRAM) block provides a general scratch pad RAM
> used for temporary storage of data. The DSPRAM provides a connection to on-chip
> memory or memory-mapped registers, which are accessed in parallel with the L1 data
> cache to minimize access latency

Can you point me to a vm/kernel image using this feature?

> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  hw/mips/cps.c                    |  29 +++++++-
>  hw/misc/Makefile.objs            |   1 +
>  hw/misc/mips_dspram.c            | 153 +++++++++++++++++++++++++++++++++++++++
>  include/hw/mips/cps.h            |   2 +
>  include/hw/misc/mips_dspram.h    |  46 ++++++++++++
>  target/mips/cpu.h                |   9 ++-
>  target/mips/internal.h           |   3 +-

I suggest you to install scripts/git.orderfile, having files ordered
eases reviews.

>  target/mips/op_helper.c          |  18 +++++
>  target/mips/translate.c          |   8 ++
>  target/mips/translate_init.inc.c |   2 +
>  10 files changed, 266 insertions(+), 5 deletions(-)
>  create mode 100644 hw/misc/mips_dspram.c
>  create mode 100644 include/hw/misc/mips_dspram.h
> 
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 0d459c4..c84bc64 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "hw/mips/cps.h"
> @@ -91,7 +92,8 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>  
>      cpu = MIPS_CPU(first_cpu);
>      env = &cpu->env;
> -    saar_present = (bool)env->saarp;
> +    saar_present = env->saarp;
> +    bool dspram_present = env->dspramp;
>  
>      /* Inter-Thread Communication Unit */
>      if (itu_present) {
> @@ -102,7 +104,8 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>          object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
>                                   &err);
>          if (saar_present) {
> -            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->CP0_SAAR);
> +            qdev_prop_set_ptr(DEVICE(&s->itu), "saar",
> +                              (void *) &env->CP0_SAAR[0]);
>          }
>          object_property_set_bool(OBJECT(&s->itu), true, "realized", &err);
>          if (err != NULL) {
> @@ -113,6 +116,28 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>          memory_region_add_subregion(&s->container, 0,
>                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->itu), 0));
>      }
> +    env->dspram = g_new0(MIPSDSPRAMState, 1);

Why not allocated this only if dspram_present?

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
> +        object_property_set_bool(OBJECT(&s->dspram), true, "realized", &err);
> +        if (err != NULL) {
> +            error_report("%s: DSPRAM initialisation failed", __func__);
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        memory_region_add_subregion(&s->container, 0,
> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dspram), 0));
> +    }
>  
>      /* Cluster Power Controller */
>      sysbus_init_child_obj(OBJECT(dev), "cpc", &s->cpc, sizeof(s->cpc),
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index e9aab51..5fcb4db 100644
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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
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

This one might be worth a static inline in target/mips/cpu.h.

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

Hmm is this endian safe?

Consider this case: migrating a VM from a LE to BE host, but maybe
we don't care.

> +    case 8:
> +        return *(uint64_t *) &s->ramblock[addr % (1 << s->size)];

I am a bit confused here. This scratch ram holds instructions of
target_ulong size or any size?

    if (size != TARGET_LONG_SIZE) {
       raise_exception(EXCP_AdEL);
       return 0;
    }

    return *(target_ulong *) &s->ramblock[addr % (1 << s->size)];

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

Ditto, target_ulong?

> +    case 1:
> +    case 2:
> +        raise_exception(EXCP_AdES);
> +        return;
> +    case 4:
> +        *(uint32_t *) &s->ramblock[addr % (1 << s->size)] = (uint32_t) data;

Ditto, endian safe?

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

or     addr = extract64(value, 13, 31) << 4;

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

If restricted to target_ulong, what about:

           .min_access_size = TARGET_LONG_SIZE,
           .max_access_size = TARGET_LONG_SIZE,

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

Yes, we should check s->size is pow2.

> +
> +    s->ramblock = g_malloc0(1 << s->size);

Nit, I'd use

       s->blocksize = 1 << s->size;

Then replace all '1 << s->size' by it.

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

'size' is misleading, any better suggestion?

The description in mips_dspram.h is also inacurate:

    /* 2 ^ SIZE */
    uint64_t size;

Isn't it the instructions count?

Thanks,

Phil.

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
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef MIPS_DSPRAM_H
> +#define MIPS_DSPRAM_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_MIPS_DSPRAM "mips-dspram"
> +#define MIPS_DSPRAM(obj) OBJECT_CHECK(MIPSDSPRAMState, (obj), TYPE_MIPS_DSPRAM)
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
> index 21c0615..90a2ed8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -453,6 +453,7 @@ struct TCState {
>  
>  };
>  
> +struct MIPSDSPRAMState;
>  struct MIPSITUState;
>  typedef struct CPUMIPSState CPUMIPSState;
>  struct CPUMIPSState {
> @@ -1035,8 +1036,8 @@ struct CPUMIPSState {
>      uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
>      uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus */
>      uint64_t insn_flags; /* Supported instruction set */
> -    int saarp;
> -
> +    bool saarp;
> +    bool dspramp;
>      /* Fields up to this point are cleared by a CPU reset */
>      struct {} end_reset_fields;
>  
> @@ -1051,6 +1052,7 @@ struct CPUMIPSState {
>      QEMUTimer *timer; /* Internal timer */
>      struct MIPSITUState *itu;
>      MemoryRegion *itc_tag; /* ITC Configuration Tags */
> +    struct MIPSDSPRAMState *dspram;
>      target_ulong exception_base; /* ExceptionBase input to the core */
>  };
>  
> @@ -1192,6 +1194,9 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq, int level);
>  /* mips_itu.c */
>  void itc_reconfigure(struct MIPSITUState *tag);
>  
> +/* mips_dspram.c */
> +void dspram_reconfigure(struct MIPSDSPRAMState *dspram);
> +
>  /* helper.c */
>  target_ulong exception_resume_pc(CPUMIPSState *env);
>  
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index b2b41a5..f6d0d7a 100644
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
> index 9e2e02f..628da45 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1614,7 +1614,16 @@ void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
>                  itc_reconfigure(env->itu);
>              }
>              break;
> +#if defined(CONFIG_MIPS_DSPRAM)
> +        case 1:
> +            if (env->dspram) {
> +                dspram_reconfigure(env->dspram);
> +            }
> +            break;
> +#endif
>          }
> +    } else {
> +        helper_raise_exception(env, EXCP_RI);
>      }
>  }
>  
> @@ -1631,7 +1640,16 @@ void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
>                  itc_reconfigure(env->itu);
>              }
>              break;
> +#if defined(CONFIG_MIPS_DSPRAM)
> +        case 1:
> +            if (env->dspram) {
> +                dspram_reconfigure(env->dspram);
> +            }
> +            break;
> +#endif
>          }
> +    } else {
> +        helper_raise_exception(env, EXCP_RI);
>      }
>  }
>  
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ca62800..4ebeabe 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -30368,6 +30368,8 @@ void cpu_state_reset(CPUMIPSState *env)
>      env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
>      env->msair = env->cpu_model->MSAIR;
>      env->insn_flags = env->cpu_model->insn_flags;
> +    env->saarp = env->cpu_model->SAARP;
> +    env->dspramp = env->cpu_model->DSPRAMP;
>  
>  #if defined(CONFIG_USER_ONLY)
>      env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
> @@ -30528,6 +30530,12 @@ void cpu_state_reset(CPUMIPSState *env)
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
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
> index 6d145a9..1df0901 100644
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
> 

