Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69184C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A92208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lv1CIGZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A92208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48831 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcQE-0005ab-Av
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:20:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9L-0006KM-TJ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9K-0007IR-6x
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:23 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc9J-0007HY-Vt
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:22 -0400
Received: by mail-pg1-x541.google.com with SMTP id d31so629309pgl.7
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WBbuMFJPoHwZ9nvC2CuWnBbrsjf1dWxChrYOssiCWu0=;
	b=lv1CIGZIlqIXI2rxq1Hh06IfQEHfRMsGIVjggqqGQu0VRXNtBIXiKm4EhwMeWR6iQV
	4DYkFQVJCHr80oGyYZCvVOoS2c6IhUxF0lO1VaJHglBiLf8Tl6NI+ux/qgennorkM7XF
	GyiL0GgHQqt3eFuFG4mf8DIeGQ4I3Q8z0IXUdShTJ67BudzsK9Y4s6DYoQqesOT4Ta6E
	1D/5QBd+ltxQMKRE7tNK3tio625Tj1iub5WHePaeC67MqHQVYIILx7igfe0Z95InnJ0S
	XIT9jv3Xa1Q/Mvh3fWjyF9DLZSrXi4z4QKQA9s2l8rIJuCXJ8OZg8aE8Z1wkPKzArD4c
	LCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=WBbuMFJPoHwZ9nvC2CuWnBbrsjf1dWxChrYOssiCWu0=;
	b=ijqSIU7SNsS9dZR91hQkscFkR1tlQLNXO1RjJL0xj/0858RHk5n9F8/K/goKMZbxNX
	V7ZAs0C8iXIEhp7DRl+rXdZx4wkrL7blN/hHksiS99eFn87wqp16CpWwc2B/EQEa1uNx
	9sVP4MgqFSumoO6a+hLMvQikUOFpS3p/0Pbz0EykzfUfd6mb/7+OZiiPAXE2gPgV8omE
	CgW6Mtm5WRaYPdyblLXZlhMqzwwon6yk21mStFGLWRISb9PQtHU+Rac1iNpmkRItYADw
	kAJ+pz1nQAUhMp5zFu0Y/JxF/sA3PcvlqgCkZ4UrKN7ATyJgfR/OHYK1taJP9TZMpSNF
	6ZRA==
X-Gm-Message-State: APjAAAVYBE6USDcwua5IWDm0qaOQNBlt88eU0hapsmqu3dCfXvmsgMNj
	s3HRiQdjuSG6s7yeYb1yG5QM9b9LUMM=
X-Google-Smtp-Source: APXvYqzuF+V4NLqWcwbBB5kKyRtoArkmj0r3msJrBAJdiRFVJGBv8f8W7bd3blEC20UkzZxVe0ZpnA==
X-Received: by 2002:a62:f245:: with SMTP id y5mr2640467pfl.12.1557381800142;
	Wed, 08 May 2019 23:03:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:43 -0700
Message-Id: <20190509060246.4031-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 24/27] target/xtensa: Convert to
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Keep user-only and system tlb_fill separate.
---
 target/xtensa/cpu.h    |  5 +++--
 target/xtensa/cpu.c    |  5 ++---
 target/xtensa/helper.c | 39 ++++++++++++++++++++++++++-------------
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 5d23e1345b..68d89f8faf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -552,8 +552,9 @@ static inline XtensaCPU *xtensa_env_get_cpu(const CPUXtensaState *env)
 #define ENV_OFFSET offsetof(XtensaCPU, env)
 
 
-int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw, int size,
-                                int mmu_idx);
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
 bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a54dbe4260..da1236377e 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -181,9 +181,8 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = xtensa_cpu_gdb_read_register;
     cc->gdb_write_register = xtensa_cpu_gdb_write_register;
     cc->gdb_stop_before_watchpoint = true;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = xtensa_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = xtensa_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->do_unaligned_access = xtensa_cpu_do_unaligned_access;
     cc->get_phys_page_debug = xtensa_cpu_get_phys_page_debug;
     cc->do_transaction_failed = xtensa_cpu_do_transaction_failed;
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5f37f378a3..5c94f934dd 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -240,19 +240,21 @@ void xtensa_cpu_list(void)
 
 #ifdef CONFIG_USER_ONLY
 
-int xtensa_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                                int mmu_idx)
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
 
     qemu_log_mask(CPU_LOG_INT,
                   "%s: rw = %d, address = 0x%08" VADDR_PRIx ", size = %d\n",
-                  __func__, rw, address, size);
+                  __func__, access_type, address, size);
     env->sregs[EXCVADDR] = address;
-    env->sregs[EXCCAUSE] = rw ? STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE;
+    env->sregs[EXCCAUSE] = (access_type == MMU_DATA_STORE ?
+                            STORE_PROHIBITED_CAUSE : LOAD_PROHIBITED_CAUSE);
     cs->exception_index = EXC_USER;
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 #else
@@ -273,31 +275,42 @@ void xtensa_cpu_do_unaligned_access(CPUState *cs,
     }
 }
 
-void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                         MMUAccessType access_type, int mmu_idx,
+                         bool probe, uintptr_t retaddr)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
     uint32_t paddr;
     uint32_t page_size;
     unsigned access;
-    int ret = xtensa_get_physical_addr(env, true, vaddr, access_type, mmu_idx,
-                                       &paddr, &page_size, &access);
+    int ret = xtensa_get_physical_addr(env, true, address, access_type,
+                                       mmu_idx, &paddr, &page_size, &access);
 
-    qemu_log_mask(CPU_LOG_MMU, "%s(%08x, %d, %d) -> %08x, ret = %d\n",
-                  __func__, vaddr, access_type, mmu_idx, paddr, ret);
+    qemu_log_mask(CPU_LOG_MMU, "%s(%08" VADDR_PRIx
+                  ", %d, %d) -> %08x, ret = %d\n",
+                  __func__, address, access_type, mmu_idx, paddr, ret);
 
     if (ret == 0) {
         tlb_set_page(cs,
-                     vaddr & TARGET_PAGE_MASK,
+                     address & TARGET_PAGE_MASK,
                      paddr & TARGET_PAGE_MASK,
                      access, mmu_idx, page_size);
+        return true;
+    } else if (probe) {
+        return false;
     } else {
         cpu_restore_state(cs, retaddr, true);
-        HELPER(exception_cause_vaddr)(env, env->pc, ret, vaddr);
+        HELPER(exception_cause_vaddr)(env, env->pc, ret, address);
     }
 }
 
+void tlb_fill(CPUState *cs, target_ulong vaddr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    xtensa_cpu_tlb_fill(cs, vaddr, size, access_type, mmu_idx, false, retaddr);
+}
+
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
-- 
2.17.1


