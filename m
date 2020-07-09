Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82002C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F5620775
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrqYjRDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F5620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtatU-0006wC-L7
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jtasa-0006I9-Oe; Thu, 09 Jul 2020 14:02:40 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jtasX-000282-Nw; Thu, 09 Jul 2020 14:02:40 -0400
Received: by mail-io1-xd41.google.com with SMTP id c16so3259536ioi.9;
 Thu, 09 Jul 2020 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pmnUHE1g5H4ARsnL8UFYPaCxu0JQzL+RMI4VjmyHhdI=;
 b=FrqYjRDdrahtybavb1F+amGxKJ8THvYbAZ2nDOQG5eet+YiJ3Dg/hux5ea8jHf46hY
 nFoSle9okGw+RP82sjxmKM/DNXATuALHCgGsoQuUYmc65QzYMbYCHsj0CqAdVhHwUvKs
 fGk4+SpotQD48vGdzCWzrhZ3viHwIyfHskRR+7tt0f/Jqle80YvRfh9m6ZIUR5YIK9Hx
 x0iz2paB/60wYIKFbOEcGzT7WPwE+Xm+7FNtySz8kMLQFN3t6K8k3UzmvgoRG2q4PcJR
 oowma9vu06Hw42L/PXpyKQRDe+N0iLS2DhiUgjdGot9lpnMzfdAHRXCDzGG3Xm6NBwmB
 ZetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pmnUHE1g5H4ARsnL8UFYPaCxu0JQzL+RMI4VjmyHhdI=;
 b=ASoM9q3TRNN7hffbCiWS3zL0tBN6rsK2Sb54gLvZFp1mk+PdYouNn4oV4EYyQCNYhr
 735BZrL1KbQz74kP5xCvihE6ygFUHv5IPw3s3eG/MPC/AXAITYPiBrUvithAV2KxSrQ+
 f8g8mdSxHD1FT80BWKKeIAW0AwpRpvVmXIy2FkKb5oKAyAaKRU5NgZsZJFilW6Obn65C
 XyPqCmd9jcBz5g3MbBs4SWD+sKDq1aSWW3t74YgNr/Z0JFrfxW4ALxgS2PpjQ5B+/5As
 IReRBZoiSNWroIMySZ2n4MXjcivSKiBte4PhrK6heqlSZFeHYuAIy4zblPPA3ZxM2maG
 ar7Q==
X-Gm-Message-State: AOAM531jE3l1tMpeyQwkZ9AUvZWxwNpKKzpIziQVsglas9J/aniPB0RT
 nnltR4t88UkFoAaEfV3Clzh4qFIowEiblSZAFOs=
X-Google-Smtp-Source: ABdhPJwxecKa6b+yi4EQlfzjJITojKgjXRIvKdIMqDeVeuEAKSlKn7giL61ApGEFOyDao7qu2N+hvynS6LbnQ62umSE=
X-Received: by 2002:a02:cb92:: with SMTP id u18mr51262192jap.143.1594317755555; 
 Thu, 09 Jul 2020 11:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-6-stefanha@redhat.com>
In-Reply-To: <20200706135650.438362-6-stefanha@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Jul 2020 11:02:24 -0700
Message-ID: <CAFubqFsSTv_j_46sq=+Kz7uDnk8eYvB+moCLNeuV8nG9YKzb7A@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] vhost-user-blk: default num_queues to -smp N
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 6, 2020 at 7:00 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Automatically size the number of request virtqueues to match the number
> of vCPUs.  This ensures that completion interrupts are handled on the
> same vCPU that submitted the request.  No IPI is necessary to complete
> an I/O request and performance is improved.  The maximum number of MSI-X
> vectors and virtqueues limit are respected.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/hw/virtio/vhost-user-blk.h | 2 ++
>  hw/block/vhost-user-blk.c          | 6 +++++-
>  hw/core/machine.c                  | 1 +
>  hw/virtio/vhost-user-blk-pci.c     | 4 ++++
>  4 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
> index 34ad6f0c0e..292d17147c 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -25,6 +25,8 @@
>  #define VHOST_USER_BLK(obj) \
>          OBJECT_CHECK(VHostUserBlk, (obj), TYPE_VHOST_USER_BLK)
>
> +#define VHOST_USER_BLK_AUTO_NUM_QUEUES UINT16_MAX
> +
>  typedef struct VHostUserBlk {
>      VirtIODevice parent_obj;
>      CharBackend chardev;
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index a00b854736..39aec42dae 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -420,6 +420,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>
> +    if (s->num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
> +        s->num_queues = 1;
> +    }

What is this check for? Is it just a backstop to ensure that
num_queues is set to 1 if vhost-user-blk-pci doesn't update it?

>      if (!s->num_queues || s->num_queues > VIRTIO_QUEUE_MAX) {
>          error_setg(errp, "vhost-user-blk: invalid number of IO queues");
>          return;
> @@ -531,7 +534,8 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>
>  static Property vhost_user_blk_properties[] = {
>      DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> -    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues, 1),
> +    DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
> +                       VHOST_USER_BLK_AUTO_NUM_QUEUES),
>      DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
>      DEFINE_PROP_BIT("config-wce", VHostUserBlk, config_wce, 0, true),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 845f6476cb..31bfaacdb5 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -30,6 +30,7 @@
>
>  GlobalProperty hw_compat_5_0[] = {
>      { "vhost-scsi", "num_queues", "1"},
> +    { "vhost-user-blk", "num-queues", "1"},
>      { "vhost-user-scsi", "num_queues", "1"},
>      { "virtio-balloon-device", "page-poison", "false" },
>      { "virtio-blk-device", "num-queues", "1"},
> diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.c
> index 4f5d5cbf44..a62a71e067 100644
> --- a/hw/virtio/vhost-user-blk-pci.c
> +++ b/hw/virtio/vhost-user-blk-pci.c
> @@ -54,6 +54,10 @@ static void vhost_user_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      VHostUserBlkPCI *dev = VHOST_USER_BLK_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
>
> +    if (dev->vdev.num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
> +        dev->vdev.num_queues = virtio_pci_optimal_num_queues(0);
> +    }
> +
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
>          vpci_dev->nvectors = dev->vdev.num_queues + 1;
>      }
> --
> 2.26.2
>

