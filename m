Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F54C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 01:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6827722C7E
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 01:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6827722C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrBFw-0006NU-I6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 21:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bo.liu@linux.alibaba.com>) id 1hr819-0003oo-Rc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bo.liu@linux.alibaba.com>) id 1hr80n-00018O-AD
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:44:36 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59467)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bo.liu@linux.alibaba.com>)
 id 1hr80h-0006hr-05
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:44:21 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=bo.liu@linux.alibaba.com; NM=1;
 PH=DS; RN=3; SR=0; TI=SMTPD_---0TXrnCxE_1564176941; 
Received: from US-160370MP2.local(mailfrom:bo.liu@linux.alibaba.com
 fp:SMTPD_---0TXrnCxE_1564176941) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 27 Jul 2019 05:35:42 +0800
Date: Fri, 26 Jul 2019 14:35:40 -0700
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190726213540.mpqdzjrtn6mbcst6@US-160370MP2.local>
References: <20190726091103.23503-1-stefanha@redhat.com>
 <20190726091103.23503-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726091103.23503-2-stefanha@redhat.com>
User-Agent: NeoMutt/20180323
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 115.124.30.45
X-Mailman-Approved-At: Fri, 26 Jul 2019 21:11:54 -0400
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 1/5] virtiofsd: skip
	unnecessary	vu_queue_get_avail_bytes()
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
Reply-To: bo.liu@linux.alibaba.com
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 10:10:59AM +0100, Stefan Hajnoczi wrote:
> When debug output is disabled there is no need to calculate the number
> of in/out bytes available.
> 
> There is also no need to skip a request if there are 0 out bytes.  The
> request parsing code already handles invalid requests.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  contrib/virtiofsd/fuse_virtio.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virtio.c
> index 083e4fc317..d543c6d30f 100644
> --- a/contrib/virtiofsd/fuse_virtio.c
> +++ b/contrib/virtiofsd/fuse_virtio.c
> @@ -507,18 +507,16 @@ static void *fv_queue_thread(void *opaque)
>                 ret = pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
>                 assert(ret == 0); /* there is no possible error case */
>  
> -               /* out is from guest, in is too guest */
> -               unsigned int in_bytes, out_bytes;
> -               vu_queue_get_avail_bytes(dev, q, &in_bytes, &out_bytes, ~0, ~0);
> +               if (se->debug) {
> +                       /* out is from guest, in is too guest */
> +                       unsigned int in_bytes, out_bytes;
> +                       vu_queue_get_avail_bytes(dev, q, &in_bytes, &out_bytes, ~0, ~0);
>  
> -               if (se->debug)
>                         fuse_debug("%s: Queue %d gave evalue: %zx available: in: %u out: %u\n",
>  				  __func__, qi->qidx, (size_t)evalue, in_bytes,
>  				  out_bytes);
> -
> -               if (!out_bytes) {
> -                       goto next;
>                 }
> +
>                 while (1) {
>                         bool allocated_bufv = false;
>                         struct fuse_bufvec bufv;
> @@ -708,7 +706,6 @@ static void *fv_queue_thread(void *opaque)
>                         elem = NULL;
>                  }
>  
> -next:
>                  pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
>          }
>          pthread_mutex_destroy(&ch.lock);
> -- 
> 2.21.0
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

thanks,
-liubo

