Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B641AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C88320644
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C88320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mQ3-0004fp-Dn
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8mNh-0002ve-V9
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8mNg-0004gV-Ch
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:17:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8mNc-0004dT-Jl; Fri, 13 Sep 2019 10:16:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E073D307D925;
 Fri, 13 Sep 2019 14:16:55 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0DB6194BB;
 Fri, 13 Sep 2019 14:16:54 +0000 (UTC)
Date: Fri, 13 Sep 2019 16:16:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809161407.11920-29-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 13 Sep 2019 14:16:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 28/42] stream: Deal with filters
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
> Because of the recent changes that make the stream job independent of
> the base node and instead track the node above it, we have to split that
> "bottom" node into two cases: The bottom COW node, and the node directly
> above the base node (which may be an R/W filter or the bottom COW node).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json |  4 ++++
>  block/stream.c       | 52 ++++++++++++++++++++++++++++----------------
>  blockdev.c           |  2 +-
>  3 files changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 38c4dbd7c3..3c54717870 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2516,6 +2516,10 @@
>  # On successful completion the image file is updated to drop the backing file
>  # and the BLOCK_JOB_COMPLETED event is emitted.
>  #
> +# In case @device is a filter node, block-stream modifies the first non-filter
> +# overlay node below it to point to base's backing node (or NULL if @base was
> +# not specified) instead of modifying @device itself.
> +#
>  # @job-id: identifier for the newly-created block job. If
>  #          omitted, the device name will be used. (Since 2.7)
>  #
> diff --git a/block/stream.c b/block/stream.c
> index 4c8b89884a..bd4a351dae 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -31,7 +31,8 @@ enum {
>  
>  typedef struct StreamBlockJob {
>      BlockJob common;
> -    BlockDriverState *bottom;
> +    BlockDriverState *bottom_cow_node;
> +    BlockDriverState *above_base;

Confusing naming, especially because in commit you used above_base for
what is bottom_cow_node here. Vladimir already suggested using
base_overlay consistently, so we should do this here too (for
bottom_cow_node). above_base can keep its name because the different
above_base in commit is going to be renamed).

>      BlockdevOnError on_error;
>      char *backing_file_str;
>      bool bs_read_only;
> @@ -54,7 +55,7 @@ static void stream_abort(Job *job)
>  
>      if (s->chain_frozen) {
>          BlockJob *bjob = &s->common;
> -        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->bottom);
> +        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->above_base);
>      }
>  }
>  
> @@ -63,14 +64,15 @@ static int stream_prepare(Job *job)
>      StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>      BlockJob *bjob = &s->common;
>      BlockDriverState *bs = blk_bs(bjob->blk);
> -    BlockDriverState *base = backing_bs(s->bottom);
> +    BlockDriverState *unfiltered_bs = bdrv_skip_rw_filters(bs);
> +    BlockDriverState *base = bdrv_filtered_bs(s->above_base);
>      Error *local_err = NULL;
>      int ret = 0;
>  
> -    bdrv_unfreeze_chain(bs, s->bottom);
> +    bdrv_unfreeze_chain(bs, s->above_base);
>      s->chain_frozen = false;
>  
> -    if (bs->backing) {
> +    if (bdrv_filtered_cow_child(unfiltered_bs)) {
>          const char *base_id = NULL, *base_fmt = NULL;
>          if (base) {
>              base_id = s->backing_file_str;
> @@ -78,8 +80,8 @@ static int stream_prepare(Job *job)
>                  base_fmt = base->drv->format_name;
>              }
>          }
> -        bdrv_set_backing_hd(bs, base, &local_err);
> -        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
> +        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
> +        ret = bdrv_change_backing_file(unfiltered_bs, base_id, base_fmt);
>          if (local_err) {
>              error_report_err(local_err);
>              return -EPERM;
> @@ -110,7 +112,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>      StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
>      BlockBackend *blk = s->common.blk;
>      BlockDriverState *bs = blk_bs(blk);
> -    bool enable_cor = !backing_bs(s->bottom);
> +    BlockDriverState *unfiltered_bs = bdrv_skip_rw_filters(bs);
> +    bool enable_cor = !bdrv_filtered_bs(s->above_base);
>      int64_t len;
>      int64_t offset = 0;
>      uint64_t delay_ns = 0;
> @@ -119,7 +122,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>      int64_t n = 0; /* bytes */
>      void *buf;
>  
> -    if (bs == s->bottom) {
> +    if (unfiltered_bs == s->bottom_cow_node) {
>          /* Nothing to stream */
>          return 0;
>      }
> @@ -154,13 +157,14 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>  
>          copy = false;
>  
> -        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &n);
> +        ret = bdrv_is_allocated(unfiltered_bs, offset, STREAM_BUFFER_SIZE, &n);
>          if (ret == 1) {
>              /* Allocated in the top, no need to copy.  */
>          } else if (ret >= 0) {
>              /* Copy if allocated in the intermediate images.  Limit to the
>               * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
> -            ret = bdrv_is_allocated_above(backing_bs(bs), s->bottom, true,
> +            ret = bdrv_is_allocated_above(bdrv_filtered_cow_bs(unfiltered_bs),
> +                                          s->bottom_cow_node, true,
>                                            offset, n, &n);
>              /* Finish early if end of backing file has been reached */
>              if (ret == 0 && n == 0) {
> @@ -231,9 +235,16 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>      BlockDriverState *iter;
>      bool bs_read_only;
>      int basic_flags = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED;
> -    BlockDriverState *bottom = bdrv_find_overlay(bs, base);
> +    BlockDriverState *bottom_cow_node = bdrv_find_overlay(bs, base);
> +    BlockDriverState *above_base;

Do we need to check for bottom_cow_node == NULL?

I think you could get a bs that is a filter of bottom_cow_node, and then
bdrv_find_overlay() returns NULL and...

> -    if (bdrv_freeze_chain(bs, bottom, errp) < 0) {
> +    /* Find the node directly above @base */
> +    for (above_base = bottom_cow_node;
> +         bdrv_filtered_bs(above_base) != base;
> +         above_base = bdrv_filtered_bs(above_base))
> +    {}

...bottom_cow_node == NULL turns this into an endless loop.

> +    if (bdrv_freeze_chain(bs, above_base, errp) < 0) {
>          return;
>      }

Hm... This feels odd. There are two places where stopping to freeze the
chain would make obvious sense: At base, like we originally did; or at
base_overlay, like we (intend to) do since commit c624b015, because we
say that we don't actually mind if the user replaces the base image. I
don't see how stopping at the first filter above base makes sense.

So should this use bottom_cow_node/base_overlay instead of above_base?

You couldn't use StreamBlockJob.above_base any more then because it
could change, but you also don't really need it anywhere. It's only used
for unfreezing (which would change) and for finding the base (you can
still find bdrv_backing_chain_next(s->base_overlay)). I guess this would
even be a code simplification.

> @@ -261,16 +272,19 @@ void stream_start(const char *job_id, BlockDriverState *bs,
>       * disappear from the chain after this operation. The streaming job reads
>       * every block only once, assuming that it doesn't change, so forbid writes
>       * and resizes. Reassign the base node pointer because the backing BS of the
> -     * bottom node might change after the call to bdrv_reopen_set_read_only()
> -     * due to parallel block jobs running.
> +     * above_base node might change after the call to
> +     * bdrv_reopen_set_read_only() due to parallel block jobs running.
>       */
> -    base = backing_bs(bottom);
> -    for (iter = backing_bs(bs); iter && iter != base; iter = backing_bs(iter)) {
> +    base = bdrv_filtered_bs(above_base);

We just calculated above_base such that it's the parent of base. Why
would base not already have the value we're assigning it again here?

> +    for (iter = bdrv_filtered_bs(bs); iter && iter != base;
> +         iter = bdrv_filtered_bs(iter))
> +    {
>          block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
>                             basic_flags, &error_abort);
>      }
>  
> -    s->bottom = bottom;
> +    s->bottom_cow_node = bottom_cow_node;
> +    s->above_base = above_base;
>      s->backing_file_str = g_strdup(backing_file_str);
>      s->bs_read_only = bs_read_only;
>      s->chain_frozen = true;
> @@ -284,5 +298,5 @@ fail:
>      if (bs_read_only) {
>          bdrv_reopen_set_read_only(bs, true, NULL);
>      }
> -    bdrv_unfreeze_chain(bs, bottom);
> +    bdrv_unfreeze_chain(bs, above_base);
>  }

Kevin

