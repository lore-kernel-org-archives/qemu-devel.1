Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2552C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD0421655
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qFkVqRiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD0421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JDz-0002UE-6n
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBa-0000XI-5a
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBY-0008Sf-TY
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBY-0008SJ-JF; Fri, 23 Aug 2019 19:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603697; x=1598139697;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IHAr6i8MPjYtCWcd0AnEateuP1Thwzh5uOKLFN0AYFI=;
 b=qFkVqRiJZilLx7E14xmo3/EEzn7lz8UEe7DooJQsgpo1ZsTdUjRmPoEF
 cR13Ncht4yW7CqPc761dwCzdVCnhxTdtDnQoe1wz5wahTnrbTVbMzKBaO
 +MGtZtf8Zm9Zs9v/BBpsb+JxDjCrfp6ZtSERsVtWEB+1Y9vsB7xDmEJzz
 uEv5XdGPE52VNXFzp2e0UASy8mLoiHsBSfIHHROGH+l8KIafRpQXYx8Hg
 uOb7yiVd50bSBo/hDZm8pL8X/VwkOeQtujA5n3EGX8B7aPXEbz50wtkQZ
 o5mPya4iu5afTKEMQjjFszaV8WEG7syxeYaUt9tMmeyOobdolle5EAQoZ g==;
IronPort-SDR: asHZ+Gp3zdZVb6pUUYiTheOrQRzBuWejVRShS9UyFbzzrG5ZsjXpk/FP9A3nPasKar9q0Zg52u
 qERGcMm8TFaxyZ7MlipJGAcn7CxAEyOKD86FrqDGrXmh6zHSq8xdW0jqKhVfTP0nMwx6PBAJcp
 hkUO/dCGl0RLtvvBaToJyCArREnKUUUcC6VoNnTQzwb8SXBP3oZYQkcfmjLEbO4lLs0I0eEbor
 byt2sFmNgeMRw2vHbeRO7y1EXiJC+7deWDL50+/1z8MyFl7TCtamG62ikKBkPspkgPh8PMFN2X
 0NA=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="121144251"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:41:35 +0800
IronPort-SDR: 2sR6CFVaUlAyLuvYUtXi2S9ECGvqNUJBSazUmM3UyFUps1e5Rx+Bq4xj5XxwLQ9/9aKdJirMYI
 2KQUQTfhVlehwgkUU0/hoXVTvnLaH7xUA/8BeSLQEJJ1NrC3O2YbB3M+93apc6042pKtxCvrcR
 q5rsooZw64IfPtJB4eY/n/MgtIodQJQSE+mGtLefVthF4W8ciqHVQZvCa6doHponFYyReVQDMx
 dZqf7Yox4BClKvSlnD3YMTJcbmKM6U/7394ztNKqtAxpZ2YUbeDBbAfmUp/w21bgub5KAZf/He
 TvR+vO7uTskqxI5tKJVjZxeA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:38:52 -0700
IronPort-SDR: DgzDMaWpm6z+L1OhEx521lMQBi3FfvUp3IcY70crlggfiD0a5XC+32WdGpCSUCtKs7ly7YfamB
 8P+xto4QuSk9FF5zGLjW04DO6mXINXmhS5+bqElJgypbLhFtNzq31lOyko0NvrCMBgvdf7Z9AT
 bZEyA6gHzw5F61hkblieKz1rdAzanS3e3DhiXOsrL5z53BCeRfILR6dkK8ZCo6rPdEFCUaiq/I
 sk6PfO6Fek9bZ3thEnjJidgeVkV/eqjOAYvcTWaSUo72oKunC903zjx5M2BZzSq2V7Ilwdum37
 094=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:41:35 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:37:54 -0700
Message-Id: <1c1d359caa6633349158debc38e07156a10b63e8.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 02/28] target/riscv: Add the virtulisation
 mode
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  4 ++++
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7f54fb8c87..0ef1ecb0e0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -117,6 +117,8 @@ struct CPURISCVState {
 
 #ifndef CONFIG_USER_ONLY
     target_ulong priv;
+    /* This contains QEMU specific information about the virt state. */
+    target_ulong virt;
     target_ulong resetvec;
 
     target_ulong mhartid;
@@ -257,6 +259,8 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
+bool riscv_cpu_virt_enabled(CPURISCVState *env);
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index e99834856c..1fbde516be 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -422,6 +422,12 @@
 #define PRV_H 2 /* Reserved */
 #define PRV_M 3
 
+/* Virtulisation modes */
+#define VIRT_OFF            0
+#define VIRT_ON             1
+#define VIRT_MODE_SHIFT     0
+#define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 225e407cff..7b0bb14c01 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -81,6 +81,29 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
     return false;
 }
 
+bool riscv_cpu_virt_enabled(CPURISCVState *env)
+{
+    bool tmp;
+
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    tmp = (env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT;
+
+    return tmp == VIRT_ON;
+}
+
+void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt &= ~VIRT_MODE_MASK;
+    env->virt |= enable << VIRT_MODE_SHIFT;
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.22.0


