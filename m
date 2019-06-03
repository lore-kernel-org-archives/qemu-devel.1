Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F74C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D442E27E72
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3y5vYnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D442E27E72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmNK-0000VR-Vo
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:47:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmKp-0007F5-Ns
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmFF-00089x-6v
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:39:22 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmFF-000883-0r; Mon, 03 Jun 2019 08:39:21 -0400
Received: by mail-pl1-x643.google.com with SMTP id f97so6958256plb.5;
	Mon, 03 Jun 2019 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=2n2TNPYPU066kE92JQNbBm7Ypw4YV4ofgNfP3dVPw+E=;
	b=b3y5vYnQjEXFQ76uHJujX4qrMGjTf6sme8zfuRomZuIKay8FZj0Qe7L2Fr/XBumxcX
	rCeurwOclbe6ZwKaeZin5UBxVUEWh9B5T6CFYwWJ1wPGnC7Pbh5IePY1UeLW4JAzXT9/
	CTwS1fOqcaMuLSogBklmTRN5kxw8bH6X9ODk/6ZVrVNUncWeJWfSPHZ0+N6iCfDGcm3O
	lGosMhgOhwOWQ96Kk9M5DWC60a0MLgpTmIGryAIvUTJjH5gTdU0G6UQLgBvVsnU7t4K7
	xFWHpbMQXR9cWeWSPo5IhGyfILJ/huBsy67KoCWTQgng62f1mK4ZGW9l5PRNajWa8hvZ
	YWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2n2TNPYPU066kE92JQNbBm7Ypw4YV4ofgNfP3dVPw+E=;
	b=aX/PZe2JqC+XFJoUjiarTTJIpyygtIuE9tP0u5n0RqBy/RnXj6OHTfNlna12x0drqX
	pETa7xmuzTpAbX7ewIe0vsVYB3BrWVcY4g+RN2BqNIEZuupdaQzvMc/wnQW/RejgSJcA
	m6ox6GBKCgbAczXiv8etyHvQ0NPlE0BP2dYO6bF6jp1lgEOxazH+KoVjA2/2iMfQ+ws2
	BO+3yiEkblaYWQ21ix/nvsP3MivrkMeJDztnAY3EEg7igGLzk6/pawxNaNtETJHw5oPX
	l8WsjuLhR6N7ysEaB1IxEZ0MzIvG7Oedh2aq5++ECdkG0XUmbV5fe2drtYzq8CgWxTqm
	oSBg==
X-Gm-Message-State: APjAAAX2DiwVmw8B7mmHV9YEmLxsZ/Aywarp6hAy+dtsQcRJ57f166YO
	lKvj4TXIWwrg0X0MXsb7qy6VHWy6a4DfYg==
X-Google-Smtp-Source: APXvYqxFp4Hj/SE/43w0jiQXnGH3O30SQrJGDw2nQeIjE0uXxnYpnINNBP4YFf9il5Ej2i/yy2WL4g==
X-Received: by 2002:a17:902:5ac9:: with SMTP id
	g9mr29729911plm.134.1559565559775; 
	Mon, 03 Jun 2019 05:39:19 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.39.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:39:19 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:20 +0530
Message-Id: <20190603123823.32661-7-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603123823.32661-1-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v4 6/9] util/async: add aio interfaces for
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
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


