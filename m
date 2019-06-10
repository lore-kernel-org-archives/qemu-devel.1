Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3DBC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB21C20679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6bx19vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB21C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKpd-0001rZ-83
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKh5-0000S3-9B
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKh3-0002Ck-16
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:39 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKgx-00027P-6e; Mon, 10 Jun 2019 09:50:33 -0400
Received: by mail-pf1-x441.google.com with SMTP id d126so5364297pfd.2;
 Mon, 10 Jun 2019 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BkrqkXKw+QojOLRD6HxRpYEmbe+jRwaGL11dLaGKZ5o=;
 b=W6bx19vM75M0ca6e2UTVcmIVqjofcKVti0vnXTCULtzXI5M03HYLmrwR4Ffidbzfkz
 7Y8ezAfHO1VNv3F+JiFD7FGo69bL1ZSefUiq7NX9hvuQWVQMWQjzp2dJyxSpWyAWacv4
 dsvJLEUaYFvHqN9UHxTDVzJKD+yrMbG0UyyNi1OKReuOZU9dCA4IUXRKjVgY04y9go/4
 ayv9NDYNDOMrq/zeFb9gY/0lvKD80e0hWD5xUPOgCwVYtH7c9xkRLynFaIMIUtRucJQU
 oq/UfgQxajmn4861fJuuP4rEA9f2mpyRbKqui2uuCWHiwBeNgGqIaeSjaUcExcHQV1Ou
 FAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BkrqkXKw+QojOLRD6HxRpYEmbe+jRwaGL11dLaGKZ5o=;
 b=uAv1NDxiiuwCD+AnqOvmqdfAlsqB+ny5OnvepPIBprulpBXDnwupDigDf1YjwgRqIr
 Mm/NBJwnGbXuqnBIc2hqpI207CSiCZUr39U31yENkerLiRgZS7MsWc2nb8n1bixE0oMQ
 EXLk+9ihFuGtgaccbbkRU6sKvGe6RsGkxIaMb0uNbDNc4C/0i+B3OZQPExwGK9JdW+0Z
 14AsZ+9N4L4Tcu5h3CQHC9/jt98NgRCUgnDFEY0mJaGPfnRql9rb2fdI035f3tCNSKxm
 awRRm3llayDnxZepmqQ8pVHRMkjNbnU5UQBb9B3JwbH+kGqM6szGge7m88L+5dlnXhr9
 pQCg==
X-Gm-Message-State: APjAAAVWav+57agPttK2mMSOp2Lm0ttYMvoZY4yMsU/ketnblsuw9ykR
 ekXnA3n25T6bWVXHGLJerbhM1B74traCSA==
X-Google-Smtp-Source: APXvYqzMr81NSKc5yXFVkUdzOsVEGm9uEwQFiOk8aWEpb8i7b9gsRwHT0V9saw2qrhEuGml4/8rotw==
X-Received: by 2002:a17:90a:2244:: with SMTP id
 c62mr5214620pje.29.1560174625653; 
 Mon, 10 Jun 2019 06:50:25 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.50.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:50:25 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:19:01 +0530
Message-Id: <20190610134905.22294-9-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v5 08/12] block/file-posix.c: extend to use
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/file-posix.c | 85 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d018429672..211dfe5337 100644
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
@@ -482,9 +483,15 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         goto fail;
     }
 
-    aio_default = (bdrv_flags & BDRV_O_NATIVE_AIO)
-                  ? BLOCKDEV_AIO_OPTIONS_NATIVE
-                  : BLOCKDEV_AIO_OPTIONS_THREADS;
+    if (bdrv_flags & BDRV_O_NATIVE_AIO) {
+        aio_default = BLOCKDEV_AIO_OPTIONS_NATIVE;
+#ifdef CONFIG_LINUX_IO_URING
+    } else if (bdrv_flags & BDRV_O_IO_URING) {
+        aio_default = BLOCKDEV_AIO_OPTIONS_IO_URING;
+#endif
+    } else {
+        aio_default = BLOCKDEV_AIO_OPTIONS_THREADS;
+    }
     aio = qapi_enum_parse(&BlockdevAioOptions_lookup,
                           qemu_opt_get(opts, "aio"),
                           aio_default, &local_err);
@@ -493,7 +500,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         ret = -EINVAL;
         goto fail;
     }
+
     s->use_linux_aio = (aio == BLOCKDEV_AIO_OPTIONS_NATIVE);
+#ifdef CONFIG_LINUX_IO_URING
+    s->use_linux_io_uring = (aio == BLOCKDEV_AIO_OPTIONS_IO_URING);
+#endif
 
     locking = qapi_enum_parse(&OnOffAuto_lookup,
                               qemu_opt_get(opts, "locking"),
@@ -557,7 +568,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     s->shared_perm = BLK_PERM_ALL;
 
 #ifdef CONFIG_LINUX_AIO
-     /* Currently Linux does AIO only for files opened with O_DIRECT */
+    /* Currently Linux does AIO only for files opened with O_DIRECT */
     if (s->use_linux_aio) {
         if (!(s->open_flags & O_DIRECT)) {
             error_setg(errp, "aio=native was specified, but it requires "
@@ -579,6 +590,22 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
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
+
     s->has_discard = true;
     s->has_write_zeroes = true;
     if ((bs->open_flags & BDRV_O_NOCACHE) != 0) {
@@ -1875,16 +1902,20 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
      * If this is the case tell the low-level driver that it needs
      * to copy the buffer.
      */
-    if (s->needs_alignment) {
-        if (!bdrv_qiov_is_aligned(bs, qiov)) {
-            type |= QEMU_AIO_MISALIGNED;
+    if (s->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)) {
+                type |= QEMU_AIO_MISALIGNED;
+#ifdef CONFIG_LINUX_IO_URING
+    } else if (s->use_linux_io_uring) {
+        LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
+        assert(qiov->size == bytes);
+        return luring_co_submit(bs, aio, s->fd, offset, qiov, type);
+#endif
 #ifdef CONFIG_LINUX_AIO
-        } else if (s->use_linux_aio) {
-            LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
-            assert(qiov->size == bytes);
-            return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
+    } else if (s->use_linux_aio && s->needs_alignment) {
+        LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
+        assert(qiov->size == bytes);
+        return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
 #endif
-        }
     }
 
     acb = (RawPosixAIOData) {
@@ -1920,24 +1951,36 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
 static void raw_aio_plug(BlockDriverState *bs)
 {
+    BDRVRawState __attribute__((unused)) *s = bs->opaque;
 #ifdef CONFIG_LINUX_AIO
-    BDRVRawState *s = bs->opaque;
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
+    BDRVRawState __attribute__((unused)) *s = bs->opaque;
 #ifdef CONFIG_LINUX_AIO
-    BDRVRawState *s = bs->opaque;
     if (s->use_linux_aio) {
         LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
         laio_io_unplug(bs, aio);
     }
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
+        luring_io_unplug(bs, aio);
+    }
+#endif
 }
 
 static int raw_co_flush_to_disk(BlockDriverState *bs)
@@ -1963,8 +2006,8 @@ static int raw_co_flush_to_disk(BlockDriverState *bs)
 static void raw_aio_attach_aio_context(BlockDriverState *bs,
                                        AioContext *new_context)
 {
+    BDRVRawState __attribute__((unused)) *s = bs->opaque;
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


