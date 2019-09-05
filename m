Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B098FC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 14:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B32206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 14:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B32206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5sPd-0001xa-KK
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 10:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i5sOl-0001J0-Pa
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i5sOg-0007G8-GU
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:06:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i5sOY-0007DV-6O; Thu, 05 Sep 2019 10:05:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FCCB883833;
 Thu,  5 Sep 2019 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-80.ams2.redhat.com
 [10.36.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6DE5A207;
 Thu,  5 Sep 2019 14:05:49 +0000 (UTC)
Date: Thu, 5 Sep 2019 16:05:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190905140547.GC4911@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-15-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809161407.11920-15-mreitz@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 05 Sep 2019 14:05:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 14/42] block: Use CAFs when working with
 backing chains
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> Use child access functions when iterating through backing chains so
> filters do not break the chain.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 86b84bea21..42abbaf0ba 100644
> --- a/block.c
> +++ b/block.c
> @@ -4376,7 +4376,8 @@ int bdrv_change_backing_file(BlockDriverState *bs,
>  }
>  
>  /*
> - * Finds the image layer in the chain that has 'bs' as its backing file.
> + * Finds the image layer in the chain that has 'bs' (or a filter on
> + * top of it) as its backing file.
>   *
>   * active is the current topmost image.
>   *
> @@ -4388,11 +4389,18 @@ int bdrv_change_backing_file(BlockDriverState *bs,
>  BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
>                                      BlockDriverState *bs)
>  {
> -    while (active && bs != backing_bs(active)) {
> -        active = backing_bs(active);
> +    bs = bdrv_skip_rw_filters(bs);
> +    active = bdrv_skip_rw_filters(active);

This does more than the commit message says. In addition to iterating
through filters instead of stopping, it also changes the semantics of
the function to return the next non-filter on top of bs instead of the
next node.

The block jobs seem to use it only for bdrv_is_allocated_above(), which
should return the same thing in both cases, so the behaviour stays the
same. qmp_block_commit() will check op blockers on a different node now,
which could be a fix or a bug, I can't tell offhand. Probably the
blocking doesn't really work anyway.

All of this should be mentioned in the commit message at least. Maybe
it's also worth splitting in two patches.

> +    while (active) {
> +        BlockDriverState *next = bdrv_backing_chain_next(active);
> +        if (bs == next) {
> +            return active;
> +        }
> +        active = next;
>      }
>  
> -    return active;
> +    return NULL;
>  }
>  
>  /* Given a BDS, searches for the base layer. */
> @@ -4544,9 +4552,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
>       * other intermediate nodes have been dropped.
>       * If 'top' is an implicit node (e.g. "commit_top") we should skip
>       * it because no one inherits from it. We use explicit_top for that. */
> -    while (explicit_top && explicit_top->implicit) {
> -        explicit_top = backing_bs(explicit_top);
> -    }
> +    explicit_top = bdrv_skip_implicit_filters(explicit_top);
>      update_inherits_from = bdrv_inherits_from_recursive(base, explicit_top);
>  
>      /* success - we can delete the intermediate states, and link top->base */
> @@ -5014,7 +5020,7 @@ BlockDriverState *bdrv_lookup_bs(const char *device,
>  bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
>  {
>      while (top && top != base) {
> -        top = backing_bs(top);
> +        top = bdrv_filtered_bs(top);
>      }
>  
>      return top != NULL;
> @@ -5253,7 +5259,17 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>  
>      is_protocol = path_has_protocol(backing_file);
>  
> -    for (curr_bs = bs; curr_bs->backing; curr_bs = curr_bs->backing->bs) {
> +    /*
> +     * Being largely a legacy function, skip any filters here
> +     * (because filters do not have normal filenames, so they cannot
> +     * match anyway; and allowing json:{} filenames is a bit out of
> +     * scope).
> +     */
> +    for (curr_bs = bdrv_skip_rw_filters(bs);
> +         bdrv_filtered_cow_child(curr_bs) != NULL;
> +         curr_bs = bdrv_backing_chain_next(curr_bs))

This could just use bs_below instead of recalculating the node if you
moved the declaration of bs_below to the function scope.

> +    {
> +        BlockDriverState *bs_below = bdrv_backing_chain_next(curr_bs);
>  
>          /* If either of the filename paths is actually a protocol, then
>           * compare unmodified paths; otherwise make paths relative */
> @@ -5261,7 +5277,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>              char *backing_file_full_ret;
>  
>              if (strcmp(backing_file, curr_bs->backing_file) == 0) {
> -                retval = curr_bs->backing->bs;
> +                retval = bs_below;
>                  break;
>              }
>              /* Also check against the full backing filename for the image */
> @@ -5271,7 +5287,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>                  bool equal = strcmp(backing_file, backing_file_full_ret) == 0;
>                  g_free(backing_file_full_ret);
>                  if (equal) {
> -                    retval = curr_bs->backing->bs;
> +                    retval = bs_below;
>                      break;
>                  }
>              }
> @@ -5297,7 +5313,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>              g_free(filename_tmp);
>  
>              if (strcmp(backing_file_full, filename_full) == 0) {
> -                retval = curr_bs->backing->bs;
> +                retval = bs_below;
>                  break;
>              }
>          }

Kevin

