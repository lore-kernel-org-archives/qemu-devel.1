Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C567C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA699208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jX82uMqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA699208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48777 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcN6-0003AS-4R
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:17:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9K-0006IX-1R
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9E-0007F2-KR
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:21 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc9E-0007EZ-Cg
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:16 -0400
Received: by mail-pf1-x444.google.com with SMTP id y11so702824pfm.13
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=H2QT/JgMiYgSHVXC+HP+NSmIDhr8i4LWMx/ucpMQgvg=;
	b=jX82uMqx0G7AB+n5uSgRtY6LmAA+jKlcyL9Jh7PbrUMJI4zk0Z9A26jd8qa3MZW+kC
	tX73eZXpx/pF8fCY7FS511pMpfxrB6jOb3VD6srFGuhbqEml8sOfjHN2AtnMWBay2I/W
	XU6Y34Srt1AOZXlif2H3rfK1KMB/93Z4Znzb41uQdJ6dl5aKnWVNJKvAwJ+gKRDtkopl
	jvu8i5pWrru6TRaVcqX3maSd4fhh8YOjgopXPzdIHa8RkaEJCznx3Jv5d7epVeozHeWh
	HBYUk/ZmVW0ks6r5JqsGwWGi9wDSKrdRkJjwY1CqGXmUmP6lMHaj4e6770Bq3ZZxwwl/
	Zq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=H2QT/JgMiYgSHVXC+HP+NSmIDhr8i4LWMx/ucpMQgvg=;
	b=Iu7m+uSgezl024qltfN1sNEe36MmhILSGNE+aTrcyyZwJZ0KL/i9Z96tkOrWSkCCux
	6wCOJOCMafvYRdgOHKd4p28yZsIk3f0fX6VkN5xRrbw2OBeLzdv3WiGAOh8jHCGsdefK
	YMNlXEtSNmqbc3z0ftnG9Gxe+NK/2O0KtlcqRJCQPq3NP5nY8stNspeyuGz0pd5Yjlbr
	AC27s+7+x8H2btJ4w6/moVWFbDJIQQz461ej2/N5l8I7eC/vUFK3E0xwKisgHHDjCp+r
	QXM+nFKwByt/PGx0EbV91iJgs5HmrYU7AaX4SOWDF6ppxN+nPB5r5aquC3OtbjGocu5v
	hTrg==
X-Gm-Message-State: APjAAAUugFhWZTf5HkiIMgHQdbUQSaW3P2JJ6TIFXDcExHMMrBcCW2id
	k5n4erurDowR2V3ZtP2KRZPiIVN5Fx0=
X-Google-Smtp-Source: APXvYqycRFVA1JH/UohKR1luUWpNnlLQUhigdxcHdqpKstfkHds0Nib9b3ZmELJUL+ry4ira2cGfpw==
X-Received: by 2002:a63:2a89:: with SMTP id q131mr3044519pgq.359.1557381795167;
	Wed, 08 May 2019 23:03:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:39 -0700
Message-Id: <20190509060246.4031-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 20/27] target/sparc: Convert to
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Keep user-only, sparc32, and sparc64 tlb_fill separate.
---
 target/sparc/cpu.h         |  5 ++-
 target/sparc/cpu.c         |  5 +--
 target/sparc/ldst_helper.c | 11 +-----
 target/sparc/mmu_helper.c  | 78 ++++++++++++++++++++++----------------
 4 files changed, 51 insertions(+), 48 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 85b9665ccc..f31e8535df 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -579,8 +579,9 @@ void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t) QEMU_NORETURN;
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
 void sparc_cpu_list(void);
 /* mmu_helper.c */
-int sparc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                               int mmu_idx);
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
 void dump_mmu(CPUSPARCState *env);
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4654c2a6a0..f93ce72eb9 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -875,9 +875,8 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = sparc_cpu_synchronize_from_tb;
     cc->gdb_read_register = sparc_cpu_gdb_read_register;
     cc->gdb_write_register = sparc_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = sparc_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = sparc_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unassigned_access = sparc_cpu_unassigned_access;
     cc->do_unaligned_access = sparc_cpu_do_unaligned_access;
     cc->get_phys_page_debug = sparc_cpu_get_phys_page_debug;
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index a7fcb84ac0..2558c08a64 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1925,18 +1925,9 @@ void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     cpu_raise_exception_ra(env, TT_UNALIGNED, retaddr);
 }
 
-/* try to fill the TLB and return an exception if error. If retaddr is
-   NULL, it means that the function was called in C code (i.e. not
-   from generated code or from helper.c) */
-/* XXX: fix it to restore all registers */
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    int ret;
-
-    ret = sparc_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret) {
-        cpu_loop_exit_restore(cs, retaddr);
-    }
+    sparc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 #endif
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index afcc5b617d..7f811ea031 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -27,13 +27,14 @@
 
 #if defined(CONFIG_USER_ONLY)
 
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
-    if (rw & 2) {
+    if (access_type == MMU_INST_FETCH) {
         cs->exception_index = TT_TFAULT;
     } else {
         cs->exception_index = TT_DFAULT;
@@ -43,7 +44,7 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
         env->mmuregs[4] = address;
 #endif
     }
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else
@@ -208,8 +209,9 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
 }
 
 /* Perform address translation */
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
@@ -220,22 +222,18 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
     address &= TARGET_PAGE_MASK;
     error_code = get_physical_address(env, &paddr, &prot, &access_index,
-                                      address, rw, mmu_idx, &page_size);
+                                      address, access_type,
+                                      mmu_idx, &page_size);
     vaddr = address;
-    if (error_code == 0) {
+    if (likely(error_code == 0)) {
         qemu_log_mask(CPU_LOG_MMU,
-                "Translate at %" VADDR_PRIx " -> " TARGET_FMT_plx ", vaddr "
-                TARGET_FMT_lx "\n", address, paddr, vaddr);
+                      "Translate at %" VADDR_PRIx " -> "
+                      TARGET_FMT_plx ", vaddr " TARGET_FMT_lx "\n",
+                      address, paddr, vaddr);
         tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
-        return 0;
+        return true;
     }
 
-    if (env->mmuregs[3]) { /* Fault status register */
-        env->mmuregs[3] = 1; /* overflow (not read before another fault) */
-    }
-    env->mmuregs[3] |= (access_index << 5) | error_code | 2;
-    env->mmuregs[4] = address; /* Fault address register */
-
     if ((env->mmuregs[0] & MMU_NF) || env->psret == 0)  {
         /* No fault mode: if a mapping is available, just override
            permissions. If no mapping is available, redirect accesses to
@@ -243,15 +241,25 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
            switching to normal mode. */
         prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, TARGET_PAGE_SIZE);
-        return 0;
-    } else {
-        if (rw & 2) {
-            cs->exception_index = TT_TFAULT;
-        } else {
-            cs->exception_index = TT_DFAULT;
-        }
-        return 1;
+        return true;
     }
+
+    if (probe) {
+        return false;
+    }
+
+    if (env->mmuregs[3]) { /* Fault status register */
+        env->mmuregs[3] = 1; /* overflow (not read before another fault) */
+    }
+    env->mmuregs[3] |= (access_index << 5) | error_code | 2;
+    env->mmuregs[4] = address; /* Fault address register */
+
+    if (access_type == MMU_INST_FETCH) {
+        cs->exception_index = TT_TFAULT;
+    } else {
+        cs->exception_index = TT_DFAULT;
+    }
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
@@ -713,20 +721,22 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
 }
 
 /* Perform address translation */
-int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                               int mmu_idx)
+bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
-    target_ulong vaddr;
     hwaddr paddr;
+    target_ulong vaddr;
     target_ulong page_size;
     int error_code = 0, prot, access_index;
 
     address &= TARGET_PAGE_MASK;
     error_code = get_physical_address(env, &paddr, &prot, &access_index,
-                                      address, rw, mmu_idx, &page_size);
-    if (error_code == 0) {
+                                      address, access_type,
+                                      mmu_idx, &page_size);
+    if (likely(error_code == 0)) {
         vaddr = address;
 
         trace_mmu_helper_mmu_fault(address, paddr, mmu_idx, env->tl,
@@ -734,10 +744,12 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
                                    env->dmmu.mmu_secondary_context);
 
         tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
-        return 0;
+        return true;
     }
-    /* XXX */
-    return 1;
+    if (probe) {
+        return false;
+    }
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 void dump_mmu(CPUSPARCState *env)
-- 
2.17.1


