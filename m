Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BCEC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D4E21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D4E21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50429 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6UF-0003mL-0S
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iS5sj-0005fB-PM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iS5si-0004av-Lc
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:56:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39700)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iS5si-0004af-CN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:56:52 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 85F5A4E919
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 20:56:50 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id l5so23747486qtj.8
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:56:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2FfkMyQD9KmRpQsiqaHQJo42cIRE8N5ktTT/ajnzwyw=;
 b=KmtEbt3LfmZrT5chFhEXzg35/g+jwcMCtJAkGf752IGBfhppS+O5ynMtmhTYUv9zH7
 4smJ6O2yC3NHslkfSm0pVM+KbZ4kU4LPlTp8M89MYSAoNUJHZUaZTE0GAFUAjd6xef2k
 AJPLzyABk0oGWaHjuJAdCHPi58lYqHZMS2oIm9pX091Kc2Lb0Qjtg1bMhL4QHnha1LIz
 oSL+guElTSHevDI4QKyTgMNt3Hf3jdNvpmeXV0oaYJMPEcgRqOszP2/jZEdAVJrLRXd3
 TCAAnM2CSDSTqIb9SeS02iAgPOi4Qdf7L+CEKVHabNYyoSh2DJN6tlrizAi/ubnloaRP
 K+1A==
X-Gm-Message-State: APjAAAX2rtWRuyEdJzh8yxlo01VQsHQ/rBlDOYT8w3a3ISyEEmbP1AjW
 QINGqS8Y1AztDU8jGX2LUr0RbUlpEp/L07vf5lllpHWUVgBLP3csa7s2DrVlqNwvDX36e9VL0TR
 AZO/b3TBOxSfQPrM=
X-Received: by 2002:ac8:27a2:: with SMTP id w31mr9005506qtw.227.1572987409781; 
 Tue, 05 Nov 2019 12:56:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQKaUAuYL/2pBZbsBbqylTSyqxiwa3oidTVSO8C5rtV7kHhQ3xLye9lRQBtPaoNTzmnHcvHw==
X-Received: by 2002:ac8:27a2:: with SMTP id w31mr9005482qtw.227.1572987409539; 
 Tue, 05 Nov 2019 12:56:49 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id r2sm13426436qtc.28.2019.11.05.12.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 12:56:48 -0800 (PST)
Date: Tue, 5 Nov 2019 15:56:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 1/4] virtio: protect non-modern devices from too big
 virtqueue size setting
Message-ID: <20191105155357-mutt-send-email-mst@kernel.org>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105161105.19016-2-dplotnikov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 07:11:02PM +0300, Denis Plotnikov wrote:
> The patch protects from creating illegal virtio device configuration
> via direct virtqueue size property setting.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/virtio/virtio-blk-pci.c  |  9 +++++++++
>  hw/virtio/virtio-scsi-pci.c | 10 ++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
> index 60c9185c39..6177ff1df8 100644
> --- a/hw/virtio/virtio-blk-pci.c
> +++ b/hw/virtio/virtio-blk-pci.c
> @@ -48,6 +48,15 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> +    bool modern = virtio_pci_modern(vpci_dev);
> +    uint32_t queue_size = dev->vdev.conf.queue_size;
> +
> +    if (!modern && queue_size > 128) {
> +        error_setg(errp,
> +                   "too big queue size (%u, max: 128) "
> +                   "for non-modern virtio device", queue_size);
> +        return;
> +    }


this enables for transitional so still visible to legacy
interface. I am guessing you want to check whether
device is accessed through the modern interface instead.

>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
>          vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;

> diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
> index 2830849729..6e6790fda5 100644
> --- a/hw/virtio/virtio-scsi-pci.c
> +++ b/hw/virtio/virtio-scsi-pci.c
> @@ -17,6 +17,7 @@
>  
>  #include "hw/virtio/virtio-scsi.h"
>  #include "virtio-pci.h"
> +#include "qapi/error.h"
>  
>  typedef struct VirtIOSCSIPCI VirtIOSCSIPCI;
>  
> @@ -47,6 +48,15 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
>      DeviceState *proxy = DEVICE(vpci_dev);
>      char *bus_name;
> +    bool modern = virtio_pci_modern(vpci_dev);
> +    uint32_t virtqueue_size = vs->conf.virtqueue_size;
> +
> +    if (!modern && virtqueue_size > 128) {
> +        error_setg(errp,
> +                   "too big virtqueue size (%u, max: 128) "
> +                   "for non-modern virtio device", virtqueue_size);
> +        return;
> +    }

why? what is illegal about 256 for legacy?

>  
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
>          vpci_dev->nvectors = vs->conf.num_queues + 3;
> -- 
> 2.17.0

