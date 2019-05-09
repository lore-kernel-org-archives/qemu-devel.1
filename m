Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C70C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1903521019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ0N9wvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1903521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrao-0003ai-9F
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:32:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV5-0007iY-DG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV4-0005Ui-49
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:51 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrV3-0005U2-Ty
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id e6so1924332pgc.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=t5VoKM+l3Lq9jc+URQ3PZSk53GmjO2/IoQkt1bRH1n8=;
	b=bQ0N9wvliHWfwB6xiRY3293N8XBBGA1FEXdS7WZPjZm3S40hJBRwPQVNbAAmi9FsFT
	gezc5dhZ0gNxxmkTpCCH8rvp/cpl5xMhud5Ai1BbyFa+QsDeQyuN3Ml0YOecE7d3O0HC
	saqrymv7VOizP7UhZoeb0Mn97esNq/b3E7Yv6x9rDQ+SasbHkHIjc/5N+haCbXrA3wVx
	qmaiUrlTvA08Y3NtCde0svxHFsBD0dJfp/VEvjhhZyfLicVVhFdSGdgnV4NlPXC1IMTk
	dZ7eSX4ZsxuIgcjNYpFPCyQKMKOn35msD261O5p6uiOs15Oh10VK3j9OlsJpAQwISyXZ
	7Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=t5VoKM+l3Lq9jc+URQ3PZSk53GmjO2/IoQkt1bRH1n8=;
	b=MvDbHwombVSDdki/Jb+8PU2RzuhzbCozL7yDH7Nv/OiWc0x4Y9HOGiQSUQ8oxUR5UF
	LwgNFAf71fRpKXWv2kHJaISpIuqsWTYpfnsUsqER8Z7LTIe1waciaHhA1J7/iNCDcoRN
	FdrfY0oY4XNgHG+W4C6JCphy5xEU4SVDDxrnojfdZYwzUVOnj8GZuev33DZJiasuvBOl
	+pvgjs0cO3kbCxEVLCcBnOhGRsXTyZhWT0zq538OASFI5YBZ8tUdqh4SomSl9i0KgBld
	oO5un2pbz8M98LGkQBx/JxIkupOMyx/IHVqgv+Y5emFKaouikBcxZUBqnpu7eJXtl1fJ
	87Eg==
X-Gm-Message-State: APjAAAUp33KkcKfiGURuID62Ax/YT6zlorMMbyA4vP3qGE9c6ugH1xtd
	umg2yWGaNx6P6LupQaVHegHdsCuZnJA=
X-Google-Smtp-Source: APXvYqyWDIV4Owc7UJN9M+nKlXe0O+KvIJqPlFl9/EKy0LPgE5JcWyP7u0lT7IxnogbhwEqZhm3ygQ==
X-Received: by 2002:a63:7d03:: with SMTP id y3mr8736562pgc.8.1557440808714;
	Thu, 09 May 2019 15:26:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:16 -0700
Message-Id: <20190509222631.14271-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 12/27] target/mips: Convert to
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
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
v2: Split out other mips cleanups to simplify the diff
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
index e217fb3e36..ebdb834b97 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -197,9 +197,8 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->synchronize_from_tb = mips_cpu_synchronize_from_tb;
     cc->gdb_read_register = mips_cpu_gdb_read_register;
     cc->gdb_write_register = mips_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = mips_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = mips_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unassigned_access = mips_cpu_unassigned_access;
     cc->do_unaligned_access = mips_cpu_do_unaligned_access;
     cc->get_phys_page_debug = mips_cpu_get_phys_page_debug;
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


