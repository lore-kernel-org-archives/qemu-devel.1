Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756BCC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EE12072D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLmsSGB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EE12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS80V-0003no-2k
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7z8-0002R7-Ce; Mon, 12 Oct 2020 20:16:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7z4-0003Ms-Tn; Mon, 12 Oct 2020 20:16:10 -0400
Received: by mail-pf1-x441.google.com with SMTP id e7so6325293pfn.12;
 Mon, 12 Oct 2020 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wF+RcJqzfCr+BV1mB/A5rZx8x6O9otAFA5Q++rjKL+g=;
 b=FLmsSGB+f1iLeje6YES7GHCBDe4zBJMRhsLZCTqkLwZdUlNEiNMMN8pCKDsm/E6Pc4
 31f/YJBN6yAT/cP03WBqDsqG30BczqEqrSZaKwkqO+sM+5ybd4XQf1y7BORDq32YdTeH
 sMBh9jlDMvKWxwMcdslWdvMA3t8m4JzCjY9/ImGij88WlaW45aNoJf33KbrTV5IsIU4a
 dxHmQ/Qf2T6IRODOtA/5uq2BD2yopi0iC+zYOe47oysq5xwOQIRSGM2XSxuAISW1y5Er
 e/fsUa4ZojC4sEfvydtT8zcRo5GKXdM7CTe647vbyB9cC5oe7H/xPUHtWwOgnhLN9ffr
 6/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wF+RcJqzfCr+BV1mB/A5rZx8x6O9otAFA5Q++rjKL+g=;
 b=YSvKISwTrJPLV2WC3xY4i/kJLjKM9vgvw3h+ATwV9Cgf5NFQvKNJz0FnyyFX0CGkMd
 W2gWgSuwmXSrPSs6nSBO/Dp7P4Y3NFkPQ/QQoljNiKzx0kefj0GfG9L6h/5g+c/ui/iu
 zEY/KXWpHbxBMx3Dl+/0U3LGEYGUjyGCiRiyNhEpBbZqZ7MYQU3zwcazyXorhZXGmXHI
 6TV79qerE+3c+vwWhJLT7YKJS0YxdEvZWu5A4iAkGpOiydydJXsCvpISAiyUQGesDHk6
 RGwpONiIBoEZb4NNGarRNw3ffh5h25Tp1I3pQ7xVktT6/xKy1z6tOtX1hx7Uq2fTW75Q
 o16g==
X-Gm-Message-State: AOAM533j4Zrr2ABdwuu0DuWm8sN8Om/ZHzymFvbJTtmU5r6hQlk+MrSF
 MiOFCqZqXiFPgC/UXFDJPQe7hECizXHRyw==
X-Google-Smtp-Source: ABdhPJwh+j9F+ipeFw7Nj33Hjk9twtXlzUlvCi2RymuZRnAY12R03/UYy9K4twbxoGjf57DzAnfZ+Q==
X-Received: by 2002:a17:90b:891:: with SMTP id
 bj17mr22034519pjb.44.1602548164243; 
 Mon, 12 Oct 2020 17:16:04 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id e5sm5902961pfj.99.2020.10.12.17.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 17:16:03 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] block: Fixes nfs compiling error on msys2/mingw
Date: Tue, 13 Oct 2020 08:15:44 +0800
Message-Id: <20201013001545.1958-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201013001545.1958-1-luoyonggang@gmail.com>
References: <20201013001545.1958-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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


