Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703B920640
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703B920640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic4aR-0007Fm-VU
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 04:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1ic4Yz-0006P8-BF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1ic4Yt-0001IC-Ha
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:33:43 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:33220
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1ic4Yi-0000yA-PN; Tue, 03 Dec 2019 04:33:29 -0500
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id C39C78137E;
 Tue,  3 Dec 2019 10:33:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7HBRh53_tzvf; Tue,  3 Dec 2019 10:33:20 +0100 (CET)
Received: from localhost.localdomain (lfbn-tou-1-352-33.w86-206.abo.wanadoo.fr
 [86.206.184.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 6D92D8137C;
 Tue,  3 Dec 2019 10:33:20 +0100 (CET)
Subject: Re: [PATCH 10/10] arm: allwinner-h3: add EMAC ethernet device
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-11-nieklinnenbank@gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <a234bebd-d794-7400-c9f8-77561ba46aa3@adacore.com>
Date: Tue, 3 Dec 2019 10:33:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191202210947.3603-11-nieklinnenbank@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.98.77.210
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 12/2/19 =C3=A0 10:09 PM, Niek Linnenbank a =C3=A9crit=C2=A0:
> The Allwinner H3 System on Chip includes an Ethernet MAC (EMAC)
> which provides 10M/100M/1000M Ethernet connectivity. This commit
> adds support for the Allwinner H3 EMAC, including emulation for
> the following functionality:
>=20
>   * DMA transfers
>   * MII interface
>   * Transmit CRC calculation
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   hw/arm/Kconfig                     |   1 +
>   hw/arm/allwinner-h3.c              |  17 +
>   hw/arm/orangepi.c                  |   7 +
>   hw/net/Kconfig                     |   3 +
>   hw/net/Makefile.objs               |   1 +
>   hw/net/allwinner-h3-emac.c         | 786 ++++++++++++++++++++++++++++=
+
>   hw/net/trace-events                |  10 +
>   include/hw/arm/allwinner-h3.h      |   2 +
>   include/hw/net/allwinner-h3-emac.h |  69 +++
>   9 files changed, 896 insertions(+)
>   create mode 100644 hw/net/allwinner-h3-emac.c
>   create mode 100644 include/hw/net/allwinner-h3-emac.h
>=20
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index ebf8d2325f..551cff3442 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -294,6 +294,7 @@ config ALLWINNER_A10
>   config ALLWINNER_H3
>       bool
>       select ALLWINNER_A10_PIT
> +    select ALLWINNER_H3_EMAC
>       select SERIAL
>       select ARM_TIMER
>       select ARM_GIC
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index c2972caf88..274b8548c0 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -53,6 +53,9 @@ static void aw_h3_init(Object *obj)
>  =20
>       sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
>                             TYPE_AW_H3_SDHOST);
> +
> +    sysbus_init_child_obj(obj, "emac", &s->emac, sizeof(s->emac),
> +                          TYPE_AW_H3_EMAC);
>   }
>  =20
>   static void aw_h3_realize(DeviceState *dev, Error **errp)
> @@ -237,6 +240,20 @@ static void aw_h3_realize(DeviceState *dev, Error =
**errp)
>           return;
>       }
>  =20
> +    /* EMAC */
> +    if (nd_table[0].used) {
> +        qemu_check_nic_model(&nd_table[0], TYPE_AW_H3_EMAC);
> +        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> +    }
> +    object_property_set_bool(OBJECT(&s->emac), true, "realized", &err)=
;
> +    if (err !=3D NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbusdev =3D SYS_BUS_DEVICE(&s->emac);
> +    sysbus_mmio_map(sysbusdev, 0, AW_H3_EMAC_BASE);
> +    sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SPI_EMAC]);
> +
>       /* Universal Serial Bus */
>       sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
>                            s->irq[AW_H3_GIC_SPI_EHCI0]);
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index dee3efaf08..8a61eb0e69 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -61,6 +61,13 @@ static void orangepi_init(MachineState *machine)
>           exit(1);
>       }
>  =20
> +    /* Setup EMAC properties */
> +    object_property_set_int(OBJECT(&s->h3->emac), 1, "phy-addr", &err)=
;
> +    if (err !=3D NULL) {
> +        error_reportf_err(err, "Couldn't set phy address: ");
> +        exit(1);
> +    }
> +
>       /* Mark H3 object realized */
>       object_property_set_bool(OBJECT(s->h3), true, "realized", &err);
>       if (err !=3D NULL) {
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 3856417d42..36d3923992 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -74,6 +74,9 @@ config MIPSNET
>   config ALLWINNER_EMAC
>       bool
>  =20
> +config ALLWINNER_H3_EMAC
> +    bool
> +
>   config IMX_FEC
>       bool
>  =20
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index 7907d2c199..5548deb07a 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -23,6 +23,7 @@ common-obj-$(CONFIG_XGMAC) +=3D xgmac.o
>   common-obj-$(CONFIG_MIPSNET) +=3D mipsnet.o
>   common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axienet.o
>   common-obj-$(CONFIG_ALLWINNER_EMAC) +=3D allwinner_emac.o
> +common-obj-$(CONFIG_ALLWINNER_H3_EMAC) +=3D allwinner-h3-emac.o
>   common-obj-$(CONFIG_IMX_FEC) +=3D imx_fec.o
>  =20
>   common-obj-$(CONFIG_CADENCE) +=3D cadence_gem.o
> diff --git a/hw/net/allwinner-h3-emac.c b/hw/net/allwinner-h3-emac.c
> new file mode 100644
> index 0000000000..37f6f44406
> --- /dev/null
> +++ b/hw/net/allwinner-h3-emac.c
> @@ -0,0 +1,786 @@
> +/*
> + * Allwinner H3 EMAC emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "net/net.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "net/checksum.h"
> +#include "qemu/module.h"
> +#include "exec/cpu-common.h"
> +#include "hw/net/allwinner-h3-emac.h"
> +
> +/* EMAC register offsets */
> +#define REG_BASIC_CTL_0        (0x0000) /* Basic Control 0 */
> +#define REG_BASIC_CTL_1        (0x0004) /* Basic Control 1 */
> +#define REG_INT_STA            (0x0008) /* Interrupt Status */
> +#define REG_INT_EN             (0x000C) /* Interrupt Enable */
> +#define REG_TX_CTL_0           (0x0010) /* Transmit Control 0 */
> +#define REG_TX_CTL_1           (0x0014) /* Transmit Control 1 */
> +#define REG_TX_FLOW_CTL        (0x001C) /* Transmit Flow Control */
> +#define REG_TX_DMA_DESC_LIST   (0x0020) /* Transmit Descriptor List Ad=
dress */
> +#define REG_RX_CTL_0           (0x0024) /* Receive Control 0 */
> +#define REG_RX_CTL_1           (0x0028) /* Receive Control 1 */
> +#define REG_RX_DMA_DESC_LIST   (0x0034) /* Receive Descriptor List Add=
ress */
> +#define REG_FRM_FLT            (0x0038) /* Receive Frame Filter */
> +#define REG_RX_HASH_0          (0x0040) /* Receive Hash Table 0 */
> +#define REG_RX_HASH_1          (0x0044) /* Receive Hash Table 1 */
> +#define REG_MII_CMD            (0x0048) /* Management Interface Comman=
d */
> +#define REG_MII_DATA           (0x004C) /* Management Interface Data *=
/
> +#define REG_ADDR_HIGH          (0x0050) /* MAC Address High */
> +#define REG_ADDR_LOW           (0x0054) /* MAC Address Low */
> +#define REG_TX_DMA_STA         (0x00B0) /* Transmit DMA Status */
> +#define REG_TX_CUR_DESC        (0x00B4) /* Transmit Current Descriptor=
 */
> +#define REG_TX_CUR_BUF         (0x00B8) /* Transmit Current Buffer */
> +#define REG_RX_DMA_STA         (0x00C0) /* Receive DMA Status */
> +#define REG_RX_CUR_DESC        (0x00C4) /* Receive Current Descriptor =
*/
> +#define REG_RX_CUR_BUF         (0x00C8) /* Receive Current Buffer */
> +#define REG_RGMII_STA          (0x00D0) /* RGMII Status */
> +
> +/* EMAC register flags */
> +#define BASIC_CTL0_100Mbps     (0b11 << 2)
> +#define BASIC_CTL0_FD          (1 << 0)
> +#define BASIC_CTL1_SOFTRST     (1 << 0)
> +
> +#define INT_STA_RGMII_LINK     (1 << 16)
> +#define INT_STA_RX_EARLY       (1 << 13)
> +#define INT_STA_RX_OVERFLOW    (1 << 12)
> +#define INT_STA_RX_TIMEOUT     (1 << 11)
> +#define INT_STA_RX_DMA_STOP    (1 << 10)
> +#define INT_STA_RX_BUF_UA      (1 << 9)
> +#define INT_STA_RX             (1 << 8)
> +#define INT_STA_TX_EARLY       (1 << 5)
> +#define INT_STA_TX_UNDERFLOW   (1 << 4)
> +#define INT_STA_TX_TIMEOUT     (1 << 3)
> +#define INT_STA_TX_BUF_UA      (1 << 2)
> +#define INT_STA_TX_DMA_STOP    (1 << 1)
> +#define INT_STA_TX             (1 << 0)
> +
> +#define INT_EN_RX_EARLY        (1 << 13)
> +#define INT_EN_RX_OVERFLOW     (1 << 12)
> +#define INT_EN_RX_TIMEOUT      (1 << 11)
> +#define INT_EN_RX_DMA_STOP     (1 << 10)
> +#define INT_EN_RX_BUF_UA       (1 << 9)
> +#define INT_EN_RX              (1 << 8)
> +#define INT_EN_TX_EARLY        (1 << 5)
> +#define INT_EN_TX_UNDERFLOW    (1 << 4)
> +#define INT_EN_TX_TIMEOUT      (1 << 3)
> +#define INT_EN_TX_BUF_UA       (1 << 2)
> +#define INT_EN_TX_DMA_STOP     (1 << 1)
> +#define INT_EN_TX              (1 << 0)
> +
> +#define TX_CTL0_TX_EN          (1 << 31)
> +#define TX_CTL1_TX_DMA_START   (1 << 31)
> +#define TX_CTL1_TX_DMA_EN      (1 << 30)
> +#define TX_CTL1_TX_FLUSH       (1 << 0)
> +
> +#define RX_CTL0_RX_EN          (1 << 31)
> +#define RX_CTL0_STRIP_FCS      (1 << 28)
> +#define RX_CTL0_CRC_IPV4       (1 << 27)
> +
> +#define RX_CTL1_RX_DMA_START   (1 << 31)
> +#define RX_CTL1_RX_DMA_EN      (1 << 30)
> +#define RX_CTL1_RX_MD          (1 << 1)
> +
> +#define RX_FRM_FLT_DIS_ADDR    (1 << 31)
> +
> +#define MII_CMD_PHY_ADDR_SHIFT (12)
> +#define MII_CMD_PHY_ADDR_MASK  (0xf000)
> +#define MII_CMD_PHY_REG_SHIFT  (4)
> +#define MII_CMD_PHY_REG_MASK   (0xf0)
> +#define MII_CMD_PHY_RW         (1 << 1)
> +#define MII_CMD_PHY_BUSY       (1 << 0)
> +
> +#define TX_DMA_STA_STOP        (0b000)
> +#define TX_DMA_STA_RUN_FETCH   (0b001)
> +#define TX_DMA_STA_WAIT_STA    (0b010)
> +
> +#define RX_DMA_STA_STOP        (0b000)
> +#define RX_DMA_STA_RUN_FETCH   (0b001)
> +#define RX_DMA_STA_WAIT_FRM    (0b011)
> +
> +#define RGMII_LINK_UP          (1 << 3)
> +#define RGMII_FD               (1 << 0)
> +
> +/* EMAC register reset values */
> +#define REG_BASIC_CTL_1_RST    (0x08000000)
> +
> +/* EMAC constants */
> +#define AW_H3_EMAC_MIN_PKT_SZ  (64)
> +
> +/* Transmit/receive frame descriptor */
> +typedef struct FrameDescriptor {
> +    uint32_t status;
> +    uint32_t status2;
> +    uint32_t addr;
> +    uint32_t next;
> +} FrameDescriptor;
> +
> +/* Frame descriptor flags */
> +#define DESC_STATUS_CTL                 (1 << 31)
> +#define DESC_STATUS2_BUF_SIZE_MASK      (0x7ff)
> +
> +/* Transmit frame descriptor flags */
> +#define TX_DESC_STATUS_LENGTH_ERR       (1 << 14)
> +#define TX_DESC_STATUS2_FIRST_DESC      (1 << 29)
> +#define TX_DESC_STATUS2_LAST_DESC       (1 << 30)
> +#define TX_DESC_STATUS2_CHECKSUM_MASK   (0x3 << 27)
> +
> +/* Receive frame descriptor flags */
> +#define RX_DESC_STATUS_FIRST_DESC       (1 << 9)
> +#define RX_DESC_STATUS_LAST_DESC        (1 << 8)
> +#define RX_DESC_STATUS_FRM_LEN_MASK     (0x3fff0000)
> +#define RX_DESC_STATUS_FRM_LEN_SHIFT    (16)
> +#define RX_DESC_STATUS_NO_BUF           (1 << 14)
> +#define RX_DESC_STATUS_HEADER_ERR       (1 << 7)
> +#define RX_DESC_STATUS_LENGTH_ERR       (1 << 4)
> +#define RX_DESC_STATUS_CRC_ERR          (1 << 1)
> +#define RX_DESC_STATUS_PAYLOAD_ERR      (1 << 0)
> +#define RX_DESC_STATUS2_RX_INT_CTL      (1 << 31)
> +
> +/* MII register offsets */
> +#define MII_REG_CR                      (0x0)
> +#define MII_REG_ST                      (0x1)
> +#define MII_REG_ID_HIGH                 (0x2)
> +#define MII_REG_ID_LOW                  (0x3)
> +
> +/* MII register flags */
> +#define MII_REG_CR_RESET                (1 << 15)
> +#define MII_REG_CR_POWERDOWN            (1 << 11)
> +#define MII_REG_CR_10Mbit               (0)
> +#define MII_REG_CR_100Mbit              (1 << 13)
> +#define MII_REG_CR_1000Mbit             (1 << 6)
> +#define MII_REG_CR_AUTO_NEG             (1 << 12)
> +#define MII_REG_CR_AUTO_NEG_RESTART     (1 << 9)
> +#define MII_REG_CR_FULLDUPLEX           (1 << 8)
> +
> +#define MII_REG_ST_100BASE_T4           (1 << 15)
> +#define MII_REG_ST_100BASE_X_FD         (1 << 14)
> +#define MII_REG_ST_100BASE_X_HD         (1 << 13)
> +#define MII_REG_ST_10_FD                (1 << 12)
> +#define MII_REG_ST_10_HD                (1 << 11)
> +#define MII_REG_ST_100BASE_T2_FD        (1 << 10)
> +#define MII_REG_ST_100BASE_T2_HD        (1 << 9)
> +#define MII_REG_ST_AUTONEG_COMPLETE     (1 << 5)
> +#define MII_REG_ST_AUTONEG_AVAIL        (1 << 3)
> +#define MII_REG_ST_LINK_UP              (1 << 2)
> +
> +/* MII constants */
> +#define MII_PHY_ID_HIGH                 (0x0044)
> +#define MII_PHY_ID_LOW                  (0x1400)

I wonder if we can't share all those mii stuff accross the network adapte=
rs
instead of redoing the work everytime. I've some patches about it I may p=
ost
them sometimes.

> +
> +static void aw_h3_emac_mii_set_link(AwH3EmacState *s, bool link_active=
)
> +{
> +    if (link_active) {
> +        s->mii_st |=3D MII_REG_ST_LINK_UP;
> +    } else {
> +        s->mii_st &=3D ~MII_REG_ST_LINK_UP;
> +    }
> +}
> +
> +static void aw_h3_emac_mii_reset(AwH3EmacState *s, bool link_active)
> +{
> +    s->mii_cr =3D MII_REG_CR_100Mbit | MII_REG_CR_AUTO_NEG |
> +                MII_REG_CR_FULLDUPLEX;
> +    s->mii_st =3D MII_REG_ST_100BASE_T4 | MII_REG_ST_100BASE_X_FD |
> +                MII_REG_ST_100BASE_X_HD | MII_REG_ST_10_FD | MII_REG_S=
T_10_HD |
> +                MII_REG_ST_100BASE_T2_FD | MII_REG_ST_100BASE_T2_HD |
> +                MII_REG_ST_AUTONEG_COMPLETE | MII_REG_ST_AUTONEG_AVAIL=
;
> +
> +    aw_h3_emac_mii_set_link(s, link_active);
> +}
> +
> +static void aw_h3_emac_mii_cmd(AwH3EmacState *s)
> +{
> +    uint8_t addr, reg;
> +
> +    addr =3D (s->mii_cmd & MII_CMD_PHY_ADDR_MASK) >> MII_CMD_PHY_ADDR_=
SHIFT;
> +    reg =3D (s->mii_cmd & MII_CMD_PHY_REG_MASK) >> MII_CMD_PHY_REG_SHI=
FT;
> +
> +    if (addr !=3D s->mii_phy_addr) {
> +        return;
> +    }
> +
> +    /* Read or write a PHY register? */
> +    if (s->mii_cmd & MII_CMD_PHY_RW) {
> +        trace_aw_h3_emac_mii_write_reg(reg, s->mii_data);
> +
> +        switch (reg) {
> +        case MII_REG_CR:
> +            if (s->mii_data & MII_REG_CR_RESET) {
> +                aw_h3_emac_mii_reset(s, s->mii_st & MII_REG_ST_LINK_UP=
);
> +            } else {
> +                s->mii_cr =3D s->mii_data & ~(MII_REG_CR_RESET |
> +                                            MII_REG_CR_AUTO_NEG_RESTAR=
T);
> +            }
> +            break;
> +        default:
> +            qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: write access =
to "
> +                                     "unknown MII register 0x%x\n", re=
g);
> +            break;
> +        }
> +    } else {
> +        switch (reg) {
> +        case MII_REG_CR:
> +            s->mii_data =3D s->mii_cr;
> +            break;
> +        case MII_REG_ST:
> +            s->mii_data =3D s->mii_st;
> +            break;
> +        case MII_REG_ID_HIGH:
> +            s->mii_data =3D MII_PHY_ID_HIGH;
> +            break;
> +        case MII_REG_ID_LOW:
> +            s->mii_data =3D MII_PHY_ID_LOW;
> +            break;
> +        default:
> +            qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: read access t=
o "
> +                                     "unknown MII register 0x%x\n", re=
g);
> +            s->mii_data =3D 0;
> +            break;
> +        }
> +
> +        trace_aw_h3_emac_mii_read_reg(reg, s->mii_data);
> +    }
> +}
> +
> +static void aw_h3_emac_update_irq(AwH3EmacState *s)
> +{
> +    qemu_set_irq(s->irq, (s->int_sta & s->int_en) !=3D 0);
> +}
> +
> +static uint32_t aw_h3_emac_next_desc(FrameDescriptor *desc, size_t min=
_size)
> +{
> +    uint32_t paddr =3D desc->next;
> +
> +    cpu_physical_memory_read(paddr, desc, sizeof(*desc));
> +
> +    if ((desc->status & DESC_STATUS_CTL) &&
> +        (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >=3D min_size) {
> +        return paddr;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static uint32_t aw_h3_emac_get_desc(FrameDescriptor *desc, uint32_t st=
art_addr,
> +                                    size_t min_size)
> +{
> +    uint32_t desc_addr =3D start_addr;
> +
> +    /* Note that the list is a cycle. Last entry points back to the he=
ad. */
> +    while (desc_addr !=3D 0) {
> +        cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
> +
> +        if ((desc->status & DESC_STATUS_CTL) &&
> +            (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >=3D min_size=
) {
> +            return desc_addr;
> +        } else if (desc->next =3D=3D start_addr) {
> +            break;
> +        } else {
> +            desc_addr =3D desc->next;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t aw_h3_emac_get_rx_desc(AwH3EmacState *s, FrameDescript=
or *desc,
> +                                       size_t min_size)
> +{
> +    return aw_h3_emac_get_desc(desc, s->rx_desc_curr, min_size);
> +}
> +
> +static uint32_t aw_h3_emac_get_tx_desc(AwH3EmacState *s, FrameDescript=
or *desc,
> +                                       size_t min_size)
> +{
> +    return aw_h3_emac_get_desc(desc, s->tx_desc_head, min_size);
> +}
> +
> +static void aw_h3_emac_flush_desc(FrameDescriptor *desc, uint32_t phys=
_addr)
> +{
> +    cpu_physical_memory_write(phys_addr, desc, sizeof(*desc));
> +}
> +
> +static int aw_h3_emac_can_receive(NetClientState *nc)
> +{
> +    AwH3EmacState *s =3D qemu_get_nic_opaque(nc);
> +    FrameDescriptor desc;
> +
> +    return (s->rx_ctl0 & RX_CTL0_RX_EN) &&
> +           (aw_h3_emac_get_rx_desc(s, &desc, 0) !=3D 0);
> +}
> +
> +static ssize_t aw_h3_emac_receive(NetClientState *nc, const uint8_t *b=
uf,
> +                                  size_t size)
> +{
> +    AwH3EmacState *s =3D qemu_get_nic_opaque(nc);
> +    FrameDescriptor desc;
> +    size_t bytes_left =3D size;
> +    size_t desc_bytes =3D 0;
> +    size_t pad_fcs_size =3D 4;
> +    size_t padding =3D 0;
> +
> +    if (!(s->rx_ctl0 & RX_CTL0_RX_EN)) {
> +        return -1;
> +    }
> +
> +    s->rx_desc_curr =3D aw_h3_emac_get_rx_desc(s, &desc, AW_H3_EMAC_MI=
N_PKT_SZ);
> +    if (!s->rx_desc_curr) {
> +        s->int_sta |=3D INT_STA_RX_BUF_UA;
> +    }
> +
> +    /* Keep filling RX descriptors until the whole frame is written */
> +    while (s->rx_desc_curr && bytes_left > 0) {
> +        desc.status &=3D ~DESC_STATUS_CTL;
> +        desc.status &=3D ~RX_DESC_STATUS_FRM_LEN_MASK;
> +
> +        if (bytes_left =3D=3D size) {
> +            desc.status |=3D RX_DESC_STATUS_FIRST_DESC;
> +        }
> +
> +        if ((desc.status2 & DESC_STATUS2_BUF_SIZE_MASK) <
> +            (bytes_left + pad_fcs_size)) {
> +            desc_bytes =3D desc.status2 & DESC_STATUS2_BUF_SIZE_MASK;
> +            desc.status |=3D desc_bytes << RX_DESC_STATUS_FRM_LEN_SHIF=
T;
> +        } else {
> +            padding =3D pad_fcs_size;
> +            if (bytes_left < AW_H3_EMAC_MIN_PKT_SZ) {
> +                padding +=3D (AW_H3_EMAC_MIN_PKT_SZ - bytes_left);
> +            }
> +
> +            desc_bytes =3D (bytes_left);
> +            desc.status |=3D RX_DESC_STATUS_LAST_DESC;
> +            desc.status |=3D (bytes_left + padding)
> +                            << RX_DESC_STATUS_FRM_LEN_SHIFT;
> +        }
> +
> +        cpu_physical_memory_write(desc.addr, buf, desc_bytes);
> +        aw_h3_emac_flush_desc(&desc, s->rx_desc_curr);
> +        trace_aw_h3_emac_receive(s->rx_desc_curr, desc.addr, desc_byte=
s);
> +
> +        /* Check if frame needs to raise the receive interrupt */
> +        if (!(desc.status2 & RX_DESC_STATUS2_RX_INT_CTL)) {
> +            s->int_sta |=3D INT_STA_RX;
> +        }
> +
> +        /* Increment variables */
> +        buf +=3D desc_bytes;
> +        bytes_left -=3D desc_bytes;
> +
> +        /* Move to the next descriptor */
> +        s->rx_desc_curr =3D aw_h3_emac_next_desc(&desc, 64);
> +        if (!s->rx_desc_curr) {
> +            /* Not enough buffer space available */
> +            s->int_sta |=3D INT_STA_RX_BUF_UA;
> +            s->rx_desc_curr =3D s->rx_desc_head;
> +            break;
> +        }
> +    }
> +
> +    /* Report receive DMA is finished */
> +    s->rx_ctl1 &=3D ~RX_CTL1_RX_DMA_START;
> +    aw_h3_emac_update_irq(s);
> +
> +    return size;
> +}
> +
> +static void aw_h3_emac_transmit(AwH3EmacState *s)
> +{
> +    NetClientState *nc =3D qemu_get_queue(s->nic);
> +    FrameDescriptor desc;
> +    size_t bytes =3D 0;
> +    size_t packet_bytes =3D 0;
> +    size_t transmitted =3D 0;
> +    static uint8_t packet_buf[2048];
> +
> +    s->tx_desc_curr =3D aw_h3_emac_get_tx_desc(s, &desc, 0);
> +
> +    /* Read all transmit descriptors */
> +    while (s->tx_desc_curr !=3D 0) {
> +
> +        /* Read from physical memory into packet buffer */
> +        bytes =3D desc.status2 & DESC_STATUS2_BUF_SIZE_MASK;
> +        if (bytes + packet_bytes > sizeof(packet_buf)) {
> +            desc.status |=3D TX_DESC_STATUS_LENGTH_ERR;
> +            break;
> +        }
> +        cpu_physical_memory_read(desc.addr, packet_buf + packet_bytes,=
 bytes);
> +        packet_bytes +=3D bytes;
> +        desc.status &=3D ~DESC_STATUS_CTL;
> +        aw_h3_emac_flush_desc(&desc, s->tx_desc_curr);
> +
> +        /* After the last descriptor, send the packet */
> +        if (desc.status2 & TX_DESC_STATUS2_LAST_DESC) {
> +            if (desc.status2 & TX_DESC_STATUS2_CHECKSUM_MASK) {
> +                net_checksum_calculate(packet_buf, packet_bytes);
> +            }
> +
> +            qemu_send_packet(nc, packet_buf, packet_bytes);
> +            trace_aw_h3_emac_transmit(s->tx_desc_curr, desc.addr, byte=
s);
> +
> +            packet_bytes =3D 0;
> +            transmitted++;
> +        }
> +        s->tx_desc_curr =3D aw_h3_emac_next_desc(&desc, 0);
> +    }
> +
> +    /* Raise transmit completed interrupt */
> +    if (transmitted > 0) {
> +        s->int_sta |=3D INT_STA_TX;
> +        s->tx_ctl1 &=3D ~TX_CTL1_TX_DMA_START;
> +        aw_h3_emac_update_irq(s);
> +    }
> +}
> +
> +static void aw_h3_emac_reset(DeviceState *dev)
> +{
> +    AwH3EmacState *s =3D AW_H3_EMAC(dev);
> +    NetClientState *nc =3D qemu_get_queue(s->nic);
> +
> +    trace_aw_h3_emac_reset();
> +
> +    s->mii_cmd =3D 0;
> +    s->mii_data =3D 0;
> +    s->basic_ctl0 =3D 0;
> +    s->basic_ctl1 =3D 0;
> +    s->int_en =3D 0;
> +    s->int_sta =3D 0;
> +    s->frm_flt =3D 0;
> +    s->rx_ctl0 =3D 0;
> +    s->rx_ctl1 =3D RX_CTL1_RX_MD;
> +    s->rx_desc_head =3D 0;
> +    s->rx_desc_curr =3D 0;
> +    s->tx_ctl0 =3D 0;
> +    s->tx_ctl1 =3D 0;
> +    s->tx_desc_head =3D 0;
> +    s->tx_desc_curr =3D 0;
> +    s->tx_flowctl =3D 0;
> +
> +    aw_h3_emac_mii_reset(s, !nc->link_down);
> +}
> +
> +static uint64_t aw_h3_emac_read(void *opaque, hwaddr offset, unsigned =
size)
> +{
> +    AwH3EmacState *s =3D opaque;

I'd put AW_H3_EMAC(opaque) here.

> +    uint64_t value =3D 0;
> +    FrameDescriptor desc;
> +
> +    switch (offset) {
> +    case REG_BASIC_CTL_0:       /* Basic Control 0 */
> +        value =3D s->basic_ctl0;
> +        break;
> +    case REG_BASIC_CTL_1:       /* Basic Control 1 */
> +        value =3D s->basic_ctl1;
> +        break;
> +    case REG_INT_STA:           /* Interrupt Status */
> +        value =3D s->int_sta;
> +        break;
> +    case REG_INT_EN:            /* Interupt Enable */
> +        value =3D s->int_en;
> +        break;
> +    case REG_TX_CTL_0:          /* Transmit Control 0 */
> +        value =3D s->tx_ctl0;
> +        break;
> +    case REG_TX_CTL_1:          /* Transmit Control 1 */
> +        value =3D s->tx_ctl1;
> +        break;
> +    case REG_TX_FLOW_CTL:       /* Transmit Flow Control */
> +        value =3D s->tx_flowctl;
> +        break;
> +    case REG_TX_DMA_DESC_LIST:  /* Transmit Descriptor List Address */
> +        value =3D s->tx_desc_head;
> +        break;
> +    case REG_RX_CTL_0:          /* Receive Control 0 */
> +        value =3D s->rx_ctl0;
> +        break;
> +    case REG_RX_CTL_1:          /* Receive Control 1 */
> +        value =3D s->rx_ctl1;
> +        break;
> +    case REG_RX_DMA_DESC_LIST:  /* Receive Descriptor List Address */
> +        value =3D s->rx_desc_head;
> +        break;
> +    case REG_FRM_FLT:           /* Receive Frame Filter */
> +        value =3D s->frm_flt;
> +        break;
> +    case REG_RX_HASH_0:         /* Receive Hash Table 0 */
> +    case REG_RX_HASH_1:         /* Receive Hash Table 1 */
> +        break;
> +    case REG_MII_CMD:           /* Management Interface Command */
> +        value =3D s->mii_cmd;
> +        break;
> +    case REG_MII_DATA:          /* Management Interface Data */
> +        value =3D s->mii_data;
> +        break;
> +    case REG_ADDR_HIGH:         /* MAC Address High */
> +        value =3D *(((uint32_t *) (s->conf.macaddr.a)) + 1);
> +        break;
> +    case REG_ADDR_LOW:          /* MAC Address Low */
> +        value =3D *(uint32_t *) (s->conf.macaddr.a);
> +        break;
> +    case REG_TX_DMA_STA:        /* Transmit DMA Status */
> +        break;
> +    case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
> +        value =3D s->tx_desc_curr;
> +        break;
> +    case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
> +        if (s->tx_desc_curr !=3D 0) {
> +            cpu_physical_memory_read(s->tx_desc_curr, &desc, sizeof(de=
sc));
> +            value =3D desc.addr;
> +        } else {
> +            value =3D 0;
> +        }
> +        break;
> +    case REG_RX_DMA_STA:        /* Receive DMA Status */
> +        break;
> +    case REG_RX_CUR_DESC:       /* Receive Current Descriptor */
> +        value =3D s->rx_desc_curr;
> +        break;
> +    case REG_RX_CUR_BUF:        /* Receive Current Buffer */
> +        if (s->rx_desc_curr !=3D 0) {
> +            cpu_physical_memory_read(s->rx_desc_curr, &desc, sizeof(de=
sc));
> +            value =3D desc.addr;
> +        } else {
> +            value =3D 0;
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: read access to un=
known "
> +                                 "EMAC register 0x" TARGET_FMT_plx "\n=
",
> +                                  offset);
> +    }
> +
> +    trace_aw_h3_emac_read(offset, value);
> +    return value;
> +}
> +
> +static void aw_h3_emac_write(void *opaque, hwaddr offset, uint64_t val=
ue,
> +                             unsigned size)
> +{
> +    AwH3EmacState *s =3D opaque;

The same.

> +    NetClientState *nc =3D qemu_get_queue(s->nic);
> +
> +    trace_aw_h3_emac_write(offset, value);
> +
> +    switch (offset) {
> +    case REG_BASIC_CTL_0:       /* Basic Control 0 */
> +        s->basic_ctl0 =3D value;
> +        break;
> +    case REG_BASIC_CTL_1:       /* Basic Control 1 */
> +        if (value & BASIC_CTL1_SOFTRST) {
> +            aw_h3_emac_reset(DEVICE(s));
> +            value &=3D ~BASIC_CTL1_SOFTRST;
> +        }
> +        s->basic_ctl1 =3D value;
> +        if (aw_h3_emac_can_receive(nc)) {
> +            qemu_flush_queued_packets(nc);
> +        }
> +        break;
> +    case REG_INT_STA:           /* Interrupt Status */
> +        s->int_sta &=3D ~value;
> +        aw_h3_emac_update_irq(s);
> +        break;
> +    case REG_INT_EN:            /* Interrupt Enable */
> +        s->int_en =3D value;
> +        aw_h3_emac_update_irq(s);
> +        break;
> +    case REG_TX_CTL_0:          /* Transmit Control 0 */
> +        s->tx_ctl0 =3D value;
> +        break;
> +    case REG_TX_CTL_1:          /* Transmit Control 1 */
> +        s->tx_ctl1 =3D value;
> +        if (value & TX_CTL1_TX_DMA_EN) {
> +            aw_h3_emac_transmit(s);
> +        }
> +        break;
> +    case REG_TX_FLOW_CTL:       /* Transmit Flow Control */
> +        s->tx_flowctl =3D value;
> +        break;
> +    case REG_TX_DMA_DESC_LIST:  /* Transmit Descriptor List Address */
> +        s->tx_desc_head =3D value;
> +        s->tx_desc_curr =3D value;
> +        break;
> +    case REG_RX_CTL_0:          /* Receive Control 0 */
> +        s->rx_ctl0 =3D value;
> +        break;
> +    case REG_RX_CTL_1:          /* Receive Control 1 */
> +        s->rx_ctl1 =3D value | RX_CTL1_RX_MD;
> +        if ((value & RX_CTL1_RX_DMA_EN) && aw_h3_emac_can_receive(nc))=
 {
> +            qemu_flush_queued_packets(nc);
> +        }
> +        break;
> +    case REG_RX_DMA_DESC_LIST:  /* Receive Descriptor List Address */
> +        s->rx_desc_head =3D value;
> +        s->rx_desc_curr =3D value;
> +        break;
> +    case REG_FRM_FLT:           /* Receive Frame Filter */
> +        s->frm_flt =3D value;
> +        break;
> +    case REG_RX_HASH_0:         /* Receive Hash Table 0 */
> +    case REG_RX_HASH_1:         /* Receive Hash Table 1 */
> +        break;
> +    case REG_MII_CMD:           /* Management Interface Command */
> +        s->mii_cmd =3D value & ~MII_CMD_PHY_BUSY;
> +        aw_h3_emac_mii_cmd(s);
> +        break;
> +    case REG_MII_DATA:          /* Management Interface Data */
> +        s->mii_data =3D value;
> +        break;
> +    case REG_ADDR_HIGH:         /* MAC Address High */
> +        s->conf.macaddr.a[4] =3D (value & 0xff);
> +        s->conf.macaddr.a[5] =3D (value & 0xff00) >> 8;
> +        break;
> +    case REG_ADDR_LOW:          /* MAC Address Low */
> +        s->conf.macaddr.a[0] =3D (value & 0xff);
> +        s->conf.macaddr.a[1] =3D (value & 0xff00) >> 8;
> +        s->conf.macaddr.a[2] =3D (value & 0xff0000) >> 16;
> +        s->conf.macaddr.a[3] =3D (value & 0xff000000) >> 24;
> +        break;
> +    case REG_TX_DMA_STA:        /* Transmit DMA Status */
> +    case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
> +    case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
> +    case REG_RX_DMA_STA:        /* Receive DMA Status */
> +    case REG_RX_CUR_DESC:       /* Receive Current Descriptor */
> +    case REG_RX_CUR_BUF:        /* Receive Current Buffer */
> +    case REG_RGMII_STA:         /* RGMII Status */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "allwinner-h3-emac: write access to u=
nknown "
> +                                 "EMAC register 0x" TARGET_FMT_plx "\n=
",
> +                                  offset);
> +    }
> +}
> +
> +static void aw_h3_emac_set_link(NetClientState *nc)
> +{
> +    AwH3EmacState *s =3D qemu_get_nic_opaque(nc);
> +
> +    trace_aw_h3_emac_set_link(!nc->link_down);
> +    aw_h3_emac_mii_set_link(s, !nc->link_down);
> +}
> +
> +static const MemoryRegionOps aw_h3_emac_mem_ops =3D {
> +    .read =3D aw_h3_emac_read,
> +    .write =3D aw_h3_emac_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static NetClientInfo net_aw_h3_emac_info =3D {
> +    .type =3D NET_CLIENT_DRIVER_NIC,
> +    .size =3D sizeof(NICState),
> +    .can_receive =3D aw_h3_emac_can_receive,
> +    .receive =3D aw_h3_emac_receive,
> +    .link_status_changed =3D aw_h3_emac_set_link,
> +};
> +
> +static void aw_h3_emac_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    AwH3EmacState *s =3D AW_H3_EMAC(obj);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &aw_h3_emac_mem_ops, s=
,
> +                          TYPE_AW_H3_EMAC, AW_H3_EMAC_REGS_MEM_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static void aw_h3_emac_realize(DeviceState *dev, Error **errp)
> +{
> +    AwH3EmacState *s =3D AW_H3_EMAC(dev);
> +
> +    qemu_macaddr_default_if_unset(&s->conf.macaddr);
> +    s->nic =3D qemu_new_nic(&net_aw_h3_emac_info, &s->conf,
> +                          object_get_typename(OBJECT(dev)), dev->id, s=
);
> +    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a=
);
> +}
> +
> +static Property aw_h3_emac_properties[] =3D {
> +    DEFINE_NIC_PROPERTIES(AwH3EmacState, conf),
> +    DEFINE_PROP_UINT8("phy-addr", AwH3EmacState, mii_phy_addr, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static int aw_h3_emac_post_load(void *opaque, int version_id)
> +{
> +    AwH3EmacState *s =3D opaque;
> +
> +    aw_h3_emac_set_link(qemu_get_queue(s->nic));
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_aw_emac =3D {
> +    .name =3D TYPE_AW_H3_EMAC,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D aw_h3_emac_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mii_phy_addr, AwH3EmacState),
> +        VMSTATE_UINT32(mii_cmd, AwH3EmacState),
> +        VMSTATE_UINT32(mii_data, AwH3EmacState),
> +        VMSTATE_UINT32(basic_ctl0, AwH3EmacState),
> +        VMSTATE_UINT32(basic_ctl1, AwH3EmacState),
> +        VMSTATE_UINT32(int_en, AwH3EmacState),
> +        VMSTATE_UINT32(int_sta, AwH3EmacState),
> +        VMSTATE_UINT32(frm_flt, AwH3EmacState),
> +        VMSTATE_UINT32(rx_ctl0, AwH3EmacState),
> +        VMSTATE_UINT32(rx_ctl1, AwH3EmacState),
> +        VMSTATE_UINT32(rx_desc_head, AwH3EmacState),
> +        VMSTATE_UINT32(rx_desc_curr, AwH3EmacState),
> +        VMSTATE_UINT32(tx_ctl0, AwH3EmacState),
> +        VMSTATE_UINT32(tx_ctl1, AwH3EmacState),
> +        VMSTATE_UINT32(tx_desc_head, AwH3EmacState),
> +        VMSTATE_UINT32(tx_desc_curr, AwH3EmacState),
> +        VMSTATE_UINT32(tx_flowctl, AwH3EmacState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void aw_h3_emac_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D aw_h3_emac_realize;
> +    dc->props =3D aw_h3_emac_properties;
> +    dc->reset =3D aw_h3_emac_reset;
> +    dc->vmsd =3D &vmstate_aw_emac;
> +}
> +
> +static const TypeInfo aw_h3_emac_info =3D {
> +    .name           =3D TYPE_AW_H3_EMAC,
> +    .parent         =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size  =3D sizeof(AwH3EmacState),
> +    .instance_init  =3D aw_h3_emac_init,
> +    .class_init     =3D aw_h3_emac_class_init,
> +};
> +
> +static void aw_h3_emac_register_types(void)
> +{
> +    type_register_static(&aw_h3_emac_info);
> +}
> +
> +type_init(aw_h3_emac_register_types)
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e70f12bee1..e9e2f26f68 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -1,5 +1,15 @@
>   # See docs/devel/tracing.txt for syntax documentation.
>  =20
> +# allwinner-h3-emac.c
> +aw_h3_emac_mii_write_reg(uint32_t reg, uint32_t value) "MII write: reg=
=3D0x%x value=3D0x%x"
> +aw_h3_emac_mii_read_reg(uint32_t reg, uint32_t value) "MII read: reg=3D=
0x%x value=3D0x%x"
> +aw_h3_emac_receive(uint32_t desc, uint32_t paddr, uint32_t bytes) "RX =
packet: desc=3D0x%08x paddr=3D0x%08x bytes=3D%u"
> +aw_h3_emac_transmit(uint32_t desc, uint32_t paddr, uint32_t bytes) "TX=
 packet: desc=3D0x%08x paddr=3D0x%08x bytes=3D%u"
> +aw_h3_emac_reset(void) "HW reset"
> +aw_h3_emac_set_link(bool active) "Set link: active=3D%u"
> +aw_h3_emac_read(uint64_t offset, uint64_t val) "MMIO read: offset=3D0x=
%" PRIx64 " value=3D0x%" PRIx64
> +aw_h3_emac_write(uint64_t offset, uint64_t val) "MMIO write: offset=3D=
0x%" PRIx64 " value=3D0x%" PRIx64
> +
>   # etraxfs_eth.c
>   mdio_phy_read(int regnum, uint16_t value) "read phy_reg:%d value:0x%0=
4x"
>   mdio_phy_write(int regnum, uint16_t value) "write phy_reg:%d value:0x=
%04x"
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h=
3.h
> index 7aff4ebbd2..b964a60f41 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -31,6 +31,7 @@
>   #include "hw/misc/allwinner-h3-syscon.h"
>   #include "hw/misc/allwinner-h3-sid.h"
>   #include "hw/sd/allwinner-h3-sdhost.h"
> +#include "hw/net/allwinner-h3-emac.h"
>   #include "target/arm/cpu.h"
>  =20
>   #define AW_H3_SRAM_A1_BASE     (0x00000000)
> @@ -119,6 +120,7 @@ typedef struct AwH3State {
>       AwH3SysconState syscon;
>       AwH3SidState sid;
>       AwH3SDHostState mmc0;
> +    AwH3EmacState emac;
>       GICState gic;
>       MemoryRegion sram_a1;
>       MemoryRegion sram_a2;
> diff --git a/include/hw/net/allwinner-h3-emac.h b/include/hw/net/allwin=
ner-h3-emac.h
> new file mode 100644
> index 0000000000..a007d54472
> --- /dev/null
> +++ b/include/hw/net/allwinner-h3-emac.h
> @@ -0,0 +1,69 @@
> +/*
> + * Allwinner H3 EMAC emulation
> + *
> + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
> + *
> + * This program is free software: you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
> + */
> +
> +#ifndef ALLWINNER_H3_EMAC_H
> +#define ALLWINNER_H3_EMAC_H
> +
> +#include "qemu/units.h"
> +#include "net/net.h"
> +#include "qemu/fifo8.h"
> +#include "hw/net/mii.h"
> +#include "hw/sysbus.h"
> +
> +#define AW_H3_EMAC_REGS_MEM_SIZE  (1024)
> +
> +#define TYPE_AW_H3_EMAC "allwinner-h3-emac"
> +#define AW_H3_EMAC(obj) OBJECT_CHECK(AwH3EmacState, (obj), TYPE_AW_H3_=
EMAC)
> +
> +typedef struct AwH3EmacState {
> +    /*< private >*/
> +    SysBusDevice  parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion iomem;
> +    qemu_irq     irq;
> +    NICState     *nic;
> +    NICConf      conf;
> +
> +    uint8_t      mii_phy_addr;
> +    uint32_t     mii_cmd;
> +    uint32_t     mii_data;
> +    uint32_t     mii_cr;
> +    uint32_t     mii_st;
> +
> +    uint32_t     basic_ctl0;
> +    uint32_t     basic_ctl1;
> +    uint32_t     int_en;
> +    uint32_t     int_sta;
> +    uint32_t     frm_flt;
> +
> +    uint32_t     rx_ctl0;
> +    uint32_t     rx_ctl1;
> +    uint32_t     rx_desc_head;
> +    uint32_t     rx_desc_curr;
> +
> +    uint32_t     tx_ctl0;
> +    uint32_t     tx_ctl1;
> +    uint32_t     tx_desc_head;
> +    uint32_t     tx_desc_curr;
> +    uint32_t     tx_flowctl;
> +
> +} AwH3EmacState;
> +
> +#endif
>=20

The rest seems ok to me. Thanks for the contribution :)!

Cheers,
Fred


