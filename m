Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E99C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80C921851
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+gCHUtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80C921851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49565 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSMxg-0005Na-Ub
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 10:38:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSMw3-0004SK-KR
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSMw1-0007PC-U9
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSMw1-0007Oq-Lv
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:09 -0400
Received: by mail-pg1-x543.google.com with SMTP id z3so5518136pgp.8
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ybyDFLz2MRq7r1ricvTKZvOGTPrswp1Lb5V9Mn0BeSM=;
	b=y+gCHUtXn5eurHuJ03hdXSYw4cxvWM9unA1qwbx0OXHw1n+I5a6USZObvJ1Cc/NV5V
	7pBeF+pONr0z0/K8u7WzLmIBLGYqkY9vwp8RC+VzHmdoMhywLT0nugG3yX+6vwiFw4wq
	haQyqKxElZYabEU55gwvLMdHb8KmNbPWTsuRhbPDxtM0rv9hr4R64LyqH9lI0/qxatmh
	+V4H/IxcOOeOEDNmsXZyq+vKvHwSLsAaulOKtbeIRhOMi2clbNb0HnMt608L3xfTB1iZ
	cBsHq5fA+5Yuev1Ic+FXw74WvSeJj+TsmV+Jy0KllMqqlXAsxgjLvdjKBTYo/jGDsaw7
	eSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ybyDFLz2MRq7r1ricvTKZvOGTPrswp1Lb5V9Mn0BeSM=;
	b=QSmK5R8rC/TaV/8/BIa0HIOrx/Be+ttktbUF46ykO2OTy6BQdadvrifvGSxeYJ2opv
	1A+vfvvcX1woH5vtmCFFP1klcmFad1l8a+cMGNJ4BDcDSNlP08cUXZqEe4uttPjdRsiz
	scBXQ8BqsIZXhEcrYwfAssBAFiKkZMIm7v0hujQMAgz+hpDK7YQ9t9MwSEP5XDpcOwcv
	piouUBo7Oj6IbhFpXj8cZKlmdKIe/sp5fBap3mN5jE4O95T5dOQEVwn44lw54mdiI7xq
	zYL3NLJs+/JM6VY2gdPgBWRiujQJ0xtPu8yxbH73mQa9S+/KYsMbpr5C3xoUJzeiuTIq
	HJ7A==
X-Gm-Message-State: APjAAAVTug6xJ7e2G16kwhoXB3fJSwigDBcG6p4SmVceKlskv8zfNUiq
	N5pn+Js4wbqXwele7EGm7dc93F2PEQA=
X-Google-Smtp-Source: APXvYqy10LaEv2JYLM7hFOWx4BKc9BNgvq2CNrWc2dSBmorcE/7rrHod9iJ1rBi8OaGZQxQ8m/av0w==
X-Received: by 2002:a63:9a52:: with SMTP id e18mr69873228pgo.335.1558276628273;
	Sun, 19 May 2019 07:37:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	184sm18248195pfa.48.2019.05.19.07.37.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 07:37:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 07:37:02 -0700
Message-Id: <20190519143702.5587-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519143702.5587-1-richard.henderson@linaro.org>
References: <20190519143702.5587-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PULL 2/2] target/alpha: Fix user-only floating-point
 exceptions
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Record the software fp control register, as set by the
osf_setsysinfo syscall.  Add those masked exceptions
to fpcr_exc_enable.  Do not raise a signal for masked
fp exceptions.

Fixes: https://bugs.launchpad.net/bugs/1701835
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h |   3 +-
 target/alpha/cpu.h        |  42 +++++++++++++++
 linux-user/syscall.c      | 104 ++++++++++++++++++--------------------
 target/alpha/fpu_helper.c |  21 ++++++--
 target/alpha/helper.c     |  20 +++++++-
 5 files changed, 130 insertions(+), 60 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 12c8407144..1f5b2d18db 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -635,7 +635,8 @@ typedef struct target_siginfo {
 #define TARGET_FPE_FLTRES      (6)  /* floating point inexact result */
 #define TARGET_FPE_FLTINV      (7)  /* floating point invalid operation */
 #define TARGET_FPE_FLTSUB      (8)  /* subscript out of range */
-#define TARGET_NSIGFPE         8
+#define TARGET_FPE_FLTUNK      (14) /* undiagnosed fp exception */
+#define TARGET_NSIGFPE         15
 
 /*
  * SIGSEGV si_codes
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index cf09112b6a..ba6bc31b15 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -198,6 +198,8 @@ enum {
 #define SWCR_STATUS_DNO         (1U << 22)
 #define SWCR_STATUS_MASK        ((1U << 23) - (1U << 17))
 
+#define SWCR_STATUS_TO_EXCSUM_SHIFT  16
+
 #define SWCR_MASK  (SWCR_TRAP_ENABLE_MASK | SWCR_MAP_MASK | SWCR_STATUS_MASK)
 
 /* MMU modes definitions */
@@ -235,6 +237,9 @@ struct CPUAlphaState {
 
     /* The FPCR, and disassembled portions thereof.  */
     uint32_t fpcr;
+#ifdef CONFIG_USER_ONLY
+    uint32_t swcr;
+#endif
     uint32_t fpcr_exc_enable;
     float_status fp_status;
     uint8_t fpcr_dyn_round;
@@ -501,4 +506,41 @@ static inline void cpu_get_tb_cpu_state(CPUAlphaState *env, target_ulong *pc,
     *pflags = env->flags & ENV_FLAG_TB_MASK;
 }
 
+#ifdef CONFIG_USER_ONLY
+/* Copied from linux ieee_swcr_to_fpcr.  */
+static inline uint64_t alpha_ieee_swcr_to_fpcr(uint64_t swcr)
+{
+    uint64_t fpcr = 0;
+
+    fpcr |= (swcr & SWCR_STATUS_MASK) << 35;
+    fpcr |= (swcr & SWCR_MAP_DMZ) << 36;
+    fpcr |= (~swcr & (SWCR_TRAP_ENABLE_INV
+                      | SWCR_TRAP_ENABLE_DZE
+                      | SWCR_TRAP_ENABLE_OVF)) << 48;
+    fpcr |= (~swcr & (SWCR_TRAP_ENABLE_UNF
+                      | SWCR_TRAP_ENABLE_INE)) << 57;
+    fpcr |= (swcr & SWCR_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
+    fpcr |= (~swcr & SWCR_TRAP_ENABLE_DNO) << 41;
+
+    return fpcr;
+}
+
+/* Copied from linux ieee_fpcr_to_swcr.  */
+static inline uint64_t alpha_ieee_fpcr_to_swcr(uint64_t fpcr)
+{
+    uint64_t swcr = 0;
+
+    swcr |= (fpcr >> 35) & SWCR_STATUS_MASK;
+    swcr |= (fpcr >> 36) & SWCR_MAP_DMZ;
+    swcr |= (~fpcr >> 48) & (SWCR_TRAP_ENABLE_INV
+                             | SWCR_TRAP_ENABLE_DZE
+                             | SWCR_TRAP_ENABLE_OVF);
+    swcr |= (~fpcr >> 57) & (SWCR_TRAP_ENABLE_UNF | SWCR_TRAP_ENABLE_INE);
+    swcr |= (fpcr >> 47) & SWCR_MAP_UMZ;
+    swcr |= (~fpcr >> 41) & SWCR_TRAP_ENABLE_DNO;
+
+    return swcr;
+}
+#endif /* CONFIG_USER_ONLY */
+
 #endif /* ALPHA_CPU_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f5ff6f5dc8..efa3ec2837 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10223,18 +10223,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         switch (arg1) {
           case TARGET_GSI_IEEE_FP_CONTROL:
             {
-                uint64_t swcr, fpcr = cpu_alpha_load_fpcr (cpu_env);
+                uint64_t fpcr = cpu_alpha_load_fpcr(cpu_env);
+                uint64_t swcr = ((CPUAlphaState *)cpu_env)->swcr;
 
-                /* Copied from linux ieee_fpcr_to_swcr.  */
-                swcr = (fpcr >> 35) & SWCR_STATUS_MASK;
-                swcr |= (fpcr >> 36) & SWCR_MAP_DMZ;
-                swcr |= (~fpcr >> 48) & (SWCR_TRAP_ENABLE_INV
-                                        | SWCR_TRAP_ENABLE_DZE
-                                        | SWCR_TRAP_ENABLE_OVF);
-                swcr |= (~fpcr >> 57) & (SWCR_TRAP_ENABLE_UNF
-                                        | SWCR_TRAP_ENABLE_INE);
-                swcr |= (fpcr >> 47) & SWCR_MAP_UMZ;
-                swcr |= (~fpcr >> 41) & SWCR_TRAP_ENABLE_DNO;
+                swcr &= ~SWCR_STATUS_MASK;
+                swcr |= (fpcr >> 35) & SWCR_STATUS_MASK;
 
                 if (put_user_u64 (swcr, arg2))
                         return -TARGET_EFAULT;
@@ -10261,25 +10254,24 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         switch (arg1) {
           case TARGET_SSI_IEEE_FP_CONTROL:
             {
-                uint64_t swcr, fpcr, orig_fpcr;
+                uint64_t swcr, fpcr;
 
                 if (get_user_u64 (swcr, arg2)) {
                     return -TARGET_EFAULT;
                 }
-                orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
-                fpcr = orig_fpcr & FPCR_DYN_MASK;
 
-                /* Copied from linux ieee_swcr_to_fpcr.  */
-                fpcr |= (swcr & SWCR_STATUS_MASK) << 35;
-                fpcr |= (swcr & SWCR_MAP_DMZ) << 36;
-                fpcr |= (~swcr & (SWCR_TRAP_ENABLE_INV
-                                  | SWCR_TRAP_ENABLE_DZE
-                                  | SWCR_TRAP_ENABLE_OVF)) << 48;
-                fpcr |= (~swcr & (SWCR_TRAP_ENABLE_UNF
-                                  | SWCR_TRAP_ENABLE_INE)) << 57;
-                fpcr |= (swcr & SWCR_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
-                fpcr |= (~swcr & SWCR_TRAP_ENABLE_DNO) << 41;
+                /*
+                 * The kernel calls swcr_update_status to update the
+                 * status bits from the fpcr at every point that it
+                 * could be queried.  Therefore, we store the status
+                 * bits only in FPCR.
+                 */
+                ((CPUAlphaState *)cpu_env)->swcr
+                    = swcr & (SWCR_TRAP_ENABLE_MASK | SWCR_MAP_MASK);
 
+                fpcr = cpu_alpha_load_fpcr(cpu_env);
+                fpcr &= ((uint64_t)FPCR_DYN_MASK << 32);
+                fpcr |= alpha_ieee_swcr_to_fpcr(swcr);
                 cpu_alpha_store_fpcr(cpu_env, fpcr);
                 ret = 0;
             }
@@ -10287,44 +10279,47 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
           case TARGET_SSI_IEEE_RAISE_EXCEPTION:
             {
-                uint64_t exc, fpcr, orig_fpcr;
-                int si_code;
+                uint64_t exc, fpcr, fex;
 
                 if (get_user_u64(exc, arg2)) {
                     return -TARGET_EFAULT;
                 }
-
-                orig_fpcr = cpu_alpha_load_fpcr(cpu_env);
-
-                /* We only add to the exception status here.  */
-                fpcr = orig_fpcr | ((exc & SWCR_STATUS_MASK) << 35);
-
-                cpu_alpha_store_fpcr(cpu_env, fpcr);
-                ret = 0;
+                exc &= SWCR_STATUS_MASK;
+                fpcr = cpu_alpha_load_fpcr(cpu_env);
 
                 /* Old exceptions are not signaled.  */
-                fpcr &= ~(orig_fpcr & FPCR_STATUS_MASK);
+                fex = alpha_ieee_fpcr_to_swcr(fpcr);
+                fex = exc & ~fex;
+                fex >>= SWCR_STATUS_TO_EXCSUM_SHIFT;
+                fex &= ((CPUArchState *)cpu_env)->swcr;
 
-                /* If any exceptions set by this call,
-                   and are unmasked, send a signal.  */
-                si_code = 0;
-                if ((fpcr & (FPCR_INE | FPCR_INED)) == FPCR_INE) {
-                    si_code = TARGET_FPE_FLTRES;
-                }
-                if ((fpcr & (FPCR_UNF | FPCR_UNFD)) == FPCR_UNF) {
-                    si_code = TARGET_FPE_FLTUND;
-                }
-                if ((fpcr & (FPCR_OVF | FPCR_OVFD)) == FPCR_OVF) {
-                    si_code = TARGET_FPE_FLTOVF;
-                }
-                if ((fpcr & (FPCR_DZE | FPCR_DZED)) == FPCR_DZE) {
-                    si_code = TARGET_FPE_FLTDIV;
-                }
-                if ((fpcr & (FPCR_INV | FPCR_INVD)) == FPCR_INV) {
-                    si_code = TARGET_FPE_FLTINV;
-                }
-                if (si_code != 0) {
+                /* Update the hardware fpcr.  */
+                fpcr |= alpha_ieee_swcr_to_fpcr(exc);
+                cpu_alpha_store_fpcr(cpu_env, fpcr);
+
+                if (fex) {
+                    int si_code = TARGET_FPE_FLTUNK;
                     target_siginfo_t info;
+
+                    if (fex & SWCR_TRAP_ENABLE_DNO) {
+                        si_code = TARGET_FPE_FLTUND;
+                    }
+                    if (fex & SWCR_TRAP_ENABLE_INE) {
+                        si_code = TARGET_FPE_FLTRES;
+                    }
+                    if (fex & SWCR_TRAP_ENABLE_UNF) {
+                        si_code = TARGET_FPE_FLTUND;
+                    }
+                    if (fex & SWCR_TRAP_ENABLE_OVF) {
+                        si_code = TARGET_FPE_FLTOVF;
+                    }
+                    if (fex & SWCR_TRAP_ENABLE_DZE) {
+                        si_code = TARGET_FPE_FLTDIV;
+                    }
+                    if (fex & SWCR_TRAP_ENABLE_INV) {
+                        si_code = TARGET_FPE_FLTINV;
+                    }
+
                     info.si_signo = SIGFPE;
                     info.si_errno = 0;
                     info.si_code = si_code;
@@ -10333,6 +10328,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                     queue_signal((CPUArchState *)cpu_env, info.si_signo,
                                  QEMU_SI_FAULT, &info);
                 }
+                ret = 0;
             }
             break;
 
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 9645978aaa..62a066d902 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -91,10 +91,25 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint32_t ignore, uint32_t regno)
     if (exc) {
         env->fpcr |= exc;
         exc &= ~ignore;
-        if (exc) {
-            exc &= env->fpcr_exc_enable;
-            fp_exc_raise1(env, GETPC(), exc, regno, EXC_M_SWC);
+#ifdef CONFIG_USER_ONLY
+        /*
+         * In user mode, the kernel's software handler only
+         * delivers a signal if the exception is enabled.
+         */
+        if (!(exc & env->fpcr_exc_enable)) {
+            return;
         }
+#else
+        /*
+         * In system mode, the software handler gets invoked
+         * for any non-ignored exception.
+         */
+        if (!exc) {
+            return;
+        }
+#endif
+        exc &= env->fpcr_exc_enable;
+        fp_exc_raise1(env, GETPC(), exc, regno, EXC_M_SWC);
     }
 }
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 74a62c3d7b..2134ee1e9d 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -29,12 +29,12 @@
 #define CONVERT_BIT(X, SRC, DST) \
     (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
 
-uint64_t cpu_alpha_load_fpcr (CPUAlphaState *env)
+uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
 {
     return (uint64_t)env->fpcr << 32;
 }
 
-void cpu_alpha_store_fpcr (CPUAlphaState *env, uint64_t val)
+void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
 {
     uint32_t fpcr = val >> 32;
     uint32_t t = 0;
@@ -67,6 +67,22 @@ void cpu_alpha_store_fpcr (CPUAlphaState *env, uint64_t val)
 
     env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
+
+#ifdef CONFIG_USER_ONLY
+    /*
+     * Override some of these bits with the contents of ENV->SWCR.
+     * In system mode, some of these would trap to the kernel, at
+     * which point the kernel's handler would emulate and apply
+     * the software exception mask.
+     */
+    if (env->swcr & SWCR_MAP_DMZ) {
+        env->fp_status.flush_inputs_to_zero = 1;
+    }
+    if (env->swcr & SWCR_MAP_UMZ) {
+        env->fp_status.flush_to_zero = 1;
+    }
+    env->fpcr_exc_enable &= ~(alpha_ieee_swcr_to_fpcr(env->swcr) >> 32);
+#endif
 }
 
 uint64_t helper_load_fpcr(CPUAlphaState *env)
-- 
2.17.1


