Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10E8C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 12:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7429822C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 12:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7429822C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqczc-0005CV-MU
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 08:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hqczT-0004o5-7I
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hqczS-0005Oo-7q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 08:36:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>)
 id 1hqczS-0005OH-2B; Thu, 25 Jul 2019 08:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A193D308427C;
 Thu, 25 Jul 2019 12:36:55 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9506160148;
 Thu, 25 Jul 2019 12:36:55 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 00EAA1800205;
 Thu, 25 Jul 2019 12:36:54 +0000 (UTC)
Date: Thu, 25 Jul 2019 08:36:54 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <748941041.4528533.1564058214607.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190725113638.4702-2-david@redhat.com>
References: <20190725113638.4702-1-david@redhat.com>
 <20190725113638.4702-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.53, 10.4.195.23]
Thread-Topic: virtio-balloon: Fix wrong sign extension of PFNs
Thread-Index: jz5vhQP+4366z+KjHUdULHkZ4ANVgA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 25 Jul 2019 12:36:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 1/7] virtio-balloon: Fix wrong
 sign extension of PFNs
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> 
> If we directly cast from int to uint64_t, we will first sign-extend to
> an int64_t, which is wrong. We actually want to treat the PFNs like
> unsigned values.
> 
> As far as I can see, this dates back to the initial virtio-balloon
> commit, but wasn't triggered as fairly big guests would be required.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index e85d1c0d5c..515abf6553 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -343,8 +343,8 @@ static void virtio_balloon_handle_output(VirtIODevice
> *vdev, VirtQueue *vq)
>          }
>  
>          while (iov_to_buf(elem->out_sg, elem->out_num, offset, &pfn, 4) ==
>          4) {                                                         
> +            unsigned int p = virtio_ldl_p(vdev, &pfn);
>              hwaddr pa;
> -            int p = virtio_ldl_p(vdev, &pfn);
>  
>              pa = (hwaddr) p << VIRTIO_BALLOON_PFN_SHIFT;
>              offset += 4;
> --
> 2.21.0

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 
> 
> 

