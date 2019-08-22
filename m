Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A088C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134472339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 09:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134472339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0jFQ-0002QF-7D
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 05:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i0jE3-0000WT-RD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i0jE1-0003WW-JV
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:17:47 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:53467)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i0jE1-0003Pf-60
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 05:17:45 -0400
Received: from player799.ha.ovh.net (unknown [10.109.146.132])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 57B59674AB
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 11:17:32 +0200 (CEST)
Received: from kaod.org (lfbn-ren-1-123-36.w83-205.abo.wanadoo.fr
 [83.205.208.36]) (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id BEFC8901A474;
 Thu, 22 Aug 2019 09:17:25 +0000 (UTC)
To: Eddie James <eajames@linux.ibm.com>, qemu-devel@nongnu.org
References: <1566327765-2003-1-git-send-email-eajames@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c2a58f33-e4cf-0033-37bf-420cc665d949@kaod.org>
Date: Thu, 22 Aug 2019 11:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566327765-2003-1-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6749488469732395793
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeghedgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.50.107
Subject: Re: [Qemu-devel] [RFC v3] hw/sd/aspeed_sdhci: New device
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

On 20/08/2019 21:02, Eddie James wrote:
> The Aspeed SOCs have two SD/MMC controllers. Add a device that
> encapsulates both of these controllers and models the Aspeed-specific
> registers and behavior.
>=20
> Tested by reading from mmcblk0 in Linux:
> qemu-system-arm -machine romulus-bmc -nographic \
>  -drive file=3Dflash-romulus,format=3Draw,if=3Dmtd \
>  -device sd-card,drive=3Dsd0 -drive file=3D_tmp/kernel,format=3Draw,if=3D=
sd
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
> This patch applies on top of Cedric's set of recent Aspeed changes.
> Therefore, I'm sending as an RFC rather than a patch for review.

I merged this patch in aspeed-4.2 and made the adjustments to move
it to the top of the patchset after the GPIO model.=20

Thanks,

C.


> Changes since v2:
>  - Do the memory mapping at the SOC level
>  - Add guest errors for out-of-bounds access to the SDHCI regs
>  - Remove unnecessary blockdev include in aspeed_soc.c
>  - Better naming for SDHCI objects.
>=20
> Changes since v1:
>  - Move slot realize code into the Aspeed SDHCI realize function
>  - Fix interrupt handling by creating input irqs and connecting them to=
 the
>    slot irqs.
>  - Removed card device creation code
>  hw/arm/aspeed.c              |   1 -
>  hw/arm/aspeed_soc.c          |  28 +++++++
>  hw/sd/Makefile.objs          |   1 +
>  hw/sd/aspeed_sdhci.c         | 194 +++++++++++++++++++++++++++++++++++=
++++++++
>  include/hw/arm/aspeed_soc.h  |   3 +
>  include/hw/sd/aspeed_sdhci.h |  34 ++++++++
>  6 files changed, 260 insertions(+), 1 deletion(-)
>  create mode 100644 hw/sd/aspeed_sdhci.c
>  create mode 100644 include/hw/sd/aspeed_sdhci.h
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 2574425..aeed5b6 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -480,7 +480,6 @@ static void aspeed_machine_class_init(ObjectClass *=
oc, void *data)
>      mc->desc =3D board->desc;
>      mc->init =3D aspeed_machine_init;
>      mc->max_cpus =3D ASPEED_CPUS_NUM;
> -    mc->no_sdcard =3D 1;
>      mc->no_floppy =3D 1;
>      mc->no_cdrom =3D 1;
>      mc->no_parallel =3D 1;
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index c9f6e01..292751e 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -62,6 +62,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
>      [ASPEED_XDMA]   =3D 0x1E6E7000,
>      [ASPEED_ADC]    =3D 0x1E6E9000,
>      [ASPEED_SRAM]   =3D 0x1E720000,
> +    [ASPEED_SDHCI]  =3D 0x1E740000,
>      [ASPEED_GPIO]   =3D 0x1E780000,
>      [ASPEED_RTC]    =3D 0x1E781000,
>      [ASPEED_TIMER1] =3D 0x1E782000,
> @@ -102,6 +103,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D=
 {
>      [ASPEED_XDMA]      =3D 0x1E6E7000,
>      [ASPEED_ADC]       =3D 0x1E6E9000,
>      [ASPEED_VIDEO]     =3D 0x1E700000,
> +    [ASPEED_SDHCI]     =3D 0x1E740000,
>      [ASPEED_GPIO]      =3D 0x1E780000,
>      [ASPEED_GPIO_1_8V] =3D 0x1E780800,
>      [ASPEED_RTC]       =3D 0x1E781000,
> @@ -147,6 +149,7 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
>      [ASPEED_ETH1]   =3D 2,
>      [ASPEED_ETH2]   =3D 3,
>      [ASPEED_XDMA]   =3D 6,
> +    [ASPEED_SDHCI]  =3D 26,
>  };
> =20
>  #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
> @@ -185,6 +188,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
>      [ASPEED_ETH2]      =3D 3,
>      [ASPEED_FSI1]      =3D 100,
>      [ASPEED_FSI2]      =3D 101,
> +    [ASPEED_SDHCI]     =3D 43,
>  };
> =20
>  static const AspeedSoCInfo aspeed_socs[] =3D {
> @@ -357,6 +361,15 @@ static void aspeed_soc_init(Object *obj)
>          sysbus_init_child_obj(obj, "fsi[*]", OBJECT(&s->fsi[0]),
>                                sizeof(s->fsi[0]), TYPE_ASPEED_FSI);
>      }
> +
> +    sysbus_init_child_obj(obj, "sdc", OBJECT(&s->sdhci), sizeof(s->sdh=
ci),
> +                          TYPE_ASPEED_SDHCI);
> +
> +    /* Init sd card slot class here so that they're under the correct =
parent */
> +    for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
> +        sysbus_init_child_obj(obj, "sdhci[*]", OBJECT(&s->sdhci.slots[=
i]),
> +                              sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_S=
DHCI);
> +    }
>  }
> =20
>  /*
> @@ -698,6 +711,21 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
>                             aspeed_soc_get_irq(s, ASPEED_FSI1));
>      }
> +
> +    /* SDHCI */
> +    object_property_set_bool(OBJECT(&s->sdhci), true, "realized", &err=
);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    for (i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci.slots[i]), 0,
> +                        sc->info->memmap[ASPEED_SDHCI] + ((i + 1) * 0x=
100));
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
> +                    sc->info->memmap[ASPEED_SDHCI]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_SDHCI));
>  }
>  static Property aspeed_soc_properties[] =3D {
>      DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> index 0665727..a884c23 100644
> --- a/hw/sd/Makefile.objs
> +++ b/hw/sd/Makefile.objs
> @@ -8,3 +8,4 @@ obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
>  obj-$(CONFIG_OMAP) +=3D omap_mmc.o
>  obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
>  obj-$(CONFIG_RASPI) +=3D bcm2835_sdhost.o
> +obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_sdhci.o
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> new file mode 100644
> index 0000000..6e99a9d
> --- /dev/null
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -0,0 +1,194 @@
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
> +static uint64_t aspeed_sdhci_read(void *opaque, hwaddr addr, unsigned =
int size)
> +{
> +    uint32_t val =3D 0;
> +    AspeedSDHCIState *sdhci =3D opaque;
> +
> +    switch (addr) {
> +    case ASPEED_SDHCI_SDIO_140:
> +        val =3D (uint32_t)sdhci->slots[0].capareg;
> +        break;
> +    case ASPEED_SDHCI_SDIO_148:
> +        val =3D (uint32_t)sdhci->slots[0].maxcurr;
> +        break;
> +    case ASPEED_SDHCI_SDIO_240:
> +        val =3D (uint32_t)sdhci->slots[1].capareg;
> +        break;
> +    case ASPEED_SDHCI_SDIO_248:
> +        val =3D (uint32_t)sdhci->slots[1].maxcurr;
> +        break;
> +    default:
> +        if (addr < ASPEED_SDHCI_REG_SIZE) {
> +            val =3D sdhci->regs[TO_REG(addr)];
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Out-of-bounds read at 0x%" HWADDR_PRIx =
"\n",
> +                          __func__, addr);
> +        }
> +    }
> +
> +    return (uint64_t)val;
> +}
> +
> +static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val=
,
> +                               unsigned int size)
> +{
> +    AspeedSDHCIState *sdhci =3D opaque;
> +
> +    switch (addr) {
> +    case ASPEED_SDHCI_SDIO_140:
> +        sdhci->slots[0].capareg =3D (uint64_t)(uint32_t)val;
> +        break;
> +    case ASPEED_SDHCI_SDIO_148:
> +        sdhci->slots[0].maxcurr =3D (uint64_t)(uint32_t)val;
> +        break;
> +    case ASPEED_SDHCI_SDIO_240:
> +        sdhci->slots[1].capareg =3D (uint64_t)(uint32_t)val;
> +        break;
> +    case ASPEED_SDHCI_SDIO_248:
> +        sdhci->slots[1].maxcurr =3D (uint64_t)(uint32_t)val;
> +        break;
> +    default:
> +        if (addr < ASPEED_SDHCI_REG_SIZE) {
> +            sdhci->regs[TO_REG(addr)] =3D (uint32_t)val;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Out-of-bounds write at 0x%" HWADDR_PRIx=
 "\n",
> +                          __func__, addr);
> +        }
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_sdhci_ops =3D {
> +    .read =3D aspeed_sdhci_read,
> +    .write =3D aspeed_sdhci_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +};
> +
> +static void aspeed_sdhci_set_irq(void *opaque, int n, int level)
> +{
> +    AspeedSDHCIState *sdhci =3D opaque;
> +
> +    if (level) {
> +        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] |=3D BIT(n);
> +
> +        qemu_irq_raise(sdhci->irq);
> +    } else {
> +        sdhci->regs[TO_REG(ASPEED_SDHCI_IRQ_STAT)] &=3D ~BIT(n);
> +
> +        qemu_irq_lower(sdhci->irq);
> +    }
> +}
> +
> +static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    Error *err =3D NULL;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
> +
> +    /* Create input irqs for the slots */
> +    qdev_init_gpio_in_named_with_opaque(DEVICE(sbd), aspeed_sdhci_set_=
irq,
> +                                        sdhci, NULL, ASPEED_SDHCI_NUM_=
SLOTS);
> +
> +    for (int i =3D 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
> +        Object *sdhci_slot =3D OBJECT(&sdhci->slots[i]);
> +        SysBusDevice *sbd_slot =3D SYS_BUS_DEVICE(&sdhci->slots[i]);
> +
> +        object_property_set_int(sdhci_slot, 2, "sd-spec-version", &err=
);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +
> +        object_property_set_uint(sdhci_slot, ASPEED_SDHCI_CAPABILITIES=
,
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
> +        sysbus_connect_irq(sbd_slot, 0, qdev_get_gpio_in(DEVICE(sbd), =
i));
> +    }
> +
> +    sysbus_init_irq(sbd, &sdhci->irq);
> +    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &aspeed_sdhci_=
ops,
> +                          sdhci, TYPE_ASPEED_SDHCI, ASPEED_SDHCI_REG_S=
IZE);
> +    sysbus_init_mmio(sbd, &sdhci->iomem);
> +}
> +
> +static void aspeed_sdhci_reset(DeviceState *dev)
> +{
> +    AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
> +
> +    memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
> +    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D ASPEED_SDHCI_INFO_RESET=
;
> +    sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] =3D ASPEED_SDHCI_DEBOUN=
CE_RESET;
> +}
> +
> +static const VMStateDescription vmstate_aspeed_sdhci =3D {
> +    .name =3D TYPE_ASPEED_SDHCI,
> +    .version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, AspeedSDHCIState, ASPEED_SDHCI_NUM_=
REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(classp);
> +
> +    dc->realize =3D aspeed_sdhci_realize;
> +    dc->reset =3D aspeed_sdhci_reset;
> +    dc->vmsd =3D &vmstate_aspeed_sdhci;
> +}
> +
> +static TypeInfo aspeed_sdhci_info =3D {
> +    .name          =3D TYPE_ASPEED_SDHCI,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(AspeedSDHCIState),
> +    .class_init    =3D aspeed_sdhci_class_init,
> +};
> +
> +static void aspeed_sdhci_register_types(void)
> +{
> +    type_register_static(&aspeed_sdhci_info);
> +}
> +
> +type_init(aspeed_sdhci_register_types)
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 3f6c6c5..60e0fb2 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -29,6 +29,7 @@
>  #include "hw/misc/aspeed_pwm.h"
>  #include "hw/misc/aspeed_lpc.h"
>  #include "hw/misc/aspeed_fsi.h"
> +#include "hw/sd/aspeed_sdhci.h"
> =20
>  #define ASPEED_SPIS_NUM  2
>  #define ASPEED_WDTS_NUM  4
> @@ -63,6 +64,7 @@ typedef struct AspeedSoCState {
>      AspeedPWMState pwm;
>      AspeedLPCState lpc;
>      AspeedFsiState fsi[2];
> +    AspeedSDHCIState sdhci;
>  } AspeedSoCState;
> =20
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -108,6 +110,7 @@ enum {
>      ASPEED_ADC,
>      ASPEED_VIDEO,
>      ASPEED_SRAM,
> +    ASPEED_SDHCI,
>      ASPEED_GPIO,
>      ASPEED_GPIO_1_8V,
>      ASPEED_RTC,
> diff --git a/include/hw/sd/aspeed_sdhci.h b/include/hw/sd/aspeed_sdhci.=
h
> new file mode 100644
> index 0000000..dfdab43
> --- /dev/null
> +++ b/include/hw/sd/aspeed_sdhci.h
> @@ -0,0 +1,34 @@
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
> +#define ASPEED_SDHCI_NUM_REGS     (ASPEED_SDHCI_REG_SIZE / sizeof(uint=
32_t))
> +#define ASPEED_SDHCI_REG_SIZE     0x100
> +
> +typedef struct AspeedSDHCIState {
> +    SysBusDevice parent;
> +
> +    SDHCIState slots[ASPEED_SDHCI_NUM_SLOTS];
> +
> +    MemoryRegion iomem;
> +    qemu_irq irq;
> +
> +    uint32_t regs[ASPEED_SDHCI_NUM_REGS];
> +} AspeedSDHCIState;
> +
> +#endif /* ASPEED_SDHCI_H */
>=20


