Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42562C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 23:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F4A20726
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 23:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4P3TrEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F4A20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igd0K-0008S5-Uv
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 18:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igcyz-0007VI-G2
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 18:07:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igcyp-00049s-LO
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 18:07:25 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:35326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igcyp-00046p-7e; Sun, 15 Dec 2019 18:07:15 -0500
Received: by mail-io1-xd29.google.com with SMTP id v18so3992361iol.2;
 Sun, 15 Dec 2019 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c8dJjvJGo5ZVUxZwxpbG0omE8CCz6DgfoJ0maa0PpO4=;
 b=G4P3TrEloWyX/3WsK14FdV+iOXSSXx9UTSeU7oovFfuxbh1BszwkQ0jjtb44aczx4N
 dt7qjxlEpVJTflQECJ7zsQJVEbOKfT504VmWrOiftFfSrdUmoJANGbT8sfeS4ka5JZra
 ngwz9m2hDTpzwOtwKvMrRL5dDlwnCCC6JOLiK0dPj+QK4Edv06K885r3GoUz3clVoI7N
 7EtiuDdcizT0AKhCzvzyOGebgsAWE3WimPYmsUP2XsapZ0eFwothqxvebIfcfidulwf0
 62dx0dCoUKlRro8cEY52yKQx6SBDSCrPHXFMdpvad46sbSyDzijpAfd91sqrFxZySzEK
 L0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c8dJjvJGo5ZVUxZwxpbG0omE8CCz6DgfoJ0maa0PpO4=;
 b=NTeidGHNUD1FnimmG4LACPypy+OWk+dQ1cSO+t39YKb3O2HwTYQ7rqc2KA8FDKHEgM
 jjrgO54zt9EUx9AvL0yM6rQuXiVpqHsjmnXvNItBm/eSXzg+eDHynfbv/vQX1GBzLqHV
 rmeOLMsFsy+rPpePeCrxu3P7WgGZjIgi0VsY5QvufnOCymgxv9Hb5pPh5xRX/Gb0P+B4
 XY1b6pv1Dl6eDANQXsqUH6m7oiznXbpo+PiAbGJN14DB/dOF86yWUoiHa8tfOepov1+B
 yadrvtVNPq5unf/NqT0bjh/RfANL98SVXwYN03PnWJtn3mr3ZQMlCa6exfl4y3a62ueZ
 PmQw==
X-Gm-Message-State: APjAAAXewUM7bvxz+ryxEU0zjVZjNeRWbq6ecruwOjVGkoTPSjWhoj2t
 YJyv/wzGBy05jkboanfcundgtkVb3AmAmdVnN7A=
X-Google-Smtp-Source: APXvYqw1j50FQ2Xpw4qhlG2QFuo38R3W8A4tM0NVe/n7PgSdTEZHdcmageDTLzqJ8ExZfCc0WgvoOr91Y5JBh9Prsk0=
X-Received: by 2002:a5d:8f17:: with SMTP id f23mr16417304iof.265.1576451233238; 
 Sun, 15 Dec 2019 15:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
 <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
 <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
In-Reply-To: <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 16 Dec 2019 00:07:01 +0100
Message-ID: <CAPan3WpiWahU85-ZgV4BMPU8mUTxsq2TPn-szOHkHc5+PHUqpw@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c3573e0599c627e0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d29
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

--000000000000c3573e0599c627e0
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

I tried to figure out what is expected, but the
Allwinner_H3_Datasheet_V1.2.pdf does not
explicitly mention endianness for any of its I/O devices. Currently it
seems all devices are
happy with using the same endianness as the CPUs. In the MemoryRegionOps
has DEVICE_NATIVE_ENDIAN
set to match the behavior seen.


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
> It seems that all registers are aligned on at least 32-bit boundaries. An=
d
the section 5.3.5.1 mentions
that the DMA descriptors must be stored in memory 32-bit aligned. So based
on that information,
I think 32-bit is a safe choice. I've verified this with Linux mainline and
U-Boot drivers and both are still working.


> >     +};
> >     +
> >     +static const VMStateDescription vmstate_aw_h3_sdhost =3D {
> >     +    .name =3D TYPE_AW_H3_SDHOST,
>
> Do not use TYPE name in VMStateDescription.name, because we might change
> the value of TYPE, but the migration state has to keep the same name.
>
> OK thanks, I will make that changes in the other commits as well.


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
> Done. I'll also use PRIu32 / PRIx32 in the other commits that have
trace-events changes.


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
> Patch very clean, chapeau!
>
> Regards,
>
> Phil.
>
>

--=20
Niek Linnenbank

--000000000000c3573e0599c627e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIg
Y2xhc3M9ImdtYWlsX2F0dHIiPk9uIEZyaSwgRGVjIDEzLCAyMDE5IGF0IDEyOjU2IEFNIFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20i
PnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBOaWVr
LDxicj4NCjxicj4NCk9uIDEyLzExLzE5IDExOjM0IFBNLCBOaWVrIExpbm5lbmJhbmsgd3JvdGU6
PGJyPg0KJmd0OyBQaW5nITxicj4NCiZndDsgPGJyPg0KJmd0OyBBbnlvbmUgd291bGQgbGlrZSB0
byBjb21tZW50IG9uIHRoaXMgZHJpdmVyPzxicj4NCiZndDsgPGJyPg0KJmd0OyBJIGZpbmlzaGVk
IHRoZSByZXdvcmsgb24gYWxsIHByZXZpb3VzIGNvbW1lbnRzIGluIHRoaXMgc2VyaWVzLjxicj4N
CiZndDsgPGJyPg0KJmd0OyBDdXJyZW50bHkgZGVidWdnaW5nIHRoZSBoZmxhZ3MgZXJyb3IgcmVw
b3J0ZWQgYnkgUGhpbGlwcGUuPGJyPg0KJmd0OyBBZnRlciB0aGF0LCBJJiMzOTttIHJlYWR5IHRv
IHNlbmQgb3V0IHYyIG9mIHRoZXNlIHBhdGNoZXMuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IFJlZ2Fy
ZHMsPGJyPg0KJmd0OyBOaWVrPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IE9uIE1vbiwgRGVjIDIsIDIw
MTkgYXQgMTA6MTAgUE0gTmllayBMaW5uZW5iYW5rIDxicj4NCiZndDsgJmx0OzxhIGhyZWY9Im1h
aWx0bzpuaWVrbGlubmVuYmFua0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5uaWVrbGlubmVu
YmFua0BnbWFpbC5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOm5pZWtsaW5uZW5i
YW5rQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm5pZWtsaW5uZW5iYW5rQGdtYWlsLmNvbTwv
YT4mZ3Q7Jmd0OyB3cm90ZTo8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoFRoZSBBbGx3aW5u
ZXIgSDMgU3lzdGVtIG9uIENoaXAgY29udGFpbnMgYW4gaW50ZWdyYXRlZCBzdG9yYWdlPGJyPg0K
Jmd0O8KgIMKgIMKgY29udHJvbGxlciBmb3IgU2VjdXJlIERpZ2l0YWwgKFNEKSBhbmQgTXVsdGkg
TWVkaWEgQ2FyZCAoTU1DKTxicj4NCiZndDvCoCDCoCDCoGludGVyZmFjZXMuIFRoaXMgY29tbWl0
IGFkZHMgc3VwcG9ydCBmb3IgdGhlIEFsbHdpbm5lciBIMzxicj4NCiZndDvCoCDCoCDCoFNEL01N
QyBzdG9yYWdlIGNvbnRyb2xsZXIgd2l0aCB0aGUgZm9sbG93aW5nIGVtdWxhdGVkIGZlYXR1cmVz
Ojxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgKiBETUEgdHJhbnNmZXJzPGJyPg0KJmd0
O8KgIMKgIMKgIMKgKiBEaXJlY3QgRklGTyBJL088YnI+DQomZ3Q7wqAgwqAgwqAgwqAqIFNob3J0
L0xvbmcgZm9ybWF0IGNvbW1hbmQgcmVzcG9uc2VzPGJyPg0KJmd0O8KgIMKgIMKgIMKgKiBBdXRv
LVN0b3AgY29tbWFuZCAoQ01EMTIpPGJyPg0KJmd0O8KgIMKgIMKgIMKgKiBJbnNlcnQgJmFtcDsg
cmVtb3ZlIGNhcmQgZGV0ZWN0aW9uPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBTaWduZWQt
b2ZmLWJ5OiBOaWVrIExpbm5lbmJhbmsgJmx0OzxhIGhyZWY9Im1haWx0bzpuaWVrbGlubmVuYmFu
a0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5uaWVrbGlubmVuYmFua0BnbWFpbC5jb208L2E+
PGJyPg0KJmd0O8KgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bmlla2xpbm5lbmJh
bmtAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bmlla2xpbm5lbmJhbmtAZ21haWwuY29tPC9h
PiZndDsmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgLS0tPGJyPg0KJmd0O8KgIMKgIMKgIMKgaHcvYXJt
L2FsbHdpbm5lci1oMy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMjAgKzxicj4NCiZndDvC
oCDCoCDCoCDCoGh3L2FybS9vcmFuZ2VwaS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8
wqAgMTcgKzxicj4NCiZndDvCoCDCoCDCoCDCoGh3L3NkL01ha2VmaWxlLm9ianPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoCDCoCDCoGh3L3NkL2FsbHdp
bm5lci1oMy1zZGhvc3QuY8KgIMKgIMKgIMKgIMKgfCA3OTEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKzxicj4NCiZndDvCoCDCoCDCoCDCoGh3L3NkL3RyYWNlLWV2ZW50c8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCDCoDcgKzxicj4NCiZndDvCoCDCoCDCoCDCoGluY2x1ZGUvaHcv
YXJtL2FsbHdpbm5lci1oMy5owqAgwqAgwqAgwqB8wqAgwqAyICs8YnI+DQomZ3Q7wqAgwqAgwqAg
wqBpbmNsdWRlL2h3L3NkL2FsbHdpbm5lci1oMy1zZGhvc3QuaCB8wqAgNzMgKysrPGJyPg0KJmd0
O8KgIMKgIMKgIMKgNyBmaWxlcyBjaGFuZ2VkLCA5MTEgaW5zZXJ0aW9ucygrKTxicj4NCiZndDvC
oCDCoCDCoCDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBody9zZC9hbGx3aW5uZXItaDMtc2Rob3N0LmM8
YnI+DQomZ3Q7wqAgwqAgwqAgwqBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9zZC9hbGx3
aW5uZXItaDMtc2Rob3N0Lmg8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoGRpZmYgLS1naXQg
YS9ody9hcm0vYWxsd2lubmVyLWgzLmMgYi9ody9hcm0vYWxsd2lubmVyLWgzLmM8YnI+DQomZ3Q7
wqAgwqAgwqBpbmRleCA0ZmM0YzhjNzI1Li5jMjk3MmNhZjg4IDEwMDY0NDxicj4NCiZndDvCoCDC
oCDCoC0tLSBhL2h3L2FybS9hbGx3aW5uZXItaDMuYzxicj4NCiZndDvCoCDCoCDCoCsrKyBiL2h3
L2FybS9hbGx3aW5uZXItaDMuYzxicj4NCiZndDvCoCDCoCDCoEBAIC01MCw2ICs1MCw5IEBAIHN0
YXRpYyB2b2lkIGF3X2gzX2luaXQoT2JqZWN0ICpvYmopPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAg
wqAgwqAgwqAgwqAgwqBzeXNidXNfaW5pdF9jaGlsZF9vYmoob2JqLCAmcXVvdDtzaWQmcXVvdDss
ICZhbXA7cy0mZ3Q7c2lkLCBzaXplb2Yocy0mZ3Q7c2lkKSw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBUWVBFX0FXX0gzX1NJRCk7PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzeXNidXNfaW5pdF9jaGls
ZF9vYmoob2JqLCAmcXVvdDttbWMwJnF1b3Q7LCAmYW1wO3MtJmd0O21tYzAsIHNpemVvZihzLSZn
dDttbWMwKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgVFlQRV9BV19IM19TREhPU1QpOzxicj4NCiZndDvCoCDCoCDCoCDCoH08YnI+DQom
Z3Q7IDxicj4NCiZndDvCoCDCoCDCoCDCoHN0YXRpYyB2b2lkIGF3X2gzX3JlYWxpemUoRGV2aWNl
U3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKTxicj4NCiZndDvCoCDCoCDCoEBAIC0yMTcsNiArMjIw
LDIzIEBAIHN0YXRpYyB2b2lkIGF3X2gzX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiw8YnI+DQom
Z3Q7wqAgwqAgwqBFcnJvciAqKmVycnApPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgfTxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoHN5c2J1c19tbWlvX21hcChTWVNfQlVTX0RFVklDRSgmYW1w
O3MtJmd0O3NpZCksIDAsIEFXX0gzX1NJRF9CQVNFKTs8YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCAvKiBTRC9NTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgb2JqZWN0X3By
b3BlcnR5X3NldF9ib29sKE9CSkVDVCgmYW1wO3MtJmd0O21tYzApLCB0cnVlLCAmcXVvdDtyZWFs
aXplZCZxdW90OywgJmFtcDtlcnIpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBpZiAoZXJyICE9
IE5VTEwpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgZXJyb3JfcHJvcGFnYXRlKGVy
cnAsIGVycik7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybjs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzeXNidXNkZXYgPSBTWVNf
QlVTX0RFVklDRSgmYW1wO3MtJmd0O21tYzApOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzeXNi
dXNfbW1pb19tYXAoc3lzYnVzZGV2LCAwLCBBV19IM19NTUMwX0JBU0UpOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBzeXNidXNfY29ubmVjdF9pcnEoc3lzYnVzZGV2LCAwLCBzLSZndDtpcnFbQVdf
SDNfR0lDX1NQSV9NTUMwXSk7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCBvYmplY3RfcHJvcGVydHlfYWRkX2FsaWFzKE9CSkVDVChzKSwgJnF1b3Q7c2QtYnVzJnF1
b3Q7LCBPQkpFQ1QoJmFtcDtzLSZndDttbWMwKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7c2QtYnVzJnF1b3Q7LCAm
YW1wO2Vycik7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGlmIChlcnIpIHs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIHJldHVybjs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4N
CiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAvKiBVbml2ZXJzYWwgU2Vy
aWFsIEJ1cyAqLzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoHN5c2J1c19jcmVhdGVfc2ltcGxl
KFRZUEVfQVdfSDNfRUhDSSwgQVdfSDNfRUhDSTBfQkFTRSw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcy0mZ3Q7aXJxW0FXX0gzX0dJQ19T
UElfRUhDSTBdKTs8YnI+DQomZ3Q7wqAgwqAgwqBkaWZmIC0tZ2l0IGEvaHcvYXJtL29yYW5nZXBp
LmMgYi9ody9hcm0vb3JhbmdlcGkuYzxicj4NCiZndDvCoCDCoCDCoGluZGV4IDVlZjI3MzVmODEu
LmRlZTNlZmFmMDggMTAwNjQ0PGJyPg0KJmd0O8KgIMKgIMKgLS0tIGEvaHcvYXJtL29yYW5nZXBp
LmM8YnI+DQomZ3Q7wqAgwqAgwqArKysgYi9ody9hcm0vb3JhbmdlcGkuYzxicj4NCiZndDvCoCDC
oCDCoEBAIC0zOSw2ICszOSwxMCBAQCB0eXBlZGVmIHN0cnVjdCBPcmFuZ2VQaVN0YXRlIHs8YnI+
DQomZ3Q7wqAgwqAgwqAgwqBzdGF0aWMgdm9pZCBvcmFuZ2VwaV9pbml0KE1hY2hpbmVTdGF0ZSAq
bWFjaGluZSk8YnI+DQomZ3Q7wqAgwqAgwqAgwqB7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
T3JhbmdlUGlTdGF0ZSAqcyA9IGdfbmV3KE9yYW5nZVBpU3RhdGUsIDEpOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBEcml2ZUluZm8gKmRpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBCbG9ja0Jh
Y2tlbmQgKmJsazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgQnVzU3RhdGUgKmJ1czs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgRGV2aWNlU3RhdGUgKmNhcmRkZXY7PGJyPg0KJmd0O8KgIMKgIMKg
IMKgIMKgIMKgRXJyb3IgKmVyciA9IE5VTEw7PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqBzLSZndDtoMyA9IEFXX0gzKG9iamVjdF9uZXcoVFlQRV9BV19IMykpOzxicj4NCiZn
dDvCoCDCoCDCoEBAIC02NCw2ICs2OCwxOCBAQCBzdGF0aWMgdm9pZCBvcmFuZ2VwaV9pbml0KE1h
Y2hpbmVTdGF0ZSAqbWFjaGluZSk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBleGl0
KDEpOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCAvKiBDcmVhdGUgYW5kIHBsdWcgaW4gdGhlIFNEIGNhcmQgKi88YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgZGkgPSBkcml2ZV9nZXRfbmV4dChJRl9TRCk7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIGJsayA9IGRpID8gYmxrX2J5X2xlZ2FjeV9kaW5mbyhkaSkgOiBOVUxMOzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCBidXMgPSBxZGV2X2dldF9jaGlsZF9idXMoREVWSUNFKHMtJmd0
O2gzKSwgJnF1b3Q7c2QtYnVzJnF1b3Q7KTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgaWYgKGJ1
cyA9PSBOVUxMKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGVycm9yX3JlcG9ydCgm
cXVvdDtObyBTRC9NTUMgZm91bmQgaW4gSDMgb2JqZWN0JnF1b3Q7KTs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgZXhpdCgxKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCjxi
cj4NCllvdXIgZGV2aWNlIGFsd2F5cyBjcmVhdGVzIGEgYnVzLCBzbyBJIGRvbiYjMzk7dCB0aGlu
ayB0aGUgaWYoYnVzKSBjaGVjayBpcyA8YnI+DQp3b3J0aHdoaWxlLiBFdmVudHVhbGx5IHVzZSBh
biBhc3NlcnQoYnVzKT88YnI+DQo8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FyZGRldiA9IHFk
ZXZfY3JlYXRlKGJ1cywgVFlQRV9TRF9DQVJEKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcWRl
dl9wcm9wX3NldF9kcml2ZShjYXJkZGV2LCAmcXVvdDtkcml2ZSZxdW90OywgYmxrLCAmYW1wO2Vy
cm9yX2ZhdGFsKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgb2JqZWN0X3Byb3BlcnR5X3NldF9i
b29sKE9CSkVDVChjYXJkZGV2KSwgdHJ1ZSwgJnF1b3Q7cmVhbGl6ZWQmcXVvdDssPGJyPg0KJmd0
O8KgIMKgIMKgJmFtcDtlcnJvcl9mYXRhbCk7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoC8qIFJBTSAqLzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoG1lbW9y
eV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtX21lbW9yeSgmYW1wO3MtJmd0O3NkcmFtLCBOVUxMLDxi
cj4NCiZndDvCoCDCoCDCoCZxdW90O29yYW5nZXBpLnJhbSZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgbWFjaGluZS0mZ3Q7cmFtX3NpemUpOzxicj4NCiZndDvCoCDCoCDCoEBAIC04MCw2
ICs5Niw3IEBAIHN0YXRpYyB2b2lkIG9yYW5nZXBpX21hY2hpbmVfaW5pdChNYWNoaW5lQ2xhc3Mg
Km1jKTxicj4NCiZndDvCoCDCoCDCoCDCoHs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqBtYy0m
Z3Q7ZGVzYyA9ICZxdW90O09yYW5nZSBQaSBQQyZxdW90Ozs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqBtYy0mZ3Q7aW5pdCA9IG9yYW5nZXBpX2luaXQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IG1jLSZndDtibG9ja19kZWZhdWx0X3R5cGUgPSBJRl9TRDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAg
wqAgwqBtYy0mZ3Q7dW5pdHNfcGVyX2RlZmF1bHRfYnVzID0gMTs8YnI+DQomZ3Q7wqAgwqAgwqAg
wqAgwqAgwqBtYy0mZ3Q7bWluX2NwdXMgPSBBV19IM19OVU1fQ1BVUzs8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqBtYy0mZ3Q7bWF4X2NwdXMgPSBBV19IM19OVU1fQ1BVUzs8YnI+DQomZ3Q7wqAg
wqAgwqBkaWZmIC0tZ2l0IGEvaHcvc2QvTWFrZWZpbGUub2JqcyBiL2h3L3NkL01ha2VmaWxlLm9i
anM8YnI+DQomZ3Q7wqAgwqAgwqBpbmRleCBhODg0YzIzOGRmLi5lN2NjNWFiNzM5IDEwMDY0NDxi
cj4NCiZndDvCoCDCoCDCoC0tLSBhL2h3L3NkL01ha2VmaWxlLm9ianM8YnI+DQomZ3Q7wqAgwqAg
wqArKysgYi9ody9zZC9NYWtlZmlsZS5vYmpzPGJyPg0KJmd0O8KgIMKgIMKgQEAgLTQsNiArNCw3
IEBAIGNvbW1vbi1vYmotJChDT05GSUdfU0QpICs9IHNkLm8gY29yZS5vIHNkbW1jLWludGVybmFs
Lm88YnI+DQomZ3Q7wqAgwqAgwqAgwqBjb21tb24tb2JqLSQoQ09ORklHX1NESENJKSArPSBzZGhj
aS5vPGJyPg0KJmd0O8KgIMKgIMKgIMKgY29tbW9uLW9iai0kKENPTkZJR19TREhDSV9QQ0kpICs9
IHNkaGNpLXBjaS5vPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqArb2JqLSQoQ09ORklHX0FM
TFdJTk5FUl9IMykgKz0gYWxsd2lubmVyLWgzLXNkaG9zdC5vPGJyPg0KJmd0O8KgIMKgIMKgIMKg
b2JqLSQoQ09ORklHX01JTEtZTUlTVCkgKz0gbWlsa3ltaXN0LW1lbWNhcmQubzxicj4NCiZndDvC
oCDCoCDCoCDCoG9iai0kKENPTkZJR19PTUFQKSArPSBvbWFwX21tYy5vPGJyPg0KJmd0O8KgIMKg
IMKgIMKgb2JqLSQoQ09ORklHX1BYQTJYWCkgKz0gcHhhMnh4X21tY2kubzxicj4NCiZndDvCoCDC
oCDCoGRpZmYgLS1naXQgYS9ody9zZC9hbGx3aW5uZXItaDMtc2Rob3N0LmMgYi9ody9zZC9hbGx3
aW5uZXItaDMtc2Rob3N0LmM8YnI+DQomZ3Q7wqAgwqAgwqBuZXcgZmlsZSBtb2RlIDEwMDY0NDxi
cj4NCiZndDvCoCDCoCDCoGluZGV4IDAwMDAwMDAwMDAuLjI2ZTExM2ExNDQ8YnI+DQomZ3Q7wqAg
wqAgwqAtLS0gL2Rldi9udWxsPGJyPg0KJmd0O8KgIMKgIMKgKysrIGIvaHcvc2QvYWxsd2lubmVy
LWgzLXNkaG9zdC5jPGJyPg0KJmd0O8KgIMKgIMKgQEAgLTAsMCArMSw3OTEgQEA8YnI+DQomZ3Q7
wqAgwqAgwqArLyo8YnI+DQomZ3Q7wqAgwqAgwqArICogQWxsd2lubmVyIEgzIFNEIEhvc3QgQ29u
dHJvbGxlciBlbXVsYXRpb248YnI+DQomZ3Q7wqAgwqAgwqArICo8YnI+DQomZ3Q7wqAgwqAgwqAr
ICogQ29weXJpZ2h0IChDKSAyMDE5IE5pZWsgTGlubmVuYmFuayAmbHQ7PGEgaHJlZj0ibWFpbHRv
Om5pZWtsaW5uZW5iYW5rQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm5pZWtsaW5uZW5iYW5r
QGdtYWlsLmNvbTwvYT48YnI+DQomZ3Q7wqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0
bzpuaWVrbGlubmVuYmFua0BnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5uaWVrbGlubmVuYmFu
a0BnbWFpbC5jb208L2E+Jmd0OyZndDs8YnI+DQomZ3Q7wqAgwqAgwqArICo8YnI+DQomZ3Q7wqAg
wqAgwqArICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU6IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnk8YnI+DQomZ3Q7wqAgwqAgwqArICogaXQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnk8YnI+
DQomZ3Q7wqAgwqAgwqArICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZl
cnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3I8YnI+DQomZ3Q7wqAgwqAgwqArICogKGF0IHlvdXIg
b3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi48YnI+DQomZ3Q7wqAgwqAgwqArICo8YnI+DQomZ3Q7
wqAgwqAgwqArICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQg
aXQgd2lsbCBiZSB1c2VmdWwsPGJyPg0KJmd0O8KgIMKgIMKgKyAqIGJ1dCBXSVRIT1VUIEFOWSBX
QVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mPGJyPg0KJmd0O8Kg
IMKgIMKgKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVS
UE9TRS7CoCBTZWUgdGhlPGJyPg0KJmd0O8KgIMKgIMKgKyAqIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGZvciBtb3JlIGRldGFpbHMuPGJyPg0KJmd0O8KgIMKgIMKgKyAqPGJyPg0KJmd0O8Kg
IMKgIMKgKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlPGJyPg0KJmd0O8KgIMKgIMKgKyAqIGFsb25nIHdpdGggdGhpcyBw
cm9ncmFtLsKgIElmIG5vdCwgc2VlPGJyPg0KJmd0O8KgIMKgIMKgJmx0OzxhIGhyZWY9Imh0dHA6
Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
Pmh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy88L2E+Jmd0Oy48YnI+DQomZ3Q7wqAgwqAgwqAr
ICovPGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDtx
ZW11L29zZGVwLmgmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqArI2luY2x1ZGUgJnF1b3Q7cWVtdS9s
b2cuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDtxZW11L21vZHVsZS5o
JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90O3N5c2VtdS9ibG9ja2Rldi5o
JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90O2h3L2lycS5oJnF1b3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90O2h3L3NkL2FsbHdpbm5lci1oMy1zZGhvc3Qu
aCZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCsjaW5jbHVkZSAmcXVvdDttaWdyYXRpb24vdm1zdGF0
ZS5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90O3RyYWNlLmgmcXVvdDs8
YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgVFlQRV9BV19IM19T
REhPU1RfQlVTICZxdW90O2FsbHdpbm5lci1oMy1zZGhvc3QtYnVzJnF1b3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgQVdfSDNfU0RIT1NUX0JVUyhvYmopIFw8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgT0JKRUNUX0NIRUNLKFNEQnVzLCAob2JqKSwgVFlQRV9BV19IM19TREhPU1RfQlVTKTxi
cj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArLyogU0QgSG9zdCByZWdpc3RlciBv
ZmZzZXRzICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0dDVEzCoCDCoCDCoCDC
oCAoMHgwMCnCoCAvKiBHbG9iYWwgQ29udHJvbCAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5l
IFJFR19TRF9DS0NSwqAgwqAgwqAgwqAgKDB4MDQpwqAgLyogQ2xvY2sgQ29udHJvbCAqLzxicj4N
CiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9UTU9SwqAgwqAgwqAgwqAgKDB4MDgpwqAgLyog
VGltZW91dCAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9CV0RSwqAgwqAgwqAg
wqAgKDB4MEMpwqAgLyogQnVzIFdpZHRoICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVH
X1NEX0JLU1LCoCDCoCDCoCDCoCAoMHgxMCnCoCAvKiBCbG9jayBTaXplICovPGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgUkVHX1NEX0JZQ1LCoCDCoCDCoCDCoCAoMHgxNCnCoCAvKiBCeXRlIENv
dW50ICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0NNRFLCoCDCoCDCoCDCoCAo
MHgxOCnCoCAvKiBDb21tYW5kICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0NB
R1LCoCDCoCDCoCDCoCAoMHgxQynCoCAvKiBDb21tYW5kIEFyZ3VtZW50ICovPGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgUkVHX1NEX1JFU1AwwqAgwqAgwqAgwqAoMHgyMCnCoCAvKiBSZXNwb25z
ZSBaZXJvICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX1JFU1AxwqAgwqAgwqAg
wqAoMHgyNCnCoCAvKiBSZXNwb25zZSBPbmUgKi88YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBS
RUdfU0RfUkVTUDLCoCDCoCDCoCDCoCgweDI4KcKgIC8qIFJlc3BvbnNlIFR3byAqLzxicj4NCiZn
dDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9SRVNQM8KgIMKgIMKgIMKgKDB4MkMpwqAgLyogUmVz
cG9uc2UgVGhyZWUgKi88YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfSU1LUsKgIMKg
IMKgIMKgICgweDMwKcKgIC8qIEludGVycnVwdCBNYXNrICovPGJyPg0KJmd0O8KgIMKgIMKgKyNk
ZWZpbmUgUkVHX1NEX01JU1LCoCDCoCDCoCDCoCAoMHgzNCnCoCAvKiBNYXNrZWQgSW50ZXJydXB0
IFN0YXR1cyAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9SSVNSwqAgwqAgwqAg
wqAgKDB4MzgpwqAgLyogUmF3IEludGVycnVwdCBTdGF0dXMgKi88YnI+DQomZ3Q7wqAgwqAgwqAr
I2RlZmluZSBSRUdfU0RfU1RBUsKgIMKgIMKgIMKgICgweDNDKcKgIC8qIFN0YXR1cyAqLzxicj4N
CiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9GV0xSwqAgwqAgwqAgwqAgKDB4NDApwqAgLyog
RklGTyBXYXRlciBMZXZlbCAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9GVU5T
wqAgwqAgwqAgwqAgKDB4NDQpwqAgLyogRklGTyBGdW5jdGlvbiBTZWxlY3QgKi88YnI+DQomZ3Q7
wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfREJHQ8KgIMKgIMKgIMKgICgweDUwKcKgIC8qIERlYnVn
IEVuYWJsZSAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9BMTJBwqAgwqAgwqAg
wqAgKDB4NTgpwqAgLyogQXV0byBjb21tYW5kIDEyIGFyZ3VtZW50ICovPGJyPg0KJmd0O8KgIMKg
IMKgKyNkZWZpbmUgUkVHX1NEX05UU1LCoCDCoCDCoCDCoCAoMHg1QynCoCAvKiBTRCBOZXdUaW1p
bmcgU2V0ICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX1NEQkfCoCDCoCDCoCDC
oCAoMHg2MCnCoCAvKiBTRCBuZXdUaW1pbmcgU2V0IERlYnVnICovPGJyPg0KJmd0O8KgIMKgIMKg
KyNkZWZpbmUgUkVHX1NEX0hXUlNUwqAgwqAgwqAgwqAoMHg3OCnCoCAvKiBIYXJkd2FyZSBSZXNl
dCBSZWdpc3RlciAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9ETUFDwqAgwqAg
wqAgwqAgKDB4ODApwqAgLyogSW50ZXJuYWwgRE1BIENvbnRyb2xsZXI8YnI+DQomZ3Q7wqAgwqAg
wqBDb250cm9sICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RMQkHCoCDCoCDC
oCDCoCAoMHg4NCnCoCAvKiBEZXNjcmlwdG9yIExpc3QgQmFzZSBBZGRyZXNzICovPGJyPg0KJmd0
O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0lEU1TCoCDCoCDCoCDCoCAoMHg4OCnCoCAvKiBJbnRl
cm5hbCBETUEgQ29udHJvbGxlciBTdGF0dXMgKi88YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBS
RUdfU0RfSURJRcKgIMKgIMKgIMKgICgweDhDKcKgIC8qIEludGVybmFsIERNQSBDb250cm9sbGVy
IElSUTxicj4NCiZndDvCoCDCoCDCoEVuYWJsZSAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5l
IFJFR19TRF9USExEQ8KgIMKgIMKgIMKgKDB4MTAwKSAvKiBDYXJkIFRocmVzaG9sZCBDb250cm9s
ICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RTQkTCoCDCoCDCoCDCoCAoMHgx
MEMpIC8qIGVNTUMgRERSIFN0YXJ0IEJpdCBEZXRlY3Rpb248YnI+DQomZ3Q7wqAgwqAgwqBDb250
cm9sICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX1JFU19DUkPCoCDCoCDCoCgw
eDExMCkgLyogUmVzcG9uc2UgQ1JDIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKg
KyNkZWZpbmUgUkVHX1NEX0RBVEE3X0NSQ8KgIMKgKDB4MTE0KSAvKiBDUkMgRGF0YSA3IGZyb20g
Y2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEE2X0NSQ8Kg
IMKgKDB4MTE4KSAvKiBDUkMgRGF0YSA2IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKg
IMKgKyNkZWZpbmUgUkVHX1NEX0RBVEE1X0NSQ8KgIMKgKDB4MTFDKSAvKiBDUkMgRGF0YSA1IGZy
b20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEE0X0NS
Q8KgIMKgKDB4MTIwKSAvKiBDUkMgRGF0YSA0IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEEzX0NSQ8KgIMKgKDB4MTI0KSAvKiBDUkMgRGF0YSAz
IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEEy
X0NSQ8KgIMKgKDB4MTI4KSAvKiBDUkMgRGF0YSAyIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0
O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEExX0NSQ8KgIMKgKDB4MTJDKSAvKiBDUkMgRGF0
YSAxIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RB
VEEwX0NSQ8KgIMKgKDB4MTMwKSAvKiBDUkMgRGF0YSAwIGZyb20gY2FyZC9lTU1DICovPGJyPg0K
Jmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0NSQ19TVEHCoCDCoCDCoCgweDEzNCkgLyogQ1JD
IHN0YXR1cyBmcm9tIGNhcmQvZU1NQzxicj4NCiZndDvCoCDCoCDCoGR1cmluZyB3cml0ZSAqLzxi
cj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9GSUZPwqAgwqAgwqAgwqAgKDB4MjAwKSAv
KiBSZWFkL1dyaXRlIEZJRk8gKi88YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKg
Ky8qIFNEIEhvc3QgcmVnaXN0ZXIgZmxhZ3MgKi88YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBT
RF9HQ1RMX0ZJRk9fQUNfTU9EwqAgwqAgwqAoMSAmbHQ7Jmx0OyAzMSk8YnI+DQomZ3Q7wqAgwqAg
wqArI2RlZmluZSBTRF9HQ1RMX0REUl9NT0RfU0VMwqAgwqAgwqAoMSAmbHQ7Jmx0OyAxMCk8YnI+
DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9HQ1RMX0NEX0RCQ19FTkLCoCDCoCDCoCAoMSAmbHQ7
Jmx0OyA4KTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0dDVExfRE1BX0VOQsKgIMKgIMKg
IMKgIMKgKDEgJmx0OyZsdDsgNSk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9HQ1RMX0lO
VF9FTkLCoCDCoCDCoCDCoCDCoCgxICZsdDsmbHQ7IDQpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZp
bmUgU0RfR0NUTF9ETUFfUlNUwqAgwqAgwqAgwqAgwqAoMSAmbHQ7Jmx0OyAyKTxicj4NCiZndDvC
oCDCoCDCoCsjZGVmaW5lIFNEX0dDVExfRklGT19SU1TCoCDCoCDCoCDCoCAoMSAmbHQ7Jmx0OyAx
KTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0dDVExfU09GVF9SU1TCoCDCoCDCoCDCoCAo
MSAmbHQ7Jmx0OyAwKTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmlu
ZSBTRF9DTURSX0xPQUTCoCDCoCDCoCDCoCDCoCDCoCAoMSAmbHQ7Jmx0OyAzMSk8YnI+DQomZ3Q7
wqAgwqAgwqArI2RlZmluZSBTRF9DTURSX0NMS0NIQU5HRcKgIMKgIMKgIMKgKDEgJmx0OyZsdDsg
MjEpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfQ01EUl9XUklURcKgIMKgIMKgIMKgIMKg
IMKgKDEgJmx0OyZsdDsgMTApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfQ01EUl9BVVRP
U1RPUMKgIMKgIMKgIMKgICgxICZsdDsmbHQ7IDEyKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5l
IFNEX0NNRFJfREFUQcKgIMKgIMKgIMKgIMKgIMKgICgxICZsdDsmbHQ7IDkpPGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgU0RfQ01EUl9SRVNQT05TRV9MT05HwqAgwqAoMSAmbHQ7Jmx0OyA3KTxi
cj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0NNRFJfUkVTUE9OU0XCoCDCoCDCoCDCoCAoMSAm
bHQ7Jmx0OyA2KTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0NNRFJfQ01ESURfTUFTS8Kg
IMKgIMKgICgweDNmKTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmlu
ZSBTRF9SSVNSX0NBUkRfUkVNT1ZFwqAgwqAgwqAoMSAmbHQ7Jmx0OyAzMSk8YnI+DQomZ3Q7wqAg
wqAgwqArI2RlZmluZSBTRF9SSVNSX0NBUkRfSU5TRVJUwqAgwqAgwqAoMSAmbHQ7Jmx0OyAzMCk8
YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9SSVNSX0FVVE9DTURfRE9ORcKgIMKgICgxICZs
dDsmbHQ7IDE0KTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX1JJU1JfREFUQV9DT01QTEVU
RcKgIMKgKDEgJmx0OyZsdDsgMyk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBTRF9SSVNSX0NN
RF9DT01QTEVURcKgIMKgICgxICZsdDsmbHQ7IDIpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUg
U0RfUklTUl9OT19SRVNQT05TRcKgIMKgIMKgKDEgJmx0OyZsdDsgMSk8YnI+DQomZ3Q7wqAgwqAg
wqArPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfU1RBUl9DQVJEX1BSRVNFTlTCoCDCoCAo
MSAmbHQ7Jmx0OyA4KTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmlu
ZSBTRF9JRFNUX1NVTV9SRUNFSVZFX0lSUSAoMSAmbHQ7Jmx0OyA4KTxicj4NCiZndDvCoCDCoCDC
oCsjZGVmaW5lIFNEX0lEU1RfUkVDRUlWRV9JUlHCoCDCoCDCoCgxICZsdDsmbHQ7IDEpPGJyPg0K
Jmd0O8KgIMKgIMKgKyNkZWZpbmUgU0RfSURTVF9UUkFOU01JVF9JUlHCoCDCoCAoMSAmbHQ7Jmx0
OyAwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFNEX0lEU1RfSVJRX01BU0vCoCDCoCDCoCDC
oCAoU0RfSURTVF9SRUNFSVZFX0lSUSB8PGJyPg0KJmd0O8KgIMKgIMKgU0RfSURTVF9UUkFOU01J
VF9JUlEgfCBcPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgU0RfSURTVF9TVU1fUkVDRUlWRV9JUlEpPGJyPg0KJmd0O8Kg
IMKgIMKgKyNkZWZpbmUgU0RfSURTVF9XUl9NQVNLwqAgwqAgwqAgwqAgwqAoMHgzZmYpPGJyPg0K
Jmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCsvKiBTRCBIb3N0IHJlZ2lzdGVyIHJlc2V0
IHZhbHVlcyAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9HQ1RMX1JTVMKgIMKg
IMKgIMKgIMKgKDB4MDAwMDAzMDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0NL
Q1JfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19T
RF9UTU9SX1JTVMKgIMKgIMKgIMKgIMKgKDB4RkZGRkZGNDApPGJyPg0KJmd0O8KgIMKgIMKgKyNk
ZWZpbmUgUkVHX1NEX0JXRFJfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDC
oCsjZGVmaW5lIFJFR19TRF9CS1NSX1JTVMKgIMKgIMKgIMKgIMKgKDB4MDAwMDAyMDApPGJyPg0K
Jmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0JZQ1JfUlNUwqAgwqAgwqAgwqAgwqAoMHgwMDAw
MDIwMCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfQ01EUl9SU1TCoCDCoCDCoCDC
oCDCoCgweDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0NBR1JfUlNUwqAgwqAg
wqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9SRVNQX1JTVMKg
IMKgIMKgIMKgIMKgKDB4MCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfSU1LUl9S
U1TCoCDCoCDCoCDCoCDCoCgweDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX01J
U1JfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19T
RF9SSVNSX1JTVMKgIMKgIMKgIMKgIMKgKDB4MCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBS
RUdfU0RfU1RBUl9SU1TCoCDCoCDCoCDCoCDCoCgweDAwMDAwMTAwKTxicj4NCiZndDvCoCDCoCDC
oCsjZGVmaW5lIFJFR19TRF9GV0xSX1JTVMKgIMKgIMKgIMKgIMKgKDB4MDAwRjAwMDApPGJyPg0K
Jmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0ZVTlNfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxi
cj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9EQkdDX1JTVMKgIMKgIMKgIMKgIMKgKDB4
MCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfQTEyQV9SU1TCoCDCoCDCoCDCoCDC
oCgweDAwMDBGRkZGKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9OVFNSX1JTVMKg
IMKgIMKgIMKgIMKgKDB4MDAwMDAwMDEpPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NE
X1NEQkdfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJF
R19TRF9IV1JTVF9SU1TCoCDCoCDCoCDCoCAoMHgwMDAwMDAwMSk8YnI+DQomZ3Q7wqAgwqAgwqAr
I2RlZmluZSBSRUdfU0RfRE1BQ19SU1TCoCDCoCDCoCDCoCDCoCgweDApPGJyPg0KJmd0O8KgIMKg
IMKgKyNkZWZpbmUgUkVHX1NEX0RMQkFfUlNUwqAgwqAgwqAgwqAgwqAoMHgwKTxicj4NCiZndDvC
oCDCoCDCoCsjZGVmaW5lIFJFR19TRF9JRFNUX1JTVMKgIMKgIMKgIMKgIMKgKDB4MCk8YnI+DQom
Z3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfSURJRV9SU1TCoCDCoCDCoCDCoCDCoCgweDApPGJy
Pg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX1RITERDX1JTVMKgIMKgIMKgIMKgICgweDAp
PGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RTQkRfUlNUwqAgwqAgwqAgwqAgwqAo
MHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9SRVNfQ1JDX1JTVMKgIMKgIMKg
ICgweDApPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgUkVHX1NEX0RBVEFfQ1JDX1JTVMKgIMKg
IMKgKDB4MCk8YnI+DQomZ3Q7wqAgwqAgwqArI2RlZmluZSBSRUdfU0RfQ1JDX1NUQV9SU1TCoCDC
oCDCoCAoMHgwKTxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFJFR19TRF9GSUZPX1JTVMKgIMKg
IMKgIMKgIMKgKDB4MCk8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKy8qIERh
dGEgdHJhbnNmZXIgZGVzY3JpcHRvciBmb3IgRE1BICovPGJyPg0KJmd0O8KgIMKgIMKgK3R5cGVk
ZWYgc3RydWN0IFRyYW5zZmVyRGVzY3JpcHRvciB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVp
bnQzMl90IHN0YXR1czsgLyogU3RhdHVzIGZsYWdzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IHVpbnQzMl90IHNpemU7wqAgwqAvKiBEYXRhIGJ1ZmZlciBzaXplICovPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIHVpbnQzMl90IGFkZHI7wqAgwqAvKiBEYXRhIGJ1ZmZlciBhZGRyZXNzICovPGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IG5leHQ7wqAgwqAvKiBQaHlzaWNhbCBhZGRy
ZXNzIG9mIG5leHQgZGVzY3JpcHRvciAqLzxicj4NCiZndDvCoCDCoCDCoCt9IFRyYW5zZmVyRGVz
Y3JpcHRvcjs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKy8qIERhdGEgdHJh
bnNmZXIgZGVzY3JpcHRvciBmbGFncyAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIERFU0Nf
U1RBVFVTX0hPTETCoCDCoCgxICZsdDsmbHQ7IDMxKSAvKiBTZXQgd2hlbiBkZXNjcmlwdG9yIGlz
IGluPGJyPg0KJmd0O8KgIMKgIMKgdXNlIGJ5IERNQSAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVm
aW5lIERFU0NfU1RBVFVTX0VSUk9SwqAgKDEgJmx0OyZsdDsgMzApIC8qIFNldCB3aGVuIERNQSB0
cmFuc2ZlciBlcnJvcjxicj4NCiZndDvCoCDCoCDCoG9jY3VycmVkICovPGJyPg0KJmd0O8KgIMKg
IMKgKyNkZWZpbmUgREVTQ19TVEFUVVNfQ0hBSU7CoCAoMSAmbHQ7Jmx0OyA0KcKgIC8qIEluZGlj
YXRlcyBjaGFpbmVkPGJyPg0KJmd0O8KgIMKgIMKgZGVzY3JpcHRvci4gKi88YnI+DQomZ3Q7wqAg
wqAgwqArI2RlZmluZSBERVNDX1NUQVRVU19GSVJTVMKgICgxICZsdDsmbHQ7IDMpwqAgLyogU2V0
IG9uIHRoZSBmaXJzdCBkZXNjcmlwdG9yICovPGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgREVT
Q19TVEFUVVNfTEFTVMKgIMKgKDEgJmx0OyZsdDsgMinCoCAvKiBTZXQgb24gdGhlIGxhc3QgZGVz
Y3JpcHRvciAqLzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIERFU0NfU1RBVFVTX05PSVJRwqAg
KDEgJmx0OyZsdDsgMSnCoCAvKiBTa2lwIHJhaXNpbmcgaW50ZXJydXB0PGJyPg0KJmd0O8KgIMKg
IMKgYWZ0ZXIgdHJhbnNmZXIgKi88YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKg
KyNkZWZpbmUgREVTQ19TSVpFX01BU0vCoCDCoCDCoCgweGZmZmZmZmZjKTxicj4NCiZndDvCoCDC
oCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArc3RhdGljIHZvaWQgYXdfaDNfc2Rob3N0X3VwZGF0ZV9p
cnEoQXdIM1NESG9zdFN0YXRlICpzKTxicj4NCiZndDvCoCDCoCDCoCt7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIHVpbnQzMl90IGlycV9lbiA9IHMtJmd0O2dsb2JhbF9jdGwgJmFtcDsgU0RfR0NU
TF9JTlRfRU5COzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBpcnEgPSBpcnFfZW4g
PyBzLSZndDtpcnFfc3RhdHVzICZhbXA7IHMtJmd0O2lycV9tYXNrIDogMDs8YnI+DQo8YnI+DQpU
aGUgcHJldmlvdXMgbGluZSBpcyBjb25mdXNlLCBlaXRoZXIgdXNlIHBhcmVudGhlc2lzIG9yIGEg
aWYgc3RhdGVtZW50Ljxicj4NCjxicj4NCsKgIMKgIMKgdWludDMyX3QgaXJxID0gaXJxX2VuID8g
KHMtJmd0O2lycV9zdGF0dXMgJmFtcDsgcy0mZ3Q7aXJxX21hc2spIDogMDs8YnI+DQo8YnI+DQom
Z3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHRyYWNlX2F3X2gzX3NkaG9zdF91
cGRhdGVfaXJxKGlycSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHFlbXVfc2V0X2lycShzLSZn
dDtpcnEsIGlycSk7PGJyPg0KJmd0O8KgIMKgIMKgK308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0K
Jmd0O8KgIMKgIMKgK3N0YXRpYyB2b2lkIGF3X2gzX3NkaG9zdF91cGRhdGVfdHJhbnNmZXJfY250
KEF3SDNTREhvc3RTdGF0ZSAqcyw8YnI+DQomZ3Q7wqAgwqAgwqB1aW50MzJfdCBieXRlcyk8YnI+
DQomZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBpZiAocy0mZ3Q7dHJhbnNm
ZXJfY250ICZndDsgYnl0ZXMpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7
dHJhbnNmZXJfY250IC09IGJ5dGVzOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9IGVsc2Ugezxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDt0cmFuc2Zlcl9jbnQgPSAwOzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCBpZiAoIXMtJmd0O3RyYW5zZmVyX2NudCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBzLSZndDtpcnFfc3RhdHVzIHw9IFNEX1JJU1JfREFUQV9DT01QTEVURSB8IFNEX1JJ
U1JfQVVUT0NNRF9ET05FOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0O8KgIMKg
IMKgK308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3N0YXRpYyB2b2lkIGF3
X2gzX3NkaG9zdF9zZXRfaW5zZXJ0ZWQoRGV2aWNlU3RhdGUgKmRldiwgYm9vbCBpbnNlcnRlZCk8
YnI+DQomZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBBd0gzU0RIb3N0U3Rh
dGUgKnMgPSBBV19IM19TREhPU1QoZGV2KTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIHRyYWNlX2F3X2gzX3NkaG9zdF9zZXRfaW5zZXJ0ZWQoaW5zZXJ0ZWQpOzxi
cj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgaWYgKGluc2VydGVkKSB7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2lycV9zdGF0dXMgfD0gU0RfUklT
Ul9DQVJEX0lOU0VSVDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7aXJxX3N0
YXR1cyAmYW1wOz0gflNEX1JJU1JfQ0FSRF9SRU1PVkU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIHMtJmd0O3N0YXR1cyB8PSBTRF9TVEFSX0NBUkRfUFJFU0VOVDs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7
aXJxX3N0YXR1cyAmYW1wOz0gflNEX1JJU1JfQ0FSRF9JTlNFUlQ7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIHMtJmd0O2lycV9zdGF0dXMgfD0gU0RfUklTUl9DQVJEX1JFTU9WRTs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7c3RhdHVzICZhbXA7PSB+U0RfU1RBUl9D
QVJEX1BSRVNFTlQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAr
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGF3X2gzX3NkaG9zdF91cGRhdGVfaXJxKHMpOzxicj4N
CiZndDvCoCDCoCDCoCt9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtzdGF0
aWMgdm9pZCBhd19oM19zZGhvc3Rfc2VuZF9jb21tYW5kKEF3SDNTREhvc3RTdGF0ZSAqcyk8YnI+
DQomZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBTRFJlcXVlc3QgcmVxdWVz
dDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDhfdCByZXNwWzE2XTs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgaW50IHJsZW47PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCAvKiBBdXRvIGNsZWFyIGxvYWQgZmxhZyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCBzLSZndDtjb21tYW5kICZhbXA7PSB+U0RfQ01EUl9MT0FEOzxicj4NCiZndDvCoCDCoCDCoCs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLyogQ2xvY2sgY2hhbmdlIGRvZXMgbm90IGFjdHVhbGx5
IGludGVyYWN0IHdpdGggdGhlIFNEIGJ1cyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBpZiAo
IShzLSZndDtjb21tYW5kICZhbXA7IFNEX0NNRFJfQ0xLQ0hBTkdFKSkgezxicj4NCiZndDvCoCDC
oCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgLyogUHJlcGFyZSByZXF1ZXN0ICov
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcXVlc3QuY21kID0gcy0mZ3Q7Y29tbWFu
ZCAmYW1wOyBTRF9DTURSX0NNRElEX01BU0s7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IHJlcXVlc3QuYXJnID0gcy0mZ3Q7Y29tbWFuZF9hcmc7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCAvKiBTZW5kIHJlcXVlc3QgdG8gU0QgYnVzICovPGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJsZW4gPSBzZGJ1c19kb19jb21tYW5kKCZhbXA7
cy0mZ3Q7c2RidXMsICZhbXA7cmVxdWVzdCwgcmVzcCk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIGlmIChybGVuICZsdDsgMCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDC
oCDCoCBnb3RvIGVycm9yOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0
O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCAvKiBJZiB0aGUgY29tbWFu
ZCBoYXMgYSByZXNwb25zZSwgc3RvcmUgaXQgaW4gdGhlIHJlc3BvbnNlPGJyPg0KJmd0O8KgIMKg
IMKgcmVnaXN0ZXJzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGlmICgocy0mZ3Q7
Y29tbWFuZCAmYW1wOyBTRF9DTURSX1JFU1BPTlNFKSkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCDCoCDCoCBpZiAocmxlbiA9PSAwIHx8PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKHJsZW4gPT0gNCAmYW1wOyZhbXA7IChzLSZndDtjb21tYW5kICZhbXA7
IFNEX0NNRFJfUkVTUE9OU0VfTE9ORykpKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGdvdG8gZXJyb3I7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKg
IMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHJsZW4gIT0gNCAm
YW1wOyZhbXA7IHJsZW4gIT0gMTYpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZ290byBlcnJvcjs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
fTxicj4NCjxicj4NCk1heWJlIHJlbW92ZSBwcmV2aW91cyBpZi4uLjxicj4NCjxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBpZiAocmxlbiA9PSA0KSB7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHMtJmd0O3Jlc3BvbnNlWzBdID0gbGRsX2JlX3Ao
JmFtcDtyZXNwWzBdKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cy0mZ3Q7cmVzcG9uc2VbMV0gPSBzLSZndDtyZXNwb25zZVsyXSA9IHMtJmd0O3Jlc3BvbnNlWzNd
ID0gMDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQo8
YnI+DQouLi48YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2Ug
aWYgKHJsZW4gPT0gMTYpIHsgLi4uPGJyPg0KPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHMtJmd0O3Jlc3BvbnNlWzBdID0gbGRsX2JlX3AoJmFtcDtyZXNwWzEyXSk7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHMtJmd0O3Jlc3BvbnNl
WzFdID0gbGRsX2JlX3AoJmFtcDtyZXNwWzhdKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcy0mZ3Q7cmVzcG9uc2VbMl0gPSBsZGxfYmVfcCgmYW1wO3Jlc3BbNF0p
Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzLSZndDtyZXNwb25z
ZVszXSA9IGxkbF9iZV9wKCZhbXA7cmVzcFswXSk7PGJyPg0KPGJyPg0KLi4uPGJyPg0KPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycm9yOzxicj4NCjxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIH08YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgLyogU2V0IGludGVycnVwdCBzdGF0dXMgYml0cyAqLzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCBzLSZndDtpcnFfc3RhdHVzIHw9IFNEX1JJU1JfQ01EX0NPTVBMRVRFOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCByZXR1cm47PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDC
oCDCoCtlcnJvcjo8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7aXJxX3N0YXR1cyB8PSBT
RF9SSVNSX05PX1JFU1BPTlNFOzxicj4NCiZndDvCoCDCoCDCoCt9PGJyPg0KJmd0O8KgIMKgIMKg
Kzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBhd19oM19zZGhvc3RfYXV0b19zdG9wKEF3
SDNTREhvc3RTdGF0ZSAqcyk8YnI+DQomZ3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCAvKjxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCogVGhlIHN0b3AgY29tbWFuZCAoQ01E
MTIpIGVuc3VyZXMgdGhlIFNEIGJ1czxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCogcmV0dXJu
cyB0byB0aGUgdHJhbnNmZXIgc3RhdGUuPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgKi88YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgaWYgKChzLSZndDtjb21tYW5kICZhbXA7IFNEX0NNRFJfQVVU
T1NUT1ApICZhbXA7JmFtcDsgKHMtJmd0O3RyYW5zZmVyX2NudCA9PSAwKSkgezxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCAvKiBGaXJzdCBzYXZlIGN1cnJlbnQgY29tbWFuZCByZWdpc3Rl
cnMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgdWludDMyX3Qgc2F2ZWRfY21kID0g
cy0mZ3Q7Y29tbWFuZDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgdWludDMyX3Qgc2F2
ZWRfYXJnID0gcy0mZ3Q7Y29tbWFuZF9hcmc7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCAvKiBQcmVwYXJlIHN0b3AgY29tbWFuZCAoQ01EMTIpICovPGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2NvbW1hbmQgJmFtcDs9IH5TRF9DTURS
X0NNRElEX01BU0s7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2NvbW1hbmQg
fD0gMTI7IC8qIENNRDEyICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2Nv
bW1hbmRfYXJnID0gMDs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIC8qIFB1dCB0aGUgY29tbWFuZCBvbiBTRCBidXMgKi88YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3NlbmRfY29tbWFuZChzKTs8YnI+DQomZ3Q7wqAgwqAg
wqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIC8qIFJlc3RvcmUgY29tbWFuZCB2YWx1
ZXMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7Y29tbWFuZCA9IHNhdmVk
X2NtZDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7Y29tbWFuZF9hcmcgPSBz
YXZlZF9hcmc7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArfTxi
cj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArc3RhdGljIHVpbnQzMl90IGF3X2gz
X3NkaG9zdF9wcm9jZXNzX2Rlc2MoQXdIM1NESG9zdFN0YXRlICpzLDxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBod2FkZHIgZGVzY19hZGRyLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUcmFuc2Zl
ckRlc2NyaXB0b3IgKmRlc2MsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJvb2wgaXNfd3JpdGUs
IHVpbnQzMl90PGJyPg0KJmd0O8KgIMKgIMKgbWF4X2J5dGVzKTxicj4NCiZndDvCoCDCoCDCoCt7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IG51bV9kb25lID0gMDs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgdWludDMyX3QgbnVtX2J5dGVzID0gbWF4X2J5dGVzOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCB1aW50OF90IGJ1ZlsxMDI0XTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIC8qIFJlYWQgZGVzY3JpcHRvciAqLzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCBjcHVfcGh5c2ljYWxfbWVtb3J5X3JlYWQoZGVzY19hZGRyLCBkZXNjLCBzaXplb2Yo
KmRlc2MpKTs8YnI+DQo8YnI+DQpTaG91bGQgd2Ugd29ycnkgYWJvdXQgZW5kaWFuZXNzIGhlcmU/
PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgdHJpZWQgdG8gZmlndXJlIG91
dCB3aGF0IGlzIGV4cGVjdGVkLCBidXQgdGhlIEFsbHdpbm5lcl9IM19EYXRhc2hlZXRfVjEuMi5w
ZGYgZG9lcyBub3Q8L2Rpdj48ZGl2PmV4cGxpY2l0bHkgbWVudGlvbiBlbmRpYW5uZXNzIGZvciBh
bnkgb2YgaXRzIEkvTyBkZXZpY2VzLiBDdXJyZW50bHkgaXQgc2VlbXMgYWxsIGRldmljZXMgYXJl
PC9kaXY+PGRpdj5oYXBweSB3aXRoIHVzaW5nIHRoZSBzYW1lIGVuZGlhbm5lc3MgYXMgdGhlIENQ
VXMuIEluIHRoZSBNZW1vcnlSZWdpb25PcHMgaGFzIERFVklDRV9OQVRJVkVfRU5ESUFOPC9kaXY+
PGRpdj5zZXQgdG8gbWF0Y2ggdGhlIGJlaGF2aW9yIHNlZW4uPGJyPjwvZGl2PjxkaXY+wqA8L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAw
cHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1s
ZWZ0OjFleCI+DQo8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgaWYgKGRlc2MtJmd0O3NpemUgPT0g
MCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBkZXNjLSZndDtzaXplID0gMHhmZmZm
ICsgMTs8YnI+DQo8YnI+DQpXaHkgbm90IHdyaXRlICYjMzk7NjQgKiBLaUImIzM5Oz88YnI+DQo8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBpZiAoZGVz
Yy0mZ3Q7c2l6ZSAmbHQ7IG51bV9ieXRlcykgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCBudW1fYnl0ZXMgPSBkZXNjLSZndDtzaXplOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB0cmFjZV9hd19oM19zZGhv
c3RfcHJvY2Vzc19kZXNjKGRlc2NfYWRkciwgZGVzYy0mZ3Q7c2l6ZSw8YnI+DQomZ3Q7wqAgwqAg
wqBpc193cml0ZSwgbWF4X2J5dGVzKTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIHdoaWxlIChudW1fZG9uZSAmbHQ7IG51bV9ieXRlcykgezxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCAvKiBUcnkgdG8gY29tcGxldGVseSBmaWxsIHRoZSBsb2NhbCBidWZm
ZXIgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgdWludDMyX3QgYnVmX2J5dGVzID0g
bnVtX2J5dGVzIC0gbnVtX2RvbmU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGlmIChi
dWZfYnl0ZXMgJmd0OyBzaXplb2YoYnVmKSkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCDCoCDCoCBidWZfYnl0ZXMgPSBzaXplb2YoYnVmKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
LyogV3JpdGUgdG8gU0QgYnVzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGlmIChp
c193cml0ZSkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBjcHVfcGh5c2lj
YWxfbWVtb3J5X3JlYWQoKGRlc2MtJmd0O2FkZHIgJmFtcDsgREVTQ19TSVpFX01BU0spPGJyPg0K
Jmd0O8KgIMKgIMKgKyBudW1fZG9uZSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnVmLCBidWZfYnl0ZXMp
Ozxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
Zm9yICh1aW50MzJfdCBpID0gMDsgaSAmbHQ7IGJ1Zl9ieXRlczsgaSsrKSB7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNkYnVzX3dyaXRlX2RhdGEoJmFtcDtzLSZn
dDtzZGJ1cywgYnVmW2ldKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgfTxi
cj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgLyogUmVhZCBm
cm9tIFNEIGJ1cyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCB9IGVsc2Ugezxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBmb3IgKHVpbnQzMl90IGkgPSAwOyBpICZs
dDsgYnVmX2J5dGVzOyBpKyspIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgYnVmW2ldID0gc2RidXNfcmVhZF9kYXRhKCZhbXA7cy0mZ3Q7c2RidXMpOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIMKgIMKgIGNwdV9waHlzaWNhbF9tZW1vcnlfd3JpdGUoKGRlc2MtJmd0O2FkZHIgJmFtcDsg
REVTQ19TSVpFX01BU0spPGJyPg0KJmd0O8KgIMKgIMKgKyBudW1fZG9uZSw8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBidWYsIGJ1Zl9ieXRlcyk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIH08
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgbnVtX2RvbmUgKz0gYnVmX2J5dGVzOzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCAvKiBDbGVhciBob2xkIGZsYWcgYW5kIGZsdXNoIGRlc2NyaXB0b3IgKi88YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgZGVzYy0mZ3Q7c3RhdHVzICZhbXA7PSB+REVTQ19TVEFUVVNfSE9M
RDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY3B1X3BoeXNpY2FsX21lbW9yeV93cml0ZShkZXNj
X2FkZHIsIGRlc2MsIHNpemVvZigqZGVzYykpOzxicj4NCjxicj4NCihSZWxhdGVkIHRvIHByZXZp
b3VzIGVuZGlhbmVzcyBxdWVzdGlvbikuPGJyPg0KPGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCByZXR1cm4gbnVtX2RvbmU7PGJyPg0KJmd0O8KgIMKgIMKgK308YnI+
DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3N0YXRpYyB2b2lkIGF3X2gzX3NkaG9z
dF9kbWEoQXdIM1NESG9zdFN0YXRlICpzKTxicj4NCiZndDvCoCDCoCDCoCt7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIFRyYW5zZmVyRGVzY3JpcHRvciBkZXNjOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCBod2FkZHIgZGVzY19hZGRyID0gcy0mZ3Q7ZGVzY19iYXNlOzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCBib29sIGlzX3dyaXRlID0gKHMtJmd0O2NvbW1hbmQgJmFtcDsgU0RfQ01EUl9XUklU
RSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGJ5dGVzX2RvbmUgPSAwOzxicj4N
CiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLyogQ2hlY2sgaWYgRE1BIGNh
biBiZSBwZXJmb3JtZWQgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgaWYgKHMtJmd0O2J5dGVf
Y291bnQgPT0gMCB8fCBzLSZndDtibG9ja19zaXplID09IDAgfHw8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgIShzLSZndDtnbG9iYWxfY3RsICZhbXA7IFNEX0dDVExfRE1BX0VOQikpIHs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAvKjxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCogRm9yIHJlYWQgb3BlcmF0aW9ucywgZGF0YSBtdXN0IGJlIGF2
YWlsYWJsZSBvbiB0aGUgU0QgYnVzPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgKiBJZiBub3Qs
IGl0IGlzIGFuIGVycm9yIGFuZCB3ZSBzaG91bGQgbm90IGFjdCBhdCBhbGw8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBpZiAoIWlzX3dyaXRlICZh
bXA7JmFtcDsgIXNkYnVzX2RhdGFfcmVhZHkoJmFtcDtzLSZndDtzZGJ1cykpIHs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAvKiBQcm9jZXNzIHRoZSBE
TUEgZGVzY3JpcHRvcnMgdW50aWwgYWxsIGRhdGEgaXMgY29waWVkICovPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIHdoaWxlIChzLSZndDtieXRlX2NvdW50ICZndDsgMCkgezxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCDCoCDCoCBieXRlc19kb25lID0gYXdfaDNfc2Rob3N0X3Byb2Nlc3NfZGVzYyhz
LCBkZXNjX2FkZHIsICZhbXA7ZGVzYyw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
c193cml0ZSw8YnI+DQomZ3Q7wqAgwqAgwqBzLSZndDtieXRlX2NvdW50KTs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3VwZGF0ZV90cmFuc2Zlcl9jbnQocywgYnl0
ZXNfZG9uZSk7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCBpZiAoYnl0ZXNfZG9uZSAmbHQ7PSBzLSZndDtieXRlX2NvdW50KSB7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIMKgIMKgIHMtJmd0O2J5dGVfY291bnQgLT0gYnl0ZXNfZG9uZTs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgwqAgwqAgcy0mZ3Q7Ynl0ZV9jb3VudCA9IDA7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIGlmIChkZXNjLnN0YXR1cyAmYW1wOyBERVNDX1NUQVRVU19MQVNUKSB7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCB9IGVsc2Ugezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCBkZXNjX2Fk
ZHIgPSBkZXNjLm5leHQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIH08YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgLyogUmFpc2UgSVJRIHRvIHNpZ25hbCBETUEgaXMgY29tcGxldGVkICovPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIHMtJmd0O2lycV9zdGF0dXMgfD0gU0RfUklTUl9EQVRBX0NPTVBMRVRFIHwg
U0RfUklTUl9BVVRPQ01EX0RPTkU7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCAvKiBVcGRhdGUgRE1BQyBiaXRzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGlm
IChpc193cml0ZSkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtkbWFjX3N0
YXR1cyB8PSBTRF9JRFNUX1RSQU5TTUlUX0lSUTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfSBl
bHNlIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7ZG1hY19zdGF0dXMgfD0g
KFNEX0lEU1RfU1VNX1JFQ0VJVkVfSVJRIHw8YnI+DQomZ3Q7wqAgwqAgwqBTRF9JRFNUX1JFQ0VJ
VkVfSVJRKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCt9PGJy
Pg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMgdWludDY0X3QgYXdfaDNf
c2Rob3N0X3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgb2Zmc2V0LDxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1bnNp
Z25lZCBzaXplKTxicj4NCiZndDvCoCDCoCDCoCt7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIEF3
SDNTREhvc3RTdGF0ZSAqcyA9IChBd0gzU0RIb3N0U3RhdGUgKilvcGFxdWU7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIHVpbnQzMl90IHJlcyA9IDA7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBzd2l0Y2ggKG9mZnNldCkgezxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCBjYXNlIFJFR19TRF9HQ1RMOsKgIMKgIMKgIC8qIEdsb2JhbCBDb250cm9sICovPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O2dsb2JhbF9jdGw7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJF
R19TRF9DS0NSOsKgIMKgIMKgIC8qIENsb2NrIENvbnRyb2wgKi88YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7Y2xvY2tfY3RsOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfVE1PUjrC
oCDCoCDCoCAvKiBUaW1lb3V0ICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9
IHMtJmd0O3RpbWVvdXQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9CV0RSOsKgIMKgIMKgIC8qIEJ1cyBXaWR0
aCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtidXNfd2lkdGg7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCBjYXNlIFJFR19TRF9CS1NSOsKgIMKgIMKgIC8qIEJsb2NrIFNpemUgKi88YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7YmxvY2tfc2l6ZTs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVH
X1NEX0JZQ1I6wqAgwqAgwqAgLyogQnl0ZSBDb3VudCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCByZXMgPSBzLSZndDtieXRlX2NvdW50Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfQ01EUjrCoCDC
oCDCoCAvKiBDb21tYW5kICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMt
Jmd0O2NvbW1hbmQ7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9DQUdSOsKgIMKgIMKgIC8qIENvbW1hbmQgQXJn
dW1lbnQgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7Y29tbWFu
ZF9hcmc7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBjYXNlIFJFR19TRF9SRVNQMDrCoCDCoCDCoC8qIFJlc3BvbnNlIFplcm8gKi88
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7cmVzcG9uc2VbMF07PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCBjYXNlIFJFR19TRF9SRVNQMTrCoCDCoCDCoC8qIFJlc3BvbnNlIE9uZSAqLzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtyZXNwb25zZVsxXTs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVH
X1NEX1JFU1AyOsKgIMKgIMKgLyogUmVzcG9uc2UgVHdvICovPGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIHJlcyA9IHMtJmd0O3Jlc3BvbnNlWzJdOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfUkVTUDM6
wqAgwqAgwqAvKiBSZXNwb25zZSBUaHJlZSAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCByZXMgPSBzLSZndDtyZXNwb25zZVszXTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
YnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0lNS1I6wqAgwqAgwqAg
LyogSW50ZXJydXB0IE1hc2sgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0g
cy0mZ3Q7aXJxX21hc2s7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9NSVNSOsKgIMKgIMKgIC8qIE1hc2tlZCBJ
bnRlcnJ1cHQgU3RhdHVzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMt
Jmd0O2lycV9zdGF0dXMgJmFtcDsgcy0mZ3Q7aXJxX21hc2s7PGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9SSVNS
OsKgIMKgIMKgIC8qIFJhdyBJbnRlcnJ1cHQgU3RhdHVzICovPGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIHJlcyA9IHMtJmd0O2lycV9zdGF0dXM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9TVEFSOsKg
IMKgIMKgIC8qIFN0YXR1cyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBz
LSZndDtzdGF0dXM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9GV0xSOsKgIMKgIMKgIC8qIEZJRk8gV2F0ZXIg
TGV2ZWwgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7Zmlmb193
bGV2ZWw7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBjYXNlIFJFR19TRF9GVU5TOsKgIMKgIMKgIC8qIEZJRk8gRnVuY3Rpb24gU2Vs
ZWN0ICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O2ZpZm9fZnVu
Y19zZWw7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQkdDOsKgIMKgIMKgIC8qIERlYnVnIEVuYWJsZSAqLzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtkZWJ1Z19lbmFibGU7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCBjYXNlIFJFR19TRF9BMTJBOsKgIMKgIMKgIC8qIEF1dG8gY29tbWFuZCAxMiBhcmd1bWVudCAq
Lzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDthdXRvMTJfYXJnOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfTlRTUjrCoCDCoCDCoCAvKiBTRCBOZXdUaW1pbmcgU2V0ICovPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O25ld3RpbWluZ19zZXQ7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBj
YXNlIFJFR19TRF9TREJHOsKgIMKgIMKgIC8qIFNEIG5ld1RpbWluZyBTZXQgRGVidWcgKi88YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7bmV3dGltaW5nX2RlYnVnOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfSFdSU1Q6wqAgwqAgwqAvKiBIYXJkd2FyZSBSZXNldCBSZWdpc3RlciAq
Lzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtoYXJkd2FyZV9yc3Q7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCBjYXNlIFJFR19TRF9ETUFDOsKgIMKgIMKgIC8qIEludGVybmFsIERNQSBDb250cm9sbGVy
IENvbnRyb2wgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7ZG1h
Yzs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIGNhc2UgUkVHX1NEX0RMQkE6wqAgwqAgwqAgLyogRGVzY3JpcHRvciBMaXN0IEJhc2Ug
QWRkcmVzcyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZndDtkZXNj
X2Jhc2U7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBjYXNlIFJFR19TRF9JRFNUOsKgIMKgIMKgIC8qIEludGVybmFsIERNQSBDb250
cm9sbGVyIFN0YXR1cyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZn
dDtkbWFjX3N0YXR1czs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0lESUU6wqAgwqAgwqAgLyogSW50ZXJuYWwg
RE1BIENvbnRyb2xsZXIgSW50ZXJydXB0PGJyPg0KJmd0O8KgIMKgIMKgRW5hYmxlICovPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O2RtYWNfaXJxOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBS
RUdfU0RfVEhMREM6wqAgwqAgwqAvKiBDYXJkIFRocmVzaG9sZCBDb250cm9sICovPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O2NhcmRfdGhyZXNob2xkOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2Fz
ZSBSRUdfU0RfRFNCRDrCoCDCoCDCoCAvKiBlTU1DIEREUiBTdGFydCBCaXQgRGV0ZWN0aW9uIENv
bnRyb2wgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcmVzID0gcy0mZ3Q7c3RhcnRi
aXRfZGV0ZWN0Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfUkVTX0NSQzrCoCDCoC8qIFJlc3BvbnNlIENSQyBm
cm9tIGNhcmQvZU1NQyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCByZXMgPSBzLSZn
dDtyZXNwb25zZV9jcmM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBN19DUkM6IC8qIENSQyBEYXRhIDcg
ZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfREFU
QTZfQ1JDOiAvKiBDUkMgRGF0YSA2IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIGNhc2UgUkVHX1NEX0RBVEE1X0NSQzogLyogQ1JDIERhdGEgNSBmcm9tIGNhcmQvZU1N
QyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBNF9DUkM6IC8qIENS
QyBEYXRhIDQgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBS
RUdfU0RfREFUQTNfQ1JDOiAvKiBDUkMgRGF0YSAzIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0RBVEEyX0NSQzogLyogQ1JDIERhdGEgMiBmcm9t
IGNhcmQvZU1NQyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBMV9D
UkM6IC8qIENSQyBEYXRhIDEgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfREFUQTBfQ1JDOiAvKiBDUkMgRGF0YSAwIGZyb20gY2FyZC9lTU1DICov
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O2RhdGFfY3JjWygob2Zm
c2V0IC0gUkVHX1NEX0RBVEE3X0NSQykgLzxicj4NCiZndDvCoCDCoCDCoHNpemVvZih1aW50MzJf
dCkpXTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIGNhc2UgUkVHX1NEX0NSQ19TVEE6wqAgwqAvKiBDUkMgc3RhdHVzIGZyb20gY2Fy
ZC9lTU1DIGluIHdyaXRlPGJyPg0KJmd0O8KgIMKgIMKgb3BlcmF0aW9uICovPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IHMtJmd0O3N0YXR1c19jcmM7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19T
RF9GSUZPOsKgIMKgIMKgIC8qIFJlYWQvV3JpdGUgRklGTyAqLzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCBpZiAoc2RidXNfZGF0YV9yZWFkeSgmYW1wO3MtJmd0O3NkYnVzKSkgezxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCByZXMgPSBzZGJ1c19yZWFkX2RhdGEoJmFt
cDtzLSZndDtzZGJ1cyk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIHJlcyB8
PSBzZGJ1c19yZWFkX2RhdGEoJmFtcDtzLSZndDtzZGJ1cykgJmx0OyZsdDsgODs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgcmVzIHw9IHNkYnVzX3JlYWRfZGF0YSgmYW1wO3Mt
Jmd0O3NkYnVzKSAmbHQ7Jmx0OyAxNjs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAg
wqAgcmVzIHw9IHNkYnVzX3JlYWRfZGF0YSgmYW1wO3MtJmd0O3NkYnVzKSAmbHQ7Jmx0OyAyNDs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3VwZGF0ZV90
cmFuc2Zlcl9jbnQocywgc2l6ZW9mKHVpbnQzMl90KSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF9hdXRvX3N0b3Aocyk7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF91cGRhdGVfaXJxKHMpOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCB9IGVsc2Ugezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDC
oCDCoCDCoCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgJnF1b3Q7JXM6IG5vIGRhdGEg
cmVhZHkgb24gU0Q8YnI+DQomZ3Q7wqAgwqAgwqBidXNcbiZxdW90Oyw8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19mdW5jX18pOzxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBkZWZhdWx0Ojxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgJnF1b3Q7JXM6IEJh
ZCBvZmZzZXQ8YnI+DQomZ3Q7wqAgwqAgwqAlJnF1b3Q7SFdBRERSX1BSSXgmcXVvdDtcbiZxdW90
Oyw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19m
dW5jX18sIG9mZnNldCk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHJlcyA9IDA7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCB9PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB0cmFjZV9hd19o
M19zZGhvc3RfcmVhZChvZmZzZXQsIHJlcywgc2l6ZSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IHJldHVybiByZXM7PGJyPg0KJmd0O8KgIMKgIMKgK308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0K
Jmd0O8KgIMKgIMKgK3N0YXRpYyB2b2lkIGF3X2gzX3NkaG9zdF93cml0ZSh2b2lkICpvcGFxdWUs
IGh3YWRkciBvZmZzZXQsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDY0X3QgdmFsdWUsIHVuc2lnbmVkIHNpemUpPGJy
Pg0KJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgQXdIM1NESG9zdFN0YXRl
ICpzID0gKEF3SDNTREhvc3RTdGF0ZSAqKW9wYXF1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIHRyYWNlX2F3X2gzX3NkaG9zdF93cml0ZShvZmZzZXQsIHZhbHVl
LCBzaXplKTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHN3aXRj
aCAob2Zmc2V0KSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0dDVEw6wqAg
wqAgwqAgLyogR2xvYmFsIENvbnRyb2wgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
cy0mZ3Q7Z2xvYmFsX2N0bCA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBz
LSZndDtnbG9iYWxfY3RsICZhbXA7PSB+KFNEX0dDVExfRE1BX1JTVCB8IFNEX0dDVExfRklGT19S
U1QgfDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFNEX0dDVExfU09GVF9SU1QpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBh
d19oM19zZGhvc3RfdXBkYXRlX2lycShzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
YnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0NLQ1I6wqAgwqAgwqAg
LyogQ2xvY2sgQ29udHJvbCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtj
bG9ja19jdGwgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX1RNT1I6wqAgwqAgwqAgLyogVGltZW91
dCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDt0aW1lb3V0ID0gdmFsdWU7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCBjYXNlIFJFR19TRF9CV0RSOsKgIMKgIMKgIC8qIEJ1cyBXaWR0aCAqLzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtidXNfd2lkdGggPSB2YWx1ZTs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVH
X1NEX0JLU1I6wqAgwqAgwqAgLyogQmxvY2sgU2l6ZSAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBzLSZndDtibG9ja19zaXplID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9CWUNSOsKg
IMKgIMKgIC8qIEJ5dGUgQ291bnQgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0m
Z3Q7Ynl0ZV9jb3VudCA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZn
dDt0cmFuc2Zlcl9jbnQgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJl
YWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0NNRFI6wqAgwqAgwqAgLyog
Q29tbWFuZCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtjb21tYW5kID0g
dmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGlmICh2YWx1ZSAmYW1wOyBTRF9D
TURSX0xPQUQpIHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAgYXdfaDNfc2Ro
b3N0X3NlbmRfY29tbWFuZChzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
YXdfaDNfc2Rob3N0X2RtYShzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgwqAgwqAg
YXdfaDNfc2Rob3N0X2F1dG9fc3RvcChzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
fTxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBhd19oM19zZGhvc3RfdXBkYXRlX2lycShz
KTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIGNhc2UgUkVHX1NEX0NBR1I6wqAgwqAgwqAgLyogQ29tbWFuZCBBcmd1bWVudCAqLzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtjb21tYW5kX2FyZyA9IHZhbHVlOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgY2FzZSBSRUdfU0RfUkVTUDA6wqAgwqAgwqAvKiBSZXNwb25zZSBaZXJvICovPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O3Jlc3BvbnNlWzBdID0gdmFsdWU7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNl
IFJFR19TRF9SRVNQMTrCoCDCoCDCoC8qIFJlc3BvbnNlIE9uZSAqLzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBzLSZndDtyZXNwb25zZVsxXSA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0Rf
UkVTUDI6wqAgwqAgwqAvKiBSZXNwb25zZSBUd28gKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgcy0mZ3Q7cmVzcG9uc2VbMl0gPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX1JFU1AzOsKg
IMKgIMKgLyogUmVzcG9uc2UgVGhyZWUgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
cy0mZ3Q7cmVzcG9uc2VbM10gPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
YnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0lNS1I6wqAgwqAgwqAg
LyogSW50ZXJydXB0IE1hc2sgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7
aXJxX21hc2sgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Ro
b3N0X3VwZGF0ZV9pcnEocyk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9NSVNSOsKgIMKgIMKgIC8qIE1hc2tl
ZCBJbnRlcnJ1cHQgU3RhdHVzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NE
X1JJU1I6wqAgwqAgwqAgLyogUmF3IEludGVycnVwdCBTdGF0dXMgKi88YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgcy0mZ3Q7aXJxX3N0YXR1cyAmYW1wOz0gfnZhbHVlOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCBhd19oM19zZGhvc3RfdXBkYXRlX2lycShzKTs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2Ug
UkVHX1NEX1NUQVI6wqAgwqAgwqAgLyogU3RhdHVzICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIHMtJmd0O3N0YXR1cyAmYW1wOz0gfnZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBhd19oM19zZGhvc3RfdXBkYXRlX2lycShzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0ZXTFI6
wqAgwqAgwqAgLyogRklGTyBXYXRlciBMZXZlbCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCBzLSZndDtmaWZvX3dsZXZlbCA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfRlVOUzrCoCDC
oCDCoCAvKiBGSUZPIEZ1bmN0aW9uIFNlbGVjdCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCBzLSZndDtmaWZvX2Z1bmNfc2VsID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQkdDOsKg
IMKgIMKgIC8qIERlYnVnIEVuYWJsZSAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBz
LSZndDtkZWJ1Z19lbmFibGUgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
YnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX0ExMkE6wqAgwqAgwqAg
LyogQXV0byBjb21tYW5kIDEyIGFyZ3VtZW50ICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIHMtJmd0O2F1dG8xMl9hcmcgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAg
wqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVHX1NEX05UU1I6wqAgwqAg
wqAgLyogU0QgTmV3VGltaW5nIFNldCAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBz
LSZndDtuZXd0aW1pbmdfc2V0ID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKg
IGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9TREJHOsKgIMKgIMKg
IC8qIFNEIG5ld1RpbWluZyBTZXQgRGVidWcgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAg
wqAgcy0mZ3Q7bmV3dGltaW5nX2RlYnVnID0gdmFsdWU7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9IV1JTVDrC
oCDCoCDCoC8qIEhhcmR3YXJlIFJlc2V0IFJlZ2lzdGVyICovPGJyPg0KJmd0O8KgIMKgIMKgK8Kg
IMKgIMKgIMKgIHMtJmd0O2hhcmR3YXJlX3JzdCA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCDCoCDCoCBicmVhazs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfRE1B
QzrCoCDCoCDCoCAvKiBJbnRlcm5hbCBETUEgQ29udHJvbGxlciBDb250cm9sICovPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O2RtYWMgPSB2YWx1ZTs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3VwZGF0ZV9pcnEocyk7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19T
RF9ETEJBOsKgIMKgIMKgIC8qIERlc2NyaXB0b3IgTGlzdCBCYXNlIEFkZHJlc3MgKi88YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7ZGVzY19iYXNlID0gdmFsdWU7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNl
IFJFR19TRF9JRFNUOsKgIMKgIMKgIC8qIEludGVybmFsIERNQSBDb250cm9sbGVyIFN0YXR1cyAq
Lzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBzLSZndDtkbWFjX3N0YXR1cyAmYW1wOz0g
KH5TRF9JRFNUX1dSX01BU0spIHwgKH52YWx1ZSAmYW1wOzxicj4NCiZndDvCoCDCoCDCoFNEX0lE
U1RfV1JfTUFTSyk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGF3X2gzX3NkaG9zdF91
cGRhdGVfaXJxKHMpOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfSURJRTrCoCDCoCDCoCAvKiBJbnRlcm5hbCBE
TUEgQ29udHJvbGxlciBJbnRlcnJ1cHQ8YnI+DQomZ3Q7wqAgwqAgwqBFbmFibGUgKi88YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7ZG1hY19pcnEgPSB2YWx1ZTs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Rob3N0X3VwZGF0ZV9pcnEocyk7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNl
IFJFR19TRF9USExEQzrCoCDCoCDCoC8qIENhcmQgVGhyZXNob2xkIENvbnRyb2wgKi88YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7Y2FyZF90aHJlc2hvbGQgPSB2YWx1ZTs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IGNhc2UgUkVHX1NEX0RTQkQ6wqAgwqAgwqAgLyogZU1NQyBERFIgU3RhcnQgQml0IERldGVjdGlv
biBDb250cm9sICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHMtJmd0O3N0YXJ0Yml0
X2RldGVjdCA9IHZhbHVlOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBicmVhazs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfRklGTzrCoCDCoCDCoCAvKiBSZWFkL1dy
aXRlIEZJRk8gKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgc2RidXNfd3JpdGVfZGF0
YSgmYW1wO3MtJmd0O3NkYnVzLCB2YWx1ZSAmYW1wOyAweGZmKTs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgwqAgwqAgc2RidXNfd3JpdGVfZGF0YSgmYW1wO3MtJmd0O3NkYnVzLCAodmFsdWUgJmd0
OyZndDsgOCkgJmFtcDsgMHhmZik7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIHNkYnVz
X3dyaXRlX2RhdGEoJmFtcDtzLSZndDtzZGJ1cywgKHZhbHVlICZndDsmZ3Q7IDE2KSAmYW1wOyAw
eGZmKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgc2RidXNfd3JpdGVfZGF0YSgmYW1w
O3MtJmd0O3NkYnVzLCAodmFsdWUgJmd0OyZndDsgMjQpICZhbXA7IDB4ZmYpOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCBhd19oM19zZGhvc3RfdXBkYXRlX3RyYW5zZmVyX2NudChzLCBz
aXplb2YodWludDMyX3QpKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Ro
b3N0X2F1dG9fc3RvcChzKTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYXdfaDNfc2Ro
b3N0X3VwZGF0ZV9pcnEocyk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIGJyZWFrOzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9SRVNfQ1JDOsKgIMKgLyogUmVzcG9u
c2UgQ1JDIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGNhc2UgUkVH
X1NEX0RBVEE3X0NSQzogLyogQ1JDIERhdGEgNyBmcm9tIGNhcmQvZU1NQyAqLzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBNl9DUkM6IC8qIENSQyBEYXRhIDYgZnJvbSBj
YXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0RfREFUQTVfQ1JD
OiAvKiBDUkMgRGF0YSA1IGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IGNhc2UgUkVHX1NEX0RBVEE0X0NSQzogLyogQ1JDIERhdGEgNCBmcm9tIGNhcmQvZU1NQyAqLzxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBM19DUkM6IC8qIENSQyBEYXRh
IDMgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2FzZSBSRUdfU0Rf
REFUQTJfQ1JDOiAvKiBDUkMgRGF0YSAyIGZyb20gY2FyZC9lTU1DICovPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIGNhc2UgUkVHX1NEX0RBVEExX0NSQzogLyogQ1JDIERhdGEgMSBmcm9tIGNhcmQv
ZU1NQyAqLzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBjYXNlIFJFR19TRF9EQVRBMF9DUkM6IC8q
IENSQyBEYXRhIDAgZnJvbSBjYXJkL2VNTUMgKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgY2Fz
ZSBSRUdfU0RfQ1JDX1NUQTrCoCDCoC8qIENSQyBzdGF0dXMgZnJvbSBjYXJkL2VNTUMgaW4gd3Jp
dGU8YnI+DQomZ3Q7wqAgwqAgwqBvcGVyYXRpb24gKi88YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgYnJlYWs7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIGRlZmF1bHQ6PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAmcXVvdDsl
czogQmFkIG9mZnNldDxicj4NCiZndDvCoCDCoCDCoCUmcXVvdDtIV0FERFJfUFJJeCZxdW90O1xu
JnF1b3Q7LDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBfX2Z1bmNfXywgb2Zmc2V0KTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgYnJlYWs7
PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIH08YnI+DQomZ3Q7wqAgwqAgwqArfTxicj4NCiZndDvC
oCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyBh
d19oM19zZGhvc3Rfb3BzID0gezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAucmVhZCA9IGF3X2gz
X3NkaG9zdF9yZWFkLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAud3JpdGUgPSBhd19oM19zZGhv
c3Rfd3JpdGUsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC5lbmRpYW5uZXNzID0gREVWSUNFX05B
VElWRV9FTkRJQU4sPGJyPg0KPGJyPg0KSSBoYXZlbiYjMzk7dCBjaGVja2VkIC52YWxpZCBhY2Nl
c3NlcyBmcm9tIHRoZSBkYXRhc2hlZXQuPGJyPg0KPGJyPg0KSG93ZXZlciBkdWUgdG86PGJyPg0K
PGJyPg0KwqAgwqByZXMgPSBzLSZndDtkYXRhX2NyY1soKG9mZnNldCAtIFJFR19TRF9EQVRBN19D
UkMpIC8gc2l6ZW9mKHVpbnQzMl90KSldOzxicj4NCjxicj4NCllvdSBzZWVtIHRvIGV4cGVjdDo8
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCAuaW1wbC5taW5fYWNjZXNzX3NpemUgPSA0LDxi
cj4NCjxicj4NCi5pbXBsLm1heF9hY2Nlc3Nfc2l6ZSB1bnNldCBpcyA4LCB3aGljaCBzaG91bGQg
d29ya3MuPGJyPg0KPGJyPjwvYmxvY2txdW90ZT48ZGl2Pkl0IHNlZW1zIHRoYXQgYWxsIHJlZ2lz
dGVycyBhcmUgYWxpZ25lZCBvbiBhdCBsZWFzdCAzMi1iaXQgYm91bmRhcmllcy4gQW5kIHRoZSBz
ZWN0aW9uIDUuMy41LjEgbWVudGlvbnM8L2Rpdj48ZGl2PnRoYXQgdGhlIERNQSBkZXNjcmlwdG9y
cyBtdXN0IGJlIHN0b3JlZCBpbiBtZW1vcnkgMzItYml0IGFsaWduZWQuIFNvIGJhc2VkIG9uIHRo
YXQgaW5mb3JtYXRpb24sPC9kaXY+PGRpdj5JIHRoaW5rIDMyLWJpdCBpcyBhIHNhZmUgY2hvaWNl
LiBJJiMzOTt2ZSB2ZXJpZmllZCB0aGlzIHdpdGggTGludXggbWFpbmxpbmUgYW5kIFUtQm9vdCBk
cml2ZXJzIGFuZCBib3RoIGFyZSBzdGlsbCB3b3JraW5nLjxicj48L2Rpdj48ZGl2PsKgPC9kaXY+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVm
dDoxZXgiPg0KJmd0O8KgIMKgIMKgK307PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDC
oCDCoCtzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfYXdfaDNfc2Rob3N0
ID0gezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAubmFtZSA9IFRZUEVfQVdfSDNfU0RIT1NULDxi
cj4NCjxicj4NCkRvIG5vdCB1c2UgVFlQRSBuYW1lIGluIFZNU3RhdGVEZXNjcmlwdGlvbi5uYW1l
LCBiZWNhdXNlIHdlIG1pZ2h0IGNoYW5nZSA8YnI+DQp0aGUgdmFsdWUgb2YgVFlQRSwgYnV0IHRo
ZSBtaWdyYXRpb24gc3RhdGUgaGFzIHRvIGtlZXAgdGhlIHNhbWUgbmFtZS48YnI+DQo8YnI+PC9i
bG9ja3F1b3RlPjxkaXY+T0sgdGhhbmtzLCBJIHdpbGwgbWFrZSB0aGF0IGNoYW5nZXMgaW4gdGhl
IG90aGVyIGNvbW1pdHMgYXMgd2VsbC48YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCiZn
dDvCoCDCoCDCoCvCoCDCoCAudmVyc2lvbl9pZCA9IDEsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IC5taW5pbXVtX3ZlcnNpb25faWQgPSAxLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAuZmllbGRz
ID0gKFZNU3RhdGVGaWVsZFtdKSB7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RB
VEVfVUlOVDMyKGdsb2JhbF9jdGwsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGNsb2NrX2N0bCwgQXdIM1NESG9zdFN0YXRlKSw8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzIodGltZW91dCwgQXdI
M1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5U
MzIoYnVzX3dpZHRoLCBBd0gzU0RIb3N0U3RhdGUpLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCBWTVNUQVRFX1VJTlQzMihibG9ja19zaXplLCBBd0gzU0RIb3N0U3RhdGUpLDxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihieXRlX2NvdW50LCBBd0gzU0RI
b3N0U3RhdGUpLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMih0
cmFuc2Zlcl9jbnQsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKg
IMKgIFZNU1RBVEVfVUlOVDMyKGNvbW1hbmQsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGNvbW1hbmRfYXJnLCBBd0gzU0RIb3N0
U3RhdGUpLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMl9BUlJB
WShyZXNwb25zZSwgQXdIM1NESG9zdFN0YXRlLCA0KSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
wqAgwqAgVk1TVEFURV9VSU5UMzIoaXJxX21hc2ssIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGlycV9zdGF0dXMsIEF3SDNTREhv
c3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKHN0
YXR1cywgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1T
VEFURV9VSU5UMzIoZmlmb193bGV2ZWwsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGZpZm9fZnVuY19zZWwsIEF3SDNTREhvc3RT
dGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGRlYnVn
X2VuYWJsZSwgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAg
Vk1TVEFURV9VSU5UMzIoYXV0bzEyX2FyZywgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzIobmV3dGltaW5nX3NldCwgQXdIM1NESG9z
dFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1TVEFURV9VSU5UMzIobmV3
dGltaW5nX2RlYnVnLCBBd0gzU0RIb3N0U3RhdGUpLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDC
oCDCoCBWTVNUQVRFX1VJTlQzMihoYXJkd2FyZV9yc3QsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0K
Jmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGRtYWMsIEF3SDNTREhvc3RT
dGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGRlc2Nf
YmFzZSwgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1T
VEFURV9VSU5UMzIoZG1hY19zdGF0dXMsIEF3SDNTREhvc3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyKGRtYWNfaXJxLCBBd0gzU0RIb3N0U3RhdGUp
LDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihjYXJkX3RocmVz
aG9sZCwgQXdIM1NESG9zdFN0YXRlKSw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgVk1T
VEFURV9VSU5UMzIoc3RhcnRiaXRfZGV0ZWN0LCBBd0gzU0RIb3N0U3RhdGUpLDxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX1VJTlQzMihyZXNwb25zZV9jcmMsIEF3SDNTREhv
c3RTdGF0ZSksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIFZNU1RBVEVfVUlOVDMyX0FS
UkFZKGRhdGFfY3JjLCBBd0gzU0RIb3N0U3RhdGUsIDgpLDxicj4NCiZndDvCoCDCoCDCoCvCoCDC
oCDCoCDCoCBWTVNUQVRFX1VJTlQzMihzdGF0dXNfY3JjLCBBd0gzU0RIb3N0U3RhdGUpLDxicj4N
CiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCBWTVNUQVRFX0VORF9PRl9MSVNUKCk8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCt9Ozxicj4NCiZndDvCoCDCoCDCoCs8
YnI+DQomZ3Q7wqAgwqAgwqArc3RhdGljIHZvaWQgYXdfaDNfc2Rob3N0X2luaXQoT2JqZWN0ICpv
YmopPGJyPg0KJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgQXdIM1NESG9z
dFN0YXRlICpzID0gQVdfSDNfU0RIT1NUKG9iaik7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCBxYnVzX2NyZWF0ZV9pbnBsYWNlKCZhbXA7cy0mZ3Q7c2RidXMsIHNp
emVvZihzLSZndDtzZGJ1cyksPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFRZUEVfQVdfSDNfU0RIT1NUX0JVUywgREVWSUNFKHMpLCAmcXVvdDtz
ZC1idXMmcXVvdDspOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
bWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZhbXA7cy0mZ3Q7aW9tZW0sIG9iaiwgJmFtcDthd19oM19z
ZGhvc3Rfb3BzLCBzLDxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBUWVBFX0FXX0gzX1NESE9TVCw8YnI+DQomZ3Q7wqAgwqAgwqBBV19IM19T
REhPU1RfUkVHU19NRU1fU0laRSk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHN5c2J1c19pbml0
X21taW8oU1lTX0JVU19ERVZJQ0UocyksICZhbXA7cy0mZ3Q7aW9tZW0pOzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBzeXNidXNfaW5pdF9pcnEoU1lTX0JVU19ERVZJQ0UocyksICZhbXA7cy0mZ3Q7
aXJxKTs8YnI+DQomZ3Q7wqAgwqAgwqArfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAg
wqAgwqArc3RhdGljIHZvaWQgYXdfaDNfc2Rob3N0X3Jlc2V0KERldmljZVN0YXRlICpkZXYpPGJy
Pg0KJmd0O8KgIMKgIMKgK3s8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgQXdIM1NESG9zdFN0YXRl
ICpzID0gQVdfSDNfU0RIT1NUKGRldik7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDC
oCDCoCvCoCDCoCBzLSZndDtnbG9iYWxfY3RsID0gUkVHX1NEX0dDVExfUlNUOzxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCBzLSZndDtjbG9ja19jdGwgPSBSRUdfU0RfQ0tDUl9SU1Q7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIHMtJmd0O3RpbWVvdXQgPSBSRUdfU0RfVE1PUl9SU1Q7PGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2J1c193aWR0aCA9IFJFR19TRF9CV0RSX1JTVDs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7YmxvY2tfc2l6ZSA9IFJFR19TRF9CS1NSX1JTVDs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7Ynl0ZV9jb3VudCA9IFJFR19TRF9CWUNSX1JTVDs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7dHJhbnNmZXJfY250ID0gMDs8YnI+DQomZ3Q7
wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2NvbW1hbmQgPSBSRUdfU0Rf
Q01EUl9SU1Q7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2NvbW1hbmRfYXJnID0gUkVH
X1NEX0NBR1JfUlNUOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAg
Zm9yIChpbnQgaSA9IDA7IGkgJmx0OyBzaXplb2Yocy0mZ3Q7cmVzcG9uc2UpIC88YnI+DQomZ3Q7
wqAgwqAgwqBzaXplb2Yocy0mZ3Q7cmVzcG9uc2VbMF0pOyBpKyspIHs8YnI+DQo8YnI+DQpQbGVh
c2UgdXNlIEFSUkFZX1NJWkUocy0mZ3Q7cmVzcG9uc2UpLjxicj4NCjxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCDCoCDCoCBzLSZndDtyZXNwb25zZVtpXSA9IFJFR19TRF9SRVNQX1JTVDs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgcy0mZ3Q7aXJxX21hc2sgPSBSRUdfU0RfSU1LUl9SU1Q7PGJyPg0KJmd0O8KgIMKgIMKg
K8KgIMKgIHMtJmd0O2lycV9zdGF0dXMgPSBSRUdfU0RfUklTUl9SU1Q7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIHMtJmd0O3N0YXR1cyA9IFJFR19TRF9TVEFSX1JTVDs8YnI+DQomZ3Q7wqAgwqAg
wqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2ZpZm9fd2xldmVsID0gUkVHX1NEX0ZX
TFJfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtmaWZvX2Z1bmNfc2VsID0gUkVH
X1NEX0ZVTlNfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtkZWJ1Z19lbmFibGUg
PSBSRUdfU0RfREJHQ19SU1Q7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O2F1dG8xMl9h
cmcgPSBSRUdfU0RfQTEyQV9SU1Q7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0O25ld3Rp
bWluZ19zZXQgPSBSRUdfU0RfTlRTUl9SU1Q7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHMtJmd0
O25ld3RpbWluZ19kZWJ1ZyA9IFJFR19TRF9TREJHX1JTVDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgcy0mZ3Q7aGFyZHdhcmVfcnN0ID0gUkVHX1NEX0hXUlNUX1JTVDs8YnI+DQomZ3Q7wqAgwqAg
wqArwqAgwqAgcy0mZ3Q7ZG1hYyA9IFJFR19TRF9ETUFDX1JTVDs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgcy0mZ3Q7ZGVzY19iYXNlID0gUkVHX1NEX0RMQkFfUlNUOzxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCBzLSZndDtkbWFjX3N0YXR1cyA9IFJFR19TRF9JRFNUX1JTVDs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgcy0mZ3Q7ZG1hY19pcnEgPSBSRUdfU0RfSURJRV9SU1Q7PGJyPg0KJmd0O8Kg
IMKgIMKgK8KgIMKgIHMtJmd0O2NhcmRfdGhyZXNob2xkID0gUkVHX1NEX1RITERDX1JTVDs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgcy0mZ3Q7c3RhcnRiaXRfZGV0ZWN0ID0gUkVHX1NEX0RTQkRf
UlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtyZXNwb25zZV9jcmMgPSBSRUdfU0Rf
UkVTX0NSQ19SU1Q7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBm
b3IgKGludCBpID0gMDsgaSAmbHQ7IHNpemVvZihzLSZndDtkYXRhX2NyYykgLzxicj4NCiZndDvC
oCDCoCDCoHNpemVvZihzLSZndDtkYXRhX2NyY1swXSk7IGkrKykgezxicj4NCjxicj4NCkFSUkFZ
X1NJWkU8YnI+DQo8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgwqAgwqAgcy0mZ3Q7ZGF0YV9jcmNb
aV0gPSBSRUdfU0RfREFUQV9DUkNfUlNUOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB9PGJyPg0K
Jmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzLSZndDtzdGF0dXNfY3JjID0g
UkVHX1NEX0NSQ19TVEFfUlNUOzxicj4NCiZndDvCoCDCoCDCoCt9PGJyPg0KJmd0O8KgIMKgIMKg
Kzxicj4NCiZndDvCoCDCoCDCoCtzdGF0aWMgdm9pZCBhd19oM19zZGhvc3RfYnVzX2NsYXNzX2lu
aXQoT2JqZWN0Q2xhc3MgKmtsYXNzLCB2b2lkICpkYXRhKTxicj4NCiZndDvCoCDCoCDCoCt7PGJy
Pg0KJmd0O8KgIMKgIMKgK8KgIMKgIFNEQnVzQ2xhc3MgKnNiYyA9IFNEX0JVU19DTEFTUyhrbGFz
cyk7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBzYmMtJmd0O3Nl
dF9pbnNlcnRlZCA9IGF3X2gzX3NkaG9zdF9zZXRfaW5zZXJ0ZWQ7PGJyPg0KJmd0O8KgIMKgIMKg
K308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3N0YXRpYyB2b2lkIGF3X2gz
X3NkaG9zdF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSk8YnI+DQom
Z3Q7wqAgwqAgwqArezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCBEZXZpY2VDbGFzcyAqZGMgPSBE
RVZJQ0VfQ0xBU1Moa2xhc3MpOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgZGMtJmd0O3Jlc2V0ID0gYXdfaDNfc2Rob3N0X3Jlc2V0Ozxicj4NCiZndDvCoCDCoCDC
oCvCoCDCoCBkYy0mZ3Q7dm1zZCA9ICZhbXA7dm1zdGF0ZV9hd19oM19zZGhvc3Q7PGJyPg0KJmd0
O8KgIMKgIMKgK308YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3N0YXRpYyBU
eXBlSW5mbyBhd19oM19zZGhvc3RfaW5mbyA9IHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLm5h
bWXCoCDCoCDCoCDCoCDCoCA9IFRZUEVfQVdfSDNfU0RIT1NULDxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCAucGFyZW50wqAgwqAgwqAgwqAgPSBUWVBFX1NZU19CVVNfREVWSUNFLDxicj4NCiZndDvC
oCDCoCDCoCvCoCDCoCAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihBd0gzU0RIb3N0U3RhdGUpLDxi
cj4NCiZndDvCoCDCoCDCoCvCoCDCoCAuY2xhc3NfaW5pdMKgIMKgID0gYXdfaDNfc2Rob3N0X2Ns
YXNzX2luaXQsPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIC5pbnN0YW5jZV9pbml0ID0gYXdfaDNf
c2Rob3N0X2luaXQsPGJyPg0KJmd0O8KgIMKgIMKgK307PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4N
CiZndDvCoCDCoCDCoCtzdGF0aWMgY29uc3QgVHlwZUluZm8gYXdfaDNfc2Rob3N0X2J1c19pbmZv
ID0gezxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCAubmFtZSA9IFRZUEVfQVdfSDNfU0RIT1NUX0JV
Uyw8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgLnBhcmVudCA9IFRZUEVfU0RfQlVTLDxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihTREJ1cyksPGJyPg0KJmd0
O8KgIMKgIMKgK8KgIMKgIC5jbGFzc19pbml0ID0gYXdfaDNfc2Rob3N0X2J1c19jbGFzc19pbml0
LDxicj4NCiZndDvCoCDCoCDCoCt9Ozxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAg
wqArc3RhdGljIHZvaWQgYXdfaDNfc2Rob3N0X3JlZ2lzdGVyX3R5cGVzKHZvaWQpPGJyPg0KJmd0
O8KgIMKgIMKgK3s8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMo
JmFtcDthd19oM19zZGhvc3RfaW5mbyk7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHR5cGVfcmVn
aXN0ZXJfc3RhdGljKCZhbXA7YXdfaDNfc2Rob3N0X2J1c19pbmZvKTs8YnI+DQomZ3Q7wqAgwqAg
wqArfTxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqArdHlwZV9pbml0KGF3X2gz
X3NkaG9zdF9yZWdpc3Rlcl90eXBlcyk8YnI+DQomZ3Q7wqAgwqAgwqBkaWZmIC0tZ2l0IGEvaHcv
c2QvdHJhY2UtZXZlbnRzIGIvaHcvc2QvdHJhY2UtZXZlbnRzPGJyPg0KJmd0O8KgIMKgIMKgaW5k
ZXggZWZjZmY2NjZhMi4uYzY3MmEyMDFiNSAxMDA2NDQ8YnI+DQomZ3Q7wqAgwqAgwqAtLS0gYS9o
dy9zZC90cmFjZS1ldmVudHM8YnI+DQomZ3Q7wqAgwqAgwqArKysgYi9ody9zZC90cmFjZS1ldmVu
dHM8YnI+DQomZ3Q7wqAgwqAgwqBAQCAtMSw1ICsxLDEyIEBAPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IyBTZWUgZG9jcy9kZXZlbC90cmFjaW5nLnR4dCBmb3Igc3ludGF4IGRvY3VtZW50YXRpb24uPGJy
Pg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqArIyBhbGx3aW5uZXItaDMtc2Rob3N0LmM8YnI+DQom
Z3Q7wqAgwqAgwqArYXdfaDNfc2Rob3N0X3NldF9pbnNlcnRlZChib29sIGluc2VydGVkKSAmcXVv
dDtpbnNlcnRlZCAldSZxdW90Ozxicj4NCiZndDvCoCDCoCDCoCthd19oM19zZGhvc3RfcHJvY2Vz
c19kZXNjKHVpbnQ2NF90IGRlc2NfYWRkciwgdWludDMyX3QgZGVzY19zaXplLDxicj4NCiZndDvC
oCDCoCDCoGJvb2wgaXNfd3JpdGUsIHVpbnQzMl90IG1heF9ieXRlcykgJnF1b3Q7ZGVzY19hZGRy
IDB4JSZxdW90OyBQUkl4NjQgJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgZGVzY19zaXplICV1IGlz
X3dyaXRlICV1IG1heF9ieXRlcyAldSZxdW90Ozxicj4NCjxicj4NClBsZWFzZSBhbHNvIHVzZSBQ
Ukl1MzIgZm9yIGRlc2Nfc2l6ZS9tYXhfYnl0ZXMuPGJyPg0KPGJyPjwvYmxvY2txdW90ZT48ZGl2
PkRvbmUuIEkmIzM5O2xsIGFsc28gdXNlIFBSSXUzMiAvIFBSSXgzMiBpbiB0aGUgb3RoZXIgY29t
bWl0cyB0aGF0IGhhdmUgdHJhY2UtZXZlbnRzIGNoYW5nZXMuPGJyPjwvZGl2PjxkaXY+wqA8L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAw
cHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1s
ZWZ0OjFleCI+DQomZ3Q7wqAgwqAgwqArYXdfaDNfc2Rob3N0X3JlYWQodWludDY0X3Qgb2Zmc2V0
LCB1aW50NjRfdCBkYXRhLCB1bnNpZ25lZCBzaXplKTxicj4NCiZndDvCoCDCoCDCoCZxdW90O29m
ZnNldCAweCUmcXVvdDsgUFJJeDY0ICZxdW90OyBkYXRhIDB4JSZxdW90OyBQUkl4NjQgJnF1b3Q7
IHNpemUgJXUmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqArYXdfaDNfc2Rob3N0X3dyaXRlKHVpbnQ2
NF90IG9mZnNldCwgdWludDY0X3QgZGF0YSwgdW5zaWduZWQgc2l6ZSk8YnI+DQomZ3Q7wqAgwqAg
wqAmcXVvdDtvZmZzZXQgMHglJnF1b3Q7IFBSSXg2NCAmcXVvdDsgZGF0YSAweCUmcXVvdDsgUFJJ
eDY0ICZxdW90OyBzaXplICV1JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgK2F3X2gzX3NkaG9zdF91
cGRhdGVfaXJxKHVpbnQzMl90IGlycSkgJnF1b3Q7SVJRIGJpdHMgMHgleCZxdW90Ozxicj4NCjxi
cj4NClBSSXgzMiA8YnI+PC9ibG9ja3F1b3RlPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQg
cmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCjxicj4NCiZndDvCoCDCoCDCoCs8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAjIGJjbTI4MzVfc2Rob3N0LmM8YnI+DQomZ3Q7wqAgwqAgwqAg
wqBiY20yODM1X3NkaG9zdF9yZWFkKHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3QgZGF0YSwgdW5z
aWduZWQgc2l6ZSk8YnI+DQomZ3Q7wqAgwqAgwqAmcXVvdDtvZmZzZXQgMHglJnF1b3Q7IFBSSXg2
NCAmcXVvdDsgZGF0YSAweCUmcXVvdDsgUFJJeDY0ICZxdW90OyBzaXplICV1JnF1b3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgIMKgYmNtMjgzNV9zZGhvc3Rfd3JpdGUodWludDY0X3Qgb2Zmc2V0LCB1aW50
NjRfdCBkYXRhLCB1bnNpZ25lZDxicj4NCiZndDvCoCDCoCDCoHNpemUpICZxdW90O29mZnNldCAw
eCUmcXVvdDsgUFJJeDY0ICZxdW90OyBkYXRhIDB4JSZxdW90OyBQUkl4NjQgJnF1b3Q7IHNpemUg
JXUmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9hcm0vYWxs
d2lubmVyLWgzLmg8YnI+DQomZ3Q7wqAgwqAgwqBiL2luY2x1ZGUvaHcvYXJtL2FsbHdpbm5lci1o
My5oPGJyPg0KJmd0O8KgIMKgIMKgaW5kZXggMzM2MDI1OTllYi4uN2FmZjRlYmJkMiAxMDA2NDQ8
YnI+DQomZ3Q7wqAgwqAgwqAtLS0gYS9pbmNsdWRlL2h3L2FybS9hbGx3aW5uZXItaDMuaDxicj4N
CiZndDvCoCDCoCDCoCsrKyBiL2luY2x1ZGUvaHcvYXJtL2FsbHdpbm5lci1oMy5oPGJyPg0KJmd0
O8KgIMKgIMKgQEAgLTMwLDYgKzMwLDcgQEA8YnI+DQomZ3Q7wqAgwqAgwqAgwqAjaW5jbHVkZSAm
cXVvdDtody9taXNjL2FsbHdpbm5lci1oMy1jcHVjZmcuaCZxdW90Ozxicj4NCiZndDvCoCDCoCDC
oCDCoCNpbmNsdWRlICZxdW90O2h3L21pc2MvYWxsd2lubmVyLWgzLXN5c2Nvbi5oJnF1b3Q7PGJy
Pg0KJmd0O8KgIMKgIMKgIMKgI2luY2x1ZGUgJnF1b3Q7aHcvbWlzYy9hbGx3aW5uZXItaDMtc2lk
LmgmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqArI2luY2x1ZGUgJnF1b3Q7aHcvc2QvYWxsd2lubmVy
LWgzLXNkaG9zdC5oJnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgIMKgI2luY2x1ZGUgJnF1b3Q7dGFy
Z2V0L2FybS9jcHUuaCZxdW90Ozxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgIMKgI2RlZmlu
ZSBBV19IM19TUkFNX0ExX0JBU0XCoCDCoCDCoCgweDAwMDAwMDAwKTxicj4NCiZndDvCoCDCoCDC
oEBAIC0xMTcsNiArMTE4LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgQXdIM1N0YXRlIHs8YnI+DQomZ3Q7
wqAgwqAgwqAgwqAgwqAgwqBBd0gzQ3B1Q2ZnU3RhdGUgY3B1Y2ZnOzxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoEF3SDNTeXNjb25TdGF0ZSBzeXNjb247PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKg
IMKgQXdIM1NpZFN0YXRlIHNpZDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgQXdIM1NESG9zdFN0
YXRlIG1tYzA7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgR0lDU3RhdGUgZ2ljOzxicj4NCiZn
dDvCoCDCoCDCoCDCoCDCoCDCoE1lbW9yeVJlZ2lvbiBzcmFtX2ExOzxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoE1lbW9yeVJlZ2lvbiBzcmFtX2EyOzxicj4NCiZndDvCoCDCoCDCoGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L3NkL2FsbHdpbm5lci1oMy1zZGhvc3QuaDxicj4NCiZndDvCoCDCoCDC
oGIvaW5jbHVkZS9ody9zZC9hbGx3aW5uZXItaDMtc2Rob3N0Lmg8YnI+DQomZ3Q7wqAgwqAgwqBu
ZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4NCiZndDvCoCDCoCDCoGluZGV4IDAwMDAwMDAwMDAuLjZj
ODk4YTNjODQ8YnI+DQomZ3Q7wqAgwqAgwqAtLS0gL2Rldi9udWxsPGJyPg0KJmd0O8KgIMKgIMKg
KysrIGIvaW5jbHVkZS9ody9zZC9hbGx3aW5uZXItaDMtc2Rob3N0Lmg8YnI+DQomZ3Q7wqAgwqAg
wqBAQCAtMCwwICsxLDczIEBAPGJyPg0KJmd0O8KgIMKgIMKgKy8qPGJyPg0KJmd0O8KgIMKgIMKg
KyAqIEFsbHdpbm5lciBIMyBTRCBIb3N0IENvbnRyb2xsZXIgZW11bGF0aW9uPGJyPg0KJmd0O8Kg
IMKgIMKgKyAqPGJyPg0KJmd0O8KgIMKgIMKgKyAqIENvcHlyaWdodCAoQykgMjAxOSBOaWVrIExp
bm5lbmJhbmsgJmx0OzxhIGhyZWY9Im1haWx0bzpuaWVrbGlubmVuYmFua0BnbWFpbC5jb20iIHRh
cmdldD0iX2JsYW5rIj5uaWVrbGlubmVuYmFua0BnbWFpbC5jb208L2E+PGJyPg0KJmd0O8KgIMKg
IMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWlsdG86bmlla2xpbm5lbmJhbmtAZ21haWwuY29tIiB0
YXJnZXQ9Il9ibGFuayI+bmlla2xpbm5lbmJhbmtAZ21haWwuY29tPC9hPiZndDsmZ3Q7PGJyPg0K
Jmd0O8KgIMKgIMKgKyAqPGJyPg0KJmd0O8KgIMKgIMKgKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVl
IHNvZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5PGJyPg0KJmd0
O8KgIMKgIMKgKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5PGJyPg0KJmd0O8KgIMKgIMKgKyAqIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb24sIGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yPGJy
Pg0KJmd0O8KgIMKgIMKgKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uPGJy
Pg0KJmd0O8KgIMKgIMKgKyAqPGJyPg0KJmd0O8KgIMKgIMKgKyAqIFRoaXMgcHJvZ3JhbSBpcyBk
aXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLDxicj4NCiZndDvC
oCDCoCDCoCsgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1w
bGllZCB3YXJyYW50eSBvZjxicj4NCiZndDvCoCDCoCDCoCsgKiBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuwqAgU2VlIHRoZTxicj4NCiZndDvCoCDC
oCDCoCsgKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLjxicj4N
CiZndDvCoCDCoCDCoCsgKjxicj4NCiZndDvCoCDCoCDCoCsgKiBZb3Ugc2hvdWxkIGhhdmUgcmVj
ZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZTxicj4NCiZndDvC
oCDCoCDCoCsgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbS7CoCBJZiBub3QsIHNlZTxicj4NCiZn
dDvCoCDCoCDCoCZsdDs8YSBocmVmPSJodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvIiByZWw9
Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMv
PC9hPiZndDsuPGJyPg0KJmd0O8KgIMKgIMKgKyAqLzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQom
Z3Q7wqAgwqAgwqArI2lmbmRlZiBBTExXSU5ORVJfSDNfU0RIT1NUX0g8YnI+DQomZ3Q7wqAgwqAg
wqArI2RlZmluZSBBTExXSU5ORVJfSDNfU0RIT1NUX0g8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0K
Jmd0O8KgIMKgIMKgKyNpbmNsdWRlICZxdW90O2h3L3N5c2J1cy5oJnF1b3Q7PGJyPg0KJmd0O8Kg
IMKgIMKgKyNpbmNsdWRlICZxdW90O2h3L3NkL3NkLmgmcXVvdDs8YnI+DQomZ3Q7wqAgwqAgwqAr
PGJyPg0KJmd0O8KgIMKgIMKgKyNkZWZpbmUgQVdfSDNfU0RIT1NUX1JFR1NfTUVNX1NJWkXCoCAo
MTAyNCk8YnI+DQo8YnI+DQpNb3ZlIHRoaXMgZGVmaW5pdGlvbiB0byB0aGUgc291cmNlIGZpbGUu
PGJyPg0KPGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCsjZGVmaW5lIFRZUEVf
QVdfSDNfU0RIT1NUICZxdW90O2FsbHdpbm5lci1oMy1zZGhvc3QmcXVvdDs8YnI+DQomZ3Q7wqAg
wqAgwqArI2RlZmluZSBBV19IM19TREhPU1Qob2JqKSBcPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IMKgIMKgIE9CSkVDVF9DSEVDSyhBd0gzU0RIb3N0U3RhdGUsIChvYmopLCBUWVBFX0FXX0gzX1NE
SE9TVCk8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK3R5cGVkZWYgc3RydWN0
IHs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgU3lzQnVzRGV2aWNlIGJ1c2Rldjs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgU0RCdXMgc2RidXM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIE1lbW9y
eVJlZ2lvbiBpb21lbTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKg
IHVpbnQzMl90IGdsb2JhbF9jdGw7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGNs
b2NrX2N0bDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgdGltZW91dDs8YnI+DQom
Z3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgYnVzX3dpZHRoOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCB1aW50MzJfdCBibG9ja19zaXplOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJf
dCBieXRlX2NvdW50Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCB0cmFuc2Zlcl9j
bnQ7PGJyPg0KJmd0O8KgIMKgIMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBj
b21tYW5kOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBjb21tYW5kX2FyZzs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgcmVzcG9uc2VbNF07PGJyPg0KJmd0O8KgIMKg
IMKgKzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBpcnFfbWFzazs8YnI+DQomZ3Q7
wqAgwqAgwqArwqAgwqAgdWludDMyX3QgaXJxX3N0YXR1czs8YnI+DQomZ3Q7wqAgwqAgwqArwqAg
wqAgdWludDMyX3Qgc3RhdHVzOzxicj4NCiZndDvCoCDCoCDCoCs8YnI+DQomZ3Q7wqAgwqAgwqAr
wqAgwqAgdWludDMyX3QgZmlmb193bGV2ZWw7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQz
Ml90IGZpZm9fZnVuY19zZWw7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGRlYnVn
X2VuYWJsZTs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgYXV0bzEyX2FyZzs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgbmV3dGltaW5nX3NldDs8YnI+DQomZ3Q7wqAg
wqAgwqArwqAgwqAgdWludDMyX3QgbmV3dGltaW5nX2RlYnVnOzxicj4NCiZndDvCoCDCoCDCoCvC
oCDCoCB1aW50MzJfdCBoYXJkd2FyZV9yc3Q7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQz
Ml90IGRtYWM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGRlc2NfYmFzZTs8YnI+
DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3QgZG1hY19zdGF0dXM7PGJyPg0KJmd0O8KgIMKg
IMKgK8KgIMKgIHVpbnQzMl90IGRtYWNfaXJxOzxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50
MzJfdCBjYXJkX3RocmVzaG9sZDs8YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgdWludDMyX3Qgc3Rh
cnRiaXRfZGV0ZWN0Ozxicj4NCiZndDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCByZXNwb25zZV9j
cmM7PGJyPg0KJmd0O8KgIMKgIMKgK8KgIMKgIHVpbnQzMl90IGRhdGFfY3JjWzhdOzxicj4NCiZn
dDvCoCDCoCDCoCvCoCDCoCB1aW50MzJfdCBzdGF0dXNfY3JjOzxicj4NCiZndDvCoCDCoCDCoCs8
YnI+DQomZ3Q7wqAgwqAgwqArwqAgwqAgcWVtdV9pcnEgaXJxOzxicj4NCiZndDvCoCDCoCDCoCt9
IEF3SDNTREhvc3RTdGF0ZTs8YnI+DQomZ3Q7wqAgwqAgwqArPGJyPg0KJmd0O8KgIMKgIMKgKyNl
bmRpZjxicj4NCiZndDvCoCDCoCDCoC0tIDxicj4NCiZndDvCoCDCoCDCoDIuMTcuMTxicj4NCjxi
cj4NCkkgaGF2ZW4mIzM5O3QgY2hlY2tlZCB0aGUgZGF0YXNoZWV0IGZvciBhbGwgdGhlIHJlZ2lz
dGVycy9iaXRzLjxicj4NCjxicj4NClBhdGNoIHZlcnkgY2xlYW4sIGNoYXBlYXUhPGJyPg0KPGJy
Pg0KUmVnYXJkcyw8YnI+DQo8YnI+DQpQaGlsLjxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rp
dj48YnIgY2xlYXI9ImFsbCI+PGJyPi0tIDxicj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxf
c2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj48ZGl2Pk5pZWsgTGlubmVuYmFuazxicj48YnI+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+DQo=
--000000000000c3573e0599c627e0--

