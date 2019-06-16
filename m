Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD1DC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861612084D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AprLvbC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861612084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccQb-0001hz-Su
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hccOg-0008V4-V7
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hccOe-0003lO-NY
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:09:06 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hccOe-0003kX-Em
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:09:04 -0400
Received: by mail-pf1-x441.google.com with SMTP id 81so4482493pfy.13
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id;
 bh=tYuJ/QJXuAV5GSW51k+J96llqQdzgPa6pJsYmtoRdmg=;
 b=AprLvbC8mQbA4Xjp3Q95ObGQodgo7RLVU7wEePU3eCmdV6LkbJuV4JxMnLFDvAkf+n
 TihJZJ+YqGRHsbDOg4rU3E8wtMPk2AiaRQu9bY6ffZGHEXFVCJM+tib+ONi4Z/nVauCM
 LwKFq1TOusVmM+5lVmzCV3l/bZZRWQfVBIAd+z+9seiGZnadTHM1xVyB6G9SQAKPjMfD
 4qFGrbjzmPMN2h0yB5X0SYLAudkqeCmAbN1QxbNA8anmlCBBUP+nHURb3050iiFRrhPk
 MMsZuqpPBLrzu+0Mszz2WUEoDzP7NTdS/vC5Rg6W8arJ7YjxhrI4NU0Z/uAVTP2f7De6
 pXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=tYuJ/QJXuAV5GSW51k+J96llqQdzgPa6pJsYmtoRdmg=;
 b=k/AaDW+GDSkFEnUK/hhdaFtbYAGGaS/tiGF+AV53P1ZBgXaMGPI7PdYhRgUHyKVUBV
 P2JnoJMgbR2UX2WC8NH0vHZQp+Bu0dATF5wnUiL7Ov/XAA8SNxBT2biU0xld5K6r8RjM
 zJ0RMIQF3c9EuufJrP5frHXq2WNOnXwghRB93pSVGjmB+wdeXqd3ZZeRVGQowVY708dU
 mqyL8D4mBNXmymbXHSM1OOD9b5Sp6JcKTFuUkvNQIUFQH+nPZu/JMoXrtLpzEEuq2vzZ
 +06lTQMgHlAaxRrE877URIJeZTLUutEjtTJdJw8+MYvfcfn3/7TG4GHfbN4OqTVhovLY
 5mlQ==
X-Gm-Message-State: APjAAAX1iu4vSqpfKF7Mb6Q8oSxmq+LF2tQrBEO5+Nc94w42EgRBPhNL
 4Nalj6DWpJ3QOqm5VcLLV6nhUJie1ds=
X-Google-Smtp-Source: APXvYqyOGwnY2IHPycm68SQ5J3qqVGqHlqI0/4j6BYjNtEPYAGMq4T7nZXdbHohaY1f3V9ptEXcg5Q==
X-Received: by 2002:a17:90a:cb81:: with SMTP id
 a1mr22088062pju.81.1560719342181; 
 Sun, 16 Jun 2019 14:09:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id i3sm9620320pfo.138.2019.06.16.14.09.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:09:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 16 Jun 2019 14:08:59 -0700
Message-Id: <20190616210900.17814-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 1/2] tcg: Introduce set/clear_helper_retaddr
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

At present we have a potential error in that helper_retaddr contains
data for handle_cpu_signal, but we have not ensured that those stores
will be scheduled properly before the operation that may fault.

The "proper" C11 function from <stdatomic.h> for this is
atomic_signal_fence().  This expands to a compiler barrier, so it
seems reasonable to use our existing barrier() macro instead.

Adjust all of the setters of helper_retaddr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h                   | 20 +++++++++++
 include/exec/cpu_ldst_useronly_template.h | 12 +++----
 accel/tcg/user-exec.c                     | 11 +++---
 target/arm/helper-a64.c                   |  8 ++---
 target/arm/sve_helper.c                   | 43 +++++++++++------------
 5 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index a08b11bd2c..4aee3a5c6b 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -89,6 +89,26 @@ typedef target_ulong abi_ptr;
 
 extern __thread uintptr_t helper_retaddr;
 
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    barrier();
+    helper_retaddr = 0;
+}
+
 /* In user-only mode we provide only the _code and _data accessors. */
 
 #define MEMSUFFIX _data
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index bc45e2b8d4..e65733f7e2 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -78,9 +78,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   uintptr_t retaddr)
 {
     RES_TYPE ret;
-    helper_retaddr = retaddr;
+    set_helper_retaddr(retaddr);
     ret = glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(env, ptr);
-    helper_retaddr = 0;
+    clear_helper_retaddr();
     return ret;
 }
 
@@ -102,9 +102,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   uintptr_t retaddr)
 {
     int ret;
-    helper_retaddr = retaddr;
+    set_helper_retaddr(retaddr);
     ret = glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(env, ptr);
-    helper_retaddr = 0;
+    clear_helper_retaddr();
     return ret;
 }
 #endif
@@ -128,9 +128,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   RES_TYPE v,
                                                   uintptr_t retaddr)
 {
-    helper_retaddr = retaddr;
+    set_helper_retaddr(retaddr);
     glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(env, ptr, v);
-    helper_retaddr = 0;
+    clear_helper_retaddr();
 }
 #endif
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index cb5f4b19c5..4384b59a4d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -134,7 +134,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
              * currently executing TB was modified and must be exited
              * immediately.  Clear helper_retaddr for next execution.
              */
-            helper_retaddr = 0;
+            clear_helper_retaddr();
             cpu_exit_tb_from_sighandler(cpu, old_set);
             /* NORETURN */
 
@@ -152,7 +152,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
      * an exception.  Undo signal and retaddr state prior to longjmp.
      */
     sigprocmask(SIG_SETMASK, old_set, NULL);
-    helper_retaddr = 0;
+    clear_helper_retaddr();
 
     cc = CPU_GET_CLASS(cpu);
     access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
@@ -682,14 +682,15 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     if (unlikely(addr & (size - 1))) {
         cpu_loop_exit_atomic(env_cpu(env), retaddr);
     }
-    helper_retaddr = retaddr;
-    return g2h(addr);
+    void *ret = g2h(addr);
+    set_helper_retaddr(retaddr);
+    return ret;
 }
 
 /* Macro to call the above, with local variables from the use context.  */
 #define ATOMIC_MMU_DECLS do {} while (0)
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
-#define ATOMIC_MMU_CLEANUP do { helper_retaddr = 0; } while (0)
+#define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
 
 #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
 #define EXTRA_ARGS
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 44e45a8037..060699b901 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -554,7 +554,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
     /* ??? Enforce alignment.  */
     uint64_t *haddr = g2h(addr);
 
-    helper_retaddr = ra;
+    set_helper_retaddr(ra);
     o0 = ldq_le_p(haddr + 0);
     o1 = ldq_le_p(haddr + 1);
     oldv = int128_make128(o0, o1);
@@ -564,7 +564,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
         stq_le_p(haddr + 0, int128_getlo(newv));
         stq_le_p(haddr + 1, int128_gethi(newv));
     }
-    helper_retaddr = 0;
+    clear_helper_retaddr();
 #else
     int mem_idx = cpu_mmu_index(env, false);
     TCGMemOpIdx oi0 = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
@@ -624,7 +624,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
     /* ??? Enforce alignment.  */
     uint64_t *haddr = g2h(addr);
 
-    helper_retaddr = ra;
+    set_helper_retaddr(ra);
     o1 = ldq_be_p(haddr + 0);
     o0 = ldq_be_p(haddr + 1);
     oldv = int128_make128(o0, o1);
@@ -634,7 +634,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
         stq_be_p(haddr + 0, int128_gethi(newv));
         stq_be_p(haddr + 1, int128_getlo(newv));
     }
-    helper_retaddr = 0;
+    clear_helper_retaddr();
 #else
     int mem_idx = cpu_mmu_index(env, false);
     TCGMemOpIdx oi0 = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fd434c66ea..fc0c1755d2 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4125,12 +4125,11 @@ static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
     return MIN(split, mem_max - mem_off) + mem_off;
 }
 
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-#ifdef CONFIG_USER_ONLY
-    helper_retaddr = ra;
+#ifndef CONFIG_USER_ONLY
+/* These are normally defined only for CONFIG_USER_ONLY in <exec/cpu_ldst.h> */
+static inline void set_helper_retaddr(uintptr_t ra) { }
+static inline void clear_helper_retaddr(void) { }
 #endif
-}
 
 /*
  * The result of tlb_vaddr_to_host for user-only is just g2h(x),
@@ -4188,7 +4187,7 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
         if (test_host_page(host)) {
             mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
             tcg_debug_assert(mem_off == mem_max);
-            set_helper_retaddr(0);
+            clear_helper_retaddr();
             /* After having taken any fault, zero leading inactive elements. */
             swap_memzero(vd, reg_off);
             return;
@@ -4239,7 +4238,7 @@ static void sve_ld1_r(CPUARMState *env, void *vg, const target_ulong addr,
     }
 #endif
 
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
     memcpy(vd, &scratch, reg_max);
 }
 
@@ -4312,7 +4311,7 @@ static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 2 * size;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4341,7 +4340,7 @@ static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 3 * size;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4372,7 +4371,7 @@ static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 4 * size;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
@@ -4494,7 +4493,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
         if (test_host_page(host)) {
             mem_off = host_fn(vd, vg, host - mem_off, mem_off, mem_max);
             tcg_debug_assert(mem_off == mem_max);
-            set_helper_retaddr(0);
+            clear_helper_retaddr();
             /* After any fault, zero any leading inactive elements.  */
             swap_memzero(vd, reg_off);
             return;
@@ -4537,7 +4536,7 @@ static void sve_ldff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     }
 #endif
 
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
     record_fault(env, reg_off, reg_max);
 }
 
@@ -4740,7 +4739,7 @@ static void sve_st1_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += msize;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4766,7 +4765,7 @@ static void sve_st2_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 2 * msize;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4794,7 +4793,7 @@ static void sve_st3_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 3 * msize;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
@@ -4824,7 +4823,7 @@ static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
             addr += 4 * msize;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 #define DO_STN_1(N, NAME, ESIZE) \
@@ -4932,7 +4931,7 @@ static void sve_ld1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
             i += 4, pg >>= 4;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(vd, &scratch, oprsz);
@@ -4955,7 +4954,7 @@ static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
             tlb_fn(env, &scratch, i * 8, base + (off << scale), oi, ra);
         }
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 
     /* Wait until all exceptions have been raised to write back.  */
     memcpy(vd, &scratch, oprsz * 8);
@@ -5133,7 +5132,7 @@ static inline void sve_ldff1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
         tlb_fn(env, vd, reg_off, addr, oi, ra);
 
         /* The rest of the reads will be non-faulting.  */
-        set_helper_retaddr(0);
+        clear_helper_retaddr();
     }
 
     /* After any fault, zero the leading predicated false elements.  */
@@ -5175,7 +5174,7 @@ static inline void sve_ldff1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
         tlb_fn(env, vd, reg_off, addr, oi, ra);
 
         /* The rest of the reads will be non-faulting.  */
-        set_helper_retaddr(0);
+        clear_helper_retaddr();
     }
 
     /* After any fault, zero the leading predicated false elements.  */
@@ -5299,7 +5298,7 @@ static void sve_st1_zs(CPUARMState *env, void *vd, void *vg, void *vm,
             i += 4, pg >>= 4;
         } while (i & 15);
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
@@ -5318,7 +5317,7 @@ static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
             tlb_fn(env, vd, i * 8, base + (off << scale), oi, ra);
         }
     }
-    set_helper_retaddr(0);
+    clear_helper_retaddr();
 }
 
 #define DO_ST1_ZPZ_S(MEM, OFS) \
-- 
2.17.1


