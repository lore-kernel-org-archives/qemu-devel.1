Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E880C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65A4207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 14:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHWWBIj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65A4207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeJnI-0003I4-4E
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 10:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jeJmV-00025K-D3; Thu, 28 May 2020 10:45:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1jeJmU-0007kl-7H; Thu, 28 May 2020 10:45:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id s8so28144193wrt.9;
 Thu, 28 May 2020 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d3ltzdDbXnDkCSxomOmC7d6RepuetyjNXF6KptKZLhQ=;
 b=AHWWBIj05Cs2aDC6focOC/2bncLkrMpCwo3Ha8aq7R6MzhcmUQHcMKbWmgf534aIfE
 Lj0U3yYkDmzx87E0yYttrpsDvQrIU9Ysrm5JBHFLRibVDjGa8ZnzQu2a/AqXs1L6mK0X
 HvQAcDqceUve2wqu2X3xBraZCMwJdqmqbXtoWvDWEyTGO1Z18PkWzLNLiTPawAgXg0Wv
 vbeAYGuQxnc5ZHSsDap2Bkrm1fOYpIn8fPf3GewrCLOqRus+EuTIvn+zIDh/gB2B5cY5
 JheuXkSWRWpjEl07eVX17ywZ5wAa+fXDnq41vV+bG1omLst5Rnu2jH5pIiVOuBOt7Y83
 ydRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d3ltzdDbXnDkCSxomOmC7d6RepuetyjNXF6KptKZLhQ=;
 b=EE2doiNZqwWfdfdJqJxifatwN8rTcykD9sKd0Nlbvj48C6MAuA1kDKpUQF4dyMJG51
 32ZGplcQxbb9XqsmPp0aKP4tYUGZDaVRPwdvBGM/nMQnbj8cNe4YvB9v4VZJ4Os1+G9/
 Rm7EeyRY9g6P+nHWpExE4WC/AW1c0K1El9y2HrGWz4UjB+RRzBZGP3KThNbluD6LYDET
 0WyhXybzeWKzGmdSTsKM0wHxySlbNhNxe+HEgx1lkOvZ+ieIwCB9fKUmHmmyZfByKaIB
 JKu9LJup99yJdNKRpoRwVff/+faDTXCuBX7nKG1MYNT2qk+hBxNo4qEk/HT/0SQuD7YR
 70uA==
X-Gm-Message-State: AOAM530W6Lg889hsy8y+Jdu/rdBiBLtzuKPhyoXh5Zfo6s/H33e5PiYs
 yeVCWF+M6+YR89Z5gDzOJopQUhd0AEVAv7WdvuM=
X-Google-Smtp-Source: ABdhPJxUTILWb7o8gCdrcM+THs7VPaHZ46DhvHolcA/Vo0AlpOM2pLomveHaAxtDpQFvgHG7FnMA5UFXyXI9M2JlJYo=
X-Received: by 2002:a5d:608d:: with SMTP id w13mr3829831wrt.298.1590677112039; 
 Thu, 28 May 2020 07:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-5-stefanha@redhat.com>
In-Reply-To: <20200527102925.128013-5-stefanha@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 28 May 2020 16:45:01 +0200
Message-ID: <CAM9Jb+gFxmY6VMkLz8azP3gfJzhr-_WZtM+-K3b=dr8_0b2a-Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] virtio-blk: default num_queues to -smp N
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Automatically size the number of virtio-blk-pci request virtqueues to
> match the number of vCPUs.  Other transports continue to default to 1
> request virtqueue.
>
> A 1:1 virtqueue:vCPU mapping ensures that completion interrupts are
> handled on the same vCPU that submitted the request.  No IPI is
> necessary to complete an I/O request and performance is improved.
>
> Performance improves from 78k to 104k IOPS on a 32 vCPU guest with 101
> virtio-blk-pci devices (ioengine=libaio, iodepth=1, bs=4k, rw=randread
> with NVMe storage).
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/hw/virtio/virtio-blk.h | 2 ++
>  hw/block/virtio-blk.c          | 6 +++++-
>  hw/core/machine.c              | 1 +
>  hw/virtio/virtio-blk-pci.c     | 7 ++++++-
>  4 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> index 1e62f869b2..4e5e903f4a 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -30,6 +30,8 @@ struct virtio_blk_inhdr
>      unsigned char status;
>  };
>
> +#define VIRTIO_BLK_AUTO_NUM_QUEUES UINT16_MAX
> +
>  struct VirtIOBlkConf
>  {
>      BlockConf conf;
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index f5f6fc925e..3c36b38255 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1135,6 +1135,9 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          error_setg(errp, "Device needs media, but drive is empty");
>          return;
>      }
> +    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
> +        conf->num_queues = 1;
> +    }
>      if (!conf->num_queues) {
>          error_setg(errp, "num-queues property must be larger than 0");
>          return;
> @@ -1274,7 +1277,8 @@ static Property virtio_blk_properties[] = {
>  #endif
>      DEFINE_PROP_BIT("request-merging", VirtIOBlock, conf.request_merging, 0,
>                      true),
> -    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues, 1),
> +    DEFINE_PROP_UINT16("num-queues", VirtIOBlock, conf.num_queues,
> +                       VIRTIO_BLK_AUTO_NUM_QUEUES),
>      DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 256),
>      DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
>      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index df7664bc8d..4aba3bdd3c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -29,6 +29,7 @@
>  #include "migration/vmstate.h"
>
>  GlobalProperty hw_compat_5_0[] = {
> +    { "virtio-blk-device", "num-queues", "1"},
>      { "virtio-scsi-device", "num_queues", "1"},
>      { "vhost-scsi", "num_queues", "1"},
>      { "vhost-user-scsi", "num_queues", "1"},
> diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
> index 28838fa958..2f0ede3863 100644
> --- a/hw/virtio/virtio-blk-pci.c
> +++ b/hw/virtio/virtio-blk-pci.c
> @@ -50,9 +50,14 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VirtIOBlkPCI *dev = VIRTIO_BLK_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> +    VirtIOBlkConf *conf = &dev->vdev.conf;
> +
> +    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
> +        conf->num_queues = virtio_pci_optimal_num_queues(0);
> +    }
>
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = dev->vdev.conf.num_queues + 1;
> +        vpci_dev->nvectors = conf->num_queues + 1;
>      }
>
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));

Looks good to me.
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

