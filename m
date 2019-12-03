Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17926C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8E92080F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcNyh1b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8E92080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icF2a-0003eX-VE
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icEBz-0005SQ-NI
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icE41-0005Pf-Iy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:42:34 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132]:45118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1icE41-0004ti-45; Tue, 03 Dec 2019 14:42:25 -0500
Received: by mail-il1-x132.google.com with SMTP id p8so283979iln.12;
 Tue, 03 Dec 2019 11:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b+beXecnhfj+JkB7YzqTh8c1TSx+LJCxVTLV6WMXZik=;
 b=GcNyh1b2pDdakLjTXDoomoSRjTQ2xIzvyjO6jzZfBoRyIvNfb7iYgPx9fJnLSpXdYS
 fBU08mBgh6xRhREAYWBL0PhyLWFJ4Hp6bi/pgc5CpvmBSAfkBvjm8FoIL8DiUTKAyheu
 +fgfrKhBwHqeO1PX7wNvvzle7CPfB0nYWgv2Nkptlhb8iWDouJGKG5ERW3Zys8ymC5R1
 wdgo7ZHWqmTgDi+cqSX0NI3ADkj4J2SYTLYlZFKmptB47KrHALyT5UJWvjy2CWZSSa7k
 Ji3D/arYiTl47F8xsqGxRNBidOgEMB4zhEo7ILBBkZLXYnckTz9lPseifkiNsD2hpepx
 mIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b+beXecnhfj+JkB7YzqTh8c1TSx+LJCxVTLV6WMXZik=;
 b=KGInJQSdtFQ9Wcko49BRgnbikD32Mm7XG1UmfOZBLRG2pdu3mc0se60BfKz05wuHN5
 Fe/FHeKFWUYLnbGNqutM4VwVypEKS2C1If01cwqKQ27AtXU66J/rcdTe/q3DMRgk9kiM
 FAWbexhdnhHVrZzokAshwV+TBHJAleHxKY8z9X8ROGK4sHmpbyOGJG6NZINu7A0k62DB
 Rd+8lmvW7ghZDI30DtNeWwYgkFoDE8fKaekFPZRtqmoKBRolki3QoYVsZp4iw+BqJzNM
 b9g9ERduZI6yf2dcCdF0WR0Ezd/GIpmymyaPyFi8cyevwBsQkPLXDRqAA8wiprRUoX2R
 sUWw==
X-Gm-Message-State: APjAAAVa/aDYlv8O0KpHG4GOV6pLZVrb/h6G50Q8SyQklLkjovpfhzhQ
 jxdw7v+tqAElV0G+SRzKsuQTQ4jfPLEjxb62rKw=
X-Google-Smtp-Source: APXvYqwaP0ti2B+IOjSzWQXDmwNzeiQJ1UUGKHU8oP6ggtM3ZQb2FGP7SAttjyTvgGvss8g/1uPUy+ymv3pfrTqOH4g=
X-Received: by 2002:a92:af08:: with SMTP id n8mr6132015ili.217.1575402127837; 
 Tue, 03 Dec 2019 11:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-11-nieklinnenbank@gmail.com>
 <a234bebd-d794-7400-c9f8-77561ba46aa3@adacore.com>
In-Reply-To: <a234bebd-d794-7400-c9f8-77561ba46aa3@adacore.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 3 Dec 2019 20:41:56 +0100
Message-ID: <CAPan3WoeRA5LkgGUN2TYswWtVQMmQuHnkUYzBLa0F4t5AGd4yQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm: allwinner-h3: add EMAC ethernet device
To: KONRAD Frederic <frederic.konrad@adacore.com>
Content-Type: multipart/alternative; boundary="000000000000354d600598d1e4fc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::132
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
Cc: b.galvani@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000354d600598d1e4fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Frederic,

Thank you for your quick review comments!
I'll start working on v2 of the patches and include the changes you
suggested.

On Tue, Dec 3, 2019 at 10:33 AM KONRAD Frederic <frederic.konrad@adacore.co=
m>
wrote:

>
>
> Le 12/2/19 =C3=A0 10:09 PM, Niek Linnenbank a =C3=A9crit :
> > The Allwinner H3 System on Chip includes an Ethernet MAC (EMAC)
> > which provides 10M/100M/1000M Ethernet connectivity. This commit
> > adds support for the Allwinner H3 EMAC, including emulation for
> > the following functionality:
> >
> >   * DMA transfers
> >   * MII interface
> >   * Transmit CRC calculation
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > ---
> >   hw/arm/Kconfig                     |   1 +
> >   hw/arm/allwinner-h3.c              |  17 +
> >   hw/arm/orangepi.c                  |   7 +
> >   hw/net/Kconfig                     |   3 +
> >   hw/net/Makefile.objs               |   1 +
> >   hw/net/allwinner-h3-emac.c         | 786 ++++++++++++++++++++++++++++=
+
> >   hw/net/trace-events                |  10 +
> >   include/hw/arm/allwinner-h3.h      |   2 +
> >   include/hw/net/allwinner-h3-emac.h |  69 +++
> >   9 files changed, 896 insertions(+)
> >   create mode 100644 hw/net/allwinner-h3-emac.c
> >   create mode 100644 include/hw/net/allwinner-h3-emac.h
> >
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index ebf8d2325f..551cff3442 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -294,6 +294,7 @@ config ALLWINNER_A10
> >   config ALLWINNER_H3
> >       bool
> >       select ALLWINNER_A10_PIT
> > +    select ALLWINNER_H3_EMAC
> >       select SERIAL
> >       select ARM_TIMER
> >       select ARM_GIC
> > diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> > index c2972caf88..274b8548c0 100644
> > --- a/hw/arm/allwinner-h3.c
> > +++ b/hw/arm/allwinner-h3.c
> > @@ -53,6 +53,9 @@ static void aw_h3_init(Object *obj)
> >
> >       sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
> >                             TYPE_AW_H3_SDHOST);
> > +
> > +    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
> > +                          TYPE_AW_H3_EMAC);
> >   }
> >
> >   static void aw_h3_realize(DeviceState *dev, Error **errp)
> > @@ -237,6 +240,20 @@ static void aw_h3_realize(DeviceState *dev, Error
> **errp)
> >           return;
> >       }
> >
> > +    /* EMAC */
> > +    if (nd_table[0].used) {
> > +        qemu_check_nic_model(&nd_table[0], TYPE_AW_H3_EMAC);
> > +        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> > +    }
> > +    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err)=
;
> > +    if (err !=3D NULL) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    sysbusdev =3D SYS_BUS_DEVICE(&s->emac);
> > +    sysbus_mmio_map(sysbusdev, 0, AW_H3_EMAC_BASE);
> > +    sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SPI_EMAC]);
> > +
> >       /* Universal Serial Bus */
> >       sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
> >                            s->irq[AW_H3_GIC_SPI_EHCI0]);
> > diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> > index dee3efaf08..8a61eb0e69 100644
> > --- a/hw/arm/orangepi.c
> > +++ b/hw/arm/orangepi.c
> > @@ -61,6 +61,13 @@ static void orangepi_init(MachineState *machine)
> >           exit(1);
> >       }
> >
> > +    /* Setup EMAC properties */
> > +    object_property_set_int(OBJECT(&s->h3->emac), 1, "phy-addr", &err)=
;
> > +    if (err !=3D NULL) {
> > +        error_reportf_err(err, "Couldn't set phy address: ");
> > +        exit(1);
> > +    }
> > +
> >       /* Mark H3 object realized */
> >       object_property_set_bool(OBJECT(s->h3), true, "realized", &err);
> >       if (err !=3D NULL) {
> > diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> > index 3856417d42..36d3923992 100644
> > --- a/hw/net/Kconfig
> > +++ b/hw/net/Kconfig
> > @@ -74,6 +74,9 @@ config MIPSNET
> >   config ALLWINNER_EMAC
> >       bool
> >
> > +config ALLWINNER_H3_EMAC
> > +    bool
> > +
> >   config IMX_FEC
> >       bool
> >
> > diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> > index 7907d2c199..5548deb07a 100644
> > --- a/hw/net/Makefile.objs
> > +++ b/hw/net/Makefile.objs
> > @@ -23,6 +23,7 @@ common-obj-$(CONFIG_XGMAC) +=3D xgmac.o
> >   common-obj-$(CONFIG_MIPSNET) +=3D mipsnet.o
> >   common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axienet.o
> >   common-obj-$(CONFIG_ALLWINNER_EMAC) +=3D allwinner_emac.o
> > +common-obj-$(CONFIG_ALLWINNER_H3_EMAC) +=3D allwinner-h3-emac.o
> >   common-obj-$(CONFIG_IMX_FEC) +=3D imx_fec.o
> >
> >   common-obj-$(CONFIG_CADENCE) +=3D cadence_gem.o
> > diff --git a/hw/net/allwinner-h3-emac.c b/hw/net/allwinner-h3-emac.c
> > new file mode 100644
> > index 0000000000..37f6f44406
> > --- /dev/null
> > +++ b/hw/net/allwinner-h3-emac.c
> > @@ -0,0 +1,786 @@
> > +/*
> > + * Allwinner H3 EMAC emulation
> > + *
> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/sysbus.h"
> > +#include "migration/vmstate.h"
> > +#include "net/net.h"
> > +#include "hw/irq.h"
> > +#include "hw/qdev-properties.h"
> > +#include "qemu/log.h"
> > +#include "trace.h"
> > +#include "net/checksum.h"
> > +#include "qemu/module.h"
> > +#include "exec/cpu-common.h"
> > +#include "hw/net/allwinner-h3-emac.h"
> > +
> > +/* EMAC register offsets */
> > +#define REG_BASIC_CTL_0        (0x0000) /* Basic Control 0 */
> > +#define REG_BASIC_CTL_1        (0x0004) /* Basic Control 1 */
> > +#define REG_INT_STA            (0x0008) /* Interrupt Status */
> > +#define REG_INT_EN             (0x000C) /* Interrupt Enable */
> > +#define REG_TX_CTL_0           (0x0010) /* Transmit Control 0 */
> > +#define REG_TX_CTL_1           (0x0014) /* Transmit Control 1 */
> > +#define REG_TX_FLOW_CTL        (0x001C) /* Transmit Flow Control */
> > +#define REG_TX_DMA_DESC_LIST   (0x0020) /* Transmit Descriptor List
> Address */
> > +#define REG_RX_CTL_0           (0x0024) /* Receive Control 0 */
> > +#define REG_RX_CTL_1           (0x0028) /* Receive Control 1 */
> > +#define REG_RX_DMA_DESC_LIST   (0x0034) /* Receive Descriptor List
> Address */
> > +#define REG_FRM_FLT            (0x0038) /* Receive Frame Filter */
> > +#define REG_RX_HASH_0          (0x0040) /* Receive Hash Table 0 */
> > +#define REG_RX_HASH_1          (0x0044) /* Receive Hash Table 1 */
> > +#define REG_MII_CMD            (0x0048) /* Management Interface Comman=
d
> */
> > +#define REG_MII_DATA           (0x004C) /* Management Interface Data *=
/
> > +#define REG_ADDR_HIGH          (0x0050) /* MAC Address High */
> > +#define REG_ADDR_LOW           (0x0054) /* MAC Address Low */
> > +#define REG_TX_DMA_STA         (0x00B0) /* Transmit DMA Status */
> > +#define REG_TX_CUR_DESC        (0x00B4) /* Transmit Current Descriptor
> */
> > +#define REG_TX_CUR_BUF         (0x00B8) /* Transmit Current Buffer */
> > +#define REG_RX_DMA_STA         (0x00C0) /* Receive DMA Status */
> > +#define REG_RX_CUR_DESC        (0x00C4) /* Receive Current Descriptor =
*/
> > +#define REG_RX_CUR_BUF         (0x00C8) /* Receive Current Buffer */
> > +#define REG_RGMII_STA          (0x00D0) /* RGMII Status */
> > +
> > +/* EMAC register flags */
> > +#define BASIC_CTL0_100Mbps     (0b11 << 2)
> > +#define BASIC_CTL0_FD          (1 << 0)
> > +#define BASIC_CTL1_SOFTRST     (1 << 0)
> > +
> > +#define INT_STA_RGMII_LINK     (1 << 16)
> > +#define INT_STA_RX_EARLY       (1 << 13)
> > +#define INT_STA_RX_OVERFLOW    (1 << 12)
> > +#define INT_STA_RX_TIMEOUT     (1 << 11)
> > +#define INT_STA_RX_DMA_STOP    (1 << 10)
> > +#define INT_STA_RX_BUF_UA      (1 << 9)
> > +#define INT_STA_RX             (1 << 8)
> > +#define INT_STA_TX_EARLY       (1 << 5)
> > +#define INT_STA_TX_UNDERFLOW   (1 << 4)
> > +#define INT_STA_TX_TIMEOUT     (1 << 3)
> > +#define INT_STA_TX_BUF_UA      (1 << 2)
> > +#define INT_STA_TX_DMA_STOP    (1 << 1)
> > +#define INT_STA_TX             (1 << 0)
> > +
> > +#define INT_EN_RX_EARLY        (1 << 13)
> > +#define INT_EN_RX_OVERFLOW     (1 << 12)
> > +#define INT_EN_RX_TIMEOUT      (1 << 11)
> > +#define INT_EN_RX_DMA_STOP     (1 << 10)
> > +#define INT_EN_RX_BUF_UA       (1 << 9)
> > +#define INT_EN_RX              (1 << 8)
> > +#define INT_EN_TX_EARLY        (1 << 5)
> > +#define INT_EN_TX_UNDERFLOW    (1 << 4)
> > +#define INT_EN_TX_TIMEOUT      (1 << 3)
> > +#define INT_EN_TX_BUF_UA       (1 << 2)
> > +#define INT_EN_TX_DMA_STOP     (1 << 1)
> > +#define INT_EN_TX              (1 << 0)
> > +
> > +#define TX_CTL0_TX_EN          (1 << 31)
> > +#define TX_CTL1_TX_DMA_START   (1 << 31)
> > +#define TX_CTL1_TX_DMA_EN      (1 << 30)
> > +#define TX_CTL1_TX_FLUSH       (1 << 0)
> > +
> > +#define RX_CTL0_RX_EN          (1 << 31)
> > +#define RX_CTL0_STRIP_FCS      (1 << 28)
> > +#define RX_CTL0_CRC_IPV4       (1 << 27)
> > +
> > +#define RX_CTL1_RX_DMA_START   (1 << 31)
> > +#define RX_CTL1_RX_DMA_EN      (1 << 30)
> > +#define RX_CTL1_RX_MD          (1 << 1)
> > +
> > +#define RX_FRM_FLT_DIS_ADDR    (1 << 31)
> > +
> > +#define MII_CMD_PHY_ADDR_SHIFT (12)
> > +#define MII_CMD_PHY_ADDR_MASK  (0xf000)
> > +#define MII_CMD_PHY_REG_SHIFT  (4)
> > +#define MII_CMD_PHY_REG_MASK   (0xf0)
> > +#define MII_CMD_PHY_RW         (1 << 1)
> > +#define MII_CMD_PHY_BUSY       (1 << 0)
> > +
> > +#define TX_DMA_STA_STOP        (0b000)
> > +#define TX_DMA_STA_RUN_FETCH   (0b001)
> > +#define TX_DMA_STA_WAIT_STA    (0b010)
> > +
> > +#define RX_DMA_STA_STOP        (0b000)
> > +#define RX_DMA_STA_RUN_FETCH   (0b001)
> > +#define RX_DMA_STA_WAIT_FRM    (0b011)
> > +
> > +#define RGMII_LINK_UP          (1 << 3)
> > +#define RGMII_FD               (1 << 0)
> > +
> > +/* EMAC register reset values */
> > +#define REG_BASIC_CTL_1_RST    (0x08000000)
> > +
> > +/* EMAC constants */
> > +#define AW_H3_EMAC_MIN_PKT_SZ  (64)
> > +
> > +/* Transmit/receive frame descriptor */
> > +typedef struct FrameDescriptor {
> > +    uint32_t status;
> > +    uint32_t status2;
> > +    uint32_t addr;
> > +    uint32_t next;
> > +} FrameDescriptor;
> > +
> > +/* Frame descriptor flags */
> > +#define DESC_STATUS_CTL                 (1 << 31)
> > +#define DESC_STATUS2_BUF_SIZE_MASK      (0x7ff)
> > +
> > +/* Transmit frame descriptor flags */
> > +#define TX_DESC_STATUS_LENGTH_ERR       (1 << 14)
> > +#define TX_DESC_STATUS2_FIRST_DESC      (1 << 29)
> > +#define TX_DESC_STATUS2_LAST_DESC       (1 << 30)
> > +#define TX_DESC_STATUS2_CHECKSUM_MASK   (0x3 << 27)
> > +
> > +/* Receive frame descriptor flags */
> > +#define RX_DESC_STATUS_FIRST_DESC       (1 << 9)
> > +#define RX_DESC_STATUS_LAST_DESC        (1 << 8)
> > +#define RX_DESC_STATUS_FRM_LEN_MASK     (0x3fff0000)
> > +#define RX_DESC_STATUS_FRM_LEN_SHIFT    (16)
> > +#define RX_DESC_STATUS_NO_BUF           (1 << 14)
> > +#define RX_DESC_STATUS_HEADER_ERR       (1 << 7)
> > +#define RX_DESC_STATUS_LENGTH_ERR       (1 << 4)
> > +#define RX_DESC_STATUS_CRC_ERR          (1 << 1)
> > +#define RX_DESC_STATUS_PAYLOAD_ERR      (1 << 0)
> > +#define RX_DESC_STATUS2_RX_INT_CTL      (1 << 31)
> > +
> > +/* MII register offsets */
> > +#define MII_REG_CR                      (0x0)
> > +#define MII_REG_ST                      (0x1)
> > +#define MII_REG_ID_HIGH                 (0x2)
> > +#define MII_REG_ID_LOW                  (0x3)
> > +
> > +/* MII register flags */
> > +#define MII_REG_CR_RESET                (1 << 15)
> > +#define MII_REG_CR_POWERDOWN            (1 << 11)
> > +#define MII_REG_CR_10Mbit               (0)
> > +#define MII_REG_CR_100Mbit              (1 << 13)
> > +#define MII_REG_CR_1000Mbit             (1 << 6)
> > +#define MII_REG_CR_AUTO_NEG             (1 << 12)
> > +#define MII_REG_CR_AUTO_NEG_RESTART     (1 << 9)
> > +#define MII_REG_CR_FULLDUPLEX           (1 << 8)
> > +
> > +#define MII_REG_ST_100BASE_T4           (1 << 15)
> > +#define MII_REG_ST_100BASE_X_FD         (1 << 14)
> > +#define MII_REG_ST_100BASE_X_HD         (1 << 13)
> > +#define MII_REG_ST_10_FD                (1 << 12)
> > +#define MII_REG_ST_10_HD                (1 << 11)
> > +#define MII_REG_ST_100BASE_T2_FD        (1 << 10)
> > +#define MII_REG_ST_100BASE_T2_HD        (1 << 9)
> > +#define MII_REG_ST_AUTONEG_COMPLETE     (1 << 5)
> > +#define MII_REG_ST_AUTONEG_AVAIL        (1 << 3)
> > +#define MII_REG_ST_LINK_UP              (1 << 2)
> > +
> > +/* MII constants */
> > +#define MII_PHY_ID_HIGH                 (0x0044)
> > +#define MII_PHY_ID_LOW                  (0x1400)
>
> I wonder if we can't share all those mii stuff accross the network adapte=
rs
> instead of redoing the work everytime. I've some patches about it I may
> post
> them sometimes.
>
>
Indeed, that would be a nice improvement. In fact, I was looking for
somekind of
MII library inside QEMU and could not find it. Then I saw that the other
emulated ethernet cards
all have that code inside each file, so that is why I did the same here.


> > +
> > +static void aw_h3_emac_mii_set_link(AwH3EmacState *s, bool link_active=
)
> > +{
> > +    if (link_active) {
> > +        s->mii_st |=3D MII_REG_ST_LINK_UP;
> > +    } else {
> > +        s->mii_st &=3D ~MII_REG_ST_LINK_UP;
> > +    }
> > +}
> > +
> > +static void aw_h3_emac_mii_reset(AwH3EmacState *s, bool link_active)
> > +{
> > +    s->mii_cr =3D MII_REG_CR_100Mbit | MII_REG_CR_AUTO_NEG |
> > +                MII_REG_CR_FULLDUPLEX;
> > +    s->mii_st =3D MII_REG_ST_100BASE_T4 | MII_REG_ST_100BASE_X_FD |
> > +                MII_REG_ST_100BASE_X_HD | MII_REG_ST_10_FD |
> MII_REG_ST_10_HD |
> > +                MII_REG_ST_100BASE_T2_FD | MII_REG_ST_100BASE_T2_HD |
> > +                MII_REG_ST_AUTONEG_COMPLETE | MII_REG_ST_AUTONEG_AVAIL=
;
> > +
> > +    aw_h3_emac_mii_set_link(s, link_active);
> > +}
> > +
> > +static void aw_h3_emac_mii_cmd(AwH3EmacState *s)
> > +{
> > +    uint8_t addr, reg;
> > +
> > +    addr =3D (s->mii_cmd & MII_CMD_PHY_ADDR_MASK) >>
> MII_CMD_PHY_ADDR_SHIFT;
> > +    reg =3D (s->mii_cmd & MII_CMD_PHY_REG_MASK) >> MII_CMD_PHY_REG_SHI=
FT;
> > +
> > +    if (addr !=3D s->mii_phy_addr) {
> > +        return;
> > +    }
> > +
> > +    /* Read or write a PHY register? */
> > +    if (s->mii_cmd & MII_CMD_PHY_RW) {
> > +        trace_aw_h3_emac_mii_write_reg(reg, s->mii_data);
> > +
> > +        switch (reg) {
> > +        case MII_REG_CR:
> > +            if (s->mii_data & MII_REG_CR_RESET) {
> > +                aw_h3_emac_mii_reset(s, s->mii_st & MII_REG_ST_LINK_UP=
);
> > +            } else {
> > +                s->mii_cr =3D s->mii_data & ~(MII_REG_CR_RESET |
> > +
> MII_REG_CR_AUTO_NEG_RESTART);
> > +            }
> > +            break;
> > +        default:
> > +            qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: write access
> to "
> > +                                     "unknown MII register 0x%x\n",
> reg);
> > +            break;
> > +        }
> > +    } else {
> > +        switch (reg) {
> > +        case MII_REG_CR:
> > +            s->mii_data =3D s->mii_cr;
> > +            break;
> > +        case MII_REG_ST:
> > +            s->mii_data =3D s->mii_st;
> > +            break;
> > +        case MII_REG_ID_HIGH:
> > +            s->mii_data =3D MII_PHY_ID_HIGH;
> > +            break;
> > +        case MII_REG_ID_LOW:
> > +            s->mii_data =3D MII_PHY_ID_LOW;
> > +            break;
> > +        default:
> > +            qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: read access t=
o
> "
> > +                                     "unknown MII register 0x%x\n",
> reg);
> > +            s->mii_data =3D 0;
> > +            break;
> > +        }
> > +
> > +        trace_aw_h3_emac_mii_read_reg(reg, s->mii_data);
> > +    }
> > +}
> > +
> > +static void aw_h3_emac_update_irq(AwH3EmacState *s)
> > +{
> > +    qemu_set_irq(s->irq, (s->int_sta & s->int_en) !=3D 0);
> > +}
> > +
> > +static uint32_t aw_h3_emac_next_desc(FrameDescriptor *desc, size_t
> min_size)
> > +{
> > +    uint32_t paddr =3D desc->next;
> > +
> > +    cpu_physical_memory_read(paddr, desc, sizeof(*desc));
> > +
> > +    if ((desc->status & DESC_STATUS_CTL) &&
> > +        (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >=3D min_size) {
> > +        return paddr;
> > +    } else {
> > +        return 0;
> > +    }
> > +}
> > +
> > +static uint32_t aw_h3_emac_get_desc(FrameDescriptor *desc, uint32_t
> start_addr,
> > +                                    size_t min_size)
> > +{
> > +    uint32_t desc_addr =3D start_addr;
> > +
> > +    /* Note that the list is a cycle. Last entry points back to the
> head. */
> > +    while (desc_addr !=3D 0) {
> > +        cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
> > +
> > +        if ((desc->status & DESC_STATUS_CTL) &&
> > +            (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >=3D min_size=
) {
> > +            return desc_addr;
> > +        } else if (desc->next =3D=3D start_addr) {
> > +            break;
> > +        } else {
> > +            desc_addr =3D desc->next;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static uint32_t aw_h3_emac_get_rx_desc(AwH3EmacState *s,
> FrameDescriptor *desc,
> > +                                       size_t min_size)
> > +{
> > +    return aw_h3_emac_get_desc(desc, s->rx_desc_curr, min_size);
> > +}
> > +
> > +static uint32_t aw_h3_emac_get_tx_desc(AwH3EmacState *s,
> FrameDescriptor *desc,
> > +                                       size_t min_size)
> > +{
> > +    return aw_h3_emac_get_desc(desc, s->tx_desc_head, min_size);
> > +}
> > +
> > +static void aw_h3_emac_flush_desc(FrameDescriptor *desc, uint32_t
> phys_addr)
> > +{
> > +    cpu_physical_memory_write(phys_addr, desc, sizeof(*desc));
> > +}
> > +
> > +static int aw_h3_emac_can_receive(NetClientState *nc)
> > +{
> > +    AwH3EmacState *s =3D qemu_get_nic_opaque(nc);
> > +    FrameDescriptor desc;
> > +
> > +    return (s->rx_ctl0 & RX_CTL0_RX_EN) &&
> > +           (aw_h3_emac_get_rx_desc(s, &desc, 0) !=3D 0);
> > +}
> > +
> > +static ssize_t aw_h3_emac_receive(NetClientState *nc, const uint8_t
> *buf,
> > +                                  size_t size)
> > +{
> > +    AwH3EmacState *s =3D qemu_get_nic_opaque(nc);
> > +    FrameDescriptor desc;
> > +    size_t bytes_left =3D size;
> > +    size_t desc_bytes =3D 0;
> > +    size_t pad_fcs_size =3D 4;
> > +    size_t padding =3D 0;
> > +
> > +    if (!(s->rx_ctl0 & RX_CTL0_RX_EN)) {
> > +        return -1;
> > +    }
> > +
> > +    s->rx_desc_curr =3D aw_h3_emac_get_rx_desc(s, &desc,
> AW_H3_EMAC_MIN_PKT_SZ);
> > +    if (!s->rx_desc_curr) {
> > +        s->int_sta |=3D INT_STA_RX_BUF_UA;
> > +    }
> > +
> > +    /* Keep filling RX descriptors until the whole frame is written */
> > +    while (s->rx_desc_curr && bytes_left > 0) {
> > +        desc.status &=3D ~DESC_STATUS_CTL;
> > +        desc.status &=3D ~RX_DESC_STATUS_FRM_LEN_MASK;
> > +
> > +        if (bytes_left =3D=3D size) {
> > +            desc.status |=3D RX_DESC_STATUS_FIRST_DESC;
> > +        }
> > +
> > +        if ((desc.status2 & DESC_STATUS2_BUF_SIZE_MASK) <
> > +            (bytes_left + pad_fcs_size)) {
> > +            desc_bytes =3D desc.status2 & DESC_STATUS2_BUF_SIZE_MASK;
> > +            desc.status |=3D desc_bytes << RX_DESC_STATUS_FRM_LEN_SHIF=
T;
> > +        } else {
> > +            padding =3D pad_fcs_size;
> > +            if (bytes_left < AW_H3_EMAC_MIN_PKT_SZ) {
> > +                padding +=3D (AW_H3_EMAC_MIN_PKT_SZ - bytes_left);
> > +            }
> > +
> > +            desc_bytes =3D (bytes_left);
> > +            desc.status |=3D RX_DESC_STATUS_LAST_DESC;
> > +            desc.status |=3D (bytes_left + padding)
> > +                            << RX_DESC_STATUS_FRM_LEN_SHIFT;
> > +        }
> > +
> > +        cpu_physical_memory_write(desc.addr, buf, desc_bytes);
> > +        aw_h3_emac_flush_desc(&desc, s->rx_desc_curr);
> > +        trace_aw_h3_emac_receive(s->rx_desc_curr, desc.addr,
> desc_bytes);
> > +
> > +        /* Check if frame needs to raise the receive interrupt */
> > +        if (!(desc.status2 & RX_DESC_STATUS2_RX_INT_CTL)) {
> > +            s->int_sta |=3D INT_STA_RX;
> > +        }
> > +
> > +        /* Increment variables */
> > +        buf +=3D desc_bytes;
> > +        bytes_left -=3D desc_bytes;
> > +
> > +        /* Move to the next descriptor */
> > +        s->rx_desc_curr =3D aw_h3_emac_next_desc(&desc, 64);
> > +        if (!s->rx_desc_curr) {
> > +            /* Not enough buffer space available */
> > +            s->int_sta |=3D INT_STA_RX_BUF_UA;
> > +            s->rx_desc_curr =3D s->rx_desc_head;
> > +            break;
> > +        }
> > +    }
> > +
> > +    /* Report receive DMA is finished */
> > +    s->rx_ctl1 &=3D ~RX_CTL1_RX_DMA_START;
> > +    aw_h3_emac_update_irq(s);
> > +
> > +    return size;
> > +}
> > +
> > +static void aw_h3_emac_transmit(AwH3EmacState *s)
> > +{
> > +    NetClientState *nc =3D qemu_get_queue(s->nic);
> > +    FrameDescriptor desc;
> > +    size_t bytes =3D 0;
> > +    size_t packet_bytes =3D 0;
> > +    size_t transmitted =3D 0;
> > +    static uint8_t packet_buf[2048];
> > +
> > +    s->tx_desc_curr =3D aw_h3_emac_get_tx_desc(s, &desc, 0);
> > +
> > +    /* Read all transmit descriptors */
> > +    while (s->tx_desc_curr !=3D 0) {
> > +
> > +        /* Read from physical memory into packet buffer */
> > +        bytes =3D desc.status2 & DESC_STATUS2_BUF_SIZE_MASK;
> > +        if (bytes + packet_bytes > sizeof(packet_buf)) {
> > +            desc.status |=3D TX_DESC_STATUS_LENGTH_ERR;
> > +            break;
> > +        }
> > +        cpu_physical_memory_read(desc.addr, packet_buf + packet_bytes,
> bytes);
> > +        packet_bytes +=3D bytes;
> > +        desc.status &=3D ~DESC_STATUS_CTL;
> > +        aw_h3_emac_flush_desc(&desc, s->tx_desc_curr);
> > +
> > +        /* After the last descriptor, send the packet */
> > +        if (desc.status2 & TX_DESC_STATUS2_LAST_DESC) {
> > +            if (desc.status2 & TX_DESC_STATUS2_CHECKSUM_MASK) {
> > +                net_checksum_calculate(packet_buf, packet_bytes);
> > +            }
> > +
> > +            qemu_send_packet(nc, packet_buf, packet_bytes);
> > +            trace_aw_h3_emac_transmit(s->tx_desc_curr, desc.addr,
> bytes);
> > +
> > +            packet_bytes =3D 0;
> > +            transmitted++;
> > +        }
> > +        s->tx_desc_curr =3D aw_h3_emac_next_desc(&desc, 0);
> > +    }
> > +
> > +    /* Raise transmit completed interrupt */
> > +    if (transmitted > 0) {
> > +        s->int_sta |=3D INT_STA_TX;
> > +        s->tx_ctl1 &=3D ~TX_CTL1_TX_DMA_START;
> > +        aw_h3_emac_update_irq(s);
> > +    }
> > +}
> > +
> > +static void aw_h3_emac_reset(DeviceState *dev)
> > +{
> > +    AwH3EmacState *s =3D AW_H3_EMAC(dev);
> > +    NetClientState *nc =3D qemu_get_queue(s->nic);
> > +
> > +    trace_aw_h3_emac_reset();
> > +
> > +    s->mii_cmd =3D 0;
> > +    s->mii_data =3D 0;
> > +    s->basic_ctl0 =3D 0;
> > +    s->basic_ctl1 =3D 0;
> > +    s->int_en =3D 0;
> > +    s->int_sta =3D 0;
> > +    s->frm_flt =3D 0;
> > +    s->rx_ctl0 =3D 0;
> > +    s->rx_ctl1 =3D RX_CTL1_RX_MD;
> > +    s->rx_desc_head =3D 0;
> > +    s->rx_desc_curr =3D 0;
> > +    s->tx_ctl0 =3D 0;
> > +    s->tx_ctl1 =3D 0;
> > +    s->tx_desc_head =3D 0;
> > +    s->tx_desc_curr =3D 0;
> > +    s->tx_flowctl =3D 0;
> > +
> > +    aw_h3_emac_mii_reset(s, !nc->link_down);
> > +}
> > +
> > +static uint64_t aw_h3_emac_read(void *opaque, hwaddr offset, unsigned
> size)
> > +{
> > +    AwH3EmacState *s =3D opaque;
>
> I'd put AW_H3_EMAC(opaque) here.
>
> > +    uint64_t value =3D 0;
> > +    FrameDescriptor desc;
> > +
> > +    switch (offset) {
> > +    case REG_BASIC_CTL_0:       /* Basic Control 0 */
> > +        value =3D s->basic_ctl0;
> > +        break;
> > +    case REG_BASIC_CTL_1:       /* Basic Control 1 */
> > +        value =3D s->basic_ctl1;
> > +        break;
> > +    case REG_INT_STA:           /* Interrupt Status */
> > +        value =3D s->int_sta;
> > +        break;
> > +    case REG_INT_EN:            /* Interupt Enable */
> > +        value =3D s->int_en;
> > +        break;
> > +    case REG_TX_CTL_0:          /* Transmit Control 0 */
> > +        value =3D s->tx_ctl0;
> > +        break;
> > +    case REG_TX_CTL_1:          /* Transmit Control 1 */
> > +        value =3D s->tx_ctl1;
> > +        break;
> > +    case REG_TX_FLOW_CTL:       /* Transmit Flow Control */
> > +        value =3D s->tx_flowctl;
> > +        break;
> > +    case REG_TX_DMA_DESC_LIST:  /* Transmit Descriptor List Address */
> > +        value =3D s->tx_desc_head;
> > +        break;
> > +    case REG_RX_CTL_0:          /* Receive Control 0 */
> > +        value =3D s->rx_ctl0;
> > +        break;
> > +    case REG_RX_CTL_1:          /* Receive Control 1 */
> > +        value =3D s->rx_ctl1;
> > +        break;
> > +    case REG_RX_DMA_DESC_LIST:  /* Receive Descriptor List Address */
> > +        value =3D s->rx_desc_head;
> > +        break;
> > +    case REG_FRM_FLT:           /* Receive Frame Filter */
> > +        value =3D s->frm_flt;
> > +        break;
> > +    case REG_RX_HASH_0:         /* Receive Hash Table 0 */
> > +    case REG_RX_HASH_1:         /* Receive Hash Table 1 */
> > +        break;
> > +    case REG_MII_CMD:           /* Management Interface Command */
> > +        value =3D s->mii_cmd;
> > +        break;
> > +    case REG_MII_DATA:          /* Management Interface Data */
> > +        value =3D s->mii_data;
> > +        break;
> > +    case REG_ADDR_HIGH:         /* MAC Address High */
> > +        value =3D *(((uint32_t *) (s->conf.macaddr.a)) + 1);
> > +        break;
> > +    case REG_ADDR_LOW:          /* MAC Address Low */
> > +        value =3D *(uint32_t *) (s->conf.macaddr.a);
> > +        break;
> > +    case REG_TX_DMA_STA:        /* Transmit DMA Status */
> > +        break;
> > +    case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
> > +        value =3D s->tx_desc_curr;
> > +        break;
> > +    case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
> > +        if (s->tx_desc_curr !=3D 0) {
> > +            cpu_physical_memory_read(s->tx_desc_curr, &desc,
> sizeof(desc));
> > +            value =3D desc.addr;
> > +        } else {
> > +            value =3D 0;
> > +        }
> > +        break;
> > +    case REG_RX_DMA_STA:        /* Receive DMA Status */
> > +        break;
> > +    case REG_RX_CUR_DESC:       /* Receive Current Descriptor */
> > +        value =3D s->rx_desc_curr;
> > +        break;
> > +    case REG_RX_CUR_BUF:        /* Receive Current Buffer */
> > +        if (s->rx_desc_curr !=3D 0) {
> > +            cpu_physical_memory_read(s->rx_desc_curr, &desc,
> sizeof(desc));
> > +            value =3D desc.addr;
> > +        } else {
> > +            value =3D 0;
> > +        }
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: read access to
> unknown "
> > +                                 "EMAC register 0x" TARGET_FMT_plx "\n=
",
> > +                                  offset);
> > +    }
> > +
> > +    trace_aw_h3_emac_read(offset, value);
> > +    return value;
> > +}
> > +
> > +static void aw_h3_emac_write(void *opaque, hwaddr offset, uint64_t
> value,
> > +                             unsigned size)
> > +{
> > +    AwH3EmacState *s =3D opaque;
>
> The same.
>
> > +    NetClientState *nc =3D qemu_get_queue(s->nic);
> > +
> > +    trace_aw_h3_emac_write(offset, value);
> > +
> > +    switch (offset) {
> > +    case REG_BASIC_CTL_0:       /* Basic Control 0 */
> > +        s->basic_ctl0 =3D value;
> > +        break;
> > +    case REG_BASIC_CTL_1:       /* Basic Control 1 */
> > +        if (value & BASIC_CTL1_SOFTRST) {
> > +            aw_h3_emac_reset(DEVICE(s));
> > +            value &=3D ~BASIC_CTL1_SOFTRST;
> > +        }
> > +        s->basic_ctl1 =3D value;
> > +        if (aw_h3_emac_can_receive(nc)) {
> > +            qemu_flush_queued_packets(nc);
> > +        }
> > +        break;
> > +    case REG_INT_STA:           /* Interrupt Status */
> > +        s->int_sta &=3D ~value;
> > +        aw_h3_emac_update_irq(s);
> > +        break;
> > +    case REG_INT_EN:            /* Interrupt Enable */
> > +        s->int_en =3D value;
> > +        aw_h3_emac_update_irq(s);
> > +        break;
> > +    case REG_TX_CTL_0:          /* Transmit Control 0 */
> > +        s->tx_ctl0 =3D value;
> > +        break;
> > +    case REG_TX_CTL_1:          /* Transmit Control 1 */
> > +        s->tx_ctl1 =3D value;
> > +        if (value & TX_CTL1_TX_DMA_EN) {
> > +            aw_h3_emac_transmit(s);
> > +        }
> > +        break;
> > +    case REG_TX_FLOW_CTL:       /* Transmit Flow Control */
> > +        s->tx_flowctl =3D value;
> > +        break;
> > +    case REG_TX_DMA_DESC_LIST:  /* Transmit Descriptor List Address */
> > +        s->tx_desc_head =3D value;
> > +        s->tx_desc_curr =3D value;
> > +        break;
> > +    case REG_RX_CTL_0:          /* Receive Control 0 */
> > +        s->rx_ctl0 =3D value;
> > +        break;
> > +    case REG_RX_CTL_1:          /* Receive Control 1 */
> > +        s->rx_ctl1 =3D value | RX_CTL1_RX_MD;
> > +        if ((value & RX_CTL1_RX_DMA_EN) && aw_h3_emac_can_receive(nc))=
 {
> > +            qemu_flush_queued_packets(nc);
> > +        }
> > +        break;
> > +    case REG_RX_DMA_DESC_LIST:  /* Receive Descriptor List Address */
> > +        s->rx_desc_head =3D value;
> > +        s->rx_desc_curr =3D value;
> > +        break;
> > +    case REG_FRM_FLT:           /* Receive Frame Filter */
> > +        s->frm_flt =3D value;
> > +        break;
> > +    case REG_RX_HASH_0:         /* Receive Hash Table 0 */
> > +    case REG_RX_HASH_1:         /* Receive Hash Table 1 */
> > +        break;
> > +    case REG_MII_CMD:           /* Management Interface Command */
> > +        s->mii_cmd =3D value & ~MII_CMD_PHY_BUSY;
> > +        aw_h3_emac_mii_cmd(s);
> > +        break;
> > +    case REG_MII_DATA:          /* Management Interface Data */
> > +        s->mii_data =3D value;
> > +        break;
> > +    case REG_ADDR_HIGH:         /* MAC Address High */
> > +        s->conf.macaddr.a[4] =3D (value & 0xff);
> > +        s->conf.macaddr.a[5] =3D (value & 0xff00) >> 8;
> > +        break;
> > +    case REG_ADDR_LOW:          /* MAC Address Low */
> > +        s->conf.macaddr.a[0] =3D (value & 0xff);
> > +        s->conf.macaddr.a[1] =3D (value & 0xff00) >> 8;
> > +        s->conf.macaddr.a[2] =3D (value & 0xff0000) >> 16;
> > +        s->conf.macaddr.a[3] =3D (value & 0xff000000) >> 24;
> > +        break;
> > +    case REG_TX_DMA_STA:        /* Transmit DMA Status */
> > +    case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
> > +    case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
> > +    case REG_RX_DMA_STA:        /* Receive DMA Status */
> > +    case REG_RX_CUR_DESC:       /* Receive Current Descriptor */
> > +    case REG_RX_CUR_BUF:        /* Receive Current Buffer */
> > +    case REG_RGMII_STA:         /* RGMII Status */
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: write access to
> unknown "
> > +                                 "EMAC register 0x" TARGET_FMT_plx "\n=
",
> > +                                  offset);
> > +    }
> > +}
> > +
> > +static void aw_h3_emac_set_link(NetClientState *nc)
> > +{
> > +    AwH3EmacState *s =3D qemu_get_nic_opaque(nc);
> > +
> > +    trace_aw_h3_emac_set_link(!nc->link_down);
> > +    aw_h3_emac_mii_set_link(s, !nc->link_down);
> > +}
> > +
> > +static const MemoryRegionOps aw_h3_emac_mem_ops =3D {
> > +    .read =3D aw_h3_emac_read,
> > +    .write =3D aw_h3_emac_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static NetClientInfo net_aw_h3_emac_info =3D {
> > +    .type =3D NET_CLIENT_DRIVER_NIC,
> > +    .size =3D sizeof(NICState),
> > +    .can_receive =3D aw_h3_emac_can_receive,
> > +    .receive =3D aw_h3_emac_receive,
> > +    .link_status_changed =3D aw_h3_emac_set_link,
> > +};
> > +
> > +static void aw_h3_emac_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    AwH3EmacState *s =3D AW_H3_EMAC(obj);
> > +
> > +    memory_region_init_io(&s->iomem, OBJECT(s), &aw_h3_emac_mem_ops, s=
,
> > +                          TYPE_AW_H3_EMAC, AW_H3_EMAC_REGS_MEM_SIZE);
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +    sysbus_init_irq(sbd, &s->irq);
> > +}
> > +
> > +static void aw_h3_emac_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AwH3EmacState *s =3D AW_H3_EMAC(dev);
> > +
> > +    qemu_macaddr_default_if_unset(&s->conf.macaddr);
> > +    s->nic =3D qemu_new_nic(&net_aw_h3_emac_info, &s->conf,
> > +                          object_get_typename(OBJECT(dev)), dev->id, s=
);
> > +    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a=
);
> > +}
> > +
> > +static Property aw_h3_emac_properties[] =3D {
> > +    DEFINE_NIC_PROPERTIES(AwH3EmacState, conf),
> > +    DEFINE_PROP_UINT8("phy-addr", AwH3EmacState, mii_phy_addr, 0),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static int aw_h3_emac_post_load(void *opaque, int version_id)
> > +{
> > +    AwH3EmacState *s =3D opaque;
> > +
> > +    aw_h3_emac_set_link(qemu_get_queue(s->nic));
> > +
> > +    return 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_aw_emac =3D {
> > +    .name =3D TYPE_AW_H3_EMAC,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .post_load =3D aw_h3_emac_post_load,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT8(mii_phy_addr, AwH3EmacState),
> > +        VMSTATE_UINT32(mii_cmd, AwH3EmacState),
> > +        VMSTATE_UINT32(mii_data, AwH3EmacState),
> > +        VMSTATE_UINT32(basic_ctl0, AwH3EmacState),
> > +        VMSTATE_UINT32(basic_ctl1, AwH3EmacState),
> > +        VMSTATE_UINT32(int_en, AwH3EmacState),
> > +        VMSTATE_UINT32(int_sta, AwH3EmacState),
> > +        VMSTATE_UINT32(frm_flt, AwH3EmacState),
> > +        VMSTATE_UINT32(rx_ctl0, AwH3EmacState),
> > +        VMSTATE_UINT32(rx_ctl1, AwH3EmacState),
> > +        VMSTATE_UINT32(rx_desc_head, AwH3EmacState),
> > +        VMSTATE_UINT32(rx_desc_curr, AwH3EmacState),
> > +        VMSTATE_UINT32(tx_ctl0, AwH3EmacState),
> > +        VMSTATE_UINT32(tx_ctl1, AwH3EmacState),
> > +        VMSTATE_UINT32(tx_desc_head, AwH3EmacState),
> > +        VMSTATE_UINT32(tx_desc_curr, AwH3EmacState),
> > +        VMSTATE_UINT32(tx_flowctl, AwH3EmacState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void aw_h3_emac_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D aw_h3_emac_realize;
> > +    dc->props =3D aw_h3_emac_properties;
> > +    dc->reset =3D aw_h3_emac_reset;
> > +    dc->vmsd =3D &vmstate_aw_emac;
> > +}
> > +
> > +static const TypeInfo aw_h3_emac_info =3D {
> > +    .name           =3D TYPE_AW_H3_EMAC,
> > +    .parent         =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size  =3D sizeof(AwH3EmacState),
> > +    .instance_init  =3D aw_h3_emac_init,
> > +    .class_init     =3D aw_h3_emac_class_init,
> > +};
> > +
> > +static void aw_h3_emac_register_types(void)
> > +{
> > +    type_register_static(&aw_h3_emac_info);
> > +}
> > +
> > +type_init(aw_h3_emac_register_types)
> > diff --git a/hw/net/trace-events b/hw/net/trace-events
> > index e70f12bee1..e9e2f26f68 100644
> > --- a/hw/net/trace-events
> > +++ b/hw/net/trace-events
> > @@ -1,5 +1,15 @@
> >   # See docs/devel/tracing.txt for syntax documentation.
> >
> > +# allwinner-h3-emac.c
> > +aw_h3_emac_mii_write_reg(uint32_t reg, uint32_t value) "MII write:
> reg=3D0x%x value=3D0x%x"
> > +aw_h3_emac_mii_read_reg(uint32_t reg, uint32_t value) "MII read:
> reg=3D0x%x value=3D0x%x"
> > +aw_h3_emac_receive(uint32_t desc, uint32_t paddr, uint32_t bytes) "RX
> packet: desc=3D0x%08x paddr=3D0x%08x bytes=3D%u"
> > +aw_h3_emac_transmit(uint32_t desc, uint32_t paddr, uint32_t bytes) "TX
> packet: desc=3D0x%08x paddr=3D0x%08x bytes=3D%u"
> > +aw_h3_emac_reset(void) "HW reset"
> > +aw_h3_emac_set_link(bool active) "Set link: active=3D%u"
> > +aw_h3_emac_read(uint64_t offset, uint64_t val) "MMIO read: offset=3D0x=
%"
> PRIx64 " value=3D0x%" PRIx64
> > +aw_h3_emac_write(uint64_t offset, uint64_t val) "MMIO write:
> offset=3D0x%" PRIx64 " value=3D0x%" PRIx64
> > +
> >   # etraxfs_eth.c
> >   mdio_phy_read(int regnum, uint16_t value) "read phy_reg:%d
> value:0x%04x"
> >   mdio_phy_write(int regnum, uint16_t value) "write phy_reg:%d
> value:0x%04x"
> > diff --git a/include/hw/arm/allwinner-h3.h
> b/include/hw/arm/allwinner-h3.h
> > index 7aff4ebbd2..b964a60f41 100644
> > --- a/include/hw/arm/allwinner-h3.h
> > +++ b/include/hw/arm/allwinner-h3.h
> > @@ -31,6 +31,7 @@
> >   #include "hw/misc/allwinner-h3-syscon.h"
> >   #include "hw/misc/allwinner-h3-sid.h"
> >   #include "hw/sd/allwinner-h3-sdhost.h"
> > +#include "hw/net/allwinner-h3-emac.h"
> >   #include "target/arm/cpu.h"
> >
> >   #define AW_H3_SRAM_A1_BASE     (0x00000000)
> > @@ -119,6 +120,7 @@ typedef struct AwH3State {
> >       AwH3SysconState syscon;
> >       AwH3SidState sid;
> >       AwH3SDHostState mmc0;
> > +    AwH3EmacState emac;
> >       GICState gic;
> >       MemoryRegion sram_a1;
> >       MemoryRegion sram_a2;
> > diff --git a/include/hw/net/allwinner-h3-emac.h
> b/include/hw/net/allwinner-h3-emac.h
> > new file mode 100644
> > index 0000000000..a007d54472
> > --- /dev/null
> > +++ b/include/hw/net/allwinner-h3-emac.h
> > @@ -0,0 +1,69 @@
> > +/*
> > + * Allwinner H3 EMAC emulation
> > + *
> > + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#ifndef ALLWINNER_H3_EMAC_H
> > +#define ALLWINNER_H3_EMAC_H
> > +
> > +#include "qemu/units.h"
> > +#include "net/net.h"
> > +#include "qemu/fifo8.h"
> > +#include "hw/net/mii.h"
> > +#include "hw/sysbus.h"
> > +
> > +#define AW_H3_EMAC_REGS_MEM_SIZE  (1024)
> > +
> > +#define TYPE_AW_H3_EMAC "allwinner-h3-emac"
> > +#define AW_H3_EMAC(obj) OBJECT_CHECK(AwH3EmacState, (obj),
> TYPE_AW_H3_EMAC)
> > +
> > +typedef struct AwH3EmacState {
> > +    /*< private >*/
> > +    SysBusDevice  parent_obj;
> > +    /*< public >*/
> > +
> > +    MemoryRegion iomem;
> > +    qemu_irq     irq;
> > +    NICState     *nic;
> > +    NICConf      conf;
> > +
> > +    uint8_t      mii_phy_addr;
> > +    uint32_t     mii_cmd;
> > +    uint32_t     mii_data;
> > +    uint32_t     mii_cr;
> > +    uint32_t     mii_st;
> > +
> > +    uint32_t     basic_ctl0;
> > +    uint32_t     basic_ctl1;
> > +    uint32_t     int_en;
> > +    uint32_t     int_sta;
> > +    uint32_t     frm_flt;
> > +
> > +    uint32_t     rx_ctl0;
> > +    uint32_t     rx_ctl1;
> > +    uint32_t     rx_desc_head;
> > +    uint32_t     rx_desc_curr;
> > +
> > +    uint32_t     tx_ctl0;
> > +    uint32_t     tx_ctl1;
> > +    uint32_t     tx_desc_head;
> > +    uint32_t     tx_desc_curr;
> > +    uint32_t     tx_flowctl;
> > +
> > +} AwH3EmacState;
> > +
> > +#endif
> >
>
> The rest seems ok to me. Thanks for the contribution :)!
>

Thanks! :-)

Regards,
Niek


> Cheers,
> Fred
>
>

--=20
Niek Linnenbank

WWW: http://www.nieklinnenbank.nl/
BLOG: http://nieklinnenbank.wordpress.com/
FUN:    http://www.FreeNOS.org/

--000000000000354d600598d1e4fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello Frederic,</div><div><br></div>=
<div>Thank you for your quick review comments!</div><div>I&#39;ll start wor=
king on v2 of the patches and include the changes you suggested.<br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Dec 3, 2019 at 10:33 AM KONRAD Frederic &lt;<a href=3D"mailto:freder=
ic.konrad@adacore.com">frederic.konrad@adacore.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Le 12/2/19 =C3=A0 10:09 PM, Niek Linnenbank a =C3=A9crit=C2=A0:<br>
&gt; The Allwinner H3 System on Chip includes an Ethernet MAC (EMAC)<br>
&gt; which provides 10M/100M/1000M Ethernet connectivity. This commit<br>
&gt; adds support for the Allwinner H3 EMAC, including emulation for<br>
&gt; the following functionality:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* DMA transfers<br>
&gt;=C2=A0 =C2=A0* MII interface<br>
&gt;=C2=A0 =C2=A0* Transmit CRC calculation<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 17 +<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0hw/net/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0hw/net/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/net/allwinner-h3-emac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 786 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +<br>
&gt;=C2=A0 =C2=A0include/hw/net/allwinner-h3-emac.h |=C2=A0 69 +++<br>
&gt;=C2=A0 =C2=A09 files changed, 896 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/net/allwinner-h3-emac.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/net/allwinner-h3-emac.h<br>
&gt; <br>
&gt; diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
&gt; index ebf8d2325f..551cff3442 100644<br>
&gt; --- a/hw/arm/Kconfig<br>
&gt; +++ b/hw/arm/Kconfig<br>
&gt; @@ -294,6 +294,7 @@ config ALLWINNER_A10<br>
&gt;=C2=A0 =C2=A0config ALLWINNER_H3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select ALLWINNER_A10_PIT<br>
&gt; +=C2=A0 =C2=A0 select ALLWINNER_H3_EMAC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select SERIAL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select ARM_TIMER<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select ARM_GIC<br>
&gt; diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
&gt; index c2972caf88..274b8548c0 100644<br>
&gt; --- a/hw/arm/allwinner-h3.c<br>
&gt; +++ b/hw/arm/allwinner-h3.c<br>
&gt; @@ -53,6 +53,9 @@ static void aw_h3_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(obj, &quot;mmc0&quot;,=
 &amp;s-&gt;mmc0, sizeof(s-&gt;mmc0),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_AW_H3_SDHOST);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_child_obj(obj, &quot;emac&quot;, &amp;s-&gt=
;emac, sizeof(s-&gt;emac),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_EMAC);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void aw_h3_realize(DeviceState *dev, Error **errp)<=
br>
&gt; @@ -237,6 +240,20 @@ static void aw_h3_realize(DeviceState *dev, Error=
 **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* EMAC */<br>
&gt; +=C2=A0 =C2=A0 if (nd_table[0].used) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_check_nic_model(&amp;nd_table[0], TY=
PE_AW_H3_EMAC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_set_nic_properties(DEVICE(&amp;s-&gt=
;emac), &amp;nd_table[0]);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 object_property_set_bool(OBJECT(&amp;s-&gt;emac), true,=
 &quot;realized&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 sysbusdev =3D SYS_BUS_DEVICE(&amp;s-&gt;emac);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(sysbusdev, 0, AW_H3_EMAC_BASE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(sysbusdev, 0, s-&gt;irq[AW_H3_GIC_SP=
I_EMAC]);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_=
EHCI0_BASE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;irq[AW_H3_GIC_SPI_EHCI0]);<br>
&gt; diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
&gt; index dee3efaf08..8a61eb0e69 100644<br>
&gt; --- a/hw/arm/orangepi.c<br>
&gt; +++ b/hw/arm/orangepi.c<br>
&gt; @@ -61,6 +61,13 @@ static void orangepi_init(MachineState *machine)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Setup EMAC properties */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_int(OBJECT(&amp;s-&gt;h3-&gt;emac),=
 1, &quot;phy-addr&quot;, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_reportf_err(err, &quot;Couldn&#39;t=
 set phy address: &quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Mark H3 object realized */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(OBJECT(s-&gt;h3), t=
rue, &quot;realized&quot;, &amp;err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D NULL) {<br>
&gt; diff --git a/hw/net/Kconfig b/hw/net/Kconfig<br>
&gt; index 3856417d42..36d3923992 100644<br>
&gt; --- a/hw/net/Kconfig<br>
&gt; +++ b/hw/net/Kconfig<br>
&gt; @@ -74,6 +74,9 @@ config MIPSNET<br>
&gt;=C2=A0 =C2=A0config ALLWINNER_EMAC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config ALLWINNER_H3_EMAC<br>
&gt; +=C2=A0 =C2=A0 bool<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0config IMX_FEC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs<br>
&gt; index 7907d2c199..5548deb07a 100644<br>
&gt; --- a/hw/net/Makefile.objs<br>
&gt; +++ b/hw/net/Makefile.objs<br>
&gt; @@ -23,6 +23,7 @@ common-obj-$(CONFIG_XGMAC) +=3D xgmac.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_MIPSNET) +=3D mipsnet.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axienet.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_ALLWINNER_EMAC) +=3D allwinner_emac.o<=
br>
&gt; +common-obj-$(CONFIG_ALLWINNER_H3_EMAC) +=3D allwinner-h3-emac.o<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_IMX_FEC) +=3D imx_fec.o<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0common-obj-$(CONFIG_CADENCE) +=3D cadence_gem.o<br>
&gt; diff --git a/hw/net/allwinner-h3-emac.c b/hw/net/allwinner-h3-emac.c<b=
r>
&gt; new file mode 100644<br>
&gt; index 0000000000..37f6f44406<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/net/allwinner-h3-emac.c<br>
&gt; @@ -0,0 +1,786 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 EMAC emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;net/net.h&quot;<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#include &quot;net/checksum.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;exec/cpu-common.h&quot;<br>
&gt; +#include &quot;hw/net/allwinner-h3-emac.h&quot;<br>
&gt; +<br>
&gt; +/* EMAC register offsets */<br>
&gt; +#define REG_BASIC_CTL_0=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0000) /* Basic =
Control 0 */<br>
&gt; +#define REG_BASIC_CTL_1=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0004) /* Basic =
Control 1 */<br>
&gt; +#define REG_INT_STA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0008)=
 /* Interrupt Status */<br>
&gt; +#define REG_INT_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x=
000C) /* Interrupt Enable */<br>
&gt; +#define REG_TX_CTL_0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0010)=
 /* Transmit Control 0 */<br>
&gt; +#define REG_TX_CTL_1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0014)=
 /* Transmit Control 1 */<br>
&gt; +#define REG_TX_FLOW_CTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x001C) /* Transm=
it Flow Control */<br>
&gt; +#define REG_TX_DMA_DESC_LIST=C2=A0 =C2=A0(0x0020) /* Transmit Descrip=
tor List Address */<br>
&gt; +#define REG_RX_CTL_0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0024)=
 /* Receive Control 0 */<br>
&gt; +#define REG_RX_CTL_1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0028)=
 /* Receive Control 1 */<br>
&gt; +#define REG_RX_DMA_DESC_LIST=C2=A0 =C2=A0(0x0034) /* Receive Descript=
or List Address */<br>
&gt; +#define REG_FRM_FLT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0038)=
 /* Receive Frame Filter */<br>
&gt; +#define REG_RX_HASH_0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0040) /* R=
eceive Hash Table 0 */<br>
&gt; +#define REG_RX_HASH_1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0044) /* R=
eceive Hash Table 1 */<br>
&gt; +#define REG_MII_CMD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0048)=
 /* Management Interface Command */<br>
&gt; +#define REG_MII_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x004C)=
 /* Management Interface Data */<br>
&gt; +#define REG_ADDR_HIGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0050) /* M=
AC Address High */<br>
&gt; +#define REG_ADDR_LOW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x0054)=
 /* MAC Address Low */<br>
&gt; +#define REG_TX_DMA_STA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00B0) /* T=
ransmit DMA Status */<br>
&gt; +#define REG_TX_CUR_DESC=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00B4) /* Transm=
it Current Descriptor */<br>
&gt; +#define REG_TX_CUR_BUF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00B8) /* T=
ransmit Current Buffer */<br>
&gt; +#define REG_RX_DMA_STA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00C0) /* R=
eceive DMA Status */<br>
&gt; +#define REG_RX_CUR_DESC=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00C4) /* Receiv=
e Current Descriptor */<br>
&gt; +#define REG_RX_CUR_BUF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x00C8) /* R=
eceive Current Buffer */<br>
&gt; +#define REG_RGMII_STA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00D0) /* R=
GMII Status */<br>
&gt; +<br>
&gt; +/* EMAC register flags */<br>
&gt; +#define BASIC_CTL0_100Mbps=C2=A0 =C2=A0 =C2=A0(0b11 &lt;&lt; 2)<br>
&gt; +#define BASIC_CTL0_FD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0=
)<br>
&gt; +#define BASIC_CTL1_SOFTRST=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
&gt; +<br>
&gt; +#define INT_STA_RGMII_LINK=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 16)<br>
&gt; +#define INT_STA_RX_EARLY=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 13)<br=
>
&gt; +#define INT_STA_RX_OVERFLOW=C2=A0 =C2=A0 (1 &lt;&lt; 12)<br>
&gt; +#define INT_STA_RX_TIMEOUT=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 11)<br>
&gt; +#define INT_STA_RX_DMA_STOP=C2=A0 =C2=A0 (1 &lt;&lt; 10)<br>
&gt; +#define INT_STA_RX_BUF_UA=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 9)<br>
&gt; +#define INT_STA_RX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 =
&lt;&lt; 8)<br>
&gt; +#define INT_STA_TX_EARLY=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 5)<br>
&gt; +#define INT_STA_TX_UNDERFLOW=C2=A0 =C2=A0(1 &lt;&lt; 4)<br>
&gt; +#define INT_STA_TX_TIMEOUT=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 3)<br>
&gt; +#define INT_STA_TX_BUF_UA=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 2)<br>
&gt; +#define INT_STA_TX_DMA_STOP=C2=A0 =C2=A0 (1 &lt;&lt; 1)<br>
&gt; +#define INT_STA_TX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 =
&lt;&lt; 0)<br>
&gt; +<br>
&gt; +#define INT_EN_RX_EARLY=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 13)<br=
>
&gt; +#define INT_EN_RX_OVERFLOW=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 12)<br>
&gt; +#define INT_EN_RX_TIMEOUT=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 11)<br>
&gt; +#define INT_EN_RX_DMA_STOP=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 10)<br>
&gt; +#define INT_EN_RX_BUF_UA=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 9)<br>
&gt; +#define INT_EN_RX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 =
&lt;&lt; 8)<br>
&gt; +#define INT_EN_TX_EARLY=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 5)<br>
&gt; +#define INT_EN_TX_UNDERFLOW=C2=A0 =C2=A0 (1 &lt;&lt; 4)<br>
&gt; +#define INT_EN_TX_TIMEOUT=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3)<br>
&gt; +#define INT_EN_TX_BUF_UA=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 2)<br>
&gt; +#define INT_EN_TX_DMA_STOP=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 1)<br>
&gt; +#define INT_EN_TX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 =
&lt;&lt; 0)<br>
&gt; +<br>
&gt; +#define TX_CTL0_TX_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3=
1)<br>
&gt; +#define TX_CTL1_TX_DMA_START=C2=A0 =C2=A0(1 &lt;&lt; 31)<br>
&gt; +#define TX_CTL1_TX_DMA_EN=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 30)<br>
&gt; +#define TX_CTL1_TX_FLUSH=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
&gt; +<br>
&gt; +#define RX_CTL0_RX_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3=
1)<br>
&gt; +#define RX_CTL0_STRIP_FCS=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 28)<br>
&gt; +#define RX_CTL0_CRC_IPV4=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 27)<br=
>
&gt; +<br>
&gt; +#define RX_CTL1_RX_DMA_START=C2=A0 =C2=A0(1 &lt;&lt; 31)<br>
&gt; +#define RX_CTL1_RX_DMA_EN=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 30)<br>
&gt; +#define RX_CTL1_RX_MD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 1=
)<br>
&gt; +<br>
&gt; +#define RX_FRM_FLT_DIS_ADDR=C2=A0 =C2=A0 (1 &lt;&lt; 31)<br>
&gt; +<br>
&gt; +#define MII_CMD_PHY_ADDR_SHIFT (12)<br>
&gt; +#define MII_CMD_PHY_ADDR_MASK=C2=A0 (0xf000)<br>
&gt; +#define MII_CMD_PHY_REG_SHIFT=C2=A0 (4)<br>
&gt; +#define MII_CMD_PHY_REG_MASK=C2=A0 =C2=A0(0xf0)<br>
&gt; +#define MII_CMD_PHY_RW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 1=
)<br>
&gt; +#define MII_CMD_PHY_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 0)<br>
&gt; +<br>
&gt; +#define TX_DMA_STA_STOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0b000)<br>
&gt; +#define TX_DMA_STA_RUN_FETCH=C2=A0 =C2=A0(0b001)<br>
&gt; +#define TX_DMA_STA_WAIT_STA=C2=A0 =C2=A0 (0b010)<br>
&gt; +<br>
&gt; +#define RX_DMA_STA_STOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0b000)<br>
&gt; +#define RX_DMA_STA_RUN_FETCH=C2=A0 =C2=A0(0b001)<br>
&gt; +#define RX_DMA_STA_WAIT_FRM=C2=A0 =C2=A0 (0b011)<br>
&gt; +<br>
&gt; +#define RGMII_LINK_UP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 3=
)<br>
&gt; +#define RGMII_FD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1 &lt;&lt; 0)<br>
&gt; +<br>
&gt; +/* EMAC register reset values */<br>
&gt; +#define REG_BASIC_CTL_1_RST=C2=A0 =C2=A0 (0x08000000)<br>
&gt; +<br>
&gt; +/* EMAC constants */<br>
&gt; +#define AW_H3_EMAC_MIN_PKT_SZ=C2=A0 (64)<br>
&gt; +<br>
&gt; +/* Transmit/receive frame descriptor */<br>
&gt; +typedef struct FrameDescriptor {<br>
&gt; +=C2=A0 =C2=A0 uint32_t status;<br>
&gt; +=C2=A0 =C2=A0 uint32_t status2;<br>
&gt; +=C2=A0 =C2=A0 uint32_t addr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t next;<br>
&gt; +} FrameDescriptor;<br>
&gt; +<br>
&gt; +/* Frame descriptor flags */<br>
&gt; +#define DESC_STATUS_CTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 &lt;&lt; 31)<br>
&gt; +#define DESC_STATUS2_BUF_SIZE_MASK=C2=A0 =C2=A0 =C2=A0 (0x7ff)<br>
&gt; +<br>
&gt; +/* Transmit frame descriptor flags */<br>
&gt; +#define TX_DESC_STATUS_LENGTH_ERR=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&l=
t; 14)<br>
&gt; +#define TX_DESC_STATUS2_FIRST_DESC=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 29=
)<br>
&gt; +#define TX_DESC_STATUS2_LAST_DESC=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&l=
t; 30)<br>
&gt; +#define TX_DESC_STATUS2_CHECKSUM_MASK=C2=A0 =C2=A0(0x3 &lt;&lt; 27)<b=
r>
&gt; +<br>
&gt; +/* Receive frame descriptor flags */<br>
&gt; +#define RX_DESC_STATUS_FIRST_DESC=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&l=
t; 9)<br>
&gt; +#define RX_DESC_STATUS_LAST_DESC=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&l=
t; 8)<br>
&gt; +#define RX_DESC_STATUS_FRM_LEN_MASK=C2=A0 =C2=A0 =C2=A0(0x3fff0000)<b=
r>
&gt; +#define RX_DESC_STATUS_FRM_LEN_SHIFT=C2=A0 =C2=A0 (16)<br>
&gt; +#define RX_DESC_STATUS_NO_BUF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1 &lt;&lt; 14)<br>
&gt; +#define RX_DESC_STATUS_HEADER_ERR=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&l=
t; 7)<br>
&gt; +#define RX_DESC_STATUS_LENGTH_ERR=C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&l=
t; 4)<br>
&gt; +#define RX_DESC_STATUS_CRC_ERR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &=
lt;&lt; 1)<br>
&gt; +#define RX_DESC_STATUS_PAYLOAD_ERR=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0)=
<br>
&gt; +#define RX_DESC_STATUS2_RX_INT_CTL=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 31=
)<br>
&gt; +<br>
&gt; +/* MII register offsets */<br>
&gt; +#define MII_REG_CR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0)<br>
&gt; +#define MII_REG_ST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x1)<br>
&gt; +#define MII_REG_ID_HIGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(0x2)<br>
&gt; +#define MII_REG_ID_LOW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (0x3)<br>
&gt; +<br>
&gt; +/* MII register flags */<br>
&gt; +#define MII_REG_CR_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 &lt;&lt; 15)<br>
&gt; +#define MII_REG_CR_POWERDOWN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (1 &lt;&lt; 11)<br>
&gt; +#define MII_REG_CR_10Mbit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(0)<br>
&gt; +#define MII_REG_CR_100Mbit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (1 &lt;&lt; 13)<br>
&gt; +#define MII_REG_CR_1000Mbit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 6)<br>
&gt; +#define MII_REG_CR_AUTO_NEG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 12)<br>
&gt; +#define MII_REG_CR_AUTO_NEG_RESTART=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 9)=
<br>
&gt; +#define MII_REG_CR_FULLDUPLEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1 &lt;&lt; 8)<br>
&gt; +<br>
&gt; +#define MII_REG_ST_100BASE_T4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(1 &lt;&lt; 15)<br>
&gt; +#define MII_REG_ST_100BASE_X_FD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &=
lt;&lt; 14)<br>
&gt; +#define MII_REG_ST_100BASE_X_HD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &=
lt;&lt; 13)<br>
&gt; +#define MII_REG_ST_10_FD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 &lt;&lt; 12)<br>
&gt; +#define MII_REG_ST_10_HD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 &lt;&lt; 11)<br>
&gt; +#define MII_REG_ST_100BASE_T2_FD=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&l=
t; 10)<br>
&gt; +#define MII_REG_ST_100BASE_T2_HD=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&l=
t; 9)<br>
&gt; +#define MII_REG_ST_AUTONEG_COMPLETE=C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 5)=
<br>
&gt; +#define MII_REG_ST_AUTONEG_AVAIL=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&l=
t; 3)<br>
&gt; +#define MII_REG_ST_LINK_UP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (1 &lt;&lt; 2)<br>
&gt; +<br>
&gt; +/* MII constants */<br>
&gt; +#define MII_PHY_ID_HIGH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(0x0044)<br>
&gt; +#define MII_PHY_ID_LOW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (0x1400)<br>
<br>
I wonder if we can&#39;t share all those mii stuff accross the network adap=
ters<br>
instead of redoing the work everytime. I&#39;ve some patches about it I may=
 post<br>
them sometimes.<br>
<br></blockquote><div><br></div><div>Indeed, that would be a nice improveme=
nt. In fact, I was looking for somekind of</div><div>MII library inside QEM=
U and could not find it. Then I saw that the other emulated ethernet cards<=
/div><div>all have that code inside each file, so that is why I did the sam=
e here.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
&gt; +<br>
&gt; +static void aw_h3_emac_mii_set_link(AwH3EmacState *s, bool link_activ=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (link_active) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_st |=3D MII_REG_ST_LINK_UP;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_st &amp;=3D ~MII_REG_ST_LINK_UP=
;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_mii_reset(AwH3EmacState *s, bool link_active)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mii_cr =3D MII_REG_CR_100Mbit | MII_REG_CR_AUTO_N=
EG |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MII_REG_CR_FU=
LLDUPLEX;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mii_st =3D MII_REG_ST_100BASE_T4 | MII_REG_ST_100=
BASE_X_FD |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MII_REG_ST_10=
0BASE_X_HD | MII_REG_ST_10_FD | MII_REG_ST_10_HD |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MII_REG_ST_10=
0BASE_T2_FD | MII_REG_ST_100BASE_T2_HD |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MII_REG_ST_AU=
TONEG_COMPLETE | MII_REG_ST_AUTONEG_AVAIL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 aw_h3_emac_mii_set_link(s, link_active);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_mii_cmd(AwH3EmacState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t addr, reg;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 addr =3D (s-&gt;mii_cmd &amp; MII_CMD_PHY_ADDR_MASK) &g=
t;&gt; MII_CMD_PHY_ADDR_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 reg =3D (s-&gt;mii_cmd &amp; MII_CMD_PHY_REG_MASK) &gt;=
&gt; MII_CMD_PHY_REG_SHIFT;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (addr !=3D s-&gt;mii_phy_addr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Read or write a PHY register? */<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;mii_cmd &amp; MII_CMD_PHY_RW) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aw_h3_emac_mii_write_reg(reg, s-&gt=
;mii_data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MII_REG_CR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;mii_data &amp; MI=
I_REG_CR_RESET) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_mi=
i_reset(s, s-&gt;mii_st &amp; MII_REG_ST_LINK_UP);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_cr =
=3D s-&gt;mii_data &amp; ~(MII_REG_CR_RESET |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 MII_REG_CR_AUTO_NEG_RESTART);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &q=
uot;allwinner-h3-emac: write access to &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;unknow=
n MII register 0x%x\n&quot;, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MII_REG_CR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_data =3D s-&gt;mi=
i_cr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MII_REG_ST:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_data =3D s-&gt;mi=
i_st;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MII_REG_ID_HIGH:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_data =3D MII_PHY_=
ID_HIGH;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case MII_REG_ID_LOW:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_data =3D MII_PHY_=
ID_LOW;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &q=
uot;allwinner-h3-emac: read access to &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;unknow=
n MII register 0x%x\n&quot;, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_data =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aw_h3_emac_mii_read_reg(reg, s-&gt;=
mii_data);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_update_irq(AwH3EmacState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, (s-&gt;int_sta &amp; s-&gt;int_=
en) !=3D 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint32_t aw_h3_emac_next_desc(FrameDescriptor *desc, size_t mi=
n_size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t paddr =3D desc-&gt;next;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cpu_physical_memory_read(paddr, desc, sizeof(*desc));<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((desc-&gt;status &amp; DESC_STATUS_CTL) &amp;&amp;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (desc-&gt;status2 &amp; DESC_STATUS2_BUF_=
SIZE_MASK) &gt;=3D min_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return paddr;<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint32_t aw_h3_emac_get_desc(FrameDescriptor *desc, uint32_t s=
tart_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t min_size)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t desc_addr =3D start_addr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Note that the list is a cycle. Last entry points bac=
k to the head. */<br>
&gt; +=C2=A0 =C2=A0 while (desc_addr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(desc_addr, desc,=
 sizeof(*desc));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((desc-&gt;status &amp; DESC_STATUS_CT=
L) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (desc-&gt;status2 &amp; DES=
C_STATUS2_BUF_SIZE_MASK) &gt;=3D min_size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return desc_addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (desc-&gt;next =3D=3D start_add=
r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr =3D desc-&gt;next=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint32_t aw_h3_emac_get_rx_desc(AwH3EmacState *s, FrameDescrip=
tor *desc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_=
t min_size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return aw_h3_emac_get_desc(desc, s-&gt;rx_desc_curr, mi=
n_size);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint32_t aw_h3_emac_get_tx_desc(AwH3EmacState *s, FrameDescrip=
tor *desc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_=
t min_size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return aw_h3_emac_get_desc(desc, s-&gt;tx_desc_head, mi=
n_size);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_flush_desc(FrameDescriptor *desc, uint32_t phy=
s_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cpu_physical_memory_write(phys_addr, desc, sizeof(*desc=
));<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int aw_h3_emac_can_receive(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D qemu_get_nic_opaque(nc);<br>
&gt; +=C2=A0 =C2=A0 FrameDescriptor desc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return (s-&gt;rx_ctl0 &amp; RX_CTL0_RX_EN) &amp;&amp;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(aw_h3_emac_get_rx_desc(s, &=
amp;desc, 0) !=3D 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t aw_h3_emac_receive(NetClientState *nc, const uint8_t *=
buf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D qemu_get_nic_opaque(nc);<br>
&gt; +=C2=A0 =C2=A0 FrameDescriptor desc;<br>
&gt; +=C2=A0 =C2=A0 size_t bytes_left =3D size;<br>
&gt; +=C2=A0 =C2=A0 size_t desc_bytes =3D 0;<br>
&gt; +=C2=A0 =C2=A0 size_t pad_fcs_size =3D 4;<br>
&gt; +=C2=A0 =C2=A0 size_t padding =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!(s-&gt;rx_ctl0 &amp; RX_CTL0_RX_EN)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_desc_curr =3D aw_h3_emac_get_rx_desc(s, &amp;d=
esc, AW_H3_EMAC_MIN_PKT_SZ);<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;rx_desc_curr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;int_sta |=3D INT_STA_RX_BUF_UA;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Keep filling RX descriptors until the whole frame is=
 written */<br>
&gt; +=C2=A0 =C2=A0 while (s-&gt;rx_desc_curr &amp;&amp; bytes_left &gt; 0)=
 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.status &amp;=3D ~DESC_STATUS_CTL;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.status &amp;=3D ~RX_DESC_STATUS_FRM_=
LEN_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_left =3D=3D size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.status |=3D RX_DESC_ST=
ATUS_FIRST_DESC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((desc.status2 &amp; DESC_STATUS2_BUF_=
SIZE_MASK) &lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (bytes_left + pad_fcs_size)=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_bytes =3D desc.status2=
 &amp; DESC_STATUS2_BUF_SIZE_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.status |=3D desc_bytes=
 &lt;&lt; RX_DESC_STATUS_FRM_LEN_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 padding =3D pad_fcs_size;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes_left &lt; AW_H3_E=
MAC_MIN_PKT_SZ) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 padding +=3D =
(AW_H3_EMAC_MIN_PKT_SZ - bytes_left);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_bytes =3D (bytes_left)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.status |=3D RX_DESC_ST=
ATUS_LAST_DESC;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.status |=3D (bytes_lef=
t + padding)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;&lt; RX_DESC_STATUS_FRM_LEN_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write(desc.addr, buf,=
 desc_bytes);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_flush_desc(&amp;desc, s-&gt;rx=
_desc_curr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aw_h3_emac_receive(s-&gt;rx_desc_cu=
rr, desc.addr, desc_bytes);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if frame needs to raise the rece=
ive interrupt */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(desc.status2 &amp; RX_DESC_STATUS2_=
RX_INT_CTL)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;int_sta |=3D INT_STA_=
RX;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Increment variables */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf +=3D desc_bytes;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_left -=3D desc_bytes;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Move to the next descriptor */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_desc_curr =3D aw_h3_emac_next_de=
sc(&amp;desc, 64);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;rx_desc_curr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not enough buffer space =
available */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;int_sta |=3D INT_STA_=
RX_BUF_UA;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_desc_curr =3D s-&g=
t;rx_desc_head;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Report receive DMA is finished */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_ctl1 &amp;=3D ~RX_CTL1_RX_DMA_START;<br>
&gt; +=C2=A0 =C2=A0 aw_h3_emac_update_irq(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return size;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_transmit(AwH3EmacState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 NetClientState *nc =3D qemu_get_queue(s-&gt;nic);<br>
&gt; +=C2=A0 =C2=A0 FrameDescriptor desc;<br>
&gt; +=C2=A0 =C2=A0 size_t bytes =3D 0;<br>
&gt; +=C2=A0 =C2=A0 size_t packet_bytes =3D 0;<br>
&gt; +=C2=A0 =C2=A0 size_t transmitted =3D 0;<br>
&gt; +=C2=A0 =C2=A0 static uint8_t packet_buf[2048];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_desc_curr =3D aw_h3_emac_get_tx_desc(s, &amp;d=
esc, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Read all transmit descriptors */<br>
&gt; +=C2=A0 =C2=A0 while (s-&gt;tx_desc_curr !=3D 0) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Read from physical memory into packet =
buffer */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes =3D desc.status2 &amp; DESC_STATUS2=
_BUF_SIZE_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bytes + packet_bytes &gt; sizeof(pack=
et_buf)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.status |=3D TX_DESC_ST=
ATUS_LENGTH_ERR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(desc.addr, packe=
t_buf + packet_bytes, bytes);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_bytes +=3D bytes;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.status &amp;=3D ~DESC_STATUS_CTL;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_flush_desc(&amp;desc, s-&gt;tx=
_desc_curr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* After the last descriptor, send the pa=
cket */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.status2 &amp; TX_DESC_STATUS2_LA=
ST_DESC) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.status2 &amp; TX_D=
ESC_STATUS2_CHECKSUM_MASK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 net_checksum_=
calculate(packet_buf, packet_bytes);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_send_packet(nc, packet=
_buf, packet_bytes);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_aw_h3_emac_transmit(s=
-&gt;tx_desc_curr, desc.addr, bytes);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_bytes =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transmitted++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_desc_curr =3D aw_h3_emac_next_de=
sc(&amp;desc, 0);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Raise transmit completed interrupt */<br>
&gt; +=C2=A0 =C2=A0 if (transmitted &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;int_sta |=3D INT_STA_TX;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_ctl1 &amp;=3D ~TX_CTL1_TX_DMA_ST=
ART;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_update_irq(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_reset(DeviceState *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D AW_H3_EMAC(dev);<br>
&gt; +=C2=A0 =C2=A0 NetClientState *nc =3D qemu_get_queue(s-&gt;nic);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aw_h3_emac_reset();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mii_cmd =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mii_data =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;basic_ctl0 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;basic_ctl1 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;int_en =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;int_sta =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;frm_flt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_ctl0 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_ctl1 =3D RX_CTL1_RX_MD;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_desc_head =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_desc_curr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_ctl0 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_ctl1 =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_desc_head =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_desc_curr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_flowctl =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 aw_h3_emac_mii_reset(s, !nc-&gt;link_down);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t aw_h3_emac_read(void *opaque, hwaddr offset, unsigned=
 size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D opaque;<br>
<br>
I&#39;d put AW_H3_EMAC(opaque) here.<br>
<br>
&gt; +=C2=A0 =C2=A0 uint64_t value =3D 0;<br>
&gt; +=C2=A0 =C2=A0 FrameDescriptor desc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_BASIC_CTL_0:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Basi=
c Control 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;basic_ctl0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_BASIC_CTL_1:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Basi=
c Control 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;basic_ctl1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_INT_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Interrupt Status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;int_sta;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_INT_EN:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Interupt Enable */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;int_en;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_CTL_0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Transmit Control 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;tx_ctl0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_CTL_1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Transmit Control 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;tx_ctl1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_FLOW_CTL:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Tran=
smit Flow Control */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;tx_flowctl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_DMA_DESC_LIST:=C2=A0 /* Transmit Descriptor=
 List Address */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;tx_desc_head;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_CTL_0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Receive Control 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;rx_ctl0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_CTL_1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Receive Control 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;rx_ctl1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_DMA_DESC_LIST:=C2=A0 /* Receive Descriptor =
List Address */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;rx_desc_head;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_FRM_FLT:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Receive Frame Filter */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;frm_flt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_HASH_0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Receive Hash Table 0 */<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_HASH_1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Receive Hash Table 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_MII_CMD:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Management Interface Command */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;mii_cmd;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_MII_DATA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Management Interface Data */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;mii_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_ADDR_HIGH:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 MAC Address High */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D *(((uint32_t *) (s-&gt;conf.mac=
addr.a)) + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_ADDR_LOW:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 MAC Address Low */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D *(uint32_t *) (s-&gt;conf.macad=
dr.a);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_DMA_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Tran=
smit DMA Status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_CUR_DESC:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Tran=
smit Current Descriptor */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;tx_desc_curr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_CUR_BUF:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Tran=
smit Current Buffer */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;tx_desc_curr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(s-=
&gt;tx_desc_curr, &amp;desc, sizeof(desc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D desc.addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_DMA_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Rece=
ive DMA Status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_CUR_DESC:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Rece=
ive Current Descriptor */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D s-&gt;rx_desc_curr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_CUR_BUF:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Rece=
ive Current Buffer */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;rx_desc_curr !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(s-=
&gt;rx_desc_curr, &amp;desc, sizeof(desc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D desc.addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;allwinner-=
h3-emac: read access to unknown &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;EMAC register 0x&quo=
t; TARGET_FMT_plx &quot;\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aw_h3_emac_read(offset, value);<br>
&gt; +=C2=A0 =C2=A0 return value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_write(void *opaque, hwaddr offset, uint64_t va=
lue,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D opaque;<br>
<br>
The same.<br>
<br>
&gt; +=C2=A0 =C2=A0 NetClientState *nc =3D qemu_get_queue(s-&gt;nic);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aw_h3_emac_write(offset, value);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_BASIC_CTL_0:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Basi=
c Control 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;basic_ctl0 =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_BASIC_CTL_1:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Basi=
c Control 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; BASIC_CTL1_SOFTRST) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_reset(DEVICE(s))=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value &amp;=3D ~BASIC_CTL1_=
SOFTRST;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;basic_ctl1 =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (aw_h3_emac_can_receive(nc)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_flush_queued_packets(n=
c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_INT_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Interrupt Status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;int_sta &amp;=3D ~value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_update_irq(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_INT_EN:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Interrupt Enable */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;int_en =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_update_irq(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_CTL_0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Transmit Control 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_ctl0 =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_CTL_1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Transmit Control 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_ctl1 =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &amp; TX_CTL1_TX_DMA_EN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_transmit(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_FLOW_CTL:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Tran=
smit Flow Control */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_flowctl =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_DMA_DESC_LIST:=C2=A0 /* Transmit Descriptor=
 List Address */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_desc_head =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_desc_curr =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_CTL_0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Receive Control 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_ctl0 =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_CTL_1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Receive Control 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_ctl1 =3D value | RX_CTL1_RX_MD;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((value &amp; RX_CTL1_RX_DMA_EN) &amp;=
&amp; aw_h3_emac_can_receive(nc)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_flush_queued_packets(n=
c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_DMA_DESC_LIST:=C2=A0 /* Receive Descriptor =
List Address */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_desc_head =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_desc_curr =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_FRM_FLT:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Receive Frame Filter */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;frm_flt =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_HASH_0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Receive Hash Table 0 */<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_HASH_1:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Receive Hash Table 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_MII_CMD:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Management Interface Command */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_cmd =3D value &amp; ~MII_CMD_PH=
Y_BUSY;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aw_h3_emac_mii_cmd(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_MII_DATA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Management Interface Data */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mii_data =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_ADDR_HIGH:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 MAC Address High */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[4] =3D (value &amp; =
0xff);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[5] =3D (value &amp; =
0xff00) &gt;&gt; 8;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_ADDR_LOW:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 MAC Address Low */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[0] =3D (value &amp; =
0xff);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[1] =3D (value &amp; =
0xff00) &gt;&gt; 8;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[2] =3D (value &amp; =
0xff0000) &gt;&gt; 16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[3] =3D (value &amp; =
0xff000000) &gt;&gt; 24;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_DMA_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Tran=
smit DMA Status */<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_CUR_DESC:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Tran=
smit Current Descriptor */<br>
&gt; +=C2=A0 =C2=A0 case REG_TX_CUR_BUF:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Tran=
smit Current Buffer */<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_DMA_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Rece=
ive DMA Status */<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_CUR_DESC:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Rece=
ive Current Descriptor */<br>
&gt; +=C2=A0 =C2=A0 case REG_RX_CUR_BUF:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Rece=
ive Current Buffer */<br>
&gt; +=C2=A0 =C2=A0 case REG_RGMII_STA:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 RGMII Status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;allwinner-=
h3-emac: write access to unknown &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;EMAC register 0x&quo=
t; TARGET_FMT_plx &quot;\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_set_link(NetClientState *nc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D qemu_get_nic_opaque(nc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_aw_h3_emac_set_link(!nc-&gt;link_down);<br>
&gt; +=C2=A0 =C2=A0 aw_h3_emac_mii_set_link(s, !nc-&gt;link_down);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps aw_h3_emac_mem_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D aw_h3_emac_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D aw_h3_emac_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static NetClientInfo net_aw_h3_emac_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .type =3D NET_CLIENT_DRIVER_NIC,<br>
&gt; +=C2=A0 =C2=A0 .size =3D sizeof(NICState),<br>
&gt; +=C2=A0 =C2=A0 .can_receive =3D aw_h3_emac_can_receive,<br>
&gt; +=C2=A0 =C2=A0 .receive =3D aw_h3_emac_receive,<br>
&gt; +=C2=A0 =C2=A0 .link_status_changed =3D aw_h3_emac_set_link,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void aw_h3_emac_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D AW_H3_EMAC(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp=
;aw_h3_emac_mem_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_H3_EMAC, AW_H3_EMAC_REGS_MEM_SIZE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_irq(sbd, &amp;s-&gt;irq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void aw_h3_emac_realize(DeviceState *dev, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D AW_H3_EMAC(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_macaddr_default_if_unset(&amp;s-&gt;conf.macaddr);=
<br>
&gt; +=C2=A0 =C2=A0 s-&gt;nic =3D qemu_new_nic(&amp;net_aw_h3_emac_info, &a=
mp;s-&gt;conf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 object_get_typename(OBJECT(dev)), dev-&gt;id, s);<br>
&gt; +=C2=A0 =C2=A0 qemu_format_nic_info_str(qemu_get_queue(s-&gt;nic), s-&=
gt;conf.macaddr.a);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static Property aw_h3_emac_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_NIC_PROPERTIES(AwH3EmacState, conf),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT8(&quot;phy-addr&quot;, AwH3EmacState, =
mii_phy_addr, 0),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int aw_h3_emac_post_load(void *opaque, int version_id)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 aw_h3_emac_set_link(qemu_get_queue(s-&gt;nic));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription vmstate_aw_emac =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_AW_H3_EMAC,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .post_load =3D aw_h3_emac_post_load,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(mii_phy_addr, AwH3EmacState=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(mii_cmd, AwH3EmacState),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(mii_data, AwH3EmacState),<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(basic_ctl0, AwH3EmacState)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(basic_ctl1, AwH3EmacState)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(int_en, AwH3EmacState),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(int_sta, AwH3EmacState),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(frm_flt, AwH3EmacState),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_ctl0, AwH3EmacState),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_ctl1, AwH3EmacState),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_desc_head, AwH3EmacStat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rx_desc_curr, AwH3EmacStat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_ctl0, AwH3EmacState),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_ctl1, AwH3EmacState),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_desc_head, AwH3EmacStat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_desc_curr, AwH3EmacStat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_flowctl, AwH3EmacState)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void aw_h3_emac_class_init(ObjectClass *klass, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D aw_h3_emac_realize;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;props =3D aw_h3_emac_properties;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;reset =3D aw_h3_emac_reset;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_aw_emac;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo aw_h3_emac_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_=
AW_H3_EMAC,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_SYS_B=
US_DEVICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_size=C2=A0 =3D sizeof(AwH3EmacState),<br>
&gt; +=C2=A0 =C2=A0 .instance_init=C2=A0 =3D aw_h3_emac_init,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =C2=A0=3D aw_h3_emac_class_ini=
t,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void aw_h3_emac_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;aw_h3_emac_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(aw_h3_emac_register_types)<br>
&gt; diff --git a/hw/net/trace-events b/hw/net/trace-events<br>
&gt; index e70f12bee1..e9e2f26f68 100644<br>
&gt; --- a/hw/net/trace-events<br>
&gt; +++ b/hw/net/trace-events<br>
&gt; @@ -1,5 +1,15 @@<br>
&gt;=C2=A0 =C2=A0# See docs/devel/tracing.txt for syntax documentation.<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +# allwinner-h3-emac.c<br>
&gt; +aw_h3_emac_mii_write_reg(uint32_t reg, uint32_t value) &quot;MII writ=
e: reg=3D0x%x value=3D0x%x&quot;<br>
&gt; +aw_h3_emac_mii_read_reg(uint32_t reg, uint32_t value) &quot;MII read:=
 reg=3D0x%x value=3D0x%x&quot;<br>
&gt; +aw_h3_emac_receive(uint32_t desc, uint32_t paddr, uint32_t bytes) &qu=
ot;RX packet: desc=3D0x%08x paddr=3D0x%08x bytes=3D%u&quot;<br>
&gt; +aw_h3_emac_transmit(uint32_t desc, uint32_t paddr, uint32_t bytes) &q=
uot;TX packet: desc=3D0x%08x paddr=3D0x%08x bytes=3D%u&quot;<br>
&gt; +aw_h3_emac_reset(void) &quot;HW reset&quot;<br>
&gt; +aw_h3_emac_set_link(bool active) &quot;Set link: active=3D%u&quot;<br=
>
&gt; +aw_h3_emac_read(uint64_t offset, uint64_t val) &quot;MMIO read: offse=
t=3D0x%&quot; PRIx64 &quot; value=3D0x%&quot; PRIx64<br>
&gt; +aw_h3_emac_write(uint64_t offset, uint64_t val) &quot;MMIO write: off=
set=3D0x%&quot; PRIx64 &quot; value=3D0x%&quot; PRIx64<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0# etraxfs_eth.c<br>
&gt;=C2=A0 =C2=A0mdio_phy_read(int regnum, uint16_t value) &quot;read phy_r=
eg:%d value:0x%04x&quot;<br>
&gt;=C2=A0 =C2=A0mdio_phy_write(int regnum, uint16_t value) &quot;write phy=
_reg:%d value:0x%04x&quot;<br>
&gt; diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-=
h3.h<br>
&gt; index 7aff4ebbd2..b964a60f41 100644<br>
&gt; --- a/include/hw/arm/allwinner-h3.h<br>
&gt; +++ b/include/hw/arm/allwinner-h3.h<br>
&gt; @@ -31,6 +31,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-syscon.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-h3-sid.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/sd/allwinner-h3-sdhost.h&quot;<br>
&gt; +#include &quot;hw/net/allwinner-h3-emac.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;target/arm/cpu.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define AW_H3_SRAM_A1_BASE=C2=A0 =C2=A0 =C2=A0(0x00000000)=
<br>
&gt; @@ -119,6 +120,7 @@ typedef struct AwH3State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SysconState syscon;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SidState sid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwH3SDHostState mmc0;<br>
&gt; +=C2=A0 =C2=A0 AwH3EmacState emac;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GICState gic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
&gt; diff --git a/include/hw/net/allwinner-h3-emac.h b/include/hw/net/allwi=
nner-h3-emac.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..a007d54472<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/net/allwinner-h3-emac.h<br>
&gt; @@ -0,0 +1,69 @@<br>
&gt; +/*<br>
&gt; + * Allwinner H3 EMAC emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2019 Niek Linnenbank &lt;<a href=3D"mailto:nieklinne=
nbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef ALLWINNER_H3_EMAC_H<br>
&gt; +#define ALLWINNER_H3_EMAC_H<br>
&gt; +<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;net/net.h&quot;<br>
&gt; +#include &quot;qemu/fifo8.h&quot;<br>
&gt; +#include &quot;hw/net/mii.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +<br>
&gt; +#define AW_H3_EMAC_REGS_MEM_SIZE=C2=A0 (1024)<br>
&gt; +<br>
&gt; +#define TYPE_AW_H3_EMAC &quot;allwinner-h3-emac&quot;<br>
&gt; +#define AW_H3_EMAC(obj) OBJECT_CHECK(AwH3EmacState, (obj), TYPE_AW_H3=
_EMAC)<br>
&gt; +<br>
&gt; +typedef struct AwH3EmacState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice=C2=A0 parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq=C2=A0 =C2=A0 =C2=A0irq;<br>
&gt; +=C2=A0 =C2=A0 NICState=C2=A0 =C2=A0 =C2=A0*nic;<br>
&gt; +=C2=A0 =C2=A0 NICConf=C2=A0 =C2=A0 =C2=A0 conf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint8_t=C2=A0 =C2=A0 =C2=A0 mii_phy_addr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0mii_cmd;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0mii_data;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0mii_cr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0mii_st;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0basic_ctl0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0basic_ctl1;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0int_en;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0int_sta;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0frm_flt;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0rx_ctl0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0rx_ctl1;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0rx_desc_head;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0rx_desc_curr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0tx_ctl0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0tx_ctl1;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0tx_desc_head;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0tx_desc_curr;<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0 =C2=A0tx_flowctl;<br>
&gt; +<br>
&gt; +} AwH3EmacState;<br>
&gt; +<br>
&gt; +#endif<br>
&gt; <br>
<br>
The rest seems ok to me. Thanks for the contribution :)!<br></blockquote><d=
iv><br></div><div>Thanks! :-) <br></div><div>=C2=A0</div><div>Regards,</div=
><div>Niek<br></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Cheers,<br>
Fred<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Niek Linnenbank<br><br>WWW: <a href=3D"http://www.nieklinne=
nbank.nl/" target=3D"_blank">http://www.nieklinnenbank.nl/</a><br>BLOG: <a =
href=3D"http://nieklinnenbank.wordpress.com/" target=3D"_blank">http://niek=
linnenbank.wordpress.com/</a><br>FUN:=C2=A0 =C2=A0 <a href=3D"http://www.Fr=
eeNOS.org/" target=3D"_blank">http://www.FreeNOS.org/</a><br></div></div>

--000000000000354d600598d1e4fc--

