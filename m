Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F06C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A612E20644
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A612E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAj1Y-0003lb-K0
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAizm-0002qK-Db
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAizk-00026Q-Cb
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAize-00025B-Dw; Wed, 18 Sep 2019 19:04:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D075AC057E9F;
 Wed, 18 Sep 2019 23:04:12 +0000 (UTC)
Received: from [10.10.124.73] (ovpn-124-73.rdu2.redhat.com [10.10.124.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 254145D9CC;
 Wed, 18 Sep 2019 23:04:07 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190916141911.5255-1-vsementsov@virtuozzo.com>
 <20190916141911.5255-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fd4b72d5-1067-bb92-f489-23b666a4b175@redhat.com>
Date: Wed, 18 Sep 2019 19:04:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141911.5255-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 18 Sep 2019 23:04:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add bs link
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
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/16/19 10:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add bs field to BdrvDirtyBitmap structure. Drop BlockDriverState
> parameter from bitmap APIs where possible.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I've thought about doing this before, but couldn't figure out if it was
worth it.

So, let's do it.

makes any functions that take (bs, bitmap) pairs less error-prone.

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  include/block/dirty-bitmap.h   | 14 +++++---------
>  block/backup.c                 | 14 ++++++--------
>  block/dirty-bitmap.c           | 24 ++++++++++++------------
>  block/mirror.c                 |  4 ++--
>  block/qcow2-bitmap.c           |  6 +++---
>  blockdev.c                     |  6 +++---
>  migration/block-dirty-bitmap.c |  7 +++----
>  migration/block.c              |  4 ++--
>  8 files changed, 36 insertions(+), 43 deletions(-)
>=20
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.=
h
> index 848dfc6590..4c58d922e4 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -18,21 +18,18 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriv=
erState *bs,
>                                            uint32_t granularity,
>                                            const char *name,
>                                            Error **errp);
> -int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
> -                                       BdrvDirtyBitmap *bitmap,
> +int bdrv_dirty_bitmap_create_successor(BdrvDirtyBitmap *bitmap,
>                                         Error **errp);
> -BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
> -                                            BdrvDirtyBitmap *bitmap,
> +BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BdrvDirtyBitmap *bitmap,
>                                              Error **errp);
> -BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
> -                                           BdrvDirtyBitmap *bitmap,
> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>                                             Error **errp);
>  void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
>  BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
>                                          const char *name);
>  int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t fl=
ags,
>                              Error **errp);
> -void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *=
bitmap);
> +void bdrv_release_dirty_bitmap(BdrvDirtyBitmap *bitmap);
>  void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
>  void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>                                           const char *name,
> @@ -107,8 +104,7 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap=
 *bitmap, uint64_t offset,
>                                      uint64_t bytes);
>  bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
>                                         uint64_t *offset, uint64_t *byt=
es);
> -BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs=
,
> -                                                  BdrvDirtyBitmap *bit=
map,
> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *bit=
map,
>                                                    Error **errp);
> =20
>  #endif
> diff --git a/block/backup.c b/block/backup.c
> index 763f0d7ff6..acb67da3a7 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -352,7 +352,6 @@ static int coroutine_fn backup_before_write_notify(
>  static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
>  {
>      BdrvDirtyBitmap *bm;
> -    BlockDriverState *bs =3D blk_bs(job->common.blk);
>      bool sync =3D (((ret =3D=3D 0) || (job->bitmap_mode =3D=3D BITMAP_=
SYNC_MODE_ALWAYS)) \
>                   && (job->bitmap_mode !=3D BITMAP_SYNC_MODE_NEVER));
> =20
> @@ -361,13 +360,13 @@ static void backup_cleanup_sync_bitmap(BackupBloc=
kJob *job, int ret)
>           * We succeeded, or we always intended to sync the bitmap.
>           * Delete this bitmap and install the child.
>           */
> -        bm =3D bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL);
> +        bm =3D bdrv_dirty_bitmap_abdicate(job->sync_bitmap, NULL);
>      } else {
>          /*
>           * We failed, or we never intended to sync the bitmap anyway.
>           * Merge the successor back into the parent, keeping all data.
>           */
> -        bm =3D bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
> +        bm =3D bdrv_reclaim_dirty_bitmap(job->sync_bitmap, NULL);
>      }
> =20
>      assert(bm);
> @@ -398,10 +397,9 @@ static void backup_abort(Job *job)
>  static void backup_clean(Job *job)
>  {
>      BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job=
);
> -    BlockDriverState *bs =3D blk_bs(s->common.blk);
> =20
>      if (s->copy_bitmap) {
> -        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
> +        bdrv_release_dirty_bitmap(s->copy_bitmap);
>          s->copy_bitmap =3D NULL;
>      }
> =20
> @@ -679,7 +677,7 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>          }
> =20
>          /* Create a new bitmap, and freeze/disable this one. */
> -        if (bdrv_dirty_bitmap_create_successor(bs, sync_bitmap, errp) =
< 0) {
> +        if (bdrv_dirty_bitmap_create_successor(sync_bitmap, errp) < 0)=
 {
>              return NULL;
>          }
>      }
> @@ -758,10 +756,10 @@ BlockJob *backup_job_create(const char *job_id, B=
lockDriverState *bs,
>   error:
>      if (copy_bitmap) {
>          assert(!job || !job->copy_bitmap);
> -        bdrv_release_dirty_bitmap(bs, copy_bitmap);
> +        bdrv_release_dirty_bitmap(copy_bitmap);
>      }
>      if (sync_bitmap) {
> -        bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
> +        bdrv_reclaim_dirty_bitmap(sync_bitmap, NULL);
>      }
>      if (job) {
>          backup_clean(&job->common.job);
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index acfc3077f1..f3dc7b3ca5 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -29,6 +29,7 @@
> =20
>  struct BdrvDirtyBitmap {
>      QemuMutex *mutex;
> +    BlockDriverState *bs;
>      HBitmap *bitmap;            /* Dirty bitmap implementation */
>      bool busy;                  /* Bitmap is busy, it can't be used vi=
a QMP */
>      BdrvDirtyBitmap *successor; /* Anonymous child, if any. */
> @@ -114,6 +115,7 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriv=
erState *bs,
>          return NULL;
>      }
>      bitmap =3D g_new0(BdrvDirtyBitmap, 1);
> +    bitmap->bs =3D bs;
>      bitmap->mutex =3D &bs->dirty_bitmap_mutex;
>      bitmap->bitmap =3D hbitmap_alloc(bitmap_size, ctz32(granularity));
>      bitmap->size =3D bitmap_size;
> @@ -236,8 +238,7 @@ int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *=
bitmap, uint32_t flags,
>   * The successor will be enabled if the parent bitmap was.
>   * Called with BQL taken.
>   */
> -int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
> -                                       BdrvDirtyBitmap *bitmap, Error =
**errp)
> +int bdrv_dirty_bitmap_create_successor(BdrvDirtyBitmap *bitmap, Error =
**errp)
>  {
>      uint64_t granularity;
>      BdrvDirtyBitmap *child;
> @@ -253,7 +254,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverS=
tate *bs,
> =20
>      /* Create an anonymous successor */
>      granularity =3D bdrv_dirty_bitmap_granularity(bitmap);
> -    child =3D bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
> +    child =3D bdrv_create_dirty_bitmap(bitmap->bs, granularity, NULL, =
errp);
>      if (!child) {
>          return -1;
>      }
> @@ -299,8 +300,7 @@ static void bdrv_release_dirty_bitmap_locked(BdrvDi=
rtyBitmap *bitmap)
>   * delete the old bitmap, and return a handle to the new bitmap.
>   * Called with BQL taken.
>   */
> -BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
> -                                            BdrvDirtyBitmap *bitmap,
> +BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BdrvDirtyBitmap *bitmap,
>                                              Error **errp)
>  {
>      char *name;
> @@ -319,7 +319,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDr=
iverState *bs,
>      successor->persistent =3D bitmap->persistent;
>      bitmap->persistent =3D false;
>      bitmap->busy =3D false;
> -    bdrv_release_dirty_bitmap(bs, bitmap);
> +    bdrv_release_dirty_bitmap(bitmap);
> =20
>      return successor;
>  }
> @@ -331,8 +331,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDr=
iverState *bs,
>   * The marged parent will be enabled if and only if the successor was =
enabled.
>   * Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.
>   */
> -BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs=
,
> -                                                  BdrvDirtyBitmap *par=
ent,
> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BdrvDirtyBitmap *par=
ent,
>                                                    Error **errp)
>  {
>      BdrvDirtyBitmap *successor =3D parent->successor;
> @@ -356,14 +355,13 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked=
(BlockDriverState *bs,
>  }
> =20
>  /* Called with BQL taken. */
> -BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
> -                                           BdrvDirtyBitmap *parent,
> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BdrvDirtyBitmap *parent,
>                                             Error **errp)
>  {
>      BdrvDirtyBitmap *ret;
> =20
>      qemu_mutex_lock(parent->mutex);
> -    ret =3D bdrv_reclaim_dirty_bitmap_locked(bs, parent, errp);
> +    ret =3D bdrv_reclaim_dirty_bitmap_locked(parent, errp);
>      qemu_mutex_unlock(parent->mutex);
> =20
>      return ret;
> @@ -389,8 +387,10 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *=
bs, int64_t bytes)
>  }
> =20
>  /* Called with BQL taken.  */
> -void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *=
bitmap)
> +void bdrv_release_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>  {
> +    BlockDriverState *bs =3D bitmap->bs;
> +
>      bdrv_dirty_bitmaps_lock(bs);
>      bdrv_release_dirty_bitmap_locked(bitmap);
>      bdrv_dirty_bitmaps_unlock(bs);
> diff --git a/block/mirror.c b/block/mirror.c
> index fe984efb90..a6c50caea4 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -638,7 +638,7 @@ static int mirror_exit_common(Job *job)
>          bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
>      }
> =20
> -    bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
> +    bdrv_release_dirty_bitmap(s->dirty_bitmap);
> =20
>      /* Make sure that the source BDS doesn't go away during bdrv_repla=
ce_node,
>       * before we can call bdrv_drained_end */
> @@ -1709,7 +1709,7 @@ fail:
>          blk_unref(s->target);
>          bs_opaque->job =3D NULL;
>          if (s->dirty_bitmap) {
> -            bdrv_release_dirty_bitmap(bs, s->dirty_bitmap);
> +            bdrv_release_dirty_bitmap(s->dirty_bitmap);
>          }
>          job_early_fail(&s->common.job);
>      }
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index b2487101ed..6d795a2255 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -374,7 +374,7 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverStat=
e *bs,
>  fail:
>      g_free(bitmap_table);
>      if (bitmap !=3D NULL) {
> -        bdrv_release_dirty_bitmap(bs, bitmap);
> +        bdrv_release_dirty_bitmap(bitmap);
>      }
> =20
>      return NULL;
> @@ -941,7 +941,7 @@ fail:
>  static void release_dirty_bitmap_helper(gpointer bitmap,
>                                          gpointer bs)
>  {
> -    bdrv_release_dirty_bitmap(bs, bitmap);
> +    bdrv_release_dirty_bitmap(bitmap);
>  }
> =20
>  /* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
> @@ -1569,7 +1569,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDr=
iverState *bs, Error **errp)
>              continue;
>          }
> =20
> -        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
> +        bdrv_release_dirty_bitmap(bm->dirty_bitmap);
>      }
> =20
>      bitmap_list_free(bm_list);
> diff --git a/blockdev.c b/blockdev.c
> index fbef6845c8..a8593fa0c1 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2178,7 +2178,7 @@ static void block_dirty_bitmap_remove_commit(BlkA=
ctionState *common)
>                                               common, common);
> =20
>      bdrv_dirty_bitmap_set_busy(state->bitmap, false);
> -    bdrv_release_dirty_bitmap(state->bs, state->bitmap);
> +    bdrv_release_dirty_bitmap(state->bitmap);
>  }
> =20
>  static void abort_prepare(BlkActionState *common, Error **errp)
> @@ -2954,7 +2954,7 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_rem=
ove(
>      }
> =20
>      if (release) {
> -        bdrv_release_dirty_bitmap(bs, bitmap);
> +        bdrv_release_dirty_bitmap(bitmap);
>      }
> =20
>      if (bitmap_bs) {
> @@ -3086,7 +3086,7 @@ static BdrvDirtyBitmap *do_block_dirty_bitmap_mer=
ge(
>      bdrv_merge_dirty_bitmap(dst, anon, backup, errp);
> =20
>   out:
> -    bdrv_release_dirty_bitmap(bs, anon);
> +    bdrv_release_dirty_bitmap(anon);
>      return dst;
>  }
> =20
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bit=
map.c
> index 5121f86d73..793f249aa5 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -474,7 +474,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, Dir=
tyBitmapLoadState *s)
>      if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
>          DirtyBitmapLoadBitmapState *b;
> =20
> -        bdrv_dirty_bitmap_create_successor(s->bs, s->bitmap, &local_er=
r);
> +        bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              return -EINVAL;
> @@ -535,13 +535,12 @@ static void dirty_bitmap_load_complete(QEMUFile *=
f, DirtyBitmapLoadState *s)
>          bdrv_dirty_bitmap_lock(s->bitmap);
>          if (enabled_bitmaps =3D=3D NULL) {
>              /* in postcopy */
> -            bdrv_reclaim_dirty_bitmap_locked(s->bs, s->bitmap, &error_=
abort);
> +            bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
>              bdrv_enable_dirty_bitmap_locked(s->bitmap);
>          } else {
>              /* target not started, successor must be empty */
>              int64_t count =3D bdrv_get_dirty_count(s->bitmap);
> -            BdrvDirtyBitmap *ret =3D bdrv_reclaim_dirty_bitmap_locked(=
s->bs,
> -                                                                    s-=
>bitmap,
> +            BdrvDirtyBitmap *ret =3D bdrv_reclaim_dirty_bitmap_locked(=
s->bitmap,
>                                                                      NU=
LL);
>              /* bdrv_reclaim_dirty_bitmap can fail only on no successor=
 (it
>               * must be) or on merge fail, but merge can't fail when se=
cond
> diff --git a/migration/block.c b/migration/block.c
> index 0de9d84198..0496b9b66e 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -361,7 +361,7 @@ static int set_dirty_tracking(void)
>  fail:
>      QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
>          if (bmds->dirty_bitmap) {
> -            bdrv_release_dirty_bitmap(blk_bs(bmds->blk), bmds->dirty_b=
itmap);
> +            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
>          }
>      }
>      return ret;
> @@ -374,7 +374,7 @@ static void unset_dirty_tracking(void)
>      BlkMigDevState *bmds;
> =20
>      QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
> -        bdrv_release_dirty_bitmap(blk_bs(bmds->blk), bmds->dirty_bitma=
p);
> +        bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
>      }
>  }
> =20
>=20

--=20
=E2=80=94js

