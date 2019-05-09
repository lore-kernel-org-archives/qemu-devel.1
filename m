Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC768C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE3C21744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtW+NYND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE3C21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33587 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrfh-0000oO-Qh
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:37:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUx-0007aB-Bu
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrUw-0005Qr-1c
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:43 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrUv-0005P2-RY
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:41 -0400
Received: by mail-pg1-x544.google.com with SMTP id w22so1921338pgi.6
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=w7l/Pbs/dkuyE6y60mYyZzngNGSZYjs+O6jEPehbb2U=;
	b=TtW+NYNDOszgF0iWYwepmGwixWdz2R6GPuo/Te+ipyW7AK4r89WXiwtAc2KhtLrZip
	GTK1dCsyCdQouNJSChFf+8eYhk6o3NSxm+oR7saVWTUzAejQO+sSIrRfoJJYKQEwDOn4
	qN0Fkp6dYvuUUMez+S8MT4EGDbYBT/nBFV62IIbA06UvVbNFQ3MJQQ7n3Z1rW9CAmGbT
	5fX22i/wtDuSl0jJSnMD8az7oKpslmFQExc4n1cf9R2dduW2+N79qoZl7bTs3MbEeYPw
	6TeChUd8As8VZyIS2jyfLO3IxOMoR2UImr0r3lEmXMU8OSO/v2gpL8oGK3fMn8nJ47IA
	FKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=w7l/Pbs/dkuyE6y60mYyZzngNGSZYjs+O6jEPehbb2U=;
	b=rCj+jnxloqnpyfrWWeBuN+B6/K43krilAr5Ai1LZVXGFU0IR+K/9F45sp62vvHE8wS
	JLOzFshRH9tDyQBIFBAbb8o+fzc6OnqZL7540gzxymfe8xqSdCI1g/ZFuSWUWUJD+/ri
	Ws2o5a82P4dC5hkBI5Q6jrx10Ne/Q0Qi6sWdnmFlI1kkLGBoCEXTB7ISeYyJ1Enn87UH
	xsN+1kuPscTckBoumRbqyCagFMZb731Sj4tWnxhy1RMPcwBBcLYeTAZjt/eCImmZTztw
	DERuKk1z/Mf7c3bKqX1etpxk+TmL07cF80wOY45G3/RmSFAVwGx04CVRcnSyWwbA5tvb
	ZrAg==
X-Gm-Message-State: APjAAAVmGtUwqcYZ5AdMWGMoLxERTjP7krZCO/tkueusK7MdUQaLeNgu
	01NjpYz2bwhyH2obAluGQHk0ZB60fh4=
X-Google-Smtp-Source: APXvYqyhhjn6Q5MO1NyJyKIPhkIM0CItcGpI8IDy6bO2GvgroKMBOlb9DjoIqn/C45JEjsnOjFbNSA==
X-Received: by 2002:a63:2bc8:: with SMTP id r191mr8957557pgr.72.1557440800397; 
	Thu, 09 May 2019 15:26:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.39
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:09 -0700
Message-Id: <20190509222631.14271-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 05/27] target/hppa: Convert to
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  8 ++++----
 target/hppa/cpu.c        |  5 ++---
 target/hppa/mem_helper.c | 22 +++++++++++++++++-----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 923346adb6..c1e0215e66 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -360,10 +360,10 @@ int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
-#ifdef CONFIG_USER_ONLY
-int hppa_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                              int rw, int midx);
-#else
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
+#ifndef CONFIG_USER_ONLY
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot);
 extern const MemoryRegionOps hppa_io_eir_ops;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index e64f48581e..9717ea1798 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -163,9 +163,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
     cc->gdb_read_register = hppa_cpu_gdb_read_register;
     cc->gdb_write_register = hppa_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = hppa_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = hppa_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_hppa_cpu;
 #endif
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 77fb544838..5cee0c19b1 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -25,8 +25,9 @@
 #include "trace.h"
 
 #ifdef CONFIG_USER_ONLY
-int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
-                              int size, int rw, int mmu_idx)
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
 
@@ -34,7 +35,7 @@ int hppa_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
        which would affect si_code.  */
     cs->exception_index = EXCP_DMP;
     cpu->env.cr[CR_IOR] = address;
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 #else
 static hppa_tlb_entry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
@@ -213,8 +214,9 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return excp == EXCP_DTLB_MISS ? -1 : phys;
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
+bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                       MMUAccessType type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
@@ -236,6 +238,9 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     excp = hppa_get_physical_address(env, addr, mmu_idx,
                                      a_prot, &phys, &prot);
     if (unlikely(excp >= 0)) {
+        if (probe) {
+            return false;
+        }
         trace_hppa_tlb_fill_excp(env, addr, size, type, mmu_idx);
         /* Failure.  Raise the indicated exception.  */
         cs->exception_index = excp;
@@ -252,6 +257,13 @@ void tlb_fill(CPUState *cs, target_ulong addr, int size,
     /* Success!  Store the translation into the QEMU TLB.  */
     tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
                  prot, mmu_idx, TARGET_PAGE_SIZE);
+    return true;
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType type, int mmu_idx, uintptr_t retaddr)
+{
+    hppa_cpu_tlb_fill(cs, addr, size, type, mmu_idx, false, retaddr);
 }
 
 /* Insert (Insn/Data) TLB Address.  Note this is PA 1.1 only.  */
-- 
2.17.1


