Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B31C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291972145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291972145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIbt-0005P9-1R
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hnIbK-0003Vi-Is
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hnIbI-0005YT-J7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:14:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hnIbI-0005Xe-DN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:14:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5225A307CDD1;
 Tue, 16 Jul 2019 08:14:15 +0000 (UTC)
Received: from redhat.com (ovpn-117-158.ams2.redhat.com [10.36.117.158])
 by smtp.corp.redhat.com (Postfix) with SMTP id D76BA5D721;
 Tue, 16 Jul 2019 08:14:02 +0000 (UTC)
Date: Tue, 16 Jul 2019 04:14:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190716041205-mutt-send-email-mst@kernel.org>
References: <20190716033719.2866-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716033719.2866-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 16 Jul 2019 08:14:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/1] Add check for header length in
 virtio-net-tx
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

On Tue, Jul 16, 2019 at 03:38:00AM +0000, Oleinik, Alexander wrote:
> While fuzzing the virtio-net tx vq, I ran into an assertion failure due
> to iov_copy offsets larger than the total iov size. Though there is
> a check to cover this, it does not execute when !n->has_vnet_hdr. This
> patch tries to fix this. 
> 
> The call stack for the assertion failure:
> 
> #8 in __assert_fail (libc.so.6+0x300f1)
> #9 in iov_copy iov.c:266:5
> #10 in virtio_net_flush_tx virtio-net.c:2073:23
> #11 in virtio_net_tx_bh virtio-net.c:2197:11
> #12 in aio_bh_poll async.c:118:13
> #13 in aio_dispatch aio-posix.c:460:5
> #14 in aio_ctx_dispatch async.c:261:5
> #15 in g_main_context_dispatch (libglib-2.0.so.0+0x4df2d)
> #16 in glib_pollfds_poll main-loop.c:213:9
> #17 in os_host_main_loop_wait main-loop.c:236
> #18 in main_loop_wait main-loop.c:512
> #19 in virtio_net_tx_fuzz virtio-net-fuzz.c:160:3
> 
> Thanks
> -Alex

I think I'd rather introduce a variant of iov_copy
that returns the remaining offset.

the code that duplicates this for byte-swap seems to
also have this problem.


> Alexander Oleinik (1):
>   virtio-net: check guest header length is valid
> 
>  hw/net/virtio-net.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> -- 
> 2.20.1

