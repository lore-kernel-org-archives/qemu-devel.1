Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F57C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3064F20B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZTdz0qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3064F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi49d-0004b6-AB
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:48:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46314)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3GC-0002sL-Fy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3G5-0002ZC-5d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:50:46 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:34262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3G2-0002Y0-O8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:50:40 -0400
Received: by mail-wr1-f46.google.com with SMTP id u18so7118674wru.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EwpRBNeUrGyzlCkkPaR10FtxiEGV5Xvub4EowqMp0/c=;
 b=UZTdz0qgfUu0a2r5cnT4GQ/uoB9D5I2VurOppwjO+LrjKSx1qYTAqz3UygnVi6AGnS
 xJQipK1QFo1yblDX9YOElKegQ1gskvDGj5ViQZrIL/WaXPzaFzTvXZ46HWcVqRcHIoiM
 sSTxt5pXT1iBtBhzu3LD8Fgh7taGfOu5jprzFGlBtbxUkiu1Zxl188yyVh8jb2b+K8qs
 eo4IIuJ5lBHF0QdBG+KVf3bitZg3OExW7vh/kGORM9Wr3JSX77bBBM6J2wWuFEI4kQN1
 Db9kujupu4ivk5GezXeVvzmWn/0ee2WMCViD3LqFylxJRjosskBkDDllFMHe7JIvYUOs
 hTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EwpRBNeUrGyzlCkkPaR10FtxiEGV5Xvub4EowqMp0/c=;
 b=lnXqzSObH0UzAWAM/P/SrIp+h/lF7Cd9SlLZCzT0CS+rd+FxYBaeVnmwGz+bRA82f7
 wlfwRkN5327huoFViql7KUepI6nmc3IU/j69ricwXtzE7yeZcixYlCv10atAANCJ1Zfd
 toeOiwuZE2f7i+3YtMHYJChO1BK82Y5897gyQXwgigoKJX6GIkBk/luytRx64BMwak6g
 2PnmtHO72Kxm+jXNzW5AKAdVg4GVI7mpgZgPXzAjNgGEXuP3j3LsEWsf6p8orwATHyRd
 Etp65KmWmR/mCPqJPmInf8dElygB5yz9QCXPWwQ/BPs5dbQms+I/ro8oBUWNf6fTIqHl
 dxYg==
X-Gm-Message-State: APjAAAXdLlP5u8omMjhqTwSXD0oUaj0E7ie90OUC0TRrSfCX5asCtTYF
 WyeUbrUYBp9g5KVqmHHCftpT7A358OeGag==
X-Google-Smtp-Source: APXvYqwxWCRaYv42GOwxZX6sP0W6vUJEfKFHw3zV3T7cwnwpQ2KoySz0HaHwUCdSv3TtCJc08nZo0A==
X-Received: by 2002:a5d:6583:: with SMTP id q3mr21504891wru.184.1561999223589; 
 Mon, 01 Jul 2019 09:40:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:31 +0100
Message-Id: <20190701163943.22313-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.46
Subject: [Qemu-devel] [PULL 34/46] target/arm: Fix multiline comment syntax
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit 8c06fbdf36b checkpatch.pl enforce a new multiline
comment syntax. Since we'll move this code around, fix its style
first.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-8-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c     | 237 ++++++++++++++++++++++++++--------------
 target/arm/op_helper.c  |  54 ++++++---
 target/arm/vfp_helper.c |   3 +-
 3 files changed, 196 insertions(+), 98 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ca4d4a57bff..c77ed852155 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7529,7 +7529,8 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
 
 uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 {
-    /* The TT instructions can be used by unprivileged code, but in
+    /*
+     * The TT instructions can be used by unprivileged code, but in
      * user-only emulation we don't have the MPU.
      * Luckily since we know we are NonSecure unprivileged (and that in
      * turn means that the A flag wasn't specified), all the bits in the
@@ -7801,7 +7802,8 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
     return true;
 
 pend_fault:
-    /* By pending the exception at this point we are making
+    /*
+     * By pending the exception at this point we are making
      * the IMPDEF choice "overridden exceptions pended" (see the
      * MergeExcInfo() pseudocode). The other choice would be to not
      * pend them now and then make a choice about which to throw away
@@ -7876,7 +7878,8 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
     return true;
 
 pend_fault:
-    /* By pending the exception at this point we are making
+    /*
+     * By pending the exception at this point we are making
      * the IMPDEF choice "overridden exceptions pended" (see the
      * MergeExcInfo() pseudocode). The other choice would be to not
      * pend them now and then make a choice about which to throw away
@@ -7977,7 +7980,8 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
      */
 }
 
-/* Write to v7M CONTROL.SPSEL bit for the specified security bank.
+/*
+ * Write to v7M CONTROL.SPSEL bit for the specified security bank.
  * This may change the current stack pointer between Main and Process
  * stack pointers if it is done for the CONTROL register for the current
  * security state.
@@ -8005,7 +8009,8 @@ static void write_v7m_control_spsel_for_secstate(CPUARMState *env,
     }
 }
 
-/* Write to v7M CONTROL.SPSEL bit. This may change the current
+/*
+ * Write to v7M CONTROL.SPSEL bit. This may change the current
  * stack pointer between Main and Process stack pointers.
  */
 static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
@@ -8015,7 +8020,8 @@ static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
 
 void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
 {
-    /* Write a new value to v7m.exception, thus transitioning into or out
+    /*
+     * Write a new value to v7m.exception, thus transitioning into or out
      * of Handler mode; this may result in a change of active stack pointer.
      */
     bool new_is_psp, old_is_psp = v7m_using_psp(env);
@@ -8041,7 +8047,8 @@ static void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
         return;
     }
 
-    /* All the banked state is accessed by looking at env->v7m.secure
+    /*
+     * All the banked state is accessed by looking at env->v7m.secure
      * except for the stack pointer; rearrange the SP appropriately.
      */
     new_ss_msp = env->v7m.other_ss_msp;
@@ -8068,7 +8075,8 @@ static void switch_v7m_security_state(CPUARMState *env, bool new_secstate)
 
 void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
 {
-    /* Handle v7M BXNS:
+    /*
+     * Handle v7M BXNS:
      *  - if the return value is a magic value, do exception return (like BX)
      *  - otherwise bit 0 of the return value is the target security state
      */
@@ -8083,7 +8091,8 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
     }
 
     if (dest >= min_magic) {
-        /* This is an exception return magic value; put it where
+        /*
+         * This is an exception return magic value; put it where
          * do_v7m_exception_exit() expects and raise EXCEPTION_EXIT.
          * Note that if we ever add gen_ss_advance() singlestep support to
          * M profile this should count as an "instruction execution complete"
@@ -8108,7 +8117,8 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
 
 void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
 {
-    /* Handle v7M BLXNS:
+    /*
+     * Handle v7M BLXNS:
      *  - bit 0 of the destination address is the target security state
      */
 
@@ -8121,7 +8131,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     assert(env->v7m.secure);
 
     if (dest & 1) {
-        /* target is Secure, so this is just a normal BLX,
+        /*
+         * Target is Secure, so this is just a normal BLX,
          * except that the low bit doesn't indicate Thumb/not.
          */
         env->regs[14] = nextinst;
@@ -8152,7 +8163,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     env->regs[13] = sp;
     env->regs[14] = 0xfeffffff;
     if (arm_v7m_is_handler_mode(env)) {
-        /* Write a dummy value to IPSR, to avoid leaking the current secure
+        /*
+         * Write a dummy value to IPSR, to avoid leaking the current secure
          * exception number to non-secure code. This is guaranteed not
          * to cause write_v7m_exception() to actually change stacks.
          */
@@ -8167,7 +8179,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
 static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool threadmode,
                                 bool spsel)
 {
-    /* Return a pointer to the location where we currently store the
+    /*
+     * Return a pointer to the location where we currently store the
      * stack pointer for the requested security state and thread mode.
      * This pointer will become invalid if the CPU state is updated
      * such that the stack pointers are switched around (eg changing
@@ -8213,7 +8226,8 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
 
     mmu_idx = arm_v7m_mmu_idx_for_secstate_and_priv(env, targets_secure, true);
 
-    /* We don't do a get_phys_addr() here because the rules for vector
+    /*
+     * We don't do a get_phys_addr() here because the rules for vector
      * loads are special: they always use the default memory map, and
      * the default memory map permits reads from all addresses.
      * Since there's no easy way to pass through to pmsav8_mpu_lookup()
@@ -8244,7 +8258,8 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int exc, bool targets_secure,
     return true;
 
 load_fail:
-    /* All vector table fetch fails are reported as HardFault, with
+    /*
+     * All vector table fetch fails are reported as HardFault, with
      * HFSR.VECTTBL and .FORCED set. (FORCED is set because
      * technically the underlying exception is a MemManage or BusFault
      * that is escalated to HardFault.) This is a terminal exception,
@@ -8276,7 +8291,8 @@ static uint32_t v7m_integrity_sig(CPUARMState *env, uint32_t lr)
 static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                                   bool ignore_faults)
 {
-    /* For v8M, push the callee-saves register part of the stack frame.
+    /*
+     * For v8M, push the callee-saves register part of the stack frame.
      * Compare the v8M pseudocode PushCalleeStack().
      * In the tailchaining case this may not be the current stack.
      */
@@ -8327,7 +8343,8 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
         return true;
     }
 
-    /* Write as much of the stack frame as we can. A write failure may
+    /*
+     * Write as much of the stack frame as we can. A write failure may
      * cause us to pend a derived exception.
      */
     sig = v7m_integrity_sig(env, lr);
@@ -8351,7 +8368,8 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailchain,
 static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                                 bool ignore_stackfaults)
 {
-    /* Do the "take the exception" parts of exception entry,
+    /*
+     * Do the "take the exception" parts of exception entry,
      * but not the pushing of state to the stack. This is
      * similar to the pseudocode ExceptionTaken() function.
      */
@@ -8376,13 +8394,15 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
             (lr & R_V7M_EXCRET_S_MASK)) {
-            /* The background code (the owner of the registers in the
+            /*
+             * The background code (the owner of the registers in the
              * exception frame) is Secure. This means it may either already
              * have or now needs to push callee-saves registers.
              */
             if (targets_secure) {
                 if (dotailchain && !(lr & R_V7M_EXCRET_ES_MASK)) {
-                    /* We took an exception from Secure to NonSecure
+                    /*
+                     * We took an exception from Secure to NonSecure
                      * (which means the callee-saved registers got stacked)
                      * and are now tailchaining to a Secure exception.
                      * Clear DCRS so eventual return from this Secure
@@ -8391,7 +8411,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
                     lr &= ~R_V7M_EXCRET_DCRS_MASK;
                 }
             } else {
-                /* We're going to a non-secure exception; push the
+                /*
+                 * We're going to a non-secure exception; push the
                  * callee-saves registers to the stack now, if they're
                  * not already saved.
                  */
@@ -8413,14 +8434,16 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
             lr |= R_V7M_EXCRET_SPSEL_MASK;
         }
 
-        /* Clear registers if necessary to prevent non-secure exception
+        /*
+         * Clear registers if necessary to prevent non-secure exception
          * code being able to see register values from secure code.
          * Where register values become architecturally UNKNOWN we leave
          * them with their previous values.
          */
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             if (!targets_secure) {
-                /* Always clear the caller-saved registers (they have been
+                /*
+                 * Always clear the caller-saved registers (they have been
                  * pushed to the stack earlier in v7m_push_stack()).
                  * Clear callee-saved registers if the background code is
                  * Secure (in which case these regs were saved in
@@ -8441,7 +8464,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     }
 
     if (push_failed && !ignore_stackfaults) {
-        /* Derived exception on callee-saves register stacking:
+        /*
+         * Derived exception on callee-saves register stacking:
          * we might now want to take a different exception which
          * targets a different security state, so try again from the top.
          */
@@ -8458,7 +8482,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
         return;
     }
 
-    /* Now we've done everything that might cause a derived exception
+    /*
+     * Now we've done everything that might cause a derived exception
      * we can go ahead and activate whichever exception we're going to
      * take (which might now be the derived exception).
      */
@@ -8661,7 +8686,8 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
 
 static bool v7m_push_stack(ARMCPU *cpu)
 {
-    /* Do the "set up stack frame" part of exception entry,
+    /*
+     * Do the "set up stack frame" part of exception entry,
      * similar to pseudocode PushStack().
      * Return true if we generate a derived exception (and so
      * should ignore further stack faults trying to process
@@ -8729,7 +8755,8 @@ static bool v7m_push_stack(ARMCPU *cpu)
         }
     }
 
-    /* Write as much of the stack frame as we can. If we fail a stack
+    /*
+     * Write as much of the stack frame as we can. If we fail a stack
      * write this will result in a derived exception being pended
      * (which may be taken in preference to the one we started with
      * if it has higher priority).
@@ -8846,7 +8873,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool ftype;
     bool restore_s16_s31;
 
-    /* If we're not in Handler mode then jumps to magic exception-exit
+    /*
+     * If we're not in Handler mode then jumps to magic exception-exit
      * addresses don't have magic behaviour. However for the v8M
      * security extensions the magic secure-function-return has to
      * work in thread mode too, so to avoid doing an extra check in
@@ -8860,7 +8888,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         return;
     }
 
-    /* In the spec pseudocode ExceptionReturn() is called directly
+    /*
+     * In the spec pseudocode ExceptionReturn() is called directly
      * from BXWritePC() and gets the full target PC value including
      * bit zero. In QEMU's implementation we treat it as a normal
      * jump-to-register (which is then caught later on), and so split
@@ -8893,7 +8922,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
 
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-        /* EXC_RETURN.ES validation check (R_SMFL). We must do this before
+        /*
+         * EXC_RETURN.ES validation check (R_SMFL). We must do this before
          * we pick which FAULTMASK to clear.
          */
         if (!env->v7m.secure &&
@@ -8907,7 +8937,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
 
     if (env->v7m.exception != ARMV7M_EXCP_NMI) {
-        /* Auto-clear FAULTMASK on return from other than NMI.
+        /*
+         * Auto-clear FAULTMASK on return from other than NMI.
          * If the security extension is implemented then this only
          * happens if the raw execution priority is >= 0; the
          * value of the ES bit in the exception return value indicates
@@ -8932,7 +8963,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         /* still an irq active now */
         break;
     case 1:
-        /* we returned to base exception level, no nesting.
+        /*
+         * We returned to base exception level, no nesting.
          * (In the pseudocode this is written using "NestedActivation != 1"
          * where we have 'rettobase == false'.)
          */
@@ -8949,7 +8981,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (!arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-            /* UNPREDICTABLE if S == 1 or DCRS == 0 or ES == 1 (R_XLCP);
+            /*
+             * UNPREDICTABLE if S == 1 or DCRS == 0 or ES == 1 (R_XLCP);
              * we choose to take the UsageFault.
              */
             if ((excret & R_V7M_EXCRET_S_MASK) ||
@@ -8968,7 +9001,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             break;
         case 13: /* Return to Thread using Process stack */
         case 9: /* Return to Thread using Main stack */
-            /* We only need to check NONBASETHRDENA for v7M, because in
+            /*
+             * We only need to check NONBASETHRDENA for v7M, because in
              * v8M this bit does not exist (it is RES1).
              */
             if (!rettobase &&
@@ -9026,7 +9060,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
 
     if (ufault) {
-        /* Bad exception return: instead of popping the exception
+        /*
+         * Bad exception return: instead of popping the exception
          * stack, directly take a usage fault on the current stack.
          */
         env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
@@ -9056,7 +9091,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     switch_v7m_security_state(env, return_to_secure);
 
     {
-        /* The stack pointer we should be reading the exception frame from
+        /*
+         * The stack pointer we should be reading the exception frame from
          * depends on bits in the magic exception return type value (and
          * for v8M isn't necessarily the stack pointer we will eventually
          * end up resuming execution with). Get a pointer to the location
@@ -9129,7 +9165,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             v7m_stack_read(cpu, &xpsr, frameptr + 0x1c, mmu_idx);
 
         if (!pop_ok) {
-            /* v7m_stack_read() pended a fault, so take it (as a tail
+            /*
+             * v7m_stack_read() pended a fault, so take it (as a tail
              * chained exception on the same stack frame)
              */
             qemu_log_mask(CPU_LOG_INT, "...derived exception on unstacking\n");
@@ -9137,7 +9174,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             return;
         }
 
-        /* Returning from an exception with a PC with bit 0 set is defined
+        /*
+         * Returning from an exception with a PC with bit 0 set is defined
          * behaviour on v8M (bit 0 is ignored), but for v7M it was specified
          * to be UNPREDICTABLE. In practice actual v7M hardware seems to ignore
          * the lsbit, and there are several RTOSes out there which incorrectly
@@ -9155,13 +9193,15 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         }
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
-            /* For v8M we have to check whether the xPSR exception field
+            /*
+             * For v8M we have to check whether the xPSR exception field
              * matches the EXCRET value for return to handler/thread
              * before we commit to changing the SP and xPSR.
              */
             bool will_be_handler = (xpsr & XPSR_EXCP) != 0;
             if (return_to_handler != will_be_handler) {
-                /* Take an INVPC UsageFault on the current stack.
+                /*
+                 * Take an INVPC UsageFault on the current stack.
                  * By this point we will have switched to the security state
                  * for the background state, so this UsageFault will target
                  * that state.
@@ -9276,7 +9316,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                 frameptr += 0x40;
             }
         }
-        /* Undo stack alignment (the SPREALIGN bit indicates that the original
+        /*
+         * Undo stack alignment (the SPREALIGN bit indicates that the original
          * pre-exception SP was not 8-aligned and we added a padding word to
          * align it, so we undo this by ORing in the bit that increases it
          * from the current 8-aligned value to the 8-unaligned value. (Adding 4
@@ -9302,13 +9343,15 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                                                V7M_CONTROL, SFPA, sfpa);
     }
 
-    /* The restored xPSR exception field will be zero if we're
+    /*
+     * The restored xPSR exception field will be zero if we're
      * resuming in Thread mode. If that doesn't match what the
      * exception return excret specified then this is a UsageFault.
      * v7M requires we make this check here; v8M did it earlier.
      */
     if (return_to_handler != arm_v7m_is_handler_mode(env)) {
-        /* Take an INVPC UsageFault by pushing the stack again;
+        /*
+         * Take an INVPC UsageFault by pushing the stack again;
          * we know we're v7M so this is never a Secure UsageFault.
          */
         bool ignore_stackfaults;
@@ -9330,7 +9373,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
 
 static bool do_v7m_function_return(ARMCPU *cpu)
 {
-    /* v8M security extensions magic function return.
+    /*
+     * v8M security extensions magic function return.
      * We may either:
      *  (1) throw an exception (longjump)
      *  (2) return true if we successfully handled the function return
@@ -9360,7 +9404,8 @@ static bool do_v7m_function_return(ARMCPU *cpu)
         frame_sp_p = get_v7m_sp_ptr(env, true, threadmode, spsel);
         frameptr = *frame_sp_p;
 
-        /* These loads may throw an exception (for MPU faults). We want to
+        /*
+         * These loads may throw an exception (for MPU faults). We want to
          * do them as secure, so work out what MMU index that is.
          */
         mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
@@ -9441,7 +9486,8 @@ static void arm_log_exception(int idx)
 static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
                                uint32_t addr, uint16_t *insn)
 {
-    /* Load a 16-bit portion of a v7M instruction, returning true on success,
+    /*
+     * Load a 16-bit portion of a v7M instruction, returning true on success,
      * or false on failure (in which case we will have pended the appropriate
      * exception).
      * We need to do the instruction fetch's MPU and SAU checks
@@ -9464,7 +9510,8 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
 
     v8m_security_lookup(env, addr, MMU_INST_FETCH, mmu_idx, &sattrs);
     if (!sattrs.nsc || sattrs.ns) {
-        /* This must be the second half of the insn, and it straddles a
+        /*
+         * This must be the second half of the insn, and it straddles a
          * region boundary with the second half not being S&NSC.
          */
         env->v7m.sfsr |= R_V7M_SFSR_INVEP_MASK;
@@ -9494,7 +9541,8 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
 
 static bool v7m_handle_execute_nsc(ARMCPU *cpu)
 {
-    /* Check whether this attempt to execute code in a Secure & NS-Callable
+    /*
+     * Check whether this attempt to execute code in a Secure & NS-Callable
      * memory region is for an SG instruction; if so, then emulate the
      * effect of the SG instruction and return true. Otherwise pend
      * the correct kind of exception and return false.
@@ -9503,7 +9551,8 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     ARMMMUIdx mmu_idx;
     uint16_t insn;
 
-    /* We should never get here unless get_phys_addr_pmsav8() caused
+    /*
+     * We should never get here unless get_phys_addr_pmsav8() caused
      * an exception for NS executing in S&NSC memory.
      */
     assert(!env->v7m.secure);
@@ -9521,7 +9570,8 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     }
 
     if (insn != 0xe97f) {
-        /* Not an SG instruction first half (we choose the IMPDEF
+        /*
+         * Not an SG instruction first half (we choose the IMPDEF
          * early-SG-check option).
          */
         goto gen_invep;
@@ -9532,13 +9582,15 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     }
 
     if (insn != 0xe97f) {
-        /* Not an SG instruction second half (yes, both halves of the SG
+        /*
+         * Not an SG instruction second half (yes, both halves of the SG
          * insn have the same hex value)
          */
         goto gen_invep;
     }
 
-    /* OK, we have confirmed that we really have an SG instruction.
+    /*
+     * OK, we have confirmed that we really have an SG instruction.
      * We know we're NS in S memory so don't need to repeat those checks.
      */
     qemu_log_mask(CPU_LOG_INT, "...really an SG instruction at 0x%08" PRIx32
@@ -9567,8 +9619,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
 
     arm_log_exception(cs->exception_index);
 
-    /* For exceptions we just mark as pending on the NVIC, and let that
-       handle it.  */
+    /*
+     * For exceptions we just mark as pending on the NVIC, and let that
+     * handle it.
+     */
     switch (cs->exception_index) {
     case EXCP_UDEF:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.secure);
@@ -9614,13 +9668,15 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         break;
     case EXCP_PREFETCH_ABORT:
     case EXCP_DATA_ABORT:
-        /* Note that for M profile we don't have a guest facing FSR, but
+        /*
+         * Note that for M profile we don't have a guest facing FSR, but
          * the env->exception.fsr will be populated by the code that
          * raises the fault, in the A profile short-descriptor format.
          */
         switch (env->exception.fsr & 0xf) {
         case M_FAKE_FSR_NSC_EXEC:
-            /* Exception generated when we try to execute code at an address
+            /*
+             * Exception generated when we try to execute code at an address
              * which is marked as Secure & Non-Secure Callable and the CPU
              * is in the Non-Secure state. The only instruction which can
              * be executed like this is SG (and that only if both halves of
@@ -9633,7 +9689,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             }
             break;
         case M_FAKE_FSR_SFAULT:
-            /* Various flavours of SecureFault for attempts to execute or
+            /*
+             * Various flavours of SecureFault for attempts to execute or
              * access data in the wrong security state.
              */
             switch (cs->exception_index) {
@@ -9675,7 +9732,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS, false);
             break;
         default:
-            /* All other FSR values are either MPU faults or "can't happen
+            /*
+             * All other FSR values are either MPU faults or "can't happen
              * for M profile" cases.
              */
             switch (cs->exception_index) {
@@ -9741,7 +9799,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     if (arm_feature(env, ARM_FEATURE_V8)) {
         lr = R_V7M_EXCRET_RES1_MASK |
             R_V7M_EXCRET_DCRS_MASK;
-        /* The S bit indicates whether we should return to Secure
+        /*
+         * The S bit indicates whether we should return to Secure
          * or NonSecure (ie our current state).
          * The ES bit indicates whether we're taking this exception
          * to Secure or NonSecure (ie our target state). We set it
@@ -9776,7 +9835,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     v7m_exception_taken(cpu, lr, false, ignore_stackfaults);
 }
 
-/* Function used to synchronize QEMU's AArch64 register set with AArch32
+/*
+ * Function used to synchronize QEMU's AArch64 register set with AArch32
  * register set.  This is necessary when switching between AArch32 and AArch64
  * execution state.
  */
@@ -9790,7 +9850,8 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         env->xregs[i] = env->regs[i];
     }
 
-    /* Unless we are in FIQ mode, x8-x12 come from the user registers r8-r12.
+    /*
+     * Unless we are in FIQ mode, x8-x12 come from the user registers r8-r12.
      * Otherwise, they come from the banked user regs.
      */
     if (mode == ARM_CPU_MODE_FIQ) {
@@ -9803,7 +9864,8 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         }
     }
 
-    /* Registers x13-x23 are the various mode SP and FP registers. Registers
+    /*
+     * Registers x13-x23 are the various mode SP and FP registers. Registers
      * r13 and r14 are only copied if we are in that mode, otherwise we copy
      * from the mode banked register.
      */
@@ -9858,7 +9920,8 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         env->xregs[23] = env->banked_r13[bank_number(ARM_CPU_MODE_UND)];
     }
 
-    /* Registers x24-x30 are mapped to r8-r14 in FIQ mode.  If we are in FIQ
+    /*
+     * Registers x24-x30 are mapped to r8-r14 in FIQ mode.  If we are in FIQ
      * mode, then we can copy from r8-r14.  Otherwise, we copy from the
      * FIQ bank for r8-r14.
      */
@@ -9877,7 +9940,8 @@ void aarch64_sync_32_to_64(CPUARMState *env)
     env->pc = env->regs[15];
 }
 
-/* Function used to synchronize QEMU's AArch32 register set with AArch64
+/*
+ * Function used to synchronize QEMU's AArch32 register set with AArch64
  * register set.  This is necessary when switching between AArch32 and AArch64
  * execution state.
  */
@@ -9891,7 +9955,8 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         env->regs[i] = env->xregs[i];
     }
 
-    /* Unless we are in FIQ mode, r8-r12 come from the user registers x8-x12.
+    /*
+     * Unless we are in FIQ mode, r8-r12 come from the user registers x8-x12.
      * Otherwise, we copy x8-x12 into the banked user regs.
      */
     if (mode == ARM_CPU_MODE_FIQ) {
@@ -9904,7 +9969,8 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         }
     }
 
-    /* Registers r13 & r14 depend on the current mode.
+    /*
+     * Registers r13 & r14 depend on the current mode.
      * If we are in a given mode, we copy the corresponding x registers to r13
      * and r14.  Otherwise, we copy the x register to the banked r13 and r14
      * for the mode.
@@ -9915,7 +9981,8 @@ void aarch64_sync_64_to_32(CPUARMState *env)
     } else {
         env->banked_r13[bank_number(ARM_CPU_MODE_USR)] = env->xregs[13];
 
-        /* HYP is an exception in that it does not have its own banked r14 but
+        /*
+         * HYP is an exception in that it does not have its own banked r14 but
          * shares the USR r14
          */
         if (mode == ARM_CPU_MODE_HYP) {
@@ -12758,7 +12825,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return value;
     }
     case 0x94: /* CONTROL_NS */
-        /* We have to handle this here because unprivileged Secure code
+        /*
+         * We have to handle this here because unprivileged Secure code
          * can read the NS CONTROL register.
          */
         if (!env->v7m.secure) {
@@ -12811,7 +12879,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
             return env->v7m.faultmask[M_REG_NS];
         case 0x98: /* SP_NS */
         {
-            /* This gives the non-secure SP selected based on whether we're
+            /*
+             * This gives the non-secure SP selected based on whether we're
              * currently in handler mode or not, using the NS CONTROL.SPSEL.
              */
             bool spsel = env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK;
@@ -12862,7 +12931,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
 
 void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
 {
-    /* We're passed bits [11..0] of the instruction; extract
+    /*
+     * We're passed bits [11..0] of the instruction; extract
      * SYSm and the mask bits.
      * Invalid combinations of SYSm and mask are UNPREDICTABLE;
      * we choose to treat them as if the mask bits were valid.
@@ -12948,7 +13018,8 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             return;
         case 0x98: /* SP_NS */
         {
-            /* This gives the non-secure SP selected based on whether we're
+            /*
+             * This gives the non-secure SP selected based on whether we're
              * currently in handler mode or not, using the NS CONTROL.SPSEL.
              */
             bool spsel = env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SPSEL_MASK;
@@ -13109,7 +13180,8 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     bool targetsec = env->v7m.secure;
     bool is_subpage;
 
-    /* Work out what the security state and privilege level we're
+    /*
+     * Work out what the security state and privilege level we're
      * interested in is...
      */
     if (alt) {
@@ -13126,12 +13198,14 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
     /* ...and then figure out which MMU index this is */
     mmu_idx = arm_v7m_mmu_idx_for_secstate_and_priv(env, targetsec, targetpriv);
 
-    /* We know that the MPU and SAU don't care about the access type
+    /*
+     * We know that the MPU and SAU don't care about the access type
      * for our purposes beyond that we don't want to claim to be
      * an insn fetch, so we arbitrarily call this a read.
      */
 
-    /* MPU region info only available for privileged or if
+    /*
+     * MPU region info only available for privileged or if
      * inspecting the other MPU state.
      */
     if (arm_current_el(env) != 0 || alt) {
@@ -13236,7 +13310,8 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
-    /* Implement DC ZVA, which zeroes a fixed-length block of memory.
+    /*
+     * Implement DC ZVA, which zeroes a fixed-length block of memory.
      * Note that we do not implement the (architecturally mandated)
      * alignment fault for attempts to use this on Device memory
      * (which matches the usual QEMU behaviour of not implementing either
@@ -13249,7 +13324,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 
 #ifndef CONFIG_USER_ONLY
     {
-        /* Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
+        /*
+         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
          * the block size so we might have to do more than one TLB lookup.
          * We know that in fact for any v8 CPU the page size is at least 4K
          * and the block size must be 2K or less, but TARGET_PAGE_SIZE is only
@@ -13276,7 +13352,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
                 }
             }
             if (i == maxidx) {
-                /* If it's all in the TLB it's fair game for just writing to;
+                /*
+                 * If it's all in the TLB it's fair game for just writing to;
                  * we know we don't need to update dirty status, etc.
                  */
                 for (i = 0; i < maxidx - 1; i++) {
@@ -13285,7 +13362,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
                 memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE));
                 return;
             }
-            /* OK, try a store and see if we can populate the tlb. This
+            /*
+             * OK, try a store and see if we can populate the tlb. This
              * might cause an exception if the memory isn't writable,
              * in which case we will longjmp out of here. We must for
              * this purpose use the actual register value passed to us
@@ -13301,7 +13379,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
             }
         }
 
-        /* Slow path (probably attempt to do this to an I/O device or
+        /*
+         * Slow path (probably attempt to do this to an I/O device or
          * similar, or clearing of a block of code we have translations
          * cached for). Just do a series of byte writes as the architecture
          * demands. It's not worth trying to use a cpu_physical_memory_map(),
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 4db254876dd..b1952486c61 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -97,7 +97,8 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
 {
     uint32_t syn;
 
-    /* ISV is only set for data aborts routed to EL2 and
+    /*
+     * ISV is only set for data aborts routed to EL2 and
      * never for stage-1 page table walks faulting on stage 2.
      *
      * Furthermore, ISV is only set for certain kinds of load/stores.
@@ -112,7 +113,8 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
         syn = syn_data_abort_no_iss(same_el,
                                     ea, 0, s1ptw, is_write, fsc);
     } else {
-        /* Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the template
+        /*
+         * Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the template
          * syndrome created at translation time.
          * Now we create the runtime syndrome with the remaining fields.
          */
@@ -144,14 +146,16 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
 
     if (target_el == 2 || arm_el_is_aa64(env, target_el) ||
         arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
-        /* LPAE format fault status register : bottom 6 bits are
+        /*
+         * LPAE format fault status register : bottom 6 bits are
          * status code in the same form as needed for syndrome
          */
         fsr = arm_fi_to_lfsc(fi);
         fsc = extract32(fsr, 0, 6);
     } else {
         fsr = arm_fi_to_sfsc(fi);
-        /* Short format FSR : this fault will never actually be reported
+        /*
+         * Short format FSR : this fault will never actually be reported
          * to an EL that uses a syndrome register. Use a (currently)
          * reserved FSR code in case the constructed syndrome does leak
          * into the guest somehow.
@@ -194,7 +198,8 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
-/* arm_cpu_do_transaction_failed: handle a memory system error response
+/*
+ * arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abort
  * exception
  */
@@ -970,7 +975,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     int bt;
     uint32_t contextidr;
 
-    /* Links to unimplemented or non-context aware breakpoints are
+    /*
+     * Links to unimplemented or non-context aware breakpoints are
      * CONSTRAINED UNPREDICTABLE: either behave as if disabled, or
      * as if linked to an UNKNOWN context-aware breakpoint (in which
      * case DBGWCR<n>_EL1.LBN must indicate that breakpoint).
@@ -989,7 +995,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
 
     bt = extract64(bcr, 20, 4);
 
-    /* We match the whole register even if this is AArch32 using the
+    /*
+     * We match the whole register even if this is AArch32 using the
      * short descriptor format (in which case it holds both PROCID and ASID),
      * since we don't implement the optional v7 context ID masking.
      */
@@ -1006,7 +1013,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     case 9: /* linked VMID match (reserved if no EL2) */
     case 11: /* linked context ID and VMID match (reserved if no EL2) */
     default:
-        /* Links to Unlinked context breakpoints must generate no
+        /*
+         * Links to Unlinked context breakpoints must generate no
          * events; we choose to do the same for reserved values too.
          */
         return false;
@@ -1020,7 +1028,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
     CPUARMState *env = &cpu->env;
     uint64_t cr;
     int pac, hmc, ssc, wt, lbn;
-    /* Note that for watchpoints the check is against the CPU security
+    /*
+     * Note that for watchpoints the check is against the CPU security
      * state, not the S/NS attribute on the offending data access.
      */
     bool is_secure = arm_is_secure(env);
@@ -1034,7 +1043,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
         }
         cr = env->cp15.dbgwcr[n];
         if (wp->hitattrs.user) {
-            /* The LDRT/STRT/LDT/STT "unprivileged access" instructions should
+            /*
+             * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
              * match watchpoints as if they were accesses done at EL0, even if
              * the CPU is at EL1 or higher.
              */
@@ -1048,7 +1058,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
         }
         cr = env->cp15.dbgbcr[n];
     }
-    /* The WATCHPOINT_HIT flag guarantees us that the watchpoint is
+    /*
+     * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
      * enabled and that the address and access type match; for breakpoints
      * we know the address matched; check the remaining fields, including
      * linked breakpoints. We rely on WCR and BCR having the same layout
@@ -1116,7 +1127,8 @@ static bool check_watchpoints(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     int n;
 
-    /* If watchpoints are disabled globally or we can't take debug
+    /*
+     * If watchpoints are disabled globally or we can't take debug
      * exceptions here then watchpoint firings are ignored.
      */
     if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
@@ -1137,7 +1149,8 @@ static bool check_breakpoints(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
     int n;
 
-    /* If breakpoints are disabled globally or we can't take debug
+    /*
+     * If breakpoints are disabled globally or we can't take debug
      * exceptions here then breakpoint firings are ignored.
      */
     if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
@@ -1164,7 +1177,8 @@ void HELPER(check_breakpoints)(CPUARMState *env)
 
 bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
-    /* Called by core code when a CPU watchpoint fires; need to check if this
+    /*
+     * Called by core code when a CPU watchpoint fires; need to check if this
      * is also an architectural watchpoint match.
      */
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1177,7 +1191,8 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
-    /* In BE32 system mode, target memory is stored byteswapped (on a
+    /*
+     * In BE32 system mode, target memory is stored byteswapped (on a
      * little-endian host system), and by the time we reach here (via an
      * opcode helper) the addresses of subword accesses have been adjusted
      * to account for that, which means that watchpoints will not match.
@@ -1196,7 +1211,8 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
 
 void arm_debug_excp_handler(CPUState *cs)
 {
-    /* Called by core code when a watchpoint or breakpoint fires;
+    /*
+     * Called by core code when a watchpoint or breakpoint fires;
      * need to check which one and raise the appropriate exception.
      */
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1220,7 +1236,8 @@ void arm_debug_excp_handler(CPUState *cs)
         uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
         bool same_el = (arm_debug_target_el(env) == arm_current_el(env));
 
-        /* (1) GDB breakpoints should be handled first.
+        /*
+         * (1) GDB breakpoints should be handled first.
          * (2) Do not raise a CPU exception if no CPU breakpoint has fired,
          * since singlestep is also done by generating a debug internal
          * exception.
@@ -1231,7 +1248,8 @@ void arm_debug_excp_handler(CPUState *cs)
         }
 
         env->exception.fsr = arm_debug_exception_fsr(env);
-        /* FAR is UNKNOWN: clear vaddress to avoid potentially exposing
+        /*
+         * FAR is UNKNOWN: clear vaddress to avoid potentially exposing
          * values to the guest that it shouldn't be able to see at its
          * exception/security level.
          */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index d3e83b627b7..7ece78e987b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -170,7 +170,8 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
     }
 
-    /* The exception flags are ORed together when we read fpscr so we
+    /*
+     * The exception flags are ORed together when we read fpscr so we
      * only need to preserve the current state in one of our
      * float_status values.
      */
-- 
2.20.1


