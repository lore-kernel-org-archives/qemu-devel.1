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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A24C468C1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C5220679
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXRog9Ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C5220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46786 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKpS-0001Pv-TP
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51267)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKgh-0000Dm-3F
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1haKgg-0001rd-2R
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:50:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1haKgf-0001pY-Sf; Mon, 10 Jun 2019 09:50:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id g9so3693286plm.6;
 Mon, 10 Jun 2019 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2n2TNPYPU066kE92JQNbBm7Ypw4YV4ofgNfP3dVPw+E=;
 b=OXRog9PsOSiWar8mHFlYwMqgg4OWgzV29N1Ng2Tf4KPhGk7W005Bq0+hao+Jl3AWTe
 SNfKyRhHFpcLlMLG8WHKrWAJlNhcC0k3H0Ba4nERvtpznsCQkNyyyv8gNtKrZMCt1hne
 w24XN9Hp/ii7KBSXlpJzQdwhf/xx6ShvQf0MCjsmMflOxYgigBKDS+LWCV+cVbkbpjmV
 G2aEV4jVgbl04z01IUpj7QuUGu9FcbSWlfjnHxe3qEPtJQRgGXxpcibTVNtHWVv3rnOo
 VhEuhMSWhwQMG61GsR6T6sLADxf++MMqHz9AV9nSKinoTKAVaUB+lxaJW6DE33OHkLGk
 kzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2n2TNPYPU066kE92JQNbBm7Ypw4YV4ofgNfP3dVPw+E=;
 b=epnehyGwnDXyj0sws2UfNPX5SToNdRRo6HtWsHKgIrZv9rQrGOItLL+MGjv1u/ZPVT
 aDNg0HOyu8/jcdLojJIL/gPI0WX+84P9ViOv8hv3lWyax6GAfQfuULlowu9/moDqsQ5w
 OAi0RzUuowaQTS0kUlaOvWN1Ykvb6bz0VIWQ+TkiJOg0c4D3qyL61oHlRd++1WIJO0dF
 SvqjhyeYknQXiqw1soMCOc9EkXL7a5zFubjg//j2JVWrBCUohzT/K4qeCHH5NJe/NKVc
 DFOvaRYNvZAliBsasA6/XRRyrVCNgoNHBGjk5YzEEED+FaXxaBwzTFOs9Phn1PfrCmeL
 WD1A==
X-Gm-Message-State: APjAAAWIZXJtr3HMKERdEp981ZUh+9yZzuS4OmhytWF1QfXuA+r0grJM
 r6bv0J0A/1yzm6uPwOLMjFHE9tuyE2bW6g==
X-Google-Smtp-Source: APXvYqzXL9yyBh5rQ/W7v841l8yeIi+4F8SMNKkf65OSRrIHS04MWNEYde3LBkPQuIV4+DR5j3c1wA==
X-Received: by 2002:a17:902:2889:: with SMTP id
 f9mr23825514plb.230.1560174612354; 
 Mon, 10 Jun 2019 06:50:12 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
 by smtp.gmail.com with ESMTPSA id d4sm13969837pfc.149.2019.06.10.06.50.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:50:11 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 19:18:59 +0530
Message-Id: <20190610134905.22294-7-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610134905.22294-1-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v5 06/12] util/async: add aio interfaces for
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


