Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DC7C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5822821479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpLkt2jV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5822821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NgJ-0006yf-HX
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7NfQ-0006JM-1P
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7NfM-0003EZ-6z
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:41:31 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i7NfI-0003Av-VF; Mon, 09 Sep 2019 13:41:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id b2so13400975otq.10;
 Mon, 09 Sep 2019 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=URaBa4+WKHRPu1cu6qv5m/Y71pWLCEqczBMnHuLTlCM=;
 b=mpLkt2jV9OUAY0X+Q+L47sEeH5egW17tXH5zdvsKlnYDriNNiJA8AD+op4Sgs86aeg
 yFuxAUQ3JW2Yccpo4uiYmr7iirJkmRUDGhRV7Sy4NJ4wKxGEQHTfUQ9TOPOzeWw0muKM
 Qj2ov3NABbAAj3PcPqf015BayDhtGxUqb+/sFMDJe8juYf6XdYOFFDpwvLeZDO76k7rG
 gZSB74qaqxNQmpBlW2SlcP+RGQFt0ukIht7DBndz9mFvphxZDkDgY3HI2h5c7zl0+9N4
 /og6cKhcjaE3AKBUABvtqo4sp5EUe2WYg26XxiHF9gdxhoXCsDvjiQT8n5k1zTpYVWJf
 q2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=URaBa4+WKHRPu1cu6qv5m/Y71pWLCEqczBMnHuLTlCM=;
 b=e8Id+le/GYH/PpcVVza5wEzuaG7Nz4poR8GtSR7ijtK/jPXaImirkv2Dw+OyoAeZwq
 yBDhs0WyLdCv3rvC1HXFM0DyqoUwmyI5VbecUom/Qkm0L38mpxcHNG1XEdH9R6gW8clu
 /EuoB7seWnpq4PhuF1imDJRsclKevqQeVKdj0JbbV91Yw6vaa/JWX1MjfF10sEjwdb05
 /cIdfFvfCTOKqAHzoVyZP/SA008pAZuS9wi/ybQ9wpP7bmShYMhHVwy2fQPGaN1omLZ5
 Mb1ZNHqOeIdjGZVHE6pPlf9R5ywHz+d78JzxfKee+8StaX+C9H411H9Ck2aSzmUmadg4
 caYg==
X-Gm-Message-State: APjAAAVztNwtMt3o0LSJVh2igkHEkcGPdtrF0TlahNlKENzllVisMpoN
 bWEWcU4Sc/evIIAL3RrHfaTgX28GmZJwKbpowjmUng==
X-Google-Smtp-Source: APXvYqwK3AbXp0F2gWJPTUx4eL6nL/gfUwTQNFFLfVIvpCozQlvgUjvY/Moi11W9Spih7FQk3YwfDSpd3DFu1H02/X0=
X-Received: by 2002:a9d:6014:: with SMTP id h20mr12468069otj.306.1568050883391; 
 Mon, 09 Sep 2019 10:41:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Mon, 9 Sep 2019 10:41:22 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Mon, 9 Sep 2019 10:41:22 -0700 (PDT)
In-Reply-To: <CAL1e-=jf=oaMfNf6jivroDLMywaNbcbKL9QuVp7K65bc-tRLuw@mail.gmail.com>
References: <20190909155813.27760-1-laurent@vivier.eu>
 <20190909155813.27760-9-laurent@vivier.eu>
 <CAL1e-=jf=oaMfNf6jivroDLMywaNbcbKL9QuVp7K65bc-tRLuw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Sep 2019 19:41:22 +0200
Message-ID: <CAL1e-=hNTEM6ebJsp1JBjhWNMtDYaSuEGtFA3jJn+UZeWAyZYA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v9 8/9] hw/m68k: add a dummy SWIM floppy
 controller
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.09.2019. 18.32, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 09.09.2019. 18.03, "Laurent Vivier" <laurent@vivier.eu> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> > ---
>
> Laurent, hi!
>
> I am not sure how "Co-developed-by:" fits in our workflow. There was some
recent talk on restricting those marks to only a handful of them, and
preventing new ones from introducing (the starter example was something
like "Regression-tested-by:"). Perhaps a final sentence "This patch was
co-developed with Mark..." would be better?
>
> Aleksandar

Laurent,

I noticed I overlooked that there is a paragraph on "Co-developed-by:" in
the Linux kernel "how to submit a patch", so it is fine.

Sorry about noise.

Aleksandar

> >  hw/block/Kconfig        |   3 +
> >  hw/block/Makefile.objs  |   1 +
> >  hw/block/swim.c         | 421 ++++++++++++++++++++++++++++++++++++++++
> >  include/hw/block/swim.h |  76 ++++++++
> >  4 files changed, 501 insertions(+)
> >  create mode 100644 hw/block/swim.c
> >  create mode 100644 include/hw/block/swim.h
> >
> > diff --git a/hw/block/Kconfig b/hw/block/Kconfig
> > index df96dc5dcc..2d17f481ad 100644
> > --- a/hw/block/Kconfig
> > +++ b/hw/block/Kconfig
> > @@ -37,3 +37,6 @@ config VHOST_USER_BLK
> >      # Only PCI devices are provided for now
> >      default y if VIRTIO_PCI
> >      depends on VIRTIO && VHOST_USER && LINUX
> > +
> > +config SWIM
> > +    bool
> > diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> > index f5f643f0cc..28c2495a00 100644
> > --- a/hw/block/Makefile.objs
> > +++ b/hw/block/Makefile.objs
> > @@ -8,6 +8,7 @@ common-obj-$(CONFIG_XEN) +=3D xen-block.o
> >  common-obj-$(CONFIG_ECC) +=3D ecc.o
> >  common-obj-$(CONFIG_ONENAND) +=3D onenand.o
> >  common-obj-$(CONFIG_NVME_PCI) +=3D nvme.o
> > +common-obj-$(CONFIG_SWIM) +=3D swim.o
> >
> >  obj-$(CONFIG_SH4) +=3D tc58128.o
> >
> > diff --git a/hw/block/swim.c b/hw/block/swim.c
> > new file mode 100644
> > index 0000000000..6e26915238
> > --- /dev/null
> > +++ b/hw/block/swim.c
> > @@ -0,0 +1,421 @@
> > +/*
> > + * QEMU Macintosh floppy disk controller emulator (SWIM)
> > + *
> > + * Copyright (c) 2014-2018 Laurent Vivier <laurent@vivier.eu>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.
See
> > + * the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/main-loop.h"
> > +#include "qapi/error.h"
> > +#include "sysemu/block-backend.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/block/block.h"
> > +#include "hw/block/swim.h"
> > +#include "hw/qdev-properties.h"
> > +
> > +/* IWM registers */
> > +
> > +#define IWM_PH0L                0
> > +#define IWM_PH0H                1
> > +#define IWM_PH1L                2
> > +#define IWM_PH1H                3
> > +#define IWM_PH2L                4
> > +#define IWM_PH2H                5
> > +#define IWM_PH3L                6
> > +#define IWM_PH3H                7
> > +#define IWM_MTROFF              8
> > +#define IWM_MTRON               9
> > +#define IWM_INTDRIVE            10
> > +#define IWM_EXTDRIVE            11
> > +#define IWM_Q6L                 12
> > +#define IWM_Q6H                 13
> > +#define IWM_Q7L                 14
> > +#define IWM_Q7H                 15
> > +
> > +/* SWIM registers */
> > +
> > +#define SWIM_WRITE_DATA         0
> > +#define SWIM_WRITE_MARK         1
> > +#define SWIM_WRITE_CRC          2
> > +#define SWIM_WRITE_PARAMETER    3
> > +#define SWIM_WRITE_PHASE        4
> > +#define SWIM_WRITE_SETUP        5
> > +#define SWIM_WRITE_MODE0        6
> > +#define SWIM_WRITE_MODE1        7
> > +
> > +#define SWIM_READ_DATA          8
> > +#define SWIM_READ_MARK          9
> > +#define SWIM_READ_ERROR         10
> > +#define SWIM_READ_PARAMETER     11
> > +#define SWIM_READ_PHASE         12
> > +#define SWIM_READ_SETUP         13
> > +#define SWIM_READ_STATUS        14
> > +#define SWIM_READ_HANDSHAKE     15
> > +
> > +#define REG_SHIFT               9
> > +
> > +#define SWIM_MODE_IWM  0
> > +#define SWIM_MODE_SWIM 1
> > +
> > +/* bits in phase register */
> > +
> > +#define SWIM_SEEK_NEGATIVE   0x074
> > +#define SWIM_STEP            0x071
> > +#define SWIM_MOTOR_ON        0x072
> > +#define SWIM_MOTOR_OFF       0x076
> > +#define SWIM_INDEX           0x073
> > +#define SWIM_EJECT           0x077
> > +#define SWIM_SETMFM          0x171
> > +#define SWIM_SETGCR          0x175
> > +#define SWIM_RELAX           0x033
> > +#define SWIM_LSTRB           0x008
> > +#define SWIM_CA_MASK         0x077
> > +
> > +/* Select values for swim_select and swim_readbit */
> > +
> > +#define SWIM_READ_DATA_0     0x074
> > +#define SWIM_TWOMEG_DRIVE    0x075
> > +#define SWIM_SINGLE_SIDED    0x076
> > +#define SWIM_DRIVE_PRESENT   0x077
> > +#define SWIM_DISK_IN         0x170
> > +#define SWIM_WRITE_PROT      0x171
> > +#define SWIM_TRACK_ZERO      0x172
> > +#define SWIM_TACHO           0x173
> > +#define SWIM_READ_DATA_1     0x174
> > +#define SWIM_MFM_MODE        0x175
> > +#define SWIM_SEEK_COMPLETE   0x176
> > +#define SWIM_ONEMEG_MEDIA    0x177
> > +
> > +/* Bits in handshake register */
> > +
> > +#define SWIM_MARK_BYTE       0x01
> > +#define SWIM_CRC_ZERO        0x02
> > +#define SWIM_RDDATA          0x04
> > +#define SWIM_SENSE           0x08
> > +#define SWIM_MOTEN           0x10
> > +#define SWIM_ERROR           0x20
> > +#define SWIM_DAT2BYTE        0x40
> > +#define SWIM_DAT1BYTE        0x80
> > +
> > +/* bits in setup register */
> > +
> > +#define SWIM_S_INV_WDATA     0x01
> > +#define SWIM_S_3_5_SELECT    0x02
> > +#define SWIM_S_GCR           0x04
> > +#define SWIM_S_FCLK_DIV2     0x08
> > +#define SWIM_S_ERROR_CORR    0x10
> > +#define SWIM_S_IBM_DRIVE     0x20
> > +#define SWIM_S_GCR_WRITE     0x40
> > +#define SWIM_S_TIMEOUT       0x80
> > +
> > +/* bits in mode register */
> > +
> > +#define SWIM_CLFIFO          0x01
> > +#define SWIM_ENBL1           0x02
> > +#define SWIM_ENBL2           0x04
> > +#define SWIM_ACTION          0x08
> > +#define SWIM_WRITE_MODE      0x10
> > +#define SWIM_HEDSEL          0x20
> > +#define SWIM_MOTON           0x80
> > +
> > +static void swim_change_cb(void *opaque, bool load, Error **errp)
> > +{
> > +    FDrive *drive =3D opaque;
> > +
> > +    if (!load) {
> > +        blk_set_perm(drive->blk, 0, BLK_PERM_ALL, &error_abort);
> > +    } else {
> > +        if (!blkconf_apply_backend_options(drive->conf,
> > +
 blk_is_read_only(drive->blk), false,
> > +                                           errp)) {
> > +            return;
> > +        }
> > +    }
> > +}
> > +
> > +static const BlockDevOps swim_block_ops =3D {
> > +    .change_media_cb =3D swim_change_cb,
> > +};
> > +
> > +static Property swim_drive_properties[] =3D {
> > +    DEFINE_PROP_INT32("unit", SWIMDrive, unit, -1),
> > +    DEFINE_BLOCK_PROPERTIES(SWIMDrive, conf),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void swim_drive_realize(DeviceState *qdev, Error **errp)
> > +{
> > +    SWIMDrive *dev =3D SWIM_DRIVE(qdev);
> > +    SWIMBus *bus =3D SWIM_BUS(qdev->parent_bus);
> > +    FDrive *drive;
> > +    int ret;
> > +
> > +    if (dev->unit =3D=3D -1) {
> > +        for (dev->unit =3D 0; dev->unit < SWIM_MAX_FD; dev->unit++) {
> > +            drive =3D &bus->ctrl->drives[dev->unit];
> > +            if (!drive->blk) {
> > +                break;
> > +            }
> > +        }
> > +    }
> > +
> > +    if (dev->unit >=3D SWIM_MAX_FD) {
> > +        error_setg(errp, "Can't create floppy unit %d, bus supports "
> > +                   "only %d units", dev->unit, SWIM_MAX_FD);
> > +        return;
> > +    }
> > +
> > +    drive =3D &bus->ctrl->drives[dev->unit];
> > +    if (drive->blk) {
> > +        error_setg(errp, "Floppy unit %d is in use", dev->unit);
> > +        return;
> > +    }
> > +
> > +    if (!dev->conf.blk) {
> > +        /* Anonymous BlockBackend for an empty drive */
> > +        dev->conf.blk =3D blk_new(qemu_get_aio_context(), 0,
BLK_PERM_ALL);
> > +        ret =3D blk_attach_dev(dev->conf.blk, qdev);
> > +        assert(ret =3D=3D 0);
> > +    }
> > +
> > +    blkconf_blocksizes(&dev->conf);
> > +    if (dev->conf.logical_block_size !=3D 512 ||
> > +        dev->conf.physical_block_size !=3D 512)
> > +    {
> > +        error_setg(errp, "Physical and logical block size must "
> > +                   "be 512 for floppy");
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * rerror/werror aren't supported by fdc and therefore not even
registered
> > +     * with qdev. So set the defaults manually before they are used in
> > +     * blkconf_apply_backend_options().
> > +     */
> > +    dev->conf.rerror =3D BLOCKDEV_ON_ERROR_AUTO;
> > +    dev->conf.werror =3D BLOCKDEV_ON_ERROR_AUTO;
> > +
> > +    if (!blkconf_apply_backend_options(&dev->conf,
> > +                                       blk_is_read_only(dev->conf.blk)=
,
> > +                                       false, errp)) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * 'enospc' is the default for -drive, 'report' is what blk_new()
gives us
> > +     * for empty drives.
> > +     */
> > +    if (blk_get_on_error(dev->conf.blk, 0) !=3D BLOCKDEV_ON_ERROR_ENOS=
PC
&&
> > +        blk_get_on_error(dev->conf.blk, 0) !=3D
BLOCKDEV_ON_ERROR_REPORT) {
> > +        error_setg(errp, "fdc doesn't support drive option werror");
> > +        return;
> > +    }
> > +    if (blk_get_on_error(dev->conf.blk, 1) !=3D
BLOCKDEV_ON_ERROR_REPORT) {
> > +        error_setg(errp, "fdc doesn't support drive option rerror");
> > +        return;
> > +    }
> > +
> > +    drive->conf =3D &dev->conf;
> > +    drive->blk =3D dev->conf.blk;
> > +    drive->swimctrl =3D bus->ctrl;
> > +
> > +    blk_set_dev_ops(drive->blk, &swim_block_ops, drive);
> > +}
> > +
> > +static void swim_drive_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *k =3D DEVICE_CLASS(klass);
> > +    k->realize =3D swim_drive_realize;
> > +    set_bit(DEVICE_CATEGORY_STORAGE, k->categories);
> > +    k->bus_type =3D TYPE_SWIM_BUS;
> > +    k->props =3D swim_drive_properties;
> > +    k->desc =3D "virtual SWIM drive";
> > +}
> > +
> > +static const TypeInfo swim_drive_info =3D {
> > +    .name =3D TYPE_SWIM_DRIVE,
> > +    .parent =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(SWIMDrive),
> > +    .class_init =3D swim_drive_class_init,
> > +};
> > +
> > +static const TypeInfo swim_bus_info =3D {
> > +    .name =3D TYPE_SWIM_BUS,
> > +    .parent =3D TYPE_BUS,
> > +    .instance_size =3D sizeof(SWIMBus),
> > +};
> > +
> > +static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
> > +                          unsigned size)
> > +{
> > +    SWIMCtrl *swimctrl =3D opaque;
> > +
> > +    reg >>=3D REG_SHIFT;
> > +
> > +    swimctrl->regs[reg >> 1] =3D reg & 1;
> > +
> > +    if (swimctrl->regs[IWM_Q6] &&
> > +        swimctrl->regs[IWM_Q7]) {
> > +        if (swimctrl->regs[IWM_MTR]) {
> > +            /* data register */
> > +            swimctrl->iwm_data =3D value;
> > +        } else {
> > +            /* mode register */
> > +            swimctrl->iwm_mode =3D value;
> > +            /* detect sequence to switch from IWM mode to SWIM mode */
> > +            switch (swimctrl->iwm_switch) {
> > +            case 0:
> > +                if (value =3D=3D 0x57) {
> > +                    swimctrl->iwm_switch++;
> > +                }
> > +                break;
> > +            case 1:
> > +                if (value =3D=3D 0x17) {
> > +                    swimctrl->iwm_switch++;
> > +                }
> > +                break;
> > +            case 2:
> > +                if (value =3D=3D 0x57) {
> > +                    swimctrl->iwm_switch++;
> > +                }
> > +                break;
> > +            case 3:
> > +                if (value =3D=3D 0x57) {
> > +                    swimctrl->mode =3D SWIM_MODE_SWIM;
> > +                    swimctrl->iwm_switch =3D 0;
> > +                }
> > +                break;
> > +            }
> > +        }
> > +    }
> > +}
> > +
> > +static uint64_t iwmctrl_read(void *opaque, hwaddr reg, unsigned size)
> > +{
> > +    SWIMCtrl *swimctrl =3D opaque;
> > +
> > +    reg >>=3D REG_SHIFT;
> > +
> > +    swimctrl->regs[reg >> 1] =3D reg & 1;
> > +
> > +    return 0;
> > +}
> > +
> > +static void swimctrl_write(void *opaque, hwaddr reg, uint64_t value,
> > +                           unsigned size)
> > +{
> > +    SWIMCtrl *swimctrl =3D opaque;
> > +
> > +    if (swimctrl->mode =3D=3D SWIM_MODE_IWM) {
> > +        iwmctrl_write(opaque, reg, value, size);
> > +        return;
> > +    }
> > +
> > +    reg >>=3D REG_SHIFT;
> > +
> > +    switch (reg) {
> > +    case SWIM_WRITE_PHASE:
> > +        swimctrl->swim_phase =3D value;
> > +        break;
> > +    case SWIM_WRITE_MODE0:
> > +        swimctrl->swim_mode &=3D ~value;
> > +        break;
> > +    case SWIM_WRITE_MODE1:
> > +        swimctrl->swim_mode |=3D value;
> > +        break;
> > +    case SWIM_WRITE_DATA:
> > +    case SWIM_WRITE_MARK:
> > +    case SWIM_WRITE_CRC:
> > +    case SWIM_WRITE_PARAMETER:
> > +    case SWIM_WRITE_SETUP:
> > +        break;
> > +    }
> > +}
> > +
> > +static uint64_t swimctrl_read(void *opaque, hwaddr reg, unsigned size)
> > +{
> > +    SWIMCtrl *swimctrl =3D opaque;
> > +    uint32_t value =3D 0;
> > +
> > +    if (swimctrl->mode =3D=3D SWIM_MODE_IWM) {
> > +        return iwmctrl_read(opaque, reg, size);
> > +    }
> > +
> > +    reg >>=3D REG_SHIFT;
> > +
> > +    switch (reg) {
> > +    case SWIM_READ_PHASE:
> > +        value =3D swimctrl->swim_phase;
> > +        break;
> > +    case SWIM_READ_HANDSHAKE:
> > +        if (swimctrl->swim_phase =3D=3D SWIM_DRIVE_PRESENT) {
> > +            /* always answer "no drive present" */
> > +            value =3D SWIM_SENSE;
> > +        }
> > +        break;
> > +    case SWIM_READ_DATA:
> > +    case SWIM_READ_MARK:
> > +    case SWIM_READ_ERROR:
> > +    case SWIM_READ_PARAMETER:
> > +    case SWIM_READ_SETUP:
> > +    case SWIM_READ_STATUS:
> > +        break;
> > +    }
> > +
> > +    return value;
> > +}
> > +
> > +static const MemoryRegionOps swimctrl_mem_ops =3D {
> > +    .write =3D swimctrl_write,
> > +    .read =3D swimctrl_read,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
> > +
> > +static void sysbus_swim_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    SWIM *sbs =3D SWIM(obj);
> > +    SWIMCtrl *swimctrl =3D &sbs->ctrl;
> > +
> > +    memory_region_init_io(&swimctrl->iomem, obj, &swimctrl_mem_ops,
swimctrl,
> > +                          "swim", 0x2000);
> > +    sysbus_init_mmio(sbd, &swimctrl->iomem);
> > +}
> > +
> > +static void sysbus_swim_realize(DeviceState *dev, Error **errp)
> > +{
> > +    SWIM *sys =3D SWIM(dev);
> > +    SWIMCtrl *swimctrl =3D &sys->ctrl;
> > +
> > +    qbus_create_inplace(&swimctrl->bus, sizeof(SWIMBus),
TYPE_SWIM_BUS, dev,
> > +                        NULL);
> > +    swimctrl->bus.ctrl =3D swimctrl;
> > +}
> > +
> > +static void sysbus_swim_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +
> > +    dc->realize =3D sysbus_swim_realize;
> > +}
> > +
> > +static const TypeInfo sysbus_swim_info =3D {
> > +    .name          =3D TYPE_SWIM,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(SWIM),
> > +    .instance_init =3D sysbus_swim_init,
> > +    .class_init    =3D sysbus_swim_class_init,
> > +};
> > +
> > +static void swim_register_types(void)
> > +{
> > +    type_register_static(&sysbus_swim_info);
> > +    type_register_static(&swim_bus_info);
> > +    type_register_static(&swim_drive_info);
> > +}
> > +
> > +type_init(swim_register_types)
> > diff --git a/include/hw/block/swim.h b/include/hw/block/swim.h
> > new file mode 100644
> > index 0000000000..e69c644995
> > --- /dev/null
> > +++ b/include/hw/block/swim.h
> > @@ -0,0 +1,76 @@
> > +/*
> > + * QEMU Macintosh floppy disk controller emulator (SWIM)
> > + *
> > + * Copyright (c) 2014-2018 Laurent Vivier <laurent@vivier.eu>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.
See
> > + * the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef SWIM_H
> > +#define SWIM_H
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/sysbus.h"
> > +
> > +#define SWIM_MAX_FD            2
> > +
> > +typedef struct SWIMDrive SWIMDrive;
> > +typedef struct SWIMBus SWIMBus;
> > +typedef struct SWIMCtrl SWIMCtrl;
> > +
> > +#define TYPE_SWIM_DRIVE "swim-drive"
> > +#define SWIM_DRIVE(obj) OBJECT_CHECK(SWIMDrive, (obj), TYPE_SWIM_DRIVE=
)
> > +
> > +struct SWIMDrive {
> > +    DeviceState qdev;
> > +    int32_t     unit;
> > +    BlockConf   conf;
> > +};
> > +
> > +#define TYPE_SWIM_BUS "swim-bus"
> > +#define SWIM_BUS(obj) OBJECT_CHECK(SWIMBus, (obj), TYPE_SWIM_BUS)
> > +
> > +struct SWIMBus {
> > +    BusState bus;
> > +    struct SWIMCtrl *ctrl;
> > +};
> > +
> > +typedef struct FDrive {
> > +    SWIMCtrl *swimctrl;
> > +    BlockBackend *blk;
> > +    BlockConf *conf;
> > +} FDrive;
> > +
> > +struct SWIMCtrl {
> > +    MemoryRegion iomem;
> > +    FDrive drives[SWIM_MAX_FD];
> > +    int mode;
> > +    /* IWM mode */
> > +    int iwm_switch;
> > +    int regs[8];
> > +#define IWM_PH0   0
> > +#define IWM_PH1   1
> > +#define IWM_PH2   2
> > +#define IWM_PH3   3
> > +#define IWM_MTR   4
> > +#define IWM_DRIVE 5
> > +#define IWM_Q6    6
> > +#define IWM_Q7    7
> > +    uint8_t iwm_data;
> > +    uint8_t iwm_mode;
> > +    /* SWIM mode */
> > +    uint8_t swim_phase;
> > +    uint8_t swim_mode;
> > +    SWIMBus bus;
> > +};
> > +
> > +#define TYPE_SWIM "swim"
> > +#define SWIM(obj) OBJECT_CHECK(SWIM, (obj), TYPE_SWIM)
> > +
> > +typedef struct SWIM {
> > +    SysBusDevice parent_obj;
> > +    SWIMCtrl     ctrl;
> > +} SWIM;
> > +#endif
> > --
> > 2.21.0
> >
> >
