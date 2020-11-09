Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CEAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5A6206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9NsaPHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5A6206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc9hs-0003Xm-Pb
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:07:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kc9gg-0002mY-BY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kc9gd-0002M2-S1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604937989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSdMlSipEdCLUNmVsb7Rsg/YPQOJi4XNuIuJm203tRM=;
 b=E9NsaPHf/O9W24vIJwVoDKupUr6wI9vZLmqWhbsfJQLrh3q75PHZJ/R0RNzCcNCAt0GRTa
 EbWE6t7KtrN5xL80yDp/0FGmeupfsU7WeXW55An5TOuJLsfW09iXs36L7gqzDBhqhtK34q
 XOQSBTwCeMJnzAGDg5SphcXaMxjp97U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-eRQQVAwSNcKBhLBj0E0JXA-1; Mon, 09 Nov 2020 11:06:28 -0500
X-MC-Unique: eRQQVAwSNcKBhLBj0E0JXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF51111CC7E3;
 Mon,  9 Nov 2020 16:06:26 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72E7F1A4D8;
 Mon,  9 Nov 2020 16:06:19 +0000 (UTC)
Date: Mon, 9 Nov 2020 17:06:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio-blk-ccw: tweak the default for num_queues
Message-ID: <20201109170616.6875f610.cohuck@redhat.com>
In-Reply-To: <20201109154831.20779-1-pasic@linux.ibm.com>
References: <20201109154831.20779-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  9 Nov 2020 16:48:31 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> Currently the default value of num_queues is effectively 1 for
> virtio-blk-ccw. Recently 9445e1e15e ("virtio-blk-pci: default num_queues
> to -smp N") changed the default for pci to the number of vcpus, citing
> interrupt better locality and better performance as a rationale.
> 
> While virtio-blk-ccw does not yet benefit from better interrupt
> locality, measurements have shown that for secure VMs multiqueue does
> help with performance. Since the bounce buffering happens with the queue
> lock held (in the guest) this is hardly a surprise.
> 
> As for non-secure VMs the extra queues shouldn't hurt too much.
> 
> Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> 
> We would prefer to land this for 5.2. If we do then commit 9445e1e15e
> ("virtio-blk-pci: default num_queues to -smp N") took care of all the
> necessary compat handling.
> 
> If that's not possible, I will send a version that does the necessary
> compat handling.

I think we can still get this into 5.2, and that would indeed be less
hassle.

> ---
>  hw/s390x/virtio-ccw-blk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
> index 2294ce1ce4..7296140dde 100644
> --- a/hw/s390x/virtio-ccw-blk.c
> +++ b/hw/s390x/virtio-ccw-blk.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio.h"
>  #include "qapi/error.h"
> @@ -20,6 +21,11 @@ static void virtio_ccw_blk_realize(VirtioCcwDevice *ccw_dev, Error **errp)
>  {
>      VirtIOBlkCcw *dev = VIRTIO_BLK_CCW(ccw_dev);
>      DeviceState *vdev = DEVICE(&dev->vdev);
> +    VirtIOBlkConf *conf = &dev->vdev.conf;
> +
> +    if (conf->num_queues == VIRTIO_BLK_AUTO_NUM_QUEUES) {
> +        conf->num_queues = MIN(4, current_machine->smp.cpus);
> +    }

I would like to have a comment explaining the numbers here, however.

virtio-pci has a pretty good explanation (use 1:1 for vqs:vcpus if
possible, apply some other capping). 4 seems to be a bit arbitrary
without explanation, although I'm sure you did some measurements :)

Do we also want something similar for virtio-scsi (and vhost-scsi)?

>  
>      qdev_realize(vdev, BUS(&ccw_dev->bus), errp);
>  }
> 
> base-commit: 2a190a7256a3e0563b29ffd67e0164097b4a6dac


