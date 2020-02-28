Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AFBC3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDCB524695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEbte838"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCB524695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7byL-0008ES-Py
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7btu-0000MY-1F
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7bts-0004A9-KB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7bts-00049x-Gk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582881940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lVzmnoIFQZpsu8Q3f0pxzEHlPBdgDz/HFFS89KovN8=;
 b=LEbte838/EFgtMDDhLgsN4kctd5t/DAVVZiG2UhqtUyy+CYo8nUmxLZ2YAlu9+V1UNVeS5
 altNhev06nnej/ho+fkuCh/651fC04zysI8VXEZsDr+AVbZ44d9zLc81ekBjAOXG7byj1L
 CBzLxZNlOoofOSRXuUxZsGRfMs3hZdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-iLxbxogSM5ijmsQwWYzLmw-1; Fri, 28 Feb 2020 04:25:38 -0500
X-MC-Unique: iLxbxogSM5ijmsQwWYzLmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA5B2D4A;
 Fri, 28 Feb 2020 09:25:36 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4D7160BE0;
 Fri, 28 Feb 2020 09:25:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] migration/block: rename BLOCK_SIZE macro
Date: Fri, 28 Feb 2020 10:24:17 +0100
Message-Id: <20200228092420.103757-13-quintela@redhat.com>
In-Reply-To: <20200228092420.103757-1-quintela@redhat.com>
References: <20200228092420.103757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Both <linux/fs.h> and <sys/mount.h> define BLOCK_SIZE macros.  Avoiding
using that name in block/migration.c.

I noticed this when including <liburing.h> (Linux io_uring) from
"block/aio.h" and compilation failed.  Although patches adding that
include haven't been sent yet, it makes sense to rename the macro now in
case someone else stumbles on it in the meantime.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/block.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index c90288ed29..737b6499f9 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -27,8 +27,8 @@
 #include "migration/vmstate.h"
 #include "sysemu/block-backend.h"
=20
-#define BLOCK_SIZE                       (1 << 20)
-#define BDRV_SECTORS_PER_DIRTY_CHUNK     (BLOCK_SIZE >> BDRV_SECTOR_BITS)
+#define BLK_MIG_BLOCK_SIZE           (1 << 20)
+#define BDRV_SECTORS_PER_DIRTY_CHUNK (BLK_MIG_BLOCK_SIZE >> BDRV_SECTOR_BI=
TS)
=20
 #define BLK_MIG_FLAG_DEVICE_BLOCK       0x01
 #define BLK_MIG_FLAG_EOS                0x02
@@ -133,7 +133,7 @@ static void blk_send(QEMUFile *f, BlkMigBlock * blk)
     uint64_t flags =3D BLK_MIG_FLAG_DEVICE_BLOCK;
=20
     if (block_mig_state.zero_blocks &&
-        buffer_is_zero(blk->buf, BLOCK_SIZE)) {
+        buffer_is_zero(blk->buf, BLK_MIG_BLOCK_SIZE)) {
         flags |=3D BLK_MIG_FLAG_ZERO_BLOCK;
     }
=20
@@ -154,7 +154,7 @@ static void blk_send(QEMUFile *f, BlkMigBlock * blk)
         return;
     }
=20
-    qemu_put_buffer(f, blk->buf, BLOCK_SIZE);
+    qemu_put_buffer(f, blk->buf, BLK_MIG_BLOCK_SIZE);
 }
=20
 int blk_mig_active(void)
@@ -309,7 +309,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevS=
tate *bmds)
     }
=20
     blk =3D g_new(BlkMigBlock, 1);
-    blk->buf =3D g_malloc(BLOCK_SIZE);
+    blk->buf =3D g_malloc(BLK_MIG_BLOCK_SIZE);
     blk->bmds =3D bmds;
     blk->sector =3D cur_sector;
     blk->nr_sectors =3D nr_sectors;
@@ -350,7 +350,8 @@ static int set_dirty_tracking(void)
=20
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
         bmds->dirty_bitmap =3D bdrv_create_dirty_bitmap(blk_bs(bmds->blk),
-                                                      BLOCK_SIZE, NULL, NU=
LL);
+                                                      BLK_MIG_BLOCK_SIZE,
+                                                      NULL, NULL);
         if (!bmds->dirty_bitmap) {
             ret =3D -errno;
             goto fail;
@@ -548,7 +549,7 @@ static int mig_save_device_dirty(QEMUFile *f, BlkMigDev=
State *bmds,
             bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
=20
             blk =3D g_new(BlkMigBlock, 1);
-            blk->buf =3D g_malloc(BLOCK_SIZE);
+            blk->buf =3D g_malloc(BLK_MIG_BLOCK_SIZE);
             blk->bmds =3D bmds;
             blk->sector =3D sector;
             blk->nr_sectors =3D nr_sectors;
@@ -770,7 +771,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque=
)
=20
     /* control the rate of transfer */
     blk_mig_lock();
-    while (block_mig_state.read_done * BLOCK_SIZE <
+    while (block_mig_state.read_done * BLK_MIG_BLOCK_SIZE <
            qemu_file_get_rate_limit(f) &&
            block_mig_state.submitted < MAX_PARALLEL_IO &&
            (block_mig_state.submitted + block_mig_state.read_done) <
@@ -874,13 +875,13 @@ static void block_save_pending(QEMUFile *f, void *opa=
que, uint64_t max_size,
     qemu_mutex_unlock_iothread();
=20
     blk_mig_lock();
-    pending +=3D block_mig_state.submitted * BLOCK_SIZE +
-               block_mig_state.read_done * BLOCK_SIZE;
+    pending +=3D block_mig_state.submitted * BLK_MIG_BLOCK_SIZE +
+               block_mig_state.read_done * BLK_MIG_BLOCK_SIZE;
     blk_mig_unlock();
=20
     /* Report at least one block pending during bulk phase */
     if (pending <=3D max_size && !block_mig_state.bulk_completed) {
-        pending =3D max_size + BLOCK_SIZE;
+        pending =3D max_size + BLK_MIG_BLOCK_SIZE;
     }
=20
     DPRINTF("Enter save live pending  %" PRIu64 "\n", pending);
@@ -901,7 +902,7 @@ static int block_load(QEMUFile *f, void *opaque, int ve=
rsion_id)
     int nr_sectors;
     int ret;
     BlockDriverInfo bdi;
-    int cluster_size =3D BLOCK_SIZE;
+    int cluster_size =3D BLK_MIG_BLOCK_SIZE;
=20
     do {
         addr =3D qemu_get_be64(f);
@@ -939,11 +940,11 @@ static int block_load(QEMUFile *f, void *opaque, int =
version_id)
=20
                 ret =3D bdrv_get_info(blk_bs(blk), &bdi);
                 if (ret =3D=3D 0 && bdi.cluster_size > 0 &&
-                    bdi.cluster_size <=3D BLOCK_SIZE &&
-                    BLOCK_SIZE % bdi.cluster_size =3D=3D 0) {
+                    bdi.cluster_size <=3D BLK_MIG_BLOCK_SIZE &&
+                    BLK_MIG_BLOCK_SIZE % bdi.cluster_size =3D=3D 0) {
                     cluster_size =3D bdi.cluster_size;
                 } else {
-                    cluster_size =3D BLOCK_SIZE;
+                    cluster_size =3D BLK_MIG_BLOCK_SIZE;
                 }
             }
=20
@@ -962,14 +963,14 @@ static int block_load(QEMUFile *f, void *opaque, int =
version_id)
                 int64_t cur_addr;
                 uint8_t *cur_buf;
=20
-                buf =3D g_malloc(BLOCK_SIZE);
-                qemu_get_buffer(f, buf, BLOCK_SIZE);
-                for (i =3D 0; i < BLOCK_SIZE / cluster_size; i++) {
+                buf =3D g_malloc(BLK_MIG_BLOCK_SIZE);
+                qemu_get_buffer(f, buf, BLK_MIG_BLOCK_SIZE);
+                for (i =3D 0; i < BLK_MIG_BLOCK_SIZE / cluster_size; i++) =
{
                     cur_addr =3D addr * BDRV_SECTOR_SIZE + i * cluster_siz=
e;
                     cur_buf =3D buf + i * cluster_size;
=20
                     if ((!block_mig_state.zero_blocks ||
-                        cluster_size < BLOCK_SIZE) &&
+                        cluster_size < BLK_MIG_BLOCK_SIZE) &&
                         buffer_is_zero(cur_buf, cluster_size)) {
                         ret =3D blk_pwrite_zeroes(blk, cur_addr,
                                                 cluster_size,
--=20
2.24.1


