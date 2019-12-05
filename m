Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C268C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D0420801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmpKwj8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D0420801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icuks-0007Ki-3v
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icuiB-0005Lh-4E
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icui7-00076Y-83
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:14:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icui6-00074P-3b
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575566076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RBVp7/jhoMAIgl2+lZ2FetkRt3te+6sfkhKnbz8L9vU=;
 b=XmpKwj8cMMMsYDj2/U1YHOl0kKXSclNa4bypwWYoXUKjGKrHS1WbttvooQDCjKn19KhiAI
 IZ7E1cLbUznB84nh4Q7hIgIILo1bQAElZrsqBCQBygs/O6tqcN+dvNeKLZImX65xNUXOXH
 2pt6I0WCsQinRo3p6uKhOeOdOya6rCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-gV6yNmG-MlqENeeSqYfR0Q-1; Thu, 05 Dec 2019 12:14:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B35E1883538;
 Thu,  5 Dec 2019 17:14:32 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14DBC5D6A5;
 Thu,  5 Dec 2019 17:14:32 +0000 (UTC)
Subject: Re: [PATCH v7 21/21] nbd: assert that Error** is not NULL in
 nbd_iter_channel_error
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
 <20191205152019.8454-22-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c4ff448d-e756-9d95-b07e-4ae5f2d5b9b0@redhat.com>
Date: Thu, 5 Dec 2019 11:14:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205152019.8454-22-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gV6yNmG-MlqENeeSqYfR0Q-1
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

On 12/5/19 9:20 AM, Vladimir Sementsov-Ogievskiy wrote:
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

Why are we forbidding grandparent callers from passing NULL when they 
want to ignore an error?  We are called by several parent functions that 
get an errp from the grandparent, and use this function to do some 
common grunt work.  Let's look at the possibilities:

1. grandparent passes address of a local error: we want to append to the 
error message, parent will then deal with the error how it wants (report 
it, ignore it, propagate it, whatever)

2. grandparent passes &error_fatal: we want to append a hint, but before 
ERRP_AUTO_PROPAGATE, the parent has already exited.  After 
ERRP_AUTO_PROPAGATE, this looks like case 1.

3. grandparent passes &error_abort: we should never be reached (failure 
earlier in the parent should have already aborted) - true whether or not 
ERRP_AUTO_PROPAGATE is applied

4. grandparent passes NULL to ignore the error. Does not currently 
happen in any of the grandparent callers, because if it did, your 
assertion in this patch would now fire.  After ERRP_AUTO_PROPAGATE, this 
would look like case 1.

Would it be better to assert(!local_err || *local_err)?  The assertion 
as written is too strict without ERRP_AUTO_PROPAGATE, but you get away 
with it because none of the grandparents pass NULL; but is appropriate 
as written for after after the macro conversion so then we wonder if 
churn on the macro is worth it.

>       assert(ret < 0);
>   
>       if (!iter->ret) {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


