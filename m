Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5229C2BC11
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07ED20758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AocT/wK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07ED20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDXYg-0000b7-Nc
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDXXj-0008T8-GV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:31:35 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:53955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDXXh-0003O3-LU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:31:35 -0400
Received: by mail-pj1-x1035.google.com with SMTP id k15so215828pji.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hNepObtXPm4N1O5edBmKFbP2Y+PrGFrGNmL2JCj+pQg=;
 b=AocT/wK+7WaECxCR/4Clls8+GvCfyVl5N4oH3S6ONdKDCMexFCua44Mqu7NMjvPryY
 6dXDnaAOfN26uUoG23LqKgUepo2PjLcYj+p12X05JAuNvB38EiClaNeep73+QUWIE05l
 gkPGja1XBOelvR3rBzUAU++CQHukz915cbv4W15ZI+lF1m6g7Fab29nHDRVn9GMB8IHK
 CFA1WzwO7ul9Ag+8EDnnVx9PoLyTakFABgsABPnKQp6l9rs0M0J8afED175q77jS9Hlg
 OPJ3hYjzOLlGfnRZ8HZ7aFLlyuiC6/zONF0MiePviIgGYLJZQU/8EYexPxbSV4opPf+i
 GLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hNepObtXPm4N1O5edBmKFbP2Y+PrGFrGNmL2JCj+pQg=;
 b=d8JXQMEYoq1rHxPs+jgEZ7Rqj/W1cgyJglP8/Pd3bJR8Lu3jmrK5cfxpLCfqkJ6ChF
 YKrZ2Rn5UUnld6L1n/mH18eG0KoVOUECl+ATLfWsK+hmuhAhDlx/J+NV4zNbMbC/zNQd
 tFhNBcLn8e7kGHgb3CQlrSg+o4VyRhkRR3PA66Eq4u+YEDeBHAXcGIkAULr/hrugjLs6
 pBJeWaDcI8/sPdyq0lyXSrbKICxwaUHZco9C9WEaA8eFJRKYJnT9sEQLZFzhuRvu2HfG
 OFqJyN942M2FXQL/IVZgumbdfIX0MhkbzpDDY6IOx6PqzlKF9AJd5Y+0a14vrFrBFZJz
 c/PQ==
X-Gm-Message-State: AOAM530b7t+FG/C/fpRJqxoyFC1jtg7HmmUivKq5KUE1zJSREwWqtI/r
 4KaCj866DGpfd29ACse6m+ccoaybRCQ=
X-Google-Smtp-Source: ABdhPJyxKyCX1DJjkol2tnyh6rON4lh+sCt2eM0uuuY0Ue1aapLBzlluGwyMcvFOYb2oibq2BnxmCg==
X-Received: by 2002:a17:902:fe94:: with SMTP id
 x20mr2986260plm.117.1599071491473; 
 Wed, 02 Sep 2020 11:31:31 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id q5sm205944pfg.89.2020.09.02.11.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 11:31:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: Fixes nfs on msys2/mingw
Date: Thu,  3 Sep 2020 02:31:13 +0800
Message-Id: <20200902183113.708-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1035.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 block/nfs.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 61a249a9fc..34b2cd5708 100644
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
@@ -51,6 +53,12 @@
 #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
 #define QEMU_NFS_MAX_DEBUG_LEVEL 2
 
+#if defined (_WIN32)
+#define nfs_stat __stat64
+#else
+#define nfs_stat stat
+#endif
+
 typedef struct NFSClient {
     struct nfs_context *context;
     struct nfsfh *fh;
@@ -58,7 +66,7 @@ typedef struct NFSClient {
     bool has_zero_init;
     AioContext *aio_context;
     QemuMutex mutex;
-    blkcnt_t st_blocks;
+    int64_t st_size;
     bool cache_used;
     NFSServer *server;
     char *path;
@@ -70,7 +78,7 @@ typedef struct NFSRPC {
     int ret;
     int complete;
     QEMUIOVector *iov;
-    struct stat *st;
+    struct nfs_stat *st;
     Coroutine *co;
     NFSClient *client;
 } NFSRPC;
@@ -419,7 +427,7 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
                                int flags, int open_flags, Error **errp)
 {
     int64_t ret = -EINVAL;
-    struct stat st;
+    struct nfs_stat st;
     char *file = NULL, *strp = NULL;
 
     qemu_mutex_init(&client->mutex);
@@ -545,7 +553,7 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
     }
 
     ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
-    client->st_blocks = st.st_blocks;
+    client->st_size = st.st_size;
     client->has_zero_init = S_ISREG(st.st_mode);
     *strp = '/';
     goto out;
@@ -729,11 +737,11 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task = {0};
-    struct stat st;
+    struct nfs_stat st;
 
     if (bdrv_is_read_only(bs) &&
         !(bs->open_flags & BDRV_O_NOCACHE)) {
-        return client->st_blocks * 512;
+        return client->st_size;
     }
 
     task.bs = bs;
@@ -746,7 +754,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
     nfs_set_events(client);
     BDRV_POLL_WHILE(bs, !task.complete);
 
-    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
+    return (task.ret < 0 ? task.ret : st.st_size);
 }
 
 static int coroutine_fn
@@ -778,7 +786,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                               BlockReopenQueue *queue, Error **errp)
 {
     NFSClient *client = state->bs->opaque;
-    struct stat st;
+    struct nfs_stat st;
     int ret = 0;
 
     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
@@ -800,7 +808,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                        nfs_get_error(client->context));
             return ret;
         }
-        client->st_blocks = st.st_blocks;
+        client->st_size = st.st_size;
     }
 
     return 0;
-- 
2.27.0.windows.1


