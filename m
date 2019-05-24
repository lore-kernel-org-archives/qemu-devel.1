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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F8EC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5D020665
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OelFy3qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5D020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUB07-0005Eu-Bj
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:16:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoJ-0003KZ-Vm
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAns-0002Un-0q
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:13 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hUAnr-0002Ts-RW; Fri, 24 May 2019 10:04:11 -0400
Received: by mail-pg1-x543.google.com with SMTP id w34so459018pga.12;
	Fri, 24 May 2019 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IwdgR4CAZqUTgzHR3HV5kaLH/wCH1Pdav2fxuHWxNdY=;
	b=OelFy3qun/4+OUHJQRyLVzDM+eEQL4qik9A9v8slQ9W6cEbTswGtRi82C0zmqSfCaR
	dS6JSXll7U8ISYEfBeQVbTUn7o1A1/He+M+3XD8+BWM/4eYq665adwH95B1BSuG3cJAP
	ShXhmYwghDh+L5lD7Bu7b0NU7BNdsmRcpnxCBkBTS5lGBB5ePBnDQW9cXq64VkdeT8Md
	2YFbSRDcIp2d3cjL9ds0P/+mE6xeNBXkuLH8Xvv+EGhK/QmUgOl5OqHeA6YpmDdpY7eR
	ZWwIKRdeWvFdR0UTTzR2WNCHmR4ZlT96wysHBIXIvyuHIUt9b9gktpHUXbStR46wsnIA
	LQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IwdgR4CAZqUTgzHR3HV5kaLH/wCH1Pdav2fxuHWxNdY=;
	b=LFOSJmDd/Cgqtqw1UwO5jMFsK9sMPrUUengVO2+TSvOdlsXdKLF66RNgQQzGCTO4x4
	mrvACiUmCM7R6ygGshAeikXhdv5JEffcWxeptFMD1ftGw/2oaVb/UyV5yLqVJYrZBJlP
	IVHeoDchKc7h7Ze2kO0mfWf613Clt7PPZa4SDElE/+ya9IPaB7/2iA+5p+T6mMrUVQ2+
	ur4ft6GXRupRAfG6qRzNCHLc1Svlyu0PBsTxS189zefE7doeRPjOHfrfUYvlmeJh0POT
	GbE7HzWimbPvAuopytPlb0/vbj1nDIgjVHttEHzKWFjitVpLuSXj38Iw+bYFZrwOV7ir
	U3jw==
X-Gm-Message-State: APjAAAXEm5Jctu7WM0xspSX24gn5UTeHn18W/1TDTg4iJh44szOKKn49
	NhQU5PqzR/Tbw+7QwDBWDuYkddpUe4nHqw==
X-Google-Smtp-Source: APXvYqz4WYDo2X5tT4guQwyOQkqYM0FFIUm67mo71cQI3kVT2QYmZXCiMjJfENV32WGaRBE1/w/F+A==
X-Received: by 2002:a63:4c14:: with SMTP id z20mr13272594pga.360.1558706650426;
	Fri, 24 May 2019 07:04:10 -0700 (PDT)
Received: from localhost.localdomain ([120.57.120.132])
	by smtp.gmail.com with ESMTPSA id
	u11sm2556766pfh.130.2019.05.24.07.04.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 07:04:09 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:33:31 +0530
Message-Id: <20190524140337.13415-4-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524140337.13415-1-mehta.aaru20@gmail.com>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [RFC PATCH v2 3/9] include/block: declare interfaces
 for io_uring
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
 include/block/aio.h     | 16 +++++++++++++++-
 include/block/raw-aio.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 0ca25dfec6..9da3fd9793 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -50,6 +50,7 @@ typedef void IOHandler(void *opaque);
 struct Coroutine;
 struct ThreadPool;
 struct LinuxAioState;
+struct LuringState;

 struct AioContext {
     GSource source;
@@ -118,11 +119,19 @@ struct AioContext {
     struct ThreadPool *thread_pool;

 #ifdef CONFIG_LINUX_AIO
-    /* State for native Linux AIO.  Uses aio_context_acquire/release for
+    /*
+     * State for native Linux AIO.  Uses aio_context_acquire/release for
      * locking.
      */
     struct LinuxAioState *linux_aio;
 #endif
+#ifdef CONFIG_LINUX_IO_URING
+    /*
+     * State for Linux io_uring.  Uses aio_context_acquire/release for
+     * locking.
+     */
+    struct LuringState *linux_io_uring;
+#endif

     /* TimerLists for calling timers - one per clock type.  Has its own
      * locking.
@@ -387,6 +396,11 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
 /* Return the LinuxAioState bound to this AioContext */
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);

+/* Setup the LuringState bound to this AioContext */
+struct LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp);
+
+/* Return the LuringState bound to this AioContext */
+struct LuringState *aio_get_linux_io_uring(AioContext *ctx);
 /**
  * aio_timer_new_with_attrs:
  * @ctx: the aio context
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index ba223dd1f1..28a836151e 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -58,6 +58,21 @@ void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
 void laio_io_plug(BlockDriverState *bs, LinuxAioState *s);
 void laio_io_unplug(BlockDriverState *bs, LinuxAioState *s);
 #endif
+/* io_uring.c - Linux io_uring implementation */
+#ifdef CONFIG_LINUX_IO_URING
+typedef struct LuringState LuringState;
+LuringState *luring_init(Error **errp);
+void luring_cleanup(LuringState *s);
+int coroutine_fn luring_co_submit(BlockDriverState *bs, LuringState *s, int fd,
+                                uint64_t offset, QEMUIOVector *qiov, int type);
+BlockAIOCB *luring_submit(BlockDriverState *bs, LuringState *s, int fd,
+        int64_t sector_num, QEMUIOVector *qiov, BlockCompletionFunc *cb,
+        void *opaque, int type);
+void luring_detach_aio_context(LuringState *s, AioContext *old_context);
+void luring_attach_aio_context(LuringState *s, AioContext *new_context);
+void luring_io_plug(BlockDriverState *bs, LuringState *s);
+void luring_io_unplug(BlockDriverState *bs, LuringState *s);
+#endif

 #ifdef _WIN32
 typedef struct QEMUWin32AIOState QEMUWin32AIOState;
--
2.17.1

