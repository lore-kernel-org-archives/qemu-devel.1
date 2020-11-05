Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9309C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA1C2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSCgMjql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA1C2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeYq-0006kj-VP
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kaeQY-00052d-UH; Thu, 05 Nov 2020 07:31:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kaeQW-0005WO-7o; Thu, 05 Nov 2020 07:31:42 -0500
Received: by mail-pg1-x542.google.com with SMTP id x13so1354161pgp.7;
 Thu, 05 Nov 2020 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VWn79h0iDOJAfDYC4SZNlTPWm6c9gDOOKAAB4nJHU8E=;
 b=aSCgMjqlVQ5RzqzXx1KVV5hq0J1wnloMZW09FGyewCYLl5WmOV7KEGLueVskyaSQX5
 NoPZTgWdskWCEmt47lidOPdl4yFnbwWqhbRe3McImsET8BM3M21TTv8RpKnDPUMln5Xf
 U+f4zMOGi5wLG0FdtvhP+Q6O4FKe51gDn0nFQcqmmHaaDGx4zCOnoijMlXcoPeSw4Gjv
 FzARsjMKA2ZN4Y0+YeBoPSNngCV7mkrIwXlX5CfuFaQ0u2LiD2Rrvzz5TNGu2/PzX6Fi
 DLMWVtpvr3lWcUrbALeT4MzrtVL40p0js5GeDmQT5DpLAUaeyz1hhChHdH4h8D9UQjWf
 Z3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VWn79h0iDOJAfDYC4SZNlTPWm6c9gDOOKAAB4nJHU8E=;
 b=gXb0Z0un6WzZ+K+jCAA8RjcSNfKOwZ96mpUXwyfsVyM4cOv2aJzjGnd3jz9SFxGmdo
 9cvICCzBMd0+uTS/8kqq7Gw4daUi2Yz89uW3kAeJHvdRJwK5/ccDwtNk+TPASXuemHgB
 fKo4X88GVusbbXh/730HzJIhodHiorc1S07EDdZaEc7+wydgvr+m8GJzVA4VVvOBqNSM
 2inOQ2yfogbaqjjd1JiRPN57QzoitGkD6gQwpvZkoDhZMBJXIenpEhkuyLbpsBp0EIoj
 RxcOvjb2rPtLozrEY3lrH639Gtm0/xjHKnZ/99bulU7+/ngcL6rvXA2JkqSMF7dj+6Nt
 kLGQ==
X-Gm-Message-State: AOAM533duCGle4hmqizg9fNAb7GqpBjIJbY3jKyquiXgUPk7OSjFGJfQ
 jF7uN4cnh/xx9h91kMQp2BQtepOJnATM8U2T
X-Google-Smtp-Source: ABdhPJz5DWOCWKeYIZvNxECCjlswkEPmZ60z0saezoCcJo8Tw0MSHfWuSGBoZZwcHHZfSdF9Upk3Cw==
X-Received: by 2002:aa7:9e5b:0:b029:18a:8d88:12cb with SMTP id
 z27-20020aa79e5b0000b029018a8d8812cbmr2508465pfq.42.1604579497636; 
 Thu, 05 Nov 2020 04:31:37 -0800 (PST)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id hi10sm2987008pjb.0.2020.11.05.04.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 04:31:36 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] block: Fixes nfs compiling error on msys2/mingw
Date: Thu,  5 Nov 2020 20:31:15 +0800
Message-Id: <20201105123116.674-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201105123116.674-1-luoyonggang@gmail.com>
References: <20201105123116.674-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x542.google.com
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
 block/nfs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/nfs.c b/block/nfs.c
index f86e660374..77905f516d 100644
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
@@ -58,7 +60,7 @@ typedef struct NFSClient {
     bool has_zero_init;
     AioContext *aio_context;
     QemuMutex mutex;
-    blkcnt_t st_blocks;
+    uint64_t st_blocks;
     bool cache_used;
     NFSServer *server;
     char *path;
@@ -545,7 +547,9 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
     }
 
     ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
+#if !defined(_WIN32)
     client->st_blocks = st.st_blocks;
+#endif
     client->has_zero_init = S_ISREG(st.st_mode);
     *strp = '/';
     goto out;
@@ -706,6 +710,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
     return client->has_zero_init;
 }
 
+#if !defined(_WIN32)
 /* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
@@ -748,6 +753,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
 
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
+#endif
 
 static int coroutine_fn
 nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
@@ -800,7 +806,9 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                        nfs_get_error(client->context));
             return ret;
         }
+#if !defined(_WIN32)
         client->st_blocks = st.st_blocks;
+#endif
     }
 
     return 0;
@@ -869,7 +877,10 @@ static BlockDriver bdrv_nfs = {
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


