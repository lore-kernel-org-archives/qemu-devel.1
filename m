Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBD3C072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C652217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGTJ4Kyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C652217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32947 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEjI-0003a7-Mm
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:03:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEcX-0005iQ-SR
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEYl-0001f4-AO
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:52:44 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEYl-0001en-5G; Tue, 21 May 2019 19:52:43 -0400
Received: by mail-pf1-x441.google.com with SMTP id 13so267742pfw.9;
	Tue, 21 May 2019 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=u+flvTgxCSEnbGBAPAYORRxauVugPBlncOQJBlabvsk=;
	b=EGTJ4KygxPfOKSU16lqWxY8l83cPOLjgZ1SbYKLcfA1U7ZrOLAuqaljRWQrKCXfJOh
	x/hTk+H8nUPd1j9HgMRolFr/cX/2jRLEzrMpPG/1H02CQzYPeQgs4tAU/UXhL33iLxbX
	paq2P4RoqomyHLa7Xa0WU2PgYttubz6HXIcNo3/ArweaiMAZ+bEkAzuMbRm/ydMGc9ku
	Hkeqe438yyhu7ehjNCw6J9dk5vdr2n6gXwEOdlnuRENcnmbPHVZ2+tF8i2yRqLxC5odU
	IPTiXJhHPk7CkIBl1rNad96pPEsB1+2NJLORSuC5THHFduSQvxMgyd/NCSDptH4VW5I8
	19Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=u+flvTgxCSEnbGBAPAYORRxauVugPBlncOQJBlabvsk=;
	b=s+rhbiGca15HsH3y8GaoVmxc+653AOrzqizncw0SCKLoTZeXw9uuocQL2/sM9ImDiO
	cxKKmclKvVdfnV7Hj9hIUfES1KQWGXkRJCVQ55tfr/Ee9o8PnBS87+g/7Mwt0PlDYf/8
	IX5w4tHCvDUYnXjuYfC8iP9TxsElGv611JSEKsEng3DIyvxe7lKLs5iVoBIVowPf1zlJ
	n8eJZVlFvAUUhHSTCasUoBXUpsKFLgvA2SeRSnV3D/0jeHMWd+ipfOh3fDSTyggV/8tj
	N0QqORKfOYgdIdz8eGHB7tcqpDZLoE/hfPxCX/aqIW0DI9OZCaO8cTm4+HeOpYf4pzbn
	u51g==
X-Gm-Message-State: APjAAAWCo+UyzP2xeEXCwvcc1xyZuqiGhEYMK1qz8maAZOmbzORnasxt
	T9D+VRo/Hq1C1ptUh7FAccNanf1ATDMiFw==
X-Google-Smtp-Source: APXvYqwqWyjoLHnK34cWpnbSnqkY5qobLwOip2Ucb3kTehPjM8JwAP5414Vv1BxmATUTMpZE5vSlfQ==
X-Received: by 2002:a63:d343:: with SMTP id u3mr85966342pgi.285.1558482761861; 
	Tue, 21 May 2019 16:52:41 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.52.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:52:41 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:09 +0530
Message-Id: <20190521235215.31341-4-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [RFC PATCH 3/9] include/block: declare interfaces for
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
 include/block/aio.h     | 16 +++++++++++++++-
 include/block/raw-aio.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 0ca25dfec6..2f9acbcd7d 100644
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
+     * State for native Linux AIO.  Uses aio_context_acquire/release for
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
index ba223dd1f1..2e413bbee0 100644
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
+        int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
+        BlockCompletionFunc *cb, void *opaque, int type);
+void luring_detach_aio_context(LuringState *s, AioContext *old_context);
+void luring_attach_aio_context(LuringState *s, AioContext *new_context);
+void luring_io_plug(BlockDriverState *bs, LuringState *s);
+void luring_io_unplug(BlockDriverState *bs, LuringState *s);
+#endif

 #ifdef _WIN32
 typedef struct QEMUWin32AIOState QEMUWin32AIOState;
--
2.17.1

