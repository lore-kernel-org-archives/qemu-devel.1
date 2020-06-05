Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710A9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D1F206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yrmPfvKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D1F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3uS-00010Z-Gq
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nn-0004lI-Gz
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nm-0000mJ-P1
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:55 -0400
Received: by mail-pf1-x443.google.com with SMTP id b16so4295086pfi.13
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=025+D4aoylrwlotsdqqyp7BRSM6nAeDFcADkgg9A3QU=;
 b=yrmPfvKuRo6BzO7M2VRSldilbgVlDVJW2mbTb2+GXbbfhfFQoAOzCcnnmzH0n7yAOW
 Zz+cnubYo3iDBzL23iRDah3EXvsFir0VrQ5lx1TFTsmDxW2ASaGYvUWmBpRc7gqqFQST
 zApQDW2GbFDJRQmT3I+vWP3ANWVKxQh1ChLkVHAwPvGr9jC4JTbYoaIJl1hrZ3cjCA+R
 MbZh7mGPvwM260Yvyoujzp0IsyZ26FxVHyx26R7RyVmdyamE7zqVilLa71KGphCdBzZT
 C+/+80CxBindWcfGxebbTINgLZ8dqdz/wy+0k3aRnkkHiPEu4/PY31vA93YAOJGl/1XS
 meRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=025+D4aoylrwlotsdqqyp7BRSM6nAeDFcADkgg9A3QU=;
 b=MMZnuruYwPBKF9uzbgjXd9vmHW9S8QTq1u4mPwaCh3xiIWX1Yqo/RmE99NE5Xx5Jrj
 d7PXC2Qk4AOvqGTysYfxOBY8ELygUus7K7FREaS674GAhhudOaJzkAEDmUShon8vuROO
 ZOD2O65e5FeapyX4R3qyzoVngL1YSnBRw4MngHwsp9ftGTfcZTU280lCwZeEJ399ivOm
 zxjVPR/37murvl0Lsr59LCHKjqQP76uHtYEXhF3BjQKQ+Z8ULeIlxvkxSTolCvFyOab6
 0KCE1a0qNjZVOblFQ2eHrOqQRqMvctjeynX1JdJGN5DWBZTuZRanniGMmUKFJqoBj1A+
 9nig==
X-Gm-Message-State: AOAM531EYNWIIrRGEktyPb+Ca6LRmq66ojw25mEQmjbnRLKFO7rWPeie
 cH0eSPTFWUDgoP7ZTUs9KXL2EoK+C5s=
X-Google-Smtp-Source: ABdhPJzQFJX5FVFVnGJvPLAH7/XunNJ0vh/wHsOHkegTGR9wLp/FbFRsilSZwIbC6OF49ASvns47Ww==
X-Received: by 2002:a62:c185:: with SMTP id i127mr8023028pfg.132.1591330673199; 
 Thu, 04 Jun 2020 21:17:53 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/17] linux-user/aarch64: Signal SEGV_MTEAERR for async
 tag check error
Date: Thu,  4 Jun 2020 21:17:30 -0700
Message-Id: <20200605041733.415188-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_signal.h |  1 +
 linux-user/aarch64/cpu_loop.c      | 34 +++++++++++++++++++++---------
 target/arm/mte_helper.c            | 10 +++++++++
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 777fb667fe..18013e1b23 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -21,6 +21,7 @@ typedef struct target_sigaltstack {
 
 #include "../generic/signal.h"
 
+#define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 41a68a57bc..1b2f2b4239 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -71,6 +71,21 @@
         put_user_u16(__x, (gaddr));                     \
     })
 
+static bool check_mte_async_fault(CPUARMState *env, target_siginfo_t *info)
+{
+    if (likely(env->cp15.tfsr_el[0] == 0)) {
+        return false;
+    }
+
+    env->cp15.tfsr_el[0] = 0;
+    info->si_signo = TARGET_SIGSEGV;
+    info->si_errno = 0;
+    info->_sifields._sigfault._addr = 0;
+    info->si_code = TARGET_SEGV_MTEAERR;
+    queue_signal(env, info->si_signo, QEMU_SI_FAULT, info);
+    return true;
+}
+
 /* AArch64 main loop */
 void cpu_loop(CPUARMState *env)
 {
@@ -87,15 +102,13 @@ void cpu_loop(CPUARMState *env)
 
         switch (trapnr) {
         case EXCP_SWI:
-            ret = do_syscall(env,
-                             env->xregs[8],
-                             env->xregs[0],
-                             env->xregs[1],
-                             env->xregs[2],
-                             env->xregs[3],
-                             env->xregs[4],
-                             env->xregs[5],
-                             0, 0);
+            if (check_mte_async_fault(env, &info)) {
+                ret = -TARGET_ERESTARTSYS;
+            } else {
+                ret = do_syscall(env, env->xregs[8], env->xregs[0],
+                                 env->xregs[1], env->xregs[2], env->xregs[3],
+                                 env->xregs[4], env->xregs[5], 0, 0);
+            }
             if (ret == -TARGET_ERESTARTSYS) {
                 env->pc -= 4;
             } else if (ret != -TARGET_QEMU_ESIGRETURN) {
@@ -103,7 +116,8 @@ void cpu_loop(CPUARMState *env)
             }
             break;
         case EXCP_INTERRUPT:
-            /* just indicate that signals should be handled asap */
+            /* Just indicate that signals should be handled asap. */
+            check_mte_async_fault(env, &info);
             break;
         case EXCP_UDEF:
             info.si_signo = TARGET_SIGILL;
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index b15fa665df..835b6d1ded 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -542,6 +542,16 @@ static void mte_check_fail(CPUARMState *env, int mmu_idx,
             select = 0;
         }
         env->cp15.tfsr_el[el] |= 1 << select;
+#ifdef CONFIG_USER_ONLY
+        /*
+         * Stand in for a timer irq, setting _TIF_MTE_ASYNC_FAULT,
+         * which then sends a SIGSEGV when the thread is next scheduled.
+         * This cpu will return to the main loop at the end of the TB,
+         * which is rather sooner than "normal".  But the alternative
+         * is waiting until the next syscall.
+         */
+        qemu_cpu_kick(env_cpu(env));
+#endif
         break;
 
     default:
-- 
2.25.1


