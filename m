Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFE0C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31E02075E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNnXPd7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31E02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAqU-0004pK-4S
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:06:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoN-0003SB-OH
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoF-0002mX-Gj
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:38 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hUAoD-0002jz-DO; Fri, 24 May 2019 10:04:35 -0400
Received: by mail-pl1-x643.google.com with SMTP id d21so4229668plr.3;
	Fri, 24 May 2019 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Bnl7EcppW2nmeABcnfX52ya1ob5IiGizIyyR9kXL2Gs=;
	b=bNnXPd7JvwWstWPX8lmMgxJrEHeWAR1s2EKh4rM9xhcIzuyrbzvzpi/nHsom79twv2
	orN87HOU+iXcgsBdp9RFN4tzu1dNGcqO1MYuB3U0V/4nUHYjclnOe7dw8eOGbpN6VceL
	XdSmrwwBa1ax3LuLgrvovFPkzCo1nPti38Sn9+0MCzsvXQdoJ+OuYY1BE44CuxyEWrkE
	Nyux5H2E0naq2crKddGkBcwFu7+HkGe8de6ICD/icxavMa7KMMdqRWl24n+P3AmZY1+u
	yUIpEVeSGfVHTiYNyogOSdZ3t62J3U0Sy7NFUzuucPpen3yo+b0BV+kJeJ34G+LvYFF/
	XiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Bnl7EcppW2nmeABcnfX52ya1ob5IiGizIyyR9kXL2Gs=;
	b=QKh84w03PWP9TmTGuPbPLERNIZeN2ZPzRnpbEtUg4MoWmNVDBaLAHxOjjHcINjKOkq
	zZfuleaV3EBuPVrcjCnkorgLis7lWf/zt5KsEePKV7c0Q7HEFucrVn8ZcyIbIDqb20sS
	ElMLx8cQKCv9JAFbGDEE+NG36MVu6OKXY2shqLaderLSDEdGDTK037KubXUXG1yAZ7I3
	6L0IiU/Stog6oArq4SZdJodJjuj6WFnf5uVq+6Ite1Hsyrj20BQMPYvCQyOsX3MDe1Nt
	vtEFGwSLvjS2aXUf3h0HSu3rpzYXtl+6bLJa2mF6LO6lUU8k4xt96gMoDcv8ybfJevBg
	R7dg==
X-Gm-Message-State: APjAAAUzBpqJbEke7/G4wfab9rkmSHxGQcu6IWoD/qpHd87NlE5ieBDW
	2kC/J4wDpXT+lBgKMWmhfSFKyPL2v/VN+A==
X-Google-Smtp-Source: APXvYqwuUsZku1PsiUrPWU5Qh/Ew67T39Hr95s6ATRLvE+izQYzjGoYuGOWJc+z1Zn8/VkzbKsukRg==
X-Received: by 2002:a17:902:a982:: with SMTP id
	bh2mr2403318plb.224.1558706671221; 
	Fri, 24 May 2019 07:04:31 -0700 (PDT)
Received: from localhost.localdomain ([120.57.120.132])
	by smtp.gmail.com with ESMTPSA id
	u11sm2556766pfh.130.2019.05.24.07.04.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 07:04:30 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:33:36 +0530
Message-Id: <20190524140337.13415-9-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524140337.13415-1-mehta.aaru20@gmail.com>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [RFC PATCH v2 8/9] block/file-posix: extends to use
 with io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/file-posix.c | 63 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d018429672..1f24618cfc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -154,6 +154,7 @@ typedef struct BDRVRawState {
     bool has_write_zeroes:1;
     bool discard_zeroes:1;
     bool use_linux_aio:1;
+    bool use_linux_io_uring:1;
     bool page_cache_inconsistent:1;
     bool has_fallocate;
     bool needs_alignment;
@@ -423,7 +424,7 @@ static QemuOptsList raw_runtime_opts = {
         {
             .name = "aio",
             .type = QEMU_OPT_STRING,
-            .help = "host AIO implementation (threads, native)",
+            .help = "host AIO implementation (threads, native, io_uring)",
         },
         {
             .name = "locking",
@@ -494,6 +495,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         goto fail;
     }
     s->use_linux_aio = (aio == BLOCKDEV_AIO_OPTIONS_NATIVE);
+    s->use_linux_io_uring = (aio == BLOCKDEV_AIO_OPTIONS_IO_URING);

     locking = qapi_enum_parse(&OnOffAuto_lookup,
                               qemu_opt_get(opts, "locking"),
@@ -557,7 +559,9 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     s->shared_perm = BLK_PERM_ALL;

 #ifdef CONFIG_LINUX_AIO
-     /* Currently Linux does AIO only for files opened with O_DIRECT */
+     /*
+      * Currently Linux does AIO only for files opened with O_DIRECT
+      */
     if (s->use_linux_aio) {
         if (!(s->open_flags & O_DIRECT)) {
             error_setg(errp, "aio=native was specified, but it requires "
@@ -578,6 +582,21 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         goto fail;
     }
 #endif /* !defined(CONFIG_LINUX_AIO) */
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        if (!aio_setup_linux_io_uring(bdrv_get_aio_context(bs), errp)) {
+            error_prepend(errp, "Unable to use io_uring: ");
+            goto fail;
+        }
+    }
+#else
+    if (s->use_linux_io_uring) {
+        error_setg(errp, "aio=io_uring was specified, but is not supported "
+                         "in this build.");
+        ret = -EINVAL;
+        goto fail;
+    }
+#endif /* !defined(CONFIG_LINUX_IO_URING) */

     s->has_discard = true;
     s->has_write_zeroes = true;
@@ -1883,6 +1902,12 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
             LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
             assert(qiov->size == bytes);
             return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
+#endif
+#ifdef CONFIG_LINUX_IO_URING
+        } else if (s->use_linux_io_uring) {
+            LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
+            assert(qiov->size == bytes);
+            return luring_co_submit(bs, aio, s->fd, offset, qiov, type);
 #endif
         }
     }
@@ -1920,24 +1945,40 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,

 static void raw_aio_plug(BlockDriverState *bs)
 {
-#ifdef CONFIG_LINUX_AIO
+#if defined CONFIG_LINUX_AIO || defined CONFIG_LINUX_IO_URING
     BDRVRawState *s = bs->opaque;
+#endif
+#ifdef CONFIG_LINUX_AIO
     if (s->use_linux_aio) {
         LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
         laio_io_plug(bs, aio);
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
+        luring_io_plug(bs, aio);
+    }
+#endif
 }

 static void raw_aio_unplug(BlockDriverState *bs)
 {
-#ifdef CONFIG_LINUX_AIO
+#if defined CONFIG_LINUX_AIO || defined CONFIG_LINUX_IO_URING
     BDRVRawState *s = bs->opaque;
+#endif
+#ifdef CONFIG_LINUX_AIO
     if (s->use_linux_aio) {
         LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
         laio_io_unplug(bs, aio);
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_aio) {
+        LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
+        luring_io_unplug(bs, aio);
+    }
+#endif
 }

 static int raw_co_flush_to_disk(BlockDriverState *bs)
@@ -1963,8 +2004,10 @@ static int raw_co_flush_to_disk(BlockDriverState *bs)
 static void raw_aio_attach_aio_context(BlockDriverState *bs,
                                        AioContext *new_context)
 {
+#if defined CONFIG_LINUX_AIO || defined CONFIG_LINUX_IO_URING
+        BDRVRawState *s = bs->opaque;
+#endif
 #ifdef CONFIG_LINUX_AIO
-    BDRVRawState *s = bs->opaque;
     if (s->use_linux_aio) {
         Error *local_err;
         if (!aio_setup_linux_aio(new_context, &local_err)) {
@@ -1974,6 +2017,16 @@ static void raw_aio_attach_aio_context(BlockDriverState *bs,
         }
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        Error *local_err;
+        if (!aio_setup_linux_io_uring(new_context, &local_err)) {
+            error_reportf_err(local_err, "Unable to use linux io_uring, "
+                                         "falling back to thread pool: ");
+            s->use_linux_io_uring = false;
+        }
+    }
+#endif
 }

 static void raw_close(BlockDriverState *bs)
--
2.17.1

