Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 06:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2ADB2064A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 06:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2ADB2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55275 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYliH-0004x2-NS
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 02:17:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hYlhI-0004dv-2O
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 02:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hYlhG-0005VU-CI
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 02:16:24 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:55441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hYlhG-0005K9-3A
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 02:16:22 -0400
Received: from player695.ha.ovh.net (unknown [10.109.143.232])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4C3D519A291
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 08:16:10 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player695.ha.ovh.net (Postfix) with ESMTPSA id 41A8D66F3BE4;
	Thu,  6 Jun 2019 06:16:04 +0000 (UTC)
To: Eddie James <eajames@linux.ibm.com>, qemu-arm@nongnu.org
References: <1559599768-9176-1-git-send-email-eajames@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8508467b-c7fd-e09b-4323-44631d25ff0e@kaod.org>
Date: Thu, 6 Jun 2019 08:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559599768-9176-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12657929705481276177
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegfedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.181.248
Subject: Re: [Qemu-devel] [PATCH] hw: misc: Add Aspeed XDMA device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-devel@nongnu.org,
	joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Eddie,

On 04/06/2019 00:09, Eddie James wrote:
> The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operations
> between the SOC (acting as a BMC) and a host processor in a server.
> 
> The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
> enable it for all of those.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

This looks correct to me. It's sufficient to exercise the BMC driver.

However, we will need to rebase on an Aspeed patchset I sent earlier :

   http://patchwork.ozlabs.org/cover/1105343/

I can do that and include the patch in my tree for the moment. 


For my understanding, how can we interact with the model and pretend
there is a host side ? 

Thanks,

C. 

> ---
>  hw/arm/aspeed_soc.c           |  14 ++++
>  hw/misc/Makefile.objs         |   2 +-
>  hw/misc/aspeed_xdma.c         | 156 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/aspeed_soc.h   |   2 +
>  include/hw/misc/aspeed_xdma.h |  31 +++++++++
>  5 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/aspeed_xdma.c
>  create mode 100644 include/hw/misc/aspeed_xdma.h
> 
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index faff42b..b25bb18 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -31,6 +31,7 @@
>  #define ASPEED_SOC_VIC_BASE         0x1E6C0000
>  #define ASPEED_SOC_SDMC_BASE        0x1E6E0000
>  #define ASPEED_SOC_SCU_BASE         0x1E6E2000
> +#define ASPEED_SOC_XDMA_BASE        0x1E6E7000
>  #define ASPEED_SOC_SRAM_BASE        0x1E720000
>  #define ASPEED_SOC_TIMER_BASE       0x1E782000
>  #define ASPEED_SOC_WDT_BASE         0x1E785000
> @@ -159,6 +160,9 @@ static void aspeed_soc_init(Object *obj)
>  
>      sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
>                            sizeof(s->ftgmac100), TYPE_FTGMAC100);
> +
> +    sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
> +                          TYPE_ASPEED_XDMA);
>  }
>  
>  static void aspeed_soc_realize(DeviceState *dev, Error **errp)
> @@ -298,6 +302,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BASE);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
>                         qdev_get_gpio_in(DEVICE(&s->vic), 2));
> +
> +    /* XDMA */
> +    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0, ASPEED_SOC_XDMA_BASE);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
> +                       qdev_get_gpio_in(DEVICE(&s->vic), 6));
>  }
>  
>  static void aspeed_soc_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 77b9df9..a4483af 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -74,7 +74,7 @@ obj-$(CONFIG_ARMSSE_MHU) += armsse-mhu.o
>  
>  obj-$(CONFIG_PVPANIC) += pvpanic.o
>  obj-$(CONFIG_AUX) += auxbus.o
> -obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
> +obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o aspeed_xdma.o
>  obj-$(CONFIG_MSF2) += msf2-sysreg.o
>  obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
>  
> diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
> new file mode 100644
> index 0000000..fe3a32e
> --- /dev/null
> +++ b/hw/misc/aspeed_xdma.c
> @@ -0,0 +1,156 @@
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
> +        if (val32 == XDMA_BMC_CMDQ_RDP_MAGIC) {
> +            xdma->bmc_cmdq_readp_set = 1;
> +        }
> +        break;
> +    case XDMA_IRQ_ENG_CTRL:
> +        xdma->regs[TO_REG(addr)] = val32 & XDMA_IRQ_ENG_CTRL_W_MASK;
> +        break;
> +    case XDMA_IRQ_ENG_STAT:
> +        idx = TO_REG(addr);
> +        if (val32 & (XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP)) {
> +            xdma->regs[TO_REG(addr)] &=
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
> +                          TYPE_ASPEED_XDMA, ASPEED_XDMA_MEM_SIZE);
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
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 836b2ba..0329247 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -20,6 +20,7 @@
>  #include "hw/ssi/aspeed_smc.h"
>  #include "hw/watchdog/wdt_aspeed.h"
>  #include "hw/net/ftgmac100.h"
> +#include "hw/misc/aspeed_xdma.h"
>  
>  #define ASPEED_SPIS_NUM  2
>  #define ASPEED_WDTS_NUM  3
> @@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
>      AspeedSDMCState sdmc;
>      AspeedWDTState wdt[ASPEED_WDTS_NUM];
>      FTGMAC100State ftgmac100;
> +    AspeedXDMAState xdma;
>  } AspeedSoCState;
>  
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xdma.h
> new file mode 100644
> index 0000000..d19e9a7
> --- /dev/null
> +++ b/include/hw/misc/aspeed_xdma.h
> @@ -0,0 +1,31 @@
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
> +#define ASPEED_XDMA_MEM_SIZE 0x1000
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


