Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB7CC31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E6621473
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E6621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcB2t-0007Jw-QK
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 11:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcAqy-00043N-Ka
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAqu-0000Uv-1i
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAqh-0008AO-9w; Sat, 15 Jun 2019 11:44:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35D1C882F2;
 Sat, 15 Jun 2019 15:44:09 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85A95106F752;
 Sat, 15 Jun 2019 15:44:07 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:35 +0200
Message-Id: <20190615154352.26824-7-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Sat, 15 Jun 2019 15:44:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/23] target/arm: Fix multiline comment
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 8c06fbdf36b checkpatch.pl enforce a new multiline
comment syntax. Since we'll move this code around, fix its style
first.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c    | 213 +++++++++++++++++++++++++++--------------
 target/arm/op_helper.c |  27 ++++--
 2 files changed, 160 insertions(+), 80 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d3f3cb57d5..9a3766b759 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7531,7 +7531,8 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t f=
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
@@ -7803,7 +7804,8 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t a=
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
@@ -7878,7 +7880,8 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *d=
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
@@ -7979,7 +7982,8 @@ void HELPER(v7m_preserve_fp_state)(CPUARMState *env=
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
@@ -8007,7 +8011,8 @@ static void write_v7m_control_spsel_for_secstate(CP=
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
@@ -8017,7 +8022,8 @@ static void write_v7m_control_spsel(CPUARMState *en=
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
@@ -8043,7 +8049,8 @@ static void switch_v7m_security_state(CPUARMState *=
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
@@ -8070,7 +8077,8 @@ static void switch_v7m_security_state(CPUARMState *=
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
@@ -8085,7 +8093,8 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t de=
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
@@ -8110,7 +8119,8 @@ void HELPER(v7m_bxns)(CPUARMState *env, uint32_t de=
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
@@ -8123,7 +8133,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t d=
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
@@ -8154,7 +8165,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t d=
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
@@ -8169,7 +8181,8 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t d=
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
@@ -8215,7 +8228,8 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int ex=
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
@@ -8246,7 +8260,8 @@ static bool arm_v7m_load_vector(ARMCPU *cpu, int ex=
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
@@ -8278,7 +8293,8 @@ static uint32_t v7m_integrity_sig(CPUARMState *env,=
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
@@ -8329,7 +8345,8 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint=
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
@@ -8353,7 +8370,8 @@ static bool v7m_push_callee_stack(ARMCPU *cpu, uint=
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
@@ -8378,13 +8396,15 @@ static void v7m_exception_taken(ARMCPU *cpu, uint=
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
@@ -8393,7 +8413,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32=
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
@@ -8415,14 +8436,16 @@ static void v7m_exception_taken(ARMCPU *cpu, uint=
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
@@ -8443,7 +8466,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32=
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
@@ -8460,7 +8484,8 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32=
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
@@ -8663,7 +8688,8 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t f=
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
@@ -8731,7 +8757,8 @@ static bool v7m_push_stack(ARMCPU *cpu)
         }
     }
=20
-    /* Write as much of the stack frame as we can. If we fail a stack
+    /*
+     * Write as much of the stack frame as we can. If we fail a stack
      * write this will result in a derived exception being pended
      * (which may be taken in preference to the one we started with
      * if it has higher priority).
@@ -8848,7 +8875,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool ftype;
     bool restore_s16_s31;
=20
-    /* If we're not in Handler mode then jumps to magic exception-exit
+    /*
+     * If we're not in Handler mode then jumps to magic exception-exit
      * addresses don't have magic behaviour. However for the v8M
      * security extensions the magic secure-function-return has to
      * work in thread mode too, so to avoid doing an extra check in
@@ -8862,7 +8890,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         return;
     }
=20
-    /* In the spec pseudocode ExceptionReturn() is called directly
+    /*
+     * In the spec pseudocode ExceptionReturn() is called directly
      * from BXWritePC() and gets the full target PC value including
      * bit zero. In QEMU's implementation we treat it as a normal
      * jump-to-register (which is then caught later on), and so split
@@ -8895,7 +8924,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -8909,7 +8939,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
=20
     if (env->v7m.exception !=3D ARMV7M_EXCP_NMI) {
-        /* Auto-clear FAULTMASK on return from other than NMI.
+        /*
+         * Auto-clear FAULTMASK on return from other than NMI.
          * If the security extension is implemented then this only
          * happens if the raw execution priority is >=3D 0; the
          * value of the ES bit in the exception return value indicates
@@ -8934,7 +8965,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -8951,7 +8983,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -8970,7 +9003,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             break;
         case 13: /* Return to Thread using Process stack */
         case 9: /* Return to Thread using Main stack */
-            /* We only need to check NONBASETHRDENA for v7M, because in
+            /*
+             * We only need to check NONBASETHRDENA for v7M, because in
              * v8M this bit does not exist (it is RES1).
              */
             if (!rettobase &&
@@ -9028,7 +9062,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     }
=20
     if (ufault) {
-        /* Bad exception return: instead of popping the exception
+        /*
+         * Bad exception return: instead of popping the exception
          * stack, directly take a usage fault on the current stack.
          */
         env->v7m.cfsr[env->v7m.secure] |=3D R_V7M_CFSR_INVPC_MASK;
@@ -9058,7 +9093,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -9131,7 +9167,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -9139,7 +9176,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -9157,13 +9195,15 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -9278,7 +9318,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -9304,13 +9345,15 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
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
@@ -9332,7 +9375,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
=20
 static bool do_v7m_function_return(ARMCPU *cpu)
 {
-    /* v8M security extensions magic function return.
+    /*
+     * v8M security extensions magic function return.
      * We may either:
      *  (1) throw an exception (longjump)
      *  (2) return true if we successfully handled the function return
@@ -9362,7 +9406,8 @@ static bool do_v7m_function_return(ARMCPU *cpu)
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
@@ -9443,7 +9488,8 @@ static void arm_log_exception(int idx)
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
@@ -9466,7 +9512,8 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUI=
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
@@ -9496,7 +9543,8 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUI=
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
@@ -9505,7 +9553,8 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     ARMMMUIdx mmu_idx;
     uint16_t insn;
=20
-    /* We should never get here unless get_phys_addr_pmsav8() caused
+    /*
+     * We should never get here unless get_phys_addr_pmsav8() caused
      * an exception for NS executing in S&NSC memory.
      */
     assert(!env->v7m.secure);
@@ -9523,7 +9572,8 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
     }
=20
     if (insn !=3D 0xe97f) {
-        /* Not an SG instruction first half (we choose the IMPDEF
+        /*
+         * Not an SG instruction first half (we choose the IMPDEF
          * early-SG-check option).
          */
         goto gen_invep;
@@ -9534,13 +9584,15 @@ static bool v7m_handle_execute_nsc(ARMCPU *cpu)
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
@@ -9569,8 +9621,10 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
@@ -9616,13 +9670,15 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
@@ -9635,7 +9691,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
@@ -9677,7 +9734,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
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
@@ -9743,7 +9801,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     if (arm_feature(env, ARM_FEATURE_V8)) {
         lr =3D R_V7M_EXCRET_RES1_MASK |
             R_V7M_EXCRET_DCRS_MASK;
-        /* The S bit indicates whether we should return to Secure
+        /*
+         * The S bit indicates whether we should return to Secure
          * or NonSecure (ie our current state).
          * The ES bit indicates whether we're taking this exception
          * to Secure or NonSecure (ie our target state). We set it
@@ -12760,7 +12819,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32=
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
@@ -12813,7 +12873,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32=
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
@@ -12864,7 +12925,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32=
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
@@ -12950,7 +13012,8 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t m=
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
@@ -13111,7 +13174,8 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_=
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
@@ -13128,12 +13192,14 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint3=
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
@@ -13238,7 +13304,8 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address=
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
@@ -13251,7 +13318,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t va=
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
@@ -13278,7 +13346,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t va=
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
@@ -13287,7 +13356,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t va=
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
@@ -13303,7 +13373,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t va=
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
index 4db254876d..db4254a67b 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -970,7 +970,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     int bt;
     uint32_t contextidr;
=20
-    /* Links to unimplemented or non-context aware breakpoints are
+    /*
+     * Links to unimplemented or non-context aware breakpoints are
      * CONSTRAINED UNPREDICTABLE: either behave as if disabled, or
      * as if linked to an UNKNOWN context-aware breakpoint (in which
      * case DBGWCR<n>_EL1.LBN must indicate that breakpoint).
@@ -989,7 +990,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
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
@@ -1006,7 +1008,8 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     case 9: /* linked VMID match (reserved if no EL2) */
     case 11: /* linked context ID and VMID match (reserved if no EL2) */
     default:
-        /* Links to Unlinked context breakpoints must generate no
+        /*
+         * Links to Unlinked context breakpoints must generate no
          * events; we choose to do the same for reserved values too.
          */
         return false;
@@ -1020,7 +1023,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool =
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
@@ -1034,7 +1038,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool =
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
@@ -1048,7 +1053,8 @@ static bool bp_wp_matches(ARMCPU *cpu, int n, bool =
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
@@ -1116,7 +1122,8 @@ static bool check_watchpoints(ARMCPU *cpu)
     CPUARMState *env =3D &cpu->env;
     int n;
=20
-    /* If watchpoints are disabled globally or we can't take debug
+    /*
+     * If watchpoints are disabled globally or we can't take debug
      * exceptions here then watchpoint firings are ignored.
      */
     if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
@@ -1164,7 +1171,8 @@ void HELPER(check_breakpoints)(CPUARMState *env)
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
@@ -1177,7 +1185,8 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, v=
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
--=20
2.20.1


