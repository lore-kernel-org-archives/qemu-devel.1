Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C518C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAC8208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faxQT0/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAC8208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBv84-00083H-Sl
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6V-00069K-US
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6S-0001mW-5h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:30 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6Q-0001hB-D0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:27 -0400
Received: by mail-pg1-x544.google.com with SMTP id s2so637509pgv.6
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WFkeQZK5wV/2b9hgN0NoiBdZ/Pf2pozUeegzyTZXJXc=;
 b=faxQT0/TZ2lP8LdufRbHEAMgV5SqtHpRoMMBYOjXzi8/oIgSE3khGexXHAGUuNG0TG
 HBFx4yEsGDAuJfnSqyKCTqX3yy0UoII0WkRISbXRIvE1r5FuUy9PrM/cMnn7z5BD+ZoR
 Sm/7bl3KmX+FCEFDGgjYlJwxMRzggqNhG4pbEjEyH0aRzMhXhNnE75kJ3lv8fHbm7VNx
 gkOmIqWNgU1ALaPxbOXA/XouNF/Ej3x7j+H02mErdIAckpsh8fhVcNPDUlTBbQSyk+BU
 tqlm0WdPXZ0rXAXQsxHs4dVKNUX76eREDFyqqAzVgXlSMu0Rg7S4Xq2tI64LGIpxVXO5
 9FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WFkeQZK5wV/2b9hgN0NoiBdZ/Pf2pozUeegzyTZXJXc=;
 b=K31lWmGYEx0M7T/8X0rwbiiOfC/rQykIM7ng0gzcQyri5UwLgjV3pZpjxN6QpyDgs2
 Cu9VX2kjqaS4++1ou4gX40nGfQnJqLcFV+Ypb+5/Ybmo6UMUNK2TeWrRo2r+Ufx9jTSP
 m+uLucfW6WQJ8L3yK/AK0Gr+uK3MzjJnCtodooZeUQr36WjMx5xJbWTqJjh7bkMwOhM1
 m9dgTjK1K5Xe+fxQ0t0qNyLv0nYojG4/W+cmwE/pw7gSaq19Nin23N3pnUuOEAD8o6M9
 NN9Oq84Jr+Eva3e5/r78iov6ixA1g3JG3lmF9bsPKaZif2tcC+6YRLywkCUpwyIBXwrR
 2IJw==
X-Gm-Message-State: ANhLgQ1w+RbMvjbhvItVqAJPmik5giBmKTfAgQBZEVhpS5f6yLnrS5JC
 hefIslMFGGDC1JEV7VJR7lesvzZlEEM=
X-Google-Smtp-Source: ADFU+vscHFYOUsqUCYSm/DcBOf/RkUoHO+NY8/Ep+wTZXuiNzAk0nLaVUiILr/VG477fYH+5xaNpgg==
X-Received: by 2002:a63:a65:: with SMTP id z37mr1405166pgk.31.1583909064289;
 Tue, 10 Mar 2020 23:44:24 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] accel/tcg: Add probe_access_flags
Date: Tue, 10 Mar 2020 23:44:06 -0700
Message-Id: <20200311064420.30606-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
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
 include/exec/cpu-all.h  |  13 ++-
 include/exec/exec-all.h |  22 +++++
 accel/tcg/cputlb.c      | 178 ++++++++++++++++++++--------------------
 accel/tcg/user-exec.c   |  36 +++++---
 4 files changed, 150 insertions(+), 99 deletions(-)

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
index e3b5750c3b..687474ccea 100644
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
@@ -1346,15 +1275,90 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
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
+    void *host;
+    int flags;
+
+    flags = probe_access_internal(env, addr, 0, access_type, mmu_idx,
+                                  nonfault, &host, retaddr);
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
+        /* Handle clean RAM pages.  */
+        if (flags & TLB_NOTDIRTY) {
+            notdirty_write(env_cpu(env), addr, 1, iotlbentry, retaddr);
+        }
+
+        /* Handle watchpoints.  */
+        if (flags & TLB_WATCHPOINT) {
+            int wp_access = (access_type == MMU_DATA_STORE
+                             ? BP_MEM_WRITE : BP_MEM_READ);
+            cpu_check_watchpoint(env_cpu(env), addr, size,
+                                 iotlbentry->attrs, wp_access, retaddr);
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
index 4be78eb9b3..c52dd8a95a 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -190,13 +190,12 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     g_assert_not_reached();
 }
 
-void *probe_access(CPUArchState *env, target_ulong addr, int size,
-                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+int probe_access_flags(CPUArchState *env, target_ulong addr,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool nonfault, void **phost, uintptr_t retaddr)
 {
     int flags;
 
-    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
-
     switch (access_type) {
     case MMU_DATA_STORE:
         flags = PAGE_WRITE;
@@ -211,15 +210,30 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
         g_assert_not_reached();
     }
 
-    if (!guest_addr_valid(addr) || page_check_range(addr, size, flags) < 0) {
-        CPUState *cpu = env_cpu(env);
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-        cc->tlb_fill(cpu, addr, size, access_type, MMU_USER_IDX, false,
-                     retaddr);
-        g_assert_not_reached();
+    if (!guest_addr_valid(addr) || page_check_range(addr, 1, flags) < 0) {
+        if (nonfault) {
+            *phost = NULL;
+            return TLB_INVALID_MASK;
+        } else {
+            CPUState *cpu = env_cpu(env);
+            CPUClass *cc = CPU_GET_CLASS(cpu);
+            cc->tlb_fill(cpu, addr, 0, access_type, MMU_USER_IDX, false, retaddr);
+            g_assert_not_reached();
+        }
     }
 
-    return size ? g2h(addr) : NULL;
+    *phost = g2h(addr);
+    return 0;
+}
+
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    void *host;
+
+    g_assert(-(addr | TARGET_PAGE_MASK) >= size);
+    probe_access_flags(env, addr, access_type, mmu_idx, false, &host, retaddr);
+    return host;
 }
 
 #if defined(__i386__)
-- 
2.20.1


