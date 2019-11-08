Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3313DC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E33222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E33222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5F4-0008Hf-NH
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iT5Da-0006kU-H6
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iT5DZ-0007C2-1S
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:26:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iT5DY-0007BY-P1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:26:28 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A12E85D615
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 14:26:27 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id a16so6905744qka.10
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 06:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=igyz/t7JL0SuEcqvyOjr4JStX+7L3TSXEICdD7eCZBk=;
 b=UNf7KOTLfWrqoN07M2weTwgT0NZw/lbBLHM8g7nZZG4rtPDgoNqX4JrJ0kXsezRvl5
 fRB3+R/SXY2L0wnHTOgZ/bRSFZkR0NFFmpbZYDkn6vTNlCfuxkZRB4XlP15Sbu0mIdN1
 hy/NorOJQPH8dW0Dv29SMY+LvzWeiVKCdkyLicalDrS4qCrDTWQMsHOmuxZuzhDpTWlf
 sSXOK92yxqWqIv7jnQVje0iYJ1C0JOper5ySR+778kAMeABhnFdWaEDPP6wQ73bFuure
 iNp33JV8oIsVH2N4VrdXDbPjKi0PYu3BqApLIUYq94aYXOjws6WGlX12tvE91W+zbjC5
 bOqw==
X-Gm-Message-State: APjAAAWClME/xBUTcw85caA8u8CK2mB8v+e+iKrLDpuT1wCav5EmsmIc
 qlzuE3ZiD7AI9XRzrfaORg1z+TuMdjnO06aeSBE5lz5feXnn2of9MI1F4eSc+XqK4affb9kZxWA
 H27ETwLIXFe7hA80=
X-Received: by 2002:ac8:2a42:: with SMTP id l2mr10980587qtl.64.1573223187001; 
 Fri, 08 Nov 2019 06:26:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwanKxIOklgQpbI35zE1lAuOvCo78pnZU5E6TR560Zcp+CjUPOsZ+BMfZC2V8slUu0+Yej9Ig==
X-Received: by 2002:ac8:2a42:: with SMTP id l2mr10980574qtl.64.1573223186843; 
 Fri, 08 Nov 2019 06:26:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id e17sm3482239qtk.65.2019.11.08.06.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 06:26:26 -0800 (PST)
Date: Fri, 8 Nov 2019 09:26:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v2 1/1] virtio: make seg_max virtqueue size dependent
Message-ID: <20191108092457-mutt-send-email-mst@kernel.org>
References: <20191108134249.19004-1-dplotnikov@virtuozzo.com>
 <20191108134249.19004-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108134249.19004-2-dplotnikov@virtuozzo.com>
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
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 04:42:49PM +0300, Denis Plotnikov wrote:
> seg_max has a restriction to be less or equal to virtqueue size
> according to Virtio 1.0 specification
> 
> Although seg_max can't be set directly, it's worth to express this
> dependancy directly in the code for sanity purpose.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>

Guest visible so please make this depend on machine type.

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

