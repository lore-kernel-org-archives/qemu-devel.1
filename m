Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C4C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCF52173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCF52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJlE-00024o-EM
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSJZZ-0004Kh-1w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSJZW-0007ju-SO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44020)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSJZW-0007j3-Hi
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:33:58 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65E4437F41
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 11:33:57 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id s3so24442537qkd.6
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=72g8Wra91z8yFxDnl9sOYdg9cczFeTRFUIE9FCkWre8=;
 b=EAhv55NVGTHkAWCkCRQVxTFmpV/a1ibfzTjnRqzjQ7FW1OfAhn2XS7JlwF/Km4unzb
 tDEBSlaugFQQOQ10qVyS8akCVXGV9PjGYIcBzX/xyeXvDgK81iKBmHXGIgeTpRAl8FoX
 M7PB/+xJ0Ij8W7NqX8IWBCL3ws1ZX5bDrvVu48zHoh20sfs7dkXA6HkGZBYIwrpbtADV
 USogWd2vog6BJGoB5eJYVC6ojt+c/Tr7bnUu1LX4tvZXBMcBkX8XvNWec4c+zC6OYoUo
 ETkN2xu5Y3Tl2n3xIcI4NVyPcFD+BPC3lcM51vJ8Am9FUWyccHEXsJZFCvMcekNq1l/n
 0Bug==
X-Gm-Message-State: APjAAAW2od6mCisl1b+GaDUT29Qze06ZIQo2isUiNijGnehx6q2/LSin
 LF742qA4I8YPXxYWNi2N3QyX85mrIg9IA3auNLc/vKfw/awFbl3lY60Za2T3OUfX1SEz3Gp+lH8
 z5pvjUrsyeYBKZ1w=
X-Received: by 2002:aed:241c:: with SMTP id r28mr1956827qtc.148.1573040036710; 
 Wed, 06 Nov 2019 03:33:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwF2wgZs9htS/dwCzn5j4gymPdD5MyZLTqKkNNK3EEHP8rRrZBegKpewe5kY2zAl+xVIlSXcQ==
X-Received: by 2002:aed:241c:: with SMTP id r28mr1956812qtc.148.1573040036473; 
 Wed, 06 Nov 2019 03:33:56 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id t128sm4445039qke.4.2019.11.06.03.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:33:55 -0800 (PST)
Date: Wed, 6 Nov 2019 06:33:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio: notify virtqueue via host notifier when
 available
Message-ID: <20191106063344-mutt-send-email-mst@kernel.org>
References: <20191105140946.165584-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105140946.165584-1-stefanha@redhat.com>
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
Cc: Yongji Xie <elohimes@gmail.com>, qemu-devel@nongnu.org, felipe@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 03:09:46PM +0100, Stefan Hajnoczi wrote:
> Host notifiers are used in several cases:
> 1. Traditional ioeventfd where virtqueue notifications are handled in
>    the main loop thread.
> 2. IOThreads (aio_handle_output) where virtqueue notifications are
>    handled in an IOThread AioContext.
> 3. vhost where virtqueue notifications are handled by kernel vhost or
>    a vhost-user device backend.
> 
> Most virtqueue notifications from the guest use the ioeventfd mechanism,
> but there are corner cases where QEMU code calls virtio_queue_notify().
> This currently honors the host notifier for the IOThreads
> aio_handle_output case, but not for the vhost case.  The result is that
> vhost does not receive virtqueue notifications from QEMU when
> virtio_queue_notify() is called.
> 
> This patch extends virtio_queue_notify() to set the host notifier
> whenever it is enabled instead of calling the vq->(aio_)handle_output()
> function directly.  We track the host notifier state for each virtqueue
> separately since some devices may use it only for certain virtqueues.
> 
> This fixes the vhost case although it does add a trip through the
> eventfd for the traditional ioeventfd case.  I don't think it's worth
> adding a fast path for the traditional ioeventfd case because calling
> virtio_queue_notify() is rare when ioeventfd is enabled.
> 
> Reported-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

queued, thanks!

> ---
> v2:
>  * Track host notifier enabled/disabled state per virtqueue [Yongji Xie]
>  * Tested with contrib/vhost-user-blk and contrib/vhost-user-scsi
> 
>  hw/virtio/virtio-bus.c     | 4 ++++
>  hw/virtio/virtio.c         | 9 ++++++++-
>  include/hw/virtio/virtio.h | 1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index b2c804292e..d6332d45c3 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -288,6 +288,10 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
>          k->ioeventfd_assign(proxy, notifier, n, false);
>      }
>  
> +    if (r == 0) {
> +        virtio_queue_set_host_notifier_enabled(vq, assign);
> +    }
> +
>      return r;
>  }
>  
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 762df12f4c..04716b5f6c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -128,6 +128,7 @@ struct VirtQueue
>      VirtIODevice *vdev;
>      EventNotifier guest_notifier;
>      EventNotifier host_notifier;
> +    bool host_notifier_enabled;
>      QLIST_ENTRY(VirtQueue) node;
>  };
>  
> @@ -2271,7 +2272,7 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
>      }
>  
>      trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
> -    if (vq->handle_aio_output) {
> +    if (vq->host_notifier_enabled) {
>          event_notifier_set(&vq->host_notifier);
>      } else if (vq->handle_output) {
>          vq->handle_output(vdev, vq);
> @@ -3145,6 +3146,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
>          vdev->vq[i].vector = VIRTIO_NO_VECTOR;
>          vdev->vq[i].vdev = vdev;
>          vdev->vq[i].queue_index = i;
> +        vdev->vq[i].host_notifier_enabled = false;
>      }
>  
>      vdev->name = name;
> @@ -3436,6 +3438,11 @@ EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq)
>      return &vq->host_notifier;
>  }
>  
> +void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled)
> +{
> +    vq->host_notifier_enabled = enabled;
> +}
> +
>  int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
>                                        MemoryRegion *mr, bool assign)
>  {
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 3448d67d2a..c32a815303 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -312,6 +312,7 @@ int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
>  void virtio_device_release_ioeventfd(VirtIODevice *vdev);
>  bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
>  EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
> +void virtio_queue_set_host_notifier_enabled(VirtQueue *vq, bool enabled);
>  void virtio_queue_host_notifier_read(EventNotifier *n);
>  void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
>                                                  VirtIOHandleAIOOutput handle_output);
> -- 
> 2.23.0

