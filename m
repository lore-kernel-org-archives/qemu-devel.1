Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF805C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A70020578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkX0aFuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A70020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7Rm-00076Q-KW
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:28:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jk-0007hf-5M
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Ji-0000A9-M6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:12 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Ji-00008M-F6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:10 -0400
Received: by mail-pl1-x642.google.com with SMTP id a59so2995958pla.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Cwj55cO5HKZwNrpsoxflAQ5QTjmy2fkdQhNi3dY/lrE=;
	b=IkX0aFuOezqfkj6/cXESKv7W+IlP/alcDnzHuyooEHs8+vqUazjbSMtog/yjrP0PRN
	ut3wihWmDTCwTniClOccEi1d5k6slIV7ZCBO7jypfOS3VyO4L5Vn0Rcm/xYUIgjPf2So
	Y2cijEicUK3Js8DCqsqtLSWdt7oMcFbC6pM/3r81I/CHGEgcXFYQZTgQaMyKYvSmIgb4
	UdurhOXBBsa1wa8hUAw35YX4gM9JgHnmd2WKCCgY9Ip0XWhufDf4HnV5O6/P/cW5BhR1
	lK+6fKAYZV4dx+63uPuvJQ6zE74TTxtSQ1Ai/ZyJiVZv8WlNgDiRbwKw8z3ENqrMxCJV
	3gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Cwj55cO5HKZwNrpsoxflAQ5QTjmy2fkdQhNi3dY/lrE=;
	b=jDbHzmGMKDCp+N+R5zhQ9uu/PzaDj5e6iwbcrl2YZ7pL+8LWVv8ctxjBMpnZtpgJ/O
	xHde+cOdEQ19DRPpsExjPJm4Orvx3zxd0tFQvn+VWX3mx1SLdSPejzPQOWbl1gZ0xGpz
	yxRLrjcbH6p7SyKM2uzzurf/s7Y8wt6WmvWUxKJf8N34dhdX+2FPxciPKbLD/LRN+Omw
	0wfACzW9Wjkv8WkHDJGsHOWS2s9TlXj9h2Z691hfLQHil3ibUOUSzvfJnBUDZ8n8mnPg
	eyMRcgxufmsVV0KNPGZOT8Pa6BgVSoziPnlyyMyv+ybHQ4bjpb2dXewr9/17AWQTfPXq
	zpSQ==
X-Gm-Message-State: APjAAAU+1ppLfxOXWh1QErtK3KawQabZE8uKf9NEBm58xNqEP2cM/tJ2
	cTBRUXgakx6GWX9L6ONLCIRTqm7NdHg=
X-Google-Smtp-Source: APXvYqyTUO4S4GkXSvjhNCYLJ9vh0t79LFv4D0YK6hNK7VwrbjrELeQdJH+rr9ciBIEiioif6QtJpA==
X-Received: by 2002:a17:902:2907:: with SMTP id
	g7mr13723060plb.238.1557501609204; 
	Fri, 10 May 2019 08:20:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:35 -0700
Message-Id: <20190510151944.22981-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PULL 18/27] target/s390x: Convert to
 CPUClass::tlb_fill
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
Cc: peter.maydell@linaro.org, qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |  5 +--
 target/s390x/cpu.c         |  5 ++-
 target/s390x/excp_helper.c | 73 ++++++++++++++++++++++++++------------
 target/s390x/mem_helper.c  | 16 ---------
 4 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 26575f2130..56534b38e0 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -263,8 +263,9 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
 void s390x_cpu_debug_excp_handler(CPUState *cs);
 void s390_cpu_do_interrupt(CPUState *cpu);
 bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
-int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type,
                                    int mmu_idx, uintptr_t retaddr);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index b58ef0a8ef..e28939032b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -478,9 +478,8 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = s390_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = s390_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = s390_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_s390_cpu;
     cc->write_elf64_note = s390_cpu_write_elf64_note;
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f84bfb1284..a4e134bcab 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -74,8 +74,9 @@ void s390_cpu_do_interrupt(CPUState *cs)
     cs->exception_index = -1;
 }
 
-int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                              int rw, int mmu_idx)
+bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     S390CPU *cpu = S390_CPU(cs);
 
@@ -83,7 +84,7 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
     /* On real machines this value is dropped into LowMem.  Since this
        is userland, simply put this someplace that cpu_loop can find it.  */
     cpu->env.__excp_addr = address;
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else /* !CONFIG_USER_ONLY */
@@ -102,19 +103,20 @@ static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
     }
 }
 
-int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
-                              int rw, int mmu_idx)
+bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
     target_ulong vaddr, raddr;
     uint64_t asc;
-    int prot;
+    int prot, fail;
 
     qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
-                  __func__, orig_vaddr, rw, mmu_idx);
+                  __func__, address, access_type, mmu_idx);
 
-    vaddr = orig_vaddr;
+    vaddr = address;
 
     if (mmu_idx < MMU_REAL_IDX) {
         asc = cpu_mmu_idx_to_asc(mmu_idx);
@@ -122,39 +124,64 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
-        if (mmu_translate(env, vaddr, rw, asc, &raddr, &prot, true)) {
-            return 1;
-        }
+        fail = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, true);
     } else if (mmu_idx == MMU_REAL_IDX) {
         /* 31-Bit mode */
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
-        if (mmu_translate_real(env, vaddr, rw, &raddr, &prot)) {
-            return 1;
-        }
+        fail = mmu_translate_real(env, vaddr, access_type, &raddr, &prot);
     } else {
-        abort();
+        g_assert_not_reached();
     }
 
     /* check out of RAM access */
-    if (!address_space_access_valid(&address_space_memory, raddr,
-                                    TARGET_PAGE_SIZE, rw,
+    if (!fail &&
+        !address_space_access_valid(&address_space_memory, raddr,
+                                    TARGET_PAGE_SIZE, access_type,
                                     MEMTXATTRS_UNSPECIFIED)) {
         qemu_log_mask(CPU_LOG_MMU,
                       "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
                       __func__, (uint64_t)raddr, (uint64_t)ram_size);
         trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
-        return 1;
+        fail = 1;
     }
 
-    qemu_log_mask(CPU_LOG_MMU, "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
-            __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
+    if (!fail) {
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: set tlb %" PRIx64 " -> %" PRIx64 " (%x)\n",
+                      __func__, (uint64_t)vaddr, (uint64_t)raddr, prot);
+        tlb_set_page(cs, address & TARGET_PAGE_MASK, raddr, prot,
+                     mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+    if (probe) {
+        return false;
+    }
 
-    tlb_set_page(cs, orig_vaddr & TARGET_PAGE_MASK, raddr, prot,
-                 mmu_idx, TARGET_PAGE_SIZE);
+    cpu_restore_state(cs, retaddr, true);
 
-    return 0;
+    /*
+     * The ILC value for code accesses is undefined.  The important
+     * thing here is to *not* leave env->int_pgm_ilen set to ILEN_AUTO,
+     * which would cause do_program_interrupt to attempt to read from
+     * env->psw.addr again.  C.f. the condition in trigger_page_fault,
+     * but is not universally applied.
+     *
+     * ??? If we remove ILEN_AUTO, by moving the computation of ILEN
+     * into cpu_restore_state, then we may remove this entirely.
+     */
+    if (access_type == MMU_INST_FETCH) {
+        env->int_pgm_ilen = 2;
+    }
+
+    cpu_loop_exit(cs);
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    s390_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 static void do_program_interrupt(CPUS390XState *env)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3f76a8abfd..ffd5f02fbe 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -33,22 +33,6 @@
 
 /*****************************************************************************/
 /* Softmmu support */
-#if !defined(CONFIG_USER_ONLY)
-
-/* try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-/* XXX: fix it to restore all registers */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret = s390_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret != 0)) {
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-
-#endif
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
-- 
2.17.1


