Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC52B20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC52B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrSH-0004FP-Rq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMrQg-0003D6-ER
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMrQf-00063A-2c
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMrQe-00062k-Qc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:30:17 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8497085537
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:30:15 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n18so8907873wro.11
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kWFx4GJHHX1unc3yl5qkieSTvZybA3YQ8dkUz1v3gfQ=;
 b=fveMpxWMomssxTp79AULrMqAkkr31fDmGV/ziHVG3UwSKvQtdBvOQ1e7DszxBGIPuY
 AeFQ/KPPjHBotIKus1M8j2zhXeMdhdTi4BxeqHwwtIPyKhUeo0Xx1KaytzF2b5FYwQL8
 qMOQwQEbhSzI7V22pZWShp/jVXtKEzWYCrqv3VvM4slKdoWFCU4o5207wYn8GrU4pGG1
 hclHf+UFE60/Fc53SI/hyvuIrTDe8fjSjpx7kGeFKg+2tkUtzTRDfjqcMN6MsOx3VwA5
 r/wWfO++iRRRdenUAJhIusJHE/kndaR54++ntHTR5mOaCYcpOhkIhX2CVIEFift95LvG
 KEyQ==
X-Gm-Message-State: APjAAAVltGJA8tbpIuBviKZltz0UXdpwua5r0We9RctzhRgR1nWCbvCc
 qmat4qcAuowKf3fS/wwnzD+I6rGa+dA0Nvulrg1AkxWVZyt9x8RcdOpLfHn2tBpSaH8xU0E8bbl
 pgaUMIHfm6lXdrd4=
X-Received: by 2002:a1c:2c88:: with SMTP id s130mr2465031wms.66.1571740214253; 
 Tue, 22 Oct 2019 03:30:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwiM/ZLGIHbn43oGUu3rgNG8VB1ifjrhkAXBJLknYGCj3yP+s5p6LPQsaG398agXldXKyxnuQ==
X-Received: by 2002:a1c:2c88:: with SMTP id s130mr2464987wms.66.1571740213867; 
 Tue, 22 Oct 2019 03:30:13 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id q66sm18760474wme.39.2019.10.22.03.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 03:30:13 -0700 (PDT)
Subject: Re: [PATCH v8 5/8] bootdevice: Gather LCHS from all relevant devices
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20191016164145.115898-1-sameid@google.com>
 <20191016164145.115898-7-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2c3ddad-06c4-3c5c-3064-e80e94f9727c@redhat.com>
Date: Tue, 22 Oct 2019 12:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016164145.115898-7-sameid@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 jsnow@redhat.com, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, lersek@redhat.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 6:41 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>=20
> Relevant devices are:
>      * ide-hd (and ide-cd, ide-drive)
>      * scsi-hd (and scsi-cd, scsi-disk, scsi-block)
>      * virtio-blk-pci
>=20
> We do not call del_boot_device_lchs() for ide-* since we don't need to =
-
> IDE block devices do not support unplugging.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> Signed-off-by: Sam Eiderman <sameid@google.com>
> ---
>   hw/block/virtio-blk.c |  6 ++++++
>   hw/ide/qdev.c         |  5 +++++
>   hw/scsi/scsi-disk.c   | 12 ++++++++++++
>   3 files changed, 23 insertions(+)
>=20
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index ed2ddebd2b..c56e905f80 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1200,6 +1200,11 @@ static void virtio_blk_device_realize(DeviceStat=
e *dev, Error **errp)
>       blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size)=
;
>  =20
>       blk_iostatus_enable(s->blk);
> +
> +    add_boot_device_lchs(dev, "/disk@0,0",
> +                         conf->conf.lcyls,
> +                         conf->conf.lheads,
> +                         conf->conf.lsecs);
>   }
>  =20
>   static void virtio_blk_device_unrealize(DeviceState *dev, Error **err=
p)
> @@ -1207,6 +1212,7 @@ static void virtio_blk_device_unrealize(DeviceSta=
te *dev, Error **errp)
>       VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
>       VirtIOBlock *s =3D VIRTIO_BLK(dev);
>  =20
> +    del_boot_device_lchs(dev, "/disk@0,0");
>       virtio_blk_data_plane_destroy(s->dataplane);
>       s->dataplane =3D NULL;
>       qemu_del_vm_change_state_handler(s->change);
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 6dd219944f..2ffd387a73 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -220,6 +220,11 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriv=
eKind kind, Error **errp)
>  =20
>       add_boot_device_path(dev->conf.bootindex, &dev->qdev,
>                            dev->unit ? "/disk@1" : "/disk@0");
> +
> +    add_boot_device_lchs(&dev->qdev, dev->unit ? "/disk@1" : "/disk@0"=
,
> +                         dev->conf.lcyls,
> +                         dev->conf.lheads,
> +                         dev->conf.lsecs);
>   }
>  =20
>   static void ide_dev_get_bootindex(Object *obj, Visitor *v, const char=
 *name,
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 68b1675fd9..07fb5ebdf1 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -35,6 +35,7 @@
>   #include "hw/block/block.h"
>   #include "hw/qdev-properties.h"
>   #include "sysemu/dma.h"
> +#include "sysemu/sysemu.h"
>   #include "qemu/cutils.h"
>   #include "trace.h"
>  =20
> @@ -2414,6 +2415,16 @@ static void scsi_realize(SCSIDevice *dev, Error =
**errp)
>       blk_set_guest_block_size(s->qdev.conf.blk, s->qdev.blocksize);
>  =20
>       blk_iostatus_enable(s->qdev.conf.blk);
> +
> +    add_boot_device_lchs(&dev->qdev, NULL,
> +                         dev->conf.lcyls,
> +                         dev->conf.lheads,
> +                         dev->conf.lsecs);
> +}
> +
> +static void scsi_unrealize(SCSIDevice *dev, Error **errp)
> +{
> +    del_boot_device_lchs(&dev->qdev, NULL);
>   }
>  =20
>   static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
> @@ -3018,6 +3029,7 @@ static void scsi_hd_class_initfn(ObjectClass *kla=
ss, void *data)
>       SCSIDeviceClass *sc =3D SCSI_DEVICE_CLASS(klass);
>  =20
>       sc->realize      =3D scsi_hd_realize;
> +    sc->unrealize    =3D scsi_unrealize;
>       sc->alloc_req    =3D scsi_new_request;
>       sc->unit_attention_reported =3D scsi_disk_unit_attention_reported=
;
>       dc->desc =3D "virtual SCSI disk";
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

