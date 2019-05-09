Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02FAC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CAA20675
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/a7l2V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CAA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcHO-0005Tl-Tn
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:11:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8z-000600-H9
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc8x-00074x-VO
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:01 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc8x-00073v-4F
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:02:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id j26so630969pgl.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KDWMmeXDxeYaDrbtpgauY6pAF7pSEhxca7JLZhrlUgE=;
	b=r/a7l2V68fV6NQ0oPdyGrUs0Miq1msJnGH2RSeoex3VTNdpUyuuV3GiwYwWtUKr5df
	yIwTT2rh4mat2NaFfHO6ZBNyPNDp95BOQe+cd2SvU3M72w02Dxd3a70Ln8yGHeSgaRXQ
	wStn/4YWNn3QHVNuHHKnglay0jBmwr3GbSgqZ7Hkg/f4rUiOFcKQwjQvGcZwnn6WszeM
	xGYGwAasB5aKSw3Yva8Wwkd1Tx1Lj8AxOCUSgBKC7J1bHvJk9o6qAjhqDE/IedhnjWR1
	N2M3akcUBj1dsFlP6VZSkL5S7bZ8mLW/OjMWQXqXlIgDAMaFQoTCY7dQgreIcBfokzo7
	AlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=KDWMmeXDxeYaDrbtpgauY6pAF7pSEhxca7JLZhrlUgE=;
	b=L5YSm25K9MH4iba92XU92zUDDqhx1RuunZiu/AU+GTmryPhq2MWbd51pRRUQtZGuTi
	+xNquT4ojH8T2jrtijGPUxvFFM/XTqVPQUS7b6hD4skyM6otyAE947B+cgjgP8cvq2N5
	4CHdUNn6LIuavuDG4Iy12bPnKVAk3Iwe8hWs4XJqEQqznUmJ9VEqS64FY7K9poALXGbP
	UsTgMd1nGSsJKmIRf0CK5NCv9IIjDzkOTU8xkBgXX+/xNHnWRxWCLBukc/ZxgF8+i41M
	ts2/ydGKGzq5i18vl7FEh2x1E5frNYJBSpnkiUXs1ODDyqXiPBSD2rAbe319TxrtW3J1
	NRWg==
X-Gm-Message-State: APjAAAVyiZlXkaNQjpSEiHdfK29xX1lWHZY/FiUKVgBKAAODLaeCPJe2
	vAs/+6QkU6Q10bBUPf0aQrcOSP++ip8=
X-Google-Smtp-Source: APXvYqyqPq3ayXTCA5ODqOlyc/aqN06lXWE27msA9sK8DufVnOm9BxFnInHobOuHShz/UBkKGV45Xw==
X-Received: by 2002:a63:fc55:: with SMTP id r21mr3101581pgk.441.1557381776890; 
	Wed, 08 May 2019 23:02:56 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.02.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:02:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:26 -0700
Message-Id: <20190509060246.4031-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 07/27] target/lm32: Convert to
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
Cc: Michael Walle <michael@walle.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Michael Walle <michael@walle.cc>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/lm32/cpu.h       |  5 +++--
 target/lm32/cpu.c       |  5 ++---
 target/lm32/helper.c    | 12 +++++++++---
 target/lm32/op_helper.c | 16 ----------------
 4 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 9b1e6c2d58..d224d4426e 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -261,8 +261,9 @@ bool lm32_cpu_do_semihosting(CPUState *cs);
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
 
-int lm32_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
-                              int mmu_idx);
+bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 282da19994..57c50c1578 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -231,9 +231,8 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = lm32_cpu_set_pc;
     cc->gdb_read_register = lm32_cpu_gdb_read_register;
     cc->gdb_write_register = lm32_cpu_gdb_write_register;
-#ifdef CONFIG_USER_ONLY
-    cc->handle_mmu_fault = lm32_cpu_handle_mmu_fault;
-#else
+    cc->tlb_fill = lm32_cpu_tlb_fill;
+#ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = lm32_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_lm32_cpu;
 #endif
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index a039a993ff..1db9a5562e 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -25,8 +25,9 @@
 #include "exec/semihost.h"
 #include "exec/log.h"
 
-int lm32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
-                              int mmu_idx)
+bool lm32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                       MMUAccessType access_type, int mmu_idx,
+                       bool probe, uintptr_t retaddr)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
@@ -40,8 +41,13 @@ int lm32_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     } else {
         tlb_set_page(cs, address, address, prot, mmu_idx, TARGET_PAGE_SIZE);
     }
+    return true;
+}
 
-    return 0;
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    lm32_cpu_tlb_fill(cs, addr, size, access_type, mmu_idx, false, retaddr);
 }
 
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 234d55e056..be12b11b02 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -143,21 +143,5 @@ uint32_t HELPER(rcsr_jrx)(CPULM32State *env)
 {
     return lm32_juart_get_jrx(env->juart_state);
 }
-
-/* Try to fill the TLB and return an exception if error. If retaddr is
- * NULL, it means that the function was called in C code (i.e. not
- * from generated code or from helper.c)
- */
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = lm32_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-    if (unlikely(ret)) {
-        /* now we have a real cpu fault */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
 #endif
 
-- 
2.17.1


