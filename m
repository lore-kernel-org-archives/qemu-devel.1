Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C77C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0136B2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OVpe9l8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0136B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKC7-00046q-5a
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:05:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK4A-0005Kz-IE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuX-0004BK-8P
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:47:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuW-00046f-T4; Fri, 24 May 2019 19:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741662; x=1590277662;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=Xw65e62SJqBKkrt6W+qEPmpcUgZUUv62LCp3vTlHgCc=;
	b=OVpe9l8HRnEg2cVd/un5wPW7s2SYif12D9h1KBCOEwClXORGdSFhGEQt
	hM6PpGGPB3O5Mjl2i/pmWbwoa5sDC1z7/w6szLGXEtD+ty0Ktd/VTaBeB
	TyBWlVdQVTdUReKLsT+MIKcUL95bJ4pRzjHINFirSEeNQn0MGshQ3szg8
	cQToahnp+qXHGxaj10AAsd3LC2pb6XdFkev80pd3O9jYKrgm+B+7Pp8U9
	JrF1CSCISxzfQqr5FwIb5eVVSiFRUeKtIzKv8NTzxAr9/Bm40uzyRix30
	BWbf2lHT1melu8b/mIEzznweWliO9pI3UmWKICYx7XT31CDiEBz7N652e Q==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="110307760"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:41 +0800
IronPort-SDR: lujm9HuTDf4IWAab1+4lRwsxKkl9RHqMFahMmliPC3k8X2qCeeQHC4CAbMROECviYtk6Om2u4v
	gyG2u6xs/u+85tgGMeP9Dn42LjgiWPZO+j4gfXkRfZ3cQvU4gy3d2FM4y2EPAuAMElK59lRFia
	PWWRdpDwwhDQrhGZOHMU6IqjFz1CjHXx2hvSXeE24YYHOYjW1NK9VFqxLYgmy772hB4s0CrLQo
	/m5XVYDrLepZ+kXTpHx6Z9/pZmRC9ewIB7LDy2url03EjqLB4AUuWDXQ+4VmZOU6pGzjmM2RWw
	cRIzu1KNEMJFaG6wfoB4c/RD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:19 -0700
IronPort-SDR: s2VEP5u/QsOkKWltn0Y6IhjEvGc3MJtx6nne7i6/+tM+HkEBYvey26GfylNno9Wt9Fe5QKn61N
	8wlc6Uyuo2+b5JjN/62iIdZAEV8TDcOKJuQKs71uxo55dNdkKLtyUbh3e2NIH0whqeYp+9idUY
	wPsf7hJFiqr0PahIo8vEeP826w4gILTIsM3vuuSRq+m+gCllLrUSUWOYoCsuHeK0GvfGF0awd8
	aEsPM5597lm6SPudxVa33+/kW78LtlGCg3xU8VdBI90OBLdjPrfMeerWk5LPtYetbBOW1JvWpE
	wls=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:47:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:45:45 -0700
Message-Id: <db2e5b1f9aca229af8dbe647c0921e5f44f32058.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [RFC v1 04/23] target/riscv: Add the force HS
 exception mode
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  2 ++
 target/riscv/cpu_bits.h   |  6 ++++++
 target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de4843b879..eeb3756c91 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -282,6 +282,8 @@ int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 07c95e8d2c..c898bb1102 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -423,6 +423,12 @@
 #define VIRT_MODE_SHIFT     0
 #define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
 
+/* HS-level exceptions modes */
+#define CLEAR_HS_EXCEP        0
+#define FORCE_HS_EXCEP        1
+#define FORCE_HS_EXCEP_SHIFT  1
+#define FORCE_HS_EXCEP_MASK   (1 << FORCE_HS_EXCEP_SHIFT)
+
 /* RV32 satp CSR field masks */
 #define SATP32_MODE         0x80000000
 #define SATP32_ASID         0x7fc00000
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5912ae63b7..0fdc81f71f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -94,6 +94,29 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
     env->virt |= enable << VIRT_MODE_SHIFT;
 }
 
+bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env)
+{
+    bool tmp;
+
+    if (!riscv_has_ext(env, RVH)) {
+        return false;
+    }
+
+    tmp = (env->virt & FORCE_HS_EXCEP_MASK) >> FORCE_HS_EXCEP_SHIFT;
+
+    return tmp == FORCE_HS_EXCEP;
+}
+
+void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    env->virt &= ~FORCE_HS_EXCEP_MASK;
+    env->virt |= enable << FORCE_HS_EXCEP_SHIFT;
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.21.0


