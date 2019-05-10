Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E464C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB685217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 18:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlZvUQIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB685217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAjT-0003Ij-9d
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 14:58:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPAfW-0007v3-Vw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hPAfO-0005oF-T5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:54:54 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hPAfO-0005lw-J5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:54:46 -0400
Received: by mail-pl1-x644.google.com with SMTP id a59so3238470pla.5
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=tebtMZETlIDQdWSOMLyAJVULNNmJQHM2vL+aKJmhU6U=;
	b=UlZvUQIZmKs0PDQlZyEQT2qkFIOsAWV7VSVR6jf+ZocudYEJrp3U2quaWCOCqk0g6h
	331BgKq2C9Ojv7OulTxVmO8ezCe11ByyMEJtmhcbcaAFaqmUf+f7ZhQOHXFRRNXxFf9X
	2/QdmvVwTbGwVLG2sJqg7Ol52cctevusYuFus6aI8yJt7cBKC1u88LUstRDg6hnoZnbu
	VoC7aZ5HYgsP6cH5I2ZquxjrRI1vcx350pwHTEqPU/yaMjHwd3ZVUA1dwE6Oxd4h7NPe
	oYTnWE0EdTgKTPApUkyY/W7s5rHb2cylAxHZ3VBAESEnqXj1MD2PZcV2OolMK+0ytIAM
	+Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tebtMZETlIDQdWSOMLyAJVULNNmJQHM2vL+aKJmhU6U=;
	b=tVb3fWFy9sIj6vByKxEeZ/tUbJ8usTMl1bD04kunIfOIIVVNL7DUOgBgr85fQkX1oN
	dZKOI95s+6xLjp9zwFnmeUAB8lHTqa4dd5wbFClauUzvldj+vAXUPjDxYIfDeVnqwlYl
	xZqx0ayIKSX+tUcfwSyCwfmCuW3tv5K1omLDXqffoYmQqCW49izWD+mgQlDRafpDQ0ua
	dbnMvhdCD6AVEEHtCMbs+vlP4pKnng3MlEROcW1jcPZjZJ+HvezzfFfw+qjDg1YLimH5
	QVUFN7KadDv+k/myZrmKxHBTrK9eN8u/ImNwhDb1uQ1yWIQ5zVXMYj4zcbXTGggJIXE/
	bfGA==
X-Gm-Message-State: APjAAAWL+UbrRxf1mvIHQaWwSrVCRs+rrzBuFNBKVuKRUoHWJ/F5YGKl
	O8sUW/sZMR7MOK7jDkUNDRXb5rQ01VA=
X-Google-Smtp-Source: APXvYqw1EFOiEuRKAQSVAW4lkMhM7D4XarVt5F2pQ50Mh5wQWh+sL+3vC8oaoJmO86Ow+Y3jE366ZQ==
X-Received: by 2002:a17:902:84:: with SMTP id
	a4mr15342052pla.210.1557514485101; 
	Fri, 10 May 2019 11:54:45 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	q20sm12733146pfi.166.2019.05.10.11.54.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 11:54:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 11:54:34 -0700
Message-Id: <20190510185438.29533-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510185438.29533-1-richard.henderson@linaro.org>
References: <20190510185438.29533-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PULL v2 12/27] target/mips: Convert to
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, peter.maydell@linaro.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that env->active_tc.PC is removed from the qemu_log as that value
is garbage.  The PC isn't recovered until cpu_restore_state, called from
cpu_loop_exit_restore, called from do_raise_exception_err.

Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/internal.h  |  5 +++--
 target/mips/cpu.c       |  5 ++---
 target/mips/helper.c    | 45 ++++++++++++++++++++++-------------------
 target/mips/op_helper.c | 15 --------------
 4 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 286e3888ab..b2b41a51ab 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -202,8 +202,9 @@ void cpu_mips_start_count(CPUMIPSState *env);
 void cpu_mips_stop_count(CPUMIPSState *env);
 
 /* helper.c */
-int mips_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 
 /* op_helper.c */
 uint32_t float_class_s(uint32_t arg, float_status *fst);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e217fb3e36..a33058609a 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -197,9 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->synchronize_from_tb = mips_cpu_synchronize_from_tb;
     cc->gdb_read_register = mips_cpu_gdb_read_register;
     cc->gdb_write_register = mips_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = mips_cpu_handle_mmu_fault;
-#else
+#ifndef CONFIG_USER_ONLY
     cc->do_unassigned_access = mips_cpu_unassigned_access;
     cc->do_unaligned_access = mips_cpu_do_unaligned_access;
     cc->get_phys_page_debug = mips_cpu_get_phys_page_debug;
@@ -208,6 +206,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->disas_set_info = mips_cpu_disas_set_info;
 #ifdef CONFIG_TCG
     cc->tcg_initialize = mips_tcg_init;
+    cc->tlb_fill = mips_cpu_tlb_fill;
 #endif
 
     cc->gdb_num_core_regs = 73;
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 86e622efb8..3a4917ce7b 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -874,31 +874,25 @@ refill:
 #endif
 #endif
 
-int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
 #if !defined(CONFIG_USER_ONLY)
     hwaddr physical;
     int prot;
-    int access_type;
+    int mips_access_type;
 #endif
     int ret = TLBRET_BADADDR;
 
-#if 0
-    log_cpu_state(cs, 0);
-#endif
-    qemu_log_mask(CPU_LOG_MMU,
-              "%s pc " TARGET_FMT_lx " ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
-              __func__, env->active_tc.PC, address, rw, mmu_idx);
-
     /* data access */
 #if !defined(CONFIG_USER_ONLY)
     /* XXX: put correct access by using cpu_restore_state() correctly */
-    access_type = ACCESS_INT;
-    ret = get_physical_address(env, &physical, &prot,
-                               address, rw, access_type, mmu_idx);
+    mips_access_type = ACCESS_INT;
+    ret = get_physical_address(env, &physical, &prot, address,
+                               access_type, mips_access_type, mmu_idx);
     switch (ret) {
     case TLBRET_MATCH:
         qemu_log_mask(CPU_LOG_MMU,
@@ -915,7 +909,7 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
                      mmu_idx, TARGET_PAGE_SIZE);
-        return 0;
+        return true;
     }
 #if !defined(TARGET_MIPS64)
     if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
@@ -926,27 +920,36 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
         int mode = (env->hflags & MIPS_HFLAG_KSU);
         bool ret_walker;
         env->hflags &= ~MIPS_HFLAG_KSU;
-        ret_walker = page_table_walk_refill(env, address, rw, mmu_idx);
+        ret_walker = page_table_walk_refill(env, address, access_type, mmu_idx);
         env->hflags |= mode;
         if (ret_walker) {
-            ret = get_physical_address(env, &physical, &prot,
-                                       address, rw, access_type, mmu_idx);
+            ret = get_physical_address(env, &physical, &prot, address,
+                                       access_type, mips_access_type, mmu_idx);
             if (ret == TLBRET_MATCH) {
                 tlb_set_page(cs, address & TARGET_PAGE_MASK,
                              physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
                              mmu_idx, TARGET_PAGE_SIZE);
-                return 0;
+                return true;
             }
         }
     }
 #endif
+    if (probe) {
+        return false;
+    }
 #endif
 
-    raise_mmu_exception(env, address, rw, ret);
-    return 1;
+    raise_mmu_exception(env, address, access_type, ret);
+    do_raise_exception_err(env, cs->exception_index, env->error_code, retaddr);
+}
+
+#ifndef CONFIG_USER_ONLY
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    mips_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
-#if !defined(CONFIG_USER_ONLY)
 hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address, int rw)
 {
     hwaddr physical;
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 0f272a5b93..6d86912958 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2669,21 +2669,6 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     do_raise_exception_err(env, excp, error_code, retaddr);
 }
 
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = mips_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (ret) {
-        MIPSCPU *cpu = MIPS_CPU(cs);
-        CPUMIPSState *env = &cpu->env;
-
-        do_raise_exception_err(env, cs->exception_index,
-                               env->error_code, retaddr);
-    }
-}
-
 void mips_cpu_unassigned_access(CPUState *cs, hwaddr addr,
                                 bool is_write, bool is_exec, int unused,
                                 unsigned size)
-- 
2.17.1


