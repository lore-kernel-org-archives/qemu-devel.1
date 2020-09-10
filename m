Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C48C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC3720BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo5uIaVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC3720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJso-0008Sk-8z
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJrf-0006qv-Sy; Thu, 10 Sep 2020 06:31:40 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:38368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJrd-00035T-WC; Thu, 10 Sep 2020 06:31:39 -0400
Received: by mail-pj1-x102e.google.com with SMTP id u3so2824365pjr.3;
 Thu, 10 Sep 2020 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/w7rMoPRyhKUVrpbUOdbHX/Pq1woWbXw5jpZlifmP6A=;
 b=Eo5uIaVc5wULvc31tEOFRRP79bdD60QOEN6l7pgqcNIDeOqJ2tUGGt/cYPWltX6Y4/
 ZD78DvtHbz5KPKWgXWxh1l1ZogUmGwzw7bAJ5X9+V3I2f/CDhwpFv8txQpBKkhrQpdsr
 VqwK7lSoqBFD+aFHaPcwLgcWifLPWi8boNTJo2EybTkLOCMi1jHh3NMGK7SnAiM8nj5h
 TZJWqIRJQP6w+6094qBpJgB/nsYwnaraNX6+dR82dydlWFasu1EafGYys2VWVpJN56Yd
 CONnxcF5eqlJ7OCRLpE1PFOTJk3tXw04tMAXfZpOOoQ/zSTI8pVU5oPkCDRhKFyWGGGY
 E6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/w7rMoPRyhKUVrpbUOdbHX/Pq1woWbXw5jpZlifmP6A=;
 b=HYY00x5agqE2rVE10vWJIHNAv310W+WStnGcBs6kqka8ZyHBiAsnv0BelA/ZduQ/bD
 KUO+oeVT+5E2P/ahS/qDrKOJ3GfPwtzQMNOOLr+oAPi77Ka8r5Ix7lJndoEU7fOdf8lB
 0bLp+mMW/CPq3Dg5ZEXOl42PDmb3ronp0/ulJ2HJyWgydErGvNfDdkj/f8zWxo1dgNll
 H999bmV9RRTOjR87kPfGX/mpZAaeGsTaraplVUZtzXeR3O+P7comTtHtO1qBNDB521f8
 tL6B/jvjakntejr79jZz9tZegXqerZGRamS4kujUc8t98kikdQ60T/kvI8OEPvKJmSFn
 oXJQ==
X-Gm-Message-State: AOAM531uielh3FTECUaRdHVA0WepbOZoi4JKtICMLy38N9HkpYzJuoNT
 ZPSU5HVt74QQQvD8Lef+xCHRR+ltA84+lLpJAB8=
X-Google-Smtp-Source: ABdhPJwDee9G7F6jL1wTNWSi64CepyYbA4UZFrw44YKeLjLTY38YrbM7oIpjii365c1qTNErz64y2w==
X-Received: by 2002:a17:902:ff12:: with SMTP id
 f18mr4779227plj.118.1599733895722; 
 Thu, 10 Sep 2020 03:31:35 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:31:34 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/25] block: Fixes nfs compiling error on msys2/mingw
Date: Thu, 10 Sep 2020 18:30:37 +0800
Message-Id: <20200910103059.987-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200910103059.987-1-luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These compiling errors are fixed:
../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
   27 | #include <poll.h>
      |          ^~~~~~~~
compilation terminated.

../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
   63 |     blkcnt_t st_blocks;
      |     ^~~~~~~~
../block/nfs.c: In function 'nfs_client_open':
../block/nfs.c:550:27: error: 'struct _stat64' has no member named 'st_blocks'
  550 |     client->st_blocks = st.st_blocks;
      |                           ^
../block/nfs.c: In function 'nfs_get_allocated_file_size':
../block/nfs.c:751:41: error: 'struct _stat64' has no member named 'st_blocks'
  751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
      |                                         ^
../block/nfs.c: In function 'nfs_reopen_prepare':
../block/nfs.c:805:31: error: 'struct _stat64' has no member named 'st_blocks'
  805 |         client->st_blocks = st.st_blocks;
      |                               ^
../block/nfs.c: In function 'nfs_get_allocated_file_size':
../block/nfs.c:752:1: error: control reaches end of non-void function [-Werror=return-type]
  752 | }
      | ^

On msys2/mingw, there is no st_blocks in struct _stat64, so we use consistence st_size instead.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 block/nfs.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 61a249a9fc..db6d8c2d2b 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -24,7 +24,9 @@
 
 #include "qemu/osdep.h"
 
+#if !defined(_WIN32)
 #include <poll.h>
+#endif
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -51,6 +53,13 @@
 #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
 #define QEMU_NFS_MAX_DEBUG_LEVEL 2
 
+#if defined (_WIN32)
+#define nfs_stat __stat64
+typedef long long blkcnt_t;
+#else
+#define nfs_stat stat
+#endif
+
 typedef struct NFSClient {
     struct nfs_context *context;
     struct nfsfh *fh;
@@ -70,7 +79,7 @@ typedef struct NFSRPC {
     int ret;
     int complete;
     QEMUIOVector *iov;
-    struct stat *st;
+    struct nfs_stat *st;
     Coroutine *co;
     NFSClient *client;
 } NFSRPC;
@@ -415,11 +424,20 @@ static void nfs_file_close(BlockDriverState *bs)
     nfs_client_close(client);
 }
 
+static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st)
+{
+#if defined(_WIN32)
+    return (st->st_size + 511) / 512;
+#else
+    return st->st_blocks;
+#endif
+}
+
 static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
                                int flags, int open_flags, Error **errp)
 {
     int64_t ret = -EINVAL;
-    struct stat st;
+    struct nfs_stat st;
     char *file = NULL, *strp = NULL;
 
     qemu_mutex_init(&client->mutex);
@@ -545,7 +563,7 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
     }
 
     ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
-    client->st_blocks = st.st_blocks;
+    client->st_blocks = nfs_get_st_blocks(&st);
     client->has_zero_init = S_ISREG(st.st_mode);
     *strp = '/';
     goto out;
@@ -729,7 +747,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task = {0};
-    struct stat st;
+    struct nfs_stat st;
 
     if (bdrv_is_read_only(bs) &&
         !(bs->open_flags & BDRV_O_NOCACHE)) {
@@ -746,7 +764,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
     nfs_set_events(client);
     BDRV_POLL_WHILE(bs, !task.complete);
 
-    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
+    return (task.ret < 0 ? task.ret : nfs_get_st_blocks(&st) * 512);
 }
 
 static int coroutine_fn
@@ -778,7 +796,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                               BlockReopenQueue *queue, Error **errp)
 {
     NFSClient *client = state->bs->opaque;
-    struct stat st;
+    struct nfs_stat st;
     int ret = 0;
 
     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
@@ -800,7 +818,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                        nfs_get_error(client->context));
             return ret;
         }
-        client->st_blocks = st.st_blocks;
+        client->st_blocks = nfs_get_st_blocks(&st);
     }
 
     return 0;
-- 
2.28.0.windows.1


