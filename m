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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875D8C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5413F20673
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thsPzzkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5413F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41759 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAkO-0005oS-E0
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:12:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAcG-0007tu-DM
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAcF-00023q-Fa
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:20 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAcF-00023a-9C; Mon, 27 May 2019 04:04:19 -0400
Received: by mail-pf1-x441.google.com with SMTP id d126so6936141pfd.2;
	Mon, 27 May 2019 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2n2TNPYPU066kE92JQNbBm7Ypw4YV4ofgNfP3dVPw+E=;
	b=thsPzzkPiu2fe9UtZVHJfIOE+kgK38nL/p11GA+Q9UTd+KYy8/XF+TZMpiOHKHWPhJ
	2F98WGwFmQgGrHI4FkHw45twSIu/ETxH/ezhJ3teIAbzGu26XKnml/4nEDY4+tX6J1nw
	zaSoLkd62GJ97O1N506qYA3Jkze2htyA9eRDGGYNJHudAfEXa0Jet2OKG4Cv8LssJXm9
	hthKtuDMyEBZT3DbD2xeGe9FJappw9LzbFskgDmVejWgrUHQ0ZEiESOYp+TXtqP/crNR
	RGCR08b8KEhM2uBaawjISWLgQQLWECy/1KkKsocYoyPek01HDH35oDZzFe6dOX7QwRvI
	JJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2n2TNPYPU066kE92JQNbBm7Ypw4YV4ofgNfP3dVPw+E=;
	b=tW4Jr2Br0soyzfHb3f4rn9dCgife00b67ZmvntdL1EVeNtzDXHjJtSxHp6wK9Gy1OH
	UBlNJZ1HjCJ+2EFbpzdcRMnrYeYi+iHJ3FcYAHR1PuA86ToGPKAI2WQgLgKWMIn5NJWJ
	e2U0aZQbyPed8jlfV+a9ETd8L8GSM6wmWCgSapInqduX74FRFdA9DrLAAfUHP7CXQ2it
	Fep8lXD2owO0/4PMD5Z5XfPLIMXZpSnwP/5Anjr3oFffY9pFX9Ew+flgD1BeUwE7GUve
	F3ygp4zztnQlTCPGffMAm4QPix8P3O2XwUgqD2DN8zzADQKKMMTw3Z732BAcN9jx0YS7
	10pw==
X-Gm-Message-State: APjAAAUC1YjIM+dlv1PPyeMsUjHKTTiIXtJOIpgYMv0RBNzdSmivdgWK
	oU6A1ClFn8ukt9JEL5x5AMHYoynQaUSsuA==
X-Google-Smtp-Source: APXvYqzyhR5YSQWVNrOFfD3ERBj8oIBYLUZEbD8YpxB6+agjcWvZFvKLVeFQ5v6ze9Gdaa/MPl9GnQ==
X-Received: by 2002:a17:90a:9a6:: with SMTP id
	35mr28885965pjo.66.1558944257986; 
	Mon, 27 May 2019 01:04:17 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.04.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:04:17 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:25 +0530
Message-Id: <20190527080327.10780-7-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 6/8] util/async: add aio interfaces for
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/async.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/util/async.c b/util/async.c
index c10642a385..2709f0edc3 100644
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
 
@@ -341,6 +349,29 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
 }
 #endif
 
+#ifdef CONFIG_LINUX_IO_URING
+LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp)
+{
+    if (ctx->linux_io_uring) {
+        return ctx->linux_io_uring;
+    }
+
+    ctx->linux_io_uring = luring_init(errp);
+    if (!ctx->linux_io_uring) {
+        return NULL;
+    }
+
+    luring_attach_aio_context(ctx->linux_io_uring, ctx);
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
@@ -432,6 +463,11 @@ AioContext *aio_context_new(Error **errp)
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


