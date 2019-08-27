Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6080C3A5A4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9699B21883
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/YLMTPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9699B21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2gjc-0001bn-Jx
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 15:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2ggf-0008Me-QW
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2gge-0006Nx-Dt
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:59:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2gge-0006NX-3x; Tue, 27 Aug 2019 14:59:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id l2so210042wmg.0;
 Tue, 27 Aug 2019 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WHUo3Tga0CGNATwCAfQwI44kWXDmXDYMUfkHqnRgu3E=;
 b=b/YLMTPITid9bZP3cnOmIU6dozatrMb5vF2Rnzjz18yea61NNujUhqfJbs4zCjHJgN
 zW8qOZKm/E2bjW5ipGrRBxOC9nM0ArEClf34W9F2/06UJVk3zYWQw01CseKk1PaHYSw/
 TXlfASWG4E48h7hT32o1IBunP2ioj+p/Y3YN47OK4AlnVxjU97IAhSz4+pjfNRrqDpZ2
 NHH9eC99E6IfBE2V/kgUBaICVdkfp/HYYBNVhh1920FbYfyuxBd0fAqpLGNc+q7S9KvF
 YMy+TsP67lGCEBQrZ4h+zR+EFVeJP5N9icbNKWICY3ea0HHNAMVqdZPfAzMka9yC/bHM
 Qmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WHUo3Tga0CGNATwCAfQwI44kWXDmXDYMUfkHqnRgu3E=;
 b=op26fAtjsmrei4liob+DCOdJiWURDHqNHHbeNwpH9MZctjhrZrb3rMh02yrUjrpUht
 nXQsTAXW2xxrGFMcMeTP65CmnZDpxBEdvcjZqVu+I8PN8WOy2lCive0CHdvLY98jvxIL
 aWkwE7ghnADNz0WQOphaUvNts1vy6gSlauMSUWsh1vvrBiAEP5Pe6DxixPxwtkFU/jZH
 cahL0XgRjhGizJdIAAuNlJONTiCqv86Xlm8bALbswNFCyz6anZxv2m/hnUn+XquJh+S4
 jE7xDScVIfEIvS4GedeO0GmwmXc5mJ/qhYBgvuPyax66+JNLJ4Vh0WeOOzvQxOKlAm0v
 uu0g==
X-Gm-Message-State: APjAAAXUTG5BJyJzu3uUP22LY0Ziot1/I/s5xys4AraNagSJyA77ycB7
 VnOoLe/oNA+f/Jt4oyLWZuxRbB/O9DAiRw==
X-Google-Smtp-Source: APXvYqwTTHq+2vwLFuj9TSBLQ1uHBO+hNP4DGmDTlIdX1MOCww1P7ZXLM2T6qwcFER+m2x7QnDVEFw==
X-Received: by 2002:a1c:c018:: with SMTP id q24mr7481wmf.162.1566932359123;
 Tue, 27 Aug 2019 11:59:19 -0700 (PDT)
Received: from localhost.localdomain (109-186-142-128.bb.netvision.net.il.
 [109.186.142.128])
 by smtp.gmail.com with ESMTPSA id g26sm9926wmh.32.2019.08.27.11.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 11:59:18 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:59:12 +0300
Message-Id: <20190827185913.27427-2-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190827185913.27427-1-nsoffer@redhat.com>
References: <20190827185913.27427-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 1/2] block: Use QEMU_IS_ALIGNED
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace instances of:

    (n & (BDRV_SECTOR_SIZE - 1)) == 0

And:

   (n & ~BDRV_SECTOR_MASK) == 0

With:

    QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE)

Which reveals the intent of the code better, and makes it easier to
locate the code checking alignment.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/bochs.c         | 4 ++--
 block/cloop.c         | 4 ++--
 block/dmg.c           | 4 ++--
 block/io.c            | 8 ++++----
 block/qcow2-cluster.c | 4 ++--
 block/qcow2.c         | 4 ++--
 block/vvfat.c         | 8 ++++----
 qemu-img.c            | 2 +-
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/block/bochs.c b/block/bochs.c
index 962f18592d..32bb83b268 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -248,8 +248,8 @@ bochs_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     QEMUIOVector local_qiov;
     int ret;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
 
     qemu_iovec_init(&local_qiov, qiov->niov);
     qemu_co_mutex_lock(&s->lock);
diff --git a/block/cloop.c b/block/cloop.c
index 384c9735bb..4de94876d4 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -253,8 +253,8 @@ cloop_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     int ret, i;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
 
     qemu_co_mutex_lock(&s->lock);
 
diff --git a/block/dmg.c b/block/dmg.c
index 45f6b28f17..4a045f2b3e 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -697,8 +697,8 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     int ret, i;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
 
     qemu_co_mutex_lock(&s->lock);
 
diff --git a/block/io.c b/block/io.c
index 56bbf195bb..7508703ecd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1080,8 +1080,8 @@ static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
     sector_num = offset >> BDRV_SECTOR_BITS;
     nb_sectors = bytes >> BDRV_SECTOR_BITS;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
     assert(bytes <= BDRV_REQUEST_MAX_BYTES);
     assert(drv->bdrv_co_readv);
 
@@ -1133,8 +1133,8 @@ static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
     sector_num = offset >> BDRV_SECTOR_BITS;
     nb_sectors = bytes >> BDRV_SECTOR_BITS;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
     assert(bytes <= BDRV_REQUEST_MAX_BYTES);
 
     assert(drv->bdrv_co_writev);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cc5609e27a..f2de74690d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -470,8 +470,8 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s = bs->opaque;
-        assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
-        assert((bytes & ~BDRV_SECTOR_MASK) == 0);
+        assert(QEMU_IS_ALIGNED(offset_in_cluster, BDRV_SECTOR_SIZE));
+        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
         assert(s->crypto);
         if (qcow2_co_encrypt(bs, cluster_offset,
                              src_cluster_offset + offset_in_cluster,
diff --git a/block/qcow2.c b/block/qcow2.c
index 7c5a4859f7..e82961c9cf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2072,8 +2072,8 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             }
             if (bs->encrypted) {
                 assert(s->crypto);
-                assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-                assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+                assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+                assert(QEMU_IS_ALIGNED(cur_bytes, BDRV_SECTOR_SIZE));
                 if (qcow2_co_decrypt(bs, cluster_offset, offset,
                                      cluster_data, cur_bytes) < 0) {
                     ret = -EIO;
diff --git a/block/vvfat.c b/block/vvfat.c
index f6c28805dd..019b8f1341 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1547,8 +1547,8 @@ vvfat_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     void *buf;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
 
     buf = g_try_malloc(bytes);
     if (bytes && buf == NULL) {
@@ -3082,8 +3082,8 @@ vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     void *buf;
 
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
 
     buf = g_try_malloc(bytes);
     if (bytes && buf == NULL) {
diff --git a/qemu-img.c b/qemu-img.c
index 7daa05e51a..cff21facf0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2141,7 +2141,7 @@ static int img_convert(int argc, char **argv)
             int64_t sval;
 
             sval = cvtnum(optarg);
-            if (sval < 0 || sval & (BDRV_SECTOR_SIZE - 1) ||
+            if (sval < 0 || !QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
                 sval / BDRV_SECTOR_SIZE > MAX_BUF_SECTORS) {
                 error_report("Invalid buffer size for sparse output specified. "
                     "Valid sizes are multiples of %llu up to %llu. Select "
-- 
2.20.1


