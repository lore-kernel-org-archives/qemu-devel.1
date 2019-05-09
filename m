Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC3C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04708217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoNp4NMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04708217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrsK-0002gY-AY
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:50:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrVK-0007vj-6i
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrVJ-0005bg-85
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrVI-0005ak-33
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id z3so1918334pgp.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=s4MN+agLoZqxLhzSptzqanZ4wwu5I/aQQC+BedaVD0U=;
	b=QoNp4NMjX0nM18pO91UXdLYVqcxOqNZg+rTWEQaHWE2/xWgHVNVRuXjeZfu1D37zst
	DrP0WT+OOr/MecTTnX0tBngUkiHfy6tJ/fi4aMhAvY0YGVa9rSbPjXIiOnYD0RREOR3D
	o37Ba0KMXvR7yTnrrwb54v12MZ5RanGJEgejZUBtwh3368DTpH3P+VrsgXDhPzLMpHTx
	HneZ8on9m4n6ECs9JxPny8OaoxWuyAnq6VcNI0FkJGF5XO4HGyCiTCX23VBYw7ZqJOeD
	V6I4VPbqxFpimC1jfamFXVmaNnPWPVBi/m2of9Jpvsamjp12AlMQdOHPjvB3/FhmtDiu
	7ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=s4MN+agLoZqxLhzSptzqanZ4wwu5I/aQQC+BedaVD0U=;
	b=e+QCexx2c8baZTuk7VGLzuYmy33jhhbg/ynhZWCHEfp0RbqXtH4ZCaiapAjXqk3oHl
	zaei9z0xmdwcM3tPrEPOP3/qImVrVFaxu43nJZi6Ilw99qoMCwdxe4Ho52HPU4e7d2bH
	GFQC+pTICtvx8EbNn5PqBReZ3agnLcMYJZmySjblZ75HZLlCMWW7T8xfUvu6DzyfGrff
	9sAfjlj4qz+u9MQyHG5iGGhCiPjMZnAUbNbR5Rz2PLTjZ+jvokIBtXG1gyjabjVHQUoW
	S02HT8jAd4L8Y9SW2aXnBdQn+rjqq3JV8IWlUMOTcAjEp/vt9exeYGREF1ytAoE5rCqf
	Wj4g==
X-Gm-Message-State: APjAAAVHFkX3sh6ATsTnbukAe3jp99fJP9zkaaBT7AXGqX9I4d9IlmUN
	M7e/NFiEnpUWzOdk2y6Tt5DEhSxbI24=
X-Google-Smtp-Source: APXvYqwffY1fD3UQKrV13pQAU268l6OBgW0Bh/TzBG92YMSgnZWfq/DeVySGCwI8trYEkIZjfr0k9w==
X-Received: by 2002:a63:61cf:: with SMTP id v198mr9074034pgb.29.1557440821617; 
	Thu, 09 May 2019 15:27:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.27.00
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:27:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:25 -0700
Message-Id: <20190509222631.14271-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 21/27] target/tilegx: Convert to
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tilegx/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index b9d37105fa..b209c55387 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -25,6 +25,7 @@
 #include "hw/qdev-properties.h"
 #include "linux-user/syscall_defs.h"
 #include "qemu/qemu-print.h"
+#include "exec/exec-all.h"
 
 static void tilegx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
@@ -111,8 +112,9 @@ static void tilegx_cpu_do_interrupt(CPUState *cs)
     cs->exception_index = -1;
 }
 
-static int tilegx_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                                       int rw, int mmu_idx)
+static bool tilegx_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                                MMUAccessType access_type, int mmu_idx,
+                                bool probe, uintptr_t retaddr)
 {
     TileGXCPU *cpu = TILEGX_CPU(cs);
 
@@ -122,7 +124,7 @@ static int tilegx_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
     cpu->env.signo = TARGET_SIGSEGV;
     cpu->env.sigcode = 0;
 
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 static bool tilegx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -152,7 +154,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt;
     cc->dump_state = tilegx_cpu_dump_state;
     cc->set_pc = tilegx_cpu_set_pc;
-    cc->handle_mmu_fault = tilegx_cpu_handle_mmu_fault;
+    cc->tlb_fill = tilegx_cpu_tlb_fill;
     cc->gdb_num_core_regs = 0;
     cc->tcg_initialize = tilegx_tcg_init;
 }
-- 
2.17.1


