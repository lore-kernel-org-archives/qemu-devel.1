Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFC0C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C5520578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwWa+SIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C5520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45087 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7Rj-00073S-E2
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:28:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JX-0007Uw-5z
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JV-0008Pr-CE
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JV-0008P5-51
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:19:57 -0400
Received: by mail-pg1-x541.google.com with SMTP id c13so3193942pgt.1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=KDWMmeXDxeYaDrbtpgauY6pAF7pSEhxca7JLZhrlUgE=;
	b=cwWa+SIwBw5dOd9/wbWsoKFwNFkrAtqi60EkVXvqjl+VKTTmnabBZj22+flfUQL0a+
	YnpDT0RGjNxamlEOigRg8FJTE2qD4PSBd4HJB/Mi/PXHD/RndmFp3PokXfJOTeVQTvY9
	xerrI0E2L7gQ8OM3dUtMOGuvm0o1VBEqasw70TQoK/+JIZ1WPmL6kC+3WWHbnA920h9z
	BkCcCycyo5/IgalVQHi7ljn9zdUe2QywL0zvEr52BduCd1aozjR2CaVIVdo2PjW8SxjH
	YsLlrFw0uiMLjEDLOtKxQqxUfh+JQH17XxsWq7/8uOleKbwKJBwJgnaXS33dQv+4JMHd
	PccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=KDWMmeXDxeYaDrbtpgauY6pAF7pSEhxca7JLZhrlUgE=;
	b=isEF2AEfzIY4YlL2SFGC89Q/lFQtUvWe6S3QzV+amHKd2Iv4GjhjCjeoIuIFvJT6ok
	epd5hfntUIp73t4RQNfS0r0bExEMsRImKVoC855lQHQweL8cKnH0BM3PKKnwobbe43QI
	xkt+4v39LwQzroGIsoi3uwgojr9apg92+tp4h7LHzkeNUN3cq4ObtLgTfpSixS7HvHww
	nJDfPs9d9cuLbJixP4CNEpu8AeqkVTojh+bWpUwRfboKRVBvymgpgQ6Tm1f7Q3AlMyGg
	uddW88fcJGkloKbHqeaUp6Lrg4ATsO4N5UWNT/Ovs6JeV0cEZ7bFRZewazh8Fb94ISi4
	5OHQ==
X-Gm-Message-State: APjAAAV4n8R4VxRUKWm5j4ba2XChWBTfTbVxY8GQsRf5RWOYuzZkkrAo
	fIJtJiyjjlo5czp1+BIYn0suL6EEPEo=
X-Google-Smtp-Source: APXvYqyhwn9RCuyz0s3DamSGJ13n8Rv5Swh0WxgZKo2TK4JDTfSQ4XvrD9nTHTzgPstZh2GtL3fiBQ==
X-Received: by 2002:a62:5653:: with SMTP id k80mr14676038pfb.144.1557501595860;
	Fri, 10 May 2019 08:19:55 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:24 -0700
Message-Id: <20190510151944.22981-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PULL 07/27] target/lm32: Convert to CPUClass::tlb_fill
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
Cc: peter.maydell@linaro.org, Michael Walle <michael@walle.cc>
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


