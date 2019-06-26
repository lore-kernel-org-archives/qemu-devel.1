Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C95C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2DEF20665
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DEF20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAhs-00079G-2N
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55846)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgAfw-0005h0-NZ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgAfp-0006nK-VL
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:21:36 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hgAfn-0006gE-Vx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:21:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MxmBc-1iVE3H2try-00zH9n; Wed, 26 Jun 2019 18:21:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 18:20:59 +0200
Message-Id: <20190626162100.24774-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626162100.24774-1-laurent@vivier.eu>
References: <20190626162100.24774-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HkT2c8+68ggExJ3KAUw6upqQzv45D6qgw2IlFL7QaUdAWyOTaK0
 AtqoEOauVnxTaSEWWYNiFpwFvs/yIvyJUcM/9aYL235VwqX3M/jzbE/g/31tfLxHgoseAbb
 oxX+pM0SqpD8oeQiMyrADjIaXL26QWcoUz96aiwZTs6hruAM34rjKtPBg8kDomG3/IgubzX
 U2NLVeqqm30Fb30/30bLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F/Jx8s1RcwY=:wQXpOLFX8gCLG+Jboa91la
 wIzO4NOEtiOjswkXG4/FlvKSjsFhpBSUgRRg/dB6QPrNPntBfy2gdrnWVxLbROBlcRTzyXqyG
 WJfuaNyLvoaUlKjND9l4t1upMlVMMgfl2+OPnwFZndwIWg/DdsaCRbedIg0BR5rCsY5czJTwU
 oAFFXT0VTkAAnQKF8/5UqWpsA+UELNS822Yd/e9BP4mHo7lVMbU6ewNm7IRHWEcb33PCxooxU
 VRifm1y0xoGPkuGHLaVHhYjayNwOdNk2KQOz3u6SDKUXgv8h9RtVcuqutM3a3M7FzecEzLOYF
 QCC2pYtDyz5qvHZO1I2zkhp9NWeZwZc84MQIY+9yz226xgRhbPEl08boUOgqdSSg4Nl4EeYQT
 f9sH/TWPB9RDbwL8B1yoOvw9eoSmaALl3p8HKxLmeInq+Zk/BiOVaWbj3e0wlhzogPPdV032c
 Izb02/71Ap9ckqxzjiEJDT1H5qmGulhaVRaGOEk2CcmdRtVX/lhtJkoePCDfGOzz/skKBXeIA
 aoVFqlQjxmHrxTxAY3YOBHjgESzL1+R6ZWPIRMa7/Y1PhuNK936k7kX0j9uyEQ9b/bvJX5BIG
 yOIHuXkW3bFjRMD2oxkE2AKRXTxw4pV3opgnfKy+/OkTJOxc6Oa7WXPzSZJ6L3uS+6NDC1EnE
 RM1DFqZWThALhHfXULq2DaolUVpn1zZgsP9UplEw0k3QRlL8HdDTLTkWwK+NenlLOZ3GHtMLe
 a41JIWqmW5slP78GUdmZagh5p1MyX/ZDRNQYWA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 2/3] m68k comments break patch submission due to
 being incorrectly formatted
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>

Altering all comments in target/m68k to match Qemu coding styles so that future
patches wont fail due to style breaches.

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190606234125.GA4830@localhost.localdomain>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu-qom.h               |   2 +-
 target/m68k/cpu.c                   |   6 +-
 target/m68k/cpu.h                   |  29 ++--
 target/m68k/fpu_helper.c            |   6 +-
 target/m68k/gdbstub.c               |   6 +-
 target/m68k/helper.c                |  16 +-
 target/m68k/m68k-semi.c             |  24 ++-
 target/m68k/op_helper.c             |  58 ++++---
 target/m68k/softfloat.c             | 181 ++++++++++----------
 target/m68k/softfloat.h             |   3 +-
 target/m68k/softfloat_fpsp_tables.h |   3 +-
 target/m68k/translate.c             | 246 ++++++++++++++++++----------
 12 files changed, 353 insertions(+), 227 deletions(-)

diff --git a/target/m68k/cpu-qom.h b/target/m68k/cpu-qom.h
index 9885bba317..0c157251a2 100644
--- a/target/m68k/cpu-qom.h
+++ b/target/m68k/cpu-qom.h
@@ -31,7 +31,7 @@
 #define M68K_CPU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(M68kCPUClass, (obj), TYPE_M68K_CPU)
 
-/**
+/*
  * M68kCPUClass:
  * @parent_realize: The parent class' realize handler.
  * @parent_reset: The parent class' reset handler.
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 3d0971d4a2..e6596de29c 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -203,8 +203,10 @@ static void any_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_CF_ISA_APLUSC);
     m68k_set_feature(env, M68K_FEATURE_BRAL);
     m68k_set_feature(env, M68K_FEATURE_CF_FPU);
-    /* MAC and EMAC are mututally exclusive, so pick EMAC.
-       It's mostly backwards compatible.  */
+    /*
+     * MAC and EMAC are mututally exclusive, so pick EMAC.
+     * It's mostly backwards compatible.
+     */
     m68k_set_feature(env, M68K_FEATURE_CF_EMAC);
     m68k_set_feature(env, M68K_FEATURE_CF_EMAC_B);
     m68k_set_feature(env, M68K_FEATURE_USP);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 5ef200a9fb..20de3c379a 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -106,9 +106,11 @@ typedef struct CPUM68KState {
     float_status fp_status;
 
     uint64_t mactmp;
-    /* EMAC Hardware deals with 48-bit values composed of one 32-bit and
-       two 8-bit parts.  We store a single 64-bit value and
-       rearrange/extend this when changing modes.  */
+    /*
+     * EMAC Hardware deals with 48-bit values composed of one 32-bit and
+     * two 8-bit parts.  We store a single 64-bit value and
+     * rearrange/extend this when changing modes.
+     */
     uint64_t macc[4];
     uint32_t macsr;
     uint32_t mac_mask;
@@ -146,7 +148,7 @@ typedef struct CPUM68KState {
     uint32_t features;
 } CPUM68KState;
 
-/**
+/*
  * M68kCPU:
  * @env: #CPUM68KState
  *
@@ -171,9 +173,11 @@ int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void m68k_tcg_init(void);
 void m68k_cpu_init_gdb(M68kCPU *cpu);
-/* you can call this signal handler from your SIGBUS and SIGSEGV
-   signal handlers to inform the virtual CPU of exceptions. non zero
-   is returned if the signal was handled by the virtual CPU.  */
+/*
+ * you can call this signal handler from your SIGBUS and SIGSEGV
+ * signal handlers to inform the virtual CPU of exceptions. non zero
+ * is returned if the signal was handled by the virtual CPU.
+ */
 int cpu_m68k_signal_handler(int host_signum, void *pinfo,
                            void *puc);
 uint32_t cpu_m68k_get_ccr(CPUM68KState *env);
@@ -182,7 +186,8 @@ void cpu_m68k_set_sr(CPUM68KState *env, uint32_t);
 void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
 
 
-/* Instead of computing the condition codes after each m68k instruction,
+/*
+ * Instead of computing the condition codes after each m68k instruction,
  * QEMU just stores one operand (called CC_SRC), the result
  * (called CC_DEST) and the type of operation (called CC_OP). When the
  * condition codes are needed, the condition codes can be calculated
@@ -447,9 +452,11 @@ void m68k_switch_sp(CPUM68KState *env);
 
 void do_m68k_semihosting(CPUM68KState *env, int nr);
 
-/* There are 4 ColdFire core ISA revisions: A, A+, B and C.
-   Each feature covers the subset of instructions common to the
-   ISA revisions mentioned.  */
+/*
+ * There are 4 ColdFire core ISA revisions: A, A+, B and C.
+ * Each feature covers the subset of instructions common to the
+ * ISA revisions mentioned.
+ */
 
 enum m68k_features {
     M68K_FEATURE_M68000,
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index b35489ba4e..9b039c856d 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -25,7 +25,8 @@
 #include "exec/cpu_ldst.h"
 #include "softfloat.h"
 
-/* Undefined offsets may be different on various FPU.
+/*
+ * Undefined offsets may be different on various FPU.
  * On 68040 they return 0.0 (floatx80_zero)
  */
 
@@ -611,7 +612,8 @@ void HELPER(fcos)(CPUM68KState *env, FPReg *res, FPReg *val)
 void HELPER(fsincos)(CPUM68KState *env, FPReg *res0, FPReg *res1, FPReg *val)
 {
     floatx80 a = val->d;
-    /* If res0 and res1 specify the same floating-point data register,
+    /*
+     * If res0 and res1 specify the same floating-point data register,
      * the sine result is stored in the register, and the cosine
      * result is discarded.
      */
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index 5cad2b658f..fdc96f57ff 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -41,8 +41,10 @@ int m68k_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
             return gdb_get_reg32(mem_buf, env->pc);
         }
     }
-    /* FP registers not included here because they vary between
-       ColdFire and m68k.  Use XML bits for these.  */
+    /*
+     * FP registers not included here because they vary between
+     * ColdFire and m68k.  Use XML bits for these.
+     */
     return 0;
 }
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 31aacb51c6..ae766a6cb0 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -965,9 +965,11 @@ void HELPER(set_sr)(CPUM68KState *env, uint32_t val)
 }
 
 /* MAC unit.  */
-/* FIXME: The MAC unit implementation is a bit of a mess.  Some helpers
-   take values,  others take register numbers and manipulate the contents
-   in-place.  */
+/*
+ * FIXME: The MAC unit implementation is a bit of a mess.  Some helpers
+ * take values,  others take register numbers and manipulate the contents
+ * in-place.
+ */
 void HELPER(mac_move)(CPUM68KState *env, uint32_t dest, uint32_t src)
 {
     uint32_t mask;
@@ -1047,9 +1049,11 @@ void HELPER(macsats)(CPUM68KState *env, uint32_t acc)
     if (env->macsr & MACSR_V) {
         env->macsr |= MACSR_PAV0 << acc;
         if (env->macsr & MACSR_OMC) {
-            /* The result is saturated to 32 bits, despite overflow occurring
-               at 48 bits.  Seems weird, but that's what the hardware docs
-               say.  */
+            /*
+             * The result is saturated to 32 bits, despite overflow occurring
+             * at 48 bits.  Seems weird, but that's what the hardware docs
+             * say.
+             */
             result = (result >> 63) ^ 0x7fffffff;
         }
     }
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index f97580af83..01627b42c9 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -130,7 +130,8 @@ static void m68k_semi_return_u32(CPUM68KState *env, uint32_t ret, uint32_t err)
     target_ulong args = env->dregs[1];
     if (put_user_u32(ret, args) ||
         put_user_u32(err, args + 4)) {
-        /* The m68k semihosting ABI does not provide any way to report this
+        /*
+         * The m68k semihosting ABI does not provide any way to report this
          * error to the guest, so the best we can do is log it in qemu.
          * It is always a guest error not to pass us a valid argument block.
          */
@@ -159,8 +160,10 @@ static void m68k_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
     CPUM68KState *env = &cpu->env;
 
     if (m68k_semi_is_fseek) {
-        /* FIXME: We've already lost the high bits of the fseek
-           return value.  */
+        /*
+         * FIXME: We've already lost the high bits of the fseek
+         * return value.
+         */
         m68k_semi_return_u64(env, ret, err);
         m68k_semi_is_fseek = 0;
     } else {
@@ -168,7 +171,8 @@ static void m68k_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
     }
 }
 
-/* Read the input value from the argument block; fail the semihosting
+/*
+ * Read the input value from the argument block; fail the semihosting
  * call if the memory read fails.
  */
 #define GET_ARG(n) do {                                 \
@@ -440,14 +444,18 @@ void do_m68k_semihosting(CPUM68KState *env, int nr)
             }
             ts->heap_limit = base + size;
         }
-        /* This call may happen before we have writable memory, so return
-           values directly in registers.  */
+        /*
+         * This call may happen before we have writable memory, so return
+         * values directly in registers.
+         */
         env->dregs[1] = ts->heap_limit;
         env->aregs[7] = ts->stack_base;
         }
 #else
-        /* FIXME: This is wrong for boards where RAM does not start at
-           address zero.  */
+        /*
+         * FIXME: This is wrong for boards where RAM does not start at
+         * address zero.
+         */
         env->dregs[1] = ram_size;
         env->aregs[7] = ram_size;
 #endif
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index ebcfe3dfdd..bc4f845e3f 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -494,10 +494,12 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
     if (interrupt_request & CPU_INTERRUPT_HARD
         && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
-        /* Real hardware gets the interrupt vector via an IACK cycle
-           at this point.  Current emulated hardware doesn't rely on
-           this, so we provide/save the vector when the interrupt is
-           first signalled.  */
+        /*
+         * Real hardware gets the interrupt vector via an IACK cycle
+         * at this point.  Current emulated hardware doesn't rely on
+         * this, so we provide/save the vector when the interrupt is
+         * first signalled.
+         */
         cs->exception_index = env->pending_vector;
         do_interrupt_m68k_hardirq(env);
         return true;
@@ -537,7 +539,8 @@ void HELPER(divuw)(CPUM68KState *env, int destr, uint32_t den)
     env->cc_c = 0; /* always cleared, even if overflow */
     if (quot > 0xffff) {
         env->cc_v = -1;
-        /* real 68040 keeps N and unset Z on overflow,
+        /*
+         * real 68040 keeps N and unset Z on overflow,
          * whereas documentation says "undefined"
          */
         env->cc_z = 1;
@@ -564,7 +567,8 @@ void HELPER(divsw)(CPUM68KState *env, int destr, int32_t den)
     if (quot != (int16_t)quot) {
         env->cc_v = -1;
         /* nothing else is modified */
-        /* real 68040 keeps N and unset Z on overflow,
+        /*
+         * real 68040 keeps N and unset Z on overflow,
          * whereas documentation says "undefined"
          */
         env->cc_z = 1;
@@ -647,7 +651,8 @@ void HELPER(divull)(CPUM68KState *env, int numr, int regr, uint32_t den)
     env->cc_c = 0; /* always cleared, even if overflow */
     if (quot > 0xffffffffULL) {
         env->cc_v = -1;
-        /* real 68040 keeps N and unset Z on overflow,
+        /*
+         * real 68040 keeps N and unset Z on overflow,
          * whereas documentation says "undefined"
          */
         env->cc_z = 1;
@@ -681,7 +686,8 @@ void HELPER(divsll)(CPUM68KState *env, int numr, int regr, int32_t den)
     env->cc_c = 0; /* always cleared, even if overflow */
     if (quot != (int32_t)quot) {
         env->cc_v = -1;
-        /* real 68040 keeps N and unset Z on overflow,
+        /*
+         * real 68040 keeps N and unset Z on overflow,
          * whereas documentation says "undefined"
          */
         env->cc_z = 1;
@@ -838,14 +844,18 @@ static struct bf_data bf_prep(uint32_t addr, int32_t ofs, uint32_t len)
         addr -= 1;
     }
 
-    /* Compute the number of bytes required (minus one) to
-       satisfy the bitfield.  */
+    /*
+     * Compute the number of bytes required (minus one) to
+     * satisfy the bitfield.
+     */
     blen = (bofs + len - 1) / 8;
 
-    /* Canonicalize the bit offset for data loaded into a 64-bit big-endian
-       word.  For the cases where BLEN is not a power of 2, adjust ADDR so
-       that we can use the next power of two sized load without crossing a
-       page boundary, unless the field itself crosses the boundary.  */
+    /*
+     * Canonicalize the bit offset for data loaded into a 64-bit big-endian
+     * word.  For the cases where BLEN is not a power of 2, adjust ADDR so
+     * that we can use the next power of two sized load without crossing a
+     * page boundary, unless the field itself crosses the boundary.
+     */
     switch (blen) {
     case 0:
         bofs += 56;
@@ -937,8 +947,10 @@ uint64_t HELPER(bfextu_mem)(CPUM68KState *env, uint32_t addr,
     struct bf_data d = bf_prep(addr, ofs, len);
     uint64_t data = bf_load(env, d.addr, d.blen, ra);
 
-    /* Put CC_N at the top of the high word; put the zero-extended value
-       at the bottom of the low word.  */
+    /*
+     * Put CC_N at the top of the high word; put the zero-extended value
+     * at the bottom of the low word.
+     */
     data <<= d.bofs;
     data >>= 64 - d.len;
     data |= data << (64 - d.len);
@@ -1016,15 +1028,18 @@ uint64_t HELPER(bfffo_mem)(CPUM68KState *env, uint32_t addr,
     uint64_t n = (data & mask) << d.bofs;
     uint32_t ffo = helper_bfffo_reg(n >> 32, ofs, d.len);
 
-    /* Return FFO in the low word and N in the high word.
-       Note that because of MASK and the shift, the low word
-       is already zero.  */
+    /*
+     * Return FFO in the low word and N in the high word.
+     * Note that because of MASK and the shift, the low word
+     * is already zero.
+     */
     return n | ffo;
 }
 
 void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
 {
-    /* From the specs:
+    /*
+     * From the specs:
      *   X: Not affected, C,V,Z: Undefined,
      *   N: Set if val < 0; cleared if val > ub, undefined otherwise
      * We implement here values found from a real MC68040:
@@ -1054,7 +1069,8 @@ void HELPER(chk)(CPUM68KState *env, int32_t val, int32_t ub)
 
 void HELPER(chk2)(CPUM68KState *env, int32_t val, int32_t lb, int32_t ub)
 {
-    /* From the specs:
+    /*
+     * From the specs:
      *   X: Not affected, N,V: Undefined,
      *   Z: Set if val is equal to lb or ub
      *   C: Set if val < lb or val > ub, cleared otherwise
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index b45a5e8690..591a6f1dce 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -14,7 +14,8 @@
  * the Softfloat-2a license unless specifically indicated otherwise.
  */
 
-/* Portions of this work are licensed under the terms of the GNU GPL,
+/*
+ * Portions of this work are licensed under the terms of the GNU GPL,
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
@@ -41,10 +42,10 @@ static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
     return a;
 }
 
-/*----------------------------------------------------------------------------
- | Returns the modulo remainder of the extended double-precision floating-point
- | value `a' with respect to the corresponding value `b'.
- *----------------------------------------------------------------------------*/
+/*
+ * Returns the modulo remainder of the extended double-precision floating-point
+ * value `a' with respect to the corresponding value `b'.
+ */
 
 floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
 {
@@ -124,10 +125,10 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
             80, zSign, bExp + expDiff, aSig0, aSig1, status);
 }
 
-/*----------------------------------------------------------------------------
- | Returns the mantissa of the extended double-precision floating-point
- | value `a'.
- *----------------------------------------------------------------------------*/
+/*
+ * Returns the mantissa of the extended double-precision floating-point
+ * value `a'.
+ */
 
 floatx80 floatx80_getman(floatx80 a, float_status *status)
 {
@@ -158,10 +159,10 @@ floatx80 floatx80_getman(floatx80 a, float_status *status)
                                 0x3FFF, aSig, 0, status);
 }
 
-/*----------------------------------------------------------------------------
- | Returns the exponent of the extended double-precision floating-point
- | value `a' as an extended double-precision value.
- *----------------------------------------------------------------------------*/
+/*
+ * Returns the exponent of the extended double-precision floating-point
+ * value `a' as an extended double-precision value.
+ */
 
 floatx80 floatx80_getexp(floatx80 a, float_status *status)
 {
@@ -191,13 +192,13 @@ floatx80 floatx80_getexp(floatx80 a, float_status *status)
     return int32_to_floatx80(aExp - 0x3FFF, status);
 }
 
-/*----------------------------------------------------------------------------
- | Scales extended double-precision floating-point value in operand `a' by
- | value `b'. The function truncates the value in the second operand 'b' to
- | an integral value and adds that value to the exponent of the operand 'a'.
- | The operation performed according to the IEC/IEEE Standard for Binary
- | Floating-Point Arithmetic.
- *----------------------------------------------------------------------------*/
+/*
+ * Scales extended double-precision floating-point value in operand `a' by
+ * value `b'. The function truncates the value in the second operand 'b' to
+ * an integral value and adds that value to the exponent of the operand 'a'.
+ * The operation performed according to the IEC/IEEE Standard for Binary
+ * Floating-Point Arithmetic.
+ */
 
 floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
 {
@@ -282,26 +283,26 @@ floatx80 floatx80_move(floatx80 a, float_status *status)
                                 aExp, aSig, 0, status);
 }
 
-/*----------------------------------------------------------------------------
-| Algorithms for transcendental functions supported by MC68881 and MC68882
-| mathematical coprocessors. The functions are derived from FPSP library.
-*----------------------------------------------------------------------------*/
+/*
+ * Algorithms for transcendental functions supported by MC68881 and MC68882
+ * mathematical coprocessors. The functions are derived from FPSP library.
+ */
 
 #define one_exp     0x3FFF
 #define one_sig     LIT64(0x8000000000000000)
 
-/*----------------------------------------------------------------------------
- | Function for compactifying extended double-precision floating point values.
- *----------------------------------------------------------------------------*/
+/*
+ * Function for compactifying extended double-precision floating point values.
+ */
 
 static int32_t floatx80_make_compact(int32_t aExp, uint64_t aSig)
 {
     return (aExp << 16) | (aSig >> 48);
 }
 
-/*----------------------------------------------------------------------------
- | Log base e of x plus 1
- *----------------------------------------------------------------------------*/
+/*
+ * Log base e of x plus 1
+ */
 
 floatx80 floatx80_lognp1(floatx80 a, float_status *status)
 {
@@ -498,9 +499,9 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Log base e
- *----------------------------------------------------------------------------*/
+/*
+ * Log base e
+ */
 
 floatx80 floatx80_logn(floatx80 a, float_status *status)
 {
@@ -666,9 +667,9 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Log base 10
- *----------------------------------------------------------------------------*/
+/*
+ * Log base 10
+ */
 
 floatx80 floatx80_log10(floatx80 a, float_status *status)
 {
@@ -723,9 +724,9 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
     return a;
 }
 
-/*----------------------------------------------------------------------------
- | Log base 2
- *----------------------------------------------------------------------------*/
+/*
+ * Log base 2
+ */
 
 floatx80 floatx80_log2(floatx80 a, float_status *status)
 {
@@ -790,9 +791,9 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
     return a;
 }
 
-/*----------------------------------------------------------------------------
- | e to x
- *----------------------------------------------------------------------------*/
+/*
+ * e to x
+ */
 
 floatx80 floatx80_etox(floatx80 a, float_status *status)
 {
@@ -848,7 +849,8 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
             j = n & 0x3F; /* J = N mod 64 */
             m = n / 64; /* NOTE: this is really arithmetic right shift by 6 */
             if (n < 0 && j) {
-                /* arithmetic right shift is division and
+                /*
+                 * arithmetic right shift is division and
                  * round towards minus infinity
                  */
                 m--;
@@ -973,9 +975,9 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | 2 to x
- *----------------------------------------------------------------------------*/
+/*
+ * 2 to x
+ */
 
 floatx80 floatx80_twotox(floatx80 a, float_status *status)
 {
@@ -1051,14 +1053,16 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         j = n & 0x3F;
         l = n / 64; /* NOTE: this is really arithmetic right shift by 6 */
         if (n < 0 && j) {
-            /* arithmetic right shift is division and
+            /*
+             * arithmetic right shift is division and
              * round towards minus infinity
              */
             l--;
         }
         m = l / 2; /* NOTE: this is really arithmetic right shift by 1 */
         if (l < 0 && (l & 1)) {
-            /* arithmetic right shift is division and
+            /*
+             * arithmetic right shift is division and
              * round towards minus infinity
              */
             m--;
@@ -1121,9 +1125,9 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | 10 to x
- *----------------------------------------------------------------------------*/
+/*
+ * 10 to x
+ */
 
 floatx80 floatx80_tentox(floatx80 a, float_status *status)
 {
@@ -1200,14 +1204,16 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         j = n & 0x3F;
         l = n / 64; /* NOTE: this is really arithmetic right shift by 6 */
         if (n < 0 && j) {
-            /* arithmetic right shift is division and
+            /*
+             * arithmetic right shift is division and
              * round towards minus infinity
              */
             l--;
         }
         m = l / 2; /* NOTE: this is really arithmetic right shift by 1 */
         if (l < 0 && (l & 1)) {
-            /* arithmetic right shift is division and
+            /*
+             * arithmetic right shift is division and
              * round towards minus infinity
              */
             m--;
@@ -1274,9 +1280,9 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Tangent
- *----------------------------------------------------------------------------*/
+/*
+ * Tangent
+ */
 
 floatx80 floatx80_tan(floatx80 a, float_status *status)
 {
@@ -1484,9 +1490,9 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Sine
- *----------------------------------------------------------------------------*/
+/*
+ * Sine
+ */
 
 floatx80 floatx80_sin(floatx80 a, float_status *status)
 {
@@ -1723,9 +1729,9 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Cosine
- *----------------------------------------------------------------------------*/
+/*
+ * Cosine
+ */
 
 floatx80 floatx80_cos(floatx80 a, float_status *status)
 {
@@ -1960,9 +1966,9 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Arc tangent
- *----------------------------------------------------------------------------*/
+/*
+ * Arc tangent
+ */
 
 floatx80 floatx80_atan(floatx80 a, float_status *status)
 {
@@ -2157,9 +2163,9 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Arc sine
- *----------------------------------------------------------------------------*/
+/*
+ * Arc sine
+ */
 
 floatx80 floatx80_asin(floatx80 a, float_status *status)
 {
@@ -2222,9 +2228,9 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
     return a;
 }
 
-/*----------------------------------------------------------------------------
- | Arc cosine
- *----------------------------------------------------------------------------*/
+/*
+ * Arc cosine
+ */
 
 floatx80 floatx80_acos(floatx80 a, float_status *status)
 {
@@ -2291,9 +2297,9 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
     return a;
 }
 
-/*----------------------------------------------------------------------------
- | Hyperbolic arc tangent
- *----------------------------------------------------------------------------*/
+/*
+ * Hyperbolic arc tangent
+ */
 
 floatx80 floatx80_atanh(floatx80 a, float_status *status)
 {
@@ -2356,9 +2362,9 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
     return a;
 }
 
-/*----------------------------------------------------------------------------
- | e to x minus 1
- *----------------------------------------------------------------------------*/
+/*
+ * e to x minus 1
+ */
 
 floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
 {
@@ -2410,7 +2416,8 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
             j = n & 0x3F; /* J = N mod 64 */
             m = n / 64; /* NOTE: this is really arithmetic right shift by 6 */
             if (n < 0 && j) {
-                /* arithmetic right shift is division and
+                /*
+                 * arithmetic right shift is division and
                  * round towards minus infinity
                  */
                 m--;
@@ -2607,9 +2614,9 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Hyperbolic tangent
- *----------------------------------------------------------------------------*/
+/*
+ * Hyperbolic tangent
+ */
 
 floatx80 floatx80_tanh(floatx80 a, float_status *status)
 {
@@ -2722,9 +2729,9 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Hyperbolic sine
- *----------------------------------------------------------------------------*/
+/*
+ * Hyperbolic sine
+ */
 
 floatx80 floatx80_sinh(floatx80 a, float_status *status)
 {
@@ -2811,9 +2818,9 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
- | Hyperbolic cosine
- *----------------------------------------------------------------------------*/
+/*
+ * Hyperbolic cosine
+ */
 
 floatx80 floatx80_cosh(floatx80 a, float_status *status)
 {
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 602661d5a8..365ef6ac7a 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -14,7 +14,8 @@
  * the Softfloat-2a license unless specifically indicated otherwise.
  */
 
-/* Portions of this work are licensed under the terms of the GNU GPL,
+/*
+ * Portions of this work are licensed under the terms of the GNU GPL,
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
diff --git a/target/m68k/softfloat_fpsp_tables.h b/target/m68k/softfloat_fpsp_tables.h
index 3f1419ee6e..2ccd9e8bc3 100644
--- a/target/m68k/softfloat_fpsp_tables.h
+++ b/target/m68k/softfloat_fpsp_tables.h
@@ -14,7 +14,8 @@
  * the Softfloat-2a license unless specifically indicated otherwise.
  */
 
-/* Portions of this work are licensed under the terms of the GNU GPL,
+/*
+ * Portions of this work are licensed under the terms of the GNU GPL,
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 2ae537461f..60bcfb7bd0 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -248,8 +248,10 @@ static void set_cc_op(DisasContext *s, CCOp op)
     s->cc_op = op;
     s->cc_op_synced = 0;
 
-    /* Discard CC computation that will no longer be used.
-       Note that X and N are never dead.  */
+    /*
+     * Discard CC computation that will no longer be used.
+     * Note that X and N are never dead.
+     */
     dead = cc_op_live[old_op] & ~cc_op_live[op];
     if (dead & CCF_C) {
         tcg_gen_discard_i32(QREG_CC_C);
@@ -306,8 +308,10 @@ static inline void gen_addr_fault(DisasContext *s)
     gen_exception(s, s->base.pc_next, EXCP_ADDRESS);
 }
 
-/* Generate a load from the specified address.  Narrow values are
-   sign extended to full register width.  */
+/*
+ * Generate a load from the specified address.  Narrow values are
+ *  sign extended to full register width.
+ */
 static inline TCGv gen_load(DisasContext *s, int opsize, TCGv addr,
                             int sign, int index)
 {
@@ -360,8 +364,10 @@ typedef enum {
     EA_LOADS
 } ea_what;
 
-/* Generate an unsigned load if VAL is 0 a signed load if val is -1,
-   otherwise generate a store.  */
+/*
+ * Generate an unsigned load if VAL is 0 a signed load if val is -1,
+ * otherwise generate a store.
+ */
 static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
                      ea_what what, int index)
 {
@@ -426,8 +432,10 @@ static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
     return add;
 }
 
-/* Handle a base + index + displacement effective addresss.
-   A NULL_QREG base means pc-relative.  */
+/*
+ * Handle a base + index + displacement effective addresss.
+ * A NULL_QREG base means pc-relative.
+ */
 static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
 {
     uint32_t offset;
@@ -714,8 +722,10 @@ static inline int ext_opsize(int ext, int pos)
     }
 }
 
-/* Assign value to a register.  If the width is less than the register width
-   only the low part of the register is set.  */
+/*
+ * Assign value to a register.  If the width is less than the register width
+ * only the low part of the register is set.
+ */
 static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
 {
     TCGv tmp;
@@ -743,8 +753,10 @@ static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
     }
 }
 
-/* Generate code for an "effective address".  Does not adjust the base
-   register for autoincrement addressing modes.  */
+/*
+ * Generate code for an "effective address".  Does not adjust the base
+ * register for autoincrement addressing modes.
+ */
 static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
                          int mode, int reg0, int opsize)
 {
@@ -817,9 +829,11 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
     return gen_lea_mode(env, s, mode, reg0, opsize);
 }
 
-/* Generate code to load/store a value from/into an EA.  If WHAT > 0 this is
-   a write otherwise it is a read (0 == sign extend, -1 == zero extend).
-   ADDRP is non-null for readwrite operands.  */
+/*
+ * Generate code to load/store a value from/into an EA.  If WHAT > 0 this is
+ * a write otherwise it is a read (0 == sign extend, -1 == zero extend).
+ * ADDRP is non-null for readwrite operands.
+ */
 static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
                         int opsize, TCGv val, TCGv *addrp, ea_what what,
                         int index)
@@ -1012,7 +1026,8 @@ static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
         tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
         break;
     case OS_PACKED:
-        /* unimplemented data type on 68040/ColdFire
+        /*
+         * unimplemented data type on 68040/ColdFire
          * FIXME if needed for another FPU
          */
         gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
@@ -1066,7 +1081,8 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
         tcg_gen_qemu_st64(t64, tmp, index);
         break;
     case OS_PACKED:
-        /* unimplemented data type on 68040/ColdFire
+        /*
+         * unimplemented data type on 68040/ColdFire
          * FIXME if needed for another FPU
          */
         gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
@@ -1212,7 +1228,8 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
                 tcg_temp_free_i64(t64);
                 break;
             case OS_PACKED:
-                /* unimplemented data type on 68040/ColdFire
+                /*
+                 * unimplemented data type on 68040/ColdFire
                  * FIXME if needed for another FPU
                  */
                 gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
@@ -1299,9 +1316,11 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
         goto done;
     case 14: /* GT (!(Z || (N ^ V))) */
     case 15: /* LE (Z || (N ^ V)) */
-        /* Logic operations clear V, which simplifies LE to (Z || N),
-           and since Z and N are co-located, this becomes a normal
-           comparison vs N.  */
+        /*
+         * Logic operations clear V, which simplifies LE to (Z || N),
+         * and since Z and N are co-located, this becomes a normal
+         * comparison vs N.
+         */
         if (op == CC_OP_LOGIC) {
             c->v1 = QREG_CC_N;
             tcond = TCG_COND_LE;
@@ -1549,9 +1568,11 @@ DISAS_INSN(undef_fpu)
 
 DISAS_INSN(undef)
 {
-    /* ??? This is both instructions that are as yet unimplemented
-       for the 680x0 series, as well as those that are implemented
-       but actually illegal for CPU32 or pre-68020.  */
+    /*
+     * ??? This is both instructions that are as yet unimplemented
+     * for the 680x0 series, as well as those that are implemented
+     * but actually illegal for CPU32 or pre-68020.
+     */
     qemu_log_mask(LOG_UNIMP, "Illegal instruction: %04x @ %08x\n",
                   insn, s->base.pc_next);
     gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
@@ -1655,7 +1676,8 @@ static void bcd_add(TCGv dest, TCGv src)
 {
     TCGv t0, t1;
 
-    /*  dest10 = dest10 + src10 + X
+    /*
+     * dest10 = dest10 + src10 + X
      *
      *        t1 = src
      *        t2 = t1 + 0x066
@@ -1667,7 +1689,8 @@ static void bcd_add(TCGv dest, TCGv src)
      *        return t3 - t7
      */
 
-    /* t1 = (src + 0x066) + dest + X
+    /*
+     * t1 = (src + 0x066) + dest + X
      *    = result with some possible exceding 0x6
      */
 
@@ -1680,20 +1703,23 @@ static void bcd_add(TCGv dest, TCGv src)
 
     /* we will remove exceding 0x6 where there is no carry */
 
-    /* t0 = (src + 0x0066) ^ dest
+    /*
+     * t0 = (src + 0x0066) ^ dest
      *    = t1 without carries
      */
 
     tcg_gen_xor_i32(t0, t0, dest);
 
-    /* extract the carries
+    /*
+     * extract the carries
      * t0 = t0 ^ t1
      *    = only the carries
      */
 
     tcg_gen_xor_i32(t0, t0, t1);
 
-    /* generate 0x1 where there is no carry
+    /*
+     * generate 0x1 where there is no carry
      * and for each 0x10, generate a 0x6
      */
 
@@ -1704,7 +1730,8 @@ static void bcd_add(TCGv dest, TCGv src)
     tcg_gen_add_i32(dest, dest, t0);
     tcg_temp_free(t0);
 
-    /* remove the exceding 0x6
+    /*
+     * remove the exceding 0x6
      * for digits that have not generated a carry
      */
 
@@ -1716,7 +1743,8 @@ static void bcd_sub(TCGv dest, TCGv src)
 {
     TCGv t0, t1, t2;
 
-    /*  dest10 = dest10 - src10 - X
+    /*
+     *  dest10 = dest10 - src10 - X
      *         = bcd_add(dest + 1 - X, 0x199 - src)
      */
 
@@ -1741,7 +1769,8 @@ static void bcd_sub(TCGv dest, TCGv src)
 
     tcg_gen_xor_i32(t0, t1, t2);
 
-    /* t2 = ~t0 & 0x110
+    /*
+     * t2 = ~t0 & 0x110
      * t0 = (t2 >> 2) | (t2 >> 3)
      *
      * to fit on 8bit operands, changed in:
@@ -2029,8 +2058,10 @@ DISAS_INSN(movem)
             /* pre-decrement is not allowed */
             goto do_addr_fault;
         }
-        /* We want a bare copy of the address reg, without any pre-decrement
-           adjustment, as gen_lea would provide.  */
+        /*
+         * We want a bare copy of the address reg, without any pre-decrement
+         * adjustment, as gen_lea would provide.
+         */
         break;
 
     default:
@@ -2072,7 +2103,8 @@ DISAS_INSN(movem)
                     tcg_gen_sub_i32(addr, addr, incr);
                     if (reg0 + 8 == i &&
                         m68k_feature(s->env, M68K_FEATURE_EXT_FULL)) {
-                        /* M68020+: if the addressing register is the
+                        /*
+                         * M68020+: if the addressing register is the
                          * register moved to memory, the value written
                          * is the initial value decremented by the size of
                          * the operation, regardless of how many actual
@@ -2413,7 +2445,8 @@ DISAS_INSN(cas)
 
     cmp = gen_extend(s, DREG(ext, 0), opsize, 1);
 
-    /* if  <EA> == Dc then
+    /*
+     * if  <EA> == Dc then
      *     <EA> = Du
      *     Dc = <EA> (because <EA> == Dc)
      * else
@@ -2466,7 +2499,8 @@ DISAS_INSN(cas2w)
         addr2 = DREG(ext2, 12);
     }
 
-    /* if (R1) == Dc1 && (R2) == Dc2 then
+    /*
+     * if (R1) == Dc1 && (R2) == Dc2 then
      *     (R1) = Du1
      *     (R2) = Du2
      * else
@@ -2516,7 +2550,8 @@ DISAS_INSN(cas2l)
         addr2 = DREG(ext2, 12);
     }
 
-    /* if (R1) == Dc1 && (R2) == Dc2 then
+    /*
+     * if (R1) == Dc1 && (R2) == Dc2 then
      *     (R1) = Du1
      *     (R2) = Du2
      * else
@@ -2597,7 +2632,8 @@ DISAS_INSN(negx)
 
     gen_flush_flags(s); /* compute old Z */
 
-    /* Perform substract with borrow.
+    /*
+     * Perform substract with borrow.
      * (X, N) =  -(src + X);
      */
 
@@ -2609,7 +2645,8 @@ DISAS_INSN(negx)
 
     tcg_gen_andi_i32(QREG_CC_X, QREG_CC_X, 1);
 
-    /* Compute signed-overflow for negation.  The normal formula for
+    /*
+     * Compute signed-overflow for negation.  The normal formula for
      * subtraction is (res ^ src) & (src ^ dest), but with dest==0
      * this simplies to res & src.
      */
@@ -2844,8 +2881,10 @@ DISAS_INSN(mull)
 
         set_cc_op(s, CC_OP_FLAGS);
     } else {
-        /* The upper 32 bits of the product are discarded, so
-           muls.l and mulu.l are functionally equivalent.  */
+        /*
+         * The upper 32 bits of the product are discarded, so
+         * muls.l and mulu.l are functionally equivalent.
+         */
         tcg_gen_mul_i32(DREG(ext, 12), src1, DREG(ext, 12));
         gen_logic_cc(s, DREG(ext, 12), OS_LONG);
     }
@@ -2938,8 +2977,10 @@ DISAS_INSN(jump)
 {
     TCGv tmp;
 
-    /* Load the target address first to ensure correct exception
-       behavior.  */
+    /*
+     * Load the target address first to ensure correct exception
+     * behavior.
+     */
     tmp = gen_lea(env, s, insn, OS_LONG);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
@@ -2976,8 +3017,10 @@ DISAS_INSN(addsubq)
     dest = tcg_temp_new();
     tcg_gen_mov_i32(dest, src);
     if ((insn & 0x38) == 0x08) {
-        /* Don't update condition codes if the destination is an
-           address register.  */
+        /*
+         * Don't update condition codes if the destination is an
+         * address register.
+         */
         if (insn & 0x0100) {
             tcg_gen_sub_i32(dest, dest, val);
         } else {
@@ -3110,7 +3153,8 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
 
     gen_flush_flags(s); /* compute old Z */
 
-    /* Perform substract with borrow.
+    /*
+     * Perform substract with borrow.
      * (X, N) = dest - (src + X);
      */
 
@@ -3320,7 +3364,8 @@ static inline void gen_addx(DisasContext *s, TCGv src, TCGv dest, int opsize)
 
     gen_flush_flags(s); /* compute old Z */
 
-    /* Perform addition with carry.
+    /*
+     * Perform addition with carry.
      * (X, N) = src + dest + X;
      */
 
@@ -3404,9 +3449,11 @@ static inline void shift_im(DisasContext *s, uint16_t insn, int opsize)
         tcg_gen_shri_i32(QREG_CC_C, reg, bits - count);
         tcg_gen_shli_i32(QREG_CC_N, reg, count);
 
-        /* Note that ColdFire always clears V (done above),
-           while M68000 sets if the most significant bit is changed at
-           any time during the shift operation */
+        /*
+         * Note that ColdFire always clears V (done above),
+         * while M68000 sets if the most significant bit is changed at
+         * any time during the shift operation.
+         */
         if (!logical && m68k_feature(s->env, M68K_FEATURE_M68000)) {
             /* if shift count >= bits, V is (reg != 0) */
             if (count >= bits) {
@@ -3451,9 +3498,11 @@ static inline void shift_reg(DisasContext *s, uint16_t insn, int opsize)
     s64 = tcg_temp_new_i64();
     s32 = tcg_temp_new();
 
-    /* Note that m68k truncates the shift count modulo 64, not 32.
-       In addition, a 64-bit shift makes it easy to find "the last
-       bit shifted out", for the carry flag.  */
+    /*
+     * Note that m68k truncates the shift count modulo 64, not 32.
+     * In addition, a 64-bit shift makes it easy to find "the last
+     * bit shifted out", for the carry flag.
+     */
     tcg_gen_andi_i32(s32, DREG(insn, 9), 63);
     tcg_gen_extu_i32_i64(s64, s32);
     tcg_gen_extu_i32_i64(t64, reg);
@@ -3480,7 +3529,8 @@ static inline void shift_reg(DisasContext *s, uint16_t insn, int opsize)
         tcg_gen_movcond_i32(TCG_COND_NE, QREG_CC_X, s32, QREG_CC_V,
                             QREG_CC_C, QREG_CC_X);
 
-        /* M68000 sets V if the most significant bit is changed at
+        /*
+         * M68000 sets V if the most significant bit is changed at
          * any time during the shift operation.  Do this via creating
          * an extension of the sign bit, comparing, and discarding
          * the bits below the sign bit.  I.e.
@@ -3576,9 +3626,11 @@ DISAS_INSN(shift_mem)
         tcg_gen_shri_i32(QREG_CC_C, src, 15);
         tcg_gen_shli_i32(QREG_CC_N, src, 1);
 
-        /* Note that ColdFire always clears V,
-           while M68000 sets if the most significant bit is changed at
-           any time during the shift operation */
+        /*
+         * Note that ColdFire always clears V,
+         * while M68000 sets if the most significant bit is changed at
+         * any time during the shift operation
+         */
         if (!logical && m68k_feature(s->env, M68K_FEATURE_M68000)) {
             src = gen_extend(s, src, OS_WORD, 1);
             tcg_gen_xor_i32(QREG_CC_V, QREG_CC_N, src);
@@ -3996,9 +4048,11 @@ DISAS_INSN(bfext_reg)
     TCGv tmp = tcg_temp_new();
     TCGv shift;
 
-    /* In general, we're going to rotate the field so that it's at the
-       top of the word and then right-shift by the complement of the
-       width to extend the field.  */
+    /*
+     * In general, we're going to rotate the field so that it's at the
+     * top of the word and then right-shift by the complement of the
+     * width to extend the field.
+     */
     if (ext & 0x20) {
         /* Variable width.  */
         if (ext & 0x800) {
@@ -4028,8 +4082,10 @@ DISAS_INSN(bfext_reg)
             src = tmp;
             pos = 32 - len;
         } else {
-            /* Immediate offset.  If the field doesn't wrap around the
-               end of the word, rely on (s)extract completely.  */
+            /*
+             * Immediate offset.  If the field doesn't wrap around the
+             * end of the word, rely on (s)extract completely.
+             */
             if (pos < 0) {
                 tcg_gen_rotli_i32(tmp, src, ofs);
                 src = tmp;
@@ -4888,7 +4944,8 @@ static void gen_op_fmove_fcr(CPUM68KState *env, DisasContext *s,
     addr = tcg_temp_new();
     tcg_gen_mov_i32(addr, tmp);
 
-    /* mask:
+    /*
+     * mask:
      *
      * 0b100 Floating-Point Control Register
      * 0b010 Floating-Point Status Register
@@ -4956,7 +5013,8 @@ static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
     }
 
     if (!is_load && (mode & 2) == 0) {
-        /* predecrement addressing mode
+        /*
+         * predecrement addressing mode
          * only available to store register to memory
          */
         if (opsize == OS_EXTENDED) {
@@ -4986,8 +5044,10 @@ static void gen_op_fmovem(CPUM68KState *env, DisasContext *s,
     tcg_temp_free(tmp);
 }
 
-/* ??? FP exceptions are not implemented.  Most exceptions are deferred until
-   immediately before the next FP instruction is executed.  */
+/*
+ * ??? FP exceptions are not implemented.  Most exceptions are deferred until
+ * immediately before the next FP instruction is executed.
+ */
 DISAS_INSN(fpu)
 {
     uint16_t ext;
@@ -5511,8 +5571,10 @@ DISAS_INSN(mac)
         tmp = gen_lea(env, s, insn, OS_LONG);
         addr = tcg_temp_new();
         tcg_gen_and_i32(addr, tmp, QREG_MAC_MASK);
-        /* Load the value now to ensure correct exception behavior.
-           Perform writeback after reading the MAC inputs.  */
+        /*
+         * Load the value now to ensure correct exception behavior.
+         * Perform writeback after reading the MAC inputs.
+         */
         loadval = gen_load(s, OS_LONG, addr, 0, IS_USER(s));
 
         acc ^= 1;
@@ -5633,8 +5695,10 @@ DISAS_INSN(mac)
         TCGv rw;
         rw = (insn & 0x40) ? AREG(insn, 9) : DREG(insn, 9);
         tcg_gen_mov_i32(rw, loadval);
-        /* FIXME: Should address writeback happen with the masked or
-           unmasked value?  */
+        /*
+         * FIXME: Should address writeback happen with the masked or
+         * unmasked value?
+         */
         switch ((insn >> 3) & 7) {
         case 3: /* Post-increment.  */
             tcg_gen_addi_i32(AREG(insn, 0), addr, 4);
@@ -5784,8 +5848,10 @@ register_opcode (disas_proc proc, uint16_t opcode, uint16_t mask)
               opcode, mask);
       abort();
   }
-  /* This could probably be cleverer.  For now just optimize the case where
-     the top bits are known.  */
+  /*
+   * This could probably be cleverer.  For now just optimize the case where
+   * the top bits are known.
+   */
   /* Find the first zero bit in the mask.  */
   i = 0x8000;
   while ((i & mask) != 0)
@@ -5803,17 +5869,22 @@ register_opcode (disas_proc proc, uint16_t opcode, uint16_t mask)
   }
 }
 
-/* Register m68k opcode handlers.  Order is important.
-   Later insn override earlier ones.  */
+/*
+ * Register m68k opcode handlers.  Order is important.
+ * Later insn override earlier ones.
+ */
 void register_m68k_insns (CPUM68KState *env)
 {
-    /* Build the opcode table only once to avoid
-       multithreading issues. */
+    /*
+     * Build the opcode table only once to avoid
+     * multithreading issues.
+     */
     if (opcode_table[0] != NULL) {
         return;
     }
 
-    /* use BASE() for instruction available
+    /*
+     * use BASE() for instruction available
      * for CF_ISA_A and M68000.
      */
 #define BASE(name, opcode, mask) \
@@ -6077,10 +6148,12 @@ static bool m68k_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     gen_exception(dc, dc->base.pc_next, EXCP_DEBUG);
-    /* The address covered by the breakpoint must be included in
-       [tb->pc, tb->pc + tb->size) in order to for it to be
-       properly cleared -- thus we increment the PC here so that
-       the logic setting tb->size below does the right thing.  */
+    /*
+     * The address covered by the breakpoint must be included in
+     * [tb->pc, tb->pc + tb->size) in order to for it to be
+     * properly cleared -- thus we increment the PC here so that
+     * the logic setting tb->size below does the right thing.
+     */
     dc->base.pc_next += 2;
 
     return true;
@@ -6099,7 +6172,8 @@ static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->base.pc_next = dc->pc;
 
     if (dc->base.is_jmp == DISAS_NEXT) {
-        /* Stop translation when the next insn might touch a new page.
+        /*
+         * Stop translation when the next insn might touch a new page.
          * This ensures that prefetch aborts at the right place.
          *
          * We cannot determine the size of the next insn without
@@ -6142,8 +6216,10 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_EXIT:
-        /* We updated CC_OP and PC in gen_exit_tb, but also modified
-           other state that may require returning to the main loop.  */
+        /*
+         * We updated CC_OP and PC in gen_exit_tb, but also modified
+         * other state that may require returning to the main loop.
+         */
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
-- 
2.21.0


