Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C2BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17DE208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+E9kacG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17DE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48773 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcLi-0001IT-5G
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:16:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9G-0006FS-Ku
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9F-0007Fh-Lr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:18 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc9F-0007FD-Ff
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:17 -0400
Received: by mail-pg1-x543.google.com with SMTP id h1so637947pgs.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=s4MN+agLoZqxLhzSptzqanZ4wwu5I/aQQC+BedaVD0U=;
	b=B+E9kacGpyzB7L3CvPy2mjiuDYpq0w2ZzDcSFGdNHg0kMMwNiS2E87BSspTUpCKrQs
	NXbLhKW/RiOrU9C34kNMqxxrcFJqn24BXvNPC06bgshYiur6G5qs/VjMBDGPSIQzUN9V
	KAw1LZb25eVEqzFxApIbG0v5XnG1iSR3OnA4qQYiM33AXYzsuR+8bRUMPL3o2FavYT56
	nWt9XiRYCItvu4aH5RnygW/e+A9g1HoZ28VBYK8QNR7AMWkhCEVtNKyjNrm+zx9nW2PE
	PUOZaMzUTfVS7r3d/+0aRIRvNt2nJXAcD5Bg4NXxmDTinmKYWTOdfP+5agKuyR69l/+g
	mfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=s4MN+agLoZqxLhzSptzqanZ4wwu5I/aQQC+BedaVD0U=;
	b=THY+FdZRMU1GGJfllP5zD/qqozBbmd+gnwBYL1IpnMcECf9RCI3ggflSKpiP8Mlsq2
	YXEU0dZuEZozvDUz1OE2cW9jh5EzZbpSzV9CMcvr7Nu1VOo34rjr1mT2DO1AY4aDXWuG
	WzdXvnUNKvA/pqFibVkV1wWcjl30drZEx9n36OQwXF5e8Lw5LZ8tuLDpAlbAt0SwrcDa
	n4pGNhh29Eh5xGvwJ2ObhKRz1ClaTVpeKK1mVoQ6DetB31NNYBXUByzFDdqut2yirJ6+
	lJBxmI5bHE9J/u3mIzpNX30tw81PLZX4HamSUYyWxgsh1sGBLx2Xp4BhR57robA4u3mm
	bDkQ==
X-Gm-Message-State: APjAAAWoLPGHmXGiM2hAxJ007Msc85AFn/6/slnTEQkeinyfwNY8K8Jg
	NnpxsRzD1TB1DkCcE5BtGbG4gSOBqQw=
X-Google-Smtp-Source: APXvYqxKDMYSJBnXXia8hd79KYLV+wwV1S9D+eR+GoVTcwtPlcGRkQMli1TYyqPHgR5Yyb1zuMylmg==
X-Received: by 2002:a62:7995:: with SMTP id u143mr2566428pfc.61.1557381796318; 
	Wed, 08 May 2019 23:03:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.15
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:40 -0700
Message-Id: <20190509060246.4031-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 21/27] target/tilegx: Convert to
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


