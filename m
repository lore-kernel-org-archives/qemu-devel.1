Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D610C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CA22146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CA22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwV9-0004CW-Cx
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKE-00023p-C6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwK8-0001wc-Jm
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwJh-0001cw-7m; Mon, 01 Jul 2019 09:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82EC185546;
 Mon,  1 Jul 2019 13:25:56 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 290086085B;
 Mon,  1 Jul 2019 13:25:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:24:56 +0200
Message-Id: <20190701132516.26392-8-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 01 Jul 2019 13:25:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 07/27] target/arm: Fix multiline comment
 syntax
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 8c06fbdf36b checkpatch.pl enforce a new multiline
comment syntax. Since we'll move this code around, fix its style
first.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: added vfp_helper.c
---
 target/arm/helper.c     | 237 ++++++++++++++++++++++++++--------------
 target/arm/op_helper.c  |  54 ++++++---
 target/arm/vfp_helper.c |   3 +-
 3 files changed, 196 insertions(+), 98 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ca4d4a57bf..c77ed85215 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7529,7 +7529,8 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t f=
ptr)
=20
 uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 {
-    /* The TT instructions can be used by unprivileged code, but in
+    /*
+     * The TT instructions can be used by unprivileged code, but in
      * user-only emulation we don't have the MPU.
      * Luckily since we know we are NonSecure unprivileged (and that in
      * turn means that the A flag wasn't specified), all the bits in the
@@ -7801,7 +7802,8 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t a=
ddr, uint32_t value,
     return true;
=20
 pend_fault:
-    /* By pending the exception at this point we are making
+    /*
+     * By pending the exception at this point we are making
      * the IMPDEF choice "overridden exceptions pended" (see the
      * MergeExcInfo() pseudocode). The other choice would be to not
      * pend them now and then make a choice about which to throw away
@@ -7876,7 +7878,8 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *d=
est, uint32_t addr,
     return true;
=20
 pend_fault:
-    /* By pending the exception at this point we are making
+    /*
+     * By pending the exception at this point we are making
      * the IMPDEF choice "overridden exceptions pended" (see the
      * MergeExcInfo() pseudocode). The other choice would be to not
      * pend them now and then make a choice about which to throw away
@@ -7977,7 +7980,8 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env=
)
      */
 }
=20
-/* Write to v7M CONTROL.SPSEL bit for the specified security bank.
+/*
+ * Write to v7M CONTROL.SPSEL bit for the specified security bank.
  * This may change the current stack pointer between Main and Process
  * stack pointers if it is done for the CONTROL register for the current
  * security state.
@@ -8005,7 +8009,8 @@ static void write_v7m_control_spsel_for_secstate(CP=
UARMState *env,
     }
 }
=20
-/* Write to v7M CONTROL.SPSEL bit. This may change the current
+/*
+ * Write to v7M CONTROL.SPSEL bit. This may change the current
  * stack pointer between Main and Process stack pointers.
  */
 static void write_v7m_control_spsel(CPUARMState *env, bool new_spsel)
@@ -8015,7 +8020,8 @@ static void write_v7m_control_spsel(CPUARMState *en=
v, bool new_spsel)
=20
 void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
 {
-    /* Write a new value to v7m.exception, thus transitioning into or ou=
t
+    /*
+     * Write a new value to v7m.exception, thus transitioning into or ou=
t
      * of Handler mode; this may result in a change of active stack poin=
ter.
      */
     bool new_is_psp, old_is_psp =3D v7m_using_psp(env);
@@ -8041,7 +8047,8 @@ static void switch_v7m_security_state(CPUARMState *=
env, bool new_secstate)
         return;
     }
=20
-    /* All the banked state is accessed by looking at env->v7m.secure
+    /*
+     * All the banked state is accessed by looking at env->v7m.secure
      * except for the stack pointer; rearrange the SP appropriately.
      */
     new_ss_msp =3D env->v7m.other_ss_msp;
@@ -8068,7 +8075,8 @@ static void switch_v7m_security_state(CPUARMState *=
env, bool new_secstate)
=20
 void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
 {
-    /* Handle v7M BXNS:
+    /*
+     * Handle v7M BXNS:
      *  - if the return value is a magic value, do exception return (lik=
e BX)
      *  - otherwise bit 0 of the return value is the target security sta=
te
      */
@@ -8083,7 +8091,8 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t de=
st)
     }
=20
     if (dest >=3D min_magic) {
-        /* This is an exception return magic value; put it where
+        /*
+         * This is an exception return magic value; put it where
          * do_v7m_exception_exit() expects and raise EXCEPTION_EXIT.
          * Note that if we ever add gen_ss_advance() singlestep support =
to
          * M profile this should count as an "instruction execution comp=
lete"
@@ -8108,7 +8117,8 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t de=
st)
=20
 void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
 {
-    /* Handle v7M BLXNS:
+    /*
+     * Handle v7M BLXNS:
      *  - bit 0 of the destination address is the target security state
      */
=20
@@ -8121,7 +8131,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t d=
est)
     assert(env->v7m.secure);
=20
     if (dest & 1) {
-        /* target is Secure, so this is just a normal BLX,
+        /*
+         * Target is Secure, so this is just a normal BLX,
          * except that the low bit doesn't indicate Thumb/not.
          */
         env->regs[14] =3D nextinst;
@@ -8152,7 +8163,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t d=
est)
     env->regs[13] =3D sp;
     env->regs[14] =3D 0xfeffffff;
     if (arm_v7m_is_handler_mode(env)) {
-        /* Write a dummy value to IPSR, to avoid leaking the current sec=
ure
+        /*
+         * Write a dummy value to IPSR, to avoid leaking the current sec=
ure
          * exception number to non-secure code. This is guaranteed not
          * to cause write_v7m_exception() to actually change stacks.
          */
@@ -8167,7 +8179,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t d=
est)
 static uint32_t *get_v7m_sp_ptr(CPUARMState *env, bool secure, bool thre=
admode,
                                 bool spsel)
 {
-    /* Return a pointer to the location where we currently store the
+    /*
+     * Return a pointer to the location where we currently store the
      * stack pointer for the requested security state and thread mode.
      * This pointer will become invalid if the CPU state is updated
      * such that the stack pointers are switched around (eg changing
@@ -8213,7 +8226,8 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int ex=
c, bool targets_secure,
=20
     mmu_idx =3D arm_v7m_mmu_idx_for_secstate_and_priv(env, targets_secur=
e, true);
=20
-    /* We don't do a get_phys_addr() here because the rules for vector
+    /*
+     * We don't do a get_phys_addr() here because the rules for vector
      * loads are special: they always use the default memory map, and
      * the default memory map permits reads from all addresses.
      * Since there's no easy way to pass through to pmsav8_mpu_lookup()
@@ -8244,7 +8258,8 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int ex=
c, bool targets_secure,
     return true;
=20
 load_fail:
-    /* All vector table fetch fails are reported as HardFault, with
+    /*
+     * All vector table fetch fails are reported as HardFault, with
      * HFSR.VECTTBL and .FORCED set. (FORCED is set because
      * technically the underlying exception is a MemManage or BusFault
      * that is escalated to HardFault.) This is a terminal exception,
@@ -8276,7 +8291,8 @@ static uint32_t v7m_integrity_sig(CPUARMState *env,=
 uint32_t lr)
 static bool v7m_push_callee_stack(ARMCPU *cpu, uint32_t lr, bool dotailc=
hain,
                                   bool ignore_faults)
 {
-    /* For v8M, push the callee-saves register part of the stack frame.
+    /*
+     * For v8M, push the callee-saves register part of the stack frame.
      * Compare the v8M pseudocode PushCalleeStack().
      * In the tailchaining case this may not be the current stack.
      */
@@ -8327,7 +8343,8 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint=
32_t lr, bool dotailchain,
         return true;
     }
=20
-    /* Write as much of the stack frame as we can. A write failure may
+    /*
+     * Write as much of the stack frame as we can. A write failure may
      * cause us to pend a derived exception.
      */
     sig =3D v7m_integrity_sig(env, lr);
@@ -8351,7 +8368,8 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint=
32_t lr, bool dotailchain,
 static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailcha=
in,
                                 bool ignore_stackfaults)
 {
-    /* Do the "take the exception" parts of exception entry,
+    /*
+     * Do the "take the exception" parts of exception entry,
      * but not the pushing of state to the stack. This is
      * similar to the pseudocode ExceptionTaken() function.
      */
@@ -8376,13 +8394,15 @@ static void v7m_exception_taken(ARMCPU *cpu, uint=
32_t lr, bool dotailchain,
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M_SECURITY) &&
             (lr & R_V7M_EXCRET_S_MASK)) {
-            /* The background code (the owner of the registers in the
+            /*
+             * The background code (the owner of the registers in the
              * exception frame) is Secure. This means it may either alre=
ady
              * have or now needs to push callee-saves registers.
              */
             if (targets_secure) {
                 if (dotailchain && !(lr & R_V7M_EXCRET_ES_MASK)) {
-                    /* We took an exception from Secure to NonSecure
+                    /*
+                     * We took an exception from Secure to NonSecure
                      * (which means the callee-saved registers got stack=
ed)
                      * and are now tailchaining to a Secure exception.
                      * Clear DCRS so eventual return from this Secure
@@ -8391,7 +8411,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32=
_t lr, bool dotailchain,
                     lr &=3D ~R_V7M_EXCRET_DCRS_MASK;
                 }
             } else {
-                /* We're going to a non-secure exception; push the
+                /*
+                 * We're going to a non-secure exception; push the
                  * callee-saves registers to the stack now, if they're
                  * not already saved.
                  */
@@ -8413,14 +8434,16 @@ static void v7m_exception_taken(ARMCPU *cpu, uint=
32_t lr, bool dotailchain,
             lr |=3D R_V7M_EXCRET_SPSEL_MASK;
         }
=20
-        /* Clear registers if necessary to prevent non-secure exception
+        /*
+         * Clear registers if necessary to prevent non-secure exception
          * code being able to see register values from secure code.
          * Where register values become architecturally UNKNOWN we leave
          * them with their previous values.
          */
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             if (!targets_secure) {
-                /* Always clear the caller-saved registers (they have be=
en
+                /*
+                 * Always clear the caller-saved registers (they have be=
en
                  * pushed to the stack earlier in v7m_push_stack()).
                  * Clear callee-saved registers if the background code i=
s
                  * Secure (in which case these regs were saved in
@@ -8441,7 +8464,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32=
_t lr, bool dotailchain,
     }
=20
     if (push_failed && !ignore_stackfaults) {
-        /* Derived exception on callee-saves register stacking:
+        /*
+         * Derived exception on callee-saves register stacking:
          * we might now want to take a different exception which
          * targets a different security state, so try again from the top=
.
          */
@@ -8458,7 +8482,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32=
_t lr, bool dotailchain,
         return;
     }
=20
-    /* Now we've done everything that might cause a derived exception
+    /*
+     * Now we've done everything that might cause a derived exception
      * we can go ahead and activate whichever exception we're going to
      * take (which might now be the derived exception).
      */
@@ -8661,7 +8686,8 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t f=
ptr)
=20
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
=20
-    /* Write as much of the stack frame as we can. If we fail a stack
+    /*
+     * Write as much of the stack frame as we can. If we fail a stack
      * write this will result in a derived exception being pended
      * (which may be taken in preference to the one we started with
      * if it has higher priority).
@@ -8846,7 +8873,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool ftype;
     bool restore_s16_s31;
=20
-    /* If we're not in Handler mode then jumps to magic exception-exit
+    /*
+     * If we're not in Handler mode then jumps to magic exception-exit
      * addresses don't have magic behaviour. However for the v8M
      * security extensions the magic secure-function-return has to
      * work in thread mode too, so to avoid doing an extra check in
@@ -8860,7 +8888,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         return;
     }
=20
-    /* In the spec pseudocode ExceptionReturn() is called directly
+    /*
+     * In the spec pseudocode ExceptionReturn() is called directly
      * from BXWritePC() and gets the full target PC value including
      * bit zero. In QEMU's implementation we treat it as a normal
      * jump-to-register (which is then caught later on), and so split
@@ -8893,7 +8922,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
=20
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-        /* EXC_RETURN.ES validation check (R_SMFL). We must do this befo=
re
+        /*
+         * EXC_RETURN.ES validation check (R_SMFL). We must do this befo=
re
          * we pick which FAULTMASK to clear.
          */
         if (!env->v7m.secure &&
@@ -8907,7 +8937,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
=20
     if (env->v7m.exception !=3D ARMV7M_EXCP_NMI) {
-        /* Auto-clear FAULTMASK on return from other than NMI.
+        /*
+         * Auto-clear FAULTMASK on return from other than NMI.
          * If the security extension is implemented then this only
          * happens if the raw execution priority is >=3D 0; the
          * value of the ES bit in the exception return value indicates
@@ -8932,7 +8963,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         /* still an irq active now */
         break;
     case 1:
-        /* we returned to base exception level, no nesting.
+        /*
+         * We returned to base exception level, no nesting.
          * (In the pseudocode this is written using "NestedActivation !=3D=
 1"
          * where we have 'rettobase =3D=3D false'.)
          */
@@ -8949,7 +8981,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
=20
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (!arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-            /* UNPREDICTABLE if S =3D=3D 1 or DCRS =3D=3D 0 or ES =3D=3D=
 1 (R_XLCP);
+            /*
+             * UNPREDICTABLE if S =3D=3D 1 or DCRS =3D=3D 0 or ES =3D=3D=
 1 (R_XLCP);
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
=20
     if (ufault) {
-        /* Bad exception return: instead of popping the exception
+        /*
+         * Bad exception return: instead of popping the exception
          * stack, directly take a usage fault on the current stack.
          */
         env->v7m.cfsr[env->v7m.secure] |=3D R_V7M_CFSR_INVPC_MASK;
@@ -9056,7 +9091,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     switch_v7m_security_state(env, return_to_secure);
=20
     {
-        /* The stack pointer we should be reading the exception frame fr=
om
+        /*
+         * The stack pointer we should be reading the exception frame fr=
om
          * depends on bits in the magic exception return type value (and
          * for v8M isn't necessarily the stack pointer we will eventuall=
y
          * end up resuming execution with). Get a pointer to the locatio=
n
@@ -9129,7 +9165,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             v7m_stack_read(cpu, &xpsr, frameptr + 0x1c, mmu_idx);
=20
         if (!pop_ok) {
-            /* v7m_stack_read() pended a fault, so take it (as a tail
+            /*
+             * v7m_stack_read() pended a fault, so take it (as a tail
              * chained exception on the same stack frame)
              */
             qemu_log_mask(CPU_LOG_INT, "...derived exception on unstacki=
ng\n");
@@ -9137,7 +9174,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             return;
         }
=20
-        /* Returning from an exception with a PC with bit 0 set is defin=
ed
+        /*
+         * Returning from an exception with a PC with bit 0 set is defin=
ed
          * behaviour on v8M (bit 0 is ignored), but for v7M it was speci=
fied
          * to be UNPREDICTABLE. In practice actual v7M hardware seems to=
 ignore
          * the lsbit, and there are several RTOSes out there which incor=
rectly
@@ -9155,13 +9193,15 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         }
=20
         if (arm_feature(env, ARM_FEATURE_V8)) {
-            /* For v8M we have to check whether the xPSR exception field
+            /*
+             * For v8M we have to check whether the xPSR exception field
              * matches the EXCRET value for return to handler/thread
              * before we commit to changing the SP and xPSR.
              */
             bool will_be_handler =3D (xpsr & XPSR_EXCP) !=3D 0;
             if (return_to_handler !=3D will_be_handler) {
-                /* Take an INVPC UsageFault on the current stack.
+                /*
+                 * Take an INVPC UsageFault on the current stack.
                  * By this point we will have switched to the security s=
tate
                  * for the background state, so this UsageFault will tar=
get
                  * that state.
@@ -9276,7 +9316,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                 frameptr +=3D 0x40;
             }
         }
-        /* Undo stack alignment (the SPREALIGN bit indicates that the or=
iginal
+        /*
+         * Undo stack alignment (the SPREALIGN bit indicates that the or=
iginal
          * pre-exception SP was not 8-aligned and we added a padding wor=
d to
          * align it, so we undo this by ORing in the bit that increases =
it
          * from the current 8-aligned value to the 8-unaligned value. (A=
dding 4
@@ -9302,13 +9343,15 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                                                V7M_CONTROL, SFPA, sfpa);
     }
=20
-    /* The restored xPSR exception field will be zero if we're
+    /*
+     * The restored xPSR exception field will be zero if we're
      * resuming in Thread mode. If that doesn't match what the
      * exception return excret specified then this is a UsageFault.
      * v7M requires we make this check here; v8M did it earlier.
      */
     if (return_to_handler !=3D arm_v7m_is_handler_mode(env)) {
-        /* Take an INVPC UsageFault by pushing the stack again;
+        /*
+         * Take an INVPC UsageFault by pushing the stack again;
          * we know we're v7M so this is never a Secure UsageFault.
          */
         bool ignore_stackfaults;
@@ -9330,7 +9373,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
=20
 static bool do_v7m_function_return(ARMCPU *cpu)
 {
-    /* v8M security extensions magic function return.
+    /*
+     * v8M security extensions magic function return.
      * We may either:
      *  (1) throw an exception (longjump)
      *  (2) return true if we successfully handled the function return
@@ -9360,7 +9404,8 @@ static bool do_v7m_function_return(ARMCPU *cpu)
         frame_sp_p =3D get_v7m_sp_ptr(env, true, threadmode, spsel);
         frameptr =3D *frame_sp_p;
=20
-        /* These loads may throw an exception (for MPU faults). We want =
to
+        /*
+         * These loads may throw an exception (for MPU faults). We want =
to
          * do them as secure, so work out what MMU index that is.
          */
         mmu_idx =3D arm_v7m_mmu_idx_for_secstate(env, true);
@@ -9441,7 +9486,8 @@ static void arm_log_exception(int idx)
 static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx,
                                uint32_t addr, uint16_t *insn)
 {
-    /* Load a 16-bit portion of a v7M instruction, returning true on suc=
cess,
+    /*
+     * Load a 16-bit portion of a v7M instruction, returning true on suc=
cess,
      * or false on failure (in which case we will have pended the approp=
riate
      * exception).
      * We need to do the instruction fetch's MPU and SAU checks
@@ -9464,7 +9510,8 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUI=
dx mmu_idx,
=20
     v8m_security_lookup(env, addr, MMU_INST_FETCH, mmu_idx, &sattrs);
     if (!sattrs.nsc || sattrs.ns) {
-        /* This must be the second half of the insn, and it straddles a
+        /*
+         * This must be the second half of the insn, and it straddles a
          * region boundary with the second half not being S&NSC.
          */
         env->v7m.sfsr |=3D R_V7M_SFSR_INVEP_MASK;
@@ -9494,7 +9541,8 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUI=
dx mmu_idx,
=20
 static bool v7m_handle_execute_nsc(ARMCPU *cpu)
 {
-    /* Check whether this attempt to execute code in a Secure & NS-Calla=
ble
+    /*
+     * Check whether this attempt to execute code in a Secure & NS-Calla=
ble
      * memory region is for an SG instruction; if so, then emulate the
      * effect of the SG instruction and return true. Otherwise pend
      * the correct kind of exception and return false.
@@ -9503,7 +9551,8 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     ARMMMUIdx mmu_idx;
     uint16_t insn;
=20
-    /* We should never get here unless get_phys_addr_pmsav8() caused
+    /*
+     * We should never get here unless get_phys_addr_pmsav8() caused
      * an exception for NS executing in S&NSC memory.
      */
     assert(!env->v7m.secure);
@@ -9521,7 +9570,8 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     }
=20
     if (insn !=3D 0xe97f) {
-        /* Not an SG instruction first half (we choose the IMPDEF
+        /*
+         * Not an SG instruction first half (we choose the IMPDEF
          * early-SG-check option).
          */
         goto gen_invep;
@@ -9532,13 +9582,15 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     }
=20
     if (insn !=3D 0xe97f) {
-        /* Not an SG instruction second half (yes, both halves of the SG
+        /*
+         * Not an SG instruction second half (yes, both halves of the SG
          * insn have the same hex value)
          */
         goto gen_invep;
     }
=20
-    /* OK, we have confirmed that we really have an SG instruction.
+    /*
+     * OK, we have confirmed that we really have an SG instruction.
      * We know we're NS in S memory so don't need to repeat those checks=
.
      */
     qemu_log_mask(CPU_LOG_INT, "...really an SG instruction at 0x%08" PR=
Ix32
@@ -9567,8 +9619,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
=20
     arm_log_exception(cs->exception_index);
=20
-    /* For exceptions we just mark as pending on the NVIC, and let that
-       handle it.  */
+    /*
+     * For exceptions we just mark as pending on the NVIC, and let that
+     * handle it.
+     */
     switch (cs->exception_index) {
     case EXCP_UDEF:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, env->v7m.s=
ecure);
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
-            /* Exception generated when we try to execute code at an add=
ress
+            /*
+             * Exception generated when we try to execute code at an add=
ress
              * which is marked as Secure & Non-Secure Callable and the C=
PU
              * is in the Non-Secure state. The only instruction which ca=
n
              * be executed like this is SG (and that only if both halves=
 of
@@ -9633,7 +9689,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             }
             break;
         case M_FAKE_FSR_SFAULT:
-            /* Various flavours of SecureFault for attempts to execute o=
r
+            /*
+             * Various flavours of SecureFault for attempts to execute o=
r
              * access data in the wrong security state.
              */
             switch (cs->exception_index) {
@@ -9675,7 +9732,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
             armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_BUS, false);
             break;
         default:
-            /* All other FSR values are either MPU faults or "can't happ=
en
+            /*
+             * All other FSR values are either MPU faults or "can't happ=
en
              * for M profile" cases.
              */
             switch (cs->exception_index) {
@@ -9741,7 +9799,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     if (arm_feature(env, ARM_FEATURE_V8)) {
         lr =3D R_V7M_EXCRET_RES1_MASK |
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
=20
-/* Function used to synchronize QEMU's AArch64 register set with AArch32
+/*
+ * Function used to synchronize QEMU's AArch64 register set with AArch32
  * register set.  This is necessary when switching between AArch32 and A=
Arch64
  * execution state.
  */
@@ -9790,7 +9850,8 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         env->xregs[i] =3D env->regs[i];
     }
=20
-    /* Unless we are in FIQ mode, x8-x12 come from the user registers r8=
-r12.
+    /*
+     * Unless we are in FIQ mode, x8-x12 come from the user registers r8=
-r12.
      * Otherwise, they come from the banked user regs.
      */
     if (mode =3D=3D ARM_CPU_MODE_FIQ) {
@@ -9803,7 +9864,8 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         }
     }
=20
-    /* Registers x13-x23 are the various mode SP and FP registers. Regis=
ters
+    /*
+     * Registers x13-x23 are the various mode SP and FP registers. Regis=
ters
      * r13 and r14 are only copied if we are in that mode, otherwise we =
copy
      * from the mode banked register.
      */
@@ -9858,7 +9920,8 @@ void aarch64_sync_32_to_64(CPUARMState *env)
         env->xregs[23] =3D env->banked_r13[bank_number(ARM_CPU_MODE_UND)=
];
     }
=20
-    /* Registers x24-x30 are mapped to r8-r14 in FIQ mode.  If we are in=
 FIQ
+    /*
+     * Registers x24-x30 are mapped to r8-r14 in FIQ mode.  If we are in=
 FIQ
      * mode, then we can copy from r8-r14.  Otherwise, we copy from the
      * FIQ bank for r8-r14.
      */
@@ -9877,7 +9940,8 @@ void aarch64_sync_32_to_64(CPUARMState *env)
     env->pc =3D env->regs[15];
 }
=20
-/* Function used to synchronize QEMU's AArch32 register set with AArch64
+/*
+ * Function used to synchronize QEMU's AArch32 register set with AArch64
  * register set.  This is necessary when switching between AArch32 and A=
Arch64
  * execution state.
  */
@@ -9891,7 +9955,8 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         env->regs[i] =3D env->xregs[i];
     }
=20
-    /* Unless we are in FIQ mode, r8-r12 come from the user registers x8=
-x12.
+    /*
+     * Unless we are in FIQ mode, r8-r12 come from the user registers x8=
-x12.
      * Otherwise, we copy x8-x12 into the banked user regs.
      */
     if (mode =3D=3D ARM_CPU_MODE_FIQ) {
@@ -9904,7 +9969,8 @@ void aarch64_sync_64_to_32(CPUARMState *env)
         }
     }
=20
-    /* Registers r13 & r14 depend on the current mode.
+    /*
+     * Registers r13 & r14 depend on the current mode.
      * If we are in a given mode, we copy the corresponding x registers =
to r13
      * and r14.  Otherwise, we copy the x register to the banked r13 and=
 r14
      * for the mode.
@@ -9915,7 +9981,8 @@ void aarch64_sync_64_to_32(CPUARMState *env)
     } else {
         env->banked_r13[bank_number(ARM_CPU_MODE_USR)] =3D env->xregs[13=
];
=20
-        /* HYP is an exception in that it does not have its own banked r=
14 but
+        /*
+         * HYP is an exception in that it does not have its own banked r=
14 but
          * shares the USR r14
          */
         if (mode =3D=3D ARM_CPU_MODE_HYP) {
@@ -12758,7 +12825,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32=
_t reg)
         return value;
     }
     case 0x94: /* CONTROL_NS */
-        /* We have to handle this here because unprivileged Secure code
+        /*
+         * We have to handle this here because unprivileged Secure code
          * can read the NS CONTROL register.
          */
         if (!env->v7m.secure) {
@@ -12811,7 +12879,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32=
_t reg)
             return env->v7m.faultmask[M_REG_NS];
         case 0x98: /* SP_NS */
         {
-            /* This gives the non-secure SP selected based on whether we=
're
+            /*
+             * This gives the non-secure SP selected based on whether we=
're
              * currently in handler mode or not, using the NS CONTROL.SP=
SEL.
              */
             bool spsel =3D env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SP=
SEL_MASK;
@@ -12862,7 +12931,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32=
_t reg)
=20
 void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
 {
-    /* We're passed bits [11..0] of the instruction; extract
+    /*
+     * We're passed bits [11..0] of the instruction; extract
      * SYSm and the mask bits.
      * Invalid combinations of SYSm and mask are UNPREDICTABLE;
      * we choose to treat them as if the mask bits were valid.
@@ -12948,7 +13018,8 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t m=
askreg, uint32_t val)
             return;
         case 0x98: /* SP_NS */
         {
-            /* This gives the non-secure SP selected based on whether we=
're
+            /*
+             * This gives the non-secure SP selected based on whether we=
're
              * currently in handler mode or not, using the NS CONTROL.SP=
SEL.
              */
             bool spsel =3D env->v7m.control[M_REG_NS] & R_V7M_CONTROL_SP=
SEL_MASK;
@@ -13109,7 +13180,8 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_=
t addr, uint32_t op)
     bool targetsec =3D env->v7m.secure;
     bool is_subpage;
=20
-    /* Work out what the security state and privilege level we're
+    /*
+     * Work out what the security state and privilege level we're
      * interested in is...
      */
     if (alt) {
@@ -13126,12 +13198,14 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint3=
2_t addr, uint32_t op)
     /* ...and then figure out which MMU index this is */
     mmu_idx =3D arm_v7m_mmu_idx_for_secstate_and_priv(env, targetsec, ta=
rgetpriv);
=20
-    /* We know that the MPU and SAU don't care about the access type
+    /*
+     * We know that the MPU and SAU don't care about the access type
      * for our purposes beyond that we don't want to claim to be
      * an insn fetch, so we arbitrarily call this a read.
      */
=20
-    /* MPU region info only available for privileged or if
+    /*
+     * MPU region info only available for privileged or if
      * inspecting the other MPU state.
      */
     if (arm_current_el(env) !=3D 0 || alt) {
@@ -13236,7 +13310,8 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
=20
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
-    /* Implement DC ZVA, which zeroes a fixed-length block of memory.
+    /*
+     * Implement DC ZVA, which zeroes a fixed-length block of memory.
      * Note that we do not implement the (architecturally mandated)
      * alignment fault for attempts to use this on Device memory
      * (which matches the usual QEMU behaviour of not implementing eithe=
r
@@ -13249,7 +13324,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t va=
ddr_in)
=20
 #ifndef CONFIG_USER_ONLY
     {
-        /* Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
+        /*
+         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
          * the block size so we might have to do more than one TLB looku=
p.
          * We know that in fact for any v8 CPU the page size is at least=
 4K
          * and the block size must be 2K or less, but TARGET_PAGE_SIZE i=
s only
@@ -13276,7 +13352,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t va=
ddr_in)
                 }
             }
             if (i =3D=3D maxidx) {
-                /* If it's all in the TLB it's fair game for just writin=
g to;
+                /*
+                 * If it's all in the TLB it's fair game for just writin=
g to;
                  * we know we don't need to update dirty status, etc.
                  */
                 for (i =3D 0; i < maxidx - 1; i++) {
@@ -13285,7 +13362,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t va=
ddr_in)
                 memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE)=
);
                 return;
             }
-            /* OK, try a store and see if we can populate the tlb. This
+            /*
+             * OK, try a store and see if we can populate the tlb. This
              * might cause an exception if the memory isn't writable,
              * in which case we will longjmp out of here. We must for
              * this purpose use the actual register value passed to us
@@ -13301,7 +13379,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t va=
ddr_in)
             }
         }
=20
-        /* Slow path (probably attempt to do this to an I/O device or
+        /*
+         * Slow path (probably attempt to do this to an I/O device or
          * similar, or clearing of a block of code we have translations
          * cached for). Just do a series of byte writes as the architect=
ure
          * demands. It's not worth trying to use a cpu_physical_memory_m=
ap(),
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 4db254876d..b1952486c6 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -97,7 +97,8 @@ static inline uint32_t merge_syn_data_abort(uint32_t te=
mplate_syn,
 {
     uint32_t syn;
=20
-    /* ISV is only set for data aborts routed to EL2 and
+    /*
+     * ISV is only set for data aborts routed to EL2 and
      * never for stage-1 page table walks faulting on stage 2.
      *
      * Furthermore, ISV is only set for certain kinds of load/stores.
@@ -112,7 +113,8 @@ static inline uint32_t merge_syn_data_abort(uint32_t =
template_syn,
         syn =3D syn_data_abort_no_iss(same_el,
                                     ea, 0, s1ptw, is_write, fsc);
     } else {
-        /* Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the templ=
ate
+        /*
+         * Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the templ=
ate
          * syndrome created at translation time.
          * Now we create the runtime syndrome with the remaining fields.
          */
@@ -144,14 +146,16 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMU=
AccessType access_type,
=20
     if (target_el =3D=3D 2 || arm_el_is_aa64(env, target_el) ||
         arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
-        /* LPAE format fault status register : bottom 6 bits are
+        /*
+         * LPAE format fault status register : bottom 6 bits are
          * status code in the same form as needed for syndrome
          */
         fsr =3D arm_fi_to_lfsc(fi);
         fsc =3D extract32(fsr, 0, 6);
     } else {
         fsr =3D arm_fi_to_sfsc(fi);
-        /* Short format FSR : this fault will never actually be reported
+        /*
+         * Short format FSR : this fault will never actually be reported
          * to an EL that uses a syndrome register. Use a (currently)
          * reserved FSR code in case the constructed syndrome does leak
          * into the guest somehow.
@@ -194,7 +198,8 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr =
vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
=20
-/* arm_cpu_do_transaction_failed: handle a memory system error response
+/*
+ * arm_cpu_do_transaction_failed: handle a memory system error response
  * (eg "no device/memory present at address") by raising an external abo=
rt
  * exception
  */
@@ -970,7 +975,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     int bt;
     uint32_t contextidr;
=20
-    /* Links to unimplemented or non-context aware breakpoints are
+    /*
+     * Links to unimplemented or non-context aware breakpoints are
      * CONSTRAINED UNPREDICTABLE: either behave as if disabled, or
      * as if linked to an UNKNOWN context-aware breakpoint (in which
      * case DBGWCR<n>_EL1.LBN must indicate that breakpoint).
@@ -989,7 +995,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
=20
     bt =3D extract64(bcr, 20, 4);
=20
-    /* We match the whole register even if this is AArch32 using the
+    /*
+     * We match the whole register even if this is AArch32 using the
      * short descriptor format (in which case it holds both PROCID and A=
SID),
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
@@ -1020,7 +1028,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool =
is_wp)
     CPUARMState *env =3D &cpu->env;
     uint64_t cr;
     int pac, hmc, ssc, wt, lbn;
-    /* Note that for watchpoints the check is against the CPU security
+    /*
+     * Note that for watchpoints the check is against the CPU security
      * state, not the S/NS attribute on the offending data access.
      */
     bool is_secure =3D arm_is_secure(env);
@@ -1034,7 +1043,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool =
is_wp)
         }
         cr =3D env->cp15.dbgwcr[n];
         if (wp->hitattrs.user) {
-            /* The LDRT/STRT/LDT/STT "unprivileged access" instructions =
should
+            /*
+             * The LDRT/STRT/LDT/STT "unprivileged access" instructions =
should
              * match watchpoints as if they were accesses done at EL0, e=
ven if
              * the CPU is at EL1 or higher.
              */
@@ -1048,7 +1058,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool =
is_wp)
         }
         cr =3D env->cp15.dbgbcr[n];
     }
-    /* The WATCHPOINT_HIT flag guarantees us that the watchpoint is
+    /*
+     * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
      * enabled and that the address and access type match; for breakpoin=
ts
      * we know the address matched; check the remaining fields, includin=
g
      * linked breakpoints. We rely on WCR and BCR having the same layout
@@ -1116,7 +1127,8 @@ static bool check_watchpoints(ARMCPU *cpu)
     CPUARMState *env =3D &cpu->env;
     int n;
=20
-    /* If watchpoints are disabled globally or we can't take debug
+    /*
+     * If watchpoints are disabled globally or we can't take debug
      * exceptions here then watchpoint firings are ignored.
      */
     if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
@@ -1137,7 +1149,8 @@ static bool check_breakpoints(ARMCPU *cpu)
     CPUARMState *env =3D &cpu->env;
     int n;
=20
-    /* If breakpoints are disabled globally or we can't take debug
+    /*
+     * If breakpoints are disabled globally or we can't take debug
      * exceptions here then breakpoint firings are ignored.
      */
     if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
@@ -1164,7 +1177,8 @@ void HELPER(check_breakpoints)(CPUARMState *env)
=20
 bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
-    /* Called by core code when a CPU watchpoint fires; need to check if=
 this
+    /*
+     * Called by core code when a CPU watchpoint fires; need to check if=
 this
      * is also an architectural watchpoint match.
      */
     ARMCPU *cpu =3D ARM_CPU(cs);
@@ -1177,7 +1191,8 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, v=
addr addr, int len)
     ARMCPU *cpu =3D ARM_CPU(cs);
     CPUARMState *env =3D &cpu->env;
=20
-    /* In BE32 system mode, target memory is stored byteswapped (on a
+    /*
+     * In BE32 system mode, target memory is stored byteswapped (on a
      * little-endian host system), and by the time we reach here (via an
      * opcode helper) the addresses of subword accesses have been adjust=
ed
      * to account for that, which means that watchpoints will not match.
@@ -1196,7 +1211,8 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, v=
addr addr, int len)
=20
 void arm_debug_excp_handler(CPUState *cs)
 {
-    /* Called by core code when a watchpoint or breakpoint fires;
+    /*
+     * Called by core code when a watchpoint or breakpoint fires;
      * need to check which one and raise the appropriate exception.
      */
     ARMCPU *cpu =3D ARM_CPU(cs);
@@ -1220,7 +1236,8 @@ void arm_debug_excp_handler(CPUState *cs)
         uint64_t pc =3D is_a64(env) ? env->pc : env->regs[15];
         bool same_el =3D (arm_debug_target_el(env) =3D=3D arm_current_el=
(env));
=20
-        /* (1) GDB breakpoints should be handled first.
+        /*
+         * (1) GDB breakpoints should be handled first.
          * (2) Do not raise a CPU exception if no CPU breakpoint has fir=
ed,
          * since singlestep is also done by generating a debug internal
          * exception.
@@ -1231,7 +1248,8 @@ void arm_debug_excp_handler(CPUState *cs)
         }
=20
         env->exception.fsr =3D arm_debug_exception_fsr(env);
-        /* FAR is UNKNOWN: clear vaddress to avoid potentially exposing
+        /*
+         * FAR is UNKNOWN: clear vaddress to avoid potentially exposing
          * values to the guest that it shouldn't be able to see at its
          * exception/security level.
          */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index d3e83b627b..7ece78e987 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -170,7 +170,8 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t=
 val)
         set_default_nan_mode(dnan_enabled, &env->vfp.fp_status_f16);
     }
=20
-    /* The exception flags are ORed together when we read fpscr so we
+    /*
+     * The exception flags are ORed together when we read fpscr so we
      * only need to preserve the current state in one of our
      * float_status values.
      */
--=20
2.20.1


