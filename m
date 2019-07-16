Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50059C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201F621721
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201F621721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIP8-0004UJ-4v
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55658)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hnIOs-00045v-VZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hnIOo-0004LI-4S
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hnIOn-0004KI-Db
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2A6CB2DCE;
 Tue, 16 Jul 2019 08:01:19 +0000 (UTC)
Received: from redhat.com (ovpn-117-158.ams2.redhat.com [10.36.117.158])
 by smtp.corp.redhat.com (Postfix) with SMTP id 862F15C21A;
 Tue, 16 Jul 2019 08:01:12 +0000 (UTC)
Date: Tue, 16 Jul 2019 04:01:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190716035715-mutt-send-email-mst@kernel.org>
References: <20190716033719.2866-1-alxndr@bu.edu>
 <20190716033719.2866-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716033719.2866-2-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 16 Jul 2019 08:01:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-net: check guest header length
 is valid
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 03:38:09AM +0000, Oleinik, Alexander wrote:
> virtio-net checks that the "out" sg is longer than the guest header, but
> this check can be skipped if has_net_hdr is 0. Also perform this check
> if host_hdr_len != guest_hdr_len

This explanation is way less clear than what you have in 0/1.
I suggest you just move the log here.

> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  hw/net/virtio-net.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index b9e1cd71cf..46d715b4f5 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2064,7 +2064,18 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>           */
>          assert(n->host_hdr_len <= n->guest_hdr_len);
>          if (n->host_hdr_len != n->guest_hdr_len) {
> -            unsigned sg_num = iov_copy(sg, ARRAY_SIZE(sg),
> +            unsigned sg_num;
> +
> +            if (!n->has_vnet_hdr) {
> +                if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
> +                    n->guest_hdr_len) {
> +                    virtio_error(vdev, "virtio-net header incorrect");
> +                    virtqueue_detach_element(q->tx_vq, elem, 0);
> +                    g_free(elem);
> +                    return -EINVAL;
> +                }
> +            }

This code is duplicated from above. I also suspect some parts are missing
here (such as header endian-ness swap).
Pls find a way not to duplicate the code.


> +            sg_num = iov_copy(sg, ARRAY_SIZE(sg),
>                                         out_sg, out_num,
>                                         0, n->host_hdr_len);
>              sg_num += iov_copy(sg + sg_num, ARRAY_SIZE(sg) - sg_num,
> -- 
> 2.20.1

