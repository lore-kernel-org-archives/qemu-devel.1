Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA7AC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8232238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8232238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqcJL-0001Aj-FW
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqcJA-0000dG-67
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqcJ8-00041d-NN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:53:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqcJ8-00041F-Gx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:53:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id k10so48803305qtq.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Adyr1wZzuqyWr7Zz/x/9o2UvcJ2uxqV0aXQ0xkIp87A=;
 b=hSi/xYxadxeTvfv0rOZGzZIgPQic+F+9dsHZafY20Z6OlUAe+ZidB6FHyRpFYjplxL
 xHUP41siuhXkU/NzoDa6cny6K9tKgcjOXiJ90BL/xHW/V3SEV3ny8Il4oQtZtsHpHgv4
 X1gdkSkuwuphoh79+4Acn9RN9cxUctcqDwEqApVRj+Vy5a6Q3R2DGJib7qy3ENf1HLIG
 vq46CLUusZFYgP4IMP+Yawnjd9bSL9KAv11pCEAT7Xt7eU2NTAu+bzk+Fq+SVlb+Nmwo
 6D/08nB2+M+SSjId0mVlPzKD8/ct71RBgO1Ma1ddlS1kNwCUe+9EyKXRtsDG04zfaKuL
 f5+g==
X-Gm-Message-State: APjAAAXH2xTGszNihlJfHvVis1fnnWsOeJugWfEZV9o8gjI8cKXwxf5W
 oi2nPll8usWB3tzi7KegmFbOOQ==
X-Google-Smtp-Source: APXvYqwE8HqnAkNR/66lUHbgNyzeuCeOAeiIO89AsIxp9Pcm3fC/eeF+QKL2oYY5O6f84s2OkgOYfQ==
X-Received: by 2002:ad4:4423:: with SMTP id e3mr50030186qvt.145.1564055593935; 
 Thu, 25 Jul 2019 04:53:13 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 z1sm25321053qkg.103.2019.07.25.04.53.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 04:53:12 -0700 (PDT)
Date: Thu, 25 Jul 2019 07:53:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190725075054-mutt-send-email-mst@kernel.org>
References: <20190725113638.4702-1-david@redhat.com>
 <20190725113638.4702-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725113638.4702-7-david@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 6/7] virtio-balloon: Use
 temporary PBP only
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 01:36:37PM +0200, David Hildenbrand wrote:
> We still have multiple issues in the current code
> - The PBP is not freed during unrealize()
> - The PBP is not reset on device resets: After a reset, the PBP is stale.
> - We are not indicating VIRTIO_BALLOON_F_MUST_TELL_HOST, therefore
>   guests (esp. legacy guests) will reuse pages without deflating,
>   turning the PBP stale. Adding that would require compat handling.
> 
> Instead, let's use the PBP only temporarily, when processing one bulk of
> inflation requests. This will keep guest_page_size > 4k working (with
> Linux guests). There is nothing to do for deflation requests anymore.
> The pbp is only used for a limited amount of time.
> 
> Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE <
>                      host page size")
> Cc: qemu-stable@nongnu.org #v4.0.0
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c         | 21 +++++++++------------
>  include/hw/virtio/virtio-balloon.h |  3 ---
>  2 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 40d493a31a..a6282d58d4 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -34,11 +34,11 @@
>  
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
>  
> -struct PartiallyBalloonedPage {
> +typedef struct PartiallyBalloonedPage {
>      ram_addr_t base_gpa;
>      long subpages;
>      unsigned long *bitmap;
> -};
> +} PartiallyBalloonedPage;
>  
>  static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
>  {
> @@ -68,11 +68,11 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
>  }
>  
>  static void balloon_inflate_page(VirtIOBalloon *balloon,
> -                                 MemoryRegion *mr, hwaddr mr_offset)
> +                                 MemoryRegion *mr, hwaddr mr_offset,
> +                                 PartiallyBalloonedPage **pbp)
>  {
>      void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
>      ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
> -    PartiallyBalloonedPage **pbp = &balloon->pbp;
>      RAMBlock *rb;
>      size_t rb_page_size;
>      int subpages;
> @@ -149,12 +149,6 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>      rb = qemu_ram_block_from_host(addr, false, &rb_offset);
>      rb_page_size = qemu_ram_pagesize(rb);
>  
> -    if (balloon->pbp) {
> -        /* Let's play safe and always reset the pbp on deflation requests. */
> -        virtio_balloon_pbp_free(balloon->pbp);
> -        balloon->pbp = NULL;
> -    }
> -
>      host_addr = (void *)((uintptr_t)addr & ~(rb_page_size - 1));
>  
>      /* When a page is deflated, we hint the whole host page it lives
> @@ -336,6 +330,7 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> +    PartiallyBalloonedPage *pbp = NULL;
>      VirtQueueElement *elem;
>      MemoryRegionSection section;
>  
> @@ -344,7 +339,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>          uint32_t pfn;
>          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>          if (!elem) {
> -            return;
> +            break;
>          }
>  
>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) == 4) {
> @@ -373,7 +368,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>              if (!qemu_balloon_is_inhibited()) {
>                  if (vq == s->ivq) {
>                      balloon_inflate_page(s, section.mr,
> -                                         section.offset_within_region);
> +                                         section.offset_within_region, &pbp);
>                  } else if (vq == s->dvq) {
>                      balloon_deflate_page(s, section.mr, section.offset_within_region);
>                  } else {
> @@ -387,6 +382,8 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>          virtio_notify(vdev, vq);
>          g_free(elem);
>      }
> +
> +    virtio_balloon_pbp_free(pbp);
>  }
>  
>  static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *vq)

Oops this is not early enough.
We must not track pbp across elements: once we push an element
guest can reuse the page.

I propose changing virtio_balloon_pbp_free to get
PartiallyBalloonedPage** and set it to NULL.

Call that within the loop after g_free(elem);




> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 5a99293a45..d1c968d237 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -33,8 +33,6 @@ typedef struct virtio_balloon_stat_modern {
>         uint64_t val;
>  } VirtIOBalloonStatModern;
>  
> -typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
> -
>  enum virtio_balloon_free_page_report_status {
>      FREE_PAGE_REPORT_S_STOP = 0,
>      FREE_PAGE_REPORT_S_REQUESTED = 1,
> @@ -70,7 +68,6 @@ typedef struct VirtIOBalloon {
>      int64_t stats_last_update;
>      int64_t stats_poll_interval;
>      uint32_t host_features;
> -    PartiallyBalloonedPage *pbp;
>  
>      bool qemu_4_0_config_size;
>  } VirtIOBalloon;
> -- 
> 2.21.0

