Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEB1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA33F204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDJHILnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA33F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jors1-0001iu-2R
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jorrQ-0001IW-74
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:09:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jorrN-00084s-Sw
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:09:55 -0400
Received: by mail-pf1-x443.google.com with SMTP id u5so4904380pfn.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=EvAUDqwpoFqGrtryxitUaLeigBIhi7ip9x0IrHUD61Y=;
 b=zDJHILnwduDcH6RBmJa8r6fjAIUIfHZDu47c5dmFEBPaHEL7sYlAYCdK5d0fbtFL35
 yKDKdzkgrk8r677LgeSTmJdkgfD2QHTaPyFEBWJpQIOhFlLcNkxrSBbY6Fzjxg1vTWFb
 rX0HnsJkuK4XoFvovdSobkY1HifiBWgvX6CCeOrU4GHjmZYOGQATeLEfgWm6db2dg0zT
 oA3TbevuYEvyeUp8Hef0/52zp4sdMg1rwgnRduz9fVc89j4lb+p5TmXTbqVUzUoUnKO8
 esskhyGpHTCu2weNjKnE3dSYztRk2HWRnfSLhHe8HjR7ntA3cVGIn1s/2acXcSHhJZuI
 vLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=EvAUDqwpoFqGrtryxitUaLeigBIhi7ip9x0IrHUD61Y=;
 b=c9MMShb30Z5eeEBFwk6ScGKrfyIA9I9jc94GU0AHI01WHGH5EZeV7ywRJdLhgr+U3T
 v+9v6GVx9/19u0I6s8QD/nTogob6ucuE7fvr7i+xGcNbbRYs+difR4aOdKab7agDANrS
 9PEt4KFUBeHIknLZ+84llFESnfmzVNBuZbC6yXWMm/qp1w88d2WK/h7wp+3+/5z5zyP1
 JevqzkR4x+AVdERdWSIlirm8q1kQuxY0TZcYdUaB8bvWMppF5A4w3yPQ9OZRLqSKlmPO
 Aoi4edZPgKCfUqvI7PUh+rhiQ/g68CUo/APibHaU2b6MxxO1w8JyAol/gwq8y1ZnUuiY
 yW/A==
X-Gm-Message-State: AOAM530k2EDPcGpRlpTVqYj8dZbmH/m3hMI0FW/VSWeRTgIiD4lGhIKO
 8WcIt30P4ZFkS6wyMgYL4BjLmXQ0V+lNAw==
X-Google-Smtp-Source: ABdhPJx1lNkqHIt0Ors+/xf4eTr5kY2vEClMLQ5YEZN6ovjGLI9owQOfPGwKNEgFU1OpCK+YVCHmWA==
X-Received: by 2002:a62:3814:: with SMTP id f20mr3706179pfa.278.1593191391031; 
 Fri, 26 Jun 2020 10:09:51 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:78b5:2b0a:b9c6:c392])
 by smtp.gmail.com with ESMTPSA id f18sm9941430pgv.84.2020.06.26.10.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 10:09:50 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] util/coroutine: Cleanup start_switch_fiber_ for TSAN.
Date: Fri, 26 Jun 2020 13:00:01 -0400
Message-Id: <20200626170001.27017-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, robert.foley@linaro.org, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a cleanup patch to follow-up the patch which introduced TSAN.
This patch makes separate start_switch_fiber_ functions for TSAN and ASAN.

This does two things:
1. Unrelated ASAN and TSAN code is separate and each function only
   has arguments that are actually needed.
2. The co->tsan_caller_fiber and co->tsan_co_fiber fields are only
   access from within #ifdef CONFIG_TSAN.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 util/coroutine-ucontext.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 613f4c118e..bac164d1f1 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -47,8 +47,10 @@ typedef struct {
     size_t stack_size;
     sigjmp_buf env;
 
+#ifdef CONFIG_TSAN
     void *tsan_co_fiber;
     void *tsan_caller_fiber;
+#endif
 
 #ifdef CONFIG_VALGRIND_H
     unsigned int valgrind_stack_id;
@@ -72,7 +74,10 @@ union cc_arg {
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
@@ -82,6 +87,7 @@ void on_new_fiber(CoroutineUContext *co)
 #endif
 }
 
+/* always_inline is required to avoid TSan runtime fatal errors. */
 static inline __attribute__((always_inline))
 void finish_switch_fiber(void *fake_stack_save)
 {
@@ -104,18 +110,29 @@ void finish_switch_fiber(void *fake_stack_save)
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
@@ -139,12 +156,9 @@ static void coroutine_trampoline(int i0, int i1)
 
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
 
@@ -199,10 +213,10 @@ Coroutine *qemu_coroutine_new(void)
 
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
         swapcontext(&old_uc, &uc);
     }
 
@@ -259,8 +273,10 @@ qemu_coroutine_switch(Coroutine *from_, Coroutine *to_,
 
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
2.17.1


