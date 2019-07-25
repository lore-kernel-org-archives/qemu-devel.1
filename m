Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19943C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E650921951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E650921951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqffr-00027J-7p
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48173)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfff-0001YV-5f
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hqffd-0000eP-Ez
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hqffa-0000cL-0T; Thu, 25 Jul 2019 11:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5297630860C0;
 Thu, 25 Jul 2019 15:28:37 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9E3D600D1;
 Thu, 25 Jul 2019 15:28:35 +0000 (UTC)
Message-ID: <9021e43da1e3c46354486c416c1d65935b37a9d2.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:28:34 +0300
In-Reply-To: <20190724171239.8764-3-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-3-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 25 Jul 2019 15:28:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 02/11] mirror: Fix bdrv_has_zero_init()
 use
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
> bdrv_has_zero_init() only has meaning for newly created images or image
> areas.  If the mirror job itself did not create the image, it cannot
> rely on bdrv_has_zero_init()'s result to carry any meaning.
> 
> This is the case for drive-mirror with mode=existing and always for
> blockdev-mirror.
> 
> Note that we only have to zero-initialize the target with sync=full,
> because other modes actually do not promise that the target will contain
> the same data as the source after the job -- sync=top only promises to
> copy anything allocated in the top layer, and sync=none will only copy
> new I/O.  (Which is how mirror has always handled it.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block_int.h   |  2 ++
>  block/mirror.c              | 11 ++++++++---
>  blockdev.c                  | 16 +++++++++++++---
>  tests/test-block-iothread.c |  2 +-
>  4 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 3aa1e832a8..6a0b1b5008 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1116,6 +1116,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>   * @buf_size: The amount of data that can be in flight at one time.
>   * @mode: Whether to collapse all images in the chain to the target.
>   * @backing_mode: How to establish the target's backing chain after completion.
> + * @zero_target: Whether the target should be explicitly zero-initialized
>   * @on_source_error: The action to take upon error reading from the source.
>   * @on_target_error: The action to take upon error writing to the target.
>   * @unmap: Whether to unmap target where source sectors only contain zeroes.
> @@ -1135,6 +1136,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>                    int creation_flags, int64_t speed,
>                    uint32_t granularity, int64_t buf_size,
>                    MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
> +                  bool zero_target,
>                    BlockdevOnError on_source_error,
>                    BlockdevOnError on_target_error,
>                    bool unmap, const char *filter_node_name,
> diff --git a/block/mirror.c b/block/mirror.c
> index 8cb75fb409..50188ce6e9 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -51,6 +51,8 @@ typedef struct MirrorBlockJob {
>      Error *replace_blocker;
>      bool is_none_mode;
>      BlockMirrorBackingMode backing_mode;
> +    /* Whether the target image requires explicit zero-initialization */
> +    bool zero_target;
>      MirrorCopyMode copy_mode;
>      BlockdevOnError on_source_error, on_target_error;
>      bool synced;
> @@ -763,7 +765,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>      int ret;
>      int64_t count;
>  
> -    if (base == NULL && !bdrv_has_zero_init(target_bs)) {
> +    if (s->zero_target) {
The justification for removing base here, is that it can be != NULL only
when MIRROR_SYNC_MODE_TOP. So looks OK


>          if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
>              bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
>              return 0;
> @@ -1501,6 +1503,7 @@ static BlockJob *mirror_start_job(
>                               const char *replaces, int64_t speed,
>                               uint32_t granularity, int64_t buf_size,
>                               BlockMirrorBackingMode backing_mode,
> +                             bool zero_target,
>                               BlockdevOnError on_source_error,
>                               BlockdevOnError on_target_error,
>                               bool unmap,
> @@ -1628,6 +1631,7 @@ static BlockJob *mirror_start_job(
>      s->on_target_error = on_target_error;
>      s->is_none_mode = is_none_mode;
>      s->backing_mode = backing_mode;
> +    s->zero_target = zero_target;
>      s->copy_mode = copy_mode;
>      s->base = base;
>      s->granularity = granularity;
> @@ -1713,6 +1717,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>                    int creation_flags, int64_t speed,
>                    uint32_t granularity, int64_t buf_size,
>                    MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
> +                  bool zero_target,
>                    BlockdevOnError on_source_error,
>                    BlockdevOnError on_target_error,
>                    bool unmap, const char *filter_node_name,
> @@ -1728,7 +1733,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>      is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
>      base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
>      mirror_start_job(job_id, bs, creation_flags, target, replaces,
> -                     speed, granularity, buf_size, backing_mode,
> +                     speed, granularity, buf_size, backing_mode, zero_target,
>                       on_source_error, on_target_error, unmap, NULL, NULL,
>                       &mirror_job_driver, is_none_mode, base, false,
>                       filter_node_name, true, copy_mode, errp);
> @@ -1755,7 +1760,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
>  
>      ret = mirror_start_job(
>                       job_id, bs, creation_flags, base, NULL, speed, 0, 0,
> -                     MIRROR_LEAVE_BACKING_CHAIN,
> +                     MIRROR_LEAVE_BACKING_CHAIN, false,
>                       on_error, on_error, true, cb, opaque,
>                       &commit_active_job_driver, false, base, auto_complete,
>                       filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
> diff --git a/blockdev.c b/blockdev.c
> index 4d141e9a1f..0323f77850 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3705,6 +3705,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>                                     bool has_replaces, const char *replaces,
>                                     enum MirrorSyncMode sync,
>                                     BlockMirrorBackingMode backing_mode,
> +                                   bool zero_target,
>                                     bool has_speed, int64_t speed,
>                                     bool has_granularity, uint32_t granularity,
>                                     bool has_buf_size, int64_t buf_size,
> @@ -3813,7 +3814,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
>       */
>      mirror_start(job_id, bs, target,
>                   has_replaces ? replaces : NULL, job_flags,
> -                 speed, granularity, buf_size, sync, backing_mode,
> +                 speed, granularity, buf_size, sync, backing_mode, zero_target,
>                   on_source_error, on_target_error, unmap, filter_node_name,
>                   copy_mode, errp);
>  }
> @@ -3829,6 +3830,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>      int flags;
>      int64_t size;
>      const char *format = arg->format;
> +    bool zero_target;
>      int ret;
>  
>      bs = qmp_get_root_bs(arg->device, errp);
> @@ -3930,6 +3932,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>          goto out;
>      }
>  
> +    zero_target = (arg->sync == MIRROR_SYNC_MODE_FULL &&
> +                   (arg->mode == NEW_IMAGE_MODE_EXISTING ||
> +                    !bdrv_has_zero_init(target_bs)));
> +
>      ret = bdrv_try_set_aio_context(target_bs, aio_context, errp);
>      if (ret < 0) {
>          bdrv_unref(target_bs);
> @@ -3938,7 +3944,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
>  
>      blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
>                             arg->has_replaces, arg->replaces, arg->sync,
> -                           backing_mode, arg->has_speed, arg->speed,
> +                           backing_mode, zero_target,
> +                           arg->has_speed, arg->speed,
>                             arg->has_granularity, arg->granularity,
>                             arg->has_buf_size, arg->buf_size,
>                             arg->has_on_source_error, arg->on_source_error,
> @@ -3978,6 +3985,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>      AioContext *aio_context;
>      BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
>      Error *local_err = NULL;
> +    bool zero_target;
>      int ret;
>  
>      bs = qmp_get_root_bs(device, errp);
> @@ -3990,6 +3998,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>          return;
>      }
>  
> +    zero_target = (sync == MIRROR_SYNC_MODE_FULL);
> +
>      aio_context = bdrv_get_aio_context(bs);
>      aio_context_acquire(aio_context);
>  
> @@ -4000,7 +4010,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>  
>      blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
>                             has_replaces, replaces, sync, backing_mode,
> -                           has_speed, speed,
> +                           zero_target, has_speed, speed,
>                             has_granularity, granularity,
>                             has_buf_size, buf_size,
>                             has_on_source_error, on_source_error,
> diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
> index 1949d5e61a..debfb69bfb 100644
> --- a/tests/test-block-iothread.c
> +++ b/tests/test-block-iothread.c
> @@ -611,7 +611,7 @@ static void test_propagate_mirror(void)
>  
>      /* Start a mirror job */
>      mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
> -                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN,
> +                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false,
>                   BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
>                   false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
>                   &error_abort);


From my limited understanding of this code, it looks ok to me.

Still to be very sure, I sort of suggest still to check that nobody relies on target zeroing 
when non in full sync mode, to avoid breaking the users

For example, QMP reference states that MIRROR_SYNC_MODE_TOP copies data in the topmost image to the destination.
If there is only the topmost image, I could image the caller assume that target is identical to the source.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


