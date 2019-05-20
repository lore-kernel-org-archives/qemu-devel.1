Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C537C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B3B214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B3B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38029 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSkzb-00024Y-Lx
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:18:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwq-0008EB-HD
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwp-0003Xe-7z
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSkwk-0003HA-8v; Mon, 20 May 2019 12:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 774563091851;
	Mon, 20 May 2019 16:15:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E53FD1E4;
	Mon, 20 May 2019 16:14:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 20 May 2019 18:14:31 +0200
Message-Id: <20190520161453.30723-3-kwolf@redhat.com>
In-Reply-To: <20190520161453.30723-1-kwolf@redhat.com>
References: <20190520161453.30723-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 20 May 2019 16:15:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/24] qcow2: Define and use
 QCOW2_COMPRESSED_SECTOR_SIZE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

When an L2 table entry points to a compressed cluster the space used
by the data is specified in 512-byte sectors. This size is independent
from BDRV_SECTOR_SIZE and is specific to the qcow2 file format.

The QCOW2_COMPRESSED_SECTOR_SIZE constant defined in this patch makes
this explicit.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h          |  4 ++++
 block/qcow2-cluster.c  |  5 +++--
 block/qcow2-refcount.c | 25 ++++++++++++++-----------
 block/qcow2.c          |  3 ++-
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index e62508d1ce..8d92ef1fee 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -74,6 +74,10 @@
 #define MIN_CLUSTER_BITS 9
 #define MAX_CLUSTER_BITS 21
=20
+/* Defined in the qcow2 spec (compressed cluster descriptor) */
+#define QCOW2_COMPRESSED_SECTOR_SIZE 512U
+#define QCOW2_COMPRESSED_SECTOR_MASK (~(QCOW2_COMPRESSED_SECTOR_SIZE - 1=
))
+
 /* Must be at least 2 to cover COW */
 #define MIN_L2_CACHE_SIZE 2 /* cache entries */
=20
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 974a4e8656..b36f4aa84a 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -796,8 +796,9 @@ int qcow2_alloc_compressed_cluster_offset(BlockDriver=
State *bs,
         return cluster_offset;
     }
=20
-    nb_csectors =3D ((cluster_offset + compressed_size - 1) >> 9) -
-                  (cluster_offset >> 9);
+    nb_csectors =3D
+        (cluster_offset + compressed_size - 1) / QCOW2_COMPRESSED_SECTOR=
_SIZE -
+        (cluster_offset / QCOW2_COMPRESSED_SECTOR_SIZE);
=20
     cluster_offset |=3D QCOW_OFLAG_COMPRESSED |
                       ((uint64_t)nb_csectors << s->csize_shift);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7481903396..0b09d6838b 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1172,12 +1172,11 @@ void qcow2_free_any_clusters(BlockDriverState *bs=
, uint64_t l2_entry,
     switch (ctype) {
     case QCOW2_CLUSTER_COMPRESSED:
         {
-            int nb_csectors;
-            nb_csectors =3D ((l2_entry >> s->csize_shift) &
-                           s->csize_mask) + 1;
-            qcow2_free_clusters(bs,
-                (l2_entry & s->cluster_offset_mask) & ~511,
-                nb_csectors * 512, type);
+            int64_t offset =3D (l2_entry & s->cluster_offset_mask)
+                & QCOW2_COMPRESSED_SECTOR_MASK;
+            int size =3D QCOW2_COMPRESSED_SECTOR_SIZE *
+                (((l2_entry >> s->csize_shift) & s->csize_mask) + 1);
+            qcow2_free_clusters(bs, offset, size, type);
         }
         break;
     case QCOW2_CLUSTER_NORMAL:
@@ -1317,9 +1316,12 @@ int qcow2_update_snapshot_refcount(BlockDriverStat=
e *bs,
                         nb_csectors =3D ((entry >> s->csize_shift) &
                                        s->csize_mask) + 1;
                         if (addend !=3D 0) {
+                            uint64_t coffset =3D (entry & s->cluster_off=
set_mask)
+                                & QCOW2_COMPRESSED_SECTOR_MASK;
                             ret =3D update_refcount(
-                                bs, (entry & s->cluster_offset_mask) & ~=
511,
-                                nb_csectors * 512, abs(addend), addend <=
 0,
+                                bs, coffset,
+                                nb_csectors * QCOW2_COMPRESSED_SECTOR_SI=
ZE,
+                                abs(addend), addend < 0,
                                 QCOW2_DISCARD_SNAPSHOT);
                             if (ret < 0) {
                                 goto fail;
@@ -1635,9 +1637,10 @@ static int check_refcounts_l2(BlockDriverState *bs=
, BdrvCheckResult *res,
             nb_csectors =3D ((l2_entry >> s->csize_shift) &
                            s->csize_mask) + 1;
             l2_entry &=3D s->cluster_offset_mask;
-            ret =3D qcow2_inc_refcounts_imrt(bs, res,
-                                           refcount_table, refcount_tabl=
e_size,
-                                           l2_entry & ~511, nb_csectors =
* 512);
+            ret =3D qcow2_inc_refcounts_imrt(
+                bs, res, refcount_table, refcount_table_size,
+                l2_entry & QCOW2_COMPRESSED_SECTOR_MASK,
+                nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE);
             if (ret < 0) {
                 goto fail;
             }
diff --git a/block/qcow2.c b/block/qcow2.c
index 8e024007db..d39882785d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4187,7 +4187,8 @@ qcow2_co_preadv_compressed(BlockDriverState *bs,
=20
     coffset =3D file_cluster_offset & s->cluster_offset_mask;
     nb_csectors =3D ((file_cluster_offset >> s->csize_shift) & s->csize_=
mask) + 1;
-    csize =3D nb_csectors * 512 - (coffset & 511);
+    csize =3D nb_csectors * QCOW2_COMPRESSED_SECTOR_SIZE -
+        (coffset & ~QCOW2_COMPRESSED_SECTOR_MASK);
=20
     buf =3D g_try_malloc(csize);
     if (!buf) {
--=20
2.20.1


