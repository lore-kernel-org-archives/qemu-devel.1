Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AD6C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D510224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwCxX4PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D510224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvWX-0003r1-Kw
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icvIB-000477-HZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icvI5-0001KW-Oe
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:51:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55011
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icvI4-0001HI-68
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575568307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6IRygscvDQRfN+uRjPp3GRLkwr95YlWlZ3S5hbHLDI=;
 b=HwCxX4PIeZPPl3HFuEBpWRg0oC+Gzc/1AYxkLrOY/xkrw9P6QF/86w5zPQV2iE5mziBtY2
 uRChjGwuLbg6SK5RvSjGcPArW7BqF9Mle6Gr+kYhoJwdJTD82OFoCqcsHDWvGsHN4NIwkK
 KSUBJxeYE/TjntC9SX3E/67byQRobMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-bPZ0cWy8Nz2Ze4OF_6hwCQ-1; Thu, 05 Dec 2019 12:51:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97EBC800EB9;
 Thu,  5 Dec 2019 17:51:42 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16FA16A028;
 Thu,  5 Dec 2019 17:51:42 +0000 (UTC)
Subject: Re: [PATCH v8 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-22-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <54278946-ad45-1a0d-e2b2-f96b86285c05@redhat.com>
Date: Thu, 5 Dec 2019 11:51:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-22-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bPZ0cWy8Nz2Ze4OF_6hwCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 11:46 AM, Vladimir Sementsov-Ogievskiy wrote:
> The local_err parameter is not here to return information about
> nbd_iter_channel_error failure. Instead it's assumed to be filled when
> passed to the function. This is already stressed by its name
> (local_err, instead of classic errp). Stress it additionally by
> assertion.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 1 +
>   1 file changed, 1 insertion(+)

Our timing resulted in crossed mails - I was replying to v7 when this 
landed, and my reply there is still relevant (namely, a better commit 
message is needed, but the code gets my R-b with that change).

> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 5f18f78a94..d085554f21 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -866,6 +866,7 @@ typedef struct NBDReplyChunkIter {
>   static void nbd_iter_channel_error(NBDReplyChunkIter *iter,
>                                      int ret, Error **local_err)
>   {
> +    assert(local_err && *local_err);
>       assert(ret < 0);
>   
>       if (!iter->ret) {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


