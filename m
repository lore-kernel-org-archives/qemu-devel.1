Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B6C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6D32087E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgg8PjH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6D32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45307 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7fc-0003nu-Bc
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:42:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jn-0007no-CW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jm-0000FO-Cu
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:15 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:41597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jm-0000Er-7a
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:14 -0400
Received: by mail-pg1-x534.google.com with SMTP id z3so3175228pgp.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=s4MN+agLoZqxLhzSptzqanZ4wwu5I/aQQC+BedaVD0U=;
	b=zgg8PjH4YnENq5WLwCWpzZ+Nr3n7SoYjq2Tf9O+KHz4AQpUpOW4bykeeVfmHJEpYHb
	LLOLoUNZCJVdbVJ5JC9DJy6PQ1OQRe1DFhX3HMxM2tAIQ0PQNReB7c6wpni4wZFITqym
	kCmtC5qnsHa41DftzqZl0JABtEO20wxr/BeLLLCuQUtDIVPwIXLEAcpo3y03Ldu6wtdW
	uIia4tTkmrTI7OeKtauk+Man9Zo18O7m4m6S1eYmr8rYnCBkBdobx1wGwqtohI5AX71t
	KOEkZzpXR5GFcJoXdAuIXTTl28JGlDEsrUTIk29+m1yYlcITUJfwUnPrXdpRbmHSdmvx
	bFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=s4MN+agLoZqxLhzSptzqanZ4wwu5I/aQQC+BedaVD0U=;
	b=uoMpDwuW8t1rc99MkLxne4WH/YxOrKSmHJPR7c3O90HjsDNmqp4oAV1dn/vzOxvQl4
	jeRLgWcSvrmc+YE7ajEQ4dxzV573q8FVFUBMCc0xaVfAOq46b+s6/VL5gUK103+inNfk
	HY4kJ2+FqVMZTKU1BFXqPLoiO1NtcYY6VwbjS/3bW6+PohRhzDU+DXg3J2cJrnn70QPn
	WUCkVX3VTHWPF6w03DPnrW15lO8QXsQEzgmadYkkFR+Z85paIkRgvPhEfXgoladdhSrv
	qbVYZTg8sZKLGb/XU+D8oWQGvpar+McWHwd6OGCq9cGF5JTJk532D8qsBrYIM8PIbXo3
	Q/Pg==
X-Gm-Message-State: APjAAAWVV09ZylIW1u575SchUmY9iGMv+ahgWx2ocjGE//uf4lUdlqAB
	c4YoZp+fPD4i9vh31BHHotAF8JWyDMg=
X-Google-Smtp-Source: APXvYqxYZtoiEwGRG66TePA+BlifD40hFFUvFgRCy1S1LWAF96I4YMTek2DRwbyggXSwO5tSucJ9YA==
X-Received: by 2002:aa7:8453:: with SMTP id r19mr15042988pfn.44.1557501612868; 
	Fri, 10 May 2019 08:20:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:38 -0700
Message-Id: <20190510151944.22981-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::534
Subject: [Qemu-devel] [PULL 21/27] target/tilegx: Convert to
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
Cc: peter.maydell@linaro.org
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


