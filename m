Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE1AC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6D720936
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DllhcBBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6D720936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIElu-0003LR-L1
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEX5-0000MH-8Y; Tue, 15 Sep 2020 13:14:19 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEX2-0002ml-8R; Tue, 15 Sep 2020 13:14:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id u13so2350067pgh.1;
 Tue, 15 Sep 2020 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D1eG66LWD77lH+Q6AzbFEnvntWYqDrWcfIHAjIFyRnM=;
 b=DllhcBBeBp4NeXwQNYzsq1O0KcLC/SMjkGdsydBopPl/p/YIcsG0VYkzXKNy+uocQM
 5XRGVaGy4QW1yp83tCRD0lcpaARM9RlT6dHs1rPkFox+byWXAKGfqg9liFmiKMyyGl/l
 9+TijINxNYMAVUp/dV2znQ9Lu0AWqqf7yXaoTrtPzFQRHiFHYXLO5CdUg6BWX8DWipVG
 tmWajfPmUFhxapOzlOz54N9eTAuBJ4GDPmmciL7iSzgf+K2T2qlG5ZoOTBBosRCaiWBH
 bDeJKqffqPlrnMpM75NgOj/Ke6FrVlEwxtM7D8StT9pwZKukRrt//YLScMgenaQJ9MhG
 6s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D1eG66LWD77lH+Q6AzbFEnvntWYqDrWcfIHAjIFyRnM=;
 b=cs458MVAa/tGY+NYAE6WplkLpCQCte1gWq5W3bZ9vmuFYFvbU00BouMttl63XCjOO/
 SfQbhUsbMndwkAPoCCEk1vohrb93GvOG8kiM7Eefs8HhjC6El+hDOOM1VKtfnS2HoaQK
 3t8OuDgXICnyC5CC5ssRZEFmQdztbcrWX275ODoUhaKHQ+sv89lwkw8aX20VfCgUbJuk
 zXjbR5qKTLebB/N8Qt3eMubM+YsMiPGj6HondwEQCFOWRBbOkYLu+sF4gyS1TxM9nb7V
 AR6QmF/AHCQe45oxs95vqb/rGL2V255oJUt3SjqI3xJc0QBSACiOdsI7ohwFEwrOKwtn
 xdag==
X-Gm-Message-State: AOAM530wdBoG+lUW57THJNrIhfgzE7tLbEcEnQSs77rZq6Wgv7Tu4v+S
 aH8l3+BFBeuO//IRcHOUMWhBRHIsUZuFYmqxREo=
X-Google-Smtp-Source: ABdhPJxhzDmLlQq9PkzylezSJDeSCoV3VrYUaN+OhZ6hy6B+WVO1U9bEk4k1IeGuONQoJ/lA3eRKKw==
X-Received: by 2002:a63:dd0f:: with SMTP id t15mr15751507pgg.123.1600190053946; 
 Tue, 15 Sep 2020 10:14:13 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 18/26] tests: fixes aio-win32 about aio_remove_fd_handler,
 get it consistence with aio-posix.c
Date: Wed, 16 Sep 2020 01:12:26 +0800
Message-Id: <20200915171234.236-19-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a fixes for
(C:\work\xemu\qemu\build\tests\test-aio-multithread.exe:19100): GLib-CRITICAL **: 23:03:24.965: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed
ERROR test-aio-multithread - Bail out! GLib-FATAL-CRITICAL: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed

(C:\work\xemu\qemu\build\tests\test-bdrv-drain.exe:21036): GLib-CRITICAL **: 23:03:29.861: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed
ERROR test-bdrv-drain - Bail out! GLib-FATAL-CRITICAL: g_source_remove_poll: assertion '!SOURCE_DESTROYED (source)' failed

And the idea comes from https://patchwork.kernel.org/patch/9975239/

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 util/aio-win32.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/util/aio-win32.c b/util/aio-win32.c
index 953c56ab48..49bd90e62e 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -37,6 +37,16 @@ struct AioHandler {
 
 static void aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
 {
+    /*
+     * If the GSource is in the process of being destroyed then
+     * g_source_remove_poll() causes an assertion failure.  Skip
+     * removal in that case, because glib cleans up its state during
+     * destruction anyway.
+     */
+    if (!g_source_is_destroyed(&ctx->source)) {
+        g_source_remove_poll(&ctx->source, &node->pfd);
+    }
+
     /* If aio_poll is in progress, just mark the node as deleted */
     if (qemu_lockcnt_count(&ctx->list_lock)) {
         node->deleted = 1;
@@ -139,8 +149,6 @@ void aio_set_event_notifier(AioContext *ctx,
     /* Are we deleting the fd handler? */
     if (!io_notify) {
         if (node) {
-            g_source_remove_poll(&ctx->source, &node->pfd);
-
             aio_remove_fd_handler(ctx, node);
         }
     } else {
-- 
2.28.0.windows.1


