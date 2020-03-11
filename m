Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C227C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA7D21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKk4ewI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA7D21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC270-0007F2-UX
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1nU-0005L0-7c
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1nS-0003CG-7v
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1nS-0003Bx-2v
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsXFZvpC2pkw5R53Eh8TmgXAp8Rg3em1Lkxo7kx5aMs=;
 b=jKk4ewI2XT4WkdY9nrW1CHeflN8ocTYM/DQv/dpQznOvzHAbLHdtnU1v+Q+QUtyhJ1zmY/
 0Oe5m96sVqteC6paZ5s7iGoGU321iLJarirgkOtKYKkPIzHd51Yf4ljIO20oNDvM3E2HLL
 YPVmafJaHvpnrr3ljdIWB8e/+CdyT1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-x4Plmby7ORWvWOwBCAZjOg-1; Wed, 11 Mar 2020 09:53:15 -0400
X-MC-Unique: x4Plmby7ORWvWOwBCAZjOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E2F1801E6C;
 Wed, 11 Mar 2020 13:53:14 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75C378FBE0;
 Wed, 11 Mar 2020 13:53:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 19/19] block/block-copy: hide structure definitions
Date: Wed, 11 Mar 2020 14:52:13 +0100
Message-Id: <20200311135213.1242028-20-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Hide structure definitions and add explicit API instead, to keep an
eye on the scope of the shared fields.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200311103004.7649-10-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup-top.c         |  6 ++--
 block/backup.c             | 25 ++++++++--------
 block/block-copy.c         | 59 ++++++++++++++++++++++++++++++++++++++
 include/block/block-copy.h | 52 +++------------------------------
 4 files changed, 80 insertions(+), 62 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index 1bfb360bd3..3b50c06e2c 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -38,6 +38,7 @@ typedef struct BDRVBackupTopState {
     BlockCopyState *bcs;
     BdrvChild *target;
     bool active;
+    int64_t cluster_size;
 } BDRVBackupTopState;
=20
 static coroutine_fn int backup_top_co_preadv(
@@ -57,8 +58,8 @@ static coroutine_fn int backup_top_cbw(BlockDriverState *=
bs, uint64_t offset,
         return 0;
     }
=20
-    off =3D QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
-    end =3D QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size);
+    off =3D QEMU_ALIGN_DOWN(offset, s->cluster_size);
+    end =3D QEMU_ALIGN_UP(offset + bytes, s->cluster_size);
=20
     return block_copy(s->bcs, off, end - off, NULL);
 }
@@ -238,6 +239,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverSta=
te *source,
         goto fail;
     }
=20
+    state->cluster_size =3D cluster_size;
     state->bcs =3D block_copy_state_new(top->backing, state->target,
                                       cluster_size, write_flags, &local_er=
r);
     if (local_err) {
diff --git a/block/backup.c b/block/backup.c
index 8694e0394b..7430ca5883 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -102,7 +102,7 @@ static void backup_cleanup_sync_bitmap(BackupBlockJob *=
job, int ret)
=20
     if (ret < 0 && job->bitmap_mode =3D=3D BITMAP_SYNC_MODE_ALWAYS) {
         /* If we failed and synced, merge in the bits we didn't copy: */
-        bdrv_dirty_bitmap_merge_internal(bm, job->bcs->copy_bitmap,
+        bdrv_dirty_bitmap_merge_internal(bm, block_copy_dirty_bitmap(job->=
bcs),
                                          NULL, true);
     }
 }
@@ -145,7 +145,8 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
         return;
     }
=20
-    bdrv_set_dirty_bitmap(backup_job->bcs->copy_bitmap, 0, backup_job->len=
);
+    bdrv_set_dirty_bitmap(block_copy_dirty_bitmap(backup_job->bcs), 0,
+                          backup_job->len);
 }
=20
 static BlockErrorAction backup_error_action(BackupBlockJob *job,
@@ -190,7 +191,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *job=
)
     BdrvDirtyBitmapIter *bdbi;
     int ret =3D 0;
=20
-    bdbi =3D bdrv_dirty_iter_new(job->bcs->copy_bitmap);
+    bdbi =3D bdrv_dirty_iter_new(block_copy_dirty_bitmap(job->bcs));
     while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
         do {
             if (yield_and_check(job)) {
@@ -210,14 +211,14 @@ static int coroutine_fn backup_loop(BackupBlockJob *j=
ob)
     return ret;
 }
=20
-static void backup_init_copy_bitmap(BackupBlockJob *job)
+static void backup_init_bcs_bitmap(BackupBlockJob *job)
 {
     bool ret;
     uint64_t estimate;
+    BdrvDirtyBitmap *bcs_bitmap =3D block_copy_dirty_bitmap(job->bcs);
=20
     if (job->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
-        ret =3D bdrv_dirty_bitmap_merge_internal(job->bcs->copy_bitmap,
-                                               job->sync_bitmap,
+        ret =3D bdrv_dirty_bitmap_merge_internal(bcs_bitmap, job->sync_bit=
map,
                                                NULL, true);
         assert(ret);
     } else {
@@ -226,12 +227,12 @@ static void backup_init_copy_bitmap(BackupBlockJob *j=
ob)
              * We can't hog the coroutine to initialize this thoroughly.
              * Set a flag and resume work when we are able to yield safely=
.
              */
-            job->bcs->skip_unallocated =3D true;
+            block_copy_set_skip_unallocated(job->bcs, true);
         }
-        bdrv_set_dirty_bitmap(job->bcs->copy_bitmap, 0, job->len);
+        bdrv_set_dirty_bitmap(bcs_bitmap, 0, job->len);
     }
=20
-    estimate =3D bdrv_get_dirty_count(job->bcs->copy_bitmap);
+    estimate =3D bdrv_get_dirty_count(bcs_bitmap);
     job_progress_set_remaining(&job->common.job, estimate);
 }
=20
@@ -240,7 +241,7 @@ static int coroutine_fn backup_run(Job *job, Error **er=
rp)
     BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
     int ret =3D 0;
=20
-    backup_init_copy_bitmap(s);
+    backup_init_bcs_bitmap(s);
=20
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
         int64_t offset =3D 0;
@@ -259,12 +260,12 @@ static int coroutine_fn backup_run(Job *job, Error **=
errp)
=20
             offset +=3D count;
         }
-        s->bcs->skip_unallocated =3D false;
+        block_copy_set_skip_unallocated(s->bcs, false);
     }
=20
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) {
         /*
-         * All bits are set in copy_bitmap to allow any cluster to be copi=
ed.
+         * All bits are set in bcs bitmap to allow any cluster to be copie=
d.
          * This does not actually require them to be copied.
          */
         while (!job_is_cancelled(job)) {
diff --git a/block/block-copy.c b/block/block-copy.c
index 44a64a94c8..05227e18bf 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -24,6 +24,55 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
+typedef struct BlockCopyInFlightReq {
+    int64_t offset;
+    int64_t bytes;
+    QLIST_ENTRY(BlockCopyInFlightReq) list;
+    CoQueue wait_queue; /* coroutines blocked on this request */
+} BlockCopyInFlightReq;
+
+typedef struct BlockCopyState {
+    /*
+     * BdrvChild objects are not owned or managed by block-copy. They are
+     * provided by block-copy user and user is responsible for appropriate
+     * permissions on these children.
+     */
+    BdrvChild *source;
+    BdrvChild *target;
+    BdrvDirtyBitmap *copy_bitmap;
+    int64_t in_flight_bytes;
+    int64_t cluster_size;
+    bool use_copy_range;
+    int64_t copy_size;
+    uint64_t len;
+    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
+
+    BdrvRequestFlags write_flags;
+
+    /*
+     * skip_unallocated:
+     *
+     * Used by sync=3Dtop jobs, which first scan the source node for unall=
ocated
+     * areas and clear them in the copy_bitmap.  During this process, the =
bitmap
+     * is thus not fully initialized: It may still have bits set for areas=
 that
+     * are unallocated and should actually not be copied.
+     *
+     * This is indicated by skip_unallocated.
+     *
+     * In this case, block_copy() will query the source=E2=80=99s allocati=
on status,
+     * skip unallocated regions, clear them in the copy_bitmap, and invoke
+     * block_copy_reset_unallocated() every time it does.
+     */
+    bool skip_unallocated;
+
+    ProgressMeter *progress;
+    /* progress_bytes_callback: called when some copying progress is done.=
 */
+    ProgressBytesCallbackFunc progress_bytes_callback;
+    void *progress_opaque;
+
+    SharedResource *mem;
+} BlockCopyState;
+
 static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState =
*s,
                                                            int64_t offset,
                                                            int64_t bytes)
@@ -517,3 +566,13 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t=
 offset, int64_t bytes,
=20
     return ret;
 }
+
+BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
+{
+    return s->copy_bitmap;
+}
+
+void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
+{
+    s->skip_unallocated =3D skip;
+}
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index b76efb736f..aac85e1488 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -18,55 +18,8 @@
 #include "block/block.h"
 #include "qemu/co-shared-resource.h"
=20
-typedef struct BlockCopyInFlightReq {
-    int64_t offset;
-    int64_t bytes;
-    QLIST_ENTRY(BlockCopyInFlightReq) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} BlockCopyInFlightReq;
-
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
-typedef struct BlockCopyState {
-    /*
-     * BdrvChild objects are not owned or managed by block-copy. They are
-     * provided by block-copy user and user is responsible for appropriate
-     * permissions on these children.
-     */
-    BdrvChild *source;
-    BdrvChild *target;
-    BdrvDirtyBitmap *copy_bitmap;
-    int64_t in_flight_bytes;
-    int64_t cluster_size;
-    bool use_copy_range;
-    int64_t copy_size;
-    uint64_t len;
-    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
-
-    BdrvRequestFlags write_flags;
-
-    /*
-     * skip_unallocated:
-     *
-     * Used by sync=3Dtop jobs, which first scan the source node for unall=
ocated
-     * areas and clear them in the copy_bitmap.  During this process, the =
bitmap
-     * is thus not fully initialized: It may still have bits set for areas=
 that
-     * are unallocated and should actually not be copied.
-     *
-     * This is indicated by skip_unallocated.
-     *
-     * In this case, block_copy() will query the source=E2=80=99s allocati=
on status,
-     * skip unallocated regions, clear them in the copy_bitmap, and invoke
-     * block_copy_reset_unallocated() every time it does.
-     */
-    bool skip_unallocated;
-
-    ProgressMeter *progress;
-    /* progress_bytes_callback: called when some copying progress is done.=
 */
-    ProgressBytesCallbackFunc progress_bytes_callback;
-    void *progress_opaque;
-
-    SharedResource *mem;
-} BlockCopyState;
+typedef struct BlockCopyState BlockCopyState;
=20
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      int64_t cluster_size,
@@ -88,4 +41,7 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t byt=
es,
                             bool *error_is_read);
=20
+BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
+void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
+
 #endif /* BLOCK_COPY_H */
--=20
2.24.1


