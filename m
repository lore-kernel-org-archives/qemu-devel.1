Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4610EC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC175214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoJ5h7HU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC175214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEIL-0004jZ-Su
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEGW-0002mP-9W; Sat, 12 Sep 2020 18:45:04 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:44068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHEGT-0004DD-CX; Sat, 12 Sep 2020 18:45:03 -0400
Received: by mail-pg1-x532.google.com with SMTP id 7so8750557pgm.11;
 Sat, 12 Sep 2020 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+TzCV5YsUfMO+qMrCqWTpCCJj1Kw1e96uTxGZjpZ7yY=;
 b=RoJ5h7HUzaS1ue8F5TpGaSZjXJlG7R5qzmAI0xdP9qzpiU7KZlbsUGD4wO7J17iKv8
 Djf5jp6RVYcFPPFGzpnqw7Hl9XigO2vcSUCk/rpzpIIcIdZlyOJhXXpRgpWu/NhEJyTo
 D8Nuqjb4r8w8htufpMWARKO1olKH6/yYzLogI+EvyQsJ1AtEZvdZdHVp81/4stOml193
 1HZcvuo7wSYbmo12h12DoW4y1fWmXX8FMdj1tiRczgwkYV98PI9hee1QfIexiKiSZTYg
 vzQebt+b7q7Bz7riqYIkMOeoqceFWvSKEijmd/gTegSgzQvw2vejpwMdUlwjOyai3Vcn
 +13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+TzCV5YsUfMO+qMrCqWTpCCJj1Kw1e96uTxGZjpZ7yY=;
 b=HY1osVByaGoGf593bFN+uNkpjfsv9dBhNUHpgjzm5AX5S0XZVr6qyvYop3Gb/cXD2Y
 FcUPcByDKjXvNrI2x5Tk9SDzUVJ9K8yR401BRWlXxkjWPsLMbtz9DAA88vGlFtiNC3XE
 zrYn3ERalnuIIs4cJGNbg3r6EOgXRqXUmiSDB4rIxRV+fXG1vmd2tw4VkMo/+DqjNc7m
 Kpw0D3RgVmYjPj/J0FOkasx12vQGZknpJ6xHBgi0qbV89HVRZWaTsiaigxs8AAP+Q1G0
 jNR/GdaV37noVIC/kkhkrx6TaXEKduSN46PbrbFInEeJk3RO8Qt1ispgN2ZKfB0/aQNP
 nzCQ==
X-Gm-Message-State: AOAM533Ai2UDP6Gaf5+joDuANRIPIe5MqaFKtlIZweugC4ZsWixrIahl
 qoc26e0/sdGGjgtp6zXJLXi3kYIv2IF0y+wgHMM=
X-Google-Smtp-Source: ABdhPJwvrozLNINoV9oSQuHNXi219Srb/88H0vGjEL0W/34/+xp7eKxZwz5zChCpIXFFzzLx2W0HBg==
X-Received: by 2002:a63:d157:: with SMTP id c23mr6134640pgj.281.1599950698152; 
 Sat, 12 Sep 2020 15:44:58 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t10sm4639266pgp.15.2020.09.12.15.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 15:44:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 02/27] block: Fixes nfs compiling error on msys2/mingw
Date: Sun, 13 Sep 2020 06:44:06 +0800
Message-Id: <20200912224431.1428-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200912224431.1428-1-luoyonggang@gmail.com>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x532.google.com
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
 block/nfs.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 61a249a9fc..98b48f363b 100644
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
@@ -58,7 +66,9 @@ typedef struct NFSClient {
     bool has_zero_init;
     AioContext *aio_context;
     QemuMutex mutex;
+#if !defined (_WIN32)
     blkcnt_t st_blocks;
+#endif
     bool cache_used;
     NFSServer *server;
     char *path;
@@ -70,7 +80,7 @@ typedef struct NFSRPC {
     int ret;
     int complete;
     QEMUIOVector *iov;
-    struct stat *st;
+    struct nfs_stat *st;
     Coroutine *co;
     NFSClient *client;
 } NFSRPC;
@@ -419,7 +429,7 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
                                int flags, int open_flags, Error **errp)
 {
     int64_t ret = -EINVAL;
-    struct stat st;
+    struct nfs_stat st;
     char *file = NULL, *strp = NULL;
 
     qemu_mutex_init(&client->mutex);
@@ -545,7 +555,9 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
     }
 
     ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
+#if !defined (_WIN32)
     client->st_blocks = st.st_blocks;
+#endif
     client->has_zero_init = S_ISREG(st.st_mode);
     *strp = '/';
     goto out;
@@ -706,6 +718,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
     return client->has_zero_init;
 }
 
+#if !defined (_WIN32)
 /* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
@@ -729,7 +742,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task = {0};
-    struct stat st;
+    struct nfs_stat st;
 
     if (bdrv_is_read_only(bs) &&
         !(bs->open_flags & BDRV_O_NOCACHE)) {
@@ -748,6 +761,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
 
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
+#endif
 
 static int coroutine_fn
 nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
@@ -778,7 +792,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                               BlockReopenQueue *queue, Error **errp)
 {
     NFSClient *client = state->bs->opaque;
-    struct stat st;
+    struct nfs_stat st;
     int ret = 0;
 
     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
@@ -800,7 +814,9 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                        nfs_get_error(client->context));
             return ret;
         }
+#if !defined (_WIN32)
         client->st_blocks = st.st_blocks;
+#endif
     }
 
     return 0;
@@ -869,7 +885,9 @@ static BlockDriver bdrv_nfs = {
     .create_opts                    = &nfs_create_opts,
 
     .bdrv_has_zero_init             = nfs_has_zero_init,
+#if !defined (_WIN32)
     .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
+#endif
     .bdrv_co_truncate               = nfs_file_co_truncate,
 
     .bdrv_file_open                 = nfs_file_open,
-- 
2.28.0.windows.1


