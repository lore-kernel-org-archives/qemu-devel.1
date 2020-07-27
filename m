Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91BC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327A720729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="To74MJQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327A720729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0AGG-0005u1-Bn
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAS-0005Jv-BH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAO-0004wE-EC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sg6tJDbO72LwAKARdg9zDX9TDfIxVD+Q8BzNg0L4F0I=;
 b=To74MJQ9t0KPu6gTUYSn0iZsxVkNQ4U9VpKFEZJ2wCI2UBsSRKNVCMjeGUkJ8m2r4dATab
 I1993hfOSb3/6ZAg0X77mXkB12lJnxYKoqQB02dRTwCk9M3nSRTEaBmTaIIss5/lwGeCr3
 Y6dfoIY3NLn+VaRaOt7TQviUkecK9Yc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-8RAXLN6-OsOIv5zbIspMCg-1; Mon, 27 Jul 2020 16:56:08 -0400
X-MC-Unique: 8RAXLN6-OsOIv5zbIspMCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 243B458;
 Mon, 27 Jul 2020 20:56:07 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0DA419D82;
 Mon, 27 Jul 2020 20:56:04 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/24] migration/block-dirty-bitmap: rename state structure
 types
Date: Mon, 27 Jul 2020 15:55:28 -0500
Message-Id: <20200727205543.206624-10-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Dirty Bitmaps" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Rename types to be symmetrical for load/save part and shorter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727194236.19551-9-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 70 ++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 0739f1259e05..1d57bff4f6c7 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -100,23 +100,25 @@
 /* 0x04 was "AUTOLOAD" flags on elder versions, no it is ignored */
 #define DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK    0xf8

-typedef struct DirtyBitmapMigBitmapState {
+/* State of one bitmap during save process */
+typedef struct SaveBitmapState {
     /* Written during setup phase. */
     BlockDriverState *bs;
     const char *node_name;
     BdrvDirtyBitmap *bitmap;
     uint64_t total_sectors;
     uint64_t sectors_per_chunk;
-    QSIMPLEQ_ENTRY(DirtyBitmapMigBitmapState) entry;
+    QSIMPLEQ_ENTRY(SaveBitmapState) entry;
     uint8_t flags;

     /* For bulk phase. */
     bool bulk_completed;
     uint64_t cur_sector;
-} DirtyBitmapMigBitmapState;
+} SaveBitmapState;

-typedef struct DirtyBitmapMigState {
-    QSIMPLEQ_HEAD(, DirtyBitmapMigBitmapState) dbms_list;
+/* State of the dirty bitmap migration (DBM) during save process */
+typedef struct DBMSaveState {
+    QSIMPLEQ_HEAD(, SaveBitmapState) dbms_list;

     bool bulk_completed;
     bool no_bitmaps;
@@ -124,23 +126,25 @@ typedef struct DirtyBitmapMigState {
     /* for send_bitmap_bits() */
     BlockDriverState *prev_bs;
     BdrvDirtyBitmap *prev_bitmap;
-} DirtyBitmapMigState;
+} DBMSaveState;

-typedef struct DirtyBitmapLoadState {
+/* State of the dirty bitmap migration (DBM) during load process */
+typedef struct DBMLoadState {
     uint32_t flags;
     char node_name[256];
     char bitmap_name[256];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
-} DirtyBitmapLoadState;
+} DBMLoadState;

-static DirtyBitmapMigState dirty_bitmap_mig_state;
+static DBMSaveState dirty_bitmap_mig_state;

-typedef struct DirtyBitmapLoadBitmapState {
+/* State of one bitmap during load process */
+typedef struct LoadBitmapState {
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     bool migrated;
-} DirtyBitmapLoadBitmapState;
+} LoadBitmapState;
 static GSList *enabled_bitmaps;
 QemuMutex finish_lock;

@@ -170,7 +174,7 @@ static void qemu_put_bitmap_flags(QEMUFile *f, uint32_t flags)
     qemu_put_byte(f, flags);
 }

-static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
+static void send_bitmap_header(QEMUFile *f, SaveBitmapState *dbms,
                                uint32_t additional_flags)
 {
     BlockDriverState *bs = dbms->bs;
@@ -199,19 +203,19 @@ static void send_bitmap_header(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
     }
 }

-static void send_bitmap_start(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void send_bitmap_start(QEMUFile *f, SaveBitmapState *dbms)
 {
     send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_START);
     qemu_put_be32(f, bdrv_dirty_bitmap_granularity(dbms->bitmap));
     qemu_put_byte(f, dbms->flags);
 }

-static void send_bitmap_complete(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void send_bitmap_complete(QEMUFile *f, SaveBitmapState *dbms)
 {
     send_bitmap_header(f, dbms, DIRTY_BITMAP_MIG_FLAG_COMPLETE);
 }

-static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
+static void send_bitmap_bits(QEMUFile *f, SaveBitmapState *dbms,
                              uint64_t start_sector, uint32_t nr_sectors)
 {
     /* align for buffer_is_zero() */
@@ -257,7 +261,7 @@ static void send_bitmap_bits(QEMUFile *f, DirtyBitmapMigBitmapState *dbms,
 /* Called with iothread lock taken.  */
 static void dirty_bitmap_mig_cleanup(void)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;

     while ((dbms = QSIMPLEQ_FIRST(&dirty_bitmap_mig_state.dbms_list)) != NULL) {
         QSIMPLEQ_REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list, entry);
@@ -271,7 +275,7 @@ static void dirty_bitmap_mig_cleanup(void)
 static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
 {
     BdrvDirtyBitmap *bitmap;
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     Error *local_err = NULL;

     FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
@@ -309,7 +313,7 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
         bdrv_ref(bs);
         bdrv_dirty_bitmap_set_busy(bitmap, true);

-        dbms = g_new0(DirtyBitmapMigBitmapState, 1);
+        dbms = g_new0(SaveBitmapState, 1);
         dbms->bs = bs;
         dbms->node_name = bs_name;
         dbms->bitmap = bitmap;
@@ -334,7 +338,7 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
 static int init_dirty_bitmap_migration(void)
 {
     BlockDriverState *bs;
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
     BlockBackend *blk;

@@ -408,7 +412,7 @@ fail:
 }

 /* Called with no lock taken.  */
-static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
+static void bulk_phase_send_chunk(QEMUFile *f, SaveBitmapState *dbms)
 {
     uint32_t nr_sectors = MIN(dbms->total_sectors - dbms->cur_sector,
                              dbms->sectors_per_chunk);
@@ -424,7 +428,7 @@ static void bulk_phase_send_chunk(QEMUFile *f, DirtyBitmapMigBitmapState *dbms)
 /* Called with no lock taken.  */
 static void bulk_phase(QEMUFile *f, bool limit)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;

     QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
         while (!dbms->bulk_completed) {
@@ -461,7 +465,7 @@ static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)

 static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     trace_dirty_bitmap_save_complete_enter();

     if (!dirty_bitmap_mig_state.bulk_completed) {
@@ -486,7 +490,7 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
                                       uint64_t *res_compatible,
                                       uint64_t *res_postcopy_only)
 {
-    DirtyBitmapMigBitmapState *dbms;
+    SaveBitmapState *dbms;
     uint64_t pending = 0;

     qemu_mutex_lock_iothread();
@@ -507,7 +511,7 @@ static void dirty_bitmap_save_pending(QEMUFile *f, void *opaque,
 }

 /* First occurrence of this bitmap. It should be created if doesn't exist */
-static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
 {
     Error *local_err = NULL;
     uint32_t granularity = qemu_get_be32(f);
@@ -538,7 +542,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)

     bdrv_disable_dirty_bitmap(s->bitmap);
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
-        DirtyBitmapLoadBitmapState *b;
+        LoadBitmapState *b;

         bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
         if (local_err) {
@@ -546,7 +550,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DirtyBitmapLoadState *s)
             return -EINVAL;
         }

-        b = g_new(DirtyBitmapLoadBitmapState, 1);
+        b = g_new(LoadBitmapState, 1);
         b->bs = s->bs;
         b->bitmap = s->bitmap;
         b->migrated = false;
@@ -563,7 +567,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     qemu_mutex_lock(&finish_lock);

     for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
-        DirtyBitmapLoadBitmapState *b = item->data;
+        LoadBitmapState *b = item->data;

         if (b->migrated) {
             bdrv_enable_dirty_bitmap(b->bitmap);
@@ -580,7 +584,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     qemu_mutex_unlock(&finish_lock);
 }

-static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
+static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 {
     GSList *item;
     trace_dirty_bitmap_load_complete();
@@ -589,7 +593,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
     qemu_mutex_lock(&finish_lock);

     for (item = enabled_bitmaps; item; item = g_slist_next(item)) {
-        DirtyBitmapLoadBitmapState *b = item->data;
+        LoadBitmapState *b = item->data;

         if (b->bitmap == s->bitmap) {
             b->migrated = true;
@@ -621,7 +625,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
     qemu_mutex_unlock(&finish_lock);
 }

-static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
 {
     uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
     uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
@@ -666,7 +670,7 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState *s)
     return 0;
 }

-static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)
+static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s)
 {
     Error *local_err = NULL;
     bool nothing;
@@ -715,7 +719,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DirtyBitmapLoadState *s)

 static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
 {
-    static DirtyBitmapLoadState s;
+    static DBMLoadState s;
     int ret = 0;

     trace_dirty_bitmap_load_enter();
@@ -753,7 +757,7 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)

 static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
 {
-    DirtyBitmapMigBitmapState *dbms = NULL;
+    SaveBitmapState *dbms = NULL;
     if (init_dirty_bitmap_migration() < 0) {
         return -1;
     }
-- 
2.27.0


