Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F5C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51D4206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSvQZhvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51D4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrPE-0002su-Qr
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrGD-0006HY-8K
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrGA-0004E0-Tg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrGA-0004DK-HV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so60342626wmg.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MQ+MbYzqozJQ8J6CVJK/Op+zhd+3OFxe+UkgMgIDHKA=;
 b=pSvQZhvkyprZK7snFzo91Oqawkfc0q/fKdUBHufj4NtJBlWkCWd3XEQLHppE/2Sf46
 PsGzODxQpphNnCS5RlsmnucIkEJye6mpTdFJsX9zCMZqJzd4eDQfBCE7P8kFNlLMkCjZ
 sHxAsAuI5GtqiJWA+HVPNOtkcN2XbZ+o6fLbo02jEvYa83Ojn6qbiiRc5240JAASQIzs
 +ZsNA9+GmbMAQva4sd2cfdD1QjL4Hhh//p5PsYh5joqyJwmEULuxDveAxtL5ZTMwpyYm
 dmNk+J3kal00Hw247GuPE3E8Ar7k0ZV8llvcw4lSTDb61w5SJdQ6mJcayun2Ja4pr/Hz
 PLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MQ+MbYzqozJQ8J6CVJK/Op+zhd+3OFxe+UkgMgIDHKA=;
 b=MRq/JXXyPAO1lUEvjKAVXeYQ/sd8dT+KuN+41khmrR4v0ZvME8aQWTn7GoG5qHdcty
 5M/D8Cbma1YsP76dVOAMXSLI7bfPYMUH2TLh0VmSzUYx6G0P3xUOUvLLJMf7b/u4yQFY
 +N65xk33K6apMtZ5XEtYNtswq7Y4IZIJKEJcs+WX+Udot48TZy/8wRHKF5UkrhUznv50
 /PbOsvu5cBu4VoDc9rAH80KW6E/gqWD+3jeJrxFEgkpP8VKoBqVpGbp3niN1tdKmnA9+
 npFWHIGQZi1rKDuKU0VV9d62TcfwB4tWxoBua2yxpQkdu0gtMs9s/4R8A3J/o5oBMQLf
 ic+w==
X-Gm-Message-State: APjAAAVHqMjkSYNhUHPD3tQuGCQtGz/YfNHFaB6+f1lwSU87kzIC7dlN
 E82rEPrcVTX9y/TxhupQSuPE7A==
X-Google-Smtp-Source: APXvYqzSzarbNKsHiwJd2hN91qSf8CNBHvH4IyKWQzCOC3cz4EvwXaMntvuOMaabUkHn5M46LPQfrA==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr38442572wmi.79.1564589725297; 
 Wed, 31 Jul 2019 09:15:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a67sm77037062wmh.40.2019.07.31.09.15.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:22 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AC47E1FFAB;
 Wed, 31 Jul 2019 17:07:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:48 +0100
Message-Id: <20190731160719.11396-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v4 23/54] tcg: let plugins instrument virtual
 memory accesses
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

To capture all memory accesses we need hook into all the various
helper functions that are involved in memory operations as well as the
injected inline helper calls. A later commit will allow us to resolve
the actual guest HW addresses by replaying the lookup.

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: drop haddr handling, just deal in vaddr]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - fixes for cpu_neg()
v4
  - rebase fixups, moved cpu_neg() fixes down the stack
  - drop haddr support - will be restored with later helper
  - reword commit
---
 accel/tcg/atomic_common.inc.c             |  4 +++
 accel/tcg/atomic_template.h               |  1 +
 accel/tcg/cpu-exec.c                      |  3 ++
 accel/tcg/cputlb.c                        | 14 ++++----
 include/exec/cpu-defs.h                   |  1 +
 include/exec/cpu_ldst_template.h          | 28 +++++++++-------
 include/exec/cpu_ldst_useronly_template.h | 29 ++++++++--------
 tcg/tcg-op.c                              | 40 ++++++++++++++++++-----
 tcg/tcg.h                                 |  1 +
 9 files changed, 79 insertions(+), 42 deletions(-)

diff --git a/accel/tcg/atomic_common.inc.c b/accel/tcg/atomic_common.inc.c
index a86098fb2de..344525b0bb3 100644
--- a/accel/tcg/atomic_common.inc.c
+++ b/accel/tcg/atomic_common.inc.c
@@ -25,6 +25,8 @@ void atomic_trace_rmw_pre(CPUArchState *env, target_ulong addr, uint16_t info)
 static inline void
 atomic_trace_rmw_post(CPUArchState *env, target_ulong addr, uint16_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, info);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, info | TRACE_MEM_ST);
 }
 
 static inline
@@ -36,6 +38,7 @@ void atomic_trace_ld_pre(CPUArchState *env, target_ulong addr, uint16_t info)
 static inline
 void atomic_trace_ld_post(CPUArchState *env, target_ulong addr, uint16_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, info);
 }
 
 static inline
@@ -47,4 +50,5 @@ void atomic_trace_st_pre(CPUArchState *env, target_ulong addr, uint16_t info)
 static inline
 void atomic_trace_st_post(CPUArchState *env, target_ulong addr, uint16_t info)
 {
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, info);
 }
diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 34f891d4a62..4f209c8e18c 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 16
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ab9dfd4f908..81be72a373d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -269,6 +269,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
             qemu_mutex_unlock_iothread();
         }
         assert_no_pages_locked();
+        qemu_plugin_disable_mem_helpers(cpu);
     }
 
     if (cpu_in_exclusive_context(cpu)) {
@@ -702,6 +703,8 @@ int cpu_exec(CPUState *cpu)
         if (qemu_mutex_iothread_locked()) {
             qemu_mutex_unlock_iothread();
         }
+        qemu_plugin_disable_mem_helpers(cpu);
+
         assert_no_pages_locked();
     }
 
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e4ac06041a2..f7c0290639c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -881,7 +881,7 @@ static void tlb_fill(CPUState *cpu, target_ulong addr, int size,
 
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          int mmu_idx, target_ulong addr, uintptr_t retaddr,
-                         MMUAccessType access_type, int size)
+                         TCGMemOp mo, MMUAccessType access_type, int size)
 {
     CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
@@ -925,7 +925,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       int mmu_idx, uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, int size)
+                      uintptr_t retaddr, TCGMemOp mo, int size)
 {
     CPUState *cpu = env_cpu(env);
     hwaddr mr_offset;
@@ -1264,7 +1264,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         offsetof(CPUTLBEntry, addr_code) : offsetof(CPUTLBEntry, addr_read);
     const MMUAccessType access_type =
         code_read ? MMU_INST_FETCH : MMU_DATA_LOAD;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    TCGMemOp mo = get_memop(oi);
+    unsigned a_bits = get_alignment_bits(mo);
     void *haddr;
     uint64_t res;
 
@@ -1313,7 +1314,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         }
 
         res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                       mmu_idx, addr, retaddr, access_type, size);
+                       mmu_idx, addr, retaddr, mo, access_type, size);
         return handle_bswap(res, size, big_endian);
     }
 
@@ -1513,7 +1514,8 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr = tlb_addr_write(entry);
     const size_t tlb_off = offsetof(CPUTLBEntry, addr_write);
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    TCGMemOp mo = get_memop(oi);
+    unsigned a_bits = get_alignment_bits(mo);
     void *haddr;
 
     /* Handle CPU specific unaligned behaviour */
@@ -1562,7 +1564,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
                   handle_bswap(val, size, big_endian),
-                  addr, retaddr, size);
+                  addr, retaddr, mo, size);
         return;
     }
 
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9bc713a70b2..31deca369ea 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -215,6 +215,7 @@ typedef struct CPUTLBCommon {
  * Since this is placed within CPUNegativeOffsetState, the smallest
  * negative offsets are at the end of the struct.
  */
+
 typedef struct CPUTLB {
     CPUTLBCommon c;
     CPUTLBDesc d[NB_MMU_MODES];
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 5750a26b9ec..6f0d3407979 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -28,6 +28,7 @@
 #include "trace-root.h"
 #endif
 
+#include "qemu/plugin.h"
 #include "trace/mem.h"
 
 #if DATA_SIZE == 8
@@ -86,11 +87,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
-
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false, mmu_idx));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false, mmu_idx);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -104,6 +103,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+#endif
     return res;
 }
 
@@ -124,11 +126,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
-
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false, mmu_idx));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false, mmu_idx);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -142,6 +142,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         uintptr_t hostaddr = addr + entry->addend;
         res = glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+#endif
     return res;
 }
 
@@ -165,11 +168,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     target_ulong addr;
     int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
-
 #if !defined(SOFTMMU_CODE_ACCESS)
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true, mmu_idx));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true, mmu_idx);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
 #endif
 
     addr = ptr;
@@ -183,6 +184,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
         uintptr_t hostaddr = addr + entry->addend;
         glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
     }
+#ifndef SOFTMMU_CODE_ACCESS
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
+#endif
 }
 
 static inline void
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 8f7f117ad44..5cd0fa3b99d 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -64,18 +64,17 @@
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#ifdef CODE_ACCESS
     RES_TYPE ret;
+#ifdef CODE_ACCESS
     set_helper_retaddr(1);
     ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
     clear_helper_retaddr();
-    return ret;
 #else
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false, 0));
-    return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, false, 0);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 #endif
+    return ret;
 }
 
 #ifndef CODE_ACCESS
@@ -96,18 +95,18 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#ifdef CODE_ACCESS
     int ret;
+#ifdef CODE_ACCESS
     set_helper_retaddr(1);
     ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
     clear_helper_retaddr();
-    return ret;
 #else
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false, 0));
-    return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, true, MO_TE, false, 0);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
+    ret = glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
 #endif
+    return ret;
 }
 
 #ifndef CODE_ACCESS
@@ -130,10 +129,10 @@ static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
                                       RES_TYPE v)
 {
-    trace_guest_mem_before_exec(
-        env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true, 0));
+    uint16_t meminfo = trace_mem_build_info(SHIFT, false, MO_TE, true, 0);
+    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
 }
 
 static inline void
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 38e62dcba97..b60b42e6410 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -30,6 +30,7 @@
 #include "tcg-mo.h"
 #include "trace-tcg.h"
 #include "trace/mem.h"
+#include "exec/plugin-gen.h"
 
 /* Reduce the number of ifdefs below.  This assumes that all uses of
    TCGV_HIGH and TCGV_LOW are properly protected by a conditional that
@@ -2684,6 +2685,7 @@ void tcg_gen_exit_tb(TranslationBlock *tb, unsigned idx)
         tcg_debug_assert(idx == TB_EXIT_REQUESTED);
     }
 
+    plugin_gen_disable_mem_helpers();
     tcg_gen_op1i(INDEX_op_exit_tb, val);
 }
 
@@ -2696,6 +2698,7 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_debug_assert((tcg_ctx->goto_tb_issue_mask & (1 << idx)) == 0);
     tcg_ctx->goto_tb_issue_mask |= 1 << idx;
 #endif
+    plugin_gen_disable_mem_helpers();
     /* When not chaining, we simply fall through to the "fallback" exit.  */
     if (!qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
         tcg_gen_op1i(INDEX_op_goto_tb, idx);
@@ -2705,7 +2708,10 @@ void tcg_gen_goto_tb(unsigned idx)
 void tcg_gen_lookup_and_goto_ptr(void)
 {
     if (TCG_TARGET_HAS_goto_ptr && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
-        TCGv_ptr ptr = tcg_temp_new_ptr();
+        TCGv_ptr ptr;
+
+        plugin_gen_disable_mem_helpers();
+        ptr = tcg_temp_new_ptr();
         gen_helper_lookup_tb_ptr(ptr, cpu_env);
         tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
         tcg_temp_free_ptr(ptr);
@@ -2788,14 +2794,24 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static inline void plugin_gen_mem_callbacks(TCGv vaddr, uint16_t info)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn == NULL) {
+        return;
+    }
+    plugin_gen_empty_mem_callback(vaddr, info);
+#endif
+}
+
 void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     TCGMemOp orig_memop;
+    uint16_t info = trace_mem_get_info(memop, idx, 0);
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, idx, 0));
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2807,6 +2823,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -2828,11 +2845,11 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     TCGv_i32 swap = NULL;
+    uint16_t info = trace_mem_get_info(memop, idx, 1);
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, idx, 1));
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i32();
@@ -2852,6 +2869,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -2861,6 +2879,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     TCGMemOp orig_memop;
+    uint16_t info;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2874,8 +2893,8 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 1, 0);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, idx, 0));
+    info = trace_mem_get_info(memop, idx, 0);
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2887,6 +2906,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -2914,6 +2934,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 {
     TCGv_i64 swap = NULL;
+    uint16_t info;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2922,8 +2943,8 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
-    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, idx, 1));
+    info = trace_mem_get_info(memop, idx, 1);
+    trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env, addr, info);
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i64();
@@ -2947,6 +2968,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     }
 
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
+    plugin_gen_mem_callbacks(addr, info);
 
     if (swap) {
         tcg_temp_free_i64(swap);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 2385e758e55..93f52f4ca93 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -28,6 +28,7 @@
 #include "cpu.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "tcg-mo.h"
 #include "tcg-target.h"
-- 
2.20.1


