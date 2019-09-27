Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD59FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16F5207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16F5207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmZ6-0001c5-S8
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDmUa-00066w-Cb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDmUW-0000Jv-Kq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:24:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDmUW-0000H9-CY
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:24:44 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 13A11C04BD48
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:24:42 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id j125so2489396wmj.6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 02:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MVCJXKZqbmChJY1uJTU4+bXV2uHl7354a76NtKyw8v0=;
 b=X3b4xg3VKHH/PvS6UheyAuo1PkEzACqo3SiabyF0LOt3kqW6Hszb7Rv8PgQ2j2Aa7s
 wRB3WN32KMMrpeNu+2WPej8gr8d/yhN79ZF/9pBE/Jbe2fdfaovMO+nDQQtMzEk7IqXO
 Zm7aTndECofHj2nmKUGYB2FEErjpRMajGIPcp/erKIAz21fzwUVeRkkCX6mDPxRASrTG
 Sv/AnQIO6J1LVMKz7NMW6DATffJAip6tTEF9NNh0BmFq96jIXd/ahYF5FXdpXS0IvzZN
 jDtOAas/FenKt5QBIvSvXXPdQcpr7P0+onZbUCAVUFqxN691Dr4CMhQDSYRSV7eMSZfG
 341w==
X-Gm-Message-State: APjAAAWp/PpGvGsLXBnLiQYE1mfk7H1Ghr2hz0N7zgMsx81ZyITQNmPs
 FjPhq7C6mKEfPxnAkbIyhtiE5RIh5zJr+wVnAy3EDAtkbSRupb6s969z/C0qLzcn0jw9CkLsuzz
 IqS90JMC+CXDskPc=
X-Received: by 2002:a5d:4709:: with SMTP id y9mr2226549wrq.129.1569576280631; 
 Fri, 27 Sep 2019 02:24:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1gkMIFCH7uuOd9NL5i9ts2FPgbCC1nfm32U7SBTES6BD/qCNq5WCwCzEm3ux4yZSq7nHOzw==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr2226511wrq.129.1569576280231; 
 Fri, 27 Sep 2019 02:24:40 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id e9sm17158996wme.3.2019.09.27.02.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 02:24:39 -0700 (PDT)
Subject: Re: [PATCH v13 7/9] hw/m68k: add a dummy SWIM floppy controller
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190927090453.24712-1-laurent@vivier.eu>
 <20190927090453.24712-8-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <062924ea-5c5e-5cf3-ddf4-ed1f562b9815@redhat.com>
Date: Fri, 27 Sep 2019 11:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190927090453.24712-8-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 11:04 AM, Laurent Vivier wrote:
> SWIM (Sander-Wozniak Integrated Machine) is the floppy controller of
> the 680x0 Macintosh.
>=20
> This patch introduces

This information ...

> only the basic support: it allows to switch from
> IWM (Integrated WOZ Machine) mode to the SWIM mode and makes the linux
> driver happy.
>=20
> It cannot read any floppy image.

... is worth to add in swim.c header IMHO.

>=20
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  MAINTAINERS             |   2 +
>  hw/block/Kconfig        |   3 +
>  hw/block/Makefile.objs  |   1 +
>  hw/block/swim.c         | 487 ++++++++++++++++++++++++++++++++++++++++
>  hw/m68k/Kconfig         |   1 +
>  include/hw/block/swim.h |  76 +++++++
>  6 files changed, 570 insertions(+)
>  create mode 100644 hw/block/swim.c
>  create mode 100644 include/hw/block/swim.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f31fa3f469..c20f6bd4cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -923,9 +923,11 @@ S: Maintained
>  F: hw/misc/mac_via.c
>  F: hw/nubus/*
>  F: hw/display/macfb.c
> +F: hw/block/swim.c
>  F: include/hw/misc/mac_via.h
>  F: include/hw/nubus/*
>  F: include/hw/display/macfb.h
> +F: include/hw/block/swim.h
> =20
>  MicroBlaze Machines
>  -------------------
> diff --git a/hw/block/Kconfig b/hw/block/Kconfig
> index df96dc5dcc..2d17f481ad 100644
> --- a/hw/block/Kconfig
> +++ b/hw/block/Kconfig
> @@ -37,3 +37,6 @@ config VHOST_USER_BLK
>      # Only PCI devices are provided for now
>      default y if VIRTIO_PCI
>      depends on VIRTIO && VHOST_USER && LINUX
> +
> +config SWIM
> +    bool
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index f5f643f0cc..28c2495a00 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -8,6 +8,7 @@ common-obj-$(CONFIG_XEN) +=3D xen-block.o
>  common-obj-$(CONFIG_ECC) +=3D ecc.o
>  common-obj-$(CONFIG_ONENAND) +=3D onenand.o
>  common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
> +common-obj-$(CONFIG_SWIM) +=3D swim.o
> =20
>  obj-$(CONFIG_SH4) +=3D tc58128.o
> =20
> diff --git a/hw/block/swim.c b/hw/block/swim.c
> new file mode 100644
> index 0000000000..80addcea9d
> --- /dev/null
> +++ b/hw/block/swim.c
> @@ -0,0 +1,487 @@
> +/*
> + * QEMU Macintosh floppy disk controller emulator (SWIM)
> + *
> + * Copyright (c) 2014-2018 Laurent Vivier <laurent@vivier.eu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "qapi/error.h"
> +#include "sysemu/block-backend.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "hw/block/block.h"
> +#include "hw/block/swim.h"
> +#include "hw/qdev-properties.h"
> +
> +/* IWM registers */
> +
> +#define IWM_PH0L                0
> +#define IWM_PH0H                1
> +#define IWM_PH1L                2
> +#define IWM_PH1H                3
> +#define IWM_PH2L                4
> +#define IWM_PH2H                5
> +#define IWM_PH3L                6
> +#define IWM_PH3H                7
> +#define IWM_MTROFF              8
> +#define IWM_MTRON               9
> +#define IWM_INTDRIVE            10
> +#define IWM_EXTDRIVE            11
> +#define IWM_Q6L                 12
> +#define IWM_Q6H                 13
> +#define IWM_Q7L                 14
> +#define IWM_Q7H                 15
> +
> +/* SWIM registers */
> +
> +#define SWIM_WRITE_DATA         0
> +#define SWIM_WRITE_MARK         1
> +#define SWIM_WRITE_CRC          2
> +#define SWIM_WRITE_PARAMETER    3
> +#define SWIM_WRITE_PHASE        4
> +#define SWIM_WRITE_SETUP        5
> +#define SWIM_WRITE_MODE0        6
> +#define SWIM_WRITE_MODE1        7
> +
> +#define SWIM_READ_DATA          8
> +#define SWIM_READ_MARK          9
> +#define SWIM_READ_ERROR         10
> +#define SWIM_READ_PARAMETER     11
> +#define SWIM_READ_PHASE         12
> +#define SWIM_READ_SETUP         13
> +#define SWIM_READ_STATUS        14
> +#define SWIM_READ_HANDSHAKE     15
> +
> +#define REG_SHIFT               9
> +
> +#define SWIM_MODE_IWM  0
> +#define SWIM_MODE_SWIM 1
> +
> +/* bits in phase register */
> +
> +#define SWIM_SEEK_NEGATIVE   0x074
> +#define SWIM_STEP            0x071
> +#define SWIM_MOTOR_ON        0x072
> +#define SWIM_MOTOR_OFF       0x076
> +#define SWIM_INDEX           0x073
> +#define SWIM_EJECT           0x077
> +#define SWIM_SETMFM          0x171
> +#define SWIM_SETGCR          0x175
> +#define SWIM_RELAX           0x033
> +#define SWIM_LSTRB           0x008
> +#define SWIM_CA_MASK         0x077
> +
> +/* Select values for swim_select and swim_readbit */
> +
> +#define SWIM_READ_DATA_0     0x074
> +#define SWIM_TWOMEG_DRIVE    0x075
> +#define SWIM_SINGLE_SIDED    0x076
> +#define SWIM_DRIVE_PRESENT   0x077
> +#define SWIM_DISK_IN         0x170
> +#define SWIM_WRITE_PROT      0x171
> +#define SWIM_TRACK_ZERO      0x172
> +#define SWIM_TACHO           0x173
> +#define SWIM_READ_DATA_1     0x174
> +#define SWIM_MFM_MODE        0x175
> +#define SWIM_SEEK_COMPLETE   0x176
> +#define SWIM_ONEMEG_MEDIA    0x177
> +
> +/* Bits in handshake register */
> +
> +#define SWIM_MARK_BYTE       0x01
> +#define SWIM_CRC_ZERO        0x02
> +#define SWIM_RDDATA          0x04
> +#define SWIM_SENSE           0x08
> +#define SWIM_MOTEN           0x10
> +#define SWIM_ERROR           0x20
> +#define SWIM_DAT2BYTE        0x40
> +#define SWIM_DAT1BYTE        0x80
> +
> +/* bits in setup register */
> +
> +#define SWIM_S_INV_WDATA     0x01
> +#define SWIM_S_3_5_SELECT    0x02
> +#define SWIM_S_GCR           0x04
> +#define SWIM_S_FCLK_DIV2     0x08
> +#define SWIM_S_ERROR_CORR    0x10
> +#define SWIM_S_IBM_DRIVE     0x20
> +#define SWIM_S_GCR_WRITE     0x40
> +#define SWIM_S_TIMEOUT       0x80
> +
> +/* bits in mode register */
> +
> +#define SWIM_CLFIFO          0x01
> +#define SWIM_ENBL1           0x02
> +#define SWIM_ENBL2           0x04
> +#define SWIM_ACTION          0x08
> +#define SWIM_WRITE_MODE      0x10
> +#define SWIM_HEDSEL          0x20
> +#define SWIM_MOTON           0x80
> +
> +static void fd_recalibrate(FDrive *drive)
> +{
> +}
> +
> +static void swim_change_cb(void *opaque, bool load, Error **errp)
> +{
> +    FDrive *drive =3D opaque;
> +
> +    if (!load) {
> +        blk_set_perm(drive->blk, 0, BLK_PERM_ALL, &error_abort);
> +    } else {
> +        if (!blkconf_apply_backend_options(drive->conf,
> +                                           blk_is_read_only(drive->blk=
), false,
> +                                           errp)) {
> +            return;
> +        }
> +    }
> +}
> +
> +static const BlockDevOps swim_block_ops =3D {
> +    .change_media_cb =3D swim_change_cb,
> +};
> +
> +static Property swim_drive_properties[] =3D {
> +    DEFINE_PROP_INT32("unit", SWIMDrive, unit, -1),
> +    DEFINE_BLOCK_PROPERTIES(SWIMDrive, conf),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void swim_drive_realize(DeviceState *qdev, Error **errp)
> +{
> +    SWIMDrive *dev =3D SWIM_DRIVE(qdev);
> +    SWIMBus *bus =3D SWIM_BUS(qdev->parent_bus);
> +    FDrive *drive;
> +    int ret;
> +
> +    if (dev->unit =3D=3D -1) {
> +        for (dev->unit =3D 0; dev->unit < SWIM_MAX_FD; dev->unit++) {
> +            drive =3D &bus->ctrl->drives[dev->unit];
> +            if (!drive->blk) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    if (dev->unit >=3D SWIM_MAX_FD) {
> +        error_setg(errp, "Can't create floppy unit %d, bus supports "
> +                   "only %d units", dev->unit, SWIM_MAX_FD);
> +        return;
> +    }
> +
> +    drive =3D &bus->ctrl->drives[dev->unit];
> +    if (drive->blk) {
> +        error_setg(errp, "Floppy unit %d is in use", dev->unit);
> +        return;
> +    }
> +
> +    if (!dev->conf.blk) {
> +        /* Anonymous BlockBackend for an empty drive */
> +        dev->conf.blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_=
ALL);
> +        ret =3D blk_attach_dev(dev->conf.blk, qdev);
> +        assert(ret =3D=3D 0);
> +    }
> +
> +    blkconf_blocksizes(&dev->conf);
> +    if (dev->conf.logical_block_size !=3D 512 ||
> +        dev->conf.physical_block_size !=3D 512)
> +    {
> +        error_setg(errp, "Physical and logical block size must "
> +                   "be 512 for floppy");
> +        return;
> +    }
> +
> +    /*
> +     * rerror/werror aren't supported by fdc and therefore not even re=
gistered
> +     * with qdev. So set the defaults manually before they are used in
> +     * blkconf_apply_backend_options().
> +     */
> +    dev->conf.rerror =3D BLOCKDEV_ON_ERROR_AUTO;
> +    dev->conf.werror =3D BLOCKDEV_ON_ERROR_AUTO;
> +
> +    if (!blkconf_apply_backend_options(&dev->conf,
> +                                       blk_is_read_only(dev->conf.blk)=
,
> +                                       false, errp)) {
> +        return;
> +    }
> +
> +    /*
> +     * 'enospc' is the default for -drive, 'report' is what blk_new() =
gives us
> +     * for empty drives.
> +     */
> +    if (blk_get_on_error(dev->conf.blk, 0) !=3D BLOCKDEV_ON_ERROR_ENOS=
PC &&
> +        blk_get_on_error(dev->conf.blk, 0) !=3D BLOCKDEV_ON_ERROR_REPO=
RT) {
> +        error_setg(errp, "fdc doesn't support drive option werror");
> +        return;
> +    }
> +    if (blk_get_on_error(dev->conf.blk, 1) !=3D BLOCKDEV_ON_ERROR_REPO=
RT) {
> +        error_setg(errp, "fdc doesn't support drive option rerror");
> +        return;
> +    }
> +
> +    drive->conf =3D &dev->conf;
> +    drive->blk =3D dev->conf.blk;
> +    drive->swimctrl =3D bus->ctrl;
> +
> +    blk_set_dev_ops(drive->blk, &swim_block_ops, drive);
> +}
> +
> +static void swim_drive_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *k =3D DEVICE_CLASS(klass);
> +    k->realize =3D swim_drive_realize;
> +    set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
> +    k->bus_type =3D TYPE_SWIM_BUS;
> +    k->props =3D swim_drive_properties;
> +    k->desc =3D "virtual SWIM drive";
> +}
> +
> +static const TypeInfo swim_drive_info =3D {
> +    .name =3D TYPE_SWIM_DRIVE,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(SWIMDrive),
> +    .class_init =3D swim_drive_class_init,
> +};
> +
> +static const TypeInfo swim_bus_info =3D {
> +    .name =3D TYPE_SWIM_BUS,
> +    .parent =3D TYPE_BUS,
> +    .instance_size =3D sizeof(SWIMBus),
> +};
> +
> +static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
> +                          unsigned size)
> +{
> +    SWIMCtrl *swimctrl =3D opaque;
> +
> +    reg >>=3D REG_SHIFT;
> +
> +    swimctrl->regs[reg >> 1] =3D reg & 1;
> +
> +    if (swimctrl->regs[IWM_Q6] &&
> +        swimctrl->regs[IWM_Q7]) {
> +        if (swimctrl->regs[IWM_MTR]) {
> +            /* data register */
> +            swimctrl->iwm_data =3D value;
> +        } else {
> +            /* mode register */
> +            swimctrl->iwm_mode =3D value;
> +            /* detect sequence to switch from IWM mode to SWIM mode */
> +            switch (swimctrl->iwm_switch) {
> +            case 0:
> +                if (value =3D=3D 0x57) {
> +                    swimctrl->iwm_switch++;
> +                }
> +                break;
> +            case 1:
> +                if (value =3D=3D 0x17) {
> +                    swimctrl->iwm_switch++;
> +                }
> +                break;
> +            case 2:
> +                if (value =3D=3D 0x57) {
> +                    swimctrl->iwm_switch++;
> +                }
> +                break;
> +            case 3:
> +                if (value =3D=3D 0x57) {
> +                    swimctrl->mode =3D SWIM_MODE_SWIM;
> +                    swimctrl->iwm_switch =3D 0;
> +                }
> +                break;
> +            }
> +        }
> +    }
> +}
> +
> +static uint64_t iwmctrl_read(void *opaque, hwaddr reg, unsigned size)
> +{
> +    SWIMCtrl *swimctrl =3D opaque;
> +
> +    reg >>=3D REG_SHIFT;
> +
> +    swimctrl->regs[reg >> 1] =3D reg & 1;
> +
> +    return 0;
> +}
> +
> +static void swimctrl_write(void *opaque, hwaddr reg, uint64_t value,
> +                           unsigned size)
> +{
> +    SWIMCtrl *swimctrl =3D opaque;
> +
> +    if (swimctrl->mode =3D=3D SWIM_MODE_IWM) {
> +        iwmctrl_write(opaque, reg, value, size);
> +        return;
> +    }
> +
> +    reg >>=3D REG_SHIFT;
> +
> +    switch (reg) {
> +    case SWIM_WRITE_PHASE:
> +        swimctrl->swim_phase =3D value;
> +        break;
> +    case SWIM_WRITE_MODE0:
> +        swimctrl->swim_mode &=3D ~value;
> +        break;
> +    case SWIM_WRITE_MODE1:
> +        swimctrl->swim_mode |=3D value;
> +        break;
> +    case SWIM_WRITE_DATA:
> +    case SWIM_WRITE_MARK:
> +    case SWIM_WRITE_CRC:
> +    case SWIM_WRITE_PARAMETER:
> +    case SWIM_WRITE_SETUP:
> +        break;
> +    }
> +}
> +
> +static uint64_t swimctrl_read(void *opaque, hwaddr reg, unsigned size)
> +{
> +    SWIMCtrl *swimctrl =3D opaque;
> +    uint32_t value =3D 0;
> +
> +    if (swimctrl->mode =3D=3D SWIM_MODE_IWM) {
> +        return iwmctrl_read(opaque, reg, size);
> +    }
> +
> +    reg >>=3D REG_SHIFT;
> +
> +    switch (reg) {
> +    case SWIM_READ_PHASE:
> +        value =3D swimctrl->swim_phase;
> +        break;
> +    case SWIM_READ_HANDSHAKE:
> +        if (swimctrl->swim_phase =3D=3D SWIM_DRIVE_PRESENT) {
> +            /* always answer "no drive present" */
> +            value =3D SWIM_SENSE;
> +        }
> +        break;
> +    case SWIM_READ_DATA:
> +    case SWIM_READ_MARK:
> +    case SWIM_READ_ERROR:
> +    case SWIM_READ_PARAMETER:
> +    case SWIM_READ_SETUP:
> +    case SWIM_READ_STATUS:
> +        break;
> +    }
> +
> +    return value;
> +}
> +
> +static const MemoryRegionOps swimctrl_mem_ops =3D {
> +    .write =3D swimctrl_write,
> +    .read =3D swimctrl_read,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void sysbus_swim_reset(DeviceState *d)
> +{
> +    SWIM *sys =3D SWIM(d);
> +    SWIMCtrl *ctrl =3D &sys->ctrl;
> +    int i;
> +
> +    ctrl->mode =3D 0;
> +    ctrl->iwm_switch =3D 0;
> +    for (i =3D 0; i < 8; i++) {
> +        ctrl->regs[i] =3D 0;
> +    }
> +    ctrl->iwm_data =3D 0;
> +    ctrl->iwm_mode =3D 0;
> +    ctrl->swim_phase =3D 0;
> +    ctrl->swim_mode =3D 0;
> +    for (i =3D 0; i < SWIM_MAX_FD; i++) {
> +        fd_recalibrate(&ctrl->drives[i]);
> +    }
> +}
> +
> +static void sysbus_swim_init(Object *obj)
> +{
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +    SWIM *sbs =3D SWIM(obj);
> +    SWIMCtrl *swimctrl =3D &sbs->ctrl;
> +
> +    memory_region_init_io(&swimctrl->iomem, obj, &swimctrl_mem_ops, sw=
imctrl,
> +                          "swim", 0x2000);
> +    sysbus_init_mmio(sbd, &swimctrl->iomem);
> +}
> +
> +static void sysbus_swim_realize(DeviceState *dev, Error **errp)
> +{
> +    SWIM *sys =3D SWIM(dev);
> +    SWIMCtrl *swimctrl =3D &sys->ctrl;
> +
> +    qbus_create_inplace(&swimctrl->bus, sizeof(SWIMBus), TYPE_SWIM_BUS=
, dev,
> +                        NULL);
> +    swimctrl->bus.ctrl =3D swimctrl;
> +}
> +
> +static const VMStateDescription vmstate_fdrive =3D {
> +    .name =3D "fdrive",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_swim =3D {
> +    .name =3D "swim",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_INT32(mode, SWIMCtrl),
> +        /* IWM mode */
> +        VMSTATE_INT32(iwm_switch, SWIMCtrl),
> +        VMSTATE_UINT16_ARRAY(regs, SWIMCtrl, 8),
> +        VMSTATE_UINT8(iwm_data, SWIMCtrl),
> +        VMSTATE_UINT8(iwm_mode, SWIMCtrl),
> +        /* SWIM mode */
> +        VMSTATE_UINT8(swim_phase, SWIMCtrl),
> +        VMSTATE_UINT8(swim_mode, SWIMCtrl),
> +        /* Drives */
> +        VMSTATE_STRUCT_ARRAY(drives, SWIMCtrl, SWIM_MAX_FD, 1,
> +                             vmstate_fdrive, FDrive),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_sysbus_swim =3D {
> +    .name =3D "SWIM",
> +    .version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_STRUCT(ctrl, SWIM, 0, vmstate_swim, SWIMCtrl),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void sysbus_swim_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D sysbus_swim_realize;
> +    dc->reset =3D sysbus_swim_reset;
> +    dc->vmsd =3D &vmstate_sysbus_swim;
> +}
> +
> +static const TypeInfo sysbus_swim_info =3D {
> +    .name          =3D TYPE_SWIM,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(SWIM),
> +    .instance_init =3D sysbus_swim_init,
> +    .class_init    =3D sysbus_swim_class_init,
> +};
> +
> +static void swim_register_types(void)
> +{
> +    type_register_static(&sysbus_swim_info);
> +    type_register_static(&swim_bus_info);
> +    type_register_static(&swim_drive_info);
> +}
> +
> +type_init(swim_register_types)
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index ef4917dee6..bab4885ca5 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -18,3 +18,4 @@ config Q800
>      select MAC_VIA
>      select NUBUS
>      select MACFB
> +    select SWIM
> diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
> new file mode 100644
> index 0000000000..6add3499d0
> --- /dev/null
> +++ b/include/hw/block/swim.h
> @@ -0,0 +1,76 @@
> +/*
> + * QEMU Macintosh floppy disk controller emulator (SWIM)
> + *
> + * Copyright (c) 2014-2018 Laurent Vivier <laurent@vivier.eu>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef SWIM_H
> +#define SWIM_H
> +
> +#include "qemu/osdep.h"
> +#include "hw/sysbus.h"
> +
> +#define SWIM_MAX_FD            2
> +
> +typedef struct SWIMDrive SWIMDrive;
> +typedef struct SWIMBus SWIMBus;
> +typedef struct SWIMCtrl SWIMCtrl;
> +
> +#define TYPE_SWIM_DRIVE "swim-drive"
> +#define SWIM_DRIVE(obj) OBJECT_CHECK(SWIMDrive, (obj), TYPE_SWIM_DRIVE=
)
> +
> +struct SWIMDrive {
> +    DeviceState qdev;
> +    int32_t     unit;
> +    BlockConf   conf;
> +};
> +
> +#define TYPE_SWIM_BUS "swim-bus"
> +#define SWIM_BUS(obj) OBJECT_CHECK(SWIMBus, (obj), TYPE_SWIM_BUS)
> +
> +struct SWIMBus {
> +    BusState bus;
> +    struct SWIMCtrl *ctrl;
> +};
> +
> +typedef struct FDrive {
> +    SWIMCtrl *swimctrl;
> +    BlockBackend *blk;
> +    BlockConf *conf;
> +} FDrive;
> +
> +struct SWIMCtrl {
> +    MemoryRegion iomem;
> +    FDrive drives[SWIM_MAX_FD];
> +    int mode;
> +    /* IWM mode */
> +    int iwm_switch;
> +    uint16_t regs[8];
> +#define IWM_PH0   0
> +#define IWM_PH1   1
> +#define IWM_PH2   2
> +#define IWM_PH3   3
> +#define IWM_MTR   4
> +#define IWM_DRIVE 5
> +#define IWM_Q6    6
> +#define IWM_Q7    7
> +    uint8_t iwm_data;
> +    uint8_t iwm_mode;
> +    /* SWIM mode */
> +    uint8_t swim_phase;
> +    uint8_t swim_mode;
> +    SWIMBus bus;
> +};
> +
> +#define TYPE_SWIM "swim"
> +#define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE_SWIM)
> +
> +typedef struct SWIM {
> +    SysBusDevice parent_obj;
> +    SWIMCtrl     ctrl;
> +} SWIM;
> +#endif
>=20

