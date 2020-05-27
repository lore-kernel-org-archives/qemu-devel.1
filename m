Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D694DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35912073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoioiAJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35912073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtTM-0001O0-TF
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdtSR-00087M-8C
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:38:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdtSO-0006cn-V1
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590575922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kCc3ppbUp+qDLCpBZRvkskwQrZN2mktaeLteAVziNtA=;
 b=EoioiAJAexkQQvEcAFRKuYyRqsBISU3Cbs6FI7N+lqFGXqd1u4GXgjUV/XUmgyXHqA8QpY
 AMWmQB4zlFBlW01coerwizoODHNZwvJqX7Xig5SNux54NW0hrtoYiT6Ge2xaxl6nGBoHDy
 44ULpCk55MmDUko+Y4Y6OetwOkn/GGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-qN3UzAhoOn-wWE6429ANoQ-1; Wed, 27 May 2020 06:38:33 -0400
X-MC-Unique: qN3UzAhoOn-wWE6429ANoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC6D3107ACCA;
 Wed, 27 May 2020 10:38:31 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9780A60E1C;
 Wed, 27 May 2020 10:38:20 +0000 (UTC)
Date: Wed, 27 May 2020 11:38:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200527103817.GI2665520@redhat.com>
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-4-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200527102925.128013-4-stefanha@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 11:29:23AM +0100, Stefan Hajnoczi wrote:
> Automatically size the number of virtio-scsi-pci, vhost-scsi-pci, and
> vhost-user-scsi-pci request virtqueues to match the number of vCPUs.
> Other transports continue to default to 1 request virtqueue.

IIRC this was raised on earlier versions of the series, but i don't
recall the outcome and no caveats are mentioned here...

Is this default still valid for very large $vCPUs. eg if I run QEMU
with "-smp 512" or even larger (I've seen people discussing 1000's of
CPUs), is this going to cause problems with the virtio-scsi default
queue counts ? Is there such a thing as "too large" for the num
of queues setting ?   num vectors defaults to a value derived from
num queues, so is there concept of "too large" for num of vectors
setting ?

Ideally the commit message would answer these questions for future
reference.  Same for the next patch to virtio-blk

> 
> A 1:1 virtqueue:vCPU mapping ensures that completion interrupts are
> handled on the same vCPU that submitted the request.  No IPI is
> necessary to complete an I/O request and performance is improved.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/virtio/virtio-scsi.h |  2 ++
>  hw/core/machine.c               |  6 +++++-
>  hw/scsi/vhost-scsi.c            |  3 ++-
>  hw/scsi/vhost-user-scsi.c       |  3 ++-
>  hw/scsi/virtio-scsi.c           |  6 +++++-
>  hw/virtio/vhost-scsi-pci.c      | 10 +++++++---
>  hw/virtio/vhost-user-scsi-pci.c | 10 +++++++---
>  hw/virtio/virtio-scsi-pci.c     | 10 +++++++---
>  8 files changed, 37 insertions(+), 13 deletions(-)
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
> index bb3a7b18b1..df7664bc8d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,7 +28,11 @@
>  #include "hw/mem/nvdimm.h"
>  #include "migration/vmstate.h"
>  
> -GlobalProperty hw_compat_5_0[] = {};
> +GlobalProperty hw_compat_5_0[] = {
> +    { "virtio-scsi-device", "num_queues", "1"},
> +    { "vhost-scsi", "num_queues", "1"},
> +    { "vhost-user-scsi", "num_queues", "1"},
> +};
>  const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
>  
>  GlobalProperty hw_compat_4_2[] = {
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index c1b012aea4..5e3bc319ab 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -272,7 +272,8 @@ static Property vhost_scsi_properties[] = {
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
> index f8bd158c31..4b56de97a8 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -163,7 +163,8 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
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
> index f3d60683bd..f055ae7389 100644
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
> index 2b25db9a3c..9f377a84cf 100644
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
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
> index 80710ab170..2a4c0d27f1 100644
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
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> diff --git a/hw/virtio/virtio-scsi-pci.c b/hw/virtio/virtio-scsi-pci.c
> index c52d68053a..c3e2f8625a 100644
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
> 2.25.4
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


