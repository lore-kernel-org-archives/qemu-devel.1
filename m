Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7E0C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0044020850
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofUkvA8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0044020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7hI-0005dL-AX
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:44:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jg-0007ea-Be
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jf-00005B-57
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:08 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:42390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Je-0008WP-VF
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:07 -0400
Received: by mail-pg1-x52f.google.com with SMTP id 145so3174133pgg.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=pyOmNQehrxQ+vJN1rBIdXnxr1kqTHPzFsWgERMP7ALs=;
	b=ofUkvA8DKRJRBhSyTfuTP4CJrRpdtlPCRQ9u7qkB5GMg7qmgw5oSq3PloxFex8kwbZ
	kMDWQIjHFpstu6XI/zrz+mBSvb2DGowu4QXP4kbz9pFoqM/4xFTZ7JYnVadKJ6TkGxXP
	tL86OhSpxXTBYben9oI7QllprBrC9kEOBm/861TKqNbT+knqXCmWr5uaBZEyEof/mYI1
	WD5KZyrg7NzCaZ+13njqy4mNnTOaSoPZlvBQlp9OWd93nHx+ru1+eBd9TZOZf95SknAb
	ZKGwjaVh/0oMavUez1jmQicq7xBvhJ78aGA2Rxn4hsss9Jtzm140IS4c+Mty7pupyfOY
	Ek5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=pyOmNQehrxQ+vJN1rBIdXnxr1kqTHPzFsWgERMP7ALs=;
	b=kqBg2nSytpgFV9k0J+HtpqygaKVzWFXJOtfAFkVgoLNPgCK3N4ed0pBtF+TLCsnyZB
	qlPa5eosyzbKfC7B/3LnV8YAzjrfWXlyLUeS9N9f0/uobDQR8HhS904fJUkl+8y//wCc
	9MRcH6IIEOv0Tx4kw8t0qv4LBM/sFC0Hg6fi/eEjW+4Q9XHG7dNWeGlsbXMKtZa0FMbW
	wisuBApvBsDe3TdS99azvIPnDKiHjMzHuMJpuks31xg9+4C/93wJ+/pMWryeoPjxLpHg
	uTOcjbyZFTaIbDsbbNWYvc1HPdV+9uRVEFVYWc3XPGXvssPMXxC4kdOXe1X1vSe9aPQL
	+Png==
X-Gm-Message-State: APjAAAU8dOMG1cOTVThTinjBs4F1tj9Q4gterLwVjXNz6RYpX0S85AYO
	w70IRACCuFRTLss1WfywR0fxanJrcjY=
X-Google-Smtp-Source: APXvYqxXpRbJyiovJlkp9WTm0Q+nxSPFLo2ost9doVl6R2NVxRkDCJ9N7u+NhgbnYkvqbtan4A0F5Q==
X-Received: by 2002:aa7:8554:: with SMTP id y20mr14945470pfn.258.1557501605638;
	Fri, 10 May 2019 08:20:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:32 -0700
Message-Id: <20190510151944.22981-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52f
Subject: [Qemu-devel] [PULL 15/27] target/openrisc: Convert to
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
Cc: peter.maydell@linaro.org, Stafford Horne <shorne@gmail.com>
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


