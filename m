Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65893C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C6020665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C6020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAgvY-0005Bc-B0
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 16:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgtv-0003u0-EL
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgtu-0007FA-E1
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:50:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iAgts-0007Cc-97; Wed, 18 Sep 2019 16:50:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AA1E85537;
 Wed, 18 Sep 2019 20:50:07 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 402F560C18;
 Wed, 18 Sep 2019 20:49:57 +0000 (UTC)
Message-ID: <eea7d7f61e886a5eaa0277986acbe8f9a0a46d16.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 23:49:57 +0300
In-Reply-To: <20190918095144.955-3-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-3-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 18 Sep 2019 20:50:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/8] block/cor: Drop cor_co_truncate()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-09-18 at 11:51 +0200, Max Reitz wrote:
> No other filter driver has a .bdrv_co_truncate() implementation, and
> there is no need to because the general block layer code can handle it
> just as well.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/copy-on-read.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 6631f30205..e95223d3cb 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -73,13 +73,6 @@ static int64_t cor_getlength(BlockDriverState *bs)
>  }
>  
>  
> -static int coroutine_fn cor_co_truncate(BlockDriverState *bs, int64_t offset,
> -                                        PreallocMode prealloc, Error **errp)
> -{
> -    return bdrv_co_truncate(bs->file, offset, prealloc, errp);
> -}
> -
> -
>  static int coroutine_fn cor_co_preadv(BlockDriverState *bs,
>                                        uint64_t offset, uint64_t bytes,
>                                        QEMUIOVector *qiov, int flags)
> @@ -139,7 +132,6 @@ static BlockDriver bdrv_copy_on_read = {
>      .bdrv_child_perm                    = cor_child_perm,
>  
>      .bdrv_getlength                     = cor_getlength,
> -    .bdrv_co_truncate                   = cor_co_truncate,
>  
>      .bdrv_co_preadv                     = cor_co_preadv,
>      .bdrv_co_pwritev                    = cor_co_pwritev,
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




