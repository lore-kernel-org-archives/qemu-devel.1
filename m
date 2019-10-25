Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884CFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B99721D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B99721D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyCk-0004zv-SO
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iNyAm-0001sL-C8
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iNyAl-0005k3-2T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55864)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iNyAk-0005js-PH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:54:27 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2CC54E83C
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 11:54:25 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id x186so1876589qke.13
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zb6YgR0hIiMHrv+5yCzw8Xz9gSiAoTrwF1e0xzhkUCM=;
 b=FJAe6OnsevF0j4/uRvqsyGq6OG248c4wo4mwfNVU6CDxr9dwZzeBilcVMeTYAY+3GT
 xt0kJyVPT5Aaw2WZvmYkyuW9GtBm0bCTyyCcY76nIBf0Y6a9Fy5BEidWIuif7TJ4d8Yb
 4K/rfX3IZl57EplbQjKm4kuhuFznmZyvuYPUNppRvdHZ/CVx25ztgqNes6UqeylersFH
 Fn+nwe89W2x95f1X7MKfgS9wN+8bvUpiK9ZDGEZT6aOZyUufMJ0dRRgQjTBWrMaB0jPr
 bfZHVx4O+q3bbMYKrsx4HnpBqoAwpSpn03i5Lg1DXLdVDyJ8kjzMRylN80AIBOFWjoiP
 42wA==
X-Gm-Message-State: APjAAAWlbab4If2pAhK/zIP0QAxhejtT5PDCidkf9F/MuV/d68fC6MU4
 /XmmZJORbNQbXNtezXiaD/t3ARL9t0YpxzHeACLjWocewBoUltlRD1V/qizaLowCJ/F+CzA48lK
 RCAT2qRm5H7k/EFk=
X-Received: by 2002:a0c:98ca:: with SMTP id g10mr2829585qvd.48.1572004465140; 
 Fri, 25 Oct 2019 04:54:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTMScwSeARfFiOVntBgvcRNc7QGDatpkwDAHjwnKmwZ+KIB2itgidSyxQ6rUjAjQI6m3N82w==
X-Received: by 2002:a0c:98ca:: with SMTP id g10mr2829568qvd.48.1572004464805; 
 Fri, 25 Oct 2019 04:54:24 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 o38sm1184884qtc.39.2019.10.25.04.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:54:23 -0700 (PDT)
Date: Fri, 25 Oct 2019 07:54:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] virito: Use auto rcu_read macros
Message-ID: <20191025075225-mutt-send-email-mst@kernel.org>
References: <20191014175440.152609-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014175440.152609-1-dgilbert@redhat.com>
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 14, 2019 at 06:54:40PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
> to replace the manual rcu_read_(un)lock calls.
> 
> I think the only change is virtio_load which was missing unlocks
> in error paths; those end up being fatal errors so it's not
> that important anyway.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Can you rebase on top of packed ring support please?
They are in my queue now.


> ---
>  hw/virtio/virtio.c | 46 ++++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 527df03bfd..15ae9da60b 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -337,7 +337,7 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
>          return;
>      }
>  
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>          vring_set_avail_event(vq, vring_avail_idx(vq));
>      } else if (enable) {
> @@ -349,7 +349,6 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
>          /* Expose avail event/used flags before caller checks the avail idx. */
>          smp_mb();
>      }
> -    rcu_read_unlock();
>  }
>  
>  int virtio_queue_ready(VirtQueue *vq)
> @@ -393,9 +392,8 @@ int virtio_queue_empty(VirtQueue *vq)
>          return 0;
>      }
>  
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      empty = vring_avail_idx(vq) == vq->last_avail_idx;
> -    rcu_read_unlock();
>      return empty;
>  }
>  
> @@ -530,10 +528,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
>  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
>                      unsigned int len)
>  {
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      virtqueue_fill(vq, elem, len, 0);
>      virtqueue_flush(vq, 1);
> -    rcu_read_unlock();
>  }
>  
>  /* Called within rcu_read_lock().  */
> @@ -624,7 +621,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
>          return;
>      }
>  
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      idx = vq->last_avail_idx;
>      total_bufs = in_total = out_total = 0;
>  
> @@ -719,7 +716,6 @@ done:
>      if (out_bytes) {
>          *out_bytes = out_total;
>      }
> -    rcu_read_unlock();
>      return;
>  
>  err:
> @@ -869,7 +865,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>      if (unlikely(vdev->broken)) {
>          return NULL;
>      }
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      if (virtio_queue_empty_rcu(vq)) {
>          goto done;
>      }
> @@ -977,7 +973,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>      trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
>  done:
>      address_space_cache_destroy(&indirect_desc_cache);
> -    rcu_read_unlock();
>  
>      return elem;
>  
> @@ -1680,13 +1675,10 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
>  
>  void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
>  {
> -    bool should_notify;
> -    rcu_read_lock();
> -    should_notify = virtio_should_notify(vdev, vq);
> -    rcu_read_unlock();
> -
> -    if (!should_notify) {
> -        return;
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        if (!virtio_should_notify(vdev, vq)) {
> +            return;
> +        }
>      }
>  
>      trace_virtio_notify_irqfd(vdev, vq);
> @@ -1718,13 +1710,10 @@ static void virtio_irq(VirtQueue *vq)
>  
>  void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
>  {
> -    bool should_notify;
> -    rcu_read_lock();
> -    should_notify = virtio_should_notify(vdev, vq);
> -    rcu_read_unlock();
> -
> -    if (!should_notify) {
> -        return;
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        if (!virtio_should_notify(vdev, vq)) {
> +            return;
> +        }
>      }
>  
>      trace_virtio_notify(vdev, vq);
> @@ -2241,7 +2230,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>          vdev->start_on_kick = true;
>      }
>  
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      for (i = 0; i < num; i++) {
>          if (vdev->vq[i].vring.desc) {
>              uint16_t nheads;
> @@ -2289,7 +2278,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>              }
>          }
>      }
> -    rcu_read_unlock();
>  
>      return 0;
>  }
> @@ -2422,21 +2410,19 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
>  
>  void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
>  {
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      if (vdev->vq[n].vring.desc) {
>          vdev->vq[n].last_avail_idx = vring_used_idx(&vdev->vq[n]);
>          vdev->vq[n].shadow_avail_idx = vdev->vq[n].last_avail_idx;
>      }
> -    rcu_read_unlock();
>  }
>  
>  void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
>  {
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>      if (vdev->vq[n].vring.desc) {
>          vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
>      }
> -    rcu_read_unlock();
>  }
>  
>  void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
> -- 
> 2.23.0

