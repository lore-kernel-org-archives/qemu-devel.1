Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A50C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC76920809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mx9n/9Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC76920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAvs-0006Sq-5b
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAcN-0006NM-8r
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAcK-00028T-7o
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548512; x=1624084512;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XFycwSO9qzdy5CvQYiFPd6ixTzOZwZsHnYky1OeqsuU=;
 b=mx9n/9ZeM4JvadlK0qmTPgUjKIfx14msDCavp8o5JwaUJ4ToOOgNmF50
 TCmE/MRRnCrI0iWmbEforSAtVmtARDSXCya1WpNFqScXqPkcEYTdhn34g
 /NpVqoOsjBNiHJwEPQr74sIWzq1jhXqGMcEPtA+aQpXHfGlYalzHX6ntn
 DZb4hNgOlrimvbo8ivaJZ1LcdQmckxOqWrddigFnLYARbJ64Rte+tkOin
 KrV0tGJ7OgxWMEksoUvmcfqUnsydiQon+7uay2Mq+Dma1VU2VZylNGGFA
 ZFJUHKHsih/zGIO7zuvM9OyofekhASHt20yL6OdajwHL8GyjlH1tj3ziG A==;
IronPort-SDR: cq++klMS24lOd0kBeGOS4P6z9C8AVRqTF6fXrV2hQOHaLW3wljUdm5cSfP/8b60D/EoaJHYMTe
 ATUYUJIcJaBHEyfVz7B3YWTwn4vGHa7Hr8iylDq3Lm38gZhuwc5O5orxjl+lblOzHHoSujbQG1
 3wmzktnb1biVMhIRQVXh8DjoU6VOp8TOOauxiQCKF4tv3hqeSfQ2y0ozyR2fdX5Hy+rkj4zSPo
 EYPFqijWg/MW6A4M0HVzkCREEGsEtrzoxMvdIFXDAWH9d+PUhNyoMaGkcS5XNVcYLNyX4oTYbT
 bgc=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781950"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:33 +0800
IronPort-SDR: AmDR975wHZib/8N4+n7qppfIxWjVahb33K+gL6cGG/Iu5ryK6Y0nUd9L2i2MFHgMu8/Zl7x7Im
 VE+Xh0APMdq3lEzTb4rEO+WdLYfZHXm0c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:44 -0700
IronPort-SDR: /styWUObYYGBEG0aV49seFhGrbaMg7WcYUI1KQkOLRLsh17nRd+0aVppxa5V3zNPqGyC+J1mhH
 4cfkUrH8S9qw==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:32 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 29/32] hw/riscv: sifive: Change SiFive E/U CPU reset vector to
 0x1004
Date: Thu, 18 Jun 2020 23:25:15 -0700
Message-Id: <20200619062518.1718523-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Per the SiFive manual, all E/U series CPU cores' reset vector is
at 0x1004. Update our codes to match the hardware.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1592268641-7478-3-git-send-email-bmeng.cn@gmail.com
Message-Id: <1592268641-7478-3-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c | 10 ++++++----
 hw/riscv/sifive_u.c |  6 +++---
 target/riscv/cpu.c  | 16 ++++++++--------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 01626820bb..0cb66ac4e2 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -95,14 +95,16 @@ static void sifive_e_machine_init(MachineState *machine)
         memmap[SIFIVE_E_DTIM].base, main_mem);
 
     /* Mask ROM reset vector */
-    uint32_t reset_vec[2];
+    uint32_t reset_vec[4];
 
     if (s->revb) {
-        reset_vec[0] = 0x200102b7;        /* 0x1000: lui     t0,0x20010 */
+        reset_vec[1] = 0x200102b7;  /* 0x1004: lui     t0,0x20010 */
     } else {
-        reset_vec[0] = 0x204002b7;        /* 0x1000: lui     t0,0x20400 */
+        reset_vec[1] = 0x204002b7;  /* 0x1004: lui     t0,0x20400 */
     }
-    reset_vec[1] = 0x00028067;        /* 0x1004: jr      t0 */
+    reset_vec[2] = 0x00028067;      /* 0x1008: jr      t0 */
+
+    reset_vec[0] = reset_vec[3] = 0;
 
     /* copy in the reset vector in little_endian byte order */
     for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ec5cfdae62..2a8c8c8829 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -430,18 +430,18 @@ static void sifive_u_machine_init(MachineState *machine)
 
     /* reset vector */
     uint32_t reset_vec[8] = {
+        0x00000000,
         0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
-        0x02028593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
+        0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
         0xf1402573,                    /*     csrr   a0, mhartid  */
 #if defined(TARGET_RISCV32)
         0x0182a283,                    /*     lw     t0, 24(t0) */
 #elif defined(TARGET_RISCV64)
-        0x0182b283,                    /*     ld     t0, 24(t0) */
+        0x0182e283,                    /*     lwu    t0, 24(t0) */
 #endif
         0x00028067,                    /*     jr     t0 */
         0x00000000,
         start_addr,                    /* start: .dword */
-        0x00000000,
                                        /* dtb: */
     };
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5f034588ec..391a0b9eec 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -134,20 +134,20 @@ static void riscv_base_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-static void rvxx_gcsu_priv1_10_0_cpu_init(Object *obj)
+static void rvxx_sifive_u_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
+    set_resetvec(env, 0x1004);
 }
 
-static void rvxx_imacu_nommu_cpu_init(Object *obj)
+static void rvxx_sifive_e_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
+    set_resetvec(env, 0x1004);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -578,13 +578,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_sifive_e_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_sifive_u_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvxx_imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvxx_gcsu_priv1_10_0_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvxx_sifive_e_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvxx_sifive_u_cpu_init),
 #endif
 };
 
-- 
2.27.0


