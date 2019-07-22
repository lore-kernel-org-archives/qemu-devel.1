Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83D3C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C134521993
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C134521993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUsx-0004LD-Vu
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48213)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hpUsl-000418-H3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hpUsj-0007xM-P0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:45:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hpUsd-0007qr-JW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:45:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so38647712wru.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 02:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eLbTseSIZMBS6DjEv4D23nhknPKmlRjzxNITFUjOJlk=;
 b=PI0vqULbkdpyBFNbcn/2YEDPe+BO7pTXRuz7rLMvb5EWtdyUDTo+W2OdAHNpHuW615
 Ag1tQUXsyuF5fm60jLdf4SeffRWX73tNsnT+imnhITdjt7dTYQ4dmLQgd2DrrZEq+Fjx
 vQTxUXihX1JV8X48A6aKd5kaPYEoDdt4h4kKdj81U2NbPhZ7U90g7UEfqAEnsqjfq5Nb
 cTqkFQqkEp3ldwdSwcEDOSejwXHsPAFzmYN5KoivhHcCW+JXNtsTnXP9M66xft6hufSE
 rBJxltm2TeHpWSZMiej6iWqrIK4Vf+TWfj2HZVGb8hPsSf+xbN1hVuiHn8WBFybMK8Zq
 q4nw==
X-Gm-Message-State: APjAAAV+OLxKkEq5iblTf2qDLlzC7gY0KNI+NrylJmlq6xOI8Sa8dOjt
 DHDn1IqUAmWyO+heI6IYQDn/7w==
X-Google-Smtp-Source: APXvYqzHX+EVxGpZqzuI5B3Nv7W0OZwNG82AknniTaV3sqeKGujxriYw0rxGxqHGyO1VZdjTT5kfjw==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr28434282wrv.104.1563788711994; 
 Mon, 22 Jul 2019 02:45:11 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id f2sm31795357wrq.48.2019.07.22.02.45.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 02:45:11 -0700 (PDT)
Date: Mon, 22 Jul 2019 11:45:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190722094503.uvohavtmz5shwb6m@steredhat>
References: <20190719151920.22586-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719151920.22586-1-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
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

Should we merge the conditions? In this way:

           if (n->has_vnet_hdr && n->needs_vnet_hdr_swap) {


Thanks,
Stefano

