Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E0AC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BE121473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 12:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BE121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50872 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hblF4-00030L-FH
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 08:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hbl2e-00037B-Kk
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hbl2c-0004BP-JB
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:10:48 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:54208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hbl2c-00049f-Cq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 08:10:46 -0400
Received: from player792.ha.ovh.net (unknown [10.108.57.23])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id A4AA55E40F
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 14:10:43 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id CB0556ECA2DC;
 Fri, 14 Jun 2019 12:10:36 +0000 (UTC)
To: Eddie James <eajames@linux.ibm.com>, qemu-arm@nongnu.org
References: <1560286476-23494-1-git-send-email-eajames@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dee5afb8-cc31-8963-6a7c-169c77e23d3c@kaod.org>
Date: Fri, 14 Jun 2019 14:10:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560286476-23494-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10287065977570954001
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiuddggeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.73.241
Subject: Re: [Qemu-devel] [PATCH v2] hw: misc: Add Aspeed XDMA device
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/06/2019 22:54, Eddie James wrote:
> The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operations
> between the SOC (acting as a BMC) and a host processor in a server.
> 
> The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
> enable it for all of those. Add trace events on the important register
> writes in the XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - add trace events
>  - minor cleanup
> 
> This patch is based on Cedric's big Aspeed update:
>     http://patchwork.ozlabs.org/cover/1105343/

Eddie, 

I have pushed the patch in my tree and I plan to resend 
as part of the patchset above.

Thanks,

C. 

>  hw/arm/aspeed_soc.c           |  19 +++++
>  hw/misc/Makefile.objs         |   1 +
>  hw/misc/aspeed_xdma.c         | 165 ++++++++++++++++++++++++++++++++++++++++++
>  hw/misc/trace-events          |   3 +
>  include/hw/arm/aspeed_soc.h   |   3 +
>  include/hw/misc/aspeed_xdma.h |  30 ++++++++
>  6 files changed, 221 insertions(+)
>  create mode 100644 hw/misc/aspeed_xdma.c
>  create mode 100644 include/hw/misc/aspeed_xdma.h
> 
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 0a0ab87..6901697 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
>      [ASPEED_VIC]    = 0x1E6C0000,
>      [ASPEED_SDMC]   = 0x1E6E0000,
>      [ASPEED_SCU]    = 0x1E6E2000,
> +    [ASPEED_XDMA]   = 0x1E6E7000,
>      [ASPEED_ADC]    = 0x1E6E9000,
>      [ASPEED_SRAM]   = 0x1E720000,
>      [ASPEED_GPIO]   = 0x1E780000,
> @@ -57,6 +58,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
>      [ASPEED_VIC]    = 0x1E6C0000,
>      [ASPEED_SDMC]   = 0x1E6E0000,
>      [ASPEED_SCU]    = 0x1E6E2000,
> +    [ASPEED_XDMA]   = 0x1E6E7000,
>      [ASPEED_ADC]    = 0x1E6E9000,
>      [ASPEED_SRAM]   = 0x1E720000,
>      [ASPEED_GPIO]   = 0x1E780000,
> @@ -90,6 +92,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>      [ASPEED_VIC]    = 0x1E6C0000,
>      [ASPEED_SDMC]   = 0x1E6E0000,
>      [ASPEED_SCU]    = 0x1E6E2000,
> +    [ASPEED_XDMA]   = 0x1E6E7000,
>      [ASPEED_ADC]    = 0x1E6E9000,
>      [ASPEED_SRAM]   = 0x1E720000,
>      [ASPEED_GPIO]   = 0x1E780000,
> @@ -137,6 +140,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
>      [ASPEED_I2C]    = 12,
>      [ASPEED_ETH1]   = 2,
>      [ASPEED_ETH2]   = 3,
> +    [ASPEED_XDMA]   = 6,
>  };
>  
>  #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
> @@ -174,6 +178,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>      [ASPEED_ETH2]   = 3,
>      [ASPEED_FSI1]   = 100,
>      [ASPEED_FSI2]   = 101,
> +    [ASPEED_XDMA]   = 6,
>  };
>  
>  static const char *aspeed_soc_ast2400_typenames[] = { "aspeed.smc.spi" };
> @@ -359,6 +364,9 @@ static void aspeed_soc_init(Object *obj)
>          sysbus_init_child_obj(obj, "fsi[*]", OBJECT(&s->fsi[0]),
>                                sizeof(s->fsi[0]), TYPE_ASPEED_FSI);
>      }
> +
> +    sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
> +                          TYPE_ASPEED_XDMA);
>  }
>  
>  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> @@ -662,6 +670,17 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
>                             aspeed_soc_get_irq(s, ASPEED_FSI1));
>      }
> +
> +    /* XDMA */
> +    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
> +                    sc->info->memmap[ASPEED_XDMA]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_XDMA));
>  }
>  
>  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index d33c1c6..dc2b9c3 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -78,6 +78,7 @@ obj-$(CONFIG_PVPANIC) += pvpanic.o
>  obj-$(CONFIG_AUX) += auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o aspeed_ibt.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_pwm.o aspeed_lpc.o aspeed_fsi.o
> +obj-$(CONFIG_ASPEED_SOC) += aspeed_xdma.o
>  obj-$(CONFIG_MSF2) += msf2-sysreg.o
>  obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
>  
> diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
> new file mode 100644
> index 0000000..eebd4ad
> --- /dev/null
> +++ b/hw/misc/aspeed_xdma.c
> @@ -0,0 +1,165 @@
> +/*
> + * ASPEED XDMA Controller
> + * Eddie James <eajames@linux.ibm.com>
> + *
> + * Copyright (C) 2019 IBM Corp
> + * SPDX-License-Identifer: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "hw/misc/aspeed_xdma.h"
> +#include "qapi/error.h"
> +
> +#include "trace.h"
> +
> +#define XDMA_BMC_CMDQ_ADDR         0x10
> +#define XDMA_BMC_CMDQ_ENDP         0x14
> +#define XDMA_BMC_CMDQ_WRP          0x18
> +#define  XDMA_BMC_CMDQ_W_MASK      0x0003FFFF
> +#define XDMA_BMC_CMDQ_RDP          0x1C
> +#define  XDMA_BMC_CMDQ_RDP_MAGIC   0xEE882266
> +#define XDMA_IRQ_ENG_CTRL          0x20
> +#define  XDMA_IRQ_ENG_CTRL_US_COMP BIT(4)
> +#define  XDMA_IRQ_ENG_CTRL_DS_COMP BIT(5)
> +#define  XDMA_IRQ_ENG_CTRL_W_MASK  0xBFEFF07F
> +#define XDMA_IRQ_ENG_STAT          0x24
> +#define  XDMA_IRQ_ENG_STAT_US_COMP BIT(4)
> +#define  XDMA_IRQ_ENG_STAT_DS_COMP BIT(5)
> +#define  XDMA_IRQ_ENG_STAT_RESET   0xF8000000
> +#define XDMA_MEM_SIZE              0x1000
> +
> +#define TO_REG(addr) ((addr) / sizeof(uint32_t))
> +
> +static uint64_t aspeed_xdma_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    uint32_t val = 0;
> +    AspeedXDMAState *xdma = opaque;
> +
> +    if (addr < ASPEED_XDMA_REG_SIZE) {
> +        val = xdma->regs[TO_REG(addr)];
> +    }
> +
> +    return (uint64_t)val;
> +}
> +
> +static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t val,
> +                              unsigned int size)
> +{
> +    unsigned int idx;
> +    uint32_t val32 = (uint32_t)val;
> +    AspeedXDMAState *xdma = opaque;
> +
> +    if (addr >= ASPEED_XDMA_REG_SIZE) {
> +        return;
> +    }
> +
> +    switch (addr) {
> +    case XDMA_BMC_CMDQ_ENDP:
> +        xdma->regs[TO_REG(addr)] = val32 & XDMA_BMC_CMDQ_W_MASK;
> +        break;
> +    case XDMA_BMC_CMDQ_WRP:
> +        idx = TO_REG(addr);
> +        xdma->regs[idx] = val32 & XDMA_BMC_CMDQ_W_MASK;
> +        xdma->regs[TO_REG(XDMA_BMC_CMDQ_RDP)] = xdma->regs[idx];
> +
> +        trace_aspeed_xdma_write(addr, val);
> +
> +        if (xdma->bmc_cmdq_readp_set) {
> +            xdma->bmc_cmdq_readp_set = 0;
> +        } else {
> +            xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] |=
> +                XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP;
> +
> +            if (xdma->regs[TO_REG(XDMA_IRQ_ENG_CTRL)] &
> +                (XDMA_IRQ_ENG_CTRL_US_COMP | XDMA_IRQ_ENG_CTRL_DS_COMP))
> +                qemu_irq_raise(xdma->irq);
> +        }
> +        break;
> +    case XDMA_BMC_CMDQ_RDP:
> +        trace_aspeed_xdma_write(addr, val);
> +
> +        if (val32 == XDMA_BMC_CMDQ_RDP_MAGIC) {
> +            xdma->bmc_cmdq_readp_set = 1;
> +        }
> +        break;
> +    case XDMA_IRQ_ENG_CTRL:
> +        xdma->regs[TO_REG(addr)] = val32 & XDMA_IRQ_ENG_CTRL_W_MASK;
> +        break;
> +    case XDMA_IRQ_ENG_STAT:
> +        trace_aspeed_xdma_write(addr, val);
> +
> +        idx = TO_REG(addr);
> +        if (val32 & (XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP)) {
> +            xdma->regs[idx] &=
> +                ~(XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP);
> +            qemu_irq_lower(xdma->irq);
> +        }
> +        break;
> +    default:
> +        xdma->regs[TO_REG(addr)] = val32;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_xdma_ops = {
> +    .read = aspeed_xdma_read,
> +    .write = aspeed_xdma_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void aspeed_xdma_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedXDMAState *xdma = ASPEED_XDMA(dev);
> +
> +    sysbus_init_irq(sbd, &xdma->irq);
> +    memory_region_init_io(&xdma->iomem, OBJECT(xdma), &aspeed_xdma_ops, xdma,
> +                          TYPE_ASPEED_XDMA, XDMA_MEM_SIZE);
> +    sysbus_init_mmio(sbd, &xdma->iomem);
> +}
> +
> +static void aspeed_xdma_reset(DeviceState *dev)
> +{
> +    AspeedXDMAState *xdma = ASPEED_XDMA(dev);
> +
> +    xdma->bmc_cmdq_readp_set = 0;
> +    memset(xdma->regs, 0, ASPEED_XDMA_REG_SIZE);
> +    xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] = XDMA_IRQ_ENG_STAT_RESET;
> +
> +    qemu_irq_lower(xdma->irq);
> +}
> +
> +static const VMStateDescription aspeed_xdma_vmstate = {
> +    .name = TYPE_ASPEED_XDMA,
> +    .version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AspeedXDMAState, ASPEED_XDMA_NUM_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static void aspeed_xdma_class_init(ObjectClass *classp, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(classp);
> +
> +    dc->realize = aspeed_xdma_realize;
> +    dc->reset = aspeed_xdma_reset;
> +    dc->vmsd = &aspeed_xdma_vmstate;
> +}
> +
> +static const TypeInfo aspeed_xdma_info = {
> +    .name          = TYPE_ASPEED_XDMA,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AspeedXDMAState),
> +    .class_init    = aspeed_xdma_class_init,
> +};
> +
> +static void aspeed_xdma_register_type(void)
> +{
> +    type_register_static(&aspeed_xdma_info);
> +}
> +type_init(aspeed_xdma_register_type);
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 47e1bcc..c1ea1aa 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -140,3 +140,6 @@ armsse_cpuid_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 CPU_I
>  # armsse-mhu.c
>  armsse_mhu_read(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> +
> +# aspeed_xdma.c
> +aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 00ee260..0aaf510 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -28,6 +28,7 @@
>  #include "hw/misc/aspeed_pwm.h"
>  #include "hw/misc/aspeed_lpc.h"
>  #include "hw/misc/aspeed_fsi.h"
> +#include "hw/misc/aspeed_xdma.h"
>  
>  #define ASPEED_SPIS_NUM  2
>  #define ASPEED_WDTS_NUM  3
> @@ -59,6 +60,7 @@ typedef struct AspeedSoCState {
>      AspeedPWMState pwm;
>      AspeedLPCState lpc;
>      AspeedFsiState fsi[2];
> +    AspeedXDMAState xdma;
>  } AspeedSoCState;
>  
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -126,6 +128,7 @@ enum {
>      ASPEED_SDRAM,
>      ASPEED_FSI1,
>      ASPEED_FSI2,
> +    ASPEED_XDMA,
>  };
>  
>  #endif /* ASPEED_SOC_H */
> diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xdma.h
> new file mode 100644
> index 0000000..00b45d9
> --- /dev/null
> +++ b/include/hw/misc/aspeed_xdma.h
> @@ -0,0 +1,30 @@
> +/*
> + * ASPEED XDMA Controller
> + * Eddie James <eajames@linux.ibm.com>
> + *
> + * Copyright (C) 2019 IBM Corp.
> + * SPDX-License-Identifer: GPL-2.0-or-later
> + */
> +
> +#ifndef ASPEED_XDMA_H
> +#define ASPEED_XDMA_H
> +
> +#include "hw/sysbus.h"
> +
> +#define TYPE_ASPEED_XDMA "aspeed.xdma"
> +#define ASPEED_XDMA(obj) OBJECT_CHECK(AspeedXDMAState, (obj), TYPE_ASPEED_XDMA)
> +
> +#define ASPEED_XDMA_NUM_REGS (ASPEED_XDMA_REG_SIZE / sizeof(uint32_t))
> +#define ASPEED_XDMA_REG_SIZE 0x7C
> +
> +typedef struct AspeedXDMAState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +
> +    char bmc_cmdq_readp_set;
> +    uint32_t regs[ASPEED_XDMA_NUM_REGS];
> +} AspeedXDMAState;
> +
> +#endif /* ASPEED_XDMA_H */
> 


