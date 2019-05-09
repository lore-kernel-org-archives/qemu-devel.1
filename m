Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A7C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFAA208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZA1JPYJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFAA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcM5-00026r-BU
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:16:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc98-00066M-1x
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc96-0007A5-RS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:10 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc96-00079e-L9
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:08 -0400
Received: by mail-pf1-x444.google.com with SMTP id z28so733749pfk.0
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Po065qxrjk3XsW6DqLkqX6sS5n4nQgII0U5vHcIO+W8=;
	b=ZA1JPYJHsS8cLBlNDoL7OcZzzfYHKYIz5i4eP+RN21EJNZT0L9VXaKb/Eer3dn/wO6
	eDHaYXI0pXHMIF9Optzey+AXayrkZa/TZjlsgwNg2R8N/t8ClCDyR0oUXOhLn+HkF/i/
	fCA1bqIx4qGvtxRxV4wa+WbL+S3sJsB2cftI00JG6DiaZ0tW0K7v5VZGNA68t3ZWlEQj
	f3ATNDz7uJ0tEULL1DianRcxm6R5eEt0eIDzqTXjZ7XrCx72rjcK3FZtRB4zYIU4BIaV
	GGedQgBDLp3/jioxrFMFzOk5/yJpyB44WKb/arI3pBAMV3AwE/l6gnd2nnZwMvXP14Lv
	Cz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Po065qxrjk3XsW6DqLkqX6sS5n4nQgII0U5vHcIO+W8=;
	b=c6e7VSII3H2Xcd8XNAFXm56l4WhBl409pXILDf3XiXStYkVXh9XHu55cBOk7SLPPAE
	wf5FbLfAimR+kB+mrySfnGnXmhRLADIfv1RDAg73wYPEDtt1wQYryvXa/K1SmE5Atg3V
	OjV308BCXiQXoHJxxWFw0J3ILPvjprFcubVwLYtQciBlj8umRPFnmoayYxrWkm9XV5aT
	wE/La7VOcnyBAGfp5ITyky1UKlEG0PwSHcsLa4Eo8MNG7ikKXqFPzTx9Tl/V9nGcHjzJ
	8lTKCXK1fV3fByLLQePLBnt+jWqao44OB1lp2DPIxxpv7cAFzg6r6V8ctbPtk8srQpWN
	SYmQ==
X-Gm-Message-State: APjAAAWLC1bMP5ytPLdATqo1dhxBcLhVJCOUGMA6YRuxQuR/Y37IrOeh
	rIkWs+hSVxRG3LIhaGoSgybSYsU5iOM=
X-Google-Smtp-Source: APXvYqzK5r85UhrCbW61JXQExYPxader4N2BNlqL7zbv+teB3e5PqjuovGp469OUhF9M9Kh4mPgVbg==
X-Received: by 2002:aa7:980e:: with SMTP id e14mr2609706pfl.142.1557381787349; 
	Wed, 08 May 2019 23:03:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:34 -0700
Message-Id: <20190509060246.4031-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 15/27] target/openrisc: Convert to
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
index a50861955a..5b1ae803a1 100644
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
index e7d5219e11..991f3fafe8 100644
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


