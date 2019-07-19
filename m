Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC34C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923D12173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVSiUH/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923D12173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT4f-0007vz-JG
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38034)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4C-00068j-5I
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT4A-00082Z-PL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT4A-00081w-Hd; Fri, 19 Jul 2019 09:36:54 -0400
Received: by mail-pl1-x642.google.com with SMTP id c2so15623982plz.13;
 Fri, 19 Jul 2019 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=21nbGyti/fbtP+74vynC71Q4v/9EpogSHcLqUvH9uKU=;
 b=kVSiUH/QWnGwtdyBbGTw78RxZS28Dta1cj+Mo6L2Y81kPMZMWyxAaP7/LfHJ44Dx3t
 MQuKAqPFVWk8WxberiwXxWGYNta/9+CpXO0MQfh+ugdi716r1nhNFvJJsmxZ+wnkpMST
 dpCIM46D6mWjC/BZnXwdywZNjX/beq2YYYGK66KyRy+kIBCOm7rEZ7P235uUHoFcsZ6I
 NUECXafWkIiBl+h0qoT8VZqLpI7FYDy8prStIqqjLQCxw/MkZxfnhuGRwfFYXM278Kba
 731lZwUmY9U+SZlo88mu/mZjqFCQ48Yx8KDNUrwMtybuG9Ck2WE2GuOafbXGm/O8qA49
 JCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=21nbGyti/fbtP+74vynC71Q4v/9EpogSHcLqUvH9uKU=;
 b=fHiWlFy5AnaCOiHgP9zIjxOrIU+n2+c7EmJDDI/H/VFoI40L6yQGY+Ufq9+mIpLNfc
 GjDUNhNOqVtrmCvzDQbj0SkE9jhm9FTGKqPgbBlHpKozeWD9jZrXtj3p2V10todTvEwM
 MbelXeVx3Ds85Ghjb7iET1cPAVPJrGJBcPoKRwK1wJx39K+UqTDMUeIf2fAACGfZkjwG
 BrLPR61ZtvmeXxtH9DBpOOk3lUZ9b7mvxnMQomVDQrwJtFiehr74pCFf1jmi0ZHiGLLw
 xFzDLNMxH2Tuj6/HOkHu/89aPHUCjSK4vGpaRjjMQTFjDjSVjBniVavHg9uriFQw0jlN
 Kzfg==
X-Gm-Message-State: APjAAAVvku8PszKn+3YSPWbntgzyCc6oif8rgz57GKHH2j2qPgLawir1
 j+AX+LG1pvEkLHmaiDd4oGRMl2524XA=
X-Google-Smtp-Source: APXvYqwAusdb8SqSvG+53Je6i0Y82xxhmRse/FcvteKGUd/kMKg9hKa3UTXbdyTw3L3R6OblSPwAgQ==
X-Received: by 2002:a17:902:6a87:: with SMTP id
 n7mr56197396plk.336.1563543413097; 
 Fri, 19 Jul 2019 06:36:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.36.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:36:52 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:24 +0530
Message-Id: <20190719133530.28688-9-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v6 08/14] block/file-posix.c: extend to use
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
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 block/file-posix.c | 99 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 20 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4479cc7ab4..4aa42f826f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -156,6 +156,7 @@ typedef struct BDRVRawState {
     bool has_write_zeroes:1;
     bool discard_zeroes:1;
     bool use_linux_aio:1;
+    bool use_linux_io_uring:1;
     bool page_cache_inconsistent:1;
     bool has_fallocate;
     bool needs_alignment;
@@ -425,7 +426,7 @@ static QemuOptsList raw_runtime_opts = {
         {
             .name = "aio",
             .type = QEMU_OPT_STRING,
-            .help = "host AIO implementation (threads, native)",
+            .help = "host AIO implementation (threads, native, io_uring)",
         },
         {
             .name = "locking",
@@ -484,9 +485,15 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
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
@@ -495,7 +502,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
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
@@ -559,7 +570,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     s->shared_perm = BLK_PERM_ALL;
 
 #ifdef CONFIG_LINUX_AIO
-     /* Currently Linux does AIO only for files opened with O_DIRECT */
+    /* Currently Linux does AIO only for files opened with O_DIRECT */
     if (s->use_linux_aio) {
         if (!(s->open_flags & O_DIRECT)) {
             error_setg(errp, "aio=native was specified, but it requires "
@@ -581,6 +592,22 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
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
@@ -1874,21 +1901,25 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
         return -EIO;
 
     /*
-     * Check if the underlying device requires requests to be aligned,
-     * and if the request we are trying to submit is aligned or not.
-     * If this is the case tell the low-level driver that it needs
-     * to copy the buffer.
+     * When using O_DIRECT, the request must be aligned to be able to use
+     * either libaio or io_uring interface. If not fail back to regular thread
+     * pool read/write code which emulates this for us if we
+     * set QEMU_AIO_MISALIGNED.
      */
-    if (s->needs_alignment) {
-        if (!bdrv_qiov_is_aligned(bs, qiov)) {
-            type |= QEMU_AIO_MISALIGNED;
+    if (s->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)) {
+        type |= QEMU_AIO_MISALIGNED;
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
+    } else if (s->use_linux_aio) {
+        LinuxAioState *aio = aio_get_linux_aio(bdrv_get_aio_context(bs));
+        assert(qiov->size == bytes);
+        return laio_co_submit(bs, aio, s->fd, offset, qiov, type);
 #endif
-        }
     }
 
     acb = (RawPosixAIOData) {
@@ -1924,24 +1955,36 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
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
@@ -1961,14 +2004,20 @@ static int raw_co_flush_to_disk(BlockDriverState *bs)
         .aio_type       = QEMU_AIO_FLUSH,
     };
 
+#ifdef CONFIG_LINUX_IO_URING
+    if (s->use_linux_io_uring) {
+        LuringState *aio = aio_get_linux_io_uring(bdrv_get_aio_context(bs));
+        return luring_co_submit(bs, aio, s->fd, 0, NULL, QEMU_AIO_FLUSH);
+    }
+#endif
     return raw_thread_pool_submit(bs, handle_aiocb_flush, &acb);
 }
 
 static void raw_aio_attach_aio_context(BlockDriverState *bs,
                                        AioContext *new_context)
 {
+    BDRVRawState __attribute__((unused)) *s = bs->opaque;
 #ifdef CONFIG_LINUX_AIO
-    BDRVRawState *s = bs->opaque;
     if (s->use_linux_aio) {
         Error *local_err;
         if (!aio_setup_linux_aio(new_context, &local_err)) {
@@ -1978,6 +2027,16 @@ static void raw_aio_attach_aio_context(BlockDriverState *bs,
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
2.21.0


