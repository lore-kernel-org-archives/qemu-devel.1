Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A38C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 02:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA75206C0
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 02:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDUMEggI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA75206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9fTp-0006u1-Cx
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 22:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k9fTB-0006Ph-7y; Sat, 22 Aug 2020 22:10:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k9fT9-0005pZ-62; Sat, 22 Aug 2020 22:10:52 -0400
Received: by mail-ot1-x342.google.com with SMTP id z18so4576994otk.6;
 Sat, 22 Aug 2020 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L/Mqf6ffkZV9bihn+BYi5T0+5mxfVaHb4V7xXtjXYEo=;
 b=VDUMEggIeHLaaduH2rkjNrZEB0AXP8TfvU5Gq9tMvjtxB/lvdmS9Ujh3cipK1cDbkE
 kUs7aSX0lVE3erojXnIW+ruJ6IOrP0wNIH5kBhqE4vPxX5hYv77dcM74CJxKg+Vbxhce
 8jcFok93qHAck267G2bd4Az9CqYKVevndTEe2s3w6d3B5Hq8XrlDI0Z2kY/L+nnc3hCt
 7529FL27VULmpAxq59v+QMGdH64m/IzVs8jbPW3MaYzmaDmN0A5clMEkEXVLKywRnpYq
 Le6YBvjU+vifn9lCfym16yzyHfE+bcApVqSP54WtkpCOt4ixnri3Jfe+LaDU3HmXPuXw
 79xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L/Mqf6ffkZV9bihn+BYi5T0+5mxfVaHb4V7xXtjXYEo=;
 b=hdjZ4N3TaC9xlhrO9gTM/VloWKVwzZ+Pp7B8iULrEogjR1CbiyysP/AEbCAYAMtwlX
 QylFUW91ByC9RWkdScoMcJx+XcwvaevVgajgYt+1kY9NzX3WaPI1jWUyHcqinhUUdQxL
 IYYy+4rJOcKFSXhVx3AfK02/rR9ZQUiRLI5i4l1fRAsbcKhiU3exW9s+8uXsHzJ96F3V
 C+mR9nYfV2ddnNruHpBPpvfbeRSsZrnE64XdGtBA4K3dSOd2EOnk66eDOGBaKdFYpEj6
 ehIQiKYRxqLgs8rnJ7Kh6lPt9mFqIV1pdtdHQwx9muH5EB/ZeO4wP1vg1KyPW8MpGlDo
 nmUA==
X-Gm-Message-State: AOAM5321GJk4B9HT7puv1V3yeWxWzel13ePDgdVCm7YwuAfsmXSMpmVG
 p3UYxvGCb0Q/3hLySdk8N0JCMvbN9wtdAOMlqS0=
X-Google-Smtp-Source: ABdhPJwOh3K1Nlgz3aGswOtUfFZfSNMJWT+83ZdFqYP1oxYudrC6v4Cl8NHUN16m6zYCgqRMENHPvV73qeATwRz+tVY=
X-Received: by 2002:a9d:5914:: with SMTP id t20mr34810oth.337.1598148647711;
 Sat, 22 Aug 2020 19:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200818143348.310613-1-stefanha@redhat.com>
 <20200818143348.310613-6-stefanha@redhat.com>
In-Reply-To: <20200818143348.310613-6-stefanha@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 22 Aug 2020 22:10:36 -0400
Message-ID: <CAFubqFun8c7BGZXGZSK=gEX4mVt-rypd04R94ceT+2r7fVJL2A@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] virtio-scsi-pci: default num_queues to -smp N
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x342.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, cohuck@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 11:32 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Automatically size the number of virtio-scsi-pci, vhost-scsi-pci, and
> vhost-user-scsi-pci request virtqueues to match the number of vCPUs.
> Other transports continue to default to 1 request virtqueue.
>
> A 1:1 virtqueue:vCPU mapping ensures that completion interrupts are
> handled on the same vCPU that submitted the request.  No IPI is
> necessary to complete an I/O request and performance is improved.  The
> maximum number of MSI-X vectors and virtqueues limit are respected.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  include/hw/virtio/virtio-scsi.h |  2 ++
>  hw/core/machine.c               |  3 +++
>  hw/scsi/vhost-scsi.c            |  3 ++-
>  hw/scsi/vhost-user-scsi.c       |  3 ++-
>  hw/scsi/virtio-scsi.c           |  6 +++++-
>  hw/virtio/vhost-scsi-pci.c      | 10 +++++++---
>  hw/virtio/vhost-user-scsi-pci.c | 10 +++++++---
>  hw/virtio/virtio-scsi-pci.c     | 10 +++++++---
>  8 files changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
> index 9f293bcb80..c0b8e4dd7e 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -39,6 +39,8 @@
>  /* Number of virtqueues that are always present */
>  #define VIRTIO_SCSI_VQ_NUM_FIXED    2
>
> +#define VIRTIO_SCSI_AUTO_NUM_QUEUES UINT32_MAX
> +
>  typedef struct virtio_scsi_cmd_req VirtIOSCSICmdReq;
>  typedef struct virtio_scsi_cmd_resp VirtIOSCSICmdResp;
>  typedef struct virtio_scsi_ctrl_tmf_req VirtIOSCSICtrlTMFReq;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a6f7e4e8d7..9ee2aa0f7b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -29,6 +29,9 @@
>  #include "migration/vmstate.h"
>
>  GlobalProperty hw_compat_5_1[] = {
> +    { "vhost-scsi", "num_queues", "1"},
> +    { "vhost-user-scsi", "num_queues", "1"},
> +    { "virtio-scsi-device", "num_queues", "1"},
>  };
>  const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
>
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 13b05af29b..a83ffeefc8 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -270,7 +270,8 @@ static Property vhost_scsi_properties[] = {
>      DEFINE_PROP_STRING("vhostfd", VirtIOSCSICommon, conf.vhostfd),
>      DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
>      DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
> -    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
> +    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
> +                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
>      DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
>                         128),
>      DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adjust,
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a8b821466f..7c0631656c 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -162,7 +162,8 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
>  static Property vhost_user_scsi_properties[] = {
>      DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
>      DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
> -    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
> +    DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
> +                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
>      DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
>                         128),
>      DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index eecdd05af5..3a71ea7097 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -891,6 +891,9 @@ void virtio_scsi_common_realize(DeviceState *dev,
>      virtio_init(vdev, "virtio-scsi", VIRTIO_ID_SCSI,
>                  sizeof(VirtIOSCSIConfig));
>
> +    if (s->conf.num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> +        s->conf.num_queues = 1;
> +    }
>      if (s->conf.num_queues == 0 ||
>              s->conf.num_queues > VIRTIO_QUEUE_MAX - VIRTIO_SCSI_VQ_NUM_FIXED) {
>          error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
> @@ -964,7 +967,8 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
>  }
>
>  static Property virtio_scsi_properties[] = {
> -    DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues, 1),
> +    DEFINE_PROP_UINT32("num_queues", VirtIOSCSI, parent_obj.conf.num_queues,
> +                       VIRTIO_SCSI_AUTO_NUM_QUEUES),
>      DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSI,
>                                           parent_obj.conf.virtqueue_size, 256),
>      DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
> diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
> index 06e814d30e..a6bb0dc60d 100644
> --- a/hw/virtio/vhost-scsi-pci.c
> +++ b/hw/virtio/vhost-scsi-pci.c
> @@ -47,11 +47,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VHostSCSIPCI *dev = VHOST_SCSI_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> -    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
> +    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.parent_obj.conf;
> +
> +    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> +        conf->num_queues =
> +            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
> +    }
>
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues +
> -                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
> +        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;
>      }
>
>      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
> index ab6dfb71a9..25e97ca54e 100644
> --- a/hw/virtio/vhost-user-scsi-pci.c
> +++ b/hw/virtio/vhost-user-scsi-pci.c
> @@ -53,11 +53,15 @@ static void vhost_user_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VHostUserSCSIPCI *dev = VHOST_USER_SCSI_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> -    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
> +    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.parent_obj.conf;
> +
> +    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> +        conf->num_queues =
> +            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
> +    }
>
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues +
> -                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
> +        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;
>      }
>
>      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
> index 3ff9eb7ef6..fa4b3bfb50 100644
> --- a/hw/virtio/virtio-scsi-pci.c
> +++ b/hw/virtio/virtio-scsi-pci.c
> @@ -46,13 +46,17 @@ static void virtio_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VirtIOSCSIPCI *dev = VIRTIO_SCSI_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> -    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
>      DeviceState *proxy = DEVICE(vpci_dev);
> +    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.conf;
>      char *bus_name;
>
> +    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> +        conf->num_queues =
> +            virtio_pci_optimal_num_queues(VIRTIO_SCSI_VQ_NUM_FIXED);
> +    }
> +
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues +
> -                             VIRTIO_SCSI_VQ_NUM_FIXED + 1;
> +        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;
>      }
>
>      /*
> --
> 2.26.2
>

