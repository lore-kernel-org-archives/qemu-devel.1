Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04450C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D4E206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeC5bky8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D4E206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwkq-0004eK-S2
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLA-0003pR-EB; Thu, 03 Sep 2020 17:00:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL8-0007Sj-CI; Thu, 03 Sep 2020 17:00:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id h17so3207875otr.1;
 Thu, 03 Sep 2020 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3SuwZW28eAjJ3YWBTzrGv938b6MDi9p5c1iamVmgVTs=;
 b=jeC5bky8i6iuk9jTkRdmcsM7MPX4//PdxWYf0UrMhtLcNDBFofCqLrGeeYfb4nlRd/
 VHWa+QAiJdFXz6V5HnQdM/XHSGbM60QV4Y0f4cp/aLdmGJNovsrgFChTHQ94cpxu+lAS
 qVQJkq/a/LdkKx1JCeoTIME6ovIph3nxrokvtwxnAJhk14wChuuy9PWAur1MHQgHXIWS
 lE6B0o405c9R2j4bVwKKl1WpbSdEchokLpZrbTqyxtW1CK+ecTNu/uZ/EPjVp8DEDE5U
 ixwwwVJLx76lohrOhoKQprWSm0szhlD0Cbiiaii3k43KoIob3oPLU62OZE5oHmx0gpql
 5PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=3SuwZW28eAjJ3YWBTzrGv938b6MDi9p5c1iamVmgVTs=;
 b=i3fMOhjMEHRxjjQ3UQ3RACN7wYpxW7htsmAh9TpeAUUOOsfbojv1E2QKi9G5c4lJa4
 CCSHJpBG+V3ZeDf/xzGAGWzdVuJgLNBVoc4xq0WizMUMIOQ6sl610L5sFI3Dt9WpdC5L
 wIfwXaQp99wyExd00sNU4+lcvlKSdAXaS7EH/hw3BQ0nHx1dDYLhwsFqmJfJ1KhGLptW
 JSygj1pBErPgHsrMIe9UangT7EieQsqx4TGsKsx2eEDTcbVmX9XF8o8IJn7J03/BSB/5
 sd0S0nBai2px98d9VcstrcROvE56Xqjsf90u7R+c32D/E3zruDXFJRWTqrQxn897jEAd
 mc1g==
X-Gm-Message-State: AOAM533ie7ivFLw48qdy8TLoZGz0z/zRX7qeTzHCplUgyvTPFY3ksZIk
 /wjT13c4mVcxmU83yIe3m19RI8zhtnE=
X-Google-Smtp-Source: ABdhPJxlBge35zxuhUGxEOkO3ktrro7su289ePXOBdgPTNUFvl6IpxX3+XvnnjyYTb+P3tex3KfC4g==
X-Received: by 2002:a9d:6c98:: with SMTP id c24mr3097488otr.208.1599166812398; 
 Thu, 03 Sep 2020 14:00:12 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id z17sm836651oop.15.2020.09.03.14.00.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:11 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/77] aio-posix: disable fdmon-io_uring when GSource is used
Date: Thu,  3 Sep 2020 15:58:43 -0500
Message-Id: <20200903205935.27832-26-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The glib event loop does not call fdmon_io_uring_wait() so fd handlers
waiting to be submitted build up in the list. There is no benefit is
using io_uring when the glib GSource is being used, so disable it
instead of implementing a more complex fix.

This fixes a memory leak where AioHandlers would build up and increasing
amounts of CPU time were spent iterating them in aio_pending(). The
symptom is that guests become slow when QEMU is built with io_uring
support.

Buglink: https://bugs.launchpad.net/qemu/+bug/1877716
Fixes: 73fd282e7b6dd4e4ea1c3bbb3d302c8db51e4ccf ("aio-posix: add io_uring fd monitoring implementation")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>
Message-id: 20200511183630.279750-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit ba607ca8bff4d2c2062902f8355657c865ac7c29)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/block/aio.h |  3 +++
 util/aio-posix.c    | 12 ++++++++++++
 util/aio-win32.c    |  4 ++++
 util/async.c        |  1 +
 4 files changed, 20 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index 62ed954344..b2f703fa3f 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -701,6 +701,9 @@ void aio_context_setup(AioContext *ctx);
  */
 void aio_context_destroy(AioContext *ctx);
 
+/* Used internally, do not call outside AioContext code */
+void aio_context_use_g_source(AioContext *ctx);
+
 /**
  * aio_context_set_poll_params:
  * @ctx: the aio context
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 8af334ab19..1b2a3af65b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -682,6 +682,18 @@ void aio_context_destroy(AioContext *ctx)
     aio_free_deleted_handlers(ctx);
 }
 
+void aio_context_use_g_source(AioContext *ctx)
+{
+    /*
+     * Disable io_uring when the glib main loop is used because it doesn't
+     * support mixed glib/aio_poll() usage. It relies on aio_poll() being
+     * called regularly so that changes to the monitored file descriptors are
+     * submitted, otherwise a list of pending fd handlers builds up.
+     */
+    fdmon_io_uring_destroy(ctx);
+    aio_free_deleted_handlers(ctx);
+}
+
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 729d533faf..953c56ab48 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -414,6 +414,10 @@ void aio_context_destroy(AioContext *ctx)
 {
 }
 
+void aio_context_use_g_source(AioContext *ctx)
+{
+}
+
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
                                  int64_t grow, int64_t shrink, Error **errp)
 {
diff --git a/util/async.c b/util/async.c
index 3165a28f2f..1319eee3bc 100644
--- a/util/async.c
+++ b/util/async.c
@@ -362,6 +362,7 @@ static GSourceFuncs aio_source_funcs = {
 
 GSource *aio_get_g_source(AioContext *ctx)
 {
+    aio_context_use_g_source(ctx);
     g_source_ref(&ctx->source);
     return &ctx->source;
 }
-- 
2.17.1


