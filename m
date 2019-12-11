Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641E6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E01520836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKiMEdf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E01520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if34E-0006sp-MO
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tw-0005QN-RL
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tv-0003FU-Km
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:40 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if2tv-0003DM-61; Wed, 11 Dec 2019 09:23:39 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so7297080wmc.2;
 Wed, 11 Dec 2019 06:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=DDlSLM0gJZ7KaXQqepJKvC61+c7na5da89NPclbedsE=;
 b=oKiMEdf0K3rS4kJfQSAf5sHlJWePOIoEwbuFS5wrtEaA8F8+KLXiZ4Gt5ZCXOGazac
 3SaReoLWacgYVCFaEr3qm+oTMUdFE/l+NbIFk7qKx8XTnJOhEXtpIq3D1llLBKmzV99K
 IRepDLHbUH62dMk2RhzA29hDFl2bTXsQCO1ccSNdc/dLHXB03PsCmvQvUapEpFBjEYX9
 veruvGuTnHSoq/5oel4Tu05+maYkPM09mvVQHqPm6DXOEk/vE/SpQ1s+l1LCe11YvK7d
 jM+ru+ChEiyUKrN0bcn5A4ocRq2fJ3ySQQBtLPfNhVUXKMSMUMe5Omom3hnOgKEAGuIS
 nJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=DDlSLM0gJZ7KaXQqepJKvC61+c7na5da89NPclbedsE=;
 b=uS8zBjKvJVoBxsUoJ4fuggrx7PWj27+WxspVy0QJb2mPSCygBGFZXInjyFeKuglRKv
 LU3ZYA1r9mUQ2NGmSClypHXpelRxoMBXWkqWwHfnEakW3U6TSWwv/USI3rdYnmjD/vzR
 cRsB4XF64UrK3BZlALJoW5YdDe1HjMe6r4P+HBM0EPu0UsF2UjGWXvTForfnixDWjlYh
 kMOpuQ27iWljkMOgWByNE2Qx5mcnsOd6MaV6XvbFWdkMQ8RGy4YCbkhLXGMyg/dLbCQw
 hYLGI306wHiDLVP2SwB25w7tisMV3uBpDfV290ElJYJybESDaE7UkgeG24Cjeszyqw5l
 izJQ==
X-Gm-Message-State: APjAAAXJTV4ceR1ChxCsML/uZ0SK1na8RylsvfYLBLoI1t1YZvf/55o0
 nRqOKsfQj2GYdoDP7QNauL4ouvBf
X-Google-Smtp-Source: APXvYqzd1YLGsmpelVZJQnbeosTTRhrZNd8xFPZ6Z9W5lBZtYWciJR57Gt/KLX4u2UIrlmkub5FjgA==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr9239wme.133.1576074217391;
 Wed, 11 Dec 2019 06:23:37 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g23sm2503783wmk.14.2019.12.11.06.23.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:23:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: use g_test_rand_int
Date: Wed, 11 Dec 2019 15:23:27 +0100
Message-Id: <1576074210-52834-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

g_test_rand_int provides a reproducible random integer number, using a
different number seed every time but allowing reproduction using the
--seed command line option.  It is thus better suited to tests than
g_random_int or random.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/vhdx.c         | 2 +-
 block/vmdk.c         | 4 ++--
 tests/ivshmem-test.c | 2 +-
 tests/test-bitmap.c  | 8 ++++----
 tests/test-qga.c     | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index f02d261..36465d5 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1504,7 +1504,7 @@ static int vhdx_create_new_headers(BlockBackend *blk, uint64_t image_size,
     hdr = g_new0(VHDXHeader, 1);
 
     hdr->signature       = VHDX_HEADER_SIGNATURE;
-    hdr->sequence_number = g_random_int();
+    hdr->sequence_number = g_test_rand_int();
     hdr->log_version     = 0;
     hdr->version         = 1;
     hdr->log_length      = log_size;
diff --git a/block/vmdk.c b/block/vmdk.c
index 20e909d..eba96bf 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2037,7 +2037,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
         /* update CID on the first write every time the virtual disk is
          * opened */
         if (!s->cid_updated) {
-            ret = vmdk_write_cid(bs, g_random_int());
+            ret = vmdk_write_cid(bs, g_test_rand_int());
             if (ret < 0) {
                 return ret;
             }
@@ -2499,7 +2499,7 @@ static int coroutine_fn vmdk_co_do_create(int64_t size,
 
     /* generate descriptor file */
     desc = g_strdup_printf(desc_template,
-                           g_random_int(),
+                           g_test_rand_int(),
                            parent_cid,
                            BlockdevVmdkSubformat_str(subformat),
                            parent_desc_line,
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index be9aa92..ecda256 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -443,7 +443,7 @@ static gchar *mktempshm(int size, int *fd)
     while (true) {
         gchar *name;
 
-        name = g_strdup_printf("/qtest-%u-%u", getpid(), g_random_int());
+        name = g_strdup_printf("/qtest-%u-%u", getpid(), g_test_rand_int());
         *fd = shm_open(name, O_CREAT|O_RDWR|O_EXCL,
                        S_IRWXU|S_IRWXG|S_IRWXO);
         if (*fd > 0) {
diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index 087e02a..2f5b714 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -22,10 +22,10 @@ static void check_bitmap_copy_with_offset(void)
     bmap2 = bitmap_new(BMAP_SIZE);
     bmap3 = bitmap_new(BMAP_SIZE);
 
-    bmap1[0] = random();
-    bmap1[1] = random();
-    bmap1[2] = random();
-    bmap1[3] = random();
+    bmap1[0] = g_test_rand_int();
+    bmap1[1] = g_test_rand_int();
+    bmap1[2] = g_test_rand_int();
+    bmap1[3] = g_test_rand_int();
     total = BITS_PER_LONG * 4;
 
     /* Shift 115 bits into bmap2 */
diff --git a/tests/test-qga.c b/tests/test-qga.c
index 1ca49bb..d2b2435 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -143,7 +143,7 @@ static void qmp_assertion_message_error(const char     *domain,
 static void test_qga_sync_delimited(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
-    guint32 v, r = g_random_int();
+    guint32 v, r = g_test_rand_int();
     unsigned char c;
     QDict *ret;
 
@@ -186,7 +186,7 @@ static void test_qga_sync_delimited(gconstpointer fix)
 static void test_qga_sync(gconstpointer fix)
 {
     const TestFixture *fixture = fix;
-    guint32 v, r = g_random_int();
+    guint32 v, r = g_test_rand_int();
     QDict *ret;
 
     /*
-- 
1.8.3.1


