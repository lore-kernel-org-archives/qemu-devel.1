Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B5C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206842080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzSjImWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206842080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFxJ-000555-MZ
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59357)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqT-0005x7-Mw
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqR-0002SQ-9P
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htFqP-0002O3-2u
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so74702404wrs.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FbaNLPetYZP3Z9xGLSDaB29D4n8r19blfa/2OsX8sO0=;
 b=OzSjImWKYvk+vg52J6vX55/O0ljdpX5KtGsrWb+4dfPgdCpetmXsRi+hMUJGwaTOSe
 5PTtFK454kfQv2ruiMCodv/lmw/K4Pnh8cv0777VaQSH4+xKEmrdkjO/vy5dGO9JNNBG
 XMn4f+B/tmlEvvGUYV0cHXmpsOah3VwlFStyEeJM5CdLU9n/k0ix8rrHf2ioe2b+CWcX
 nvAQAKkSnYmAldQ0mJWxVOrUEbJz4oN7hXCc/yrOHMk6S6/RSRac8gKTL16hSBD94tse
 fh7t3Gt3ro9YDr9tr6oVFHNEHlYYfvT3f8q60/1HiXmgU2Z0eW9tz7P/wEPL1Ev8FI9n
 6UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FbaNLPetYZP3Z9xGLSDaB29D4n8r19blfa/2OsX8sO0=;
 b=D4tubbsgGvbkiLcHKUyhyDypgkB70SRFeDkC5cDOLNl1YWVbFPR9g5+loCBQezuNDf
 ATpyRrq5+tunKMhyWuOxVZ3k1gPWoVA39Qz40OlI1FgChTkCz2TyI4m5E5m/A4k5t6ZP
 Dml//JtWX0iH6xY/J8DF4K7B6tMF6DObYR+GYL7G5Hvf5BA6Su704kHFPFNW4SI+cZ2Z
 0m20AJfZ6plUpzUQ+n+8vXnEdE8ZWJA/FWc1QzHqQQrIZFxSC1FqZeEBcklXF97rgmRJ
 QcRX6tSdFQs9oUIorqKtlvTjNyIuP3UrW9E82yMQoOBGBRdnavOxoUT0pMNZ5x1vgwrJ
 2BYg==
X-Gm-Message-State: APjAAAXXwotfpg8v8FpelCcRYfd2INpikevyxhyK4bsQyv8Y4LKS+lVO
 cZxZfj6cP4EfT/+8LG06xXoUvVDt5B+IBQ==
X-Google-Smtp-Source: APXvYqxjtyZxj8D0J6XA0aw3VHflWljYN+dn2JSgEIWBFKXDK+ZakxkZqQEr9UAUDRIpX46T5+I0yw==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr1826705wrw.96.1564684215939;
 Thu, 01 Aug 2019 11:30:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm71702104wrw.23.2019.08.01.11.30.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 11:30:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 19:30:06 +0100
Message-Id: <20190801183012.17564-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801183012.17564-1-peter.maydell@linaro.org>
References: <20190801183012.17564-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 1/7] target/sparc: Factor out the body of
 sparc_cpu_unassigned_access()
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the SPARC target uses the old-style do_unassigned_access
hook.  We want to switch it over to do_transaction_failed, but to do
this we must first remove all the direct calls in ldst_helper.c to
cpu_unassigned_access().  Factor out the body of the hook function's
code into a new sparc_raise_mmu_fault() and call it from the hook and
from the various places that used to call cpu_unassigned_access().

In passing, this fixes a bug where the code that raised the
MMU exception was directly calling GETPC() from a function that
was several levels deep in the callstack from the original
helper function: the new sparc_raise_mmu_fault() instead takes
the return address as an argument.

Other than the use of retaddr rather than GETPC() and a comment
format fixup, the body of the new function has no changes from
that of the old hook function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/ldst_helper.c | 201 +++++++++++++++++++------------------
 1 file changed, 106 insertions(+), 95 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 7f56c100c69..26876e5a575 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -422,6 +422,99 @@ static void dump_asi(const char *txt, target_ulong addr, int asi, int size,
 }
 #endif
 
+#ifndef CONFIG_USER_ONLY
+#ifndef TARGET_SPARC64
+static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
+                                  bool is_write, bool is_exec, int is_asi,
+                                  unsigned size, uintptr_t retaddr)
+{
+    SPARCCPU *cpu = SPARC_CPU(cs);
+    CPUSPARCState *env = &cpu->env;
+    int fault_type;
+
+#ifdef DEBUG_UNASSIGNED
+    if (is_asi) {
+        printf("Unassigned mem %s access of %d byte%s to " TARGET_FMT_plx
+               " asi 0x%02x from " TARGET_FMT_lx "\n",
+               is_exec ? "exec" : is_write ? "write" : "read", size,
+               size == 1 ? "" : "s", addr, is_asi, env->pc);
+    } else {
+        printf("Unassigned mem %s access of %d byte%s to " TARGET_FMT_plx
+               " from " TARGET_FMT_lx "\n",
+               is_exec ? "exec" : is_write ? "write" : "read", size,
+               size == 1 ? "" : "s", addr, env->pc);
+    }
+#endif
+    /* Don't overwrite translation and access faults */
+    fault_type = (env->mmuregs[3] & 0x1c) >> 2;
+    if ((fault_type > 4) || (fault_type == 0)) {
+        env->mmuregs[3] = 0; /* Fault status register */
+        if (is_asi) {
+            env->mmuregs[3] |= 1 << 16;
+        }
+        if (env->psrs) {
+            env->mmuregs[3] |= 1 << 5;
+        }
+        if (is_exec) {
+            env->mmuregs[3] |= 1 << 6;
+        }
+        if (is_write) {
+            env->mmuregs[3] |= 1 << 7;
+        }
+        env->mmuregs[3] |= (5 << 2) | 2;
+        /* SuperSPARC will never place instruction fault addresses in the FAR */
+        if (!is_exec) {
+            env->mmuregs[4] = addr; /* Fault address register */
+        }
+    }
+    /* overflow (same type fault was not read before another fault) */
+    if (fault_type == ((env->mmuregs[3] & 0x1c)) >> 2) {
+        env->mmuregs[3] |= 1;
+    }
+
+    if ((env->mmuregs[0] & MMU_E) && !(env->mmuregs[0] & MMU_NF)) {
+        int tt = is_exec ? TT_CODE_ACCESS : TT_DATA_ACCESS;
+        cpu_raise_exception_ra(env, tt, retaddr);
+    }
+
+    /*
+     * flush neverland mappings created during no-fault mode,
+     * so the sequential MMU faults report proper fault types
+     */
+    if (env->mmuregs[0] & MMU_NF) {
+        tlb_flush(cs);
+    }
+}
+#else
+static void sparc_raise_mmu_fault(CPUState *cs, hwaddr addr,
+                                  bool is_write, bool is_exec, int is_asi,
+                                  unsigned size, uintptr_t retaddr)
+{
+    SPARCCPU *cpu = SPARC_CPU(cs);
+    CPUSPARCState *env = &cpu->env;
+
+#ifdef DEBUG_UNASSIGNED
+    printf("Unassigned mem access to " TARGET_FMT_plx " from " TARGET_FMT_lx
+           "\n", addr, env->pc);
+#endif
+
+    if (is_exec) { /* XXX has_hypervisor */
+        if (env->lsu & (IMMU_E)) {
+            cpu_raise_exception_ra(env, TT_CODE_ACCESS, retaddr);
+        } else if (cpu_has_hypervisor(env) && !(env->hpstate & HS_PRIV)) {
+            cpu_raise_exception_ra(env, TT_INSN_REAL_TRANSLATION_MISS, retaddr);
+        }
+    } else {
+        if (env->lsu & (DMMU_E)) {
+            cpu_raise_exception_ra(env, TT_DATA_ACCESS, retaddr);
+        } else if (cpu_has_hypervisor(env) && !(env->hpstate & HS_PRIV)) {
+            cpu_raise_exception_ra(env, TT_DATA_REAL_TRANSLATION_MISS, retaddr);
+        }
+    }
+}
+#endif
+#endif
+
 #ifndef TARGET_SPARC64
 #ifndef CONFIG_USER_ONLY
 
@@ -688,7 +781,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         break;
     case ASI_USERTXT: /* User code access, XXX */
     default:
-        cpu_unassigned_access(cs, addr, false, false, asi, size);
+        sparc_raise_mmu_fault(cs, addr, false, false, asi, size, GETPC());
         ret = 0;
         break;
 
@@ -1026,7 +1119,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
     case ASI_USERTXT: /* User code access, XXX */
     case ASI_KERNELTXT: /* Supervisor code access, XXX */
     default:
-        cpu_unassigned_access(cs, addr, true, false, asi, size);
+        sparc_raise_mmu_fault(cs, addr, true, false, asi, size, GETPC());
         break;
 
     case ASI_USERDATA: /* User data access */
@@ -1292,7 +1385,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
                 ret = env->immu.tag_access;
                 break;
             default:
-                cpu_unassigned_access(cs, addr, false, false, 1, size);
+                sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
                 ret = 0;
             }
             break;
@@ -1358,7 +1451,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
                 ret = env->dmmu.physical_watchpoint;
                 break;
             default:
-                cpu_unassigned_access(cs, addr, false, false, 1, size);
+                sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
                 ret = 0;
             }
             break;
@@ -1407,7 +1500,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_SCRATCHPAD: /* UA2005 privileged scratchpad */
         if (unlikely((addr >= 0x20) && (addr < 0x30))) {
             /* Hyperprivileged access only */
-            cpu_unassigned_access(cs, addr, false, false, 1, size);
+            sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
         }
         /* fall through */
     case ASI_HYP_SCRATCHPAD: /* UA2005 hyperprivileged scratchpad */
@@ -1425,7 +1518,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             ret = env->dmmu.mmu_secondary_context;
             break;
         default:
-          cpu_unassigned_access(cs, addr, true, false, 1, size);
+          sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         }
         break;
     case ASI_DCACHE_DATA:     /* D-cache data */
@@ -1448,7 +1541,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_DMMU_DEMAP:          /* D-MMU demap, WO */
     case ASI_INTR_W:              /* Interrupt vector, WO */
     default:
-        cpu_unassigned_access(cs, addr, false, false, 1, size);
+        sparc_raise_mmu_fault(cs, addr, false, false, 1, size, GETPC());
         ret = 0;
         break;
     }
@@ -1622,7 +1715,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             case 8:
                 return;
             default:
-                cpu_unassigned_access(cs, addr, true, false, 1, size);
+                sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
                 break;
             }
 
@@ -1706,7 +1799,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                 env->dmmu.physical_watchpoint = val;
                 break;
             default:
-                cpu_unassigned_access(cs, addr, true, false, 1, size);
+                sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
                 break;
             }
 
@@ -1750,7 +1843,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
     case ASI_SCRATCHPAD: /* UA2005 privileged scratchpad */
         if (unlikely((addr >= 0x20) && (addr < 0x30))) {
             /* Hyperprivileged access only */
-            cpu_unassigned_access(cs, addr, true, false, 1, size);
+            sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         }
         /* fall through */
     case ASI_HYP_SCRATCHPAD: /* UA2005 hyperprivileged scratchpad */
@@ -1776,7 +1869,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                                   (1 << MMU_KERNEL_SECONDARY_IDX));
               break;
           default:
-              cpu_unassigned_access(cs, addr, true, false, 1, size);
+              sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
           }
         }
         return;
@@ -1808,7 +1901,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
     case ASI_PNFL: /* Primary no-fault LE, RO */
     case ASI_SNFL: /* Secondary no-fault LE, RO */
     default:
-        cpu_unassigned_access(cs, addr, true, false, 1, size);
+        sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         return;
     }
 }
@@ -1816,94 +1909,12 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
 #endif /* TARGET_SPARC64 */
 
 #if !defined(CONFIG_USER_ONLY)
-#ifndef TARGET_SPARC64
 void sparc_cpu_unassigned_access(CPUState *cs, hwaddr addr,
                                  bool is_write, bool is_exec, int is_asi,
                                  unsigned size)
 {
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-    int fault_type;
-
-#ifdef DEBUG_UNASSIGNED
-    if (is_asi) {
-        printf("Unassigned mem %s access of %d byte%s to " TARGET_FMT_plx
-               " asi 0x%02x from " TARGET_FMT_lx "\n",
-               is_exec ? "exec" : is_write ? "write" : "read", size,
-               size == 1 ? "" : "s", addr, is_asi, env->pc);
-    } else {
-        printf("Unassigned mem %s access of %d byte%s to " TARGET_FMT_plx
-               " from " TARGET_FMT_lx "\n",
-               is_exec ? "exec" : is_write ? "write" : "read", size,
-               size == 1 ? "" : "s", addr, env->pc);
-    }
-#endif
-    /* Don't overwrite translation and access faults */
-    fault_type = (env->mmuregs[3] & 0x1c) >> 2;
-    if ((fault_type > 4) || (fault_type == 0)) {
-        env->mmuregs[3] = 0; /* Fault status register */
-        if (is_asi) {
-            env->mmuregs[3] |= 1 << 16;
-        }
-        if (env->psrs) {
-            env->mmuregs[3] |= 1 << 5;
-        }
-        if (is_exec) {
-            env->mmuregs[3] |= 1 << 6;
-        }
-        if (is_write) {
-            env->mmuregs[3] |= 1 << 7;
-        }
-        env->mmuregs[3] |= (5 << 2) | 2;
-        /* SuperSPARC will never place instruction fault addresses in the FAR */
-        if (!is_exec) {
-            env->mmuregs[4] = addr; /* Fault address register */
-        }
-    }
-    /* overflow (same type fault was not read before another fault) */
-    if (fault_type == ((env->mmuregs[3] & 0x1c)) >> 2) {
-        env->mmuregs[3] |= 1;
-    }
-
-    if ((env->mmuregs[0] & MMU_E) && !(env->mmuregs[0] & MMU_NF)) {
-        int tt = is_exec ? TT_CODE_ACCESS : TT_DATA_ACCESS;
-        cpu_raise_exception_ra(env, tt, GETPC());
-    }
-
-    /* flush neverland mappings created during no-fault mode,
-       so the sequential MMU faults report proper fault types */
-    if (env->mmuregs[0] & MMU_NF) {
-        tlb_flush(cs);
-    }
+    sparc_raise_mmu_fault(cs, addr, is_write, is_exec, is_asi, size, GETPC());
 }
-#else
-void sparc_cpu_unassigned_access(CPUState *cs, hwaddr addr,
-                                 bool is_write, bool is_exec, int is_asi,
-                                 unsigned size)
-{
-    SPARCCPU *cpu = SPARC_CPU(cs);
-    CPUSPARCState *env = &cpu->env;
-
-#ifdef DEBUG_UNASSIGNED
-    printf("Unassigned mem access to " TARGET_FMT_plx " from " TARGET_FMT_lx
-           "\n", addr, env->pc);
-#endif
-
-    if (is_exec) { /* XXX has_hypervisor */
-        if (env->lsu & (IMMU_E)) {
-            cpu_raise_exception_ra(env, TT_CODE_ACCESS, GETPC());
-        } else if (cpu_has_hypervisor(env) && !(env->hpstate & HS_PRIV)) {
-            cpu_raise_exception_ra(env, TT_INSN_REAL_TRANSLATION_MISS, GETPC());
-        }
-    } else {
-        if (env->lsu & (DMMU_E)) {
-            cpu_raise_exception_ra(env, TT_DATA_ACCESS, GETPC());
-        } else if (cpu_has_hypervisor(env) && !(env->hpstate & HS_PRIV)) {
-            cpu_raise_exception_ra(env, TT_DATA_REAL_TRANSLATION_MISS, GETPC());
-        }
-    }
-}
-#endif
 #endif
 
 #if !defined(CONFIG_USER_ONLY)
-- 
2.20.1


