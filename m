Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDF0C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FEC2068E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxYpVX4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FEC2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQJA-0006Kh-Mj
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 03:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pagupta@redhat.com>) id 1icQ66-0001ol-4n
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:33:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1icQ63-0004HR-Jz
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:33:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38332
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1icQ5y-0004Ct-5W
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575448393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6UGOlvOKi6PN/wm6Q9E3hg+GSFoLO3uURB2+RaSRKc=;
 b=HxYpVX4uctce7y5b62+q2ksoashwXC9CD+UmErjBXYpkiVXCuQwJjVuQEaT+3Bnc6IlH+k
 j3uQ2dfdJUxkj3+9q4gjKwKX4Xx1Z0zGWttD827YU3jVfhAoZ2OTfDJQPdJzRpqcMwleK2
 PrpixQVkdNPsUdA7pIpL8Q4qJbjiN3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-yrd6dsCLPKOwMc1aWjaplQ-1; Wed, 04 Dec 2019 03:33:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B8F3800C78;
 Wed,  4 Dec 2019 08:33:08 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D234691A2;
 Wed,  4 Dec 2019 08:33:08 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 1CAEC18095FF;
 Wed,  4 Dec 2019 08:33:07 +0000 (UTC)
Date: Wed, 4 Dec 2019 03:33:07 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
To: pannengyuan@huawei.com
Message-ID: <606337023.38890965.1575448387620.JavaMail.zimbra@redhat.com>
In-Reply-To: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
MIME-Version: 1.0
X-Originating-IP: [10.67.116.237, 10.4.195.1]
Thread-Topic: virtio: add ability to delete vq through a pointer
Thread-Index: r68BuNi/ZDw3LY3KXbIwL1IkiqUIWg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: yrd6dsCLPKOwMc1aWjaplQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: liyiting@huawei.com, kuhn chenqun <kuhn.chenqun@huawei.com>,
 zhang zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Devices tend to maintain vq pointers, allow deleting them trough a vq
> pointer.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes v2 to v1:
> - add a new function virtio_delete_queue to cleanup vq through a vq pointer
> ---
>  hw/virtio/virtio.c         | 16 +++++++++++-----
>  include/hw/virtio/virtio.h |  2 ++
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5..6de3cfd 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2330,17 +2330,23 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int
> queue_size,
>      return &vdev->vq[i];
>  }
>  
> +void virtio_delete_queue(VirtQueue *vq)
> +{
> +    vq->vring.num = 0;
> +    vq->vring.num_default = 0;
> +    vq->handle_output = NULL;
> +    vq->handle_aio_output = NULL;
> +    g_free(vq->used_elems);
> +    vq->used_elems = NULL;
> +}
> +
>  void virtio_del_queue(VirtIODevice *vdev, int n)
>  {
>      if (n < 0 || n >= VIRTIO_QUEUE_MAX) {
>          abort();
>      }
>  
> -    vdev->vq[n].vring.num = 0;
> -    vdev->vq[n].vring.num_default = 0;
> -    vdev->vq[n].handle_output = NULL;
> -    vdev->vq[n].handle_aio_output = NULL;
> -    g_free(vdev->vq[n].used_elems);
> +    virtio_delete_queue(&vdev->vq[n]);
>  }
>  
>  static void virtio_set_isr(VirtIODevice *vdev, int value)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c32a815..e18756d 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int
> queue_size,
>  
>  void virtio_del_queue(VirtIODevice *vdev, int n);
>  
> +void virtio_delete_queue(VirtQueue *vq);
> +
>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>                      unsigned int len);
>  void virtqueue_flush(VirtQueue *vq, unsigned int count);
> --
> 2.7.2.windows.1
> 
> 
Overall it ooks good to me.

Just one point: e.g in virtio_rng: "virtio_rng_device_unrealize" function
We are doing :     virtio_del_queue(vdev, 0);

One can directly call "virtio_delete_queue". It can become confusing
to call multiple functions for same purpose. Instead, Can we make 
"virtio_delete_queue" static inline?

Other than that:
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 
> 


