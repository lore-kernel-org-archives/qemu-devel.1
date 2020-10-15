Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4E6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5293B2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ1aDZZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5293B2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9id-0006Nh-CR
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9dP-0002Wj-9f; Thu, 15 Oct 2020 16:13:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9dN-0001tl-IE; Thu, 15 Oct 2020 16:13:58 -0400
Received: by mail-pl1-x642.google.com with SMTP id d23so2219916pll.7;
 Thu, 15 Oct 2020 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wF+RcJqzfCr+BV1mB/A5rZx8x6O9otAFA5Q++rjKL+g=;
 b=jZ1aDZZYD84BXSo1DU71rum+u8oI/WJKl88cANj4QxKTh0fS41L1tZxu9wO39JzoUt
 ecAISymJgk9TEOyX09Km7oiI6rXDewyujQGCJvh950OP+17ViGvE1xJvZ8Q3sMRXtiHM
 aYg4ZbwNxK+8q8HVgaYl/RWi/7VhY2NI3pCjOE/CAo92bGCvxj/273wEdHH4oYX1jbR7
 KCiM3xo8HUcU0yQs8PsyEm9n8bseLXm5bJM16F6rN2gGvUkhl7eixbse7K6IZsVE3h5H
 PoXCxmQO5J+A3PLKw3N4N/jHnqCfKQv1V3IaC2ZtVVA4Y04/0bFGj4yt6Ec+Lt6aiEmC
 3F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wF+RcJqzfCr+BV1mB/A5rZx8x6O9otAFA5Q++rjKL+g=;
 b=SSZHCejZgNZigbmKKcyhFEzZxSwjbQiSprB15IQWBIOOI6drXdq0Z7zLprKMzVFNT1
 nnX26zFIzrkmsPxSjGFuxFBBMm69hkDWRIhl/DHZaLf+F8CdlG29/63uZ+MEXeUI/1Ti
 XBSWuF01abM2CuoDrOMr+5GIlLqoTt2dbEbNfTpVNhtoHsItNhlZobdMlOrZZGx3i2h2
 8Y4Fw+bp/gmluEbFOmqsmlZMXGV0YGUsMKlcR0ZQwcEO/3FV77Hje+ef1OkKg4dVnmIk
 3xRL/1Y2Fei0ZeYoGL5aMBPzlEJSRVfaBata+Agm8HOCXnGl4fNLds7cgx8meYM62hAl
 n+Nw==
X-Gm-Message-State: AOAM531i5jx7/+8Qd9/w6TSFJAMcRNZCrJuchpJnBknxNHkjLVE3oiOn
 Dgkuad/jrwWwdJEOzhfKyq8zaUyLB9Qhzrth
X-Google-Smtp-Source: ABdhPJy4ShsPLizukGG1vwRprrxFfW2uFI6CFxux/FiCOC8H8wLe18xcgzjy/ZPJMrUiYyRrN6FEZw==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr431480pjg.60.1602792834915; 
 Thu, 15 Oct 2020 13:13:54 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id s20sm89922pfc.201.2020.10.15.13.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 13:13:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] block: Fixes nfs compiling error on msys2/mingw
Date: Fri, 16 Oct 2020 04:13:34 +0800
Message-Id: <20201015201335.357-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015201335.357-1-luoyonggang@gmail.com>
References: <20201015201335.357-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
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

On msys2/mingw, there is no st_blocks in struct _stat64 yet, we disable the usage of it
on msys2/mingw, and create a typedef long long blkcnt_t; for further implementation

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 block/nfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/nfs.c b/block/nfs.c
index f86e660374..cf8795fb49 100644
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
@@ -51,6 +53,10 @@
 #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
 #define QEMU_NFS_MAX_DEBUG_LEVEL 2
 
+#if defined(_WIN32)
+typedef long long blkcnt_t;
+#endif
+
 typedef struct NFSClient {
     struct nfs_context *context;
     struct nfsfh *fh;
@@ -545,7 +551,9 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
     }
 
     ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
+#if !defined(_WIN32)
     client->st_blocks = st.st_blocks;
+#endif
     client->has_zero_init = S_ISREG(st.st_mode);
     *strp = '/';
     goto out;
@@ -706,6 +714,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
     return client->has_zero_init;
 }
 
+#if !defined(_WIN32)
 /* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
@@ -748,6 +757,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
 
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
+#endif
 
 static int coroutine_fn
 nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
@@ -800,7 +810,9 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                        nfs_get_error(client->context));
             return ret;
         }
+#if !defined(_WIN32)
         client->st_blocks = st.st_blocks;
+#endif
     }
 
     return 0;
@@ -869,7 +881,10 @@ static BlockDriver bdrv_nfs = {
     .create_opts                    = &nfs_create_opts,
 
     .bdrv_has_zero_init             = nfs_has_zero_init,
+/* libnfs does not provide the allocated filesize of a file on win32. */
+#if !defined(_WIN32)
     .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
+#endif
     .bdrv_co_truncate               = nfs_file_co_truncate,
 
     .bdrv_file_open                 = nfs_file_open,
-- 
2.28.0.windows.1


