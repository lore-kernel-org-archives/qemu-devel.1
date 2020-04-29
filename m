Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D4FC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A73F214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqqCsvGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A73F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtOy-0007pa-IA
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTtNK-0006Ls-Bs
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTtJS-0005vQ-LI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:32:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTtJQ-0005ux-WA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588192087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSq3vZYAKDQjQAKE4D8xiqg+i+Lw+X1sipG4ALihLKA=;
 b=RqqCsvGRNDizl/YOm9LEZLd8yL3QMpe8nSrzYHf1H6w/1Vjhi+vCUEuD9gfmUdKkK7B18o
 nGgHNR0DVPeEvxExtvn3MYKy6+TNsevYaVQEQ5qVaspwMKHgfd/e3PFM38SIRGDQLYube/
 5bqe2SGdlzn9A/ugWp/gPpHeNkvtfdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-25s0jj-SNFunHBOX-sjpjw-1; Wed, 29 Apr 2020 16:28:03 -0400
X-MC-Unique: 25s0jj-SNFunHBOX-sjpjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06494800C78;
 Wed, 29 Apr 2020 20:28:01 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BCE35D780;
 Wed, 29 Apr 2020 20:27:50 +0000 (UTC)
Subject: Re: [PATCH v2 04/17] block/io: use int64_t bytes in driver wrappers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b9daa960-b607-6ef4-9dbb-67807d4fd13c@redhat.com>
Date: Wed, 29 Apr 2020 15:27:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427082325.10414-5-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:59:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths. Convert driver wrappers parameters which are
> already 64bit to signed type.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 1267918def..4796476835 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1086,7 +1086,7 @@ static void bdrv_co_io_em_complete(void *opaque, int ret)
>   }
>   
>   static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
> -                                           uint64_t offset, uint64_t bytes,
> +                                           int64_t offset, int64_t bytes,

Remains 64 bits, the question is whether any caller could pass in 
something larger than 63 bits.  Callers are:

bdrv_co_do_copy_on_readv() - passes 'int64_t pnum', but sets pnum in a 
fragmenting loop, MAX_BOUNCE_BUFFER when copy-on-read is needed, or 
max_transfer bounded by BDRV_REQUEST_MAX_BYTES otherwise
bdrv_aligned_preadv() - passes 'unsigned int bytes' further limited by 
fragmenting loop on max_transfer <= INT_MAX

Input is bounded to < 2G, internal use of 'bytes' is:
drv->bdrv_co_preadv_part(uint64_t) - safe
qemu_iovec_init_slice(size_t) - potential truncation on 32-bit platform, 
if you don't fix qemu_iovec
drv->bdrv_co_preadv(uint64_t) - safe
drv->bdrv_aio_preadv(uint64_t) - safe
drv->bdrv_co_readv(int) after assertion of <2G - safe

>                                              QEMUIOVector *qiov,
>                                              size_t qiov_offset, int flags)
>   {
> @@ -1155,7 +1155,7 @@ out:
>   }
>   
>   static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
> -                                            uint64_t offset, uint64_t bytes,
> +                                            int64_t offset, int64_t bytes,

Remains 64 bits, the question is whether any caller could pass in 
something larger than 63.  Callers are:

bdrv_co_do_copy_on_readv() - passes 'int64_t pnum', but set in a 
fragmenting loop bounded by MAX_BOUNCE_BUFFER
bdrv_co_do_pwrite_zeroes() - passes 'int num'
bdrv_aligned_pwritev() - passes 'unsigned int bytes' further limited by 
fragmenting loop on max_transfer <= INT_MAX

Input is bounded to < 2G, internal use of 'bytes' is:
drv->bdrv_co_pwritev_part(uint64_t) - safe
qemu_iovec_init_slice(size_t) - potential truncation on 32-bit platform, 
if you don't fix qemu_iovec
drv->bdrv_co_pwritev(uint64_t) - safe
drv->bdrv_aio_pwritev(uint64_t) - safe
drv->bdrv_co_writev(int) after assertion of <2G - safe

>                                               QEMUIOVector *qiov,
>                                               size_t qiov_offset, int flags)
>   {
> @@ -1235,8 +1235,8 @@ emulate_flags:
>   }
>   
>   static int coroutine_fn
> -bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
> -                               uint64_t bytes, QEMUIOVector *qiov,
> +bdrv_driver_pwritev_compressed(BlockDriverState *bs, int64_t offset,
> +                               int64_t bytes, QEMUIOVector *qiov,
>                                  size_t qiov_offset)

Remains 64 bits, the question is whether any caller could pass in 
something larger than 63.  Callers are:

bdrv_aligned_pwritev() - passes 'unsigned int bytes'

Input is bounded to < 4G, internal use of 'bytes' is:
drv->bdrv_co_pwritev_compressed_part(uint64_t) - safe
drv->bdrv_co_pwritev_compressed(uint64_t) - safe
qemu_iovec_init_slice(size_t) - potential truncation on 32-bit platform, 
if you don't fix qemu_iovec

Because our input is bounded, all of the changes made here have no 
semantic impact, and I argue this patch is safe.  However, I also 
pointed out the spots where we have latent bugs (on 32-bit machines 
only) if the callers are relaxed to pass larger than 2G or 4G.  As long 
as you are auditing things, it would be nice to either fix that in this 
patch, or document in the commit message how a future patch will address 
that latent problem (whether by enforcing max_transfer to be capped at 
2G on 32-bit platforms, or else fixing qemu_iovec to use int64_t instead 
of size_t bounds).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


