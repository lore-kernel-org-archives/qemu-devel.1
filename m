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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E9AC072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60760217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rO1UXrDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60760217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEhF-0001iO-J1
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:01:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEcV-0005iQ-5A
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEYs-0001j3-KL
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:52:51 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEYs-0001ij-F8; Tue, 21 May 2019 19:52:50 -0400
Received: by mail-pf1-x441.google.com with SMTP id z26so276701pfg.6;
	Tue, 21 May 2019 16:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=HFBwuOKEbqexqwPgrKzRL4NNTvNhKQclyEPlvywkxJs=;
	b=rO1UXrDK9jTzkhu+6kaDlqwnX3bPbTNFxaOfQuwgzABgp0BJHEfFHYN/4c0X0hnYOm
	5tSpvxL50yYL9QrTI1QDwED63lwJ+5a3adDCvaLROGH5XJRVKeYHlJVNZ6CJn9JVkTLr
	rUOy5IetczVYw07KEp7051J+KPivqfWhLjlSj1qlPTGu1jBdxWIB8schOf54yHYGhO0M
	D04OmcbBalHZ6RLv3uY+dd5F20TdE+s3rztJY6lZSlvnSwblfsuiUhzoAE4Pb5hbRNJw
	SY7HA/sOCbqUQ6NLvJV68/VwKri0FUWbjlSJ3TQ9WXEx76Euxod/Dne8wmhT0nfx37lI
	cq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=HFBwuOKEbqexqwPgrKzRL4NNTvNhKQclyEPlvywkxJs=;
	b=hChM1VOBEEQaGG3y5Rch31jfa5K76wlh0A2SaLH2Njc3fHT/wGyMcdIl10/qbFsher
	zJ5O5jTD52vzfe19f9Bbn1BkfxgZfMDEO+VsPuPUD9XdIc7dpuD4YZwWteIzzLtWyme8
	Okr7xTZ+w2TJJMjbLQRWjHbSEDPGO57w2rhd3Dk9FVKp1yV6XZtLSAWTT9+aTpGkHkrm
	6HVhajVzXrjFw3rQcNE1LyzbMT8cyRGER4ysD1666bMx4naQqhcBVJGpipN+KQEVm1E4
	+YIPQezbGiIZ1QoWyX5HR8JYKTl+00m3B1xUQb6J6JIb6gcQT2FZO5T81xBRiAhfae+t
	7N+Q==
X-Gm-Message-State: APjAAAXXKZev12h9anrecR4/fvZ5kRSfsdF7nH6rax3kYL+gmrSGiVXO
	VYbhW9oMvkiy/9VZuziSurRO/IuVMI1Qtg==
X-Google-Smtp-Source: APXvYqx3Z/px+tuLCUbtnRfSLoCItyYKrqbM0NNIiB5m5HbbR1omm9nam5H+2MmEgKYnB4zdzX8RgA==
X-Received: by 2002:aa7:9a99:: with SMTP id w25mr52155463pfi.249.1558482769204;
	Tue, 21 May 2019 16:52:49 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.52.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:52:48 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:11 +0530
Message-Id: <20190521235215.31341-6-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [RFC PATCH 5/9] util/asyn: add aio interfaces for
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
 util/async.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/util/async.c b/util/async.c
index c10642a385..dd45aff8f5 100644
--- a/util/async.c
+++ b/util/async.c
@@ -277,6 +277,14 @@ aio_ctx_finalize(GSource     *source)
     }
 #endif

+#ifdef CONFIG_LINUX_IO_URING
+    if (ctx->linux_io_uring) {
+        luring_detach_aio_context(ctx->linux_io_uring, ctx);
+        luring_cleanup(ctx->linux_io_uring);
+        ctx->linux_io_uring = NULL;
+    }
+#endif
+
     assert(QSLIST_EMPTY(&ctx->scheduled_coroutines));
     qemu_bh_delete(ctx->co_schedule_bh);

@@ -341,6 +349,25 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
 }
 #endif

+#ifdef CONFIG_LINUX_IO_URING
+LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp)
+{
+    if (!ctx->linux_io_uring) {
+        ctx->linux_io_uring = luring_init(errp);
+        if (ctx->linux_io_uring) {
+            luring_attach_aio_context(ctx->linux_io_uring, ctx);
+        }
+    }
+    return ctx->linux_io_uring;
+}
+
+LuringState *aio_get_linux_io_uring(AioContext *ctx)
+{
+    assert(ctx->linux_io_uring);
+    return ctx->linux_io_uring;
+}
+#endif
+
 void aio_notify(AioContext *ctx)
 {
     /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
@@ -432,6 +459,11 @@ AioContext *aio_context_new(Error **errp)
 #ifdef CONFIG_LINUX_AIO
     ctx->linux_aio = NULL;
 #endif
+
+#ifdef CONFIG_LINUX_IO_URING
+    ctx->linux_io_uring = NULL;
+#endif
+
     ctx->thread_pool = NULL;
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
--
2.17.1

