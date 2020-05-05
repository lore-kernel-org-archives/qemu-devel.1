Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD398C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775F42078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4odJrJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775F42078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxKd-0003tC-JD
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAK-0001zY-3p
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAI-0001IP-UV
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPVPkTBT7gtmChDFl5iKp++k8KNrrXiv+H5bePQX/1k=;
 b=N4odJrJaeQTWNJYjiua5Uqh2YQQz25Liv3HMRguYE0kTLG39sJ7lEOa98xO3d1tnUolFqh
 DkMRX2BImFksvaH1RviPqIbJT1Y/zIOmxYDhshretEBFAeRfg9TVYxXDoNllYs1YF9gdU+
 IAWsnmei2vphcKWu51vcsejUSZFowas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405--3Hf_VyIP9aVqi5HTSP8nQ-1; Tue, 05 May 2020 08:59:09 -0400
X-MC-Unique: -3Hf_VyIP9aVqi5HTSP8nQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5944835B43;
 Tue,  5 May 2020 12:59:08 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7667E1002387;
 Tue,  5 May 2020 12:59:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 18/24] block: Comment cleanups
Date: Tue,  5 May 2020 14:58:20 +0200
Message-Id: <20200505125826.1001451-19-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

It's been a while since we got rid of the sector-based bdrv_read and
bdrv_write (commit 2e11d756); let's finish the job on a few remaining
comments.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200428213807.776655-1-eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c             |  3 ++-
 block/qcow2-refcount.c |  2 +-
 block/vvfat.c          | 10 +++++-----
 tests/qemu-iotests/001 |  2 +-
 tests/qemu-iotests/052 |  2 +-
 tests/qemu-iotests/134 |  2 +-
 tests/qemu-iotests/188 |  2 +-
 7 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/io.c b/block/io.c
index a4f9714230..7d30e61edc 100644
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
=20
+/* return < 0 if error. See bdrv_pwrite() for the return codes */
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index d9650b9b6c..0457a6060d 100644
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
index ab800c4887..6d5c090dec 100644
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
=20
-    /* copy FAT (with bdrv_read) */
+    /* copy FAT (with bdrv_pread) */
     memcpy(s->fat.pointer, s->fat2, 0x200 * s->sectors_per_fat);
=20
-    /* recurse direntries from root (using bs->bdrv_read) */
+    /* recurse direntries from root (using bs->bdrv_pread) */
     ret =3D commit_direntries(s, 0, -1);
     if (ret) {
         fprintf(stderr, "Fatal: error while committing (%d)\n", ret);
diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index d87a535c33..696726e45f 100755
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
index 45a140910d..8d5c10601f 100755
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
index 5f0fb86211..5162d21662 100755
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
index afca44df54..09b9b6083a 100755
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


