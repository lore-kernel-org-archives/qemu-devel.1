Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504DDC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E43120673
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1UML6ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E43120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41761 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAkT-0005sB-76
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:12:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAca-00086D-RG
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAcT-0002vJ-Hv
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAcT-0002eA-9v; Mon, 27 May 2019 04:04:33 -0400
Received: by mail-pg1-x544.google.com with SMTP id a3so8668403pgb.3;
	Mon, 27 May 2019 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Uwb/EZQuCfGDY5z7rHaCbNCqdMyI7SEsgEZivjIIJAI=;
	b=o1UML6ikBlzPKty4fWKliLrER8SCt2l8psnpi74SvvCmozjKZG3N6BzMugTyqi8acf
	TMSuGs41VdbYjEg4MScP0YXz3kKW+LrsBatpPVjCJ2tYVYlPqWbJZXZHa2eTd/EVxR9Q
	fF+abMJJWOp1cZyx8pNq8a/G4t3pyZYGUgUVpsSDEHWhi/D7Ti7L0htO6lMJiJZ21OSV
	JOz8mz2I1N9K7fJhL8mYDrDOG5R0bfIzw0BhL+/75yh1IGbpdmJ13vi8bHCf7OO+U3Dt
	DkkGge9G2ABXomkuDn06fToK4s8WqyHUAavb++h/37pH2BUkOy5M81qhD7r22GhfzMtH
	KImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Uwb/EZQuCfGDY5z7rHaCbNCqdMyI7SEsgEZivjIIJAI=;
	b=cg8trVVyzStnz8rQEeJttLVq0qZqC349tG7R50nGm8uQh5YeHDkjM4XNnpMfNsD4Vl
	VrslguyqH1lurMWLv5OJ2L9Zt5vfKsvcV65V2WkftW4MB6eRPhxOfLIjPEk92jLRjInF
	6kcKZw/fOm15wlpMqQb0zWcaJduhqgqywCd3gUfpbbZBcSoLW6nYMQnSGgGcDv8WzpcB
	puXMNd8c/BUCeVr++2o3wswqbCjHx0J9Y6YJ9n39tXxwiQ9wJws1cwJHN8+7zY4Ca1lI
	dIYisS5uqQfj5KvsBbfZMHo5MyAT9i/vLex8EN4UCF9UcCCOeC+GDcCsFnZTZckZJpcE
	DaWQ==
X-Gm-Message-State: APjAAAUeeQpzI332NzMhzYDLWmOEist8OUtv3VmvbvImkn1vITgzQnJo
	JnPWJRt0DRnEhhmHXFrI2wW1XAnICtz5gg==
X-Google-Smtp-Source: APXvYqy2qM0/Rvsu/oKehb1yjv2eoxi3PRcw8dcJ6ptpdkM4dHoHIXOOeKUnEgqjHvs1jxRdx83J1w==
X-Received: by 2002:aa7:9217:: with SMTP id 23mr34543747pfo.80.1558944268240; 
	Mon, 27 May 2019 01:04:28 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.04.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:04:27 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:27 +0530
Message-Id: <20190527080327.10780-9-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 8/8] block/fileposix: extend to use io_uring
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
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/file-posix.c | 65 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index d018429672..50899064df 100644
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
@@ -494,6 +495,9 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         goto fail;
     }
     s->use_linux_aio = (aio == BLOCKDEV_AIO_OPTIONS_NATIVE);
+#ifdef CONFIG_LINUX_IO_URING
+    s->use_linux_io_uring = (aio == BLOCKDEV_AIO_OPTIONS_IO_URING);
+#endif
 
     locking = qapi_enum_parse(&OnOffAuto_lookup,
                               qemu_opt_get(opts, "locking"),
@@ -557,7 +561,9 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     s->shared_perm = BLK_PERM_ALL;
 
 #ifdef CONFIG_LINUX_AIO
-     /* Currently Linux does AIO only for files opened with O_DIRECT */
+    /*
+     * Currently Linux does AIO only for files opened with O_DIRECT
+     */
     if (s->use_linux_aio) {
         if (!(s->open_flags & O_DIRECT)) {
             error_setg(errp, "aio=native was specified, but it requires "
@@ -578,6 +584,21 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
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
@@ -1883,6 +1904,12 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
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
@@ -1920,24 +1947,40 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
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
@@ -1963,8 +2006,10 @@ static int raw_co_flush_to_disk(BlockDriverState *bs)
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
@@ -1974,6 +2019,16 @@ static void raw_aio_attach_aio_context(BlockDriverState *bs,
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


