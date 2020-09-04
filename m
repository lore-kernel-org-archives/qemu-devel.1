Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FADAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C042083B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNRVoZhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C042083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHbD-0008Pi-EO
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHaR-0007kY-IY; Fri, 04 Sep 2020 15:41:27 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:38478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHaP-000553-3t; Fri, 04 Sep 2020 15:41:27 -0400
Received: by mail-il1-x142.google.com with SMTP id w3so7371626ilh.5;
 Fri, 04 Sep 2020 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Dt8Ojl09/KiTwnSPVXovfAjydL/3HsqXuXzjSMp5k6I=;
 b=DNRVoZhED4mxdqYlM4j4h4u0pBkn53Jfzcz99UyIsQM6qFtq+vLH/7aYsihvXsq0Rj
 ViePn5HCjTldq+o8i4bTpA3CT9ITjZaWfiHml95GVgxY3zjz1fnvpIUrDTtu25KM6OWt
 qcTHRegf4wanoU2PD34en/t2hVP6yOd3anwzev3ClI8dr1pLI9ham82O6iznZtvb+/Db
 s0HcHhxz4ri7L5xR7mTyzWv9F/XvsOy37lwA0hn9+wptOrWzIdWzySAWvnGfcw1uk5ns
 2BtxCiSEgUttUBERnoFNYe8wFZZ1N1+M3SWNcpA+aXORE8BUM7LMlWB9H3Fk9XiB+uF4
 FSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Dt8Ojl09/KiTwnSPVXovfAjydL/3HsqXuXzjSMp5k6I=;
 b=h7uxYjuA7qv47QWvm9yWRggnWnKKmI2H67RAa6jXiYjkFLQNdfYhpmamnEgdUXhpuq
 YCssMsivDlTmmDaZdFP75V9irb8OOhnduN0/lXseVv7tfs0n/qLvaQBioZBbmIsf+hDP
 o8Y8T4qw+ww2F63vBR3qVIEgxrGtAyocQRmYW4KCSKHKCOT1fWYCfyeShuDHrtp5pQHe
 3YzOdD/wcosX8rUKY5Ci85CSNldP+M+eLrcIhI6YdYs+VpwMM9SfqfvDDsucoapkEs/d
 p0vk84z8Na7m862dG9q8y9bdAyn7ghgQMXL2ei67djXvr+t/bHfCsE53Ddzm9TE6VPxN
 j89w==
X-Gm-Message-State: AOAM531R/q4FNw8dySX0rcvzK1M+leeE4Ys6/0t8bAYCDIaMy/6oLkbK
 CPryEQeeTLjXOObqE/y0cQcZStP5rfQwQUhvhBA=
X-Google-Smtp-Source: ABdhPJzZfFUnngdoqV9pXFESs1MLIuLxF9oMSwgBLlzwhw963d6rnYK58Y1z4L2ZvYVpDGcX6Yu+TEAaiB8uj/u9lp4=
X-Received: by 2002:a05:6e02:ca3:: with SMTP id
 3mr9871384ilg.227.1599248483183; 
 Fri, 04 Sep 2020 12:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-8-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1598924352-89526-8-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 12:30:28 -0700
Message-ID: <CAKmqyKODHvqddbXd+5Cw7M5YqZb_fk=ab3HgEbv+CegYxRFGaw@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] hw/sd: Add Cadence SDHCI emulation
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 6:45 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Cadence SD/SDIO/eMMC Host Controller (SD4HC) is an SDHCI compatible
> controller. The SDHCI compatible registers start from offset 0x200,
> which are called Slot Register Set (SRS) in its datasheet.
>
> This creates a Cadence SDHCI model built on top of the existing
> generic SDHCI model. Cadence specific Host Register Set (HRS) is
> implemented to make guest software happy.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I could find s apec to compare this with. Overall it looks fine in
terms of QEMU code though.

Acked-by: Alistair Francis <alistair.francis@wdc.com>

>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - change to update hw/sd/meson.build
> - change the name to "generic-sdhci" when calling object_initialize_child=
()
> - add a container MR to simplify out-of-bounds access checks
>
>  include/hw/sd/cadence_sdhci.h |  47 ++++++++++
>  hw/sd/cadence_sdhci.c         | 193 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/sd/Kconfig                 |   4 +
>  hw/sd/meson.build             |   1 +
>  4 files changed, 245 insertions(+)
>  create mode 100644 include/hw/sd/cadence_sdhci.h
>  create mode 100644 hw/sd/cadence_sdhci.c
>
> diff --git a/include/hw/sd/cadence_sdhci.h b/include/hw/sd/cadence_sdhci.=
h
> new file mode 100644
> index 0000000..cd8288b
> --- /dev/null
> +++ b/include/hw/sd/cadence_sdhci.h
> @@ -0,0 +1,47 @@
> +/*
> + * Cadence SDHCI emulation
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef CADENCE_SDHCI_H
> +#define CADENCE_SDHCI_H
> +
> +#include "hw/sd/sdhci.h"
> +
> +#define CADENCE_SDHCI_REG_SIZE  0x100
> +#define CADENCE_SDHCI_NUM_REGS  (CADENCE_SDHCI_REG_SIZE / sizeof(uint32_=
t))
> +
> +typedef struct CadenceSDHCIState {
> +    SysBusDevice parent;
> +
> +    MemoryRegion container;
> +    MemoryRegion iomem;
> +    BusState *bus;
> +
> +    uint32_t regs[CADENCE_SDHCI_NUM_REGS];
> +
> +    SDHCIState sdhci;
> +} CadenceSDHCIState;
> +
> +#define TYPE_CADENCE_SDHCI  "cadence.sdhci"
> +#define CADENCE_SDHCI(obj)  OBJECT_CHECK(CadenceSDHCIState, (obj), \
> +                                         TYPE_CADENCE_SDHCI)
> +
> +#endif /* CADENCE_SDHCI_H */
> diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
> new file mode 100644
> index 0000000..0b371c8
> --- /dev/null
> +++ b/hw/sd/cadence_sdhci.c
> @@ -0,0 +1,193 @@
> +/*
> + * Cadence SDHCI emulation
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "hw/irq.h"
> +#include "hw/sd/cadence_sdhci.h"
> +#include "sdhci-internal.h"
> +
> +/* HRS - Host Register Set (specific to Cadence) */
> +
> +#define CADENCE_SDHCI_HRS00             0x00    /* general information *=
/
> +#define CADENCE_SDHCI_HRS00_SWR             BIT(0)
> +#define CADENCE_SDHCI_HRS00_POR_VAL         0x00010000
> +
> +#define CADENCE_SDHCI_HRS04             0x10    /* PHY access port */
> +#define CADENCE_SDHCI_HRS04_WR              BIT(24)
> +#define CADENCE_SDHCI_HRS04_RD              BIT(25)
> +#define CADENCE_SDHCI_HRS04_ACK             BIT(26)
> +
> +#define CADENCE_SDHCI_HRS06             0x18    /* eMMC control */
> +#define CADENCE_SDHCI_HRS06_TUNE_UP         BIT(15)

Just for future the REGISTER and FILED macros are useful here.

Alistair

> +
> +/* SRS - Slot Register Set (SDHCI-compatible) */
> +
> +#define CADENCE_SDHCI_SRS_BASE          0x200
> +
> +#define TO_REG(addr)    ((addr) / sizeof(uint32_t))
> +
> +static void cadence_sdhci_instance_init(Object *obj)
> +{
> +    CadenceSDHCIState *s =3D CADENCE_SDHCI(obj);
> +
> +    object_initialize_child(OBJECT(s), "generic-sdhci",
> +                            &s->sdhci, TYPE_SYSBUS_SDHCI);
> +}
> +
> +static void cadence_sdhci_reset(DeviceState *dev)
> +{
> +    CadenceSDHCIState *s =3D CADENCE_SDHCI(dev);
> +
> +    memset(s->regs, 0, CADENCE_SDHCI_REG_SIZE);
> +    s->regs[TO_REG(CADENCE_SDHCI_HRS00)] =3D CADENCE_SDHCI_HRS00_POR_VAL=
;
> +
> +    device_cold_reset(DEVICE(&s->sdhci));
> +}
> +
> +static uint64_t cadence_sdhci_read(void *opaque, hwaddr addr, unsigned i=
nt size)
> +{
> +    CadenceSDHCIState *s =3D opaque;
> +    uint32_t val;
> +
> +    val =3D s->regs[TO_REG(addr)];
> +
> +    return (uint64_t)val;
> +}
> +
> +static void cadence_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
> +                                unsigned int size)
> +{
> +    CadenceSDHCIState *s =3D opaque;
> +    uint32_t val32 =3D (uint32_t)val;
> +
> +    switch (addr) {
> +    case CADENCE_SDHCI_HRS00:
> +        /*
> +         * The only writable bit is SWR (software reset) and it automati=
cally
> +         * clears to zero, so essentially this register remains unchange=
d.
> +         */
> +        if (val32 & CADENCE_SDHCI_HRS00_SWR) {
> +            cadence_sdhci_reset(DEVICE(s));
> +        }
> +
> +        break;
> +    case CADENCE_SDHCI_HRS04:
> +        /*
> +         * Only emulate the ACK bit behavior when read or write transact=
ion
> +         * are requested.
> +         */
> +        if (val32 & (CADENCE_SDHCI_HRS04_WR | CADENCE_SDHCI_HRS04_RD)) {
> +            val32 |=3D CADENCE_SDHCI_HRS04_ACK;
> +        } else {
> +            val32 &=3D ~CADENCE_SDHCI_HRS04_ACK;
> +        }
> +
> +        s->regs[TO_REG(addr)] =3D val32;
> +        break;
> +    case CADENCE_SDHCI_HRS06:
> +        if (val32 & CADENCE_SDHCI_HRS06_TUNE_UP) {
> +            val32 &=3D ~CADENCE_SDHCI_HRS06_TUNE_UP;
> +        }
> +
> +        s->regs[TO_REG(addr)] =3D val32;
> +        break;
> +    default:
> +        s->regs[TO_REG(addr)] =3D val32;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps cadence_sdhci_ops =3D {
> +    .read =3D cadence_sdhci_read,
> +    .write =3D cadence_sdhci_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    }
> +};
> +
> +static void cadence_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    CadenceSDHCIState *s =3D CADENCE_SDHCI(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    SysBusDevice *sbd_sdhci =3D SYS_BUS_DEVICE(&s->sdhci);
> +
> +    memory_region_init(&s->container, OBJECT(s),
> +                       "cadence.sdhci-container", 0x1000);
> +    sysbus_init_mmio(sbd, &s->container);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &cadence_sdhci_ops,
> +                          s, TYPE_CADENCE_SDHCI, CADENCE_SDHCI_REG_SIZE)=
;
> +    memory_region_add_subregion(&s->container, 0, &s->iomem);
> +
> +    sysbus_realize(sbd_sdhci, errp);
> +    memory_region_add_subregion(&s->container, CADENCE_SDHCI_SRS_BASE,
> +                                sysbus_mmio_get_region(sbd_sdhci, 0));
> +
> +    /* propagate irq and "sd-bus" from generic-sdhci */
> +    sysbus_pass_irq(sbd, sbd_sdhci);
> +    s->bus =3D qdev_get_child_bus(DEVICE(sbd_sdhci), "sd-bus");
> +}
> +
> +static const VMStateDescription vmstate_cadence_sdhci =3D {
> +    .name =3D TYPE_CADENCE_SDHCI,
> +    .version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, CadenceSDHCIState, CADENCE_SDHCI_NUM_=
REGS),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static void cadence_sdhci_class_init(ObjectClass *classp, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(classp);
> +
> +    dc->desc =3D "Cadence SD/SDIO/eMMC Host Controller (SD4HC)";
> +    dc->realize =3D cadence_sdhci_realize;
> +    dc->reset =3D cadence_sdhci_reset;
> +    dc->vmsd =3D &vmstate_cadence_sdhci;
> +}
> +
> +static TypeInfo cadence_sdhci_info =3D {
> +    .name          =3D TYPE_CADENCE_SDHCI,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(CadenceSDHCIState),
> +    .instance_init =3D cadence_sdhci_instance_init,
> +    .class_init    =3D cadence_sdhci_class_init,
> +};
> +
> +static void cadence_sdhci_register_types(void)
> +{
> +    type_register_static(&cadence_sdhci_info);
> +}
> +
> +type_init(cadence_sdhci_register_types)
> diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
> index c5e1e55..633b9af 100644
> --- a/hw/sd/Kconfig
> +++ b/hw/sd/Kconfig
> @@ -19,3 +19,7 @@ config SDHCI_PCI
>      default y if PCI_DEVICES
>      depends on PCI
>      select SDHCI
> +
> +config CADENCE_SDHCI
> +    bool
> +    select SDHCI
> diff --git a/hw/sd/meson.build b/hw/sd/meson.build
> index b43e59b..9c29691 100644
> --- a/hw/sd/meson.build
> +++ b/hw/sd/meson.build
> @@ -10,3 +10,4 @@ softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('p=
xa2xx_mmci.c'))
>  softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
>  softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c=
'))
>  softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sd=
host.c'))
> +softmmu_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdh=
ci.c'))
> --
> 2.7.4
>
>

