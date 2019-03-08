Received: from eggs.gnu.org ([209.51.188.92]:55331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2Mwy-0000cq-Or
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2Mwx-0002QM-Op
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:22:40 -0500
References: <20190308205845.25734-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6c0eb003-6bd5-2683-5a0c-10578974890c@redhat.com>
Date: Fri, 8 Mar 2019 16:22:32 -0500
MIME-Version: 1.0
In-Reply-To: <20190308205845.25734-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] bitmaps: Fix typo in function name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 3/8/19 3:58 PM, Eric Blake wrote:
> Commit a88b179f introduced the ability to set and query bitmap
> persistence, but with an atypical spelling.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Based-on: <20190308202858.26636-1-jsnow@redhat.com>
> [PULL 00/17 Bitmaps patches]
> (Don't know if John wants to do a v2 pull request to silence some
> checkpatch warnings, in which case this could sneak in...)
> 

Yes, I'll take it. Staged.

--js

>  include/block/dirty-bitmap.h   | 4 ++--
>  block/dirty-bitmap.c           | 4 ++--
>  block/qcow2-bitmap.c           | 6 +++---
>  blockdev.c                     | 4 ++--
>  migration/block-dirty-bitmap.c | 4 ++--
>  5 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 2a782439547..8044ace63e4 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -78,7 +78,7 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
>  void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
> 
>  void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
> -void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
> +void bdrv_dirty_bitmap_set_persistence(BdrvDirtyBitmap *bitmap,
>                                         bool persistent);
>  void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap);
>  void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy);
> @@ -103,7 +103,7 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
>  bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
>  bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>  bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
> -bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
> +bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap);
>  bool bdrv_dirty_bitmap_inconsistent(const BdrvDirtyBitmap *bitmap);
>  bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
>  BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 59c403c3fd5..b08d4ec69ee 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -739,7 +739,7 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
>  }
> 
>  /* Called with BQL taken. */
> -void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
> +void bdrv_dirty_bitmap_set_persistence(BdrvDirtyBitmap *bitmap, bool persistent)
>  {
>      qemu_mutex_lock(bitmap->mutex);
>      bitmap->persistent = persistent;
> @@ -764,7 +764,7 @@ void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration)
>      qemu_mutex_unlock(bitmap->mutex);
>  }
> 
> -bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
> +bool bdrv_dirty_bitmap_get_persistence(BdrvDirtyBitmap *bitmap)
>  {
>      return bitmap->persistent && !bitmap->migration;
>  }
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 80926966de2..6adbe06b4d2 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -968,7 +968,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>              goto fail;
>          }
> 
> -        bdrv_dirty_bitmap_set_persistance(bitmap, true);
> +        bdrv_dirty_bitmap_set_persistence(bitmap, true);
>          if (bm->flags & BME_FLAG_IN_USE) {
>              bdrv_dirty_bitmap_set_inconsistent(bitmap);
>          } else {
> @@ -1426,7 +1426,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>          uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
>          Qcow2Bitmap *bm;
> 
> -        if (!bdrv_dirty_bitmap_get_persistance(bitmap) ||
> +        if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
>              bdrv_dirty_bitmap_readonly(bitmap) ||
>              bdrv_dirty_bitmap_inconsistent(bitmap)) {
>              continue;
> @@ -1544,7 +1544,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>      for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap != NULL;
>           bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
>      {
> -        if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +        if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
>              bdrv_dirty_bitmap_set_readonly(bitmap, true);
>          }
>      }
> diff --git a/blockdev.c b/blockdev.c
> index 51fcfb7faf1..267debda336 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2862,7 +2862,7 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
>          bdrv_disable_dirty_bitmap(bitmap);
>      }
> 
> -    bdrv_dirty_bitmap_set_persistance(bitmap, persistent);
> +    bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
>   out:
>      if (aio_context) {
>          aio_context_release(aio_context);
> @@ -2887,7 +2887,7 @@ void qmp_block_dirty_bitmap_remove(const char *node, const char *name,
>          return;
>      }
> 
> -    if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +    if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
>          aio_context = bdrv_get_aio_context(bs);
>          aio_context_acquire(aio_context);
>          bdrv_remove_persistent_dirty_bitmap(bs, name, &local_err);
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 0fcf897f329..ac095dae0f5 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -320,7 +320,7 @@ static int init_dirty_bitmap_migration(void)
>              if (bdrv_dirty_bitmap_enabled(bitmap)) {
>                  dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
>              }
> -            if (bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +            if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
>                  dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
>              }
> 
> @@ -472,7 +472,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
>      }
> 
>      if (flags & DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT) {
> -        bdrv_dirty_bitmap_set_persistance(s->bitmap, true);
> +        bdrv_dirty_bitmap_set_persistence(s->bitmap, true);
>      }
> 
>      bdrv_disable_dirty_bitmap(s->bitmap);
> 
