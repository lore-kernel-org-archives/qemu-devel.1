Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD43C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6BC206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aFOM+UND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6BC206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAMtc-00057B-3A
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 19:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsN-0004DJ-WD
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsM-0002kq-FU
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:27:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsK-0002d5-Ng; Tue, 17 Sep 2019 19:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568762832; x=1600298832;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GHkKx2iMe0DVDnMz2PJlSqovsjWMq6y8Tg7I8i9Imdc=;
 b=aFOM+UNDeZ5XFZSsxnYpLSrzLbgkpGoTlqb2qo64jO+CXZIDjvqHb0Jc
 1jmZ76ZWMjXvdvG6TXPcLVak0BVkWS/+D8GQWTrVqJE4a7TMJoleHSjX4
 5H2IVGpP2qMExiKs5halHCCRtWdKavqtw/2x1X8AIdJ60rEMR5ImnBiV3
 +h9WLyVdBn+STSd7PAoLfo610LAG/XqxUjS1qg8+12xmht4KWtg6FPIBt
 sx1ZcAAoAnVnwi0BKesiQNCotXClErYQcCVZ+7btXUYUI4Nsl/1YHZYIs
 9pFTgQUFYh3Y8M24SLTCncsDkUYDYKIZXrhcRAzvf1PTfVtv2MzFTb3YT A==;
IronPort-SDR: kIbapOoMffOtUumA58cu41O4MYlIcY7fUmYKnJj40k1IDXsRxdCOnEy8xNkKPNGNSLhg36MyqC
 oklrwuPycYqoX5j3M0pVZx0p12s1hyP552a1LtK9zxgDxD/J0zy/PUH046Atex5bgKK4n70/f8
 VW3VwvqeMFRvH98y/+qlZT3aWpH6h2JWOdo6y0JE5l8FINpucW9VFDpl0169wiotIrFDpX1HH4
 mFCv420RQvEjRNQ4YA8AOmgK3A5kWaXc009/59ugo9opPbPurkQGftCfuNJoXGb4L0mDKnWNAa
 wDM=
X-IronPort-AV: E=Sophos;i="5.64,518,1559491200"; d="scan'208";a="225302175"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2019 07:27:08 +0800
IronPort-SDR: pnUYMrM0ok7UQohTcLTCXu1N5PSQGjrxmhqO462jOgnb1yWto2tx0pVx96elGkePVn3vyTIwAn
 c86xzk1K3LDcgvvVX2NKyrrO14+zsIvi7l9dyMuPldjKh6QYO+Dr4FstsRfT0+YK6BEl9h1l3S
 ZZwEcvaxXzld/n7iQrNxX/XZxT9I7nym4EysJVBie5w3PJTCtj7PqniIkuSaoAdxTFoXWn1kcc
 h6AD7Vb0O0wCoRoGmlW16tXRkyPHYfXzIjNn6xvqiJVUQlkHhSrfAHIOzDXqH5ymVzVRFw+Drs
 NxRj0imcs1wUmAtUGGM64zh3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 16:23:43 -0700
IronPort-SDR: nAfKiDgCf864YPlYhHl7EN80oO7bjpo3CEQLTOwzayDBs+fZEwekKXNYZGNjWtlWTgV/UX/jnI
 jjxb2o7/S9c8zK2Me9iie3pjTDj+q3njRkOrUCGwNZX6GydvJyEq+1zEjZma1PuZsGxY9xrKbE
 xWsyORH0PdjSFvt2Z9azEq0tDC4f5DU1z6p1NRkq3+crVkME/MeAs2jflrusWqkOUhLMAJQ9Jq
 2qB4vDjrUQ/i1v4qS3o3iZRj4K0DUCnTfP/kbECnFxs9cPwvT30sZopJQ2xFNZzivRPUgLuetK
 0iY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2019 16:27:08 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 17 Sep 2019 16:23:02 -0700
Message-Id: <62b87f2ee604c437cc59e82b84853c6f02a83372.1568762497.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568762497.git.alistair.francis@wdc.com>
References: <cover.1568762497.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v1 2/2] RISC-V: Implement
 cpu_do_transaction_failed
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, palmer@sifive.com, alistair.francis@wdc.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Palmer Dabbelt <palmer@sifive.com>

This converts our port over from cpu_do_unassigned_access to
cpu_do_transaction_failed, as cpu_do_unassigned_access has been
deprecated.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu.h        |  7 +++++--
 target/riscv/cpu_helper.c | 11 +++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f13e298a36..3939963b71 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -484,7 +484,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = riscv_cpu_disas_set_info;
 #ifndef CONFIG_USER_ONLY
-    cc->do_unassigned_access = riscv_cpu_unassigned_access;
+    cc->do_transaction_failed = riscv_cpu_do_transaction_failed;
     cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 124ed33ee4..8c64c68538 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -264,8 +264,11 @@ void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
-void riscv_cpu_unassigned_access(CPUState *cpu, hwaddr addr, bool is_write,
-                                 bool is_exec, int unused, unsigned size);
+void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c82e7ed52b..917252f71b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -408,20 +408,23 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
-void riscv_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
-                                 bool is_exec, int unused, unsigned size)
+void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
-    if (is_write) {
+    if (access_type == MMU_DATA_STORE) {
         cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
     } else {
         cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
     }
 
     env->badaddr = addr;
-    riscv_raise_exception(&cpu->env, cs->exception_index, GETPC());
+    riscv_raise_exception(&cpu->env, cs->exception_index, retaddr);
 }
 
 void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
-- 
2.23.0


