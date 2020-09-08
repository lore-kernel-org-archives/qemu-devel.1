Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46D62067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg55n84S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46D62067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFijd-0007jP-Rv
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigf-0002A0-Fh; Tue, 08 Sep 2020 14:49:50 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:40690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigX-0002bQ-QV; Tue, 08 Sep 2020 14:49:48 -0400
Received: by mail-pg1-x533.google.com with SMTP id j34so187403pgi.7;
 Tue, 08 Sep 2020 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bscWSrwzBlA91ho91MKRFqbKOrFCfnhQG9RPGa7f72A=;
 b=mg55n84SAuKUqEgxRs2ybo3Z0b/hUrx2HgRvwfnkc+FgJNWORXiATFd9mj4CAQM2jQ
 ymSiU0RJslLG7fr/I8p4A+mkcCdS76yhGnK3xb9UvPJ+0JEt2YaBlUrUMzFMKaQllJ53
 jqC9oADnMiV55r8hals21d3IzEncGDcJUqTuBFSfJwF+Wc00nrK93FBzjVsW8lM3LfRp
 Z+/f5ifl8HeoqIb1nTXbwnlrhDWKJ1Y6cLPb17B4h2sgeAe7kOAI36l2goh6DuWy4bfb
 EA75zJfS5x+P6+FXE8l57oio0aFaclDj/hDoKcLs09paCEyTXdw2G/XFxSlqgCR0SjAe
 dLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bscWSrwzBlA91ho91MKRFqbKOrFCfnhQG9RPGa7f72A=;
 b=VB2d9jRBNSJZeUShthSNP+nwtPhBpFtJL80VYuITehk2kCE8stU7z2gWndLLaHl4X2
 jrM6yBO8RAmuPlqjYv+uqQxpwdTyK9KIiIKBgwDKniqQ0bMxg80ZhL1dQhDVRvZIqPxN
 etuQlOa5eLfwr8YP24KskVnbYUoM4add0vViLKEjBx32yFXGAxN81AmtHCCvgfObKNSL
 YZdO6voI8DfR8LPP3GPBPnOOcLI6EGCIfD8bjQtBm//ZtmkoWABkajFrkZCL1+mgy8ru
 mdQZ+kJSakxL0qBwPP47fcIAmEvr1P80auGJ3CVA45d/oHnJ0a6OYyLP+7r8bHVSbdAZ
 W3JQ==
X-Gm-Message-State: AOAM530KAgnWeoHrUdlplgOUjOMMxbT0+OTcid9cOm/LB54DH2H8QT4k
 rw9wkL5eaK+3f8o4QGNDpvVEZm++fVckoQju
X-Google-Smtp-Source: ABdhPJyv80W/UrcQFzActTe/j+LlUlvyEe3yPjDQE3x6n9pb1hVoaSXlFbAVGIExzfKxroOmIQqSMQ==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr85064pls.48.1599590978817; 
 Tue, 08 Sep 2020 11:49:38 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:49:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] block: Fixes nfs on msys2/mingw
Date: Wed,  9 Sep 2020 02:49:03 +0800
Message-Id: <20200908184918.1085-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x533.google.com
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
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
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
2.28.0.windows.1


