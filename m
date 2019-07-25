Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29625C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0360821951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0360821951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfg7-00032B-AN
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hqffv-0002Wm-P6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hqffu-0000lm-JE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hqffr-0000kD-N7; Thu, 25 Jul 2019 11:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08CAC300CA4D;
 Thu, 25 Jul 2019 15:28:55 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A18D1001E75;
 Thu, 25 Jul 2019 15:28:53 +0000 (UTC)
Message-ID: <08fa9a1e04f8c92d66897b57054b0cf6fc5c3cb7.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:28:52 +0300
In-Reply-To: <20190724171239.8764-4-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-4-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 25 Jul 2019 15:28:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/11] block: Add
 bdrv_has_zero_init_truncate()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-07-24 at 19:12 +0200, Max Reitz wrote:
> No .bdrv_has_zero_init() implementation returns 1 if growing the file
> would add non-zero areas (at least with PREALLOC_MODE_OFF), so using it
> in lieu of this new function was always safe.
> 
> But on the other hand, it is possible that growing an image that is not
> zero-initialized would still add a zero-initialized area, like when
> using nonpreallocating truncation on a preallocated image.  For callers
> that care only about truncation, not about creation with potential
> preallocation, this new function is useful.
> 
> Alternatively, we could have added a PreallocMode parameter to
> bdrv_has_zero_init().  But the only user would have been qemu-img
> convert, which does not have a plain PreallocMode value right now -- it
> would have to parse the creation option to obtain it.  Therefore, the
> simpler solution is to let bdrv_has_zero_init() inquire the
> preallocation status and add the new bdrv_has_zero_init_truncate() that
> presupposes PREALLOC_MODE_OFF.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h     |  1 +
>  include/block/block_int.h |  7 +++++++
>  block.c                   | 21 +++++++++++++++++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 50a07c1c33..5321d8afdf 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -438,6 +438,7 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
>  int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
>  int bdrv_has_zero_init_1(BlockDriverState *bs);
>  int bdrv_has_zero_init(BlockDriverState *bs);
> +int bdrv_has_zero_init_truncate(BlockDriverState *bs);
>  bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
>  bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
>  int bdrv_block_status(BlockDriverState *bs, int64_t offset,
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 6a0b1b5008..d7fc6b296b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -420,9 +420,16 @@ struct BlockDriver {
>      /*
>       * Returns 1 if newly created images are guaranteed to contain only
>       * zeros, 0 otherwise.
> +     * Must return 0 if .bdrv_has_zero_init_truncate() returns 0.
>       */
>      int (*bdrv_has_zero_init)(BlockDriverState *bs);
>  
> +    /*
> +     * Returns 1 if new areas added by growing the image with
> +     * PREALLOC_MODE_OFF contain only zeros, 0 otherwise.
> +     */
> +    int (*bdrv_has_zero_init_truncate)(BlockDriverState *bs);
> +
>      /* Remove fd handlers, timers, and other event loop callbacks so the event
>       * loop is no longer in use.  Called with no in-flight requests and in
>       * depth-first traversal order with parents before child nodes.
> diff --git a/block.c b/block.c
> index cbd8da5f3b..81ae44dcf3 100644
> --- a/block.c
> +++ b/block.c
> @@ -5066,6 +5066,27 @@ int bdrv_has_zero_init(BlockDriverState *bs)
>      return 0;
>  }
>  
> +int bdrv_has_zero_init_truncate(BlockDriverState *bs)
> +{
> +    if (!bs->drv) {
> +        return 0;
> +    }
> +
> +    if (bs->backing) {
> +        /* Depends on the backing image length, but better safe than sorry */
> +        return 0;
> +    }
> +    if (bs->drv->bdrv_has_zero_init_truncate) {
> +        return bs->drv->bdrv_has_zero_init_truncate(bs);
> +    }
> +    if (bs->file && bs->drv->is_filter) {
> +        return bdrv_has_zero_init_truncate(bs->file->bs);
> +    }
> +
> +    /* safe default */
> +    return 0;
> +}
> +
>  bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
>  {
>      BlockDriverInfo bdi;


This looks like a very correct change, even for the sake
of clarifying the scope of bdrv_has_zero_init

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


