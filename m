Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6567C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCC2206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 12:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCC2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8l84-0005rM-JD
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 08:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8l6i-0004gn-Gx
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8l6g-00066K-7t
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 08:55:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52090)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8l6b-00064u-W2; Fri, 13 Sep 2019 08:55:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5043C8665A;
 Fri, 13 Sep 2019 12:55:17 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F98819C78;
 Fri, 13 Sep 2019 12:55:15 +0000 (UTC)
Date: Fri, 13 Sep 2019 14:55:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190913125514.GG8312@dhcp-200-226.str.redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-26-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809161407.11920-26-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 13 Sep 2019 12:55:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 25/42] mirror: Deal with filters
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
> This includes some permission limiting (for example, we only need to
> take the RESIZE permission for active commits where the base is smaller
> than the top).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/mirror.c | 117 ++++++++++++++++++++++++++++++++++++++-----------
>  blockdev.c     |  47 +++++++++++++++++---
>  2 files changed, 131 insertions(+), 33 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 54bafdf176..6ddbfb9708 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -42,6 +42,7 @@ typedef struct MirrorBlockJob {
>      BlockBackend *target;
>      BlockDriverState *mirror_top_bs;
>      BlockDriverState *base;
> +    BlockDriverState *base_overlay;
>  
>      /* The name of the graph node to replace */
>      char *replaces;
> @@ -665,8 +666,10 @@ static int mirror_exit_common(Job *job)
>                               &error_abort);
>      if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
>          BlockDriverState *backing = s->is_none_mode ? src : s->base;
> -        if (backing_bs(target_bs) != backing) {
> -            bdrv_set_backing_hd(target_bs, backing, &local_err);
> +        BlockDriverState *unfiltered_target = bdrv_skip_rw_filters(target_bs);
> +
> +        if (bdrv_filtered_cow_bs(unfiltered_target) != backing) {
> +            bdrv_set_backing_hd(unfiltered_target, backing, &local_err);
>              if (local_err) {
>                  error_report_err(local_err);
>                  ret = -EPERM;
> @@ -715,7 +718,7 @@ static int mirror_exit_common(Job *job)
>       * valid.
>       */
>      block_job_remove_all_bdrv(bjob);
> -    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
> +    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
>  
>      /* We just changed the BDS the job BB refers to (with either or both of the
>       * bdrv_replace_node() calls), so switch the BB back so the cleanup does
> @@ -812,7 +815,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>              return 0;
>          }
>  
> -        ret = bdrv_is_allocated_above(bs, base, false, offset, bytes, &count);
> +        ret = bdrv_is_allocated_above(bs, s->base_overlay, true, offset, bytes,
> +                                      &count);
>          if (ret < 0) {
>              return ret;
>          }
> @@ -908,7 +912,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>      } else {
>          s->target_cluster_size = BDRV_SECTOR_SIZE;
>      }
> -    if (backing_filename[0] && !target_bs->backing &&
> +    if (backing_filename[0] && !bdrv_backing_chain_next(target_bs) &&
>          s->granularity < s->target_cluster_size) {
>          s->buf_size = MAX(s->buf_size, s->target_cluster_size);
>          s->cow_bitmap = bitmap_new(length);
> @@ -1088,8 +1092,9 @@ static void mirror_complete(Job *job, Error **errp)
>      if (s->backing_mode == MIRROR_OPEN_BACKING_CHAIN) {
>          int ret;
>  
> -        assert(!target->backing);
> -        ret = bdrv_open_backing_file(target, NULL, "backing", errp);
> +        assert(!bdrv_backing_chain_next(target));
> +        ret = bdrv_open_backing_file(bdrv_skip_rw_filters(target), NULL,
> +                                     "backing", errp);
>          if (ret < 0) {
>              return;
>          }
> @@ -1531,8 +1536,8 @@ static BlockJob *mirror_start_job(
>      MirrorBlockJob *s;
>      MirrorBDSOpaque *bs_opaque;
>      BlockDriverState *mirror_top_bs;
> -    bool target_graph_mod;
>      bool target_is_backing;
> +    uint64_t target_perms, target_shared_perms;
>      Error *local_err = NULL;
>      int ret;
>  
> @@ -1551,7 +1556,7 @@ static BlockJob *mirror_start_job(
>          buf_size = DEFAULT_MIRROR_BUF_SIZE;
>      }
>  
> -    if (bs == target) {
> +    if (bdrv_skip_rw_filters(bs) == bdrv_skip_rw_filters(target)) {
>          error_setg(errp, "Can't mirror node into itself");
>          return NULL;
>      }
> @@ -1615,15 +1620,50 @@ static BlockJob *mirror_start_job(
>       * In the case of active commit, things look a bit different, though,
>       * because the target is an already populated backing file in active use.
>       * We can allow anything except resize there.*/
> +
> +    target_perms = BLK_PERM_WRITE;
> +    target_shared_perms = BLK_PERM_WRITE_UNCHANGED;
> +
>      target_is_backing = bdrv_chain_contains(bs, target);
> -    target_graph_mod = (backing_mode != MIRROR_LEAVE_BACKING_CHAIN);
> +    if (target_is_backing) {
> +        int64_t bs_size, target_size;
> +        bs_size = bdrv_getlength(bs);
> +        if (bs_size < 0) {
> +            error_setg_errno(errp, -bs_size,
> +                             "Could not inquire top image size");
> +            goto fail;
> +        }
> +
> +        target_size = bdrv_getlength(target);
> +        if (target_size < 0) {
> +            error_setg_errno(errp, -target_size,
> +                             "Could not inquire base image size");
> +            goto fail;
> +        }
> +
> +        if (target_size < bs_size) {
> +            target_perms |= BLK_PERM_RESIZE;
> +        }
> +
> +        target_shared_perms |= BLK_PERM_CONSISTENT_READ
> +                            |  BLK_PERM_WRITE
> +                            |  BLK_PERM_GRAPH_MOD;
> +    } else if (bdrv_chain_contains(bs, bdrv_skip_rw_filters(target))) {
> +        /*
> +         * We may want to allow this in the future, but it would
> +         * require taking some extra care.
> +         */
> +        error_setg(errp, "Cannot mirror to a filter on top of a node in the "
> +                   "source's backing chain");
> +        goto fail;
> +    }
> +
> +    if (backing_mode != MIRROR_LEAVE_BACKING_CHAIN) {
> +        target_perms |= BLK_PERM_GRAPH_MOD;
> +    }

This is getting absurd. We keep moving GRAPH_MOD around, but still
nobody knows what it's actually supposed to mean. Maybe it would be
better to just remove it finally?

Of course, not a reason to stop this patch, after all it's moving the
nonsensical piece of code correctly...

>      s->target = blk_new(s->common.job.aio_context,
> -                        BLK_PERM_WRITE | BLK_PERM_RESIZE |
> -                        (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
> -                        BLK_PERM_WRITE_UNCHANGED |
> -                        (target_is_backing ? BLK_PERM_CONSISTENT_READ |
> -                                             BLK_PERM_WRITE |
> -                                             BLK_PERM_GRAPH_MOD : 0));
> +                        target_perms, target_shared_perms);
>      ret = blk_insert_bs(s->target, target, errp);
>      if (ret < 0) {
>          goto fail;
> @@ -1647,6 +1687,7 @@ static BlockJob *mirror_start_job(
>      s->backing_mode = backing_mode;
>      s->copy_mode = copy_mode;
>      s->base = base;
> +    s->base_overlay = bdrv_find_overlay(bs, base);
>      s->granularity = granularity;
>      s->buf_size = ROUND_UP(buf_size, granularity);
>      s->unmap = unmap;
> @@ -1693,15 +1734,39 @@ static BlockJob *mirror_start_job(
>      /* In commit_active_start() all intermediate nodes disappear, so
>       * any jobs in them must be blocked */
>      if (target_is_backing) {
> -        BlockDriverState *iter;
> -        for (iter = backing_bs(bs); iter != target; iter = backing_bs(iter)) {
> -            /* XXX BLK_PERM_WRITE needs to be allowed so we don't block
> -             * ourselves at s->base (if writes are blocked for a node, they are
> -             * also blocked for its backing file). The other options would be a
> -             * second filter driver above s->base (== target). */
> +        BlockDriverState *iter, *filtered_target;
> +        uint64_t iter_shared_perms;
> +
> +        /*
> +         * The topmost node with
> +         * bdrv_skip_rw_filters(filtered_target) == bdrv_skip_rw_filters(target)
> +         */
> +        filtered_target = bdrv_filtered_cow_bs(bdrv_find_overlay(bs, target));
> +
> +        assert(bdrv_skip_rw_filters(filtered_target) ==
> +               bdrv_skip_rw_filters(target));
> +
> +        /*
> +         * XXX BLK_PERM_WRITE needs to be allowed so we don't block
> +         * ourselves at s->base (if writes are blocked for a node, they are
> +         * also blocked for its backing file). The other options would be a
> +         * second filter driver above s->base (== target).
> +         */
> +        iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
> +
> +        for (iter = bdrv_filtered_bs(bs); iter != target;
> +             iter = bdrv_filtered_bs(iter))
> +        {
> +            if (iter == filtered_target) {
> +                /*
> +                 * From here on, all nodes are filters on the base.
> +                 * This allows us to share BLK_PERM_CONSISTENT_READ.
> +                 */
> +                iter_shared_perms |= BLK_PERM_CONSISTENT_READ;
> +            }
> +
>              ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
> -                                     BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
> -                                     errp);
> +                                     iter_shared_perms, errp);
>              if (ret < 0) {
>                  goto fail;
>              }
> @@ -1737,7 +1802,7 @@ fail:
>      bs_opaque->stop = true;
>      bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
>                               &error_abort);
> -    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
> +    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
>  
>      bdrv_unref(mirror_top_bs);
>  
> @@ -1764,7 +1829,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>          return;
>      }
>      is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
> -    base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
> +    base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
>      mirror_start_job(job_id, bs, creation_flags, target, replaces,
>                       speed, granularity, buf_size, backing_mode,
>                       on_source_error, on_target_error, unmap, NULL, NULL,
> diff --git a/blockdev.c b/blockdev.c
> index c540802127..c451f553f7 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3851,7 +3851,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>          return;
>      }
>  
> -    if (!bs->backing && sync == MIRROR_SYNC_MODE_TOP) {
> +    if (!bdrv_backing_chain_next(bs) && sync == MIRROR_SYNC_MODE_TOP) {
>          sync = MIRROR_SYNC_MODE_FULL;
>      }
>  
> @@ -3900,7 +3900,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>  
>  void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>  {
> -    BlockDriverState *bs;
> +    BlockDriverState *bs, *unfiltered_bs;
>      BlockDriverState *source, *target_bs;
>      AioContext *aio_context;
>      BlockMirrorBackingMode backing_mode;
> @@ -3909,6 +3909,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      int flags;
>      int64_t size;
>      const char *format = arg->format;
> +    const char *replaces_node_name = NULL;
>      int ret;
>  
>      bs = qmp_get_root_bs(arg->device, errp);
> @@ -3921,6 +3922,16 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>          return;
>      }
>  
> +    /*
> +     * If the user has not instructed us otherwise, we should let the
> +     * block job run from @bs (thus taking into account all filters on
> +     * it) but replace @unfiltered_bs when it finishes (thus not
> +     * removing those filters).
> +     * (And if there are any explicit filters, we should assume the
> +     *  user knows how to use the @replaces option.)
> +     */
> +    unfiltered_bs = bdrv_skip_implicit_filters(bs);

Should this behaviour be documented in the QAPI schema for drive-mirror?

>      aio_context = bdrv_get_aio_context(bs);
>      aio_context_acquire(aio_context);
>  
> @@ -3934,8 +3945,14 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      }
>  
>      flags = bs->open_flags | BDRV_O_RDWR;
> -    source = backing_bs(bs);
> +    source = bdrv_filtered_cow_bs(unfiltered_bs);
>      if (!source && arg->sync == MIRROR_SYNC_MODE_TOP) {
> +        if (bdrv_filtered_bs(unfiltered_bs)) {
> +            /* @unfiltered_bs is an explicit filter */
> +            error_setg(errp, "Cannot perform sync=top mirror through an "
> +                       "explicitly added filter node on the source");
> +            goto out;
> +        }
>          arg->sync = MIRROR_SYNC_MODE_FULL;
>      }
>      if (arg->sync == MIRROR_SYNC_MODE_NONE) {
> @@ -3954,6 +3971,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>                               " named node of the graph");
>              goto out;
>          }
> +        replaces_node_name = arg->replaces;
> +    } else if (unfiltered_bs != bs) {
> +        replaces_node_name = unfiltered_bs->node_name;
>      }
>  
>      if (arg->mode == NEW_IMAGE_MODE_ABSOLUTE_PATHS) {
> @@ -3973,6 +3993,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>          bdrv_img_create(arg->target, format,
>                          NULL, NULL, NULL, size, flags, false, &local_err);
>      } else {
> +        /* Implicit filters should not appear in the filename */
> +        BlockDriverState *explicit_backing = bdrv_skip_implicit_filters(source);
> +
>          switch (arg->mode) {
>          case NEW_IMAGE_MODE_EXISTING:
>              break;
> @@ -3980,8 +4003,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>              /* create new image with backing file */
>              bdrv_refresh_filename(source);
>              bdrv_img_create(arg->target, format,
> -                            source->filename,
> -                            source->drv->format_name,
> +                            explicit_backing->filename,
> +                            explicit_backing->drv->format_name,
>                              NULL, size, flags, false, &local_err);
>              break;
>          default:
> @@ -4017,7 +4040,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      }
>  
>      blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
> -                           arg->has_replaces, arg->replaces, arg->sync,
> +                           !!replaces_node_name, replaces_node_name, arg->sync,
>                             backing_mode, arg->has_speed, arg->speed,
>                             arg->has_granularity, arg->granularity,
>                             arg->has_buf_size, arg->buf_size,
> @@ -4053,7 +4076,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>                           bool has_auto_dismiss, bool auto_dismiss,
>                           Error **errp)
>  {
> -    BlockDriverState *bs;
> +    BlockDriverState *bs, *unfiltered_bs;
>      BlockDriverState *target_bs;
>      AioContext *aio_context;
>      BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
> @@ -4065,6 +4088,16 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>          return;
>      }
>  
> +    /*
> +     * Same as in qmp_drive_mirror(): We want to run the job from @bs,
> +     * but we want to replace @unfiltered_bs on completion.
> +     */
> +    unfiltered_bs = bdrv_skip_implicit_filters(bs);

Do we? I thought the idea with blockdev-mirror was that the client tells
us the exact node it is interested in, without any magic skipping nodes.

Skipping implicit nodes is a feature for compatibility with legacy
clients, but a client using blockdev-mirror isn't a legacy client.

> +    if (!has_replaces && unfiltered_bs != bs) {
> +        replaces = unfiltered_bs->node_name;
> +        has_replaces = true;
> +    }
> +
>      target_bs = bdrv_lookup_bs(target, target, errp);
>      if (!target_bs) {
>          return;

Kevin

