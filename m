Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31763C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF50B2173B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/cLIwy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF50B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrZx-0002yF-40
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:31:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV9-0007mg-Fx
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV8-0005WZ-CC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:55 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrV8-0005WP-6G
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:54 -0400
Received: by mail-pl1-x641.google.com with SMTP id d9so1800873pls.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=pyOmNQehrxQ+vJN1rBIdXnxr1kqTHPzFsWgERMP7ALs=;
	b=f/cLIwy2OMjK1HB+Myp61BRRwUEr+BM8LJ3ybmbIFg9F+7iAwj2Fo//gX5ih6O1koc
	0hfwPqMytjRS1T/IVyvLRIR47A26Oqq+Sz2+Ybv/8RkbKMcGPZdK92qi2gqZ6SJRS6P3
	Vv2iTwqtU7TWQRX0FJOBbD+hq75YuI4B0s3/O0SRCXoroUxDzJq33Bv7uOlIl6bMAoDG
	j5m8Ow2AIwOqBurt9Hpnf9KQ2o3mivjqZ244Q2bM2FGkgHEUcOsyqxyPaoKBmYkFpnvy
	aTI5R5GIgWUb81HcivxzHPif+rWKxAGY4AYqtIM7+OM8gVQGlhGUQtI6zZ9agNwms3nx
	T72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=pyOmNQehrxQ+vJN1rBIdXnxr1kqTHPzFsWgERMP7ALs=;
	b=IEdhW0JJ3gVT15J5rmDKXNf+rwEXyFOP1Q16sh4wVmtut2wElKl9e9rf0tulOGPhlK
	iOUXSHLHmRUkD85Dq6KYjGZqSvCzaoVQ47GTvZowT/qmmJkF3bd1pBY23+GwXyWMxDsd
	kmIAG3dDOwwIY88VicylDeuHaB40tVoCHMRg6cYTrUqJLyxFm4yYnW9rc1rwJ2aoUP/t
	4kPELO+j6Vq+8gRKYjtXhZ5VRTdIcjF/1I9lU7Sn2qKP0bPItePQyaXBOuFCu3l3Y4xL
	vokohWiflKHKirwwUqmX0f+4Xb+J3I50cogzx9KMOlADUnswAf31+nI58Y9pRF5mRNbd
	jT4A==
X-Gm-Message-State: APjAAAUiT+M7yWvW3knLAdbEXNFhWy011lq2zy2z0aV+XRCqdiqrF6ic
	WZCRHPgUE452Ym6foEcDLQWRFte/EKM=
X-Google-Smtp-Source: APXvYqyWy5/oNyQltvggk5llVfWmxDVecjdXdqT8LyftywvGUIZiGDH35I4yGteQIp9MBAUS6MZmEA==
X-Received: by 2002:a17:902:102a:: with SMTP id
	b39mr8585437pla.188.1557440812996; 
	Thu, 09 May 2019 15:26:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:19 -0700
Message-Id: <20190509222631.14271-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 15/27] target/openrisc: Convert to
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
Cc: Stafford Horne <shorne@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h |  5 ++--
 target/openrisc/cpu.c |  5 ++--
 target/openrisc/mmu.c | 65 ++++++++++++++++++++++---------------------
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 88a8c70092..9473d94d0c 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -344,8 +344,9 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
-int openrisc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
-                                  int rw, int mmu_idx);
+bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                           MMUAccessType access_type, int mmu_idx,
+                           bool probe, uintptr_t retaddr);
 int cpu_openrisc_signal_handler(int host_signum, void *pinfo, void *puc);
 int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index d125236977..3816baee70 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -149,9 +149,8 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = openrisc_cpu_set_pc;
     cc->gdb_read_register = openrisc_cpu_gdb_read_register;
     cc->gdb_write_register = openrisc_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = openrisc_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = openrisc_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = openrisc_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_openrisc_cpu;
 #endif
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 5dec68dcff..94c65a25fa 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -107,16 +107,42 @@ static void raise_mmu_exception(OpenRISCCPU *cpu, target_ulong address,
     cpu->env.lock_addr = -1;
 }
 
-int openrisc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                                  int rw, int mmu_idx)
+bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                           MMUAccessType access_type, int mmu_idx,
+                           bool probe, uintptr_t retaddr)
 {
-#ifdef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    raise_mmu_exception(cpu, address, EXCP_DPF);
-    return 1;
-#else
-    g_assert_not_reached();
+    int excp = EXCP_DPF;
+
+#ifndef CONFIG_USER_ONLY
+    int prot;
+    hwaddr phys_addr;
+
+    if (mmu_idx == MMU_NOMMU_IDX) {
+        /* The mmu is disabled; lookups never fail.  */
+        get_phys_nommu(&phys_addr, &prot, addr);
+        excp = 0;
+    } else {
+        bool super = mmu_idx == MMU_SUPERVISOR_IDX;
+        int need = (access_type == MMU_INST_FETCH ? PAGE_EXEC
+                    : access_type == MMU_DATA_STORE ? PAGE_WRITE
+                    : PAGE_READ);
+        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
+    }
+
+    if (likely(excp == 0)) {
+        tlb_set_page(cs, addr & TARGET_PAGE_MASK,
+                     phys_addr & TARGET_PAGE_MASK, prot,
+                     mmu_idx, TARGET_PAGE_SIZE);
+        return true;
+    }
+    if (probe) {
+        return false;
+    }
 #endif
+
+    raise_mmu_exception(cpu, addr, excp);
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -156,29 +182,6 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(cs);
-    int prot, excp;
-    hwaddr phys_addr;
-
-    if (mmu_idx == MMU_NOMMU_IDX) {
-        /* The mmu is disabled; lookups never fail.  */
-        get_phys_nommu(&phys_addr, &prot, addr);
-        excp = 0;
-    } else {
-        bool super = mmu_idx == MMU_SUPERVISOR_IDX;
-        int need = (access_type == MMU_INST_FETCH ? PAGE_EXEC
-                    : access_type == MMU_DATA_STORE ? PAGE_WRITE
-                    : PAGE_READ);
-        excp = get_phys_mmu(cpu, &phys_addr, &prot, addr, need, super);
-    }
-
-    if (unlikely(excp)) {
-        raise_mmu_exception(cpu, addr, excp);
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-
-    tlb_set_page(cs, addr & TARGET_PAGE_MASK,
-                 phys_addr & TARGET_PAGE_MASK, prot,
-                 mmu_idx, TARGET_PAGE_SIZE);
+    openrisc_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, 0, retaddr);
 }
 #endif
-- 
2.17.1


