Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A60DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC81F21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj9NciEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC81F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifs5h-0008I7-8u
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 16:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ifs3t-0006xC-61
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ifs3j-0002hi-QE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:01:20 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ifs3j-0002eJ-8U; Fri, 13 Dec 2019 16:01:11 -0500
Received: by mail-il1-x141.google.com with SMTP id b15so582694iln.3;
 Fri, 13 Dec 2019 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9/BMrQf3mcRwclQo5IjtFuJ54xGqaINnPEy9RJNJTRM=;
 b=Kj9NciEYK/rHehYvja7ZTaO8ljCKhyaoWXd+2tV3ZKX1Ol+eTvPdUFbl5QQsu0GwKc
 Un2neIhvGDznUWyyZDfqz2AIQFCYVIc/Br0dl82LGXFk31rIsOa18TnwFRF+lC5ywK2J
 XffLZs2WMhRc20Sbxhuec7K641yUFrI1cWRhXIjTqU5JsiJmrIq3/Cu0/5ZuG1GexmtS
 ENGOn6wiSdUIIwrgquXVHGIOnHSIqbvCdJmDVrhqoqWwVLFTw91Tt86Ki0GIfSCJqqCp
 HryTSck9Cm3+PNhbwnGTG4bFxvwjqEXZyetkYaUEuHPmkFr9A0qcesJPb/p/2Nbz8+7Y
 Hs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9/BMrQf3mcRwclQo5IjtFuJ54xGqaINnPEy9RJNJTRM=;
 b=O6d+Kr9cbPHlhA0fFtFw1A3pNOqiSUndiWqQqa4dnzICO9JEF/1ep8gANKxrCl7ACs
 8JhGWD2YHIHN4jnKPrqPheAEqkSpiRapnDprvFNx+5c6xf8vIXLtcpXEd+3UCxIiF+9w
 IRlLweOoI2xFBGHlS06RhXVCJWus4JJtey3K+gFnldKMfi4cZE2PsM5L2U7rPO/I00pP
 W5be4XPzqRjSenaP5+rwEGfeJFc0NfgGHhZ71HhdUk5NXOt1OZjyVJx1zwu81Kzfublf
 gelOj+pwXD6ICO9tqGb+SbW1M5LnD6Gq5dOtYN/8uljt4ZJ39H2DqvpsI63045hJB05T
 YvGA==
X-Gm-Message-State: APjAAAUUksuY5gdKpUgzQKTrq2L/TqFXIvotEZ7pm58IiQw3PjP6NMPj
 Ymi62tS16JYZoToyKFgmJPDBwdUBM+k2MLFxaOk=
X-Google-Smtp-Source: APXvYqzvMDaK5AmMw2f+37qHykGNuFhYIX2Sy3AXzP3z+QHbpPk1c1va9TMNPnRUB/3iviaRzH4IpC+cjmXtCh3p3BE=
X-Received: by 2002:a92:5a45:: with SMTP id o66mr1227940ilb.67.1576270870130; 
 Fri, 13 Dec 2019 13:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
 <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
 <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
In-Reply-To: <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 13 Dec 2019 22:00:59 +0100
Message-ID: <CAPan3Woq_EJAE6s-N5dAApAgzexGr4M-OtFkiHuMN_Xp=8_bTQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000048b6cc05999c2987"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000048b6cc05999c2987
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> Hi Niek,
>
> On 12/11/19 11:34 PM, Niek Linnenbank wrote:
> > Ping!
> >
> > Anyone would like to comment on this driver?
> >
> > I finished the rework on all previous comments in this series.
> >
> > Currently debugging the hflags error reported by Philippe.
> > After that, I'm ready to send out v2 of these patches.
> >
> > Regards,
> > Niek
> >
> > On Mon, Dec 2, 2019 at 10:10 PM Niek Linnenbank
> > <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>> wrote:
> >
> >     The Allwinner H3 System on Chip contains an integrated storage
> >     controller for Secure Digital (SD) and Multi Media Card (MMC)
> >     interfaces. This commit adds support for the Allwinner H3
> >     SD/MMC storage controller with the following emulated features:
> >
> >       * DMA transfers
> >       * Direct FIFO I/O
> >       * Short/Long format command responses
> >       * Auto-Stop command (CMD12)
> >       * Insert & remove card detection
> >
> >     Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >     ---
> >       hw/arm/allwinner-h3.c               |  20 +
> >       hw/arm/orangepi.c                   |  17 +
> >       hw/sd/Makefile.objs                 |   1 +
> >       hw/sd/allwinner-h3-sdhost.c         | 791
> ++++++++++++++++++++++++++++
> >       hw/sd/trace-events                  |   7 +
> >       include/hw/arm/allwinner-h3.h       |   2 +
> >       include/hw/sd/allwinner-h3-sdhost.h |  73 +++
> >       7 files changed, 911 insertions(+)
> >       create mode 100644 hw/sd/allwinner-h3-sdhost.c
> >       create mode 100644 include/hw/sd/allwinner-h3-sdhost.h
> >
> >     diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> >     index 4fc4c8c725..c2972caf88 100644
> >     --- a/hw/arm/allwinner-h3.c
> >     +++ b/hw/arm/allwinner-h3.c
> >     @@ -50,6 +50,9 @@ static void aw_h3_init(Object *obj)
> >
> >           sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
> >                                 TYPE_AW_H3_SID);
> >     +
> >     +    sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
> >     +                          TYPE_AW_H3_SDHOST);
> >       }
> >
> >       static void aw_h3_realize(DeviceState *dev, Error **errp)
> >     @@ -217,6 +220,23 @@ static void aw_h3_realize(DeviceState *dev,
> >     Error **errp)
> >           }
> >           sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, AW_H3_SID_BASE);
> >
> >     +    /* SD/MMC */
> >     +    object_property_set_bool(OBJECT(&s->mmc0), true, "realized",
> &err);
> >     +    if (err !=3D NULL) {
> >     +        error_propagate(errp, err);
> >     +        return;
> >     +    }
> >     +    sysbusdev =3D SYS_BUS_DEVICE(&s->mmc0);
> >     +    sysbus_mmio_map(sysbusdev, 0, AW_H3_MMC0_BASE);
> >     +    sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SPI_MMC0]);
> >     +
> >     +    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0=
),
> >     +                              "sd-bus", &err);
> >     +    if (err) {
> >     +        error_propagate(errp, err);
> >     +        return;
> >     +    }
> >     +
> >           /* Universal Serial Bus */
> >           sysbus_create_simple(TYPE_AW_H3_EHCI, AW_H3_EHCI0_BASE,
> >                                s->irq[AW_H3_GIC_SPI_EHCI0]);
> >     diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> >     index 5ef2735f81..dee3efaf08 100644
> >     --- a/hw/arm/orangepi.c
> >     +++ b/hw/arm/orangepi.c
> >     @@ -39,6 +39,10 @@ typedef struct OrangePiState {
> >       static void orangepi_init(MachineState *machine)
> >       {
> >           OrangePiState *s =3D g_new(OrangePiState, 1);
> >     +    DriveInfo *di;
> >     +    BlockBackend *blk;
> >     +    BusState *bus;
> >     +    DeviceState *carddev;
> >           Error *err =3D NULL;
> >
> >           s->h3 =3D AW_H3(object_new(TYPE_AW_H3));
> >     @@ -64,6 +68,18 @@ static void orangepi_init(MachineState *machine)
> >               exit(1);
> >           }
> >
> >     +    /* Create and plug in the SD card */
> >     +    di =3D drive_get_next(IF_SD);
> >     +    blk =3D di ? blk_by_legacy_dinfo(di) : NULL;
> >     +    bus =3D qdev_get_child_bus(DEVICE(s->h3), "sd-bus");
> >     +    if (bus =3D=3D NULL) {
> >     +        error_report("No SD/MMC found in H3 object");
> >     +        exit(1);
> >     +    }
>
> Your device always creates a bus, so I don't think the if(bus) check is
> worthwhile. Eventually use an assert(bus)?
>
> >     +    carddev =3D qdev_create(bus, TYPE_SD_CARD);
> >     +    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
> >     +    object_property_set_bool(OBJECT(carddev), true, "realized",
> >     &error_fatal);
> >     +
> >           /* RAM */
> >           memory_region_allocate_system_memory(&s->sdram, NULL,
> >     "orangepi.ram",
> >                                                machine->ram_size);
> >     @@ -80,6 +96,7 @@ static void orangepi_machine_init(MachineClass *m=
c)
> >       {
> >           mc->desc =3D "Orange Pi PC";
> >           mc->init =3D orangepi_init;
> >     +    mc->block_default_type =3D IF_SD;
> >           mc->units_per_default_bus =3D 1;
> >           mc->min_cpus =3D AW_H3_NUM_CPUS;
> >           mc->max_cpus =3D AW_H3_NUM_CPUS;
> >     diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> >     index a884c238df..e7cc5ab739 100644
> >     --- a/hw/sd/Makefile.objs
> >     +++ b/hw/sd/Makefile.objs
> >     @@ -4,6 +4,7 @@ common-obj-$(CONFIG_SD) +=3D sd.o core.o
> sdmmc-internal.o
> >       common-obj-$(CONFIG_SDHCI) +=3D sdhci.o
> >       common-obj-$(CONFIG_SDHCI_PCI) +=3D sdhci-pci.o
> >
> >     +obj-$(CONFIG_ALLWINNER_H3) +=3D allwinner-h3-sdhost.o
> >       obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
> >       obj-$(CONFIG_OMAP) +=3D omap_mmc.o
> >       obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
> >     diff --git a/hw/sd/allwinner-h3-sdhost.c
> b/hw/sd/allwinner-h3-sdhost.c
> >     new file mode 100644
> >     index 0000000000..26e113a144
> >     --- /dev/null
> >     +++ b/hw/sd/allwinner-h3-sdhost.c
> >     @@ -0,0 +1,791 @@
> >     +/*
> >     + * Allwinner H3 SD Host Controller emulation
> >     + *
> >     + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >     + *
> >     + * This program is free software: you can redistribute it and/or
> modify
> >     + * it under the terms of the GNU General Public License as
> published by
> >     + * the Free Software Foundation, either version 2 of the License, =
or
> >     + * (at your option) any later version.
> >     + *
> >     + * This program is distributed in the hope that it will be useful,
> >     + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >     + * GNU General Public License for more details.
> >     + *
> >     + * You should have received a copy of the GNU General Public Licen=
se
> >     + * along with this program.  If not, see
> >     <http://www.gnu.org/licenses/>.
> >     + */
> >     +
> >     +#include "qemu/osdep.h"
> >     +#include "qemu/log.h"
> >     +#include "qemu/module.h"
> >     +#include "sysemu/blockdev.h"
> >     +#include "hw/irq.h"
> >     +#include "hw/sd/allwinner-h3-sdhost.h"
> >     +#include "migration/vmstate.h"
> >     +#include "trace.h"
> >     +
> >     +#define TYPE_AW_H3_SDHOST_BUS "allwinner-h3-sdhost-bus"
> >     +#define AW_H3_SDHOST_BUS(obj) \
> >     +    OBJECT_CHECK(SDBus, (obj), TYPE_AW_H3_SDHOST_BUS)
> >     +
> >     +/* SD Host register offsets */
> >     +#define REG_SD_GCTL        (0x00)  /* Global Control */
> >     +#define REG_SD_CKCR        (0x04)  /* Clock Control */
> >     +#define REG_SD_TMOR        (0x08)  /* Timeout */
> >     +#define REG_SD_BWDR        (0x0C)  /* Bus Width */
> >     +#define REG_SD_BKSR        (0x10)  /* Block Size */
> >     +#define REG_SD_BYCR        (0x14)  /* Byte Count */
> >     +#define REG_SD_CMDR        (0x18)  /* Command */
> >     +#define REG_SD_CAGR        (0x1C)  /* Command Argument */
> >     +#define REG_SD_RESP0       (0x20)  /* Response Zero */
> >     +#define REG_SD_RESP1       (0x24)  /* Response One */
> >     +#define REG_SD_RESP2       (0x28)  /* Response Two */
> >     +#define REG_SD_RESP3       (0x2C)  /* Response Three */
> >     +#define REG_SD_IMKR        (0x30)  /* Interrupt Mask */
> >     +#define REG_SD_MISR        (0x34)  /* Masked Interrupt Status */
> >     +#define REG_SD_RISR        (0x38)  /* Raw Interrupt Status */
> >     +#define REG_SD_STAR        (0x3C)  /* Status */
> >     +#define REG_SD_FWLR        (0x40)  /* FIFO Water Level */
> >     +#define REG_SD_FUNS        (0x44)  /* FIFO Function Select */
> >     +#define REG_SD_DBGC        (0x50)  /* Debug Enable */
> >     +#define REG_SD_A12A        (0x58)  /* Auto command 12 argument */
> >     +#define REG_SD_NTSR        (0x5C)  /* SD NewTiming Set */
> >     +#define REG_SD_SDBG        (0x60)  /* SD newTiming Set Debug */
> >     +#define REG_SD_HWRST       (0x78)  /* Hardware Reset Register */
> >     +#define REG_SD_DMAC        (0x80)  /* Internal DMA Controller
> >     Control */
> >     +#define REG_SD_DLBA        (0x84)  /* Descriptor List Base Address
> */
> >     +#define REG_SD_IDST        (0x88)  /* Internal DMA Controller
> Status */
> >     +#define REG_SD_IDIE        (0x8C)  /* Internal DMA Controller IRQ
> >     Enable */
> >     +#define REG_SD_THLDC       (0x100) /* Card Threshold Control */
> >     +#define REG_SD_DSBD        (0x10C) /* eMMC DDR Start Bit Detection
> >     Control */
> >     +#define REG_SD_RES_CRC     (0x110) /* Response CRC from card/eMMC =
*/
> >     +#define REG_SD_DATA7_CRC   (0x114) /* CRC Data 7 from card/eMMC */
> >     +#define REG_SD_DATA6_CRC   (0x118) /* CRC Data 6 from card/eMMC */
> >     +#define REG_SD_DATA5_CRC   (0x11C) /* CRC Data 5 from card/eMMC */
> >     +#define REG_SD_DATA4_CRC   (0x120) /* CRC Data 4 from card/eMMC */
> >     +#define REG_SD_DATA3_CRC   (0x124) /* CRC Data 3 from card/eMMC */
> >     +#define REG_SD_DATA2_CRC   (0x128) /* CRC Data 2 from card/eMMC */
> >     +#define REG_SD_DATA1_CRC   (0x12C) /* CRC Data 1 from card/eMMC */
> >     +#define REG_SD_DATA0_CRC   (0x130) /* CRC Data 0 from card/eMMC */
> >     +#define REG_SD_CRC_STA     (0x134) /* CRC status from card/eMMC
> >     during write */
> >     +#define REG_SD_FIFO        (0x200) /* Read/Write FIFO */
> >     +
> >     +/* SD Host register flags */
> >     +#define SD_GCTL_FIFO_AC_MOD     (1 << 31)
> >     +#define SD_GCTL_DDR_MOD_SEL     (1 << 10)
> >     +#define SD_GCTL_CD_DBC_ENB      (1 << 8)
> >     +#define SD_GCTL_DMA_ENB         (1 << 5)
> >     +#define SD_GCTL_INT_ENB         (1 << 4)
> >     +#define SD_GCTL_DMA_RST         (1 << 2)
> >     +#define SD_GCTL_FIFO_RST        (1 << 1)
> >     +#define SD_GCTL_SOFT_RST        (1 << 0)
> >     +
> >     +#define SD_CMDR_LOAD            (1 << 31)
> >     +#define SD_CMDR_CLKCHANGE       (1 << 21)
> >     +#define SD_CMDR_WRITE           (1 << 10)
> >     +#define SD_CMDR_AUTOSTOP        (1 << 12)
> >     +#define SD_CMDR_DATA            (1 << 9)
> >     +#define SD_CMDR_RESPONSE_LONG   (1 << 7)
> >     +#define SD_CMDR_RESPONSE        (1 << 6)
> >     +#define SD_CMDR_CMDID_MASK      (0x3f)
> >     +
> >     +#define SD_RISR_CARD_REMOVE     (1 << 31)
> >     +#define SD_RISR_CARD_INSERT     (1 << 30)
> >     +#define SD_RISR_AUTOCMD_DONE    (1 << 14)
> >     +#define SD_RISR_DATA_COMPLETE   (1 << 3)
> >     +#define SD_RISR_CMD_COMPLETE    (1 << 2)
> >     +#define SD_RISR_NO_RESPONSE     (1 << 1)
> >     +
> >     +#define SD_STAR_CARD_PRESENT    (1 << 8)
> >     +
> >     +#define SD_IDST_SUM_RECEIVE_IRQ (1 << 8)
> >     +#define SD_IDST_RECEIVE_IRQ     (1 << 1)
> >     +#define SD_IDST_TRANSMIT_IRQ    (1 << 0)
> >     +#define SD_IDST_IRQ_MASK        (SD_IDST_RECEIVE_IRQ |
> >     SD_IDST_TRANSMIT_IRQ | \
> >     +                                 SD_IDST_SUM_RECEIVE_IRQ)
> >     +#define SD_IDST_WR_MASK         (0x3ff)
> >     +
> >     +/* SD Host register reset values */
> >     +#define REG_SD_GCTL_RST         (0x00000300)
> >     +#define REG_SD_CKCR_RST         (0x0)
> >     +#define REG_SD_TMOR_RST         (0xFFFFFF40)
> >     +#define REG_SD_BWDR_RST         (0x0)
> >     +#define REG_SD_BKSR_RST         (0x00000200)
> >     +#define REG_SD_BYCR_RST         (0x00000200)
> >     +#define REG_SD_CMDR_RST         (0x0)
> >     +#define REG_SD_CAGR_RST         (0x0)
> >     +#define REG_SD_RESP_RST         (0x0)
> >     +#define REG_SD_IMKR_RST         (0x0)
> >     +#define REG_SD_MISR_RST         (0x0)
> >     +#define REG_SD_RISR_RST         (0x0)
> >     +#define REG_SD_STAR_RST         (0x00000100)
> >     +#define REG_SD_FWLR_RST         (0x000F0000)
> >     +#define REG_SD_FUNS_RST         (0x0)
> >     +#define REG_SD_DBGC_RST         (0x0)
> >     +#define REG_SD_A12A_RST         (0x0000FFFF)
> >     +#define REG_SD_NTSR_RST         (0x00000001)
> >     +#define REG_SD_SDBG_RST         (0x0)
> >     +#define REG_SD_HWRST_RST        (0x00000001)
> >     +#define REG_SD_DMAC_RST         (0x0)
> >     +#define REG_SD_DLBA_RST         (0x0)
> >     +#define REG_SD_IDST_RST         (0x0)
> >     +#define REG_SD_IDIE_RST         (0x0)
> >     +#define REG_SD_THLDC_RST        (0x0)
> >     +#define REG_SD_DSBD_RST         (0x0)
> >     +#define REG_SD_RES_CRC_RST      (0x0)
> >     +#define REG_SD_DATA_CRC_RST     (0x0)
> >     +#define REG_SD_CRC_STA_RST      (0x0)
> >     +#define REG_SD_FIFO_RST         (0x0)
> >     +
> >     +/* Data transfer descriptor for DMA */
> >     +typedef struct TransferDescriptor {
> >     +    uint32_t status; /* Status flags */
> >     +    uint32_t size;   /* Data buffer size */
> >     +    uint32_t addr;   /* Data buffer address */
> >     +    uint32_t next;   /* Physical address of next descriptor */
> >     +} TransferDescriptor;
> >     +
> >     +/* Data transfer descriptor flags */
> >     +#define DESC_STATUS_HOLD   (1 << 31) /* Set when descriptor is in
> >     use by DMA */
> >     +#define DESC_STATUS_ERROR  (1 << 30) /* Set when DMA transfer erro=
r
> >     occurred */
> >     +#define DESC_STATUS_CHAIN  (1 << 4)  /* Indicates chained
> >     descriptor. */
> >     +#define DESC_STATUS_FIRST  (1 << 3)  /* Set on the first descripto=
r
> */
> >     +#define DESC_STATUS_LAST   (1 << 2)  /* Set on the last descriptor
> */
> >     +#define DESC_STATUS_NOIRQ  (1 << 1)  /* Skip raising interrupt
> >     after transfer */
> >     +
> >     +#define DESC_SIZE_MASK     (0xfffffffc)
> >     +
> >     +static void aw_h3_sdhost_update_irq(AwH3SDHostState *s)
> >     +{
> >     +    uint32_t irq_en =3D s->global_ctl & SD_GCTL_INT_ENB;
> >     +    uint32_t irq =3D irq_en ? s->irq_status & s->irq_mask : 0;
>
> The previous line is confuse, either use parenthesis or a if statement.
>
>      uint32_t irq =3D irq_en ? (s->irq_status & s->irq_mask) : 0;
>
> >     +
> >     +    trace_aw_h3_sdhost_update_irq(irq);
> >     +    qemu_set_irq(s->irq, irq);
> >     +}
> >     +
> >     +static void aw_h3_sdhost_update_transfer_cnt(AwH3SDHostState *s,
> >     uint32_t bytes)
> >     +{
> >     +    if (s->transfer_cnt > bytes) {
> >     +        s->transfer_cnt -=3D bytes;
> >     +    } else {
> >     +        s->transfer_cnt =3D 0;
> >     +    }
> >     +
> >     +    if (!s->transfer_cnt) {
> >     +        s->irq_status |=3D SD_RISR_DATA_COMPLETE |
> SD_RISR_AUTOCMD_DONE;
> >     +    }
> >     +}
> >     +
> >     +static void aw_h3_sdhost_set_inserted(DeviceState *dev, bool
> inserted)
> >     +{
> >     +    AwH3SDHostState *s =3D AW_H3_SDHOST(dev);
> >     +
> >     +    trace_aw_h3_sdhost_set_inserted(inserted);
> >     +
> >     +    if (inserted) {
> >     +        s->irq_status |=3D SD_RISR_CARD_INSERT;
> >     +        s->irq_status &=3D ~SD_RISR_CARD_REMOVE;
> >     +        s->status |=3D SD_STAR_CARD_PRESENT;
> >     +    } else {
> >     +        s->irq_status &=3D ~SD_RISR_CARD_INSERT;
> >     +        s->irq_status |=3D SD_RISR_CARD_REMOVE;
> >     +        s->status &=3D ~SD_STAR_CARD_PRESENT;
> >     +    }
> >     +
> >     +    aw_h3_sdhost_update_irq(s);
> >     +}
> >     +
> >     +static void aw_h3_sdhost_send_command(AwH3SDHostState *s)
> >     +{
> >     +    SDRequest request;
> >     +    uint8_t resp[16];
> >     +    int rlen;
> >     +
> >     +    /* Auto clear load flag */
> >     +    s->command &=3D ~SD_CMDR_LOAD;
> >     +
> >     +    /* Clock change does not actually interact with the SD bus */
> >     +    if (!(s->command & SD_CMDR_CLKCHANGE)) {
> >     +
> >     +        /* Prepare request */
> >     +        request.cmd =3D s->command & SD_CMDR_CMDID_MASK;
> >     +        request.arg =3D s->command_arg;
> >     +
> >     +        /* Send request to SD bus */
> >     +        rlen =3D sdbus_do_command(&s->sdbus, &request, resp);
> >     +        if (rlen < 0) {
> >     +            goto error;
> >     +        }
> >     +
> >     +        /* If the command has a response, store it in the response
> >     registers */
> >     +        if ((s->command & SD_CMDR_RESPONSE)) {
> >     +            if (rlen =3D=3D 0 ||
> >     +               (rlen =3D=3D 4 && (s->command & SD_CMDR_RESPONSE_LO=
NG)))
> {
> >     +                goto error;
> >     +            }
> >     +            if (rlen !=3D 4 && rlen !=3D 16) {
> >     +                goto error;
> >     +            }
>
> Maybe remove previous if...
>
> >     +            if (rlen =3D=3D 4) {
> >     +                s->response[0] =3D ldl_be_p(&resp[0]);
> >     +                s->response[1] =3D s->response[2] =3D s->response[=
3] =3D
> 0;
> >     +            } else {
>
> ...
>
>                     } else if (rlen =3D=3D 16) { ...
>
> >     +                s->response[0] =3D ldl_be_p(&resp[12]);
> >     +                s->response[1] =3D ldl_be_p(&resp[8]);
> >     +                s->response[2] =3D ldl_be_p(&resp[4]);
> >     +                s->response[3] =3D ldl_be_p(&resp[0]);
>
> ...
>
>                     } else {
>                         goto error;
>
> >     +            }
> >     +        }
> >     +    }
> >     +
> >     +    /* Set interrupt status bits */
> >     +    s->irq_status |=3D SD_RISR_CMD_COMPLETE;
> >     +    return;
> >     +
> >     +error:
> >     +    s->irq_status |=3D SD_RISR_NO_RESPONSE;
> >     +}
> >     +
> >     +static void aw_h3_sdhost_auto_stop(AwH3SDHostState *s)
> >     +{
> >     +    /*
> >     +     * The stop command (CMD12) ensures the SD bus
> >     +     * returns to the transfer state.
> >     +     */
> >     +    if ((s->command & SD_CMDR_AUTOSTOP) && (s->transfer_cnt =3D=3D=
 0)) {
> >     +        /* First save current command registers */
> >     +        uint32_t saved_cmd =3D s->command;
> >     +        uint32_t saved_arg =3D s->command_arg;
> >     +
> >     +        /* Prepare stop command (CMD12) */
> >     +        s->command &=3D ~SD_CMDR_CMDID_MASK;
> >     +        s->command |=3D 12; /* CMD12 */
> >     +        s->command_arg =3D 0;
> >     +
> >     +        /* Put the command on SD bus */
> >     +        aw_h3_sdhost_send_command(s);
> >     +
> >     +        /* Restore command values */
> >     +        s->command =3D saved_cmd;
> >     +        s->command_arg =3D saved_arg;
> >     +    }
> >     +}
> >     +
> >     +static uint32_t aw_h3_sdhost_process_desc(AwH3SDHostState *s,
> >     +                                          hwaddr desc_addr,
> >     +                                          TransferDescriptor *desc=
,
> >     +                                          bool is_write, uint32_t
> >     max_bytes)
> >     +{
> >     +    uint32_t num_done =3D 0;
> >     +    uint32_t num_bytes =3D max_bytes;
> >     +    uint8_t buf[1024];
> >     +
> >     +    /* Read descriptor */
> >     +    cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
>
> Should we worry about endianess here?
>
> >     +    if (desc->size =3D=3D 0) {
> >     +        desc->size =3D 0xffff + 1;
>
> Why not write '64 * KiB'?
>
> >     +    }
> >     +    if (desc->size < num_bytes) {
> >     +        num_bytes =3D desc->size;
> >     +    }
> >     +
> >     +    trace_aw_h3_sdhost_process_desc(desc_addr, desc->size,
> >     is_write, max_bytes);
> >     +
> >     +    while (num_done < num_bytes) {
> >     +        /* Try to completely fill the local buffer */
> >     +        uint32_t buf_bytes =3D num_bytes - num_done;
> >     +        if (buf_bytes > sizeof(buf)) {
> >     +            buf_bytes =3D sizeof(buf);
> >     +        }
> >     +
> >     +        /* Write to SD bus */
> >     +        if (is_write) {
> >     +            cpu_physical_memory_read((desc->addr & DESC_SIZE_MASK)
> >     + num_done,
> >     +                                      buf, buf_bytes);
> >     +
> >     +            for (uint32_t i =3D 0; i < buf_bytes; i++) {
> >     +                sdbus_write_data(&s->sdbus, buf[i]);
> >     +            }
> >     +
> >     +        /* Read from SD bus */
> >     +        } else {
> >     +            for (uint32_t i =3D 0; i < buf_bytes; i++) {
> >     +                buf[i] =3D sdbus_read_data(&s->sdbus);
> >     +            }
> >     +            cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK=
)
> >     + num_done,
> >     +                                       buf, buf_bytes);
> >     +        }
> >     +        num_done +=3D buf_bytes;
> >     +    }
> >     +
> >     +    /* Clear hold flag and flush descriptor */
> >     +    desc->status &=3D ~DESC_STATUS_HOLD;
> >     +    cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));
>
> (Related to previous endianess question).
>
> >     +
> >     +    return num_done;
> >     +}
> >     +
> >     +static void aw_h3_sdhost_dma(AwH3SDHostState *s)
> >     +{
> >     +    TransferDescriptor desc;
> >     +    hwaddr desc_addr =3D s->desc_base;
> >     +    bool is_write =3D (s->command & SD_CMDR_WRITE);
> >     +    uint32_t bytes_done =3D 0;
> >     +
> >     +    /* Check if DMA can be performed */
> >     +    if (s->byte_count =3D=3D 0 || s->block_size =3D=3D 0 ||
> >     +      !(s->global_ctl & SD_GCTL_DMA_ENB)) {
> >     +        return;
> >     +    }
> >     +
> >     +    /*
> >     +     * For read operations, data must be available on the SD bus
> >     +     * If not, it is an error and we should not act at all
> >     +     */
> >     +    if (!is_write && !sdbus_data_ready(&s->sdbus)) {
> >     +        return;
> >     +    }
> >     +
> >     +    /* Process the DMA descriptors until all data is copied */
> >     +    while (s->byte_count > 0) {
> >     +        bytes_done =3D aw_h3_sdhost_process_desc(s, desc_addr, &de=
sc,
> >     +                                               is_write,
> >     s->byte_count);
> >     +        aw_h3_sdhost_update_transfer_cnt(s, bytes_done);
> >     +
> >     +        if (bytes_done <=3D s->byte_count) {
> >     +            s->byte_count -=3D bytes_done;
> >     +        } else {
> >     +            s->byte_count =3D 0;
> >     +        }
> >     +
> >     +        if (desc.status & DESC_STATUS_LAST) {
> >     +            break;
> >     +        } else {
> >     +            desc_addr =3D desc.next;
> >     +        }
> >     +    }
> >     +
> >     +    /* Raise IRQ to signal DMA is completed */
> >     +    s->irq_status |=3D SD_RISR_DATA_COMPLETE | SD_RISR_AUTOCMD_DON=
E;
> >     +
> >     +    /* Update DMAC bits */
> >     +    if (is_write) {
> >     +        s->dmac_status |=3D SD_IDST_TRANSMIT_IRQ;
> >     +    } else {
> >     +        s->dmac_status |=3D (SD_IDST_SUM_RECEIVE_IRQ |
> >     SD_IDST_RECEIVE_IRQ);
> >     +    }
> >     +}
> >     +
> >     +static uint64_t aw_h3_sdhost_read(void *opaque, hwaddr offset,
> >     +                                  unsigned size)
> >     +{
> >     +    AwH3SDHostState *s =3D (AwH3SDHostState *)opaque;
> >     +    uint32_t res =3D 0;
> >     +
> >     +    switch (offset) {
> >     +    case REG_SD_GCTL:      /* Global Control */
> >     +        res =3D s->global_ctl;
> >     +        break;
> >     +    case REG_SD_CKCR:      /* Clock Control */
> >     +        res =3D s->clock_ctl;
> >     +        break;
> >     +    case REG_SD_TMOR:      /* Timeout */
> >     +        res =3D s->timeout;
> >     +        break;
> >     +    case REG_SD_BWDR:      /* Bus Width */
> >     +        res =3D s->bus_width;
> >     +        break;
> >     +    case REG_SD_BKSR:      /* Block Size */
> >     +        res =3D s->block_size;
> >     +        break;
> >     +    case REG_SD_BYCR:      /* Byte Count */
> >     +        res =3D s->byte_count;
> >     +        break;
> >     +    case REG_SD_CMDR:      /* Command */
> >     +        res =3D s->command;
> >     +        break;
> >     +    case REG_SD_CAGR:      /* Command Argument */
> >     +        res =3D s->command_arg;
> >     +        break;
> >     +    case REG_SD_RESP0:     /* Response Zero */
> >     +        res =3D s->response[0];
> >     +        break;
> >     +    case REG_SD_RESP1:     /* Response One */
> >     +        res =3D s->response[1];
> >     +        break;
> >     +    case REG_SD_RESP2:     /* Response Two */
> >     +        res =3D s->response[2];
> >     +        break;
> >     +    case REG_SD_RESP3:     /* Response Three */
> >     +        res =3D s->response[3];
> >     +        break;
> >     +    case REG_SD_IMKR:      /* Interrupt Mask */
> >     +        res =3D s->irq_mask;
> >     +        break;
> >     +    case REG_SD_MISR:      /* Masked Interrupt Status */
> >     +        res =3D s->irq_status & s->irq_mask;
> >     +        break;
> >     +    case REG_SD_RISR:      /* Raw Interrupt Status */
> >     +        res =3D s->irq_status;
> >     +        break;
> >     +    case REG_SD_STAR:      /* Status */
> >     +        res =3D s->status;
> >     +        break;
> >     +    case REG_SD_FWLR:      /* FIFO Water Level */
> >     +        res =3D s->fifo_wlevel;
> >     +        break;
> >     +    case REG_SD_FUNS:      /* FIFO Function Select */
> >     +        res =3D s->fifo_func_sel;
> >     +        break;
> >     +    case REG_SD_DBGC:      /* Debug Enable */
> >     +        res =3D s->debug_enable;
> >     +        break;
> >     +    case REG_SD_A12A:      /* Auto command 12 argument */
> >     +        res =3D s->auto12_arg;
> >     +        break;
> >     +    case REG_SD_NTSR:      /* SD NewTiming Set */
> >     +        res =3D s->newtiming_set;
> >     +        break;
> >     +    case REG_SD_SDBG:      /* SD newTiming Set Debug */
> >     +        res =3D s->newtiming_debug;
> >     +        break;
> >     +    case REG_SD_HWRST:     /* Hardware Reset Register */
> >     +        res =3D s->hardware_rst;
> >     +        break;
> >     +    case REG_SD_DMAC:      /* Internal DMA Controller Control */
> >     +        res =3D s->dmac;
> >     +        break;
> >     +    case REG_SD_DLBA:      /* Descriptor List Base Address */
> >     +        res =3D s->desc_base;
> >     +        break;
> >     +    case REG_SD_IDST:      /* Internal DMA Controller Status */
> >     +        res =3D s->dmac_status;
> >     +        break;
> >     +    case REG_SD_IDIE:      /* Internal DMA Controller Interrupt
> >     Enable */
> >     +        res =3D s->dmac_irq;
> >     +        break;
> >     +    case REG_SD_THLDC:     /* Card Threshold Control */
> >     +        res =3D s->card_threshold;
> >     +        break;
> >     +    case REG_SD_DSBD:      /* eMMC DDR Start Bit Detection Control
> */
> >     +        res =3D s->startbit_detect;
> >     +        break;
> >     +    case REG_SD_RES_CRC:   /* Response CRC from card/eMMC */
> >     +        res =3D s->response_crc;
> >     +        break;
> >     +    case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
> >     +    case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
> >     +    case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
> >     +    case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
> >     +    case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
> >     +    case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
> >     +    case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
> >     +    case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
> >     +        res =3D s->data_crc[((offset - REG_SD_DATA7_CRC) /
> >     sizeof(uint32_t))];
> >     +        break;
> >     +    case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write
> >     operation */
> >     +        res =3D s->status_crc;
> >     +        break;
> >     +    case REG_SD_FIFO:      /* Read/Write FIFO */
> >     +        if (sdbus_data_ready(&s->sdbus)) {
> >     +            res =3D sdbus_read_data(&s->sdbus);
> >     +            res |=3D sdbus_read_data(&s->sdbus) << 8;
> >     +            res |=3D sdbus_read_data(&s->sdbus) << 16;
> >     +            res |=3D sdbus_read_data(&s->sdbus) << 24;
> >     +            aw_h3_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
> >     +            aw_h3_sdhost_auto_stop(s);
> >     +            aw_h3_sdhost_update_irq(s);
> >     +        } else {
> >     +            qemu_log_mask(LOG_GUEST_ERROR, "%s: no data ready on S=
D
> >     bus\n",
> >     +                          __func__);
> >     +        }
> >     +        break;
> >     +    default:
> >     +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> >     %"HWADDR_PRIx"\n",
> >     +                      __func__, offset);
> >     +        res =3D 0;
> >     +        break;
> >     +    }
> >     +
> >     +    trace_aw_h3_sdhost_read(offset, res, size);
> >     +    return res;
> >     +}
> >     +
> >     +static void aw_h3_sdhost_write(void *opaque, hwaddr offset,
> >     +                               uint64_t value, unsigned size)
> >     +{
> >     +    AwH3SDHostState *s =3D (AwH3SDHostState *)opaque;
> >     +
> >     +    trace_aw_h3_sdhost_write(offset, value, size);
> >     +
> >     +    switch (offset) {
> >     +    case REG_SD_GCTL:      /* Global Control */
> >     +        s->global_ctl =3D value;
> >     +        s->global_ctl &=3D ~(SD_GCTL_DMA_RST | SD_GCTL_FIFO_RST |
> >     +                           SD_GCTL_SOFT_RST);
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_CKCR:      /* Clock Control */
> >     +        s->clock_ctl =3D value;
> >     +        break;
> >     +    case REG_SD_TMOR:      /* Timeout */
> >     +        s->timeout =3D value;
> >     +        break;
> >     +    case REG_SD_BWDR:      /* Bus Width */
> >     +        s->bus_width =3D value;
> >     +        break;
> >     +    case REG_SD_BKSR:      /* Block Size */
> >     +        s->block_size =3D value;
> >     +        break;
> >     +    case REG_SD_BYCR:      /* Byte Count */
> >     +        s->byte_count =3D value;
> >     +        s->transfer_cnt =3D value;
> >     +        break;
> >     +    case REG_SD_CMDR:      /* Command */
> >     +        s->command =3D value;
> >     +        if (value & SD_CMDR_LOAD) {
> >     +            aw_h3_sdhost_send_command(s);
> >     +            aw_h3_sdhost_dma(s);
> >     +            aw_h3_sdhost_auto_stop(s);
> >     +        }
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_CAGR:      /* Command Argument */
> >     +        s->command_arg =3D value;
> >     +        break;
> >     +    case REG_SD_RESP0:     /* Response Zero */
> >     +        s->response[0] =3D value;
> >     +        break;
> >     +    case REG_SD_RESP1:     /* Response One */
> >     +        s->response[1] =3D value;
> >     +        break;
> >     +    case REG_SD_RESP2:     /* Response Two */
> >     +        s->response[2] =3D value;
> >     +        break;
> >     +    case REG_SD_RESP3:     /* Response Three */
> >     +        s->response[3] =3D value;
> >     +        break;
> >     +    case REG_SD_IMKR:      /* Interrupt Mask */
> >     +        s->irq_mask =3D value;
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_MISR:      /* Masked Interrupt Status */
> >     +    case REG_SD_RISR:      /* Raw Interrupt Status */
> >     +        s->irq_status &=3D ~value;
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_STAR:      /* Status */
> >     +        s->status &=3D ~value;
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_FWLR:      /* FIFO Water Level */
> >     +        s->fifo_wlevel =3D value;
> >     +        break;
> >     +    case REG_SD_FUNS:      /* FIFO Function Select */
> >     +        s->fifo_func_sel =3D value;
> >     +        break;
> >     +    case REG_SD_DBGC:      /* Debug Enable */
> >     +        s->debug_enable =3D value;
> >     +        break;
> >     +    case REG_SD_A12A:      /* Auto command 12 argument */
> >     +        s->auto12_arg =3D value;
> >     +        break;
> >     +    case REG_SD_NTSR:      /* SD NewTiming Set */
> >     +        s->newtiming_set =3D value;
> >     +        break;
> >     +    case REG_SD_SDBG:      /* SD newTiming Set Debug */
> >     +        s->newtiming_debug =3D value;
> >     +        break;
> >     +    case REG_SD_HWRST:     /* Hardware Reset Register */
> >     +        s->hardware_rst =3D value;
> >     +        break;
> >     +    case REG_SD_DMAC:      /* Internal DMA Controller Control */
> >     +        s->dmac =3D value;
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_DLBA:      /* Descriptor List Base Address */
> >     +        s->desc_base =3D value;
> >     +        break;
> >     +    case REG_SD_IDST:      /* Internal DMA Controller Status */
> >     +        s->dmac_status &=3D (~SD_IDST_WR_MASK) | (~value &
> >     SD_IDST_WR_MASK);
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_IDIE:      /* Internal DMA Controller Interrupt
> >     Enable */
> >     +        s->dmac_irq =3D value;
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_THLDC:     /* Card Threshold Control */
> >     +        s->card_threshold =3D value;
> >     +        break;
> >     +    case REG_SD_DSBD:      /* eMMC DDR Start Bit Detection Control
> */
> >     +        s->startbit_detect =3D value;
> >     +        break;
> >     +    case REG_SD_FIFO:      /* Read/Write FIFO */
> >     +        sdbus_write_data(&s->sdbus, value & 0xff);
> >     +        sdbus_write_data(&s->sdbus, (value >> 8) & 0xff);
> >     +        sdbus_write_data(&s->sdbus, (value >> 16) & 0xff);
> >     +        sdbus_write_data(&s->sdbus, (value >> 24) & 0xff);
> >     +        aw_h3_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
> >     +        aw_h3_sdhost_auto_stop(s);
> >     +        aw_h3_sdhost_update_irq(s);
> >     +        break;
> >     +    case REG_SD_RES_CRC:   /* Response CRC from card/eMMC */
> >     +    case REG_SD_DATA7_CRC: /* CRC Data 7 from card/eMMC */
> >     +    case REG_SD_DATA6_CRC: /* CRC Data 6 from card/eMMC */
> >     +    case REG_SD_DATA5_CRC: /* CRC Data 5 from card/eMMC */
> >     +    case REG_SD_DATA4_CRC: /* CRC Data 4 from card/eMMC */
> >     +    case REG_SD_DATA3_CRC: /* CRC Data 3 from card/eMMC */
> >     +    case REG_SD_DATA2_CRC: /* CRC Data 2 from card/eMMC */
> >     +    case REG_SD_DATA1_CRC: /* CRC Data 1 from card/eMMC */
> >     +    case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
> >     +    case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write
> >     operation */
> >     +        break;
> >     +    default:
> >     +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
> >     %"HWADDR_PRIx"\n",
> >     +                      __func__, offset);
> >     +        break;
> >     +    }
> >     +}
> >     +
> >     +static const MemoryRegionOps aw_h3_sdhost_ops =3D {
> >     +    .read =3D aw_h3_sdhost_read,
> >     +    .write =3D aw_h3_sdhost_write,
> >     +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>
> I haven't checked .valid accesses from the datasheet.
>
> However due to:
>
>    res =3D s->data_crc[((offset - REG_SD_DATA7_CRC) / sizeof(uint32_t))];
>
> You seem to expect:
>
>             .impl.min_access_size =3D 4,
>
> .impl.max_access_size unset is 8, which should works.
>
> >     +};
> >     +
> >     +static const VMStateDescription vmstate_aw_h3_sdhost =3D {
> >     +    .name =3D TYPE_AW_H3_SDHOST,
>
> Do not use TYPE name in VMStateDescription.name, because we might change
> the value of TYPE, but the migration state has to keep the same name.
>
> >     +    .version_id =3D 1,
> >     +    .minimum_version_id =3D 1,
> >     +    .fields =3D (VMStateField[]) {
> >     +        VMSTATE_UINT32(global_ctl, AwH3SDHostState),
> >     +        VMSTATE_UINT32(clock_ctl, AwH3SDHostState),
> >     +        VMSTATE_UINT32(timeout, AwH3SDHostState),
> >     +        VMSTATE_UINT32(bus_width, AwH3SDHostState),
> >     +        VMSTATE_UINT32(block_size, AwH3SDHostState),
> >     +        VMSTATE_UINT32(byte_count, AwH3SDHostState),
> >     +        VMSTATE_UINT32(transfer_cnt, AwH3SDHostState),
> >     +        VMSTATE_UINT32(command, AwH3SDHostState),
> >     +        VMSTATE_UINT32(command_arg, AwH3SDHostState),
> >     +        VMSTATE_UINT32_ARRAY(response, AwH3SDHostState, 4),
> >     +        VMSTATE_UINT32(irq_mask, AwH3SDHostState),
> >     +        VMSTATE_UINT32(irq_status, AwH3SDHostState),
> >     +        VMSTATE_UINT32(status, AwH3SDHostState),
> >     +        VMSTATE_UINT32(fifo_wlevel, AwH3SDHostState),
> >     +        VMSTATE_UINT32(fifo_func_sel, AwH3SDHostState),
> >     +        VMSTATE_UINT32(debug_enable, AwH3SDHostState),
> >     +        VMSTATE_UINT32(auto12_arg, AwH3SDHostState),
> >     +        VMSTATE_UINT32(newtiming_set, AwH3SDHostState),
> >     +        VMSTATE_UINT32(newtiming_debug, AwH3SDHostState),
> >     +        VMSTATE_UINT32(hardware_rst, AwH3SDHostState),
> >     +        VMSTATE_UINT32(dmac, AwH3SDHostState),
> >     +        VMSTATE_UINT32(desc_base, AwH3SDHostState),
> >     +        VMSTATE_UINT32(dmac_status, AwH3SDHostState),
> >     +        VMSTATE_UINT32(dmac_irq, AwH3SDHostState),
> >     +        VMSTATE_UINT32(card_threshold, AwH3SDHostState),
> >     +        VMSTATE_UINT32(startbit_detect, AwH3SDHostState),
> >     +        VMSTATE_UINT32(response_crc, AwH3SDHostState),
> >     +        VMSTATE_UINT32_ARRAY(data_crc, AwH3SDHostState, 8),
> >     +        VMSTATE_UINT32(status_crc, AwH3SDHostState),
> >     +        VMSTATE_END_OF_LIST()
> >     +    }
> >     +};
> >     +
> >     +static void aw_h3_sdhost_init(Object *obj)
> >     +{
> >     +    AwH3SDHostState *s =3D AW_H3_SDHOST(obj);
> >     +
> >     +    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus),
> >     +                        TYPE_AW_H3_SDHOST_BUS, DEVICE(s), "sd-bus"=
);
> >     +
> >     +    memory_region_init_io(&s->iomem, obj, &aw_h3_sdhost_ops, s,
> >     +                          TYPE_AW_H3_SDHOST,
> >     AW_H3_SDHOST_REGS_MEM_SIZE);
> >     +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> >     +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> >     +}
> >     +
> >     +static void aw_h3_sdhost_reset(DeviceState *dev)
> >     +{
> >     +    AwH3SDHostState *s =3D AW_H3_SDHOST(dev);
> >     +
> >     +    s->global_ctl =3D REG_SD_GCTL_RST;
> >     +    s->clock_ctl =3D REG_SD_CKCR_RST;
> >     +    s->timeout =3D REG_SD_TMOR_RST;
> >     +    s->bus_width =3D REG_SD_BWDR_RST;
> >     +    s->block_size =3D REG_SD_BKSR_RST;
> >     +    s->byte_count =3D REG_SD_BYCR_RST;
> >     +    s->transfer_cnt =3D 0;
> >     +
> >     +    s->command =3D REG_SD_CMDR_RST;
> >     +    s->command_arg =3D REG_SD_CAGR_RST;
> >     +
> >     +    for (int i =3D 0; i < sizeof(s->response) /
> >     sizeof(s->response[0]); i++) {
>
> Please use ARRAY_SIZE(s->response).
>
> >     +        s->response[i] =3D REG_SD_RESP_RST;
> >     +    }
> >     +
> >     +    s->irq_mask =3D REG_SD_IMKR_RST;
> >     +    s->irq_status =3D REG_SD_RISR_RST;
> >     +    s->status =3D REG_SD_STAR_RST;
> >     +
> >     +    s->fifo_wlevel =3D REG_SD_FWLR_RST;
> >     +    s->fifo_func_sel =3D REG_SD_FUNS_RST;
> >     +    s->debug_enable =3D REG_SD_DBGC_RST;
> >     +    s->auto12_arg =3D REG_SD_A12A_RST;
> >     +    s->newtiming_set =3D REG_SD_NTSR_RST;
> >     +    s->newtiming_debug =3D REG_SD_SDBG_RST;
> >     +    s->hardware_rst =3D REG_SD_HWRST_RST;
> >     +    s->dmac =3D REG_SD_DMAC_RST;
> >     +    s->desc_base =3D REG_SD_DLBA_RST;
> >     +    s->dmac_status =3D REG_SD_IDST_RST;
> >     +    s->dmac_irq =3D REG_SD_IDIE_RST;
> >     +    s->card_threshold =3D REG_SD_THLDC_RST;
> >     +    s->startbit_detect =3D REG_SD_DSBD_RST;
> >     +    s->response_crc =3D REG_SD_RES_CRC_RST;
> >     +
> >     +    for (int i =3D 0; i < sizeof(s->data_crc) /
> >     sizeof(s->data_crc[0]); i++) {
>
> ARRAY_SIZE
>
> >     +        s->data_crc[i] =3D REG_SD_DATA_CRC_RST;
> >     +    }
> >     +
> >     +    s->status_crc =3D REG_SD_CRC_STA_RST;
> >     +}
> >     +
> >     +static void aw_h3_sdhost_bus_class_init(ObjectClass *klass, void
> *data)
> >     +{
> >     +    SDBusClass *sbc =3D SD_BUS_CLASS(klass);
> >     +
> >     +    sbc->set_inserted =3D aw_h3_sdhost_set_inserted;
> >     +}
> >     +
> >     +static void aw_h3_sdhost_class_init(ObjectClass *klass, void *data=
)
> >     +{
> >     +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >     +
> >     +    dc->reset =3D aw_h3_sdhost_reset;
> >     +    dc->vmsd =3D &vmstate_aw_h3_sdhost;
> >     +}
> >     +
> >     +static TypeInfo aw_h3_sdhost_info =3D {
> >     +    .name          =3D TYPE_AW_H3_SDHOST,
> >     +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >     +    .instance_size =3D sizeof(AwH3SDHostState),
> >     +    .class_init    =3D aw_h3_sdhost_class_init,
> >     +    .instance_init =3D aw_h3_sdhost_init,
> >     +};
> >     +
> >     +static const TypeInfo aw_h3_sdhost_bus_info =3D {
> >     +    .name =3D TYPE_AW_H3_SDHOST_BUS,
> >     +    .parent =3D TYPE_SD_BUS,
> >     +    .instance_size =3D sizeof(SDBus),
> >     +    .class_init =3D aw_h3_sdhost_bus_class_init,
> >     +};
> >     +
> >     +static void aw_h3_sdhost_register_types(void)
> >     +{
> >     +    type_register_static(&aw_h3_sdhost_info);
> >     +    type_register_static(&aw_h3_sdhost_bus_info);
> >     +}
> >     +
> >     +type_init(aw_h3_sdhost_register_types)
> >     diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> >     index efcff666a2..c672a201b5 100644
> >     --- a/hw/sd/trace-events
> >     +++ b/hw/sd/trace-events
> >     @@ -1,5 +1,12 @@
> >       # See docs/devel/tracing.txt for syntax documentation.
> >
> >     +# allwinner-h3-sdhost.c
> >     +aw_h3_sdhost_set_inserted(bool inserted) "inserted %u"
> >     +aw_h3_sdhost_process_desc(uint64_t desc_addr, uint32_t desc_size,
> >     bool is_write, uint32_t max_bytes) "desc_addr 0x%" PRIx64 "
> >     desc_size %u is_write %u max_bytes %u"
>
> Please also use PRIu32 for desc_size/max_bytes.
>
> >     +aw_h3_sdhost_read(uint64_t offset, uint64_t data, unsigned size)
> >     "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> >     +aw_h3_sdhost_write(uint64_t offset, uint64_t data, unsigned size)
> >     "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> >     +aw_h3_sdhost_update_irq(uint32_t irq) "IRQ bits 0x%x"
>
> PRIx32
>
> >     +
> >       # bcm2835_sdhost.c
> >       bcm2835_sdhost_read(uint64_t offset, uint64_t data, unsigned size=
)
> >     "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> >       bcm2835_sdhost_write(uint64_t offset, uint64_t data, unsigned
> >     size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
> >     diff --git a/include/hw/arm/allwinner-h3.h
> >     b/include/hw/arm/allwinner-h3.h
> >     index 33602599eb..7aff4ebbd2 100644
> >     --- a/include/hw/arm/allwinner-h3.h
> >     +++ b/include/hw/arm/allwinner-h3.h
> >     @@ -30,6 +30,7 @@
> >       #include "hw/misc/allwinner-h3-cpucfg.h"
> >       #include "hw/misc/allwinner-h3-syscon.h"
> >       #include "hw/misc/allwinner-h3-sid.h"
> >     +#include "hw/sd/allwinner-h3-sdhost.h"
> >       #include "target/arm/cpu.h"
> >
> >       #define AW_H3_SRAM_A1_BASE     (0x00000000)
> >     @@ -117,6 +118,7 @@ typedef struct AwH3State {
> >           AwH3CpuCfgState cpucfg;
> >           AwH3SysconState syscon;
> >           AwH3SidState sid;
> >     +    AwH3SDHostState mmc0;
> >           GICState gic;
> >           MemoryRegion sram_a1;
> >           MemoryRegion sram_a2;
> >     diff --git a/include/hw/sd/allwinner-h3-sdhost.h
> >     b/include/hw/sd/allwinner-h3-sdhost.h
> >     new file mode 100644
> >     index 0000000000..6c898a3c84
> >     --- /dev/null
> >     +++ b/include/hw/sd/allwinner-h3-sdhost.h
> >     @@ -0,0 +1,73 @@
> >     +/*
> >     + * Allwinner H3 SD Host Controller emulation
> >     + *
> >     + * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com
> >     <mailto:nieklinnenbank@gmail.com>>
> >     + *
> >     + * This program is free software: you can redistribute it and/or
> modify
> >     + * it under the terms of the GNU General Public License as
> published by
> >     + * the Free Software Foundation, either version 2 of the License, =
or
> >     + * (at your option) any later version.
> >     + *
> >     + * This program is distributed in the hope that it will be useful,
> >     + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >     + * GNU General Public License for more details.
> >     + *
> >     + * You should have received a copy of the GNU General Public Licen=
se
> >     + * along with this program.  If not, see
> >     <http://www.gnu.org/licenses/>.
> >     + */
> >     +
> >     +#ifndef ALLWINNER_H3_SDHOST_H
> >     +#define ALLWINNER_H3_SDHOST_H
> >     +
> >     +#include "hw/sysbus.h"
> >     +#include "hw/sd/sd.h"
> >     +
> >     +#define AW_H3_SDHOST_REGS_MEM_SIZE  (1024)
>
> Move this definition to the source file.
>
> >     +
> >     +#define TYPE_AW_H3_SDHOST "allwinner-h3-sdhost"
> >     +#define AW_H3_SDHOST(obj) \
> >     +        OBJECT_CHECK(AwH3SDHostState, (obj), TYPE_AW_H3_SDHOST)
> >     +
> >     +typedef struct {
> >     +    SysBusDevice busdev;
> >     +    SDBus sdbus;
> >     +    MemoryRegion iomem;
> >     +
> >     +    uint32_t global_ctl;
> >     +    uint32_t clock_ctl;
> >     +    uint32_t timeout;
> >     +    uint32_t bus_width;
> >     +    uint32_t block_size;
> >     +    uint32_t byte_count;
> >     +    uint32_t transfer_cnt;
> >     +
> >     +    uint32_t command;
> >     +    uint32_t command_arg;
> >     +    uint32_t response[4];
> >     +
> >     +    uint32_t irq_mask;
> >     +    uint32_t irq_status;
> >     +    uint32_t status;
> >     +
> >     +    uint32_t fifo_wlevel;
> >     +    uint32_t fifo_func_sel;
> >     +    uint32_t debug_enable;
> >     +    uint32_t auto12_arg;
> >     +    uint32_t newtiming_set;
> >     +    uint32_t newtiming_debug;
> >     +    uint32_t hardware_rst;
> >     +    uint32_t dmac;
> >     +    uint32_t desc_base;
> >     +    uint32_t dmac_status;
> >     +    uint32_t dmac_irq;
> >     +    uint32_t card_threshold;
> >     +    uint32_t startbit_detect;
> >     +    uint32_t response_crc;
> >     +    uint32_t data_crc[8];
> >     +    uint32_t status_crc;
> >     +
> >     +    qemu_irq irq;
> >     +} AwH3SDHostState;
> >     +
> >     +#endif
> >     --
> >     2.17.1
>
> I haven't checked the datasheet for all the registers/bits.
>

Thanks again for all of your helpful comments Philippe!
I've started to rework the patch.

One question about adding tags in the commit message: should I
already add 'Reviewed-by: ' when I re-send v2 of this patch? Or should
that be added after you have seen the v2 changes?


>
> Patch very clean, chapeau!
>

Thank you :-)

Regards,
Niek

>
> Regards,
>
> Phil.
>
>

--=20
Niek Linnenbank

--00000000000048b6cc05999c2987
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIEZyaSwgRGVj
IDEzLCAyMDE5IGF0IDEyOjU2IEFNIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVm
PSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iPnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDsgd3Jv
dGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBOaWVrLDxicj4NCjxicj4NCk9uIDEyLzExLzE5IDExOjM0
IFBNLCBOaWVrIExpbm5lbmJhbmsgd3JvdGU6PGJyPg0KJmd0OyBQaW5nITxicj4NCiZndDsgPGJy
Pg0KJmd0OyBBbnlvbmUgd291bGQgbGlrZSB0byBjb21tZW50IG9uIHRoaXMgZHJpdmVyPzxicj4N
CiZndDsgPGJyPg0KJmd0OyBJIGZpbmlzaGVkIHRoZSByZXdvcmsgb24gYWxsIHByZXZpb3VzIGNv
bW1lbnRzIGluIHRoaXMgc2VyaWVzLjxicj4NCiZndDsgPGJyPg0KJmd0OyBDdXJyZW50bHkgZGVi
dWdnaW5nIHRoZSBoZmxhZ3MgZXJyb3IgcmVwb3J0ZWQgYnkgUGhpbGlwcGUuPGJyPg0KJmd0OyBB
ZnRlciB0aGF0LCBJJiMzOTttIHJlYWR5IHRvIHNlbmQgb3V0IHYyIG9mIHRoZXNlIHBhdGNoZXMu
PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IFJlZ2FyZHMsPGJyPg0KJmd0OyBOaWVrPGJyPg0KJmd0OyA8
YnI+DQomZ3Q7IE9uIE1vbiwgRGVjIDIsIDIwMTkgYXQgMTA6MTAgUE0gTmllayBMaW5uZW5iYW5r
IDxicj4NCiZndDsgJmx0OzxhIGhyZWY9Im1haWx0bzpuaWVrbGlubmVuYmFua0BnbWFpbC5jb20i
IHRhcmdldD0iX2JsYW5rIj5uaWVrbGlubmVuYmFua0BnbWFpbC5jb208L2E+ICZsdDttYWlsdG86
PGEgaHJlZj0ibWFpbHRvOm5pZWtsaW5uZW5iYW5rQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsi
Pm5pZWtsaW5uZW5iYW5rQGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0OyB3cm90ZTo8YnI+DQomZ3Q7IDxi
cj4NCiZndDvCoCDCoCDCoFRoZSBBbGx3aW5uZXIgSDMgU3lzdGVtIG9uIENoaXAgY29udGFpbnMg
YW4gaW50ZWdyYXRlZCBzdG9yYWdlPGJyPg0KJmd0O8KgIMKgIMKgY29udHJvbGxlciBmb3IgU2Vj
dXJlIERpZ2l0YWwgKFNEKSBhbmQgTXVsdGkgTWVkaWEgQ2FyZCAoTU1DKTxicj4NCiZndDvCoCDC
oCDCoGludGVyZmFjZXMuIFRoaXMgY29tbWl0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIEFsbHdpbm5l
ciBIMzxicj4NCiZndDvCoCDCoCDCoFNEL01NQyBzdG9yYWdlIGNvbnRyb2xsZXIgd2l0aCB0aGUg
Zm9sbG93aW5nIGVtdWxhdGVkIGZlYXR1cmVzOjxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKg
IMKgKiBETUEgdHJhbnNmZXJzPGJyPg0KJmd0O8KgIMKgIMKgIMKgKiBEaXJlY3QgRklGTyBJL088
YnI+DQomZ3Q7wqAgwqAgwqAgwqAqIFNob3J0L0xvbmcgZm9ybWF0IGNvbW1hbmQgcmVzcG9uc2Vz
PGJyPg0KJmd0O8KgIMKgIMKgIMKgKiBBdXRvLVN0b3AgY29tbWFuZCAoQ01EMTIpPGJyPg0KJmd0
O8KgIMKgIMKgIMKgKiBJbnNlcnQgJmFtcDsgcmVtb3ZlIGNhcmQgZGV0ZWN0aW9uPGJyPg0KJmd0
OyA8YnI+DQomZ3Q7wqAgwqAgwqBTaWduZWQtb2ZmLWJ5OiBOaWVrIExpbm5lbmJhbmsgJmx0Ozxh
IGhyZWY9Im1haWx0bzpuaWVrbGlubmVuYmFua0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5u
aWVrbGlubmVuYmFua0BnbWFpbC5jb208L2E+PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8
YSBocmVmPSJtYWlsdG86bmlla2xpbm5lbmJhbmtAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
bmlla2xpbm5lbmJhbmtAZ21haWwuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgLS0t
PGJyPg0KJmd0O8KgIMKgIMKgIMKgaHcvYXJtL2FsbHdpbm5lci1oMy5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB8wqAgMjAgKzxicj4NCiZndDvCoCDCoCDCoCDCoGh3L2FybS9vcmFuZ2VwaS5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMTcgKzxicj4NCiZndDvCoCDCoCDCoCDCoGh3
L3NkL01ha2VmaWxlLm9ianPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4N
CiZndDvCoCDCoCDCoCDCoGh3L3NkL2FsbHdpbm5lci1oMy1zZGhvc3QuY8KgIMKgIMKgIMKgIMKg
fCA3OTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4NCiZndDvCoCDCoCDCoCDCoGh3
L3NkL3RyYWNlLWV2ZW50c8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDcgKzxicj4N
CiZndDvCoCDCoCDCoCDCoGluY2x1ZGUvaHcvYXJtL2FsbHdpbm5lci1oMy5owqAgwqAgwqAgwqB8
wqAgwqAyICs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBpbmNsdWRlL2h3L3NkL2FsbHdpbm5lci1oMy1z
ZGhvc3QuaCB8wqAgNzMgKysrPGJyPg0KJmd0O8KgIMKgIMKgIMKgNyBmaWxlcyBjaGFuZ2VkLCA5
MTEgaW5zZXJ0aW9ucygrKTxicj4NCiZndDvCoCDCoCDCoCDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBo
dy9zZC9hbGx3aW5uZXItaDMtc2Rob3N0LmM8YnI+DQomZ3Q7wqAgwqAgwqAgwqBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9ody9zZC9hbGx3aW5uZXItaDMtc2Rob3N0Lmg8YnI+DQomZ3Q7IDxi
cj4NCiZndDvCoCDCoCDCoGRpZmYgLS1naXQgYS9ody9hcm0vYWxsd2lubmVyLWgzLmMgYi9ody9h
cm0vYWxsd2lubmVyLWgzLmM8YnI+DQomZ3Q7wqAgwqAgwqBpbmRleCA0ZmM0YzhjNzI1Li5jMjk3
MmNhZjg4IDEwMDY0NDxicj4NCiZndDvCoCDCoCDCoC0tLSBhL2h3L2FybS9hbGx3aW5uZXItaDMu
Yzxicj4NCiZndDvCoCDCoCDCoCsrKyBiL2h3L2FybS9hbGx3aW5uZXItaDMuYzxicj4NCiZndDvC
oCDCoCDCoEBAIC01MCw2ICs1MCw5IEBAIHN0YXRpYyB2b2lkIGF3X2gzX2luaXQoT2JqZWN0ICpv
YmopPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBzeXNidXNfaW5pdF9jaGls
ZF9vYmoob2JqLCAmcXVvdDtzaWQmcXVvdDssICZhbXA7cy0mZ3Q7c2lkLCBzaXplb2Yocy0mZ3Q7
c2lkKSw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBUWVBFX0FXX0gzX1NJRCk7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBzeXNidXNfaW5pdF9jaGlsZF9vYmoob2JqLCAmcXVvdDttbWMwJnF1b3Q7LCAm
YW1wO3MtJmd0O21tYzAsIHNpemVvZihzLSZndDttbWMwKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgVFlQRV9BV19IM19TREhPU1QpOzxi
cj4NCiZndDvCoCDCoCDCoCDCoH08YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoHN0YXRp
YyB2b2lkIGF3X2gzX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKTxicj4N
CiZndDvCoCDCoCDCoEBAIC0yMTcsNiArMjIwLDIzIEBAIHN0YXRpYyB2b2lkIGF3X2gzX3JlYWxp
emUoRGV2aWNlU3RhdGUgKmRldiw8YnI+DQomZ3Q7wqAgwqAgwqBFcnJvciAqKmVycnApPGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoHN5c2J1c19t
bWlvX21hcChTWVNfQlVTX0RFVklDRSgmYW1wO3MtJmd0O3NpZCksIDAsIEFXX0gzX1NJRF9CQVNF
KTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAvKiBTRC9NTUMgKi88YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVCgmYW1wO3Mt
Jmd0O21tYzApLCB0cnVlLCAmcXVvdDtyZWFsaXplZCZxdW90OywgJmFtcDtlcnIpOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBpZiAoZXJyICE9IE5VTEwpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIHJldHVybjs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBzeXNidXNkZXYgPSBTWVNfQlVTX0RFVklDRSgmYW1wO3MtJmd0O21tYzApOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzeXNidXNfbW1pb19tYXAoc3lzYnVzZGV2LCAwLCBBV19I
M19NTUMwX0JBU0UpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzeXNidXNfY29ubmVjdF9pcnEo
c3lzYnVzZGV2LCAwLCBzLSZndDtpcnFbQVdfSDNfR0lDX1NQSV9NTUMwXSk7PGJyPg0KJmd0O8Kg
IMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBvYmplY3RfcHJvcGVydHlfYWRkX2FsaWFz
KE9CSkVDVChzKSwgJnF1b3Q7c2QtYnVzJnF1b3Q7LCBPQkpFQ1QoJmFtcDtzLSZndDttbWMwKSw8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJnF1b3Q7c2QtYnVzJnF1b3Q7LCAmYW1wO2Vycik7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIGlmIChlcnIpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgZXJyb3JfcHJvcGFn
YXRlKGVycnAsIGVycik7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybjs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAvKiBVbml2ZXJzYWwgU2VyaWFsIEJ1cyAqLzxicj4NCiZndDvCoCDCoCDCoCDC
oCDCoCDCoHN5c2J1c19jcmVhdGVfc2ltcGxlKFRZUEVfQVdfSDNfRUhDSSwgQVdfSDNfRUhDSTBf
QkFTRSw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcy0mZ3Q7aXJxW0FXX0gzX0dJQ19TUElfRUhDSTBdKTs8YnI+DQomZ3Q7wqAgwqAgwqBk
aWZmIC0tZ2l0IGEvaHcvYXJtL29yYW5nZXBpLmMgYi9ody9hcm0vb3JhbmdlcGkuYzxicj4NCiZn
dDvCoCDCoCDCoGluZGV4IDVlZjI3MzVmODEuLmRlZTNlZmFmMDggMTAwNjQ0PGJyPg0KJmd0O8Kg
IMKgIMKgLS0tIGEvaHcvYXJtL29yYW5nZXBpLmM8YnI+DQomZ3Q7wqAgwqAgwqArKysgYi9ody9h
cm0vb3JhbmdlcGkuYzxicj4NCiZndDvCoCDCoCDCoEBAIC0zOSw2ICszOSwxMCBAQCB0eXBlZGVm
IHN0cnVjdCBPcmFuZ2VQaVN0YXRlIHs8YnI+DQomZ3Q7wqAgwqAgwqAgwqBzdGF0aWMgdm9pZCBv
cmFuZ2VwaV9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8YnI+DQomZ3Q7wqAgwqAgwqAgwqB7
PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgT3JhbmdlUGlTdGF0ZSAqcyA9IGdfbmV3KE9yYW5n
ZVBpU3RhdGUsIDEpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBEcml2ZUluZm8gKmRpOzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCBCbG9ja0JhY2tlbmQgKmJsazs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgQnVzU3RhdGUgKmJ1czs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgRGV2aWNlU3RhdGUg
KmNhcmRkZXY7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgRXJyb3IgKmVyciA9IE5VTEw7PGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBzLSZndDtoMyA9IEFXX0gzKG9iamVj
dF9uZXcoVFlQRV9BV19IMykpOzxicj4NCiZndDvCoCDCoCDCoEBAIC02NCw2ICs2OCwxOCBAQCBz
dGF0aWMgdm9pZCBvcmFuZ2VwaV9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSk8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBleGl0KDEpOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDC
oH08YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAvKiBDcmVhdGUgYW5kIHBsdWcg
aW4gdGhlIFNEIGNhcmQgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgZGkgPSBkcml2ZV9nZXRf
bmV4dChJRl9TRCk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGJsayA9IGRpID8gYmxrX2J5X2xl
Z2FjeV9kaW5mbyhkaSkgOiBOVUxMOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBidXMgPSBxZGV2
X2dldF9jaGlsZF9idXMoREVWSUNFKHMtJmd0O2gzKSwgJnF1b3Q7c2QtYnVzJnF1b3Q7KTs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgaWYgKGJ1cyA9PSBOVUxMKSB7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIGVycm9yX3JlcG9ydCgmcXVvdDtObyBTRC9NTUMgZm91bmQgaW4gSDMgb2Jq
ZWN0JnF1b3Q7KTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgZXhpdCgxKTs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCjxicj4NCllvdXIgZGV2aWNlIGFsd2F5cyBjcmVhdGVz
IGEgYnVzLCBzbyBJIGRvbiYjMzk7dCB0aGluayB0aGUgaWYoYnVzKSBjaGVjayBpcyA8YnI+DQp3
b3J0aHdoaWxlLiBFdmVudHVhbGx5IHVzZSBhbiBhc3NlcnQoYnVzKT88YnI+DQo8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgY2FyZGRldiA9IHFkZXZfY3JlYXRlKGJ1cywgVFlQRV9TRF9DQVJEKTs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcWRldl9wcm9wX3NldF9kcml2ZShjYXJkZGV2LCAmcXVv
dDtkcml2ZSZxdW90OywgYmxrLCAmYW1wO2Vycm9yX2ZhdGFsKTs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVDVChjYXJkZGV2KSwgdHJ1ZSwgJnF1
b3Q7cmVhbGl6ZWQmcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgJmFtcDtlcnJvcl9mYXRhbCk7PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoC8qIFJBTSAqLzxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoG1lbW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtX21lbW9y
eSgmYW1wO3MtJmd0O3NkcmFtLCBOVUxMLDxicj4NCiZndDvCoCDCoCDCoCZxdW90O29yYW5nZXBp
LnJhbSZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbWFjaGluZS0mZ3Q7cmFtX3NpemUp
Ozxicj4NCiZndDvCoCDCoCDCoEBAIC04MCw2ICs5Niw3IEBAIHN0YXRpYyB2b2lkIG9yYW5nZXBp
X21hY2hpbmVfaW5pdChNYWNoaW5lQ2xhc3MgKm1jKTxicj4NCiZndDvCoCDCoCDCoCDCoHs8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBtYy0mZ3Q7ZGVzYyA9ICZxdW90O09yYW5nZSBQaSBQQyZx
dW90Ozs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBtYy0mZ3Q7aW5pdCA9IG9yYW5nZXBpX2lu
aXQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIG1jLSZndDtibG9ja19kZWZhdWx0X3R5cGUgPSBJ
Rl9TRDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBtYy0mZ3Q7dW5pdHNfcGVyX2RlZmF1bHRf
YnVzID0gMTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBtYy0mZ3Q7bWluX2NwdXMgPSBBV19I
M19OVU1fQ1BVUzs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBtYy0mZ3Q7bWF4X2NwdXMgPSBB
V19IM19OVU1fQ1BVUzs8YnI+DQomZ3Q7wqAgwqAgwqBkaWZmIC0tZ2l0IGEvaHcvc2QvTWFrZWZp
bGUub2JqcyBiL2h3L3NkL01ha2VmaWxlLm9ianM8YnI+DQomZ3Q7wqAgwqAgwqBpbmRleCBhODg0
YzIzOGRmLi5lN2NjNWFiNzM5IDEwMDY0NDxicj4NCiZndDvCoCDCoCDCoC0tLSBhL2h3L3NkL01h
a2VmaWxlLm9ianM8YnI+DQomZ3Q7wqAgwqAgwqArKysgYi9ody9zZC9NYWtlZmlsZS5vYmpzPGJy
Pg0KJmd0O8KgIMKgIMKgQEAgLTQsNiArNCw3IEBAIGNvbW1vbi1vYmotJChDT05GSUdfU0QpICs9
IHNkLm8gY29yZS5vIHNkbW1jLWludGVybmFsLm88YnI+DQomZ3Q7wqAgwqAgwqAgwqBjb21tb24t
b2JqLSQoQ09ORklHX1NESENJKSArPSBzZGhjaS5vPGJyPg0KJmd0O8KgIMKgIMKgIMKgY29tbW9u
LW9iai0kKENPTkZJR19TREhDSV9QQ0kpICs9IHNkaGNpLXBjaS5vPGJyPg0KJmd0OyA8YnI+DQom
Z3Q7wqAgwqAgwqArb2JqLSQoQ09ORklHX0FMTFdJTk5FUl9IMykgKz0gYWxsd2lubmVyLWgzLXNk
aG9zdC5vPGJyPg0KJmd0O8KgIMKgIMKgIMKgb2JqLSQoQ09ORklHX01JTEtZTUlTVCkgKz0gbWls
a3ltaXN0LW1lbWNhcmQubzxicj4NCiZndDvCoCDCoCDCoCDCoG9iai0kKENPTkZJR19PTUFQKSAr
PSBvbWFwX21tYy5vPGJyPg0KJmd0O8KgIMKgIMKgIMKgb2JqLSQoQ09ORklHX1BYQTJYWCkgKz0g
cHhhMnh4X21tY2kubzxicj4NCiZndDvCoCDCoCDCoGRpZmYgLS1naXQgYS9ody9zZC9hbGx3aW5u
ZXItaDMtc2Rob3N0LmMgYi9ody9zZC9hbGx3aW5uZXItaDMtc2Rob3N0LmM8YnI+DQomZ3Q7wqAg
wqAgwqBuZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4NCiZndDvCoCDCoCDCoGluZGV4IDAwMDAwMDAw
MDAuLjI2ZTExM2ExNDQ8YnI+DQomZ3Q7wqAgwqAgwqAtLS0gL2Rldi9udWxsPGJyPg0KJmd0O8Kg
IMKgIMKgKysrIGIvaHcvc2QvYWxsd2lubmVyLWgzLXNkaG9zdC5jPGJyPg0KJmd0O8KgIMKgIMKg
QEAgLTAsMCArMSw3OTEgQEA8YnI+DQomZ3Q7wqAgwqAgwqArLyo8YnI+DQomZ3Q7wqAgwqAgwqAr
ICogQWxsd2lubmVyIEgzIFNEIEhvc3QgQ29udHJvbGxlciBlbXVsYXRpb248YnI+DQomZ3Q7wqAg
wqAgwqArICo8YnI+DQomZ3Q7wqAgwqAgwqArICogQ29weXJpZ2h0IChDKSAyMDE5IE5pZWsgTGlu
bmVuYmFuayAmbHQ7PGEgaHJlZj0ibWFpbHRvOm5pZWtsaW5uZW5iYW5rQGdtYWlsLmNvbSIgdGFy
Z2V0PSJfYmxhbmsiPm5pZWtsaW5uZW5iYW5rQGdtYWlsLmNvbTwvYT48YnI+DQomZ3Q7wqAgwqAg
wqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzpuaWVrbGlubmVuYmFua0BnbWFpbC5jb20iIHRh
cmdldD0iX2JsYW5rIj5uaWVrbGlubmVuYmFua0BnbWFpbC5jb208L2E+Jmd0OyZndDs8YnI+DQom
Z3Q7wqAgwqAgwqArICo8YnI+DQomZ3Q7wqAgwqAgwqArICogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU6IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnk8YnI+DQomZ3Q7
wqAgwqAgwqArICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBhcyBwdWJsaXNoZWQgYnk8YnI+DQomZ3Q7wqAgwqAgwqArICogdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3I8YnI+
DQomZ3Q7wqAgwqAgwqArICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi48YnI+
DQomZ3Q7wqAgwqAgwqArICo8YnI+DQomZ3Q7wqAgwqAgwqArICogVGhpcyBwcm9ncmFtIGlzIGRp
c3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsPGJyPg0KJmd0O8Kg
IMKgIMKgKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5IG9mPGJyPg0KJmd0O8KgIMKgIMKgKyAqIE1FUkNIQU5UQUJJTElUWSBvciBG
SVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS7CoCBTZWUgdGhlPGJyPg0KJmd0O8KgIMKg
IMKgKyAqIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuPGJyPg0K
Jmd0O8KgIMKgIMKgKyAqPGJyPg0KJmd0O8KgIMKgIMKgKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlPGJyPg0KJmd0O8Kg
IMKgIMKgKyAqIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtLsKgIElmIG5vdCwgc2VlPGJyPg0KJmd0
O8KgIMKgIMKgJmx0OzxhIGhyZWY9Imh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8iIHJlbD0i
bm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy88
L2E+Jmd0Oy48YnI+DQomZ3Q7wqAgwqAgwqArICovPGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZn
dDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDtxZW11L29zZGVwLmgmcXVvdDs8YnI+DQomZ3Q7wqAg
wqAgwqArI2luY2x1ZGUgJnF1b3Q7cWVtdS9sb2cuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCsj
aW5jbHVkZSAmcXVvdDtxZW11L21vZHVsZS5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNpbmNs
dWRlICZxdW90O3N5c2VtdS9ibG9ja2Rldi5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNpbmNs
dWRlICZxdW90O2h3L2lycS5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90
O2h3L3NkL2FsbHdpbm5lci1oMy1zZGhvc3QuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCsjaW5j
bHVkZSAmcXVvdDttaWdyYXRpb24vdm1zdGF0ZS5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNp
bmNsdWRlICZxdW90O3RyYWNlLmgmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgVFlQRV9BV19IM19TREhPU1RfQlVTICZxdW90O2FsbHdpbm5lci1oMy1z
ZGhvc3QtYnVzJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgQVdfSDNfU0RIT1NUX0JV
UyhvYmopIFw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgT0JKRUNUX0NIRUNLKFNEQnVzLCAob2Jq
KSwgVFlQRV9BV19IM19TREhPU1RfQlVTKTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAg
wqAgwqArLyogU0QgSG9zdCByZWdpc3RlciBvZmZzZXRzICovPGJyPg0KJmd0O8KgIMKgIMKgKyNk
ZWZpbmUgUkVHX1NEX0dDVEzCoCDCoCDCoCDCoCAoMHgwMCnCoCAvKiBHbG9iYWwgQ29udHJvbCAq
Lzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9DS0NSwqAgwqAgwqAgwqAgKDB4MDQp
wqAgLyogQ2xvY2sgQ29udHJvbCAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9U
TU9SwqAgwqAgwqAgwqAgKDB4MDgpwqAgLyogVGltZW91dCAqLzxicj4NCiZndDvCoCDCoCDCoCsj
ZGVmaW5lIFJFR19TRF9CV0RSwqAgwqAgwqAgwqAgKDB4MEMpwqAgLyogQnVzIFdpZHRoICovPGJy
Pg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0JLU1LCoCDCoCDCoCDCoCAoMHgxMCnCoCAv
KiBCbG9jayBTaXplICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0JZQ1LCoCDC
oCDCoCDCoCAoMHgxNCnCoCAvKiBCeXRlIENvdW50ICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZp
bmUgUkVHX1NEX0NNRFLCoCDCoCDCoCDCoCAoMHgxOCnCoCAvKiBDb21tYW5kICovPGJyPg0KJmd0
O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0NBR1LCoCDCoCDCoCDCoCAoMHgxQynCoCAvKiBDb21t
YW5kIEFyZ3VtZW50ICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX1JFU1AwwqAg
wqAgwqAgwqAoMHgyMCnCoCAvKiBSZXNwb25zZSBaZXJvICovPGJyPg0KJmd0O8KgIMKgIMKgKyNk
ZWZpbmUgUkVHX1NEX1JFU1AxwqAgwqAgwqAgwqAoMHgyNCnCoCAvKiBSZXNwb25zZSBPbmUgKi88
YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfUkVTUDLCoCDCoCDCoCDCoCgweDI4KcKg
IC8qIFJlc3BvbnNlIFR3byAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9SRVNQ
M8KgIMKgIMKgIMKgKDB4MkMpwqAgLyogUmVzcG9uc2UgVGhyZWUgKi88YnI+DQomZ3Q7wqAgwqAg
wqArI2RlZmluZSBSRUdfU0RfSU1LUsKgIMKgIMKgIMKgICgweDMwKcKgIC8qIEludGVycnVwdCBN
YXNrICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX01JU1LCoCDCoCDCoCDCoCAo
MHgzNCnCoCAvKiBNYXNrZWQgSW50ZXJydXB0IFN0YXR1cyAqLzxicj4NCiZndDvCoCDCoCDCoCsj
ZGVmaW5lIFJFR19TRF9SSVNSwqAgwqAgwqAgwqAgKDB4MzgpwqAgLyogUmF3IEludGVycnVwdCBT
dGF0dXMgKi88YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfU1RBUsKgIMKgIMKgIMKg
ICgweDNDKcKgIC8qIFN0YXR1cyAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9G
V0xSwqAgwqAgwqAgwqAgKDB4NDApwqAgLyogRklGTyBXYXRlciBMZXZlbCAqLzxicj4NCiZndDvC
oCDCoCDCoCsjZGVmaW5lIFJFR19TRF9GVU5TwqAgwqAgwqAgwqAgKDB4NDQpwqAgLyogRklGTyBG
dW5jdGlvbiBTZWxlY3QgKi88YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfREJHQ8Kg
IMKgIMKgIMKgICgweDUwKcKgIC8qIERlYnVnIEVuYWJsZSAqLzxicj4NCiZndDvCoCDCoCDCoCsj
ZGVmaW5lIFJFR19TRF9BMTJBwqAgwqAgwqAgwqAgKDB4NTgpwqAgLyogQXV0byBjb21tYW5kIDEy
IGFyZ3VtZW50ICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX05UU1LCoCDCoCDC
oCDCoCAoMHg1QynCoCAvKiBTRCBOZXdUaW1pbmcgU2V0ICovPGJyPg0KJmd0O8KgIMKgIMKgKyNk
ZWZpbmUgUkVHX1NEX1NEQkfCoCDCoCDCoCDCoCAoMHg2MCnCoCAvKiBTRCBuZXdUaW1pbmcgU2V0
IERlYnVnICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0hXUlNUwqAgwqAgwqAg
wqAoMHg3OCnCoCAvKiBIYXJkd2FyZSBSZXNldCBSZWdpc3RlciAqLzxicj4NCiZndDvCoCDCoCDC
oCsjZGVmaW5lIFJFR19TRF9ETUFDwqAgwqAgwqAgwqAgKDB4ODApwqAgLyogSW50ZXJuYWwgRE1B
IENvbnRyb2xsZXI8YnI+DQomZ3Q7wqAgwqAgwqBDb250cm9sICovPGJyPg0KJmd0O8KgIMKgIMKg
KyNkZWZpbmUgUkVHX1NEX0RMQkHCoCDCoCDCoCDCoCAoMHg4NCnCoCAvKiBEZXNjcmlwdG9yIExp
c3QgQmFzZSBBZGRyZXNzICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0lEU1TC
oCDCoCDCoCDCoCAoMHg4OCnCoCAvKiBJbnRlcm5hbCBETUEgQ29udHJvbGxlciBTdGF0dXMgKi88
YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfSURJRcKgIMKgIMKgIMKgICgweDhDKcKg
IC8qIEludGVybmFsIERNQSBDb250cm9sbGVyIElSUTxicj4NCiZndDvCoCDCoCDCoEVuYWJsZSAq
Lzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9USExEQ8KgIMKgIMKgIMKgKDB4MTAw
KSAvKiBDYXJkIFRocmVzaG9sZCBDb250cm9sICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUg
UkVHX1NEX0RTQkTCoCDCoCDCoCDCoCAoMHgxMEMpIC8qIGVNTUMgRERSIFN0YXJ0IEJpdCBEZXRl
Y3Rpb248YnI+DQomZ3Q7wqAgwqAgwqBDb250cm9sICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZp
bmUgUkVHX1NEX1JFU19DUkPCoCDCoCDCoCgweDExMCkgLyogUmVzcG9uc2UgQ1JDIGZyb20gY2Fy
ZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEE3X0NSQ8KgIMKg
KDB4MTE0KSAvKiBDUkMgRGF0YSA3IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKg
KyNkZWZpbmUgUkVHX1NEX0RBVEE2X0NSQ8KgIMKgKDB4MTE4KSAvKiBDUkMgRGF0YSA2IGZyb20g
Y2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEE1X0NSQ8Kg
IMKgKDB4MTFDKSAvKiBDUkMgRGF0YSA1IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKg
IMKgKyNkZWZpbmUgUkVHX1NEX0RBVEE0X0NSQ8KgIMKgKDB4MTIwKSAvKiBDUkMgRGF0YSA0IGZy
b20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEEzX0NS
Q8KgIMKgKDB4MTI0KSAvKiBDUkMgRGF0YSAzIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEEyX0NSQ8KgIMKgKDB4MTI4KSAvKiBDUkMgRGF0YSAy
IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEEx
X0NSQ8KgIMKgKDB4MTJDKSAvKiBDUkMgRGF0YSAxIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0
O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEEwX0NSQ8KgIMKgKDB4MTMwKSAvKiBDUkMgRGF0
YSAwIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0NS
Q19TVEHCoCDCoCDCoCgweDEzNCkgLyogQ1JDIHN0YXR1cyBmcm9tIGNhcmQvZU1NQzxicj4NCiZn
dDvCoCDCoCDCoGR1cmluZyB3cml0ZSAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19T
RF9GSUZPwqAgwqAgwqAgwqAgKDB4MjAwKSAvKiBSZWFkL1dyaXRlIEZJRk8gKi88YnI+DQomZ3Q7
wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKy8qIFNEIEhvc3QgcmVnaXN0ZXIgZmxhZ3MgKi88
YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9HQ1RMX0ZJRk9fQUNfTU9EwqAgwqAgwqAoMSAm
bHQ7Jmx0OyAzMSk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9HQ1RMX0REUl9NT0RfU0VM
wqAgwqAgwqAoMSAmbHQ7Jmx0OyAxMCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9HQ1RM
X0NEX0RCQ19FTkLCoCDCoCDCoCAoMSAmbHQ7Jmx0OyA4KTxicj4NCiZndDvCoCDCoCDCoCsjZGVm
aW5lIFNEX0dDVExfRE1BX0VOQsKgIMKgIMKgIMKgIMKgKDEgJmx0OyZsdDsgNSk8YnI+DQomZ3Q7
wqAgwqAgwqArI2RlZmluZSBTRF9HQ1RMX0lOVF9FTkLCoCDCoCDCoCDCoCDCoCgxICZsdDsmbHQ7
IDQpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfR0NUTF9ETUFfUlNUwqAgwqAgwqAgwqAg
wqAoMSAmbHQ7Jmx0OyAyKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0dDVExfRklGT19S
U1TCoCDCoCDCoCDCoCAoMSAmbHQ7Jmx0OyAxKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNE
X0dDVExfU09GVF9SU1TCoCDCoCDCoCDCoCAoMSAmbHQ7Jmx0OyAwKTxicj4NCiZndDvCoCDCoCDC
oCs8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9DTURSX0xPQUTCoCDCoCDCoCDCoCDCoCDC
oCAoMSAmbHQ7Jmx0OyAzMSk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9DTURSX0NMS0NI
QU5HRcKgIMKgIMKgIMKgKDEgJmx0OyZsdDsgMjEpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUg
U0RfQ01EUl9XUklURcKgIMKgIMKgIMKgIMKgIMKgKDEgJmx0OyZsdDsgMTApPGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgU0RfQ01EUl9BVVRPU1RPUMKgIMKgIMKgIMKgICgxICZsdDsmbHQ7IDEy
KTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0NNRFJfREFUQcKgIMKgIMKgIMKgIMKgIMKg
ICgxICZsdDsmbHQ7IDkpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfQ01EUl9SRVNQT05T
RV9MT05HwqAgwqAoMSAmbHQ7Jmx0OyA3KTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0NN
RFJfUkVTUE9OU0XCoCDCoCDCoCDCoCAoMSAmbHQ7Jmx0OyA2KTxicj4NCiZndDvCoCDCoCDCoCsj
ZGVmaW5lIFNEX0NNRFJfQ01ESURfTUFTS8KgIMKgIMKgICgweDNmKTxicj4NCiZndDvCoCDCoCDC
oCs8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9SSVNSX0NBUkRfUkVNT1ZFwqAgwqAgwqAo
MSAmbHQ7Jmx0OyAzMSk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9SSVNSX0NBUkRfSU5T
RVJUwqAgwqAgwqAoMSAmbHQ7Jmx0OyAzMCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9S
SVNSX0FVVE9DTURfRE9ORcKgIMKgICgxICZsdDsmbHQ7IDE0KTxicj4NCiZndDvCoCDCoCDCoCsj
ZGVmaW5lIFNEX1JJU1JfREFUQV9DT01QTEVURcKgIMKgKDEgJmx0OyZsdDsgMyk8YnI+DQomZ3Q7
wqAgwqAgwqArI2RlZmluZSBTRF9SSVNSX0NNRF9DT01QTEVURcKgIMKgICgxICZsdDsmbHQ7IDIp
PGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfUklTUl9OT19SRVNQT05TRcKgIMKgIMKgKDEg
Jmx0OyZsdDsgMSk8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUg
U0RfU1RBUl9DQVJEX1BSRVNFTlTCoCDCoCAoMSAmbHQ7Jmx0OyA4KTxicj4NCiZndDvCoCDCoCDC
oCs8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9JRFNUX1NVTV9SRUNFSVZFX0lSUSAoMSAm
bHQ7Jmx0OyA4KTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0lEU1RfUkVDRUlWRV9JUlHC
oCDCoCDCoCgxICZsdDsmbHQ7IDEpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfSURTVF9U
UkFOU01JVF9JUlHCoCDCoCAoMSAmbHQ7Jmx0OyAwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5l
IFNEX0lEU1RfSVJRX01BU0vCoCDCoCDCoCDCoCAoU0RfSURTVF9SRUNFSVZFX0lSUSB8PGJyPg0K
Jmd0O8KgIMKgIMKgU0RfSURTVF9UUkFOU01JVF9JUlEgfCBcPGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgU0RfSURTVF9T
VU1fUkVDRUlWRV9JUlEpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfSURTVF9XUl9NQVNL
wqAgwqAgwqAgwqAgwqAoMHgzZmYpPGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDC
oCsvKiBTRCBIb3N0IHJlZ2lzdGVyIHJlc2V0IHZhbHVlcyAqLzxicj4NCiZndDvCoCDCoCDCoCsj
ZGVmaW5lIFJFR19TRF9HQ1RMX1JTVMKgIMKgIMKgIMKgIMKgKDB4MDAwMDAzMDApPGJyPg0KJmd0
O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0NLQ1JfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4N
CiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9UTU9SX1JTVMKgIMKgIMKgIMKgIMKgKDB4RkZG
RkZGNDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0JXRFJfUlNUwqAgwqAgwqAg
wqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9CS1NSX1JTVMKgIMKg
IMKgIMKgIMKgKDB4MDAwMDAyMDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0JZ
Q1JfUlNUwqAgwqAgwqAgwqAgwqAoMHgwMDAwMDIwMCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmlu
ZSBSRUdfU0RfQ01EUl9SU1TCoCDCoCDCoCDCoCDCoCgweDApPGJyPg0KJmd0O8KgIMKgIMKgKyNk
ZWZpbmUgUkVHX1NEX0NBR1JfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDC
oCsjZGVmaW5lIFJFR19TRF9SRVNQX1JTVMKgIMKgIMKgIMKgIMKgKDB4MCk8YnI+DQomZ3Q7wqAg
wqAgwqArI2RlZmluZSBSRUdfU0RfSU1LUl9SU1TCoCDCoCDCoCDCoCDCoCgweDApPGJyPg0KJmd0
O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX01JU1JfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4N
CiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9SSVNSX1JTVMKgIMKgIMKgIMKgIMKgKDB4MCk8
YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfU1RBUl9SU1TCoCDCoCDCoCDCoCDCoCgw
eDAwMDAwMTAwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9GV0xSX1JTVMKgIMKg
IMKgIMKgIMKgKDB4MDAwRjAwMDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0ZV
TlNfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19T
RF9EQkdDX1JTVMKgIMKgIMKgIMKgIMKgKDB4MCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBS
RUdfU0RfQTEyQV9SU1TCoCDCoCDCoCDCoCDCoCgweDAwMDBGRkZGKTxicj4NCiZndDvCoCDCoCDC
oCsjZGVmaW5lIFJFR19TRF9OVFNSX1JTVMKgIMKgIMKgIMKgIMKgKDB4MDAwMDAwMDEpPGJyPg0K
Jmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX1NEQkdfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxi
cj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9IV1JTVF9SU1TCoCDCoCDCoCDCoCAoMHgw
MDAwMDAwMSk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfRE1BQ19SU1TCoCDCoCDC
oCDCoCDCoCgweDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RMQkFfUlNUwqAg
wqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9JRFNUX1JT
VMKgIMKgIMKgIMKgIMKgKDB4MCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfSURJ
RV9SU1TCoCDCoCDCoCDCoCDCoCgweDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NE
X1RITERDX1JTVMKgIMKgIMKgIMKgICgweDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVH
X1NEX0RTQkRfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5l
IFJFR19TRF9SRVNfQ1JDX1JTVMKgIMKgIMKgICgweDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZp
bmUgUkVHX1NEX0RBVEFfQ1JDX1JTVMKgIMKgIMKgKDB4MCk8YnI+DQomZ3Q7wqAgwqAgwqArI2Rl
ZmluZSBSRUdfU0RfQ1JDX1NUQV9SU1TCoCDCoCDCoCAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsj
ZGVmaW5lIFJFR19TRF9GSUZPX1JTVMKgIMKgIMKgIMKgIMKgKDB4MCk8YnI+DQomZ3Q7wqAgwqAg
wqArPGJyPg0KJmd0O8KgIMKgIMKgKy8qIERhdGEgdHJhbnNmZXIgZGVzY3JpcHRvciBmb3IgRE1B
ICovPGJyPg0KJmd0O8KgIMKgIMKgK3R5cGVkZWYgc3RydWN0IFRyYW5zZmVyRGVzY3JpcHRvciB7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IHN0YXR1czsgLyogU3RhdHVzIGZsYWdz
ICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IHNpemU7wqAgwqAvKiBEYXRhIGJ1
ZmZlciBzaXplICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGFkZHI7wqAgwqAv
KiBEYXRhIGJ1ZmZlciBhZGRyZXNzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90
IG5leHQ7wqAgwqAvKiBQaHlzaWNhbCBhZGRyZXNzIG9mIG5leHQgZGVzY3JpcHRvciAqLzxicj4N
CiZndDvCoCDCoCDCoCt9IFRyYW5zZmVyRGVzY3JpcHRvcjs8YnI+DQomZ3Q7wqAgwqAgwqArPGJy
Pg0KJmd0O8KgIMKgIMKgKy8qIERhdGEgdHJhbnNmZXIgZGVzY3JpcHRvciBmbGFncyAqLzxicj4N
CiZndDvCoCDCoCDCoCsjZGVmaW5lIERFU0NfU1RBVFVTX0hPTETCoCDCoCgxICZsdDsmbHQ7IDMx
KSAvKiBTZXQgd2hlbiBkZXNjcmlwdG9yIGlzIGluPGJyPg0KJmd0O8KgIMKgIMKgdXNlIGJ5IERN
QSAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIERFU0NfU1RBVFVTX0VSUk9SwqAgKDEgJmx0
OyZsdDsgMzApIC8qIFNldCB3aGVuIERNQSB0cmFuc2ZlciBlcnJvcjxicj4NCiZndDvCoCDCoCDC
oG9jY3VycmVkICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgREVTQ19TVEFUVVNfQ0hBSU7C
oCAoMSAmbHQ7Jmx0OyA0KcKgIC8qIEluZGljYXRlcyBjaGFpbmVkPGJyPg0KJmd0O8KgIMKgIMKg
ZGVzY3JpcHRvci4gKi88YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBERVNDX1NUQVRVU19GSVJT
VMKgICgxICZsdDsmbHQ7IDMpwqAgLyogU2V0IG9uIHRoZSBmaXJzdCBkZXNjcmlwdG9yICovPGJy
Pg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgREVTQ19TVEFUVVNfTEFTVMKgIMKgKDEgJmx0OyZsdDsg
MinCoCAvKiBTZXQgb24gdGhlIGxhc3QgZGVzY3JpcHRvciAqLzxicj4NCiZndDvCoCDCoCDCoCsj
ZGVmaW5lIERFU0NfU1RBVFVTX05PSVJRwqAgKDEgJmx0OyZsdDsgMSnCoCAvKiBTa2lwIHJhaXNp
bmcgaW50ZXJydXB0PGJyPg0KJmd0O8KgIMKgIMKgYWZ0ZXIgdHJhbnNmZXIgKi88YnI+DQomZ3Q7
wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgREVTQ19TSVpFX01BU0vCoCDCoCDC
oCgweGZmZmZmZmZjKTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArc3RhdGlj
IHZvaWQgYXdfaDNfc2Rob3N0X3VwZGF0ZV9pcnEoQXdIM1NESG9zdFN0YXRlICpzKTxicj4NCiZn
dDvCoCDCoCDCoCt7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGlycV9lbiA9IHMt
Jmd0O2dsb2JhbF9jdGwgJmFtcDsgU0RfR0NUTF9JTlRfRU5COzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCB1aW50MzJfdCBpcnEgPSBpcnFfZW4gPyBzLSZndDtpcnFfc3RhdHVzICZhbXA7IHMtJmd0
O2lycV9tYXNrIDogMDs8YnI+DQo8YnI+DQpUaGUgcHJldmlvdXMgbGluZSBpcyBjb25mdXNlLCBl
aXRoZXIgdXNlIHBhcmVudGhlc2lzIG9yIGEgaWYgc3RhdGVtZW50Ljxicj4NCjxicj4NCsKgIMKg
IMKgdWludDMyX3QgaXJxID0gaXJxX2VuID8gKHMtJmd0O2lycV9zdGF0dXMgJmFtcDsgcy0mZ3Q7
aXJxX21hc2spIDogMDs8YnI+DQo8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIHRyYWNlX2F3X2gzX3NkaG9zdF91cGRhdGVfaXJxKGlycSk7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIHFlbXVfc2V0X2lycShzLSZndDtpcnEsIGlycSk7PGJyPg0KJmd0O8KgIMKgIMKg
K308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3N0YXRpYyB2b2lkIGF3X2gz
X3NkaG9zdF91cGRhdGVfdHJhbnNmZXJfY250KEF3SDNTREhvc3RTdGF0ZSAqcyw8YnI+DQomZ3Q7
wqAgwqAgwqB1aW50MzJfdCBieXRlcyk8YnI+DQomZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBpZiAocy0mZ3Q7dHJhbnNmZXJfY250ICZndDsgYnl0ZXMpIHs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7dHJhbnNmZXJfY250IC09IGJ5dGVzOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCB9IGVsc2Ugezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBz
LSZndDt0cmFuc2Zlcl9jbnQgPSAwOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0
O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBpZiAoIXMtJmd0O3RyYW5zZmVyX2Nu
dCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtpcnFfc3RhdHVzIHw9IFNE
X1JJU1JfREFUQV9DT01QTEVURSB8IFNEX1JJU1JfQVVUT0NNRF9ET05FOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgK308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0K
Jmd0O8KgIMKgIMKgK3N0YXRpYyB2b2lkIGF3X2gzX3NkaG9zdF9zZXRfaW5zZXJ0ZWQoRGV2aWNl
U3RhdGUgKmRldiwgYm9vbCBpbnNlcnRlZCk8YnI+DQomZ3Q7wqAgwqAgwqArezxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCBBd0gzU0RIb3N0U3RhdGUgKnMgPSBBV19IM19TREhPU1QoZGV2KTs8YnI+
DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHRyYWNlX2F3X2gzX3NkaG9z
dF9zZXRfaW5zZXJ0ZWQoaW5zZXJ0ZWQpOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgaWYgKGluc2VydGVkKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IHMtJmd0O2lycV9zdGF0dXMgfD0gU0RfUklTUl9DQVJEX0lOU0VSVDs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgcy0mZ3Q7aXJxX3N0YXR1cyAmYW1wOz0gflNEX1JJU1JfQ0FSRF9SRU1P
VkU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O3N0YXR1cyB8PSBTRF9TVEFS
X0NBUkRfUFJFU0VOVDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7aXJxX3N0YXR1cyAmYW1wOz0gflNEX1JJU1JfQ0FS
RF9JTlNFUlQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2lycV9zdGF0dXMg
fD0gU0RfUklTUl9DQVJEX1JFTU9WRTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0m
Z3Q7c3RhdHVzICZhbXA7PSB+U0RfU1RBUl9DQVJEX1BSRVNFTlQ7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGF3X2gz
X3NkaG9zdF91cGRhdGVfaXJxKHMpOzxicj4NCiZndDvCoCDCoCDCoCt9PGJyPg0KJmd0O8KgIMKg
IMKgKzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBhd19oM19zZGhvc3Rfc2VuZF9jb21t
YW5kKEF3SDNTREhvc3RTdGF0ZSAqcyk8YnI+DQomZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBTRFJlcXVlc3QgcmVxdWVzdDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWlu
dDhfdCByZXNwWzE2XTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgaW50IHJsZW47PGJyPg0KJmd0
O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAvKiBBdXRvIGNsZWFyIGxvYWQgZmxh
ZyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtjb21tYW5kICZhbXA7PSB+U0RfQ01E
Ul9MT0FEOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLyogQ2xv
Y2sgY2hhbmdlIGRvZXMgbm90IGFjdHVhbGx5IGludGVyYWN0IHdpdGggdGhlIFNEIGJ1cyAqLzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBpZiAoIShzLSZndDtjb21tYW5kICZhbXA7IFNEX0NNRFJf
Q0xLQ0hBTkdFKSkgezxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgLyogUHJlcGFyZSByZXF1ZXN0ICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IHJlcXVlc3QuY21kID0gcy0mZ3Q7Y29tbWFuZCAmYW1wOyBTRF9DTURSX0NNRElEX01BU0s7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcXVlc3QuYXJnID0gcy0mZ3Q7Y29tbWFuZF9h
cmc7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCAvKiBT
ZW5kIHJlcXVlc3QgdG8gU0QgYnVzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJs
ZW4gPSBzZGJ1c19kb19jb21tYW5kKCZhbXA7cy0mZ3Q7c2RidXMsICZhbXA7cmVxdWVzdCwgcmVz
cCk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGlmIChybGVuICZsdDsgMCkgezxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycm9yOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCAvKiBJZiB0aGUgY29tbWFuZCBoYXMgYSByZXNwb25zZSwgc3RvcmUgaXQgaW4g
dGhlIHJlc3BvbnNlPGJyPg0KJmd0O8KgIMKgIMKgcmVnaXN0ZXJzICovPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIGlmICgocy0mZ3Q7Y29tbWFuZCAmYW1wOyBTRF9DTURSX1JFU1BPTlNF
KSkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmxlbiA9PSAwIHx8
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHJsZW4gPT0gNCAmYW1w
OyZhbXA7IChzLSZndDtjb21tYW5kICZhbXA7IFNEX0NNRFJfUkVTUE9OU0VfTE9ORykpKSB7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgwqAgwqAgaWYgKHJsZW4gIT0gNCAmYW1wOyZhbXA7IHJsZW4gIT0gMTYpIHs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJvcjs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCk1heWJlIHJlbW92ZSBwcmV2
aW91cyBpZi4uLjxicj4NCjxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBpZiAo
cmxlbiA9PSA0KSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHMt
Jmd0O3Jlc3BvbnNlWzBdID0gbGRsX2JlX3AoJmFtcDtyZXNwWzBdKTs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcy0mZ3Q7cmVzcG9uc2VbMV0gPSBzLSZndDtyZXNw
b25zZVsyXSA9IHMtJmd0O3Jlc3BvbnNlWzNdID0gMDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQo8YnI+DQouLi48YnI+DQo8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2UgaWYgKHJsZW4gPT0gMTYpIHsgLi4uPGJyPg0KPGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHMtJmd0O3Jlc3BvbnNlWzBd
ID0gbGRsX2JlX3AoJmFtcDtyZXNwWzEyXSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHMtJmd0O3Jlc3BvbnNlWzFdID0gbGRsX2JlX3AoJmFtcDtyZXNwWzhdKTs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcy0mZ3Q7cmVzcG9uc2Vb
Ml0gPSBsZGxfYmVfcCgmYW1wO3Jlc3BbNF0pOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzLSZndDtyZXNwb25zZVszXSA9IGxkbF9iZV9wKCZhbXA7cmVzcFswXSk7
PGJyPg0KPGJyPg0KLi4uPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fSBlbHNlIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVy
cm9yOzxicj4NCjxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZn
dDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLyogU2V0IGludGVycnVwdCBzdGF0
dXMgYml0cyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtpcnFfc3RhdHVzIHw9IFNE
X1JJU1JfQ01EX0NPTVBMRVRFOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCByZXR1cm47PGJyPg0K
Jmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtlcnJvcjo8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgcy0mZ3Q7aXJxX3N0YXR1cyB8PSBTRF9SSVNSX05PX1JFU1BPTlNFOzxicj4NCiZndDvC
oCDCoCDCoCt9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMgdm9p
ZCBhd19oM19zZGhvc3RfYXV0b19zdG9wKEF3SDNTREhvc3RTdGF0ZSAqcyk8YnI+DQomZ3Q7wqAg
wqAgwqArezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAvKjxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCogVGhlIHN0b3AgY29tbWFuZCAoQ01EMTIpIGVuc3VyZXMgdGhlIFNEIGJ1czxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCogcmV0dXJucyB0byB0aGUgdHJhbnNmZXIgc3RhdGUuPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgaWYgKChzLSZn
dDtjb21tYW5kICZhbXA7IFNEX0NNRFJfQVVUT1NUT1ApICZhbXA7JmFtcDsgKHMtJmd0O3RyYW5z
ZmVyX2NudCA9PSAwKSkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCAvKiBGaXJzdCBz
YXZlIGN1cnJlbnQgY29tbWFuZCByZWdpc3RlcnMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgdWludDMyX3Qgc2F2ZWRfY21kID0gcy0mZ3Q7Y29tbWFuZDs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgdWludDMyX3Qgc2F2ZWRfYXJnID0gcy0mZ3Q7Y29tbWFuZF9hcmc7PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCAvKiBQcmVwYXJl
IHN0b3AgY29tbWFuZCAoQ01EMTIpICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMt
Jmd0O2NvbW1hbmQgJmFtcDs9IH5TRF9DTURSX0NNRElEX01BU0s7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIHMtJmd0O2NvbW1hbmQgfD0gMTI7IC8qIENNRDEyICovPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2NvbW1hbmRfYXJnID0gMDs8YnI+DQomZ3Q7wqAgwqAg
wqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIC8qIFB1dCB0aGUgY29tbWFuZCBvbiBT
RCBidXMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3NlbmRf
Y29tbWFuZChzKTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIC8qIFJlc3RvcmUgY29tbWFuZCB2YWx1ZXMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgcy0mZ3Q7Y29tbWFuZCA9IHNhdmVkX2NtZDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgcy0mZ3Q7Y29tbWFuZF9hcmcgPSBzYXZlZF9hcmc7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAg
wqAgwqArc3RhdGljIHVpbnQzMl90IGF3X2gzX3NkaG9zdF9wcm9jZXNzX2Rlc2MoQXdIM1NESG9z
dFN0YXRlICpzLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBod2FkZHIgZGVzY19hZGRyLDxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBUcmFuc2ZlckRlc2NyaXB0b3IgKmRlc2MsPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGJvb2wgaXNfd3JpdGUsIHVpbnQzMl90PGJyPg0KJmd0O8KgIMKgIMKgbWF4
X2J5dGVzKTxicj4NCiZndDvCoCDCoCDCoCt7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQz
Ml90IG51bV9kb25lID0gMDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgbnVtX2J5
dGVzID0gbWF4X2J5dGVzOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50OF90IGJ1ZlsxMDI0
XTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC8qIFJlYWQgZGVz
Y3JpcHRvciAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjcHVfcGh5c2ljYWxfbWVtb3J5X3Jl
YWQoZGVzY19hZGRyLCBkZXNjLCBzaXplb2YoKmRlc2MpKTs8YnI+DQo8YnI+DQpTaG91bGQgd2Ug
d29ycnkgYWJvdXQgZW5kaWFuZXNzIGhlcmU/PGJyPg0KPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IGlmIChkZXNjLSZndDtzaXplID09IDApIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
ZGVzYy0mZ3Q7c2l6ZSA9IDB4ZmZmZiArIDE7PGJyPg0KPGJyPg0KV2h5IG5vdCB3cml0ZSAmIzM5
OzY0ICogS2lCJiMzOTs/PGJyPg0KPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIH08YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgaWYgKGRlc2MtJmd0O3NpemUgJmx0OyBudW1fYnl0ZXMpIHs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgbnVtX2J5dGVzID0gZGVzYy0mZ3Q7c2l6ZTs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgdHJhY2VfYXdfaDNfc2Rob3N0X3Byb2Nlc3NfZGVzYyhkZXNjX2FkZHIsIGRlc2MtJmd0
O3NpemUsPGJyPg0KJmd0O8KgIMKgIMKgaXNfd3JpdGUsIG1heF9ieXRlcyk7PGJyPg0KJmd0O8Kg
IMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB3aGlsZSAobnVtX2RvbmUgJmx0OyBudW1f
Ynl0ZXMpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgLyogVHJ5IHRvIGNvbXBsZXRl
bHkgZmlsbCB0aGUgbG9jYWwgYnVmZmVyICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IHVpbnQzMl90IGJ1Zl9ieXRlcyA9IG51bV9ieXRlcyAtIG51bV9kb25lOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCBpZiAoYnVmX2J5dGVzICZndDsgc2l6ZW9mKGJ1ZikpIHs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgYnVmX2J5dGVzID0gc2l6ZW9mKGJ1Zik7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIC8qIFdyaXRlIHRvIFNEIGJ1cyAqLzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCBpZiAoaXNfd3JpdGUpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgwqAgwqAgY3B1X3BoeXNpY2FsX21lbW9yeV9yZWFkKChkZXNjLSZndDthZGRyICZhbXA7
IERFU0NfU0laRV9NQVNLKTxicj4NCiZndDvCoCDCoCDCoCsgbnVtX2RvbmUsPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGJ1ZiwgYnVmX2J5dGVzKTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIMKgIMKgIGZvciAodWludDMyX3QgaSA9IDA7IGkgJmx0OyBidWZfYnl0
ZXM7IGkrKykgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZGJ1
c193cml0ZV9kYXRhKCZhbXA7cy0mZ3Q7c2RidXMsIGJ1ZltpXSk7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIC8qIFJlYWQgZnJvbSBTRCBidXMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgZm9y
ICh1aW50MzJfdCBpID0gMDsgaSAmbHQ7IGJ1Zl9ieXRlczsgaSsrKSB7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJ1ZltpXSA9IHNkYnVzX3JlYWRfZGF0YSgmYW1w
O3MtJmd0O3NkYnVzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBjcHVfcGh5c2ljYWxfbWVtb3J5X3dyaXRl
KChkZXNjLSZndDthZGRyICZhbXA7IERFU0NfU0laRV9NQVNLKTxicj4NCiZndDvCoCDCoCDCoCsg
bnVtX2RvbmUsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnVmLCBidWZfYnl0ZXMpOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIG51bV9k
b25lICs9IGJ1Zl9ieXRlczs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDC
oCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLyogQ2xlYXIgaG9sZCBmbGFnIGFuZCBmbHVz
aCBkZXNjcmlwdG9yICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGRlc2MtJmd0O3N0YXR1cyAm
YW1wOz0gfkRFU0NfU1RBVFVTX0hPTEQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNwdV9waHlz
aWNhbF9tZW1vcnlfd3JpdGUoZGVzY19hZGRyLCBkZXNjLCBzaXplb2YoKmRlc2MpKTs8YnI+DQo8
YnI+DQooUmVsYXRlZCB0byBwcmV2aW91cyBlbmRpYW5lc3MgcXVlc3Rpb24pLjxicj4NCjxicj4N
CiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcmV0dXJuIG51bV9kb25lOzxi
cj4NCiZndDvCoCDCoCDCoCt9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtz
dGF0aWMgdm9pZCBhd19oM19zZGhvc3RfZG1hKEF3SDNTREhvc3RTdGF0ZSAqcyk8YnI+DQomZ3Q7
wqAgwqAgwqArezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBUcmFuc2ZlckRlc2NyaXB0b3IgZGVz
Yzs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgaHdhZGRyIGRlc2NfYWRkciA9IHMtJmd0O2Rlc2Nf
YmFzZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgYm9vbCBpc193cml0ZSA9IChzLSZndDtjb21t
YW5kICZhbXA7IFNEX0NNRFJfV1JJVEUpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJf
dCBieXRlc19kb25lID0gMDs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIC8qIENoZWNrIGlmIERNQSBjYW4gYmUgcGVyZm9ybWVkICovPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIGlmIChzLSZndDtieXRlX2NvdW50ID09IDAgfHwgcy0mZ3Q7YmxvY2tfc2l6ZSA9PSAw
IHx8PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgICEocy0mZ3Q7Z2xvYmFsX2N0bCAmYW1wOyBT
RF9HQ1RMX0RNQV9FTkIpKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybjs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgLyo8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAqIEZvciByZWFkIG9wZXJh
dGlvbnMsIGRhdGEgbXVzdCBiZSBhdmFpbGFibGUgb24gdGhlIFNEIGJ1czxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCogSWYgbm90LCBpdCBpcyBhbiBlcnJvciBhbmQgd2Ugc2hvdWxkIG5vdCBh
Y3QgYXQgYWxsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgKi88YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgaWYgKCFpc193cml0ZSAmYW1wOyZhbXA7ICFzZGJ1c19kYXRhX3JlYWR5KCZhbXA7cy0m
Z3Q7c2RidXMpKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybjs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgLyogUHJvY2VzcyB0aGUgRE1BIGRlc2NyaXB0b3JzIHVudGlsIGFsbCBkYXRhIGlzIGNv
cGllZCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB3aGlsZSAocy0mZ3Q7Ynl0ZV9jb3VudCAm
Z3Q7IDApIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnl0ZXNfZG9uZSA9IGF3X2gz
X3NkaG9zdF9wcm9jZXNzX2Rlc2MocywgZGVzY19hZGRyLCAmYW1wO2Rlc2MsPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaXNfd3JpdGUsPGJyPg0KJmd0O8KgIMKgIMKgcy0mZ3Q7Ynl0
ZV9jb3VudCk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF91cGRh
dGVfdHJhbnNmZXJfY250KHMsIGJ5dGVzX2RvbmUpOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgaWYgKGJ5dGVzX2RvbmUgJmx0Oz0gcy0mZ3Q7Ynl0ZV9j
b3VudCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBzLSZndDtieXRlX2Nv
dW50IC09IGJ5dGVzX2RvbmU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIH0gZWxzZSB7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIHMtJmd0O2J5dGVfY291bnQgPSAw
Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBpZiAoZGVzYy5zdGF0dXMgJmFtcDsgREVTQ19TVEFU
VVNfTEFTVCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgwqAgwqAgZGVzY19hZGRyID0gZGVzYy5uZXh0Ozxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAr
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC8qIFJhaXNlIElSUSB0byBzaWduYWwgRE1BIGlzIGNv
bXBsZXRlZCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtpcnFfc3RhdHVzIHw9IFNE
X1JJU1JfREFUQV9DT01QTEVURSB8IFNEX1JJU1JfQVVUT0NNRF9ET05FOzxicj4NCiZndDvCoCDC
oCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLyogVXBkYXRlIERNQUMgYml0cyAqLzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCBpZiAoaXNfd3JpdGUpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgcy0mZ3Q7ZG1hY19zdGF0dXMgfD0gU0RfSURTVF9UUkFOU01JVF9JUlE7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIH0gZWxzZSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IHMtJmd0O2RtYWNfc3RhdHVzIHw9IChTRF9JRFNUX1NVTV9SRUNFSVZFX0lSUSB8PGJyPg0KJmd0
O8KgIMKgIMKgU0RfSURTVF9SRUNFSVZFX0lSUSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIH08
YnI+DQomZ3Q7wqAgwqAgwqArfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAr
c3RhdGljIHVpbnQ2NF90IGF3X2gzX3NkaG9zdF9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9m
ZnNldCw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgdW5zaWduZWQgc2l6ZSk8YnI+DQomZ3Q7wqAgwqAgwqArezxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCBBd0gzU0RIb3N0U3RhdGUgKnMgPSAoQXdIM1NESG9zdFN0YXRl
ICopb3BhcXVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCByZXMgPSAwOzxicj4N
CiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgc3dpdGNoIChvZmZzZXQpIHs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfR0NUTDrCoCDCoCDCoCAvKiBHbG9i
YWwgQ29udHJvbCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtn
bG9iYWxfY3RsOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfQ0tDUjrCoCDCoCDCoCAvKiBDbG9jayBDb250cm9s
ICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O2Nsb2NrX2N0bDs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIGNhc2UgUkVHX1NEX1RNT1I6wqAgwqAgwqAgLyogVGltZW91dCAqLzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDt0aW1lb3V0Ozxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfQldE
UjrCoCDCoCDCoCAvKiBCdXMgV2lkdGggKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
cmVzID0gcy0mZ3Q7YnVzX3dpZHRoOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVh
azs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfQktTUjrCoCDCoCDCoCAvKiBC
bG9jayBTaXplICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O2Js
b2NrX3NpemU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9CWUNSOsKgIMKgIMKgIC8qIEJ5dGUgQ291bnQgKi88
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7Ynl0ZV9jb3VudDs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IGNhc2UgUkVHX1NEX0NNRFI6wqAgwqAgwqAgLyogQ29tbWFuZCAqLzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtjb21tYW5kOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfQ0FHUjrC
oCDCoCDCoCAvKiBDb21tYW5kIEFyZ3VtZW50ICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIHJlcyA9IHMtJmd0O2NvbW1hbmRfYXJnOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfUkVTUDA6wqAgwqAg
wqAvKiBSZXNwb25zZSBaZXJvICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9
IHMtJmd0O3Jlc3BvbnNlWzBdOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfUkVTUDE6wqAgwqAgwqAvKiBSZXNw
b25zZSBPbmUgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7cmVz
cG9uc2VbMV07PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9SRVNQMjrCoCDCoCDCoC8qIFJlc3BvbnNlIFR3byAq
Lzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtyZXNwb25zZVsyXTs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIGNhc2UgUkVHX1NEX1JFU1AzOsKgIMKgIMKgLyogUmVzcG9uc2UgVGhyZWUgKi88YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7cmVzcG9uc2VbM107PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNl
IFJFR19TRF9JTUtSOsKgIMKgIMKgIC8qIEludGVycnVwdCBNYXNrICovPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O2lycV9tYXNrOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfTUlT
UjrCoCDCoCDCoCAvKiBNYXNrZWQgSW50ZXJydXB0IFN0YXR1cyAqLzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtpcnFfc3RhdHVzICZhbXA7IHMtJmd0O2lycV9tYXNr
Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgY2FzZSBSRUdfU0RfUklTUjrCoCDCoCDCoCAvKiBSYXcgSW50ZXJydXB0IFN0YXR1cyAq
Lzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtpcnFfc3RhdHVzOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfU1RBUjrCoCDCoCDCoCAvKiBTdGF0dXMgKi88YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7c3RhdHVzOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfRldMUjrC
oCDCoCDCoCAvKiBGSUZPIFdhdGVyIExldmVsICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIHJlcyA9IHMtJmd0O2ZpZm9fd2xldmVsOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfRlVOUzrCoCDCoCDC
oCAvKiBGSUZPIEZ1bmN0aW9uIFNlbGVjdCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCByZXMgPSBzLSZndDtmaWZvX2Z1bmNfc2VsOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfREJHQzrCoCDCoCDC
oCAvKiBEZWJ1ZyBFbmFibGUgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0g
cy0mZ3Q7ZGVidWdfZW5hYmxlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfQTEyQTrCoCDCoCDCoCAvKiBBdXRv
IGNvbW1hbmQgMTIgYXJndW1lbnQgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVz
ID0gcy0mZ3Q7YXV0bzEyX2FyZzs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX05UU1I6wqAgwqAgwqAgLyogU0Qg
TmV3VGltaW5nIFNldCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZn
dDtuZXd0aW1pbmdfc2V0Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfU0RCRzrCoCDCoCDCoCAvKiBTRCBuZXdU
aW1pbmcgU2V0IERlYnVnICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMt
Jmd0O25ld3RpbWluZ19kZWJ1Zzs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0hXUlNUOsKgIMKgIMKgLyogSGFy
ZHdhcmUgUmVzZXQgUmVnaXN0ZXIgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVz
ID0gcy0mZ3Q7aGFyZHdhcmVfcnN0Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVh
azs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfRE1BQzrCoCDCoCDCoCAvKiBJ
bnRlcm5hbCBETUEgQ29udHJvbGxlciBDb250cm9sICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIHJlcyA9IHMtJmd0O2RtYWM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJy
ZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9ETEJBOsKgIMKgIMKgIC8q
IERlc2NyaXB0b3IgTGlzdCBCYXNlIEFkZHJlc3MgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgcmVzID0gcy0mZ3Q7ZGVzY19iYXNlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfSURTVDrCoCDCoCDC
oCAvKiBJbnRlcm5hbCBETUEgQ29udHJvbGxlciBTdGF0dXMgKi88YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7ZG1hY19zdGF0dXM7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9JRElF
OsKgIMKgIMKgIC8qIEludGVybmFsIERNQSBDb250cm9sbGVyIEludGVycnVwdDxicj4NCiZndDvC
oCDCoCDCoEVuYWJsZSAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZn
dDtkbWFjX2lycTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX1RITERDOsKgIMKgIMKgLyogQ2FyZCBUaHJlc2hv
bGQgQ29udHJvbCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtj
YXJkX3RocmVzaG9sZDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0RTQkQ6wqAgwqAgwqAgLyogZU1NQyBERFIg
U3RhcnQgQml0IERldGVjdGlvbiBDb250cm9sICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIHJlcyA9IHMtJmd0O3N0YXJ0Yml0X2RldGVjdDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX1JFU19DUkM6
wqAgwqAvKiBSZXNwb25zZSBDUkMgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7cmVzcG9uc2VfY3JjOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfREFU
QTdfQ1JDOiAvKiBDUkMgRGF0YSA3IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIGNhc2UgUkVHX1NEX0RBVEE2X0NSQzogLyogQ1JDIERhdGEgNiBmcm9tIGNhcmQvZU1N
QyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBNV9DUkM6IC8qIENS
QyBEYXRhIDUgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBS
RUdfU0RfREFUQTRfQ1JDOiAvKiBDUkMgRGF0YSA0IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0RBVEEzX0NSQzogLyogQ1JDIERhdGEgMyBmcm9t
IGNhcmQvZU1NQyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBMl9D
UkM6IC8qIENSQyBEYXRhIDIgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfREFUQTFfQ1JDOiAvKiBDUkMgRGF0YSAxIGZyb20gY2FyZC9lTU1DICov
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0RBVEEwX0NSQzogLyogQ1JDIERh
dGEgMCBmcm9tIGNhcmQvZU1NQyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMg
PSBzLSZndDtkYXRhX2NyY1soKG9mZnNldCAtIFJFR19TRF9EQVRBN19DUkMpIC88YnI+DQomZ3Q7
wqAgwqAgwqBzaXplb2YodWludDMyX3QpKV07PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9DUkNfU1RBOsKgIMKg
LyogQ1JDIHN0YXR1cyBmcm9tIGNhcmQvZU1NQyBpbiB3cml0ZTxicj4NCiZndDvCoCDCoCDCoG9w
ZXJhdGlvbiAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtzdGF0
dXNfY3JjOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfRklGTzrCoCDCoCDCoCAvKiBSZWFkL1dyaXRlIEZJRk8g
Ki88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgaWYgKHNkYnVzX2RhdGFfcmVhZHkoJmFt
cDtzLSZndDtzZGJ1cykpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgcmVz
ID0gc2RidXNfcmVhZF9kYXRhKCZhbXA7cy0mZ3Q7c2RidXMpOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCDCoCDCoCByZXMgfD0gc2RidXNfcmVhZF9kYXRhKCZhbXA7cy0mZ3Q7c2RidXMp
ICZsdDsmbHQ7IDg7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIHJlcyB8PSBz
ZGJ1c19yZWFkX2RhdGEoJmFtcDtzLSZndDtzZGJ1cykgJmx0OyZsdDsgMTY7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIHJlcyB8PSBzZGJ1c19yZWFkX2RhdGEoJmFtcDtzLSZn
dDtzZGJ1cykgJmx0OyZsdDsgMjQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKg
IGF3X2gzX3NkaG9zdF91cGRhdGVfdHJhbnNmZXJfY250KHMsIHNpemVvZih1aW50MzJfdCkpOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBhd19oM19zZGhvc3RfYXV0b19zdG9w
KHMpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBhd19oM19zZGhvc3RfdXBk
YXRlX2lycShzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJS
T1IsICZxdW90OyVzOiBubyBkYXRhIHJlYWR5IG9uIFNEPGJyPg0KJmd0O8KgIMKgIMKgYnVzXG4m
cXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIF9fZnVuY19fKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgfTxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgZGVm
YXVsdDo8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcWVtdV9sb2dfbWFzayhMT0dfR1VF
U1RfRVJST1IsICZxdW90OyVzOiBCYWQgb2Zmc2V0PGJyPg0KJmd0O8KgIMKgIMKgJSZxdW90O0hX
QUREUl9QUkl4JnF1b3Q7XG4mcXVvdDssPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIF9fZnVuY19fLCBvZmZzZXQpOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCByZXMgPSAwOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgdHJhY2VfYXdfaDNfc2Rob3N0X3JlYWQob2Zmc2V0LCByZXMsIHNpemUpOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCByZXR1cm4gcmVzOzxicj4NCiZndDvCoCDCoCDCoCt9PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBhd19oM19zZGhv
c3Rfd3JpdGUodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LDxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVpbnQ2NF90IHZh
bHVlLCB1bnNpZ25lZCBzaXplKTxicj4NCiZndDvCoCDCoCDCoCt7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIEF3SDNTREhvc3RTdGF0ZSAqcyA9IChBd0gzU0RIb3N0U3RhdGUgKilvcGFxdWU7PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB0cmFjZV9hd19oM19zZGhv
c3Rfd3JpdGUob2Zmc2V0LCB2YWx1ZSwgc2l6ZSk7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBzd2l0Y2ggKG9mZnNldCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCBjYXNlIFJFR19TRF9HQ1RMOsKgIMKgIMKgIC8qIEdsb2JhbCBDb250cm9sICovPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2dsb2JhbF9jdGwgPSB2YWx1ZTs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7Z2xvYmFsX2N0bCAmYW1wOz0gfihTRF9HQ1RMX0RN
QV9SU1QgfCBTRF9HQ1RMX0ZJRk9fUlNUIHw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBTRF9HQ1RMX1NPRlRfUlNUKTs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3VwZGF0ZV9pcnEocyk7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNl
IFJFR19TRF9DS0NSOsKgIMKgIMKgIC8qIENsb2NrIENvbnRyb2wgKi88YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgcy0mZ3Q7Y2xvY2tfY3RsID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9U
TU9SOsKgIMKgIMKgIC8qIFRpbWVvdXQgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
cy0mZ3Q7dGltZW91dCA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVh
azs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfQldEUjrCoCDCoCDCoCAvKiBC
dXMgV2lkdGggKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7YnVzX3dpZHRo
ID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9CS1NSOsKgIMKgIMKgIC8qIEJsb2NrIFNpemUgKi88
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7YmxvY2tfc2l6ZSA9IHZhbHVlOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfQllDUjrCoCDCoCDCoCAvKiBCeXRlIENvdW50ICovPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2J5dGVfY291bnQgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7dHJhbnNmZXJfY250ID0gdmFsdWU7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJF
R19TRF9DTURSOsKgIMKgIMKgIC8qIENvbW1hbmQgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgcy0mZ3Q7Y29tbWFuZCA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCBpZiAodmFsdWUgJmFtcDsgU0RfQ01EUl9MT0FEKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF9zZW5kX2NvbW1hbmQocyk7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF9kbWEocyk7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF9hdXRvX3N0b3Aocyk7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdf
aDNfc2Rob3N0X3VwZGF0ZV9pcnEocyk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJy
ZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9DQUdSOsKgIMKgIMKgIC8q
IENvbW1hbmQgQXJndW1lbnQgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7
Y29tbWFuZF9hcmcgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX1JFU1AwOsKgIMKgIMKgLyogUmVz
cG9uc2UgWmVybyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtyZXNwb25z
ZVswXSA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfUkVTUDE6wqAgwqAgwqAvKiBSZXNwb25zZSBP
bmUgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7cmVzcG9uc2VbMV0gPSB2
YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIGNhc2UgUkVHX1NEX1JFU1AyOsKgIMKgIMKgLyogUmVzcG9uc2UgVHdvICovPGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O3Jlc3BvbnNlWzJdID0gdmFsdWU7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCBjYXNlIFJFR19TRF9SRVNQMzrCoCDCoCDCoC8qIFJlc3BvbnNlIFRocmVlICovPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O3Jlc3BvbnNlWzNdID0gdmFsdWU7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNl
IFJFR19TRF9JTUtSOsKgIMKgIMKgIC8qIEludGVycnVwdCBNYXNrICovPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIHMtJmd0O2lycV9tYXNrID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF91cGRhdGVfaXJxKHMpOzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0Rf
TUlTUjrCoCDCoCDCoCAvKiBNYXNrZWQgSW50ZXJydXB0IFN0YXR1cyAqLzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBjYXNlIFJFR19TRF9SSVNSOsKgIMKgIMKgIC8qIFJhdyBJbnRlcnJ1cHQgU3Rh
dHVzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2lycV9zdGF0dXMgJmFt
cDs9IH52YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3Vw
ZGF0ZV9pcnEocyk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9TVEFSOsKgIMKgIMKgIC8qIFN0YXR1cyAqLzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtzdGF0dXMgJmFtcDs9IH52YWx1ZTs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3VwZGF0ZV9pcnEocyk7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCBjYXNlIFJFR19TRF9GV0xSOsKgIMKgIMKgIC8qIEZJRk8gV2F0ZXIgTGV2ZWwgKi88YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7Zmlmb193bGV2ZWwgPSB2YWx1ZTs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IGNhc2UgUkVHX1NEX0ZVTlM6wqAgwqAgwqAgLyogRklGTyBGdW5jdGlvbiBTZWxlY3QgKi88YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7Zmlmb19mdW5jX3NlbCA9IHZhbHVlOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfREJHQzrCoCDCoCDCoCAvKiBEZWJ1ZyBFbmFibGUgKi88YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7ZGVidWdfZW5hYmxlID0gdmFsdWU7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNl
IFJFR19TRF9BMTJBOsKgIMKgIMKgIC8qIEF1dG8gY29tbWFuZCAxMiBhcmd1bWVudCAqLzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDthdXRvMTJfYXJnID0gdmFsdWU7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBj
YXNlIFJFR19TRF9OVFNSOsKgIMKgIMKgIC8qIFNEIE5ld1RpbWluZyBTZXQgKi88YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7bmV3dGltaW5nX3NldCA9IHZhbHVlOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2Fz
ZSBSRUdfU0RfU0RCRzrCoCDCoCDCoCAvKiBTRCBuZXdUaW1pbmcgU2V0IERlYnVnICovPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O25ld3RpbWluZ19kZWJ1ZyA9IHZhbHVlOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfSFdSU1Q6wqAgwqAgwqAvKiBIYXJkd2FyZSBSZXNldCBSZWdpc3RlciAq
Lzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtoYXJkd2FyZV9yc3QgPSB2YWx1
ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIGNhc2UgUkVHX1NEX0RNQUM6wqAgwqAgwqAgLyogSW50ZXJuYWwgRE1BIENvbnRyb2xs
ZXIgQ29udHJvbCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtkbWFjID0g
dmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF91cGRhdGVf
aXJxKHMpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfRExCQTrCoCDCoCDCoCAvKiBEZXNjcmlwdG9yIExpc3Qg
QmFzZSBBZGRyZXNzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2Rlc2Nf
YmFzZSA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfSURTVDrCoCDCoCDCoCAvKiBJbnRlcm5hbCBE
TUEgQ29udHJvbGxlciBTdGF0dXMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0m
Z3Q7ZG1hY19zdGF0dXMgJmFtcDs9ICh+U0RfSURTVF9XUl9NQVNLKSB8ICh+dmFsdWUgJmFtcDs8
YnI+DQomZ3Q7wqAgwqAgwqBTRF9JRFNUX1dSX01BU0spOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBhd19oM19zZGhvc3RfdXBkYXRlX2lycShzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0lESUU6
wqAgwqAgwqAgLyogSW50ZXJuYWwgRE1BIENvbnRyb2xsZXIgSW50ZXJydXB0PGJyPg0KJmd0O8Kg
IMKgIMKgRW5hYmxlICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2RtYWNf
aXJxID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF91
cGRhdGVfaXJxKHMpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfVEhMREM6wqAgwqAgwqAvKiBDYXJkIFRocmVz
aG9sZCBDb250cm9sICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2NhcmRf
dGhyZXNob2xkID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EU0JEOsKgIMKgIMKgIC8qIGVNTUMg
RERSIFN0YXJ0IEJpdCBEZXRlY3Rpb24gQ29udHJvbCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBzLSZndDtzdGFydGJpdF9kZXRlY3QgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0ZJ
Rk86wqAgwqAgwqAgLyogUmVhZC9Xcml0ZSBGSUZPICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIHNkYnVzX3dyaXRlX2RhdGEoJmFtcDtzLSZndDtzZGJ1cywgdmFsdWUgJmFtcDsgMHhm
Zik7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHNkYnVzX3dyaXRlX2RhdGEoJmFtcDtz
LSZndDtzZGJ1cywgKHZhbHVlICZndDsmZ3Q7IDgpICZhbXA7IDB4ZmYpOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCBzZGJ1c193cml0ZV9kYXRhKCZhbXA7cy0mZ3Q7c2RidXMsICh2YWx1
ZSAmZ3Q7Jmd0OyAxNikgJmFtcDsgMHhmZik7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IHNkYnVzX3dyaXRlX2RhdGEoJmFtcDtzLSZndDtzZGJ1cywgKHZhbHVlICZndDsmZ3Q7IDI0KSAm
YW1wOyAweGZmKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3Vw
ZGF0ZV90cmFuc2Zlcl9jbnQocywgc2l6ZW9mKHVpbnQzMl90KSk7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF9hdXRvX3N0b3Aocyk7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF91cGRhdGVfaXJxKHMpOzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0Rf
UkVTX0NSQzrCoCDCoC8qIFJlc3BvbnNlIENSQyBmcm9tIGNhcmQvZU1NQyAqLzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBN19DUkM6IC8qIENSQyBEYXRhIDcgZnJvbSBj
YXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfREFUQTZfQ1JD
OiAvKiBDUkMgRGF0YSA2IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IGNhc2UgUkVHX1NEX0RBVEE1X0NSQzogLyogQ1JDIERhdGEgNSBmcm9tIGNhcmQvZU1NQyAqLzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBNF9DUkM6IC8qIENSQyBEYXRh
IDQgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0Rf
REFUQTNfQ1JDOiAvKiBDUkMgRGF0YSAzIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIGNhc2UgUkVHX1NEX0RBVEEyX0NSQzogLyogQ1JDIERhdGEgMiBmcm9tIGNhcmQv
ZU1NQyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBMV9DUkM6IC8q
IENSQyBEYXRhIDEgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2Fz
ZSBSRUdfU0RfREFUQTBfQ1JDOiAvKiBDUkMgRGF0YSAwIGZyb20gY2FyZC9lTU1DICovPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0NSQ19TVEE6wqAgwqAvKiBDUkMgc3RhdHVz
IGZyb20gY2FyZC9lTU1DIGluIHdyaXRlPGJyPg0KJmd0O8KgIMKgIMKgb3BlcmF0aW9uICovPGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCBkZWZhdWx0Ojxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBxZW11X2xvZ19tYXNrKExP
R19HVUVTVF9FUlJPUiwgJnF1b3Q7JXM6IEJhZCBvZmZzZXQ8YnI+DQomZ3Q7wqAgwqAgwqAlJnF1
b3Q7SFdBRERSX1BSSXgmcXVvdDtcbiZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19mdW5jX18sIG9mZnNldCk7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0
O8KgIMKgIMKgK308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3N0YXRpYyBj
b25zdCBNZW1vcnlSZWdpb25PcHMgYXdfaDNfc2Rob3N0X29wcyA9IHs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgLnJlYWQgPSBhd19oM19zZGhvc3RfcmVhZCw8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgLndyaXRlID0gYXdfaDNfc2Rob3N0X3dyaXRlLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAu
ZW5kaWFubmVzcyA9IERFVklDRV9OQVRJVkVfRU5ESUFOLDxicj4NCjxicj4NCkkgaGF2ZW4mIzM5
O3QgY2hlY2tlZCAudmFsaWQgYWNjZXNzZXMgZnJvbSB0aGUgZGF0YXNoZWV0Ljxicj4NCjxicj4N
Ckhvd2V2ZXIgZHVlIHRvOjxicj4NCjxicj4NCsKgIMKgcmVzID0gcy0mZ3Q7ZGF0YV9jcmNbKChv
ZmZzZXQgLSBSRUdfU0RfREFUQTdfQ1JDKSAvIHNpemVvZih1aW50MzJfdCkpXTs8YnI+DQo8YnI+
DQpZb3Ugc2VlbSB0byBleHBlY3Q6PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgLmltcGwu
bWluX2FjY2Vzc19zaXplID0gNCw8YnI+DQo8YnI+DQouaW1wbC5tYXhfYWNjZXNzX3NpemUgdW5z
ZXQgaXMgOCwgd2hpY2ggc2hvdWxkIHdvcmtzLjxicj4NCjxicj4NCiZndDvCoCDCoCDCoCt9Ozxi
cj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArc3RhdGljIGNvbnN0IFZNU3RhdGVE
ZXNjcmlwdGlvbiB2bXN0YXRlX2F3X2gzX3NkaG9zdCA9IHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgLm5hbWUgPSBUWVBFX0FXX0gzX1NESE9TVCw8YnI+DQo8YnI+DQpEbyBub3QgdXNlIFRZUEUg
bmFtZSBpbiBWTVN0YXRlRGVzY3JpcHRpb24ubmFtZSwgYmVjYXVzZSB3ZSBtaWdodCBjaGFuZ2Ug
PGJyPg0KdGhlIHZhbHVlIG9mIFRZUEUsIGJ1dCB0aGUgbWlncmF0aW9uIHN0YXRlIGhhcyB0byBr
ZWVwIHRoZSBzYW1lIG5hbWUuPGJyPg0KPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC52ZXJzaW9u
X2lkID0gMSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDEs
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC5maWVsZHMgPSAoVk1TdGF0ZUZpZWxkW10pIHs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzIoZ2xvYmFsX2N0bCwgQXdI
M1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5U
MzIoY2xvY2tfY3RsLCBBd0gzU0RIb3N0U3RhdGUpLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCBWTVNUQVRFX1VJTlQzMih0aW1lb3V0LCBBd0gzU0RIb3N0U3RhdGUpLDxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihidXNfd2lkdGgsIEF3SDNTREhvc3RT
dGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGJsb2Nr
X3NpemUsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZN
U1RBVEVfVUlOVDMyKGJ5dGVfY291bnQsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKHRyYW5zZmVyX2NudCwgQXdIM1NESG9zdFN0
YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzIoY29tbWFu
ZCwgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFU
RV9VSU5UMzIoY29tbWFuZF9hcmcsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKHJlc3BvbnNlLCBBd0gzU0RIb3N0U3Rh
dGUsIDQpLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihpcnFf
bWFzaywgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1T
VEFURV9VSU5UMzIoaXJxX3N0YXR1cywgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzIoc3RhdHVzLCBBd0gzU0RIb3N0U3RhdGUpLDxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihmaWZvX3dsZXZlbCwg
QXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9V
SU5UMzIoZmlmb19mdW5jX3NlbCwgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzIoZGVidWdfZW5hYmxlLCBBd0gzU0RIb3N0U3RhdGUp
LDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihhdXRvMTJfYXJn
LCBBd0gzU0RIb3N0U3RhdGUpLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRF
X1VJTlQzMihuZXd0aW1pbmdfc2V0LCBBd0gzU0RIb3N0U3RhdGUpLDxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihuZXd0aW1pbmdfZGVidWcsIEF3SDNTREhvc3RT
dGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGhhcmR3
YXJlX3JzdCwgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
Vk1TVEFURV9VSU5UMzIoZG1hYywgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzIoZGVzY19iYXNlLCBBd0gzU0RIb3N0U3RhdGUpLDxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihkbWFjX3N0YXR1cywg
QXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9V
SU5UMzIoZG1hY19pcnEsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIFZNU1RBVEVfVUlOVDMyKGNhcmRfdGhyZXNob2xkLCBBd0gzU0RIb3N0U3RhdGUpLDxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihzdGFydGJpdF9kZXRl
Y3QsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RB
VEVfVUlOVDMyKHJlc3BvbnNlX2NyYywgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzJfQVJSQVkoZGF0YV9jcmMsIEF3SDNTREhvc3RT
dGF0ZSwgOCksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKHN0
YXR1c19jcmMsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IFZNU1RBVEVfRU5EX09GX0xJU1QoKTxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0
O8KgIMKgIMKgK307PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMg
dm9pZCBhd19oM19zZGhvc3RfaW5pdChPYmplY3QgKm9iaik8YnI+DQomZ3Q7wqAgwqAgwqArezxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBBd0gzU0RIb3N0U3RhdGUgKnMgPSBBV19IM19TREhPU1Qo
b2JqKTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHFidXNfY3Jl
YXRlX2lucGxhY2UoJmFtcDtzLSZndDtzZGJ1cywgc2l6ZW9mKHMtJmd0O3NkYnVzKSw8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgVFlQRV9BV19I
M19TREhPU1RfQlVTLCBERVZJQ0UocyksICZxdW90O3NkLWJ1cyZxdW90Oyk7PGJyPg0KJmd0O8Kg
IMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJmFt
cDtzLSZndDtpb21lbSwgb2JqLCAmYW1wO2F3X2gzX3NkaG9zdF9vcHMsIHMsPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFRZUEVfQVdfSDNf
U0RIT1NULDxicj4NCiZndDvCoCDCoCDCoEFXX0gzX1NESE9TVF9SRUdTX01FTV9TSVpFKTs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgc3lzYnVzX2luaXRfbW1pbyhTWVNfQlVTX0RFVklDRShzKSwg
JmFtcDtzLSZndDtpb21lbSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHN5c2J1c19pbml0X2ly
cShTWVNfQlVTX0RFVklDRShzKSwgJmFtcDtzLSZndDtpcnEpOzxicj4NCiZndDvCoCDCoCDCoCt9
PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBhd19oM19z
ZGhvc3RfcmVzZXQoRGV2aWNlU3RhdGUgKmRldik8YnI+DQomZ3Q7wqAgwqAgwqArezxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBBd0gzU0RIb3N0U3RhdGUgKnMgPSBBV19IM19TREhPU1QoZGV2KTs8
YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2dsb2JhbF9j
dGwgPSBSRUdfU0RfR0NUTF9SU1Q7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2Nsb2Nr
X2N0bCA9IFJFR19TRF9DS0NSX1JTVDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7dGlt
ZW91dCA9IFJFR19TRF9UTU9SX1JTVDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7YnVz
X3dpZHRoID0gUkVHX1NEX0JXRFJfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDti
bG9ja19zaXplID0gUkVHX1NEX0JLU1JfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZn
dDtieXRlX2NvdW50ID0gUkVHX1NEX0JZQ1JfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBz
LSZndDt0cmFuc2Zlcl9jbnQgPSAwOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgcy0mZ3Q7Y29tbWFuZCA9IFJFR19TRF9DTURSX1JTVDs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgcy0mZ3Q7Y29tbWFuZF9hcmcgPSBSRUdfU0RfQ0FHUl9SU1Q7PGJyPg0KJmd0O8Kg
IMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBmb3IgKGludCBpID0gMDsgaSAmbHQ7IHNp
emVvZihzLSZndDtyZXNwb25zZSkgLzxicj4NCiZndDvCoCDCoCDCoHNpemVvZihzLSZndDtyZXNw
b25zZVswXSk7IGkrKykgezxicj4NCjxicj4NClBsZWFzZSB1c2UgQVJSQVlfU0laRShzLSZndDty
ZXNwb25zZSkuPGJyPg0KPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O3Jlc3Bv
bnNlW2ldID0gUkVHX1NEX1JFU1BfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0K
Jmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtpcnFfbWFzayA9IFJF
R19TRF9JTUtSX1JTVDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7aXJxX3N0YXR1cyA9
IFJFR19TRF9SSVNSX1JTVDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7c3RhdHVzID0g
UkVHX1NEX1NUQVJfUlNUOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgcy0mZ3Q7Zmlmb193bGV2ZWwgPSBSRUdfU0RfRldMUl9SU1Q7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIHMtJmd0O2ZpZm9fZnVuY19zZWwgPSBSRUdfU0RfRlVOU19SU1Q7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIHMtJmd0O2RlYnVnX2VuYWJsZSA9IFJFR19TRF9EQkdDX1JTVDs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7YXV0bzEyX2FyZyA9IFJFR19TRF9BMTJBX1JTVDs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7bmV3dGltaW5nX3NldCA9IFJFR19TRF9OVFNSX1JT
VDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7bmV3dGltaW5nX2RlYnVnID0gUkVHX1NE
X1NEQkdfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtoYXJkd2FyZV9yc3QgPSBS
RUdfU0RfSFdSU1RfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtkbWFjID0gUkVH
X1NEX0RNQUNfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtkZXNjX2Jhc2UgPSBS
RUdfU0RfRExCQV9SU1Q7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2RtYWNfc3RhdHVz
ID0gUkVHX1NEX0lEU1RfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtkbWFjX2ly
cSA9IFJFR19TRF9JRElFX1JTVDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7Y2FyZF90
aHJlc2hvbGQgPSBSRUdfU0RfVEhMRENfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZn
dDtzdGFydGJpdF9kZXRlY3QgPSBSRUdfU0RfRFNCRF9SU1Q7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIHMtJmd0O3Jlc3BvbnNlX2NyYyA9IFJFR19TRF9SRVNfQ1JDX1JTVDs8YnI+DQomZ3Q7wqAg
wqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGZvciAoaW50IGkgPSAwOyBpICZsdDsgc2l6
ZW9mKHMtJmd0O2RhdGFfY3JjKSAvPGJyPg0KJmd0O8KgIMKgIMKgc2l6ZW9mKHMtJmd0O2RhdGFf
Y3JjWzBdKTsgaSsrKSB7PGJyPg0KPGJyPg0KQVJSQVlfU0laRTxicj4NCjxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCBzLSZndDtkYXRhX2NyY1tpXSA9IFJFR19TRF9EQVRBX0NSQ19SU1Q7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIHMtJmd0O3N0YXR1c19jcmMgPSBSRUdfU0RfQ1JDX1NUQV9SU1Q7PGJyPg0K
Jmd0O8KgIMKgIMKgK308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3N0YXRp
YyB2b2lkIGF3X2gzX3NkaG9zdF9idXNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIHZv
aWQgKmRhdGEpPGJyPg0KJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgU0RC
dXNDbGFzcyAqc2JjID0gU0RfQlVTX0NMQVNTKGtsYXNzKTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIHNiYy0mZ3Q7c2V0X2luc2VydGVkID0gYXdfaDNfc2Rob3N0
X3NldF9pbnNlcnRlZDs8YnI+DQomZ3Q7wqAgwqAgwqArfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+
DQomZ3Q7wqAgwqAgwqArc3RhdGljIHZvaWQgYXdfaDNfc2Rob3N0X2NsYXNzX2luaXQoT2JqZWN0
Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKTxicj4NCiZndDvCoCDCoCDCoCt7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7PGJyPg0K
Jmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBkYy0mZ3Q7cmVzZXQgPSBhd19o
M19zZGhvc3RfcmVzZXQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGRjLSZndDt2bXNkID0gJmFt
cDt2bXN0YXRlX2F3X2gzX3NkaG9zdDs8YnI+DQomZ3Q7wqAgwqAgwqArfTxicj4NCiZndDvCoCDC
oCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArc3RhdGljIFR5cGVJbmZvIGF3X2gzX3NkaG9zdF9pbmZv
ID0gezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAubmFtZcKgIMKgIMKgIMKgIMKgID0gVFlQRV9B
V19IM19TREhPU1QsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC5wYXJlbnTCoCDCoCDCoCDCoCA9
IFRZUEVfU1lTX0JVU19ERVZJQ0UsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC5pbnN0YW5jZV9z
aXplID0gc2l6ZW9mKEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC5j
bGFzc19pbml0wqAgwqAgPSBhd19oM19zZGhvc3RfY2xhc3NfaW5pdCw8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgLmluc3RhbmNlX2luaXQgPSBhd19oM19zZGhvc3RfaW5pdCw8YnI+DQomZ3Q7wqAg
wqAgwqArfTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3N0YXRpYyBjb25z
dCBUeXBlSW5mbyBhd19oM19zZGhvc3RfYnVzX2luZm8gPSB7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIC5uYW1lID0gVFlQRV9BV19IM19TREhPU1RfQlVTLDxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCAucGFyZW50ID0gVFlQRV9TRF9CVVMsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC5pbnN0YW5j
ZV9zaXplID0gc2l6ZW9mKFNEQnVzKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLmNsYXNzX2lu
aXQgPSBhd19oM19zZGhvc3RfYnVzX2NsYXNzX2luaXQsPGJyPg0KJmd0O8KgIMKgIMKgK307PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBhd19oM19zZGhv
c3RfcmVnaXN0ZXJfdHlwZXModm9pZCk8YnI+DQomZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCB0eXBlX3JlZ2lzdGVyX3N0YXRpYygmYW1wO2F3X2gzX3NkaG9zdF9pbmZvKTs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmFtcDthd19oM19z
ZGhvc3RfYnVzX2luZm8pOzxicj4NCiZndDvCoCDCoCDCoCt9PGJyPg0KJmd0O8KgIMKgIMKgKzxi
cj4NCiZndDvCoCDCoCDCoCt0eXBlX2luaXQoYXdfaDNfc2Rob3N0X3JlZ2lzdGVyX3R5cGVzKTxi
cj4NCiZndDvCoCDCoCDCoGRpZmYgLS1naXQgYS9ody9zZC90cmFjZS1ldmVudHMgYi9ody9zZC90
cmFjZS1ldmVudHM8YnI+DQomZ3Q7wqAgwqAgwqBpbmRleCBlZmNmZjY2NmEyLi5jNjcyYTIwMWI1
IDEwMDY0NDxicj4NCiZndDvCoCDCoCDCoC0tLSBhL2h3L3NkL3RyYWNlLWV2ZW50czxicj4NCiZn
dDvCoCDCoCDCoCsrKyBiL2h3L3NkL3RyYWNlLWV2ZW50czxicj4NCiZndDvCoCDCoCDCoEBAIC0x
LDUgKzEsMTIgQEA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAjIFNlZSBkb2NzL2RldmVsL3RyYWNpbmcu
dHh0IGZvciBzeW50YXggZG9jdW1lbnRhdGlvbi48YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDC
oCsjIGFsbHdpbm5lci1oMy1zZGhvc3QuYzxicj4NCiZndDvCoCDCoCDCoCthd19oM19zZGhvc3Rf
c2V0X2luc2VydGVkKGJvb2wgaW5zZXJ0ZWQpICZxdW90O2luc2VydGVkICV1JnF1b3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgK2F3X2gzX3NkaG9zdF9wcm9jZXNzX2Rlc2ModWludDY0X3QgZGVzY19hZGRy
LCB1aW50MzJfdCBkZXNjX3NpemUsPGJyPg0KJmd0O8KgIMKgIMKgYm9vbCBpc193cml0ZSwgdWlu
dDMyX3QgbWF4X2J5dGVzKSAmcXVvdDtkZXNjX2FkZHIgMHglJnF1b3Q7IFBSSXg2NCAmcXVvdDs8
YnI+DQomZ3Q7wqAgwqAgwqBkZXNjX3NpemUgJXUgaXNfd3JpdGUgJXUgbWF4X2J5dGVzICV1JnF1
b3Q7PGJyPg0KPGJyPg0KUGxlYXNlIGFsc28gdXNlIFBSSXUzMiBmb3IgZGVzY19zaXplL21heF9i
eXRlcy48YnI+DQo8YnI+DQomZ3Q7wqAgwqAgwqArYXdfaDNfc2Rob3N0X3JlYWQodWludDY0X3Qg
b2Zmc2V0LCB1aW50NjRfdCBkYXRhLCB1bnNpZ25lZCBzaXplKTxicj4NCiZndDvCoCDCoCDCoCZx
dW90O29mZnNldCAweCUmcXVvdDsgUFJJeDY0ICZxdW90OyBkYXRhIDB4JSZxdW90OyBQUkl4NjQg
JnF1b3Q7IHNpemUgJXUmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqArYXdfaDNfc2Rob3N0X3dyaXRl
KHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3QgZGF0YSwgdW5zaWduZWQgc2l6ZSk8YnI+DQomZ3Q7
wqAgwqAgwqAmcXVvdDtvZmZzZXQgMHglJnF1b3Q7IFBSSXg2NCAmcXVvdDsgZGF0YSAweCUmcXVv
dDsgUFJJeDY0ICZxdW90OyBzaXplICV1JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgK2F3X2gzX3Nk
aG9zdF91cGRhdGVfaXJxKHVpbnQzMl90IGlycSkgJnF1b3Q7SVJRIGJpdHMgMHgleCZxdW90Ozxi
cj4NCjxicj4NClBSSXgzMjxicj4NCjxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAjIGJjbTI4MzVfc2Rob3N0LmM8YnI+DQomZ3Q7wqAgwqAgwqAgwqBiY20yODM1X3NkaG9z
dF9yZWFkKHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3QgZGF0YSwgdW5zaWduZWQgc2l6ZSk8YnI+
DQomZ3Q7wqAgwqAgwqAmcXVvdDtvZmZzZXQgMHglJnF1b3Q7IFBSSXg2NCAmcXVvdDsgZGF0YSAw
eCUmcXVvdDsgUFJJeDY0ICZxdW90OyBzaXplICV1JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKg
YmNtMjgzNV9zZGhvc3Rfd3JpdGUodWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBkYXRhLCB1bnNp
Z25lZDxicj4NCiZndDvCoCDCoCDCoHNpemUpICZxdW90O29mZnNldCAweCUmcXVvdDsgUFJJeDY0
ICZxdW90OyBkYXRhIDB4JSZxdW90OyBQUkl4NjQgJnF1b3Q7IHNpemUgJXUmcXVvdDs8YnI+DQom
Z3Q7wqAgwqAgwqBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9hcm0vYWxsd2lubmVyLWgzLmg8YnI+
DQomZ3Q7wqAgwqAgwqBiL2luY2x1ZGUvaHcvYXJtL2FsbHdpbm5lci1oMy5oPGJyPg0KJmd0O8Kg
IMKgIMKgaW5kZXggMzM2MDI1OTllYi4uN2FmZjRlYmJkMiAxMDA2NDQ8YnI+DQomZ3Q7wqAgwqAg
wqAtLS0gYS9pbmNsdWRlL2h3L2FybS9hbGx3aW5uZXItaDMuaDxicj4NCiZndDvCoCDCoCDCoCsr
KyBiL2luY2x1ZGUvaHcvYXJtL2FsbHdpbm5lci1oMy5oPGJyPg0KJmd0O8KgIMKgIMKgQEAgLTMw
LDYgKzMwLDcgQEA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAjaW5jbHVkZSAmcXVvdDtody9taXNjL2Fs
bHdpbm5lci1oMy1jcHVjZmcuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCDCoCNpbmNsdWRlICZx
dW90O2h3L21pc2MvYWxsd2lubmVyLWgzLXN5c2Nvbi5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKg
IMKgI2luY2x1ZGUgJnF1b3Q7aHcvbWlzYy9hbGx3aW5uZXItaDMtc2lkLmgmcXVvdDs8YnI+DQom
Z3Q7wqAgwqAgwqArI2luY2x1ZGUgJnF1b3Q7aHcvc2QvYWxsd2lubmVyLWgzLXNkaG9zdC5oJnF1
b3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgI2luY2x1ZGUgJnF1b3Q7dGFyZ2V0L2FybS9jcHUuaCZx
dW90Ozxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgI2RlZmluZSBBV19IM19TUkFNX0Ex
X0JBU0XCoCDCoCDCoCgweDAwMDAwMDAwKTxicj4NCiZndDvCoCDCoCDCoEBAIC0xMTcsNiArMTE4
LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgQXdIM1N0YXRlIHs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAg
wqBBd0gzQ3B1Q2ZnU3RhdGUgY3B1Y2ZnOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoEF3SDNT
eXNjb25TdGF0ZSBzeXNjb247PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgQXdIM1NpZFN0YXRl
IHNpZDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgQXdIM1NESG9zdFN0YXRlIG1tYzA7PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgR0lDU3RhdGUgZ2ljOzxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oCDCoE1lbW9yeVJlZ2lvbiBzcmFtX2ExOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoE1lbW9y
eVJlZ2lvbiBzcmFtX2EyOzxicj4NCiZndDvCoCDCoCDCoGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3
L3NkL2FsbHdpbm5lci1oMy1zZGhvc3QuaDxicj4NCiZndDvCoCDCoCDCoGIvaW5jbHVkZS9ody9z
ZC9hbGx3aW5uZXItaDMtc2Rob3N0Lmg8YnI+DQomZ3Q7wqAgwqAgwqBuZXcgZmlsZSBtb2RlIDEw
MDY0NDxicj4NCiZndDvCoCDCoCDCoGluZGV4IDAwMDAwMDAwMDAuLjZjODk4YTNjODQ8YnI+DQom
Z3Q7wqAgwqAgwqAtLS0gL2Rldi9udWxsPGJyPg0KJmd0O8KgIMKgIMKgKysrIGIvaW5jbHVkZS9o
dy9zZC9hbGx3aW5uZXItaDMtc2Rob3N0Lmg8YnI+DQomZ3Q7wqAgwqAgwqBAQCAtMCwwICsxLDcz
IEBAPGJyPg0KJmd0O8KgIMKgIMKgKy8qPGJyPg0KJmd0O8KgIMKgIMKgKyAqIEFsbHdpbm5lciBI
MyBTRCBIb3N0IENvbnRyb2xsZXIgZW11bGF0aW9uPGJyPg0KJmd0O8KgIMKgIMKgKyAqPGJyPg0K
Jmd0O8KgIMKgIMKgKyAqIENvcHlyaWdodCAoQykgMjAxOSBOaWVrIExpbm5lbmJhbmsgJmx0Ozxh
IGhyZWY9Im1haWx0bzpuaWVrbGlubmVuYmFua0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5u
aWVrbGlubmVuYmFua0BnbWFpbC5jb208L2E+PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8
YSBocmVmPSJtYWlsdG86bmlla2xpbm5lbmJhbmtAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
bmlla2xpbm5lbmJhbmtAZ21haWwuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyAq
PGJyPg0KJmd0O8KgIMKgIMKgKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOiB5b3Ug
Y2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5PGJyPg0KJmd0O8KgIMKgIMKgKyAqIGl0
IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVi
bGlzaGVkIGJ5PGJyPg0KJmd0O8KgIMKgIMKgKyAqIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24sIGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yPGJyPg0KJmd0O8KgIMKgIMKg
KyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uPGJyPg0KJmd0O8KgIMKgIMKg
KyAqPGJyPg0KJmd0O8KgIMKgIMKgKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0
aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLDxicj4NCiZndDvCoCDCoCDCoCsgKiBidXQg
V0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
Zjxicj4NCiZndDvCoCDCoCDCoCsgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuwqAgU2VlIHRoZTxicj4NCiZndDvCoCDCoCDCoCsgKiBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLjxicj4NCiZndDvCoCDCoCDCoCsg
Kjxicj4NCiZndDvCoCDCoCDCoCsgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZTxicj4NCiZndDvCoCDCoCDCoCsgKiBhbG9u
ZyB3aXRoIHRoaXMgcHJvZ3JhbS7CoCBJZiBub3QsIHNlZTxicj4NCiZndDvCoCDCoCDCoCZsdDs8
YSBocmVmPSJodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvIiByZWw9Im5vcmVmZXJyZXIiIHRh
cmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPC9hPiZndDsuPGJyPg0K
Jmd0O8KgIMKgIMKgKyAqLzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArI2lm
bmRlZiBBTExXSU5ORVJfSDNfU0RIT1NUX0g8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBBTExX
SU5ORVJfSDNfU0RIT1NUX0g8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKyNp
bmNsdWRlICZxdW90O2h3L3N5c2J1cy5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNpbmNsdWRl
ICZxdW90O2h3L3NkL3NkLmgmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKg
IMKgKyNkZWZpbmUgQVdfSDNfU0RIT1NUX1JFR1NfTUVNX1NJWkXCoCAoMTAyNCk8YnI+DQo8YnI+
DQpNb3ZlIHRoaXMgZGVmaW5pdGlvbiB0byB0aGUgc291cmNlIGZpbGUuPGJyPg0KPGJyPg0KJmd0
O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFRZUEVfQVdfSDNfU0RIT1NUICZx
dW90O2FsbHdpbm5lci1oMy1zZGhvc3QmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBB
V19IM19TREhPU1Qob2JqKSBcPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIE9CSkVDVF9D
SEVDSyhBd0gzU0RIb3N0U3RhdGUsIChvYmopLCBUWVBFX0FXX0gzX1NESE9TVCk8YnI+DQomZ3Q7
wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3R5cGVkZWYgc3RydWN0IHs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgU3lzQnVzRGV2aWNlIGJ1c2Rldjs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
U0RCdXMgc2RidXM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIE1lbW9yeVJlZ2lvbiBpb21lbTs8
YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGdsb2Jh
bF9jdGw7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGNsb2NrX2N0bDs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgdGltZW91dDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgdWludDMyX3QgYnVzX3dpZHRoOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBi
bG9ja19zaXplOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBieXRlX2NvdW50Ozxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCB0cmFuc2Zlcl9jbnQ7PGJyPg0KJmd0O8Kg
IMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBjb21tYW5kOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBjb21tYW5kX2FyZzs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgdWludDMyX3QgcmVzcG9uc2VbNF07PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCB1aW50MzJfdCBpcnFfbWFzazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
dWludDMyX3QgaXJxX3N0YXR1czs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3Qgc3Rh
dHVzOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3Qg
Zmlmb193bGV2ZWw7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGZpZm9fZnVuY19z
ZWw7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGRlYnVnX2VuYWJsZTs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgYXV0bzEyX2FyZzs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgdWludDMyX3QgbmV3dGltaW5nX3NldDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWlu
dDMyX3QgbmV3dGltaW5nX2RlYnVnOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBo
YXJkd2FyZV9yc3Q7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGRtYWM7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGRlc2NfYmFzZTs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgdWludDMyX3QgZG1hY19zdGF0dXM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQz
Ml90IGRtYWNfaXJxOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBjYXJkX3RocmVz
aG9sZDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3Qgc3RhcnRiaXRfZGV0ZWN0Ozxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCByZXNwb25zZV9jcmM7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIHVpbnQzMl90IGRhdGFfY3JjWzhdOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCB1aW50MzJfdCBzdGF0dXNfY3JjOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgcWVtdV9pcnEgaXJxOzxicj4NCiZndDvCoCDCoCDCoCt9IEF3SDNTREhvc3RTdGF0
ZTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKyNlbmRpZjxicj4NCiZndDvC
oCDCoCDCoC0tIDxicj4NCiZndDvCoCDCoCDCoDIuMTcuMTxicj4NCjxicj4NCkkgaGF2ZW4mIzM5
O3QgY2hlY2tlZCB0aGUgZGF0YXNoZWV0IGZvciBhbGwgdGhlIHJlZ2lzdGVycy9iaXRzLjxicj48
L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MgYWdhaW4gZm9yIGFsbCBvZiB5
b3VyIGhlbHBmdWwgY29tbWVudHMgUGhpbGlwcGUhPC9kaXY+PGRpdj5JJiMzOTt2ZSBzdGFydGVk
IHRvIHJld29yayB0aGUgcGF0Y2guPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5PbmUgcXVlc3Rp
b24gYWJvdXQgYWRkaW5nIHRhZ3MgaW4gdGhlIGNvbW1pdCBtZXNzYWdlOiBzaG91bGQgSTwvZGl2
PjxkaXY+YWxyZWFkeSBhZGQgJiMzOTtSZXZpZXdlZC1ieTogJiMzOTsgd2hlbiBJIHJlLXNlbmQg
djIgb2YgdGhpcyBwYXRjaD8gT3Igc2hvdWxkPC9kaXY+PGRpdj50aGF0IGJlIGFkZGVkIGFmdGVy
IHlvdSBoYXZlIHNlZW4gdGhlIHYyIGNoYW5nZXM/PGJyPjwvZGl2PjxkaXY+wqA8L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+DQo8YnI+DQpQYXRjaCB2ZXJ5IGNsZWFuLCBjaGFwZWF1ITxicj48L2Jsb2NrcXVvdGU+PGRp
dj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3UgOi0pPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5S
ZWdhcmRzLDwvZGl2PjxkaXY+Tmllazxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNv
bGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+DQo8YnI+DQpSZWdhcmRzLDxi
cj4NCjxicj4NClBoaWwuPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGVhcj0i
YWxsIj48YnI+LS0gPGJyPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPjxk
aXYgZGlyPSJsdHIiPjxkaXY+TmllayBMaW5uZW5iYW5rPGJyPjxicj48L2Rpdj48L2Rpdj48L2Rp
dj48L2Rpdj4NCg==
--00000000000048b6cc05999c2987--

