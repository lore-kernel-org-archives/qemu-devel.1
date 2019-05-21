Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5DFC072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 23:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48520216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 23:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To+xm8ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48520216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32823 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEeS-0007Fr-FQ
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 19:58:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEcK-0005iQ-Og
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEZ3-0001qJ-Gn
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:53:02 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEZ3-0001pz-Ax; Tue, 21 May 2019 19:53:01 -0400
Received: by mail-pg1-x544.google.com with SMTP id w22so307547pgi.6;
	Tue, 21 May 2019 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Gj1H7BTnoNvkp48yhjN3bE5xK+DRFHACTLF5AwUVMgo=;
	b=To+xm8ZK002sUar6/wjXpBl9tAvuy5A9z3jXm+xU0Iiy1w6G+V+tuhY1asF2WrYl5p
	M6bLvoPHZ8txQm6GoasW7r+YMT3JdZ/o7CaqQVl8/pLus8y/PFUJWntLHsK2RcQ/P/HY
	zNZoB293MGQcMSMPhk4t4hb/1indCMrdlrczttY88ImRclPnkg58Nu9NXFrNuef1fx5m
	fJ4Mt2zdiD34o/V3/p1lwhWt9fCf09qk/7NM1z7p7JYH+YccNSdnV+6qlBY+m9qnyEQK
	r5wIrMydQ//Cj7c9RrZU/BCE0BrrkWZj2HAJY1wHIbseTdh91VDxJWZWzar+b/RNvGSJ
	PDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Gj1H7BTnoNvkp48yhjN3bE5xK+DRFHACTLF5AwUVMgo=;
	b=aW3HjMIGwB9PMbWhSy4DpH19qLqVMEXWnl6lZNBw/2pMwKk7HgRvM10neSL9Xsaqhb
	YHV+BkRM7TS0jXzr8CIyqbbOuUMQRm9w0qAI0SclWbil89I9nwEXLE8y/2T0SgQkzLYk
	iRzTk+1p8CuXnQ0FFfdDkPgbw5JQFiCg2xt1pi5OMBtmwFBEk+NcYtOQQTzvUqH6Qsrw
	etXPqESjZryBhvrSRqczq7BdVY7TDcGplxSFxu8giFhpzxZ+G61l0UU1zz+YGwW4D5/W
	wRynUAmKyIaPLYwJ4yyEuqVZ/ra1qprxEkuqhfULys5mOUu86d3ZZfhwCUItvy6S5blY
	qHWQ==
X-Gm-Message-State: APjAAAUjoPUc5uQ8e4yz8qUJ3yDpTHJY8HH2y22teIHfjGQ0+FQy7+Kx
	zxdiSkO40N52J6sH5pi79xLy46RG96OYaA==
X-Google-Smtp-Source: APXvYqwT3SUaOiSoAgO2ZqLusTFeI8bEUt+fZ1bj3jgFgR5m/V3mdXzb1zhj9GK+0gU9Igo5Vsh/RQ==
X-Received: by 2002:a65:640c:: with SMTP id a12mr23600702pgv.1.1558482780074; 
	Tue, 21 May 2019 16:53:00 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.52.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:52:59 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:14 +0530
Message-Id: <20190521235215.31341-9-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [RFC PATCH 8/9] block/file-posix: extends to use with
 io_uring
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 block/file-posix.c | 63 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1cf4ee49eb..41952217a4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -154,6 +154,7 @@ typedef struct BDRVRawState {
     bool has_write_zeroes:1;
     bool discard_zeroes:1;
     bool use_linux_aio:1;
+    bool use_linux_io_uring;
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
@@ -1870,6 +1889,12 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
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
@@ -1907,24 +1932,40 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,

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
@@ -1950,8 +1991,10 @@ static int raw_co_flush_to_disk(BlockDriverState *bs)
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
@@ -1961,6 +2004,16 @@ static void raw_aio_attach_aio_context(BlockDriverState *bs,
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

