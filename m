Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9DFC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 21:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6592920873
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 21:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lyLarlJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6592920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHwdL-0004Xz-36
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 17:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWw-0008AQ-6o
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWu-0002HS-V3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:56:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHwWu-0002HA-NF; Tue, 08 Oct 2019 16:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570568184; x=1602104184;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pvc66Uik+KxP3YvrM1LSPSwpT4x8ShXKtIkGQgR5Bdg=;
 b=lyLarlJodQVCcdcwIOFziiYPR3sxunTutcqv4vENjtTwslzQJcM69u/W
 HTdHud/evVCu7/UnSv7lI8ITjbahm7N5KVJMsNUNKPgDcD3Zgef843c/4
 7TjPhONpsqJLMMVM08HOGd8ITVAnG2jKMaK53R/U5uFqy0XW+74WwOPY3
 wkwe5xyC5gkhfQKP03U06F1vI6mven26OkvF83u36ch+5s5y0OuyDckhi
 p3U/tt2vo5uBAzYXRuNBcL+pmJlbvJCS77ah34qaj+ElGpYJlNePYPDLG
 OtwidFAGzc3dcJsRCnBlUd1Gp9nsLW5DtLiYqFFQFXkVCwha65woR39Y6 A==;
IronPort-SDR: n5mw6F6QXI42U8TYKGtizQPxntQAuBOoaNkdLt8v97wqJqMkZnm9tR22w3eLn91LpkSYbJYwle
 I+fYbL06fIIGHtyP+Gcfa57CCxzpG3L9Sl6K/EmE6XaPq/bClyIoolGml1/YhdxHBAEScAOhpf
 lhiBi6U6UyoYK/n4iOO7vP5/37U/sSXThF3G+A/xFKMD/OSNLCijoXpXTyx9jp2m5ThrcipELM
 yaTZOQXklhAlWxXVSQaTmJD4+j0WYy+Ffj/b6ZPP7Nm30nXooPOXOQqdxgD72PEWGnthsbh6pK
 EJY=
X-IronPort-AV: E=Sophos;i="5.67,272,1566835200"; d="scan'208";a="227047829"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 04:56:23 +0800
IronPort-SDR: uyCXAFmjkgdzdBfQRCC6Px/mloPNR9nIGxANa35k3FkTr5cRm2LLU7ow1ze6LNYC4kXEJghO7G
 cB4LPoZDr0h+CbpKeKPd2b1F8flvO/i9Rd8DxishehX6L+u/fM7n6Y5q7OXbFkwghYKegToyV3
 XYdCPOvuz3w4OZUWr7d5QMMpJb+M82A5auekFwroaATVTPreJu7iUIo4eZ1/tvn4lCgR+aerXR
 9vVfxOKfuuWF/07zJCAkg3XY41u8EcOsoapPZB0srMmpqbU7qM4qWI2TBKi20O6KbXjpc7kXsH
 bJq2M0Ec0B2shWgm6s+JS2aG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 13:52:24 -0700
IronPort-SDR: Y367CMfUEkQnQgvot/seoHQB7LaLgcGmDEsHLMq6ISm8QO/h2J8mbECjbGDnpxB5hJ9AZMQNGl
 z67BxHVYN0ibz//R3z1//CrSQ+SL7LQa6oVPU/G66IPj7fmaQI166Y27udSNJ0SKGZPfejmlLU
 3k8nbjzmFpeB25xCkXDpzD0TI9uwi5KHA4gdElBh4dXpbRxypAVy1RjoF3/OPLBjEOIcEre28+
 N5A9fjTcsAReRxAZhhagjWd4tcOOv1oQkEUZqJeMX6N0DUybT1k/DvHGOACHuPvHAu9K1bVRBU
 Qo8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Oct 2019 13:56:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 2/2] RISC-V: Implement cpu_do_transaction_failed
Date: Tue,  8 Oct 2019 13:51:52 -0700
Message-Id: <ffc9ba71259b9d212ff3fa29462a5cac6e0710b2.1570567870.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570567870.git.alistair.francis@wdc.com>
References: <cover.1570567870.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Palmer Dabbelt <palmer@sifive.com>

This converts our port over from cpu_do_unassigned_access to
cpu_do_transaction_failed, as cpu_do_unassigned_access has been
deprecated.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


