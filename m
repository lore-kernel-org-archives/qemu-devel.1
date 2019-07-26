Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6537C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913A6206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913A6206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqw9r-00028I-GE
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hqw9d-0001jD-Uo
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hqw9a-0007jq-GY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:04:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hqw9a-0007OU-5E
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:04:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so53559254wre.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CNUQzvaD/vDwOnujDCN9BOJS9uAgp3meNNhs7GoeCC4=;
 b=XPPlF+NZ87slvRd0/zDzlekiz5Ones9O3aj05hKy7Aofi4alDkMH7ngSl9XJqDU95l
 Su/1YBMMguR7gVf/vn9jx5ahfra6svb+oAlWcw9WNSSMotFJEv/CoxuQMMpobAqgOX1z
 icn0XTZC9g/X5mnKWmo0IqO9cr7mCBfkb7I730x2+JL7udQi1qUZSrSX22+rSxgQOLPz
 Cg4hTm9kJX3k08ruChFxEXx1KUXNI7cEKNPcxPWXQj2PGCgRZffcL4LHLq8LXiABYPqV
 cVxfWMN0bwVGAu3XdXyZLQk7+lEj4tKBhim73c+alU9iSlO0kipDqVM6yR99bCBmZOFP
 WYcg==
X-Gm-Message-State: APjAAAVXk2d5vcjN7dR+T2tGI4gxU3+TluF0qcsFiswWwPTxq22seOVb
 j6/V6hX/5WKXK1b5aVYtbkHUHA==
X-Google-Smtp-Source: APXvYqxhe1nXyCyNUhx8cTTNtgRnwP67TInHBpyDLvSJrEmZyrS3owGAroB4YRMX+xAih1k98Uzc1w==
X-Received: by 2002:adf:eec4:: with SMTP id a4mr93560883wrp.85.1564131875615; 
 Fri, 26 Jul 2019 02:04:35 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id o20sm131388680wrh.8.2019.07.26.02.04.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 02:04:35 -0700 (PDT)
Date: Fri, 26 Jul 2019 11:04:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190726090432.x6hk3rt57jip7iwu@steredhat>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724171239.8764-4-mreitz@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 24, 2019 at 07:12:31PM +0200, Max Reitz wrote:
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

Does it make sense to make sure of that in the bdrv_has_zero_init()?

I mean something like this:

int bdrv_has_zero_init(BlockDriverState *bs)
{
    ...
    if (bs->drv->bdrv_has_zero_init && bs->drv->bdrv_has_zero_init_truncate) {
        return bs->drv->bdrv_has_zero_init_truncate(bs) &&
               bs->drv->bdrv_has_zero_init(bs);
    } else if (bs->drv->bdrv_has_zero_init)
        return bs->drv->bdrv_has_zero_init(bs);
    }
    ...
}

Thanks,
Stefano

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
> -- 
> 2.21.0
> 

-- 

