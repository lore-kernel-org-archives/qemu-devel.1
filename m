Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D0BC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2949D20CC7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HolfXHGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2949D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5ND-0006pv-7N
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ah-0007ht-0L
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:19 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Ae-0005Kv-GO
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:44:18 -0400
Received: by mail-pf1-x444.google.com with SMTP id x77so1140484pfc.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t8M2cL4tKnio/X4k/ktq+rXeCnBIOcWaxmxMRjHpbTo=;
 b=HolfXHGrpqk/V8OFF5ZpQSSOW7Ty5ycCEGqecy1svkbJHLDDRyof64JSYpI0a2jmzI
 lq7xVTUdYYIz0jrpAzq93x+2MYmdCS0RimvWPYAzK+AGU40pF+R/ujaeTfdDV2yz6oj+
 4RGSylzpEBembBudfHX0/+/3L8GclHQeRpGsrEt3XoTRWQgYp52ImkKg5MpOw79v6tAy
 7YgVU2r7wLPk5wzqd5Tv+LMaMonQAsaVKAsMwVKZCRRj5hy4B3zf2Q0LrlooFRuF6SPp
 g7Rim6CvjJ83O7cL9uBPjJ45G+1mN2qU6xTCIAjnzjAMxIF7YwroIAQwNYohbJE6DLTo
 /vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t8M2cL4tKnio/X4k/ktq+rXeCnBIOcWaxmxMRjHpbTo=;
 b=YFf+bTvkL93lxvllgXbQIFXoSyUGGllGQn81LUB4IVugj8YEDj5v096dEjCI6I397n
 uZIXIcfJNblMWecZIoH2TvxJy4WAoIlGYsEko7S+vvDO2lzZWsxaJ3705ImUSuEvI2el
 u/mqrc/piM4McmhPIWnNsbaD80xnRXQNxGnJk5MVs0ly2HXQxZuMq13GDjUjXm6zq2Tu
 tVTxw3R6hdDYYh0iCAgNYZ78oTzld2yUHpVeMxTo5iwitqp/pGU+eAQbmadH1UB3ow3u
 o+3u2HjuVGrb6jOrHrG03zuO2vHLIveR4QaOqVBFEcm7MPbSJ3SobV48LWQQbeysH6ks
 TRjg==
X-Gm-Message-State: AGi0Pubb55iWoYsTuG1jB+f41JHcsapXq6aKZAZfYCvSr9Hi5ADqGGiT
 Jt168/zLTnl/fMg4gNYCq3Ja7zyzEd0=
X-Google-Smtp-Source: APiQypJaIv+aZKef7oORPAzA37PBTJieU2gu/iF/qO8YKcblGNTawairMazZKohLDLxf5+Vzp3/8Aw==
X-Received: by 2002:a62:f941:: with SMTP id g1mr3390074pfm.118.1588952653643; 
 Fri, 08 May 2020 08:44:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id o99sm2727662pjo.8.2020.05.08.08.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:44:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/19] accel/tcg: Add probe_access_flags
Date: Fri,  8 May 2020 08:43:45 -0700
Message-Id: <20200508154359.7494-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
References: <20200508154359.7494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new interface will allow targets to probe for a page
and then handle watchpoints themselves.  This will be most
useful for vector predicated memory operations, where one
page lookup can be used for many operations, and one test
can avoid many watchpoint checks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix return of host pointer in softmmu probe_access_flags.
v4: Match user-only version closer to softmmu version.
---
 include/exec/cpu-all.h  |  13 ++-
 include/exec/exec-all.h |  22 +++++
 accel/tcg/cputlb.c      | 177 ++++++++++++++++++++--------------------
 accel/tcg/user-exec.c   |  43 ++++++++--
 4 files changed, 158 insertions(+), 97 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 49384bb66a..43ddcf024c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -328,7 +328,18 @@ CPUArchState *cpu_copy(CPUArchState *env);
      | CPU_INTERRUPT_TGT_EXT_3   \
      | CPU_INTERRUPT_TGT_EXT_4)
 
-#if !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_USER_ONLY
+
+/*
+ * Allow some level of source compatibility with softmmu.  We do not
+ * support any of the more exotic features, so only invalid pages may
+ * be signaled by probe_access_flags().
+ */
+#define TLB_INVALID_MASK    (1 << (TARGET_PAGE_BITS_MIN - 1))
+#define TLB_MMIO            0
+#define TLB_WATCHPOINT      0
+
+#else
 
 /*
  * Flags stored in the low bits of the TLB virtual address.
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index d656a1f05c..8792bea07a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -362,6 +362,28 @@ static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
     return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
 }
 
+/**
+ * probe_access_flags:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @access_type: read, write or execute permission
+ * @mmu_idx: MMU index to use for lookup
+ * @nonfault: suppress the fault
+ * @phost: return value for host address
+ * @retaddr: return address for unwinding
+ *
+ * Similar to probe_access, loosely returning the TLB_FLAGS_MASK for
+ * the page, and storing the host address for RAM in @phost.
+ *
+ * If @nonfault is set, do not raise an exception but return TLB_INVALID_MASK.
+ * Do not handle watchpoints, but include TLB_WATCHPOINT in the returned flags.
+ * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
+ * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
+ */
+int probe_access_flags(CPUArchState *env, target_ulong addr,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool nonfault, void **phost, uintptr_t retaddr);
+
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
 
 /* Estimated block size for TB allocation.  */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e3b5750c3b..c708e9785f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1231,86 +1231,16 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     }
 }
 
-/*
- * Probe for whether the specified guest access is permitted. If it is not
- * permitted then an exception will be taken in the same way as if this
- * were a real access (and we will not return).
- * If the size is 0 or the page requires I/O access, returns NULL; otherwise,
- * returns the address of the host page similar to tlb_vaddr_to_host().
- */
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
-                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+static int probe_access_internal(CPUArchState *env, target_ulong addr,
+                                 int fault_size, MMUAccessType access_type,
+                                 int mmu_idx, bool nonfault,
+                                 void **phost, uintptr_t retaddr)
 {
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr;
-    size_t elt_ofs;
-    int wp_access;
-
-    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
-
-    switch (access_type) {
-    case MMU_DATA_LOAD:
-        elt_ofs = offsetof(CPUTLBEntry, addr_read);
-        wp_access = BP_MEM_READ;
-        break;
-    case MMU_DATA_STORE:
-        elt_ofs = offsetof(CPUTLBEntry, addr_write);
-        wp_access = BP_MEM_WRITE;
-        break;
-    case MMU_INST_FETCH:
-        elt_ofs = offsetof(CPUTLBEntry, addr_code);
-        wp_access = BP_MEM_READ;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    tlb_addr = tlb_read_ofs(entry, elt_ofs);
-
-    if (unlikely(!tlb_hit(tlb_addr, addr))) {
-        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs,
-                            addr & TARGET_PAGE_MASK)) {
-            tlb_fill(env_cpu(env), addr, size, access_type, mmu_idx, retaddr);
-            /* TLB resize via tlb_fill may have moved the entry. */
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
-        }
-        tlb_addr = tlb_read_ofs(entry, elt_ofs);
-    }
-
-    if (!size) {
-        return NULL;
-    }
-
-    if (unlikely(tlb_addr & TLB_FLAGS_MASK)) {
-        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
-
-        /* Reject I/O access, or other required slow-path.  */
-        if (tlb_addr & (TLB_MMIO | TLB_BSWAP | TLB_DISCARD_WRITE)) {
-            return NULL;
-        }
-
-        /* Handle watchpoints.  */
-        if (tlb_addr & TLB_WATCHPOINT) {
-            cpu_check_watchpoint(env_cpu(env), addr, size,
-                                 iotlbentry->attrs, wp_access, retaddr);
-        }
-
-        /* Handle clean RAM pages.  */
-        if (tlb_addr & TLB_NOTDIRTY) {
-            notdirty_write(env_cpu(env), addr, size, iotlbentry, retaddr);
-        }
-    }
-
-    return (void *)((uintptr_t)addr + entry->addend);
-}
-
-void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
-                        MMUAccessType access_type, int mmu_idx)
-{
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr, page;
+    target_ulong tlb_addr, page_addr;
     size_t elt_ofs;
+    int flags;
 
     switch (access_type) {
     case MMU_DATA_LOAD:
@@ -1325,20 +1255,19 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     default:
         g_assert_not_reached();
     }
-
-    page = addr & TARGET_PAGE_MASK;
     tlb_addr = tlb_read_ofs(entry, elt_ofs);
 
-    if (!tlb_hit_page(tlb_addr, page)) {
-        uintptr_t index = tlb_index(env, mmu_idx, addr);
-
-        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs, page)) {
+    page_addr = addr & TARGET_PAGE_MASK;
+    if (!tlb_hit_page(tlb_addr, page_addr)) {
+        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs, page_addr)) {
             CPUState *cs = env_cpu(env);
             CPUClass *cc = CPU_GET_CLASS(cs);
 
-            if (!cc->tlb_fill(cs, addr, 0, access_type, mmu_idx, true, 0)) {
+            if (!cc->tlb_fill(cs, addr, fault_size, access_type,
+                              mmu_idx, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
-                return NULL;
+                *phost = NULL;
+                return TLB_INVALID_MASK;
             }
 
             /* TLB resize via tlb_fill may have moved the entry.  */
@@ -1346,15 +1275,89 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
         }
         tlb_addr = tlb_read_ofs(entry, elt_ofs);
     }
+    flags = tlb_addr & TLB_FLAGS_MASK;
 
-    if (tlb_addr & ~TARGET_PAGE_MASK) {
-        /* IO access */
+    /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
+    if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))) {
+        *phost = NULL;
+        return TLB_MMIO;
+    }
+
+    /* Everything else is RAM. */
+    *phost = (void *)((uintptr_t)addr + entry->addend);
+    return flags;
+}
+
+int probe_access_flags(CPUArchState *env, target_ulong addr,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool nonfault, void **phost, uintptr_t retaddr)
+{
+    int flags;
+
+    flags = probe_access_internal(env, addr, 0, access_type, mmu_idx,
+                                  nonfault, phost, retaddr);
+
+    /* Handle clean RAM pages.  */
+    if (unlikely(flags & TLB_NOTDIRTY)) {
+        uintptr_t index = tlb_index(env, mmu_idx, addr);
+        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+
+        notdirty_write(env_cpu(env), addr, 1, iotlbentry, retaddr);
+        flags &= ~TLB_NOTDIRTY;
+    }
+
+    return flags;
+}
+
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    void *host;
+    int flags;
+
+    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
+
+    flags = probe_access_internal(env, addr, size, access_type, mmu_idx,
+                                  false, &host, retaddr);
+
+    /* Per the interface, size == 0 merely faults the access. */
+    if (size == 0) {
         return NULL;
     }
 
-    return (void *)((uintptr_t)addr + entry->addend);
+    if (unlikely(flags & (TLB_NOTDIRTY | TLB_WATCHPOINT))) {
+        uintptr_t index = tlb_index(env, mmu_idx, addr);
+        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+
+        /* Handle watchpoints.  */
+        if (flags & TLB_WATCHPOINT) {
+            int wp_access = (access_type == MMU_DATA_STORE
+                             ? BP_MEM_WRITE : BP_MEM_READ);
+            cpu_check_watchpoint(env_cpu(env), addr, size,
+                                 iotlbentry->attrs, wp_access, retaddr);
+        }
+
+        /* Handle clean RAM pages.  */
+        if (flags & TLB_NOTDIRTY) {
+            notdirty_write(env_cpu(env), addr, 1, iotlbentry, retaddr);
+        }
+    }
+
+    return host;
 }
 
+void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+                        MMUAccessType access_type, int mmu_idx)
+{
+    void *host;
+    int flags;
+
+    flags = probe_access_internal(env, addr, 0, access_type,
+                                  mmu_idx, true, &host, 0);
+
+    /* No combination of flags are expected by the caller. */
+    return flags ? NULL : host;
+}
 
 #ifdef CONFIG_PLUGIN
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 03538e2a38..987342c50c 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -190,13 +190,12 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     g_assert_not_reached();
 }
 
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
-                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+static int probe_access_internal(CPUArchState *env, target_ulong addr,
+                                 int fault_size, MMUAccessType access_type,
+                                 bool nonfault, uintptr_t ra)
 {
     int flags;
 
-    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
-
     switch (access_type) {
     case MMU_DATA_STORE:
         flags = PAGE_WRITE;
@@ -212,12 +211,38 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
     }
 
     if (!guest_addr_valid(addr) || page_check_range(addr, 1, flags) < 0) {
-        CPUState *cpu = env_cpu(env);
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-        cc->tlb_fill(cpu, addr, size, access_type, MMU_USER_IDX, false,
-                     retaddr);
-        g_assert_not_reached();
+        if (nonfault) {
+            return TLB_INVALID_MASK;
+        } else {
+            CPUState *cpu = env_cpu(env);
+            CPUClass *cc = CPU_GET_CLASS(cpu);
+            cc->tlb_fill(cpu, addr, fault_size, access_type,
+                         MMU_USER_IDX, false, ra);
+            g_assert_not_reached();
+        }
     }
+    return 0;
+}
+
+int probe_access_flags(CPUArchState *env, target_ulong addr,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool nonfault, void **phost, uintptr_t ra)
+{
+    int flags;
+
+    flags = probe_access_internal(env, addr, 0, access_type, nonfault, ra);
+    *phost = flags ? NULL : g2h(addr);
+    return flags;
+}
+
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t ra)
+{
+    int flags;
+
+    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
+    flags = probe_access_internal(env, addr, size, access_type, false, ra);
+    g_assert(flags == 0);
 
     return size ? g2h(addr) : NULL;
 }
-- 
2.20.1


