Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB3C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 17:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEAE20880
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 17:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI0pwoxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEAE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hz2ub-0006HW-M6
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 13:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1hz2tx-0005ni-VB
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 13:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1hz2tw-0008Dd-Ef
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 13:54:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1hz2tr-0008BN-OU; Sat, 17 Aug 2019 13:54:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id z11so4609254wrt.4;
 Sat, 17 Aug 2019 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IXUzcvfQJAG55Yt7JL4AzspwSYc7nyIKyLhl4baOQXA=;
 b=TI0pwoxA3f1mIwKWHAKuCpafMd0ZM8z/Cv5lWMx5i0B1150NREG46A/Hl8uP8GACjY
 nAw5j8q84o6C58bhaRuaCYtxnnAELK0zWT8LYuggLfuAWE+Zq7nEPG1iHLv8q1YC/kVq
 fGDHTjpzSBQfy872RMqjOLFH1+n7b9pakJCwfyYQkM2Uqf801hva1Y9qhN2WJj+ZOwex
 iZmuJMTpFeD/37lF0PiNqrXLKZJhw5SEUywgghfMLouVOLtFm7m9YvJ+t0btaDZELYUR
 blpayeZMKCeOQryODVQiYxF4NLJGOgX4Pf2avYDRmEPbgcwxDjofaWjaERCnnuWaGGJG
 XlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IXUzcvfQJAG55Yt7JL4AzspwSYc7nyIKyLhl4baOQXA=;
 b=pvffyT5lhIEurKeXHIrTB3GC9rQefli9W+PsVuopW9k2/VIwKnWnIBUBplVstyuAT7
 DethmcDrbdF60q+WO7J5/Jr40E3DBfZVXNOsgXJ9YJ+PycisovdTNjjUW1BNB4qWiUAM
 LCW3ijhFFAFrAW7Xz+CezYmW+UtZmru1PtSVZFZ1oWqV30HJfmAgNCvozxN8BFYmCGxz
 sh03y3rJW4dm5zfgpkQb4LaECpdMb6XWLL22csljFqglNSd1bKX2nEV4+wx583NreCms
 SN8ewc8a4GaiRT5UP5Nw01qJm93W4/x24d3YM6iMsh2I8ciLnXauNvAtubYkiglVTZ/u
 u0Xg==
X-Gm-Message-State: APjAAAUVFvaLq7PHqTuml7sGkrw26uuBi8lX3F4tmtlnWhnYI8CrVvnA
 wkKAo7XDHc48x8IUeSMha1jtX25gs40AbQ==
X-Google-Smtp-Source: APXvYqyDyK1+4chPY/x+cxOurgpvnia5F5GYOCbR5CeNd4FiMHPsAiuUF8Y3SfNd70kaPaKets3d/w==
X-Received: by 2002:a5d:63d0:: with SMTP id c16mr17347093wrw.22.1566064437825; 
 Sat, 17 Aug 2019 10:53:57 -0700 (PDT)
Received: from sparse-local.redhat.com (93-173-46-43.bb.netvision.net.il.
 [93.173.46.43])
 by smtp.gmail.com with ESMTPSA id f70sm15007759wme.22.2019.08.17.10.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2019 10:53:57 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-block@nongnu.org
Date: Sat, 17 Aug 2019 20:53:46 +0300
Message-Id: <20190817175346.12518-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH] block: Use QEMU_IS_ALIGNED instead of
 reinventing it
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace instances of:

    (n & (BDRV_SECTOR_SIZE - 1)) == 0)

With:

    QEMU_IS_ALIGNED(n, BDRV_SECTOR_SIZE)

Which reveals the intent of the code better, and makes it easier to
locate the code checking alignment.

QEMU_IS_ALIGNED is implemented using %, which may be less efficient but
it is used only in assert() except one instance, so it should not
matter.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/bochs.c | 4 ++--
 block/cloop.c | 4 ++--
 block/dmg.c   | 4 ++--
 block/io.c    | 8 ++++----
 block/qcow2.c | 4 ++--
 block/vvfat.c | 8 ++++----
 qemu-img.c    | 2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

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
diff --git a/block/qcow2.c b/block/qcow2.c
index 59cff1d4cb..41cab70e1d 100644
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
index c920e3564c..ca3af0c549 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2138,7 +2138,7 @@ static int img_convert(int argc, char **argv)
             int64_t sval;
 
             sval = cvtnum(optarg);
-            if (sval < 0 || sval & (BDRV_SECTOR_SIZE - 1) ||
+            if (sval < 0 || !QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
                 sval / BDRV_SECTOR_SIZE > MAX_BUF_SECTORS) {
                 error_report("Invalid buffer size for sparse output specified. "
                     "Valid sizes are multiples of %llu up to %llu. Select "
-- 
2.20.1


