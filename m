Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12323C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F682053B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGjmaRZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F682053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7PE-0004RN-26
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:25:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jc-0007bD-HH
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jb-0008UC-5v
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:04 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Ja-0008Tn-W4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:03 -0400
Received: by mail-pl1-x643.google.com with SMTP id x15so2977956pln.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8AceDIzAKZ/IbsaMhEPVD0M5uShF47/3BlNlJvJR/2s=;
	b=hGjmaRZJ6SsroPsebkbxKe+CgoX8Ue3qK9qGRzCpeZx5LwtcCQjsp0Cevvq87jIwyM
	gdkFEP/UmiQ53GERO+lHAylJwhcMJqar83e2DCcXs3A0S3lF/4/i4XhuhTIAbJUTI5B5
	WaCHyfDBEBp9aWX5dW+ZWsNlXV6Ok+cw5P7RI2IFa8Ggq6IhHFB77gCTSjkVEb+SqIps
	nlPzWjMQeNmsOhJbNniXC8rxy7O65GbAAnZT4l2OZFullsBn8IJjiokkpiCIA64vzTvl
	RKlkOM7NM4XOE7DVwjuLIqzZluK993mAX+jgKueRj3JO/IewQDVo1MsxWKSrZlrnq82J
	NuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8AceDIzAKZ/IbsaMhEPVD0M5uShF47/3BlNlJvJR/2s=;
	b=A6R8mfD82G/GlINyL41MDV0YF3UBzjffQ/iny8+xX7G2Sb12gURJoaGttk9Tznjhfr
	ADA/zew0fmAKykzYAjISvRZEvYtnT1hZFdfCU68g+NKueDXQsOs5C+zWQL9/im6+rGLF
	8YE1GjlzivDjZcvulweZwf6r6IqrKQOxrXt8BMgViKYkJgHA5/oYCW0MJntIGm0zAhQ5
	tFOjmQPx9hW7UGvCLge58F2hoXburRrV4k5ELG7OFv1tKIegP8cmNmtiJyfKE75iEY34
	a0W6MYuQqlCOieOxstgPADJ0+wki085jHKbxgBFiyPGShk4OGtNSf4ILEQOQf99Qq7uD
	oa7A==
X-Gm-Message-State: APjAAAU9S1FP8v+XWgzaWsNo277iGRIKewO3SkQ65iwsFzElw9IwWTsG
	iBHB1t3KwrxT6MWLVfBn0kZ9VFBRWsw=
X-Google-Smtp-Source: APXvYqziFxkG1iSiHSx2GDCr/LoIWeQCbM1Ti5+JfAMgELPakf9l+1/TPX1ybX5D0+K/iwLiyJPyuA==
X-Received: by 2002:a17:902:7c93:: with SMTP id
	y19mr13688072pll.55.1557501601785; 
	Fri, 10 May 2019 08:20:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:29 -0700
Message-Id: <20190510151944.22981-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PULL 12/27] target/mips: Convert to CPUClass::tlb_fill
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


