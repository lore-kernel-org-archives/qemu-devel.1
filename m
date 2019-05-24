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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BEC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5F6206A3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evo77aYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5F6206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55253 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAvy-0001o2-BJ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:12:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoD-0003K3-Cx
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAo0-0002cW-4d
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:21 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hUAnz-0002c2-UU; Fri, 24 May 2019 10:04:20 -0400
Received: by mail-pf1-x444.google.com with SMTP id a23so5409939pff.4;
	Fri, 24 May 2019 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=sX7eykaQ8cZK+ytZ0RoclnVS3C7FzTjrBrMveeNkyW0=;
	b=Evo77aYyLdCC6UeBeVsvqOqPSwLYkA7QMFLp3xjnKJei1ewqe8E1faz511cNBpd2t4
	bNetoCn7+HmrJflvUtarj8sNiY5ZpAzC0T4JCBdEDaU4Dp2RwjPMyY8NKHnf0MsLrUR5
	ejiL813hYUVBkGfWc4F/5g4Dl4OU9Yzy9Q29kCbIPJLSzgKxToZQYCWDTFhVxiuiFX7P
	GpPVGxojzRrk1dvXXyAFHp2QAS4gaLIpkHiSlQMYTHFN/GTugLUGEYwX7dK1H42+HGxl
	AyJ10GlZj+N9ytF2z+ngMwUDF1WAHh06Pwm59KfEr3OQIwsTzloHtmh05hT2DODLSUwE
	9S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=sX7eykaQ8cZK+ytZ0RoclnVS3C7FzTjrBrMveeNkyW0=;
	b=FiAl5+1qsajmcMH2u5V1FLrfE9Qvg8J4xUXoppla/MT9Q4RIM2ZjbfeJAPJ3S+Mw5F
	mcsD5IUCmU63/71l8u9HWKmCiNbLyhRBS2zcpfqUVL1jyBh1kDb5bCyzIEtb4HItCGtj
	hkQRMuL7aX9JmXuTPR1MKPtTYfeTyTFWBZlBrrmtSHf0TwRwuM7mg0pvCy+mg7U1OJes
	ViLYXQexqxjf6NX6M4x+WZeToLmu92CkaH8AN556DFNj6/rQwVJrBDv1TjLxZS3rx7hM
	HtPCtR9CMv5lm3U5i/4/Y8lU74hobz+OZeKu+LvaADt8PJ9U4Sm2qWyPifa4O6udG94V
	HakQ==
X-Gm-Message-State: APjAAAUdfdRgmKC0NvkHuAcZ/thoWoS39Rml4m60eI5WnkAvhkkS9zbG
	LeIr56F4mNC/BQWIAyOy6WhY2WnQ0Mxdgw==
X-Google-Smtp-Source: APXvYqwLhpJDTAMkQDahfqbOoPmf7EOgUKZcljgITJVmaQJmhrI5gTmiuNfr+kuGyHE/2e4mSBwhYg==
X-Received: by 2002:a63:1854:: with SMTP id 20mr103061860pgy.366.1558706658608;
	Fri, 24 May 2019 07:04:18 -0700 (PDT)
Received: from localhost.localdomain ([120.57.120.132])
	by smtp.gmail.com with ESMTPSA id
	u11sm2556766pfh.130.2019.05.24.07.04.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 07:04:18 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:33:33 +0530
Message-Id: <20190524140337.13415-6-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524140337.13415-1-mehta.aaru20@gmail.com>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [RFC PATCH v2 5/9] util/async: add aio interfaces for
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
	saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
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

