Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D9CC32759
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7CA2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7CA2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyAmD-0000DR-J7
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 04:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1hyAlL-0007iQ-Jf
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hyAlJ-00048n-Bl
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:05:35 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:38208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hyAlJ-00046Y-3m
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:05:33 -0400
Received: from player695.ha.ovh.net (unknown [10.109.143.220])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id C4E561E2812
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 10:05:30 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id B096A8C2D286;
 Thu, 15 Aug 2019 08:05:22 +0000 (UTC)
To: Eddie James <eajames@linux.ibm.com>, qemu-devel@nongnu.org
References: <1565814456-1264-1-git-send-email-eajames@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ca560d31-25ca-5d48-a16a-4fdf74f4779b@kaod.org>
Date: Thu, 15 Aug 2019 10:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565814456-1264-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1317865841822960401
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.35.78
Subject: Re: [Qemu-devel] [RFC v2] hw/sd/aspeed_sdhci: New device
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Eddie,

On 14/08/2019 22:27, Eddie James wrote:
> The Aspeed SOCs have two SD/MMC controllers. Add a device that
> encapsulates both of these controllers and models the Aspeed-specific
> registers and behavior.
> 
> Tested by reading from mmcblk0 in Linux:
> qemu-system-arm -machine romulus-bmc -nographic -serial mon:stdio \
>  -drive file=_tmp/flash-romulus,format=raw,if=mtd \
>  -device sd-card,drive=sd0 -drive file=_tmp/kernel,format=raw,if=sd
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> This patch applies on top of Cedric's set of recent Aspeed changes. Therefore,
> I'm sending as an RFC rather than a patch.

yes. we can worked that out when the patch is reviewed. You can base on
mainline when ready. My tree serves as an overall test base.

> Changes since v1:
>  - Move slot realize code into the Aspeed SDHCI realize function
>  - Fix interrupt handling by creating input irqs and connecting them to the
>    slot irqs.
>  - Removed card device creation code

I think all the code is here but it needs some more reshuffling :) 
 
The raspi machine is a good source for modelling pratices. 

>  hw/arm/aspeed.c              |   1 -
>  hw/arm/aspeed_soc.c          |  24 ++++++
>  hw/sd/Makefile.objs          |   1 +
>  hw/sd/aspeed_sdhci.c         | 190 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/aspeed_soc.h  |   3 +
>  include/hw/sd/aspeed_sdhci.h |  35 ++++++++
>  6 files changed, 253 insertions(+), 1 deletion(-)
>  create mode 100644 hw/sd/aspeed_sdhci.c
>  create mode 100644 include/hw/sd/aspeed_sdhci.h
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 2574425..aeed5b6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -480,7 +480,6 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
>      mc->desc = board->desc;
>      mc->init = aspeed_machine_init;
>      mc->max_cpus = ASPEED_CPUS_NUM;
> -    mc->no_sdcard = 1;
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->no_parallel = 1;
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 8df96f2..a12f14a 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -22,6 +22,7 @@
>  #include "qemu/error-report.h"
>  #include "hw/i2c/aspeed_i2c.h"
>  #include "net/net.h"
> +#include "sysemu/blockdev.h"

I would expect block devices to be handled at the machine level in 
aspeed.c, like the flash devices are. Something like :

    /* Create and plug in the SD cards */
    for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; i++) {
        BusState *bus;
        DriveInfo *di = drive_get_next(IF_SD);
        BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
        DeviceState *carddev;

        bus = qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
        if (!bus) {
            error_report("No SD bus found for SD card %d", i);
            exit(1);
        }
        carddev = qdev_create(bus, TYPE_SD_CARD);
        qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
        object_property_set_bool(OBJECT(carddev), true, "realized",
                                 &error_fatal);
    }

>  
>  #define ASPEED_SOC_IOMEM_SIZE       0x00200000
>  
> @@ -62,6 +63,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
>      [ASPEED_XDMA]   = 0x1E6E7000,
>      [ASPEED_ADC]    = 0x1E6E9000,
>      [ASPEED_SRAM]   = 0x1E720000,
> +    [ASPEED_SDHCI]  = 0x1E740000,
>      [ASPEED_GPIO]   = 0x1E780000,
>      [ASPEED_RTC]    = 0x1E781000,
>      [ASPEED_TIMER1] = 0x1E782000,
> @@ -100,6 +102,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>      [ASPEED_XDMA]   = 0x1E6E7000,
>      [ASPEED_ADC]    = 0x1E6E9000,
>      [ASPEED_VIDEO]  = 0x1E700000,
> +    [ASPEED_SDHCI]  = 0x1E740000,
>      [ASPEED_GPIO]   = 0x1E780000,
>      [ASPEED_RTC]    = 0x1E781000,
>      [ASPEED_TIMER1] = 0x1E782000,
> @@ -146,6 +149,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
>      [ASPEED_ETH1]   = 2,
>      [ASPEED_ETH2]   = 3,
>      [ASPEED_XDMA]   = 6,
> +    [ASPEED_SDHCI]  = 26,
>  };
>  
>  #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
> @@ -163,6 +167,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>      [ASPEED_SDMC]   = 0,
>      [ASPEED_SCU]    = 12,
>      [ASPEED_XDMA]   = 6,
> +    [ASPEED_SDHCI]  = 43,
>      [ASPEED_ADC]    = 46,
>      [ASPEED_GPIO]   = 40,
>      [ASPEED_RTC]    = 13,
> @@ -350,6 +355,15 @@ static void aspeed_soc_init(Object *obj)
>          sysbus_init_child_obj(obj, "fsi[*]", OBJECT(&s->fsi[0]),
>                                sizeof(s->fsi[0]), TYPE_ASPEED_FSI);
>      }
> +
> +    sysbus_init_child_obj(obj, "sdhci", OBJECT(&s->sdhci), sizeof(s->sdhci),
> +                          TYPE_ASPEED_SDHCI);

This is the Aspeed SD host interface. May be we should call it sdhost ? 

I suppose this is our "sd-bus" device ? 

> +    /* Init sd card slot class here so that they're under the correct parent */
> +    for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {

and these are the slots, I would put them at the SoC level.

> +        sysbus_init_child_obj(obj, "sdhci_slot[*]", OBJECT(&s->sdhci.slots[i]),
> +                              sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
> +    }
>  }
>  
>  /*
> @@ -680,6 +694,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
>                             aspeed_soc_get_irq(s, ASPEED_FSI1));
>      }
> +
> +    /* SD/SDIO - set the reg address so slot memory mapping can be set up */
> +    s->sdhci.ioaddr = sc->info->memmap[ASPEED_SDHCI];

That's weird. We do all mappings in the SoC. 

I think you should be realizing the slots here also. See the other SoCs, 
XlnxZynqMPState for instance.

> +    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_SDHCI));
>
>  }
>  static Property aspeed_soc_properties[] = {
>      DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> index 0665727..a884c23 100644
> --- a/hw/sd/Makefile.objs
> +++ b/hw/sd/Makefile.objs
> @@ -8,3 +8,4 @@ obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
>  obj-$(CONFIG_OMAP) += omap_mmc.o
>  obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
>  obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
> +obj-$(CONFIG_ASPEED_SOC) += aspeed_sdhci.o
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> new file mode 100644
> index 0000000..d1a05e9
> --- /dev/null
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -0,0 +1,190 @@
> +/*
> + * Aspeed SD Host Controller
> + * Eddie James <eajames@linux.ibm.com>
> + *
> + * Copyright (C) 2019 IBM Corp
> + * SPDX-License-Identifer: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "hw/sd/aspeed_sdhci.h"
> +#include "qapi/error.h"
> +
> +#define ASPEED_SDHCI_INFO            0x00
> +#define  ASPEED_SDHCI_INFO_RESET     0x00030000
> +#define ASPEED_SDHCI_DEBOUNCE        0x04
> +#define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
> +#define ASPEED_SDHCI_BUS             0x08
> +#define ASPEED_SDHCI_SDIO_140        0x10
> +#define ASPEED_SDHCI_SDIO_148        0x18
> +#define ASPEED_SDHCI_SDIO_240        0x20
> +#define ASPEED_SDHCI_SDIO_248        0x28
> +#define ASPEED_SDHCI_WP_POL          0xec
> +#define ASPEED_SDHCI_CARD_DET        0xf0
> +#define ASPEED_SDHCI_IRQ_STAT        0xfc
> +
> +#define TO_REG(addr) ((addr) / sizeof(uint32_t))
> +
> +static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    uint32_t val = 0;
> +    AspeedSDHCIState *sdhci = opaque;
> +
> +    switch (addr) {
> +    case ASPEED_SDHCI_SDIO_140:
> +        val = (uint32_t)sdhci->slots[0].capareg;
> +        break;
> +    case ASPEED_SDHCI_SDIO_148:
> +        val = (uint32_t)sdhci->slots[0].maxcurr;
> +        break;
> +    case ASPEED_SDHCI_SDIO_240:
> +        val = (uint32_t)sdhci->slots[1].capareg;
> +        break;
> +    case ASPEED_SDHCI_SDIO_248:
> +        val = (uint32_t)sdhci->slots[1].maxcurr;
> +        break;

We could mirror the 16bytes segment for [ SDHC_CAPAB ...  SDHC_MAXCURR + 4 ]  
of each slot under the MMIO region of the Aspeed SD controller at offset: 
(slot + 1) * 0x10. If that worked, we wouldn't need these redirections.

I think you need alias regions.

> +    default:
> +        if (addr < ASPEED_SDHCI_REG_SIZE) {
> +            val = sdhci->regs[TO_REG(addr)];
> +        }

we could return some errors for not implemented registers.
 
> +    }
> +
> +    return (uint64_t)val;
> +}
> +
> +static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
> +                               unsigned int size)
> +{
> +    AspeedSDHCIState *sdhci = opaque;
> +
> +    switch (addr) {
> +    case ASPEED_SDHCI_SDIO_140:
> +        sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
> +        break;
> +    case ASPEED_SDHCI_SDIO_148:
> +        sdhci->slots[0].maxcurr = (uint64_t)(uint32_t)val;
> +        break;
> +    case ASPEED_SDHCI_SDIO_240:
> +        sdhci->slots[1].capareg = (uint64_t)(uint32_t)val;
> +        break;
> +    case ASPEED_SDHCI_SDIO_248:
> +        sdhci->slots[1].maxcurr = (uint64_t)(uint32_t)val;
> +        break;

I think these regs are readonly.

> +    default:
> +        if (addr < ASPEED_SDHCI_REG_SIZE) {
> +            sdhci->regs[TO_REG(addr)] = (uint32_t)val;
> +        }
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_sdhci_ops = {
> +    .read = aspeed_sdhci_read,
> +    .write = aspeed_sdhci_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +};
> +
> +static void aspeed_sdhci_set_irq(void *opaque, int n, int level)
> +{
> +    AspeedSDHCIState *sdhci = opaque;
> +
> +    if (level) {
> +        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] |= BIT(n);
> +
> +        qemu_irq_raise(sdhci->irq);
> +    } else {
> +        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] &= ~BIT(n);
> +
> +        qemu_irq_lower(sdhci->irq);
> +    }

Doesn't that work the other way around ? 

The SDHCI objects trigger their IRQ which call the irq_notify() handler 
in which we need to deduce the slot number to update ASPEED_SDHCI_IRQ_STAT 
and raise/lower the Aspeed SD host IRQ. I think that's how it should work.


> +}
> +
> +static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    Error *err = NULL;
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
> +
> +    /* Create input irqs for the slots */
> +    qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_irq,
> +                                        sdhci, NULL, ASPEED_SDHCI_NUM_SLOTS);
> +
> +    for (int i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
> +        hwaddr slot_addr = sdhci->ioaddr + (0x100 * (i + 1));
> +        Object *sdhci_slot = OBJECT(&sdhci->slots[i]);
> +        SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slots[i]);
> +
> +        object_property_set_int(sdhci_slot, 2, "sd-spec-version", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        object_property_set_uint(sdhci_slot, ASPEED_SDHCI_CAPABILITIES,
> +                                 "capareg", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        object_property_set_bool(sdhci_slot, true, "realized", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        sysbus_mmio_map(sbd_slot, 0, slot_addr);

We should do the mapping at the SoC level and I would also put the slots 
at the SoC level.

> +        sysbus_connect_irq(sbd_slot, 0, qdev_get_gpio_in(DEVICE(sbd), i));
> +    }
> +
> +    sysbus_init_irq(sbd, &sdhci->irq);
> +    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_ops,
> +                          sdhci, TYPE_ASPEED_SDHCI, ASPEED_SDHCI_REG_SIZE);
> +    sysbus_init_mmio(sbd, &sdhci->iomem);
> +    sysbus_mmio_map(sbd, 0, sdhci->ioaddr);

Here also.

> +}
> +
> +static void aspeed_sdhci_reset(DeviceState *dev)
> +{
> +    AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
> +
> +    memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
> +    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] = ASPEED_SDHCI_INFO_RESET;
> +    sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] = ASPEED_SDHCI_DEBOUNCE_RESET;
> +}
> +
> +static const VMStateDescription vmstate_aspeed_sdhci = {
> +    .name = TYPE_ASPEED_SDHCI,
> +    .version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AspeedSDHCIState, ASPEED_SDHCI_NUM_REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(classp);
> +
> +    dc->realize = aspeed_sdhci_realize;
> +    dc->reset = aspeed_sdhci_reset;
> +    dc->vmsd = &vmstate_aspeed_sdhci;
> +}
> +
> +static TypeInfo aspeed_sdhci_info = {
> +    .name          = TYPE_ASPEED_SDHCI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AspeedSDHCIState),
> +    .class_init    = aspeed_sdhci_class_init,
> +};
> +
> +static void aspeed_sdhci_register_types(void)
> +{
> +    type_register_static(&aspeed_sdhci_info);
> +}
> +
> +type_init(aspeed_sdhci_register_types)
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 429d7e7..3ddba3a 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -29,6 +29,7 @@
>  #include "hw/misc/aspeed_pwm.h"
>  #include "hw/misc/aspeed_lpc.h"
>  #include "hw/misc/aspeed_fsi.h"
> +#include "hw/sd/aspeed_sdhci.h"
>  
>  #define ASPEED_SPIS_NUM  2
>  #define ASPEED_WDTS_NUM  4
> @@ -62,6 +63,7 @@ typedef struct AspeedSoCState {
>      AspeedPWMState pwm;
>      AspeedLPCState lpc;
>      AspeedFsiState fsi[2];
> +    AspeedSDHCIState sdhci;
>  } AspeedSoCState;
>  
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -107,6 +109,7 @@ enum {
>      ASPEED_ADC,
>      ASPEED_VIDEO,
>      ASPEED_SRAM,
> +    ASPEED_SDHCI,
>      ASPEED_GPIO,
>      ASPEED_RTC,
>      ASPEED_TIMER1,
> diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.h
> new file mode 100644
> index 0000000..ac5482f
> --- /dev/null
> +++ b/include/hw/sd/aspeed_sdhci.h
> @@ -0,0 +1,35 @@
> +/*
> + * Aspeed SD Host Controller
> + * Eddie James <eajames@linux.ibm.com>
> + *
> + * Copyright (C) 2019 IBM Corp
> + * SPDX-License-Identifer: GPL-2.0-or-later
> + */
> +
> +#ifndef ASPEED_SDHCI_H
> +#define ASPEED_SDHCI_H
> +
> +#include "hw/sd/sdhci.h"
> +
> +#define TYPE_ASPEED_SDHCI "aspeed.sdhci"
> +#define ASPEED_SDHCI(obj) OBJECT_CHECK(AspeedSDHCIState, (obj), \
> +                                       TYPE_ASPEED_SDHCI)
> +
> +#define ASPEED_SDHCI_CAPABILITIES 0x01E80080
> +#define ASPEED_SDHCI_NUM_SLOTS    2
> +#define ASPEED_SDHCI_NUM_REGS     (ASPEED_SDHCI_REG_SIZE / sizeof(uint32_t))
> +#define ASPEED_SDHCI_REG_SIZE     0x100
> +
> +typedef struct AspeedSDHCIState {

AspeedSDHost may be ? It's the SoC SD controller.

> +    SysBusDevice parent;
> +
> +    SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];

I think the SoC should own the SD slots. 

> +
> +    hwaddr ioaddr;

not needed.

> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +
> +    uint32_t regs[ASPEED_SDHCI_NUM_REGS];
> +} AspeedSDHCIState;
> +
> +#endif /* ASPEED_SDHCI_H */
> 

Thanks,

C.

