Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D03CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25822065D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HukKTbwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25822065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdHw-0007Zd-0A
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEU-0002Bu-Bd
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdES-0005q6-Ao
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id z13so23959360wrw.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/2Na6SuLR2BPH24MTaa9ZH4OY5rPBs3TXnZRAXFwy5s=;
 b=HukKTbwS3xLaKvtwiGlyUulYjK3Nk/fFVapHUciO2MHMhGV7OxoU7hw43GXLEYlOkJ
 SH6EhPYd/uJLh9glIUnMETUJrbvDujT67OU7awC7box+xi7kDkzXVq16Asoug5nCNvMh
 jqbThx1296xqxTV3aUBc7wjAewd5X7tc1PPw3F2tP1VYEE5vjT9e9zFFGItoJRu/x44M
 xN7DkGKbTxHyclA0GROLaPr00E9mpDQO4JU44GfxNKHoer+20QIRnTfUqG9wLgWtkxeR
 h0itNVumENwl9cMVb2WSPFSqjrqAm05uZFhb2dFIUOkuhM1qVjLh6IbnAjTUVqkkGb7y
 gJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/2Na6SuLR2BPH24MTaa9ZH4OY5rPBs3TXnZRAXFwy5s=;
 b=H0nJhKsSM9v1+/JkDJp7MzygKroJcBLk2s9Iw+viAmi824WTxow4puXNSh0WVGEQIn
 1iOEHBbsyWEJXPKZweyyM9LMJieDaPdEw9v2CfTlVO7q7NUb65TxudDibbLpgB+FrFUX
 gBa4lDZH8DrJPOwNl7Xvx37hJj/asPNNbGYVncklie/LDs1Mlwr7tdasUAHnRXEnQYZF
 6+xYmSdf3H4OSx/MNK7wZoBxLeSfb68TBkTRyGq3gVhZ4ZBxg5UsVaF7Prvqs3kHsSLV
 XkY5+LTPv/yl4dGfw5jjsnZvOcfrlADHJt0NONsLdLQJzdSZmd2VL4+8vE0NbVB+v3yI
 MC7A==
X-Gm-Message-State: AOAM533cbDIN4vv7JA0WoiH7qtPSqg9s3f+YFY/3qn08zghmEKL4gENK
 ExgBbuYkpES3YTJUyaUOxz4c/Q==
X-Google-Smtp-Source: ABdhPJzK/fHQ+I0MxFyvBgP9OF2EUl+2nE6RhxzDcOKJuOaYJyT0vpRxtqe2MfgjBDT25IrmkSmMkQ==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr29010137wrq.38.1593611818952; 
 Wed, 01 Jul 2020 06:56:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm7565612wmf.3.2020.07.01.06.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:56:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 37DB41FF90;
 Wed,  1 Jul 2020 14:56:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/40] util/coroutine: Cleanup start_switch_fiber_ for TSAN.
Date: Wed,  1 Jul 2020 14:56:16 +0100
Message-Id: <20200701135652.1366-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

This is a cleanup patch to follow-up the patch which introduced TSAN.
This patch makes separate start_switch_fiber_ functions for TSAN and ASAN.

This does two things:
1. Unrelated ASAN and TSAN code is separate and each function only
   has arguments that are actually needed.
2. The co->tsan_caller_fiber and co->tsan_co_fiber fields are only
   access from within #ifdef CONFIG_TSAN.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200626170001.27017-1-robert.foley@linaro.org>
---
 util/coroutine-ucontext.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index f0b66320e10..fff20aad80a 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -52,8 +52,10 @@ typedef struct {
 #endif
     sigjmp_buf env;
 
+#ifdef CONFIG_TSAN
     void *tsan_co_fiber;
     void *tsan_caller_fiber;
+#endif
 
 #ifdef CONFIG_VALGRIND_H
     unsigned int valgrind_stack_id;
@@ -77,7 +79,10 @@ union cc_arg {
     int i[2];
 };
 
-/* QEMU_ALWAYS_INLINE only does so if __OPTIMIZE__, so we cannot use it. */
+/*
+ * QEMU_ALWAYS_INLINE only does so if __OPTIMIZE__, so we cannot use it.
+ * always_inline is required to avoid TSan runtime fatal errors.
+ */
 static inline __attribute__((always_inline))
 void on_new_fiber(CoroutineUContext *co)
 {
@@ -87,6 +92,7 @@ void on_new_fiber(CoroutineUContext *co)
 #endif
 }
 
+/* always_inline is required to avoid TSan runtime fatal errors. */
 static inline __attribute__((always_inline))
 void finish_switch_fiber(void *fake_stack_save)
 {
@@ -109,18 +115,29 @@ void finish_switch_fiber(void *fake_stack_save)
 #endif
 }
 
-static inline __attribute__((always_inline)) void start_switch_fiber(
-    CoroutineAction action, void **fake_stack_save,
-    const void *bottom, size_t size, void *new_fiber)
+/* always_inline is required to avoid TSan runtime fatal errors. */
+static inline __attribute__((always_inline))
+void start_switch_fiber_asan(CoroutineAction action, void **fake_stack_save,
+                             const void *bottom, size_t size)
 {
 #ifdef CONFIG_ASAN
     __sanitizer_start_switch_fiber(
             action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
             bottom, size);
 #endif
+}
+
+/* always_inline is required to avoid TSan runtime fatal errors. */
+static inline __attribute__((always_inline))
+void start_switch_fiber_tsan(void **fake_stack_save,
+                             CoroutineUContext *co,
+                             bool caller)
+{
 #ifdef CONFIG_TSAN
-    void *curr_fiber =
-        __tsan_get_current_fiber();
+    void *new_fiber = caller ?
+                      co->tsan_caller_fiber :
+                      co->tsan_co_fiber;
+    void *curr_fiber = __tsan_get_current_fiber();
     __tsan_acquire(curr_fiber);
 
     *fake_stack_save = curr_fiber;
@@ -144,12 +161,9 @@ static void coroutine_trampoline(int i0, int i1)
 
     /* Initialize longjmp environment and switch back the caller */
     if (!sigsetjmp(self->env, 0)) {
-        start_switch_fiber(
-            COROUTINE_YIELD,
-            &fake_stack_save,
-            leader.stack,
-            leader.stack_size,
-            self->tsan_caller_fiber);
+        start_switch_fiber_asan(COROUTINE_YIELD, &fake_stack_save, leader.stack,
+                                leader.stack_size);
+        start_switch_fiber_tsan(&fake_stack_save, self, true); /* true=caller */
         siglongjmp(*(sigjmp_buf *)co->entry_arg, 1);
     }
 
@@ -208,10 +222,10 @@ Coroutine *qemu_coroutine_new(void)
 
     /* swapcontext() in, siglongjmp() back out */
     if (!sigsetjmp(old_env, 0)) {
-        start_switch_fiber(
-            COROUTINE_YIELD,
-            &fake_stack_save,
-            co->stack, co->stack_size, co->tsan_co_fiber);
+        start_switch_fiber_asan(COROUTINE_YIELD, &fake_stack_save, co->stack,
+                                co->stack_size);
+        start_switch_fiber_tsan(&fake_stack_save,
+                                co, false); /* false=not caller */
 
 #ifdef CONFIG_SAFESTACK
         /*
@@ -287,8 +301,10 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
 
     ret = sigsetjmp(from->env, 0);
     if (ret == 0) {
-        start_switch_fiber(action, &fake_stack_save,
-                           to->stack, to->stack_size, to->tsan_co_fiber);
+        start_switch_fiber_asan(action, &fake_stack_save, to->stack,
+                                to->stack_size);
+        start_switch_fiber_tsan(&fake_stack_save,
+                                to, false); /* false=not caller */
         siglongjmp(to->env, action);
     }
 
-- 
2.20.1


