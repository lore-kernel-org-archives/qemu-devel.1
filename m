Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F46C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC81C20675
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlYS8hRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC81C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOABg-0002ig-VU
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:11:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6p-0007Bb-Pz
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOA6l-0005vr-6Z
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOA6k-0005ot-RT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:06:51 -0400
Received: by mail-pf1-x441.google.com with SMTP id y13so9480250pfm.11
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=+D5j5a6cnSwn/99ODXcI0DMvoR+N8vkM4pkxoovJaqY=;
	b=FlYS8hRlaiVmvfo+USqi1nJ6UXqkHZpPq3WVsf7gE3SLZgNSz4qnUdsugfTlWJE/51
	WcVhmYDTTdXsqHC64zK1BPABfIgaLHy9iw+LzoeLfTBR/TJrs4BY3QF58pLfKyn1PgTZ
	plaAUwhNbJhFchIi0v1yioUCEL6wf6MRBnMi8fEbwPjSAOBALDUpwsZ+Mqr00KoaNqir
	3GM5PXxxqExRDjFZOz+VgeoEMwInsVh/kh0eori+9C95L/NTHXxc+06QIcMhuYw26F/G
	mJQHqEBbydefIaB96Cse9ZZJ6ELF8eFaPcvc4tnnp+CX1hgDKsqLuznRpljt3YusxYiL
	ORWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=+D5j5a6cnSwn/99ODXcI0DMvoR+N8vkM4pkxoovJaqY=;
	b=p2tLI38Ft6SVxmSll7z8LubwUxzNX2kexsq62I159IqpcXk4VDQl2HqU8rZl79vpiY
	Bldtf/o7G1+sd7CoQu2Pwg23TahI5dIJZBPpBjyCQIdfVCUijoyeVknqj4m/Dl23RXKh
	URO3u7GHeNIb5abPU7r4ZiF/eDmEV0h7SNPSXeEPUmq3rymTiRKECTfIEOfTn06+7yyL
	qn23QbcA842DBbPPYoVzc8+GIDOlYY291Uk+dtNy9AvbE+3W9bJ0+RuwIFcrzWGLS3/M
	eFxG9AN6MdHpN9Dajpw7/E3D7imxl573W6pbU8+pySmXRmSIsxkHvWnzpVOgmjAmD/k3
	4oKg==
X-Gm-Message-State: APjAAAVqG7LTuDrIXvvwkBsasRpfS6Bd0x/2MWebOyiyEI6kF5qf2dyL
	Xx/ZbfIQoS18XsNCkGUJKApiHGQsnD0=
X-Google-Smtp-Source: APXvYqzW7nKa5NgmY8dY0Vcsk8vCgU45HHegVPIjJL4nILB9g3H7mPyR6xPjVn8cekuzc0zHczQWAQ==
X-Received: by 2002:a63:1b04:: with SMTP id b4mr42818778pgb.305.1557274007540; 
	Tue, 07 May 2019 17:06:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	j1sm15793183pgp.91.2019.05.07.17.06.46 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:06:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 17:06:05 -0700
Message-Id: <20190508000641.19090-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508000641.19090-1-richard.henderson@linaro.org>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 03/39] tcg: Create struct CPUTLB
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move all softmmu tlb data into this structure.  Arrange the
members so that we are able to place mask+table together and
at a smaller absolute offset from ENV.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/softmmu_template.h |   4 +-
 include/exec/cpu-defs.h      |  61 ++++++++------
 include/exec/cpu_ldst.h      |   6 +-
 accel/tcg/cputlb.c           | 149 ++++++++++++++++++-----------------
 target/arm/translate-a64.c   |   2 +-
 tcg/aarch64/tcg-target.inc.c |  10 +--
 tcg/arm/tcg-target.inc.c     |  10 +--
 tcg/i386/tcg-target.inc.c    |   4 +-
 tcg/mips/tcg-target.inc.c    |  12 +--
 tcg/ppc/tcg-target.inc.c     |   8 +-
 tcg/riscv/tcg-target.inc.c   |  12 +--
 tcg/s390/tcg-target.inc.c    |   8 +-
 tcg/sparc/tcg-target.inc.c   |  12 +--
 13 files changed, 137 insertions(+), 161 deletions(-)

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index e970a8b378..fc6371aed1 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -102,7 +102,7 @@ static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
                                               bool recheck,
                                               MMUAccessType access_type)
 {
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+    CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
     return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, recheck,
                     access_type, DATA_SIZE);
 }
@@ -273,7 +273,7 @@ static inline void glue(io_write, SUFFIX)(CPUArchState *env,
                                           uintptr_t retaddr,
                                           bool recheck)
 {
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+    CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
     return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
                      recheck, DATA_SIZE);
 }
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 2694481769..fbe8945606 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -78,6 +78,7 @@ typedef uint64_t target_ulong;
 #endif
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+
 /* use a fully associative victim tlb of 8 entries */
 #define CPU_VTLB_SIZE 8
 
@@ -147,6 +148,10 @@ typedef struct CPUIOTLBEntry {
     MemTxAttrs attrs;
 } CPUIOTLBEntry;
 
+/*
+ * Data elements that are per MMU mode, minus the bits accessed by
+ * the TCG fast path.
+ */
 typedef struct CPUTLBDesc {
     /*
      * Describe a region covering all of the large pages allocated
@@ -160,16 +165,31 @@ typedef struct CPUTLBDesc {
     int64_t window_begin_ns;
     /* maximum number of entries observed in the window */
     size_t window_max_entries;
+    size_t n_used_entries;
     /* The next index to use in the tlb victim table.  */
     size_t vindex;
-    size_t n_used_entries;
+    /* The tlb victim table, in two parts.  */
+    CPUTLBEntry vtable[CPU_VTLB_SIZE];
+    CPUIOTLBEntry viotlb[CPU_VTLB_SIZE];
+    /* The iotlb.  */
+    CPUIOTLBEntry *iotlb;
 } CPUTLBDesc;
 
+/*
+ * Data elements that are per MMU mode, accessed by the fast path.
+ */
+typedef struct CPUTLBDescFast {
+    /* Contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */
+    uintptr_t mask;
+    /* The array of tlb entries itself. */
+    CPUTLBEntry *table;
+} CPUTLBDescFast;
+
 /*
  * Data elements that are shared between all MMU modes.
  */
 typedef struct CPUTLBCommon {
-    /* Serialize updates to tlb_table and tlb_v_table, and others as noted. */
+    /* Serialize updates to tlb_table and vtable, and others as noted. */
     QemuSpin lock;
     /*
      * Within dirty, for each bit N, modifications have been made to
@@ -187,35 +207,24 @@ typedef struct CPUTLBCommon {
     size_t elide_flush_count;
 } CPUTLBCommon;
 
-# define CPU_TLB                                                        \
-    /* tlb_mask[i] contains (n_entries - 1) << CPU_TLB_ENTRY_BITS */    \
-    uintptr_t tlb_mask[NB_MMU_MODES];                                   \
-    CPUTLBEntry *tlb_table[NB_MMU_MODES];
-# define CPU_IOTLB                              \
-    CPUIOTLBEntry *iotlb[NB_MMU_MODES];
-
 /*
+ * The entire softmmu tlb, for all MMU modes.
  * The meaning of each of the MMU modes is defined in the target code.
- * Note that NB_MMU_MODES is not yet defined; we can only reference it
- * within preprocessor defines that will be expanded later.
  */
-#define CPU_COMMON_TLB \
-    CPUTLBCommon tlb_c;                                                 \
-    CPUTLBDesc tlb_d[NB_MMU_MODES];                                     \
-    CPU_TLB                                                             \
-    CPUTLBEntry tlb_v_table[NB_MMU_MODES][CPU_VTLB_SIZE];               \
-    CPU_IOTLB                                                           \
-    CPUIOTLBEntry iotlb_v[NB_MMU_MODES][CPU_VTLB_SIZE];
+typedef struct CPUTLB {
+    CPUTLBDescFast f[NB_MMU_MODES];
+    CPUTLBDesc d[NB_MMU_MODES];
+    CPUTLBCommon c;
+} CPUTLB;
+
+/* There are target-specific members named "tlb".  This is temporary.  */
+#define CPU_COMMON    CPUTLB tlb_;
+#define env_tlb(ENV)  (&(ENV)->tlb_)
 
 #else
 
-#define CPU_COMMON_TLB
-
-#endif
-
-
-#define CPU_COMMON                                                      \
-    /* soft mmu support */                                              \
-    CPU_COMMON_TLB                                                      \
+#define CPU_COMMON  /* Nothing */
+
+#endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
 #endif
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index d78041d7a0..09abd95008 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -139,21 +139,21 @@ static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
 static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
                                   target_ulong addr)
 {
-    uintptr_t size_mask = env->tlb_mask[mmu_idx] >> CPU_TLB_ENTRY_BITS;
+    uintptr_t size_mask = env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
 
     return (addr >> TARGET_PAGE_BITS) & size_mask;
 }
 
 static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
 {
-    return (env->tlb_mask[mmu_idx] >> CPU_TLB_ENTRY_BITS) + 1;
+    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
 }
 
 /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
 static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
                                      target_ulong addr)
 {
-    return &env->tlb_table[mmu_idx][tlb_index(env, mmu_idx, addr)];
+    return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)];
 }
 
 #ifdef MMU_MODE0_SUFFIX
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6c7593235c..2225640fc1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -76,7 +76,7 @@ QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 
 static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
 {
-    return env->tlb_mask[mmu_idx] + (1 << CPU_TLB_ENTRY_BITS);
+    return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
 }
 
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
@@ -91,14 +91,14 @@ static void tlb_dyn_init(CPUArchState *env)
     int i;
 
     for (i = 0; i < NB_MMU_MODES; i++) {
-        CPUTLBDesc *desc = &env->tlb_d[i];
+        CPUTLBDesc *desc = &env_tlb(env)->d[i];
         size_t n_entries = 1 << CPU_TLB_DYN_DEFAULT_BITS;
 
         tlb_window_reset(desc, get_clock_realtime(), 0);
         desc->n_used_entries = 0;
-        env->tlb_mask[i] = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
-        env->tlb_table[i] = g_new(CPUTLBEntry, n_entries);
-        env->iotlb[i] = g_new(CPUIOTLBEntry, n_entries);
+        env_tlb(env)->f[i].mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
+        env_tlb(env)->f[i].table = g_new(CPUTLBEntry, n_entries);
+        env_tlb(env)->d[i].iotlb = g_new(CPUIOTLBEntry, n_entries);
     }
 }
 
@@ -144,7 +144,7 @@ static void tlb_dyn_init(CPUArchState *env)
  */
 static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
 {
-    CPUTLBDesc *desc = &env->tlb_d[mmu_idx];
+    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
     size_t old_size = tlb_n_entries(env, mmu_idx);
     size_t rate;
     size_t new_size = old_size;
@@ -187,14 +187,14 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
         return;
     }
 
-    g_free(env->tlb_table[mmu_idx]);
-    g_free(env->iotlb[mmu_idx]);
+    g_free(env_tlb(env)->f[mmu_idx].table);
+    g_free(env_tlb(env)->d[mmu_idx].iotlb);
 
     tlb_window_reset(desc, now, 0);
     /* desc->n_used_entries is cleared by the caller */
-    env->tlb_mask[mmu_idx] = (new_size - 1) << CPU_TLB_ENTRY_BITS;
-    env->tlb_table[mmu_idx] = g_try_new(CPUTLBEntry, new_size);
-    env->iotlb[mmu_idx] = g_try_new(CPUIOTLBEntry, new_size);
+    env_tlb(env)->f[mmu_idx].mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+    env_tlb(env)->f[mmu_idx].table = g_try_new(CPUTLBEntry, new_size);
+    env_tlb(env)->d[mmu_idx].iotlb = g_try_new(CPUIOTLBEntry, new_size);
     /*
      * If the allocations fail, try smaller sizes. We just freed some
      * memory, so going back to half of new_size has a good chance of working.
@@ -202,46 +202,47 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
      * allocations to fail though, so we progressively reduce the allocation
      * size, aborting if we cannot even allocate the smallest TLB we support.
      */
-    while (env->tlb_table[mmu_idx] == NULL || env->iotlb[mmu_idx] == NULL) {
+    while (env_tlb(env)->f[mmu_idx].table == NULL ||
+           env_tlb(env)->d[mmu_idx].iotlb == NULL) {
         if (new_size == (1 << CPU_TLB_DYN_MIN_BITS)) {
             error_report("%s: %s", __func__, strerror(errno));
             abort();
         }
         new_size = MAX(new_size >> 1, 1 << CPU_TLB_DYN_MIN_BITS);
-        env->tlb_mask[mmu_idx] = (new_size - 1) << CPU_TLB_ENTRY_BITS;
+        env_tlb(env)->f[mmu_idx].mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
 
-        g_free(env->tlb_table[mmu_idx]);
-        g_free(env->iotlb[mmu_idx]);
-        env->tlb_table[mmu_idx] = g_try_new(CPUTLBEntry, new_size);
-        env->iotlb[mmu_idx] = g_try_new(CPUIOTLBEntry, new_size);
+        g_free(env_tlb(env)->f[mmu_idx].table);
+        g_free(env_tlb(env)->d[mmu_idx].iotlb);
+        env_tlb(env)->f[mmu_idx].table = g_try_new(CPUTLBEntry, new_size);
+        env_tlb(env)->d[mmu_idx].iotlb = g_try_new(CPUIOTLBEntry, new_size);
     }
 }
 
 static inline void tlb_table_flush_by_mmuidx(CPUArchState *env, int mmu_idx)
 {
     tlb_mmu_resize_locked(env, mmu_idx);
-    memset(env->tlb_table[mmu_idx], -1, sizeof_tlb(env, mmu_idx));
-    env->tlb_d[mmu_idx].n_used_entries = 0;
+    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
+    env_tlb(env)->d[mmu_idx].n_used_entries = 0;
 }
 
 static inline void tlb_n_used_entries_inc(CPUArchState *env, uintptr_t mmu_idx)
 {
-    env->tlb_d[mmu_idx].n_used_entries++;
+    env_tlb(env)->d[mmu_idx].n_used_entries++;
 }
 
 static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
 {
-    env->tlb_d[mmu_idx].n_used_entries--;
+    env_tlb(env)->d[mmu_idx].n_used_entries--;
 }
 
 void tlb_init(CPUState *cpu)
 {
     CPUArchState *env = cpu->env_ptr;
 
-    qemu_spin_init(&env->tlb_c.lock);
+    qemu_spin_init(&env_tlb(env)->c.lock);
 
     /* Ensure that cpu_reset performs a full flush.  */
-    env->tlb_c.dirty = ALL_MMUIDX_BITS;
+    env_tlb(env)->c.dirty = ALL_MMUIDX_BITS;
 
     tlb_dyn_init(env);
 }
@@ -273,9 +274,9 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     CPU_FOREACH(cpu) {
         CPUArchState *env = cpu->env_ptr;
 
-        full += atomic_read(&env->tlb_c.full_flush_count);
-        part += atomic_read(&env->tlb_c.part_flush_count);
-        elide += atomic_read(&env->tlb_c.elide_flush_count);
+        full += atomic_read(&env_tlb(env)->c.full_flush_count);
+        part += atomic_read(&env_tlb(env)->c.part_flush_count);
+        elide += atomic_read(&env_tlb(env)->c.elide_flush_count);
     }
     *pfull = full;
     *ppart = part;
@@ -285,10 +286,11 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
 static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
 {
     tlb_table_flush_by_mmuidx(env, mmu_idx);
-    memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
-    env->tlb_d[mmu_idx].large_page_addr = -1;
-    env->tlb_d[mmu_idx].large_page_mask = -1;
-    env->tlb_d[mmu_idx].vindex = 0;
+    env_tlb(env)->d[mmu_idx].large_page_addr = -1;
+    env_tlb(env)->d[mmu_idx].large_page_mask = -1;
+    env_tlb(env)->d[mmu_idx].vindex = 0;
+    memset(env_tlb(env)->d[mmu_idx].vtable, -1,
+           sizeof(env_tlb(env)->d[0].vtable));
 }
 
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
@@ -301,31 +303,31 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
     tlb_debug("mmu_idx:0x%04" PRIx16 "\n", asked);
 
-    qemu_spin_lock(&env->tlb_c.lock);
+    qemu_spin_lock(&env_tlb(env)->c.lock);
 
-    all_dirty = env->tlb_c.dirty;
+    all_dirty = env_tlb(env)->c.dirty;
     to_clean = asked & all_dirty;
     all_dirty &= ~to_clean;
-    env->tlb_c.dirty = all_dirty;
+    env_tlb(env)->c.dirty = all_dirty;
 
     for (work = to_clean; work != 0; work &= work - 1) {
         int mmu_idx = ctz32(work);
         tlb_flush_one_mmuidx_locked(env, mmu_idx);
     }
 
-    qemu_spin_unlock(&env->tlb_c.lock);
+    qemu_spin_unlock(&env_tlb(env)->c.lock);
 
     cpu_tb_jmp_cache_clear(cpu);
 
     if (to_clean == ALL_MMUIDX_BITS) {
-        atomic_set(&env->tlb_c.full_flush_count,
-                   env->tlb_c.full_flush_count + 1);
+        atomic_set(&env_tlb(env)->c.full_flush_count,
+                   env_tlb(env)->c.full_flush_count + 1);
     } else {
-        atomic_set(&env->tlb_c.part_flush_count,
-                   env->tlb_c.part_flush_count + ctpop16(to_clean));
+        atomic_set(&env_tlb(env)->c.part_flush_count,
+                   env_tlb(env)->c.part_flush_count + ctpop16(to_clean));
         if (to_clean != asked) {
-            atomic_set(&env->tlb_c.elide_flush_count,
-                       env->tlb_c.elide_flush_count +
+            atomic_set(&env_tlb(env)->c.elide_flush_count,
+                       env_tlb(env)->c.elide_flush_count +
                        ctpop16(asked & ~to_clean));
         }
     }
@@ -410,11 +412,12 @@ static inline bool tlb_flush_entry_locked(CPUTLBEntry *tlb_entry,
 static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
                                               target_ulong page)
 {
+    CPUTLBDesc *d = &env_tlb(env)->d[mmu_idx];
     int k;
 
     assert_cpu_is_self(ENV_GET_CPU(env));
     for (k = 0; k < CPU_VTLB_SIZE; k++) {
-        if (tlb_flush_entry_locked(&env->tlb_v_table[mmu_idx][k], page)) {
+        if (tlb_flush_entry_locked(&d->vtable[k], page)) {
             tlb_n_used_entries_dec(env, mmu_idx);
         }
     }
@@ -423,8 +426,8 @@ static inline void tlb_flush_vtlb_page_locked(CPUArchState *env, int mmu_idx,
 static void tlb_flush_page_locked(CPUArchState *env, int midx,
                                   target_ulong page)
 {
-    target_ulong lp_addr = env->tlb_d[midx].large_page_addr;
-    target_ulong lp_mask = env->tlb_d[midx].large_page_mask;
+    target_ulong lp_addr = env_tlb(env)->d[midx].large_page_addr;
+    target_ulong lp_mask = env_tlb(env)->d[midx].large_page_mask;
 
     /* Check if we need to flush due to large pages.  */
     if ((page & lp_mask) == lp_addr) {
@@ -459,13 +462,13 @@ static void tlb_flush_page_by_mmuidx_async_work(CPUState *cpu,
     tlb_debug("page addr:" TARGET_FMT_lx " mmu_map:0x%lx\n",
               addr, mmu_idx_bitmap);
 
-    qemu_spin_lock(&env->tlb_c.lock);
+    qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         if (test_bit(mmu_idx, &mmu_idx_bitmap)) {
             tlb_flush_page_locked(env, mmu_idx, addr);
         }
     }
-    qemu_spin_unlock(&env->tlb_c.lock);
+    qemu_spin_unlock(&env_tlb(env)->c.lock);
 
     tb_flush_jmp_cache(cpu, addr);
 }
@@ -609,22 +612,22 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
     int mmu_idx;
 
     env = cpu->env_ptr;
-    qemu_spin_lock(&env->tlb_c.lock);
+    qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
         unsigned int n = tlb_n_entries(env, mmu_idx);
 
         for (i = 0; i < n; i++) {
-            tlb_reset_dirty_range_locked(&env->tlb_table[mmu_idx][i], start1,
-                                         length);
+            tlb_reset_dirty_range_locked(&env_tlb(env)->f[mmu_idx].table[i],
+                                         start1, length);
         }
 
         for (i = 0; i < CPU_VTLB_SIZE; i++) {
-            tlb_reset_dirty_range_locked(&env->tlb_v_table[mmu_idx][i], start1,
-                                         length);
+            tlb_reset_dirty_range_locked(&env_tlb(env)->d[mmu_idx].vtable[i],
+                                         start1, length);
         }
     }
-    qemu_spin_unlock(&env->tlb_c.lock);
+    qemu_spin_unlock(&env_tlb(env)->c.lock);
 }
 
 /* Called with tlb_c.lock held */
@@ -646,7 +649,7 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
     assert_cpu_is_self(cpu);
 
     vaddr &= TARGET_PAGE_MASK;
-    qemu_spin_lock(&env->tlb_c.lock);
+    qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         tlb_set_dirty1_locked(tlb_entry(env, mmu_idx, vaddr), vaddr);
     }
@@ -654,10 +657,10 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         int k;
         for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_set_dirty1_locked(&env->tlb_v_table[mmu_idx][k], vaddr);
+            tlb_set_dirty1_locked(&env_tlb(env)->d[mmu_idx].vtable[k], vaddr);
         }
     }
-    qemu_spin_unlock(&env->tlb_c.lock);
+    qemu_spin_unlock(&env_tlb(env)->c.lock);
 }
 
 /* Our TLB does not support large pages, so remember the area covered by
@@ -665,7 +668,7 @@ void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
                                target_ulong vaddr, target_ulong size)
 {
-    target_ulong lp_addr = env->tlb_d[mmu_idx].large_page_addr;
+    target_ulong lp_addr = env_tlb(env)->d[mmu_idx].large_page_addr;
     target_ulong lp_mask = ~(size - 1);
 
     if (lp_addr == (target_ulong)-1) {
@@ -675,13 +678,13 @@ static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
         /* Extend the existing region to include the new page.
            This is a compromise between unnecessary flushes and
            the cost of maintaining a full variable size TLB.  */
-        lp_mask &= env->tlb_d[mmu_idx].large_page_mask;
+        lp_mask &= env_tlb(env)->d[mmu_idx].large_page_mask;
         while (((lp_addr ^ vaddr) & lp_mask) != 0) {
             lp_mask <<= 1;
         }
     }
-    env->tlb_d[mmu_idx].large_page_addr = lp_addr & lp_mask;
-    env->tlb_d[mmu_idx].large_page_mask = lp_mask;
+    env_tlb(env)->d[mmu_idx].large_page_addr = lp_addr & lp_mask;
+    env_tlb(env)->d[mmu_idx].large_page_mask = lp_mask;
 }
 
 /* Add a new TLB entry. At most one entry for a given virtual address
@@ -696,6 +699,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
                              int mmu_idx, target_ulong size)
 {
     CPUArchState *env = cpu->env_ptr;
+    CPUTLB *tlb = env_tlb(env);
+    CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
     unsigned int index;
     target_ulong address;
@@ -757,10 +762,10 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      * a longer critical section, but this is not a concern since the TLB lock
      * is unlikely to be contended.
      */
-    qemu_spin_lock(&env->tlb_c.lock);
+    qemu_spin_lock(&tlb->c.lock);
 
     /* Note that the tlb is no longer clean.  */
-    env->tlb_c.dirty |= 1 << mmu_idx;
+    tlb->c.dirty |= 1 << mmu_idx;
 
     /* Make sure there's no cached translation for the new page.  */
     tlb_flush_vtlb_page_locked(env, mmu_idx, vaddr_page);
@@ -770,12 +775,12 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      * different page; otherwise just overwrite the stale data.
      */
     if (!tlb_hit_page_anyprot(te, vaddr_page) && !tlb_entry_is_empty(te)) {
-        unsigned vidx = env->tlb_d[mmu_idx].vindex++ % CPU_VTLB_SIZE;
-        CPUTLBEntry *tv = &env->tlb_v_table[mmu_idx][vidx];
+        unsigned vidx = desc->vindex++ % CPU_VTLB_SIZE;
+        CPUTLBEntry *tv = &desc->vtable[vidx];
 
         /* Evict the old entry into the victim tlb.  */
         copy_tlb_helper_locked(tv, te);
-        env->iotlb_v[mmu_idx][vidx] = env->iotlb[mmu_idx][index];
+        desc->viotlb[vidx] = desc->iotlb[index];
         tlb_n_used_entries_dec(env, mmu_idx);
     }
 
@@ -792,8 +797,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
      * subtract here is that of the page base, and not the same as the
      * vaddr we add back in io_readx()/io_writex()/get_page_addr_code().
      */
-    env->iotlb[mmu_idx][index].addr = iotlb - vaddr_page;
-    env->iotlb[mmu_idx][index].attrs = attrs;
+    desc->iotlb[index].addr = iotlb - vaddr_page;
+    desc->iotlb[index].attrs = attrs;
 
     /* Now calculate the new entry */
     tn.addend = addend - vaddr_page;
@@ -829,7 +834,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
 
     copy_tlb_helper_locked(te, &tn);
     tlb_n_used_entries_inc(env, mmu_idx);
-    qemu_spin_unlock(&env->tlb_c.lock);
+    qemu_spin_unlock(&tlb->c.lock);
 }
 
 /* Add a new TLB entry, but without specifying the memory
@@ -997,7 +1002,7 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
 
     assert_cpu_is_self(ENV_GET_CPU(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
-        CPUTLBEntry *vtlb = &env->tlb_v_table[mmu_idx][vidx];
+        CPUTLBEntry *vtlb = &env_tlb(env)->d[mmu_idx].vtable[vidx];
         target_ulong cmp;
 
         /* elt_ofs might correspond to .addr_write, so use atomic_read */
@@ -1009,16 +1014,16 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
-            CPUTLBEntry tmptlb, *tlb = &env->tlb_table[mmu_idx][index];
+            CPUTLBEntry tmptlb, *tlb = &env_tlb(env)->f[mmu_idx].table[index];
 
-            qemu_spin_lock(&env->tlb_c.lock);
+            qemu_spin_lock(&env_tlb(env)->c.lock);
             copy_tlb_helper_locked(&tmptlb, tlb);
             copy_tlb_helper_locked(tlb, vtlb);
             copy_tlb_helper_locked(vtlb, &tmptlb);
-            qemu_spin_unlock(&env->tlb_c.lock);
+            qemu_spin_unlock(&env_tlb(env)->c.lock);
 
-            CPUIOTLBEntry tmpio, *io = &env->iotlb[mmu_idx][index];
-            CPUIOTLBEntry *vio = &env->iotlb_v[mmu_idx][vidx];
+            CPUIOTLBEntry tmpio, *io = &env_tlb(env)->d[mmu_idx].iotlb[index];
+            CPUIOTLBEntry *vio = &env_tlb(env)->d[mmu_idx].viotlb[vidx];
             tmpio = *io; *io = *vio; *vio = tmpio;
             return true;
         }
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9dcc5ff3a3..d0fefa798e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14163,7 +14163,7 @@ static bool is_guarded_page(CPUARMState *env, DisasContext *s)
      * table entry even for that case.
      */
     return (tlb_hit(entry->addr_code, addr) &&
-            env->iotlb[mmu_idx][index].attrs.target_tlb_bit0);
+            env_tlb(env)->d[mmu_idx].iotlb[index].attrs.target_tlb_bit0);
 #endif
 }
 
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index eefa929948..72cf4c5ff8 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1455,12 +1455,8 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
     label->label_ptr[0] = label_ptr;
 }
 
-/* We expect tlb_mask to be before tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
-                  offsetof(CPUArchState, tlb_mask));
-
 /* We expect to use a 24-bit unsigned offset from ENV.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1])
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_.f[NB_MMU_MODES - 1].table)
                   > 0xffffff);
 
 /* Load and compare a TLB entry, emitting the conditional jump to the
@@ -1471,8 +1467,8 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
                              tcg_insn_unit **label_ptr, int mem_index,
                              bool is_read)
 {
-    int mask_ofs = offsetof(CPUArchState, tlb_mask[mem_index]);
-    int table_ofs = offsetof(CPUArchState, tlb_table[mem_index]);
+    int mask_ofs = offsetof(CPUArchState, tlb_.f[mem_index].mask);
+    int table_ofs = offsetof(CPUArchState, tlb_.f[mem_index].table);
     unsigned a_bits = get_alignment_bits(opc);
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_mask = (1u << a_bits) - 1;
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index abf0c444b4..28b911e550 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1220,12 +1220,8 @@ static TCGReg tcg_out_arg_reg64(TCGContext *s, TCGReg argreg,
 
 #define TLB_SHIFT	(CPU_TLB_ENTRY_BITS + CPU_TLB_BITS)
 
-/* We expect tlb_mask to be before tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
-                  offsetof(CPUArchState, tlb_mask));
-
 /* We expect to use a 20-bit unsigned offset from ENV.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1])
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_.f[NB_MMU_MODES - 1].table)
                   > 0xfffff);
 
 /* Load and compare a TLB entry, leaving the flags set.  Returns the register
@@ -1236,8 +1232,8 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
 {
     int cmp_off = (is_load ? offsetof(CPUTLBEntry, addr_read)
                    : offsetof(CPUTLBEntry, addr_write));
-    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
-    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
+    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
     TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index d5ed9f1ffd..b2e11a4b7c 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1655,10 +1655,10 @@ static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
                    TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
 
     tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, r0, TCG_AREG0,
-                         offsetof(CPUArchState, tlb_mask[mem_index]));
+                         offsetof(CPUArchState, tlb_.f[mem_index].mask));
 
     tcg_out_modrm_offset(s, OPC_ADD_GvEv + hrexw, r0, TCG_AREG0,
-                         offsetof(CPUArchState, tlb_table[mem_index]));
+                         offsetof(CPUArchState, tlb_.f[mem_index].table));
 
     /* If the required alignment is at least as large as the access, simply
        copy the address and mask.  For lesser alignments, check that we don't
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 412cacdcb9..45b26e596f 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1201,14 +1201,6 @@ static int tcg_out_call_iarg_reg2(TCGContext *s, int i, TCGReg al, TCGReg ah)
     return i;
 }
 
-/* We expect tlb_mask to be before tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
-                  offsetof(CPUArchState, tlb_mask));
-
-/* We expect tlb_mask to be "near" tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) -
-                  offsetof(CPUArchState, tlb_mask) >= 0x8000);
-
 /*
  * Perform the tlb comparison operation.
  * The complete host address is placed in BASE.
@@ -1222,8 +1214,8 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg base, TCGReg addrl,
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
     int mem_index = get_mmuidx(oi);
-    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
-    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
+    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
     int add_off = offsetof(CPUTLBEntry, addend);
     int cmp_off = (is_load ? offsetof(CPUTLBEntry, addr_read)
                    : offsetof(CPUTLBEntry, addr_write));
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 36b4791707..a248603bc5 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1497,10 +1497,6 @@ static void * const qemu_st_helpers[16] = {
     [MO_BEQ]  = helper_be_stq_mmu,
 };
 
-/* We expect tlb_mask to be before tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
-                  offsetof(CPUArchState, tlb_mask));
-
 /* Perform the TLB load and compare.  Places the result of the comparison
    in CR7, loads the addend of the TLB into R3, and returns the register
    containing the guest address (zero-extended into R4).  Clobbers R0 and R2. */
@@ -1513,8 +1509,8 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
         = (is_read
            ? offsetof(CPUTLBEntry, addr_read)
            : offsetof(CPUTLBEntry, addr_write));
-    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
-    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
+    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
     TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
     unsigned s_bits = opc & MO_SIZE;
     unsigned a_bits = get_alignment_bits(opc);
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 2932505094..85acbb9514 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -961,14 +961,6 @@ static void * const qemu_st_helpers[16] = {
 /* We don't support oversize guests */
 QEMU_BUILD_BUG_ON(TCG_TARGET_REG_BITS < TARGET_LONG_BITS);
 
-/* We expect tlb_mask to be before tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
-                  offsetof(CPUArchState, tlb_mask));
-
-/* We expect tlb_mask to be "near" tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) -
-                  offsetof(CPUArchState, tlb_mask) >= 0x800);
-
 static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit **label_ptr, bool is_load)
@@ -981,8 +973,8 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
     int mask_off, table_off;
     TCGReg mask_base = TCG_AREG0, table_base = TCG_AREG0;
 
-    mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
-    table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
+    table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
     if (table_off > 0x7ff) {
         int mask_hi = mask_off - sextreg(mask_off, 0, 12);
         int table_hi = table_off - sextreg(table_off, 0, 12);
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 3d6150b10e..1f578ea980 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1538,9 +1538,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc, TCGReg data,
 #include "tcg-ldst.inc.c"
 
 /* We're expecting to use a 20-bit signed offset on the tlb memory ops.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_mask[NB_MMU_MODES - 1])
-                  > 0x7ffff);
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table[NB_MMU_MODES - 1])
+QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_.f[NB_MMU_MODES - 1].table)
                   > 0x7ffff);
 
 /* Load and compare a TLB entry, leaving the flags set.  Loads the TLB
@@ -1552,8 +1550,8 @@ static TCGReg tcg_out_tlb_read(TCGContext* s, TCGReg addr_reg, TCGMemOp opc,
     unsigned a_bits = get_alignment_bits(opc);
     unsigned s_mask = (1 << s_bits) - 1;
     unsigned a_mask = (1 << a_bits) - 1;
-    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
-    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
+    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
     int ofs, a_off;
     uint64_t tlb_mask;
 
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 7a61839dc1..be10124e11 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1074,19 +1074,11 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
    The result of the TLB comparison is in %[ix]cc.  The sanitized address
    is in the returned register, maybe %o0.  The TLB addend is in %o1.  */
 
-/* We expect tlb_mask to be before tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) <
-                  offsetof(CPUArchState, tlb_mask));
-
-/* We expect tlb_mask to be "near" tlb_table.  */
-QEMU_BUILD_BUG_ON(offsetof(CPUArchState, tlb_table) -
-                  offsetof(CPUArchState, tlb_mask) >= (1 << 13));
-
 static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addr, int mem_index,
                                TCGMemOp opc, int which)
 {
-    int mask_off = offsetof(CPUArchState, tlb_mask[mem_index]);
-    int table_off = offsetof(CPUArchState, tlb_table[mem_index]);
+    int mask_off = offsetof(CPUArchState, tlb_.f[mem_index].mask);
+    int table_off = offsetof(CPUArchState, tlb_.f[mem_index].table);
     TCGReg base = TCG_AREG0;
     const TCGReg r0 = TCG_REG_O0;
     const TCGReg r1 = TCG_REG_O1;
-- 
2.17.1


