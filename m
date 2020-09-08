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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150E5C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A033220768
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSxGgF7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A033220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjcT-0006FH-NA
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjbg-0004gX-W7; Tue, 08 Sep 2020 15:48:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:55184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjbf-0002TX-71; Tue, 08 Sep 2020 15:48:44 -0400
Received: by mail-pj1-x1033.google.com with SMTP id mm21so133829pjb.4;
 Tue, 08 Sep 2020 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SUvRS89sUzi/CKcVKuZSUX6fRCoMdjCQPEKiAKbAayo=;
 b=VSxGgF7/SU1Xyv3X/12Zg9q+vhs4FXaZefRHPubT4BGPD9wek0Ewa5zzy32qKRQqEV
 A/sfOLl7THobm2uwY+qiRlQbbss7bnx0bJ7XTWZt0isT9mCekpwvDpjnI6IQ7kEPg76v
 OGjFF3q0s4GPLf431mlAMW84X6Jbo4ub8yy+WHReTNkudEAiZa7h/9rVM1NnxWzrsxC0
 ljPv6hUnTgIq84hVZSwJJclLfjp3VJOV/udHwKCI2zrb8XyNbJPvOvABBbcQjjcvpT1R
 rB4OJ87n7JUa3J051Xj/Smw4Cg41aQq9dcbNLZqvoBv6rLt3GJsUsB21laLgtnjJE9C/
 GOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SUvRS89sUzi/CKcVKuZSUX6fRCoMdjCQPEKiAKbAayo=;
 b=AhTjzv3QdKYOOBWW02npAkyvF46XyQgReOr4AwTCDzY5WM1ptkoLrG1aNijQDxywdu
 zsLR2gq5j7vm7mz+WsWF3a5sW0W8jmPC+T5nahOda9X9kLTgz09Xfat2KnLciHc0pBIh
 rVO/RayT3xVe9CiNWtp2s6H5fJeetegL6MAYEDpEkl2q/1PV06KNRqplpO5Rd+gLRINx
 W/kW08LR1jQNnR7C3piAMz2oBbh3M+Bss26NhqzkHjv5qWf2d46W3CGKZhFdP8Mk9wps
 RY6ze0+tBE6uvxiO0PIgRV5Vf8C8BJkKnlL6sDJwtmagqAXzdWQxXlV3V9Du7LO7OroM
 vTlw==
X-Gm-Message-State: AOAM533SFcQiwju8Vqqzbjumtg0XY+yCqpdRnhjGl0Sjr3XJSBfOKxWp
 7MHBO4l7Y1YuXZ6lXvOP+qJ2jf8UgMbmOP7+
X-Google-Smtp-Source: ABdhPJwVR8f1t9x1BNKS3aaf6N2nwCBCrNPVmpANlyqirlC8oBSJ/9MJt1Zpil3sF4DFHzbMHYZRRg==
X-Received: by 2002:a17:90b:46c4:: with SMTP id
 jx4mr414979pjb.190.1599594521049; 
 Tue, 08 Sep 2020 12:48:41 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:48:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/16] block: Fixes nfs compiling error on msys2/mingw
Date: Wed,  9 Sep 2020 03:48:05 +0800
Message-Id: <20200908194820.702-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1033.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
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


