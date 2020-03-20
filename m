Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EB7C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E358320754
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtFtxHTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E358320754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFFNP-0001ep-1b
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jFFMh-0001Bu-AR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jFFMg-00026S-4A
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:58:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jFFMg-00025Y-0w
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584701937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kw/kfZ7qTMu1W5pAKuKaqmX1uwVXO4dDy84wqzzyI4g=;
 b=gtFtxHTQHicScyoF5U26e0NKGGde/NjME3TzzezkkyZzUo5Rj5rxMGsZSWNzGU5DwIfhAk
 H8Q83VUZZxm7UmFpNGorJ7e0OdiDS7rbP324PoGuE1M4wSWQyAd31Ke5NNHZnc4T0Lenuy
 NGacgnC9h72my9WTTavLVdXAgcQ+rQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-7rScMW-1O6OlPpQaaDZLog-1; Fri, 20 Mar 2020 06:58:54 -0400
X-MC-Unique: 7rScMW-1O6OlPpQaaDZLog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FE121005527;
 Fri, 20 Mar 2020 10:58:53 +0000 (UTC)
Received: from gondolin (ovpn-113-89.ams2.redhat.com [10.36.113.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0E95D9CA;
 Fri, 20 Mar 2020 10:58:42 +0000 (UTC)
Date: Fri, 20 Mar 2020 11:58:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RESEND v3 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200320115839.4d1e6285.cohuck@redhat.com>
In-Reply-To: <20200320103041.129527-3-stefanha@redhat.com>
References: <20200320103041.129527-1-stefanha@redhat.com>
 <20200320103041.129527-3-stefanha@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 10:30:39 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Automatically size the number of virtio-scsi-pci, vhost-scsi-pci, and
> vhost-user-scsi-pci request virtqueues to match the number of vCPUs.
> Other transports continue to default to 1 request virtqueue.
> 
> A 1:1 virtqueue:vCPU mapping ensures that completion interrupts are
> handled on the same vCPU that submitted the request.  No IPI is
> necessary to complete an I/O request and performance is improved.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/core/machine.c               |  3 +++
>  hw/scsi/vhost-scsi.c            |  3 ++-
>  hw/scsi/vhost-user-scsi.c       |  3 ++-
>  hw/scsi/virtio-scsi.c           |  6 +++++-
>  hw/virtio/vhost-scsi-pci.c      | 10 ++++++++--
>  hw/virtio/vhost-user-scsi-pci.c | 10 ++++++++--
>  hw/virtio/virtio-scsi-pci.c     | 10 ++++++++--
>  include/hw/virtio/virtio-scsi.h |  2 ++
>  8 files changed, 38 insertions(+), 9 deletions(-)

(...)

> diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
> index 5dce640eaf..a0b7cdc1ac 100644
> --- a/hw/virtio/vhost-scsi-pci.c
> +++ b/hw/virtio/vhost-scsi-pci.c
> @@ -17,6 +17,7 @@
>  #include "qemu/osdep.h"
>  
>  #include "standard-headers/linux/virtio_pci.h"
> +#include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/vhost-scsi.h"
>  #include "qapi/error.h"
> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
>      VHostSCSIPCI *dev = VHOST_SCSI_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> -    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(vdev);
> +    VirtIOSCSIConf *conf = &dev->vdev.parent_obj.parent_obj.conf;
> +
> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
> +    if (conf->num_queues == VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> +        conf->num_queues = current_machine->smp.cpus;

I don't recall the discussion from previous versions of this patch
set... do we need to bound this by the maximum number of virtqueues? It
seems unlikely that something will break from my reading of the code,
but it might still be nicer.

> +    }
>  
>      if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors = vs->conf.num_queues + 3;
> +        vpci_dev->nvectors = conf->num_queues + VIRTIO_SCSI_VQ_NUM_FIXED + 1;

You might already do the resolving of 3 into NUM_FIXED + 1 in the
previous patch; but as you touch this line anyway, I'd just keep this
if you don't need to respin.

>      }
>  
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));

(Same comments apply to the two other cases below.)


