Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BEAC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4BD2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BtLmtTNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4BD2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlAG-0002mZ-SV
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:17:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl62-0007um-9T
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl60-0007LB-H6
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:12:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=033a92d29=alistair.francis@wdc.com>)
	id 1hRl5y-0007Ep-Sr; Fri, 17 May 2019 18:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558131175; x=1589667175;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=vv3ooix0VzFZWoLjoANO1jDgrm6n68GaIIt8y5+y+Mc=;
	b=BtLmtTNBmqqru9vysJeHU2CBq3jLXXu3Sx/l2w1R3T8WD2TEnfKbynEz
	GRF06gbvScq3zZ1ORtShRIZkpls/Ot1jtVjuKNViKbbxm/gCuMT//VrEq
	hZqjRxZ/3/LztC6CPfojHHv3Ffhukq9+GvxAZnOAuYhrFoW+xFpXZhJWS
	1xw/Y9T1+ygmrWJLj3+f2h78ZTEqJIoIlNRvvWaMrX+3Hw/WqfNRcIwCU
	Yomhn2dAg4hvw3Eko+JaGFci0MEo0LDwkK+1gG1XWIjJUa4UTLJ8FcpC3
	9NHCcOStBWTA1T5MRCOOqkHDdNgJTB3lsRRNbhcQD+ZzboURVsQrrIFvQ A==;
X-IronPort-AV: E=Sophos;i="5.60,481,1549900800"; d="scan'208";a="110242479"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 06:12:54 +0800
IronPort-SDR: vH/6U/4IvdIE4ick20++OrPiFMIT4sJcWa5DP3gkcu4P0gPEnAUPz21HoZj6vLpmbf0DdXGJqw
	GHjIxbZOy9L3tPPnj7GyHgZz+vLuJ8f791K/oItB89BBryJMLdRRin0JSifH9+CPvexoM9EHhI
	d9F4SN/afdO0vT1Tnoi04VgKMyAsO+i3+NZTOllvdQOTkxhJtPYw2hbZ/bgE4cJwzTrbSQyBGS
	vOCLcT/zxsTW+V+4N5ExutZCGUWnzi9hqCnDu/rQVDm0ZjDurgWhdKuEvON3GsUz9wgTeWIqlf
	oQYJfV8foP7AFmnXatnO8L73
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep01.wdc.com with ESMTP; 17 May 2019 14:48:23 -0700
IronPort-SDR: iH/RJEhRyk0/GQs+jemQ0DfRKPSRCApmyHRz4ZNXzm4usHR5iJdBOx6SiXLzC754z4sT2aQErV
	SY/xHEoVSqa16+dVQ11UgjeIvwDkQjzLl8nHTgBlUXKxVlfp5zywtUl6S/rTEKrkeVW5llvhgD
	xYtRB4LfBIUsR9UBKNo0NKvzUhJkdUnC8SWySegp92iM6/1YP+2jioaaJIEGMMlI9sQPUGyVwD
	W5K8mVQrk/Q2RHLXGrdO3UNcoqmp5fn+htTrLONRzJ2Si+Lt3gke4buAarNDwvQiHGkslGbEVS
	ewc=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 17 May 2019 15:12:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 17 May 2019 15:11:06 -0700
Message-Id: <7e9b4a6cc07a931e62da9c18c40849690eef7150.1558131003.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558131003.git.alistair.francis@wdc.com>
References: <cover.1558131003.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 4/4] target/riscv: Implement
 riscv_cpu_unassigned_access
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Clark <mjc@sifive.com>

This patch adds support for the riscv_cpu_unassigned_access call
and will raise a load or store access fault.

Signed-off-by: Michael Clark <mjc@sifive.com>
[Changes by AF:
 - Squash two patches and rewrite commit message
 - Set baddr to the access address
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  1 +
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_helper.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b7675707e0..bfe92235d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -356,6 +356,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
 #ifndef CONFIG_USER_ONLY
+    cc->do_unassigned_access = riscv_cpu_unassigned_access;
     cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c17184f4e4..8250175811 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -264,6 +264,8 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
+void riscv_cpu_unassigned_access(CPUState *cpu, hwaddr addr, bool is_write,
+                                 bool is_exec, int unused, unsigned size);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 41d6db41c3..202b6f021d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -356,6 +356,22 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
+void riscv_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
+                                 bool is_exec, int unused, unsigned size)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    if (is_write) {
+        cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+    } else {
+        cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+    }
+
+    env->badaddr = addr;
+    riscv_raise_exception(&cpu->env, cs->exception_index, GETPC());
+}
+
 void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                    MMUAccessType access_type, int mmu_idx,
                                    uintptr_t retaddr)
-- 
2.21.0


