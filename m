Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900F0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C6F2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CC6yg2cc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C6F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8s4t-0007vH-ER
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j8s4D-0007L0-NN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j8s4C-0005Ng-Df
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:53:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51317
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j8s4C-0005NF-6P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583182411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/Lfyuzm+TcuRZ/dcMxrvHuVEzbIC9b9g1qieX0PhI0=;
 b=CC6yg2ccofuXDTDIrGECITDnladxWlEzpjTJFhuxa4tPEzdGlFU+W23TSbPAGO746Tg8QZ
 /SFj+aXBUMO6uASb76uE9IUMY4irndv5zjoCvKVrcWc+MsmNSbxwicUUP2nJcNRSmdzD46
 yDOZZk5XsZ+Mw3D3x7PSeYKKIsCqddQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-_WBs9mwAMyCfRrChgHfLbA-1; Mon, 02 Mar 2020 15:53:27 -0500
X-MC-Unique: _WBs9mwAMyCfRrChgHfLbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17B84801E53;
 Mon,  2 Mar 2020 20:53:26 +0000 (UTC)
Received: from [10.3.117.157] (ovpn-117-157.phx2.redhat.com [10.3.117.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86E3C73862;
 Mon,  2 Mar 2020 20:53:14 +0000 (UTC)
Subject: Re: [PATCH 1/5] block/nbd-client: drop max_block restriction from
 block_status
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <363605b3-9c0f-7cb3-3241-9e534770e23e@redhat.com>
Date: Mon, 2 Mar 2020 14:53:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302100537.29058-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> NBD spec is updated, so that max_block doesn't relate to
> NBD_CMD_BLOCK_STATUS. So, drop the restriction.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 976be76647..2a58d6b91c 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1320,9 +1320,7 @@ static int coroutine_fn nbd_client_co_block_status(
>       NBDRequest request = {
>           .type = NBD_CMD_BLOCK_STATUS,
>           .from = offset,
> -        .len = MIN(MIN_NON_ZERO(QEMU_ALIGN_DOWN(INT_MAX,
> -                                                bs->bl.request_alignment),
> -                                s->info.max_block),
> +        .len = MIN(QEMU_ALIGN_DOWN(INT_MAX, bs->bl.request_alignment),
>                      MIN(bytes, s->info.size - offset)),

Reviewed-by: Eric Blake <eblake@redhat.com>

We're still capped at 32 bits (instead of status over the entire 
device), but future NBD extensions will get to that.  In the meantime, 
this is a lot nicer than having to stick to 32M per request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


