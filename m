Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3247C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 21:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCD520730
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 21:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHOa4shr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCD520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTXxh-0002h3-Jb
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 17:40:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTXwm-0001K4-1Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 17:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTXvo-0008BS-Li
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 17:39:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51911
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTXvo-0008BH-8V
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 17:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588109899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LK75nYSRtRRZuMEp++Qb+RXUesvk1OVJFMBt4OC3ZfQ=;
 b=hHOa4shrT7PrYrVRu0RtLX1Ik8+Eb+qVTDzARGt49kkiaDEbZwuvO1HRTZAKjzER1mj4O4
 McNfhjgD/aSFIkKrnnhHq2o3W336H644MZFOOLGl8FM3GboCdLwKftLDjsv0vvhnVWpmpU
 y9WNahmNEyQrFegN0rsLKJLaqx20h+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-T8V2cAIEOOefrCaFyz1-2Q-1; Tue, 28 Apr 2020 17:38:17 -0400
X-MC-Unique: T8V2cAIEOOefrCaFyz1-2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A24F118FF663;
 Tue, 28 Apr 2020 21:38:16 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9216B1002388;
 Tue, 28 Apr 2020 21:38:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: Comment cleanups
Date: Tue, 28 Apr 2020 16:38:07 -0500
Message-Id: <20200428213807.776655-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, berto@igalia.com,
 "open list:Block I/O path" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's been a while since we got rid of the sector-based bdrv_read and
bdrv_write (commit 2e11d756); let's finish the job on a few remaining
comments.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Hmm - I started this in Nov 2018, and just barely noticed that it has
been sitting in a stale tree on my disk for a while now...

 block/io.c             |  3 ++-
 block/qcow2-refcount.c |  2 +-
 block/vvfat.c          | 10 +++++-----
 tests/qemu-iotests/001 |  2 +-
 tests/qemu-iotests/052 |  2 +-
 tests/qemu-iotests/134 |  2 +-
 tests/qemu-iotests/188 |  2 +-
 7 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/io.c b/block/io.c
index a4f971423093..7d30e61edc6c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -960,7 +960,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset=
,
  * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP=
,
  * BDRV_REQ_FUA).
  *
- * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
+ * Returns < 0 on error, 0 on success. For error codes see bdrv_pwrite().
  */
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
@@ -994,6 +994,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags f=
lags)
     }
 }

+/* return < 0 if error. See bdrv_pwrite() for the return codes */
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index d9650b9b6c50..0457a6060d11 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2660,7 +2660,7 @@ fail:
  * - 0 if writing to this offset will not affect the mentioned metadata
  * - a positive QCow2MetadataOverlap value indicating one overlapping sect=
ion
  * - a negative value (-errno) indicating an error while performing a chec=
k,
- *   e.g. when bdrv_read failed on QCOW2_OL_INACTIVE_L2
+ *   e.g. when bdrv_pread failed on QCOW2_OL_INACTIVE_L2
  */
 int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t of=
fset,
                                  int64_t size)
diff --git a/block/vvfat.c b/block/vvfat.c
index ab800c4887a2..6d5c090dec4d 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2148,7 +2148,7 @@ DLOG(checkpoint());
      * - get modified FAT
      * - compare the two FATs (TODO)
      * - get buffer for marking used clusters
-     * - recurse direntries from root (using bs->bdrv_read to make
+     * - recurse direntries from root (using bs->bdrv_pread to make
      *    sure to get the new data)
      *   - check that the FAT agrees with the size
      *   - count the number of clusters occupied by this directory and
@@ -2913,9 +2913,9 @@ static int handle_deletes(BDRVVVFATState* s)
 /*
  * synchronize mapping with new state:
  *
- * - copy FAT (with bdrv_read)
+ * - copy FAT (with bdrv_pread)
  * - mark all filenames corresponding to mappings as deleted
- * - recurse direntries from root (using bs->bdrv_read)
+ * - recurse direntries from root (using bs->bdrv_pread)
  * - delete files corresponding to mappings marked as deleted
  */
 static int do_commit(BDRVVVFATState* s)
@@ -2935,10 +2935,10 @@ static int do_commit(BDRVVVFATState* s)
         return ret;
     }

-    /* copy FAT (with bdrv_read) */
+    /* copy FAT (with bdrv_pread) */
     memcpy(s->fat.pointer, s->fat2, 0x200 * s->sectors_per_fat);

-    /* recurse direntries from root (using bs->bdrv_read) */
+    /* recurse direntries from root (using bs->bdrv_pread) */
     ret =3D commit_direntries(s, 0, -1);
     if (ret) {
         fprintf(stderr, "Fatal: error while committing (%d)\n", ret);
diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index d87a535c3391..696726e45f56 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -1,6 +1,6 @@
 #!/usr/bin/env bash
 #
-# Test simple read/write using plain bdrv_read/bdrv_write
+# Test simple read/write using plain bdrv_pread/bdrv_pwrite
 #
 # Copyright (C) 2009 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 45a140910da1..8d5c10601fe9 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -1,6 +1,6 @@
 #!/usr/bin/env bash
 #
-# Test bdrv_read/bdrv_write using BDRV_O_SNAPSHOT
+# Test bdrv_pread/bdrv_pwrite using BDRV_O_SNAPSHOT
 #
 # Copyright (C) 2013 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 5f0fb86211e3..5162d2166248 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -1,6 +1,6 @@
 #!/usr/bin/env bash
 #
-# Test encrypted read/write using plain bdrv_read/bdrv_write
+# Test encrypted read/write using plain bdrv_pread/bdrv_pwrite
 #
 # Copyright (C) 2015 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
index afca44df5427..09b9b6083ab3 100755
--- a/tests/qemu-iotests/188
+++ b/tests/qemu-iotests/188
@@ -1,6 +1,6 @@
 #!/usr/bin/env bash
 #
-# Test encrypted read/write using plain bdrv_read/bdrv_write
+# Test encrypted read/write using plain bdrv_pread/bdrv_pwrite
 #
 # Copyright (C) 2017 Red Hat, Inc.
 #
--=20
2.26.2


