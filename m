Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7C9C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FB3206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6RMTsJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FB3206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7WF-0004fh-NL
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Ph-0007IH-Rr
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Pg-0007uc-SO
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:13 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7Pg-0007tm-Ml; Mon, 29 Jul 2019 11:18:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id k8so27651854plt.3;
 Mon, 29 Jul 2019 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eFjnzxuAegStXPBjOt40eXvFDqL2hXLnGuTLIfY9ow8=;
 b=d6RMTsJJ4Li8LDNoKvGFSMtne3nJ0koJtocDNJnZ2J3vbIUfSw606EmNQqRnEpgGJD
 uqkxp3t3jHljdFhXQJniNrTgEQCB+QbYkmmL2sLqmIWeU0vRXLQEuKj2ftgqL3wCep1v
 g8O/kOr5Bszn1c/7CLRJK3xabl5tYnY4mxrD78cV46wRIgypjg34vrliphvxAcnWWWUZ
 HwpdZ9j32Um3jwWeYZByxJB9PY2Z7q3ZUolugwk2eqVLxIQKQW1QRS7QJM1pdB3reqyI
 K+C6oOqIKwrokEnMF9gFgfcSDre38dCGQmIWtSyAiH4MBXn9Okss1Hgeh6Fn1SvruvlQ
 LZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eFjnzxuAegStXPBjOt40eXvFDqL2hXLnGuTLIfY9ow8=;
 b=Qg0aHEerdhJ8VAoaEfTZ6DhDunBqfwvVT4p4A7S77IMfFDlE77xfLlIRLdIhvgvfpe
 Cx1zRBxrlWJjF66wOgBLVpqyJSGV/wQIwQFV2tL3+TSDxOi6GtBFaXFtdCB0ROsGG5qX
 au8SnzXR6R2z+Jj5YAWfLixahAd3nAZL+ojAYCmxyrIDsAv0NcUSjOPxPiY7LDkuvBVU
 zI7/dVNYt8YGGnLG36TpbroXRPbvsw4WeQAUm2vFb16aABESG+uT42cXfAMbYwuH1ziu
 lDSRvyePICNanVajq5a+2A31bI30kGJoPjdms1rBk7Q+UdtgQHsB+u490IXTg55X5Iky
 OYBg==
X-Gm-Message-State: APjAAAXY7PS7OYC0EU/uKjniAc2yQUcIP5pZLcUG8QlDRNb+4CSi74cJ
 wAqKh1QwAkWB2d4Ef0rcfulfj6Cdxbiu2Q==
X-Google-Smtp-Source: APXvYqyKXJh7+q9Ef37oHVYiL20DRfITfHp4vA41XF4qUEhpwBqoWmUdRxweZPRzao1vOg/CF7pXBA==
X-Received: by 2002:a17:902:e4:: with SMTP id
 a91mr14164357pla.150.1564413491384; 
 Mon, 29 Jul 2019 08:18:11 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.18.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:18:10 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:42 +0530
Message-Id: <20190729151651.21306-7-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v7 06/15] util/async: add aio interfaces for
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
index 8d2105729c..2e0a5e20ac 100644
--- a/util/async.c
+++ b/util/async.c
@@ -276,6 +276,14 @@ aio_ctx_finalize(GSource     *source)
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
 
@@ -340,6 +348,29 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
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
@@ -431,6 +462,11 @@ AioContext *aio_context_new(Error **errp)
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
2.21.0


