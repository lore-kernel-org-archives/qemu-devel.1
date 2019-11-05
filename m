Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAABC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC7B21A49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC7B21A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5oA-0007d4-Mm
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iS5nP-0006gB-Va
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iS5nN-0001WW-Pr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:51:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iS5nN-0001W8-H9
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:51:21 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 873653680C
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 20:51:20 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id l5so23733684qtj.8
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=myWYIXR6IB1ss3HjAfXCUvzwmmV21wTalY306PQ59GI=;
 b=cfKnH4AePAGTImQN51KoJS+gLQeeABfGIWokviTWjRDam+cePPIv0HpfS/KCmjs96L
 kVrb8cewkw/cPaoIgfE3kmBdiqLWY6bD1r57gRepNcpxHbiXdcZ/7pHe/XE7s/ZdzA7w
 nFt9jzuUgbwmpc5rCsOOHfNDcy4jSGv6kFjXkj5vFmYbTQV84cgXYImbdCrHroz2ldQq
 H3owBaZjt6HRhobvsb+yum3gcWtbbWzlFVCwH4RGsXG/68XqpXS7vguY8ExpTnLNo26k
 SfljmlBYDFIWOUge9mn+7O4oAzSpwRZLYfGkpGT0yTi8BUciMj5eiWb39puh4fv5pZgp
 Fg0g==
X-Gm-Message-State: APjAAAUiqU39oa40FQ8xVgDFiToyxm3P/ZTyUqLiFoGxiQNaMWT310Xo
 AiMaFJsQ2OS7ScxBU+U+3lp5agPiOotelH3xGdD/wwBbGk8oLlXx0KVM2Rr9b3Q0wfuktTBfYhq
 ltT0ZGAdrTX/anq4=
X-Received: by 2002:a37:4a83:: with SMTP id x125mr2847058qka.229.1572987079784; 
 Tue, 05 Nov 2019 12:51:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+d9xbt/+s9I3/hNonk7K5O6yzktrdPqalTaXb/s1Z/SfTWOIuyLraNLcYpIiIGdPGGdi+dQ==
X-Received: by 2002:a37:4a83:: with SMTP id x125mr2847043qka.229.1572987079512; 
 Tue, 05 Nov 2019 12:51:19 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id n62sm12039785qkn.47.2019.11.05.12.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 12:51:18 -0800 (PST)
Date: Tue, 5 Nov 2019 15:51:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: make seg_max virtqueue size dependent
Message-ID: <20191105155033-mutt-send-email-mst@kernel.org>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-3-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105161105.19016-3-dplotnikov@virtuozzo.com>
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

On Tue, Nov 05, 2019 at 07:11:03PM +0300, Denis Plotnikov wrote:
> seg_max has a restriction to be less or equal to virtqueue size
> according to Virtio 1.0 specification
> 
> Although seg_max can't be set directly, it's worth to express this
> dependancy directly in the code for sanity purpose.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

This is guest visible so needs to be machine type dependent, right?

> ---
>  hw/block/virtio-blk.c | 2 +-
>  hw/scsi/virtio-scsi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 06e57a4d39..21530304cf 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -903,7 +903,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      blk_get_geometry(s->blk, &capacity);
>      memset(&blkcfg, 0, sizeof(blkcfg));
>      virtio_stq_p(vdev, &blkcfg.capacity, capacity);
> -    virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
> +    virtio_stl_p(vdev, &blkcfg.seg_max, s->conf.queue_size - 2);
>      virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>      virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>      virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_size);
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 839f120256..f7e5533cd5 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -650,7 +650,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>      VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(vdev);
>  
>      virtio_stl_p(vdev, &scsiconf->num_queues, s->conf.num_queues);
> -    virtio_stl_p(vdev, &scsiconf->seg_max, 128 - 2);
> +    virtio_stl_p(vdev, &scsiconf->seg_max, s->conf.virtqueue_size - 2);
>      virtio_stl_p(vdev, &scsiconf->max_sectors, s->conf.max_sectors);
>      virtio_stl_p(vdev, &scsiconf->cmd_per_lun, s->conf.cmd_per_lun);
>      virtio_stl_p(vdev, &scsiconf->event_info_size, sizeof(VirtIOSCSIEvent));
> -- 
> 2.17.0

