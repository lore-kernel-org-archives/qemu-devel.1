Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A7BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1753C22CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1753C22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i391f-0000ST-78
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i390A-0007aa-Hi
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i3908-0000bD-8n
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:13:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i3904-0000ZK-8a; Wed, 28 Aug 2019 21:13:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C44A308FC4A;
 Thu, 29 Aug 2019 01:13:19 +0000 (UTC)
Received: from [10.18.17.85] (dhcp-17-85.bos.redhat.com [10.18.17.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3BE95C1B5;
 Thu, 29 Aug 2019 01:13:18 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190823143224.338486-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ed729f00-cac8-f2f5-15dd-d8a9fa535e53@redhat.com>
Date: Wed, 28 Aug 2019 21:13:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823143224.338486-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 29 Aug 2019 01:13:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] job: drop job_drain
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/23/19 10:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> In job_finish_sync job_enter should be enough for a job to make some
> progress and draining is a wrong tool for it. So use job_enter directly
> here and drop job_drain with all related staff not used more.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> v2: drop drain from tests/test-*, which I missed in v1

This patch has rotted a little, but not badly enough that --3way can't
handle it.

> 
>  include/block/blockjob_int.h | 19 -------------------
>  include/qemu/job.h           | 13 -------------
>  block/backup.c               | 19 +------------------
>  block/commit.c               |  1 -
>  block/mirror.c               | 28 +++-------------------------
>  block/stream.c               |  1 -
>  blockjob.c                   | 13 -------------
>  job.c                        | 12 +-----------
>  tests/test-bdrv-drain.c      |  2 --
>  tests/test-block-iothread.c  |  1 -
>  tests/test-blockjob-txn.c    |  1 -
>  tests/test-blockjob.c        |  2 --
>  12 files changed, 5 insertions(+), 107 deletions(-)
> 
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index e4a318dd15..e2824a36a8 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -52,17 +52,6 @@ struct BlockJobDriver {
>       * besides job->blk to the new AioContext.
>       */
>      void (*attached_aio_context)(BlockJob *job, AioContext *new_context);
> -
> -    /*
> -     * If the callback is not NULL, it will be invoked when the job has to be
> -     * synchronously cancelled or completed; it should drain BlockDriverStates
> -     * as required to ensure progress.
> -     *
> -     * Block jobs must use the default implementation for job_driver.drain,
> -     * which will in turn call this callback after doing generic block job
> -     * stuff.
> -     */
> -    void (*drain)(BlockJob *job);
>  };
>  
>  /**
> @@ -107,14 +96,6 @@ void block_job_free(Job *job);
>   */
>  void block_job_user_resume(Job *job);
>  
> -/**
> - * block_job_drain:
> - * Callback to be used for JobDriver.drain in all block jobs. Drains the main
> - * block node associated with the block jobs and calls BlockJobDriver.drain for
> - * job-specific actions.
> - */
> -void block_job_drain(Job *job);
> -
>  /**
>   * block_job_ratelimit_get_delay:
>   *
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index 9e7cd1e4a0..09739b8dd9 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -220,13 +220,6 @@ struct JobDriver {
>       */
>      void (*complete)(Job *job, Error **errp);
>  
> -    /*
> -     * If the callback is not NULL, it will be invoked when the job has to be
> -     * synchronously cancelled or completed; it should drain any activities
> -     * as required to ensure progress.
> -     */
> -    void (*drain)(Job *job);
> -
>      /**
>       * If the callback is not NULL, prepare will be invoked when all the jobs
>       * belonging to the same transaction complete; or upon this job's completion
> @@ -470,12 +463,6 @@ bool job_user_paused(Job *job);
>   */
>  void job_user_resume(Job *job, Error **errp);
>  
> -/*
> - * Drain any activities as required to ensure progress. This can be called in a
> - * loop to synchronously complete a job.
> - */
> -void job_drain(Job *job);
> -
>  /**
>   * Get the next element from the list of block jobs after @job, or the
>   * first one if @job is %NULL.
> diff --git a/block/backup.c b/block/backup.c
> index 715e1d3be8..d1ecdfa9aa 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -320,21 +320,6 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
>      hbitmap_set(backup_job->copy_bitmap, 0, backup_job->len);
>  }
>  
> -static void backup_drain(BlockJob *job)
> -{
> -    BackupBlockJob *s = container_of(job, BackupBlockJob, common);
> -
> -    /* Need to keep a reference in case blk_drain triggers execution
> -     * of backup_complete...
> -     */
> -    if (s->target) {
> -        BlockBackend *target = s->target;
> -        blk_ref(target);
> -        blk_drain(target);
> -        blk_unref(target);
> -    }
> -}
> -
>  static BlockErrorAction backup_error_action(BackupBlockJob *job,
>                                              bool read, int error)
>  {
> @@ -488,13 +473,11 @@ static const BlockJobDriver backup_job_driver = {
>          .job_type               = JOB_TYPE_BACKUP,
>          .free                   = block_job_free,
>          .user_resume            = block_job_user_resume,
> -        .drain                  = block_job_drain,
>          .run                    = backup_run,
>          .commit                 = backup_commit,
>          .abort                  = backup_abort,
>          .clean                  = backup_clean,
> -    },
> -    .drain                  = backup_drain,
> +    }
>  };
>  
>  static int64_t backup_calculate_cluster_size(BlockDriverState *target,
> diff --git a/block/commit.c b/block/commit.c
> index 2c5a6d4ebc..697a779d8e 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -216,7 +216,6 @@ static const BlockJobDriver commit_job_driver = {
>          .job_type      = JOB_TYPE_COMMIT,
>          .free          = block_job_free,
>          .user_resume   = block_job_user_resume,
> -        .drain         = block_job_drain,
>          .run           = commit_run,
>          .prepare       = commit_prepare,
>          .abort         = commit_abort,
> diff --git a/block/mirror.c b/block/mirror.c
> index 8cb75fb409..b91abe0288 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -644,14 +644,11 @@ static int mirror_exit_common(Job *job)
>      bdrv_ref(mirror_top_bs);
>      bdrv_ref(target_bs);
>  
> -    /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
> +    /*
> +     * Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
>       * inserting target_bs at s->to_replace, where we might not be able to get
>       * these permissions.
> -     *
> -     * Note that blk_unref() alone doesn't necessarily drop permissions because
> -     * we might be running nested inside mirror_drain(), which takes an extra
> -     * reference, so use an explicit blk_set_perm() first. */
> -    blk_set_perm(s->target, 0, BLK_PERM_ALL, &error_abort);
> +     */
>      blk_unref(s->target);
>      s->target = NULL;
>  
> @@ -1143,28 +1140,12 @@ static bool mirror_drained_poll(BlockJob *job)
>      return !!s->in_flight;
>  }
>  
> -static void mirror_drain(BlockJob *job)
> -{
> -    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
> -
> -    /* Need to keep a reference in case blk_drain triggers execution
> -     * of mirror_complete...
> -     */
> -    if (s->target) {
> -        BlockBackend *target = s->target;
> -        blk_ref(target);
> -        blk_drain(target);
> -        blk_unref(target);
> -    }
> -}
> -
>  static const BlockJobDriver mirror_job_driver = {
>      .job_driver = {
>          .instance_size          = sizeof(MirrorBlockJob),
>          .job_type               = JOB_TYPE_MIRROR,
>          .free                   = block_job_free,
>          .user_resume            = block_job_user_resume,
> -        .drain                  = block_job_drain,
>          .run                    = mirror_run,
>          .prepare                = mirror_prepare,
>          .abort                  = mirror_abort,
> @@ -1172,7 +1153,6 @@ static const BlockJobDriver mirror_job_driver = {
>          .complete               = mirror_complete,
>      },
>      .drained_poll           = mirror_drained_poll,
> -    .drain                  = mirror_drain,
>  };
>  
>  static const BlockJobDriver commit_active_job_driver = {
> @@ -1181,7 +1161,6 @@ static const BlockJobDriver commit_active_job_driver = {
>          .job_type               = JOB_TYPE_COMMIT,
>          .free                   = block_job_free,
>          .user_resume            = block_job_user_resume,
> -        .drain                  = block_job_drain,
>          .run                    = mirror_run,
>          .prepare                = mirror_prepare,
>          .abort                  = mirror_abort,
> @@ -1189,7 +1168,6 @@ static const BlockJobDriver commit_active_job_driver = {
>          .complete               = mirror_complete,
>      },
>      .drained_poll           = mirror_drained_poll,
> -    .drain                  = mirror_drain,
>  };
>  
>  static void coroutine_fn
> diff --git a/block/stream.c b/block/stream.c
> index 6ac1e7bec4..07f9908e1a 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -218,7 +218,6 @@ static const BlockJobDriver stream_job_driver = {
>          .abort         = stream_abort,
>          .clean         = stream_clean,
>          .user_resume   = block_job_user_resume,
> -        .drain         = block_job_drain,
>      },
>  };
>  
> diff --git a/blockjob.c b/blockjob.c
> index 20b7f557da..4b8d0869c6 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -89,18 +89,6 @@ void block_job_free(Job *job)
>      error_free(bjob->blocker);
>  }
>  
> -void block_job_drain(Job *job)
> -{
> -    BlockJob *bjob = container_of(job, BlockJob, job);
> -    const JobDriver *drv = job->driver;
> -    BlockJobDriver *bjdrv = container_of(drv, BlockJobDriver, job_driver);
> -
> -    blk_drain(bjob->blk);
> -    if (bjdrv->drain) {
> -        bjdrv->drain(bjob);
> -    }
> -}
> -
>  static char *child_job_get_parent_desc(BdrvChild *c)
>  {
>      BlockJob *job = c->opaque;
> @@ -421,7 +409,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>      assert(is_block_job(&job->job));
>      assert(job->job.driver->free == &block_job_free);
>      assert(job->job.driver->user_resume == &block_job_user_resume);
> -    assert(job->job.driver->drain == &block_job_drain);
>  
>      job->blk = blk;
>  
> diff --git a/job.c b/job.c
> index 28dd48f8a5..04409b40aa 100644
> --- a/job.c
> +++ b/job.c
> @@ -523,16 +523,6 @@ void coroutine_fn job_sleep_ns(Job *job, int64_t ns)
>      job_pause_point(job);
>  }
>  
> -void job_drain(Job *job)
> -{
> -    /* If job is !busy this kicks it into the next pause point. */
> -    job_enter(job);
> -
> -    if (job->driver->drain) {
> -        job->driver->drain(job);
> -    }
> -}
> -
>  /* Assumes the block_job_mutex is held */
>  static bool job_timer_not_pending(Job *job)
>  {
> @@ -991,7 +981,7 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
>      }
>  
>      AIO_WAIT_WHILE(job->aio_context,
> -                   (job_drain(job), !job_is_completed(job)));
> +                   (job_enter(job), !job_is_completed(job)));
>  
>      ret = (job_is_cancelled(job) && job->ret == 0) ? -ECANCELED : job->ret;
>      job_unref(job);
> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
> index 03fa1142a1..efbce9f8b4 100644
> --- a/tests/test-bdrv-drain.c
> +++ b/tests/test-bdrv-drain.c
> @@ -837,7 +837,6 @@ BlockJobDriver test_job_driver = {
>          .instance_size  = sizeof(TestBlockJob),
>          .free           = block_job_free,
>          .user_resume    = block_job_user_resume,
> -        .drain          = block_job_drain,
>          .run            = test_job_run,
>          .complete       = test_job_complete,
>          .prepare        = test_job_prepare,
> @@ -1563,7 +1562,6 @@ static const BlockJobDriver test_drop_backing_job_driver = {
>          .instance_size  = sizeof(TestDropBackingBlockJob),
>          .free           = block_job_free,
>          .user_resume    = block_job_user_resume,
> -        .drain          = block_job_drain,
>          .run            = test_drop_backing_job_run,
>          .commit         = test_drop_backing_job_commit,
>      }

I think this misses test_simple_job_driver; which must be newly
committed. If I fix it, everything seems like it works out OK.

So with that fixed, I would feel comfortable saying:

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

