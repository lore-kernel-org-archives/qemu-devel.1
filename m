Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C3DC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B6122296
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B6122296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59785 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUB0-0003Ha-3r
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33341)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hpUAp-0002se-C6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hpUAo-0006KA-CP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 04:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hpUAo-0006Jk-74
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 04:59:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3EE402D1CE;
 Mon, 22 Jul 2019 08:59:57 +0000 (UTC)
Received: from redhat.com (ovpn-120-233.rdu2.redhat.com [10.10.120.233])
 by smtp.corp.redhat.com (Postfix) with SMTP id 285F960C05;
 Mon, 22 Jul 2019 08:59:49 +0000 (UTC)
Date: Mon, 22 Jul 2019 04:59:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190722045944-mutt-send-email-mst@kernel.org>
References: <20190719151920.22586-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719151920.22586-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 22 Jul 2019 08:59:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtio-net: Always check for guest
 header length
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
Cc: Jason Wang <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 03:21:15PM +0000, Oleinik, Alexander wrote:
> While fuzzing the virtio-net tx vq, I ran into an assertion failure due
> to iov_copy offsets larger than the total iov size. Though there is
> a check to cover this, it does not execute when !n->has_vnet_hdr. This
> change always copies the guest header into the mhdr buffer and checks its
> length, even if mhdr is not needed.
> 
> The call stack for the assertion failure:
> 
>  #8 in __assert_fail (libc.so.6+0x300f1)
>  #9 in iov_copy iov.c:266:5
>  #10 in virtio_net_flush_tx virtio-net.c:2073:23
>  #11 in virtio_net_tx_bh virtio-net.c:2197:11
>  #12 in aio_bh_poll async.c:118:13
>  #13 in aio_dispatch aio-posix.c:460:5
>  #14 in aio_ctx_dispatch async.c:261:5
>  #15 in g_main_context_dispatch (libglib-2.0.so.0+0x4df2d)
>  #16 in glib_pollfds_poll main-loop.c:213:9
>  #17 in os_host_main_loop_wait main-loop.c:236
>  #18 in main_loop_wait main-loop.c:512
>  #19 in virtio_net_tx_fuzz virtio-net-fuzz.c:160:3
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/net/virtio-net.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index b9e1cd71cf..003436b53c 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2035,14 +2035,19 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>              return -EINVAL;
>          }
>  
> -        if (n->has_vnet_hdr) {
> -            if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
> +        /*
> +         * Even if !n->has_vnet_hdr and we dont need mhdr, we still need this
> +         * to check that out_sg contains at least guest_hdr_len bytes
> +         */
> +        if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
>                  n->guest_hdr_len) {
> -                virtio_error(vdev, "virtio-net header incorrect");
> -                virtqueue_detach_element(q->tx_vq, elem, 0);
> -                g_free(elem);
> -                return -EINVAL;
> -            }
> +            virtio_error(vdev, "virtio-net header incorrect");
> +            virtqueue_detach_element(q->tx_vq, elem, 0);
> +            g_free(elem);
> +            return -EINVAL;
> +        }
> +
> +        if (n->has_vnet_hdr) {
>              if (n->needs_vnet_hdr_swap) {
>                  virtio_net_hdr_swap(vdev, (void *) &mhdr);
>                  sg2[0].iov_base = &mhdr;
> -- 
> 2.20.1

