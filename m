Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65157C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC142077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZYfzs+Hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC142077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNgb-0007D2-Vc
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaP-0006pS-52
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaN-0007Dg-Qn
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaN-000793-Ic; Mon, 09 Dec 2019 13:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915421; x=1607451421;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/3fxKU2515+FuiCpoyXrQI09sK+MUJhblGNAHmPNsJI=;
 b=ZYfzs+HlrLo/N3xaTGU/+ZW0tDGqukyKadu+NYBzSg9mV3Io7wt4KQjS
 v++omEXnhuN4zEWePyGkaCZGJeP7B6yAE+c26HNBbY6qo65jtqD9+D927
 /9bocACLlYEtfmG0sJ+LTylBdZzWcAwQiyX72k9oVGzPVG0KyHTtGGWOH
 4DXdeMudyikSAgu9IEd4vsoUsIPKT2/piLULlF7YDp8LpBrk6XUcIKgQ9
 Drjwu7sId2wWvJcgDNCehBhyfgo9iW259JczDlst6TS1JHVnSGk9JKFgI
 zB6m4Pj6or/RAfJJ7hUOVUiqkqF3obJWnknjeuUfNRvyMJUDA1oVu6czu Q==;
IronPort-SDR: woJDB8AOx3ATFXi//Oe8RP/DZluDZDRqtzCMU1DF6Nrw3OPwOPP8LnCNAoZXszCqI2pnpYcmQu
 OcXsu8NYUP3wGGTjWXVW/kDQgTl3JSibZ42V8Ti7n3UaIh1+zm8USiVYEZiy3LmTulC9ATG7h3
 lfinuVMgMBgjDPLhI2NOyRHnvGrs6Cl8jZUpsMr6e8SD6Vx0yDvYaIVAEl8fp4bMciZk0kfxp+
 Tvmdql0RQZlBLiyFCN2fJe4l8I3stqXa9YPGhXE3CSujypol+JCLRu0RxPTN9W19ZPUGowaTBZ
 Dhg=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226411935"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:01 +0800
IronPort-SDR: dOa4KWmbd+MYltrt0uuC7ctViy/cu/bxwG/3vbe0B6ma3Um8+c9/KM9sB83uNT6Lf8hby5Qgbo
 DDO+47jsBF6IEd4lv+xHpmjznfreBxtyRDar+IDt4dcr58pWyjA6fYhIoHeP77yHGi8zF9dS2p
 wLYNHBSlcoSfLjtzH32b0Ls3QxtS+waj9DgQahBBzvqLu3ilqRd1/IcZwMUMMYZTsSveyl8pGN
 Pq83iFMioHg7pOyyJhGjuLwMOoIl6gh/t22hPz4MYqNRKNkFHsHHDPiN712L8/XAuNkvVuR6Sm
 eTeWupMThCNo8z30gplAvMoA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:10:59 -0800
IronPort-SDR: 43bvn2/1mRF32MpeGjp5uVkRDValEtxZywZBbyiiJXyCRlzFDLM0xeY9Dnp786trlQrfNG/w1g
 NRMzAKOAMrc/nd8JjiDT23cy2gO60yL0EIb+KuiCUCXb/9YiqfXOOq19lsNYWbaoR7hX3CyYgP
 eDEx8ldF9aZu4mYfR03ugIwdb/jPaY+LXstoWnwYSdSMp5Q6QY/ZmL/n1f+rk6aPfIAKVKdvUc
 5GVFBt17mlWcJhmvKhAlVYuA75Y3L16fdQieZdvxOw4YXo+H3GybcIiD87sOuPirlLTIfZOAvC
 CFc=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:43 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 08/36] target/riscv: Add the force HS exception mode
Date: Mon,  9 Dec 2019 10:11:01 -0800
Message-Id: <ad8c1b0907683bfbe85894e18ffb895b23db833d.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a FORCE_HS_EXCEP mode to the RISC-V virtulisation status. This bit
specifies if an exeption should be taken to HS mode no matter the
current delegation status. This is used when an exeption must be taken
to HS mode, such as when handling interrupts.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_helper.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a73292cd20..21ae5a8b19 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -273,6 +273,8 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 2cdb0de4fe..ad6479796c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -432,6 +432,12 @@
 
 /* Virtulisation Register Fields */
 #define VIRT_ONOFF          1
+/* This is used to save state for when we take an exception. If this is set
+ * that means that we want to force a HS level exception (no matter what the
+ * delegation is set to). This will occur for things such as a second level
+ * page table fault.
+ */
+#define FORCE_HS_EXCEP      2
 
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 046f3549cc..b00f66824a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -100,6 +100,24 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
     env->virt = set_field(env->virt, VIRT_ONOFF, enable);
 }
 
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    return get_field(env->virt, FORCE_HS_EXCEP);
+}
+
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt = set_field(env->virt, FORCE_HS_EXCEP, enable);
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.24.0


