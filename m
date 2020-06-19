Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423B0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F834207DD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DPyoI6GY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F834207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAki-0003St-7y
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbl-0005Yg-Lb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbj-00028J-LR
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548476; x=1624084476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oVrn5w9HfRb0TvrN5CP3m58pdTdH4CK0+0WfxcCouCQ=;
 b=DPyoI6GYXclJ+LACt6jB/cLyvrSRNdm8sfr+8OhGvqTxj5i9qzMPLdjN
 bIVCalg2A4iLATaKc4Rv+8KAvHacI80MhSjkEunmKko15lgA2aTo/90WZ
 VDW9/7ItBeFkkkWGp0AC9N7wEuK09wd9XoOgNJ18z+oTZUFNwM+mwoxIT
 FfjCw81pIehGpYlFJnJj9CI0pHBRWOqSOrUkLmdME68dSHj7XeeGyQSFj
 NFNYSlsrm5Eu3j+JDz5cx9KuK9Lcd8ImRjY+1YZ998meHj7xm5t5HcTHH
 Eqzl9Pys4XzTzmbu/8ONKLRsw+ObaZD3nY1rWHIqBAWk8zDz5DByn3x6D w==;
IronPort-SDR: eCaVqqlSahQ7L6kfdhFYod6rdl8tfJIN1mb/2X8DFnYTJ/TqiHZ0gkmNzWppVDDp7qV3eRtzxw
 7S96WZ55Y9Pw8sPocc+FZrJhCChlGCb6Yuw3wqDyZhE/mtDv3tDtFrOeAB0bM7+f8k4T8Y9XYj
 7HgWGQXmTjEw2tgzeDyUsXfPLdrn1ZRf3Eyqnfgj7vqzjzhYyGaTnT0yLuHc5U2f3zHAd5pnyl
 liUNayaOx51DrMIzH6CtFzV8gGnQj4/b8VpbFKHLYuPD9j56hMSG2XUj1uyyPmNf8z/6vEF3pk
 ulo=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="144724282"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:27 +0800
IronPort-SDR: ibxYzGv5RgSY3RYnf4ucQHhNCpswVbkTiI+/MGTd0PHZUGw2BNV48+fpPAVVq87VKwdE2hS/jK
 gCkmmUyIbCYXE6E5pWukTmt1VzNrKAYwo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:38 -0700
IronPort-SDR: EcSwOho8vTgfUNSK7KqPePo9Pv7EkAMBWI2PVqMpP6hbFsUfCF3Z9I1IaT3kuRqBDt5MEYMOXU
 MSfoq5zboezQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/32] riscv: Generalize CPU init routine for the imacu CPU
Date: Thu, 18 Jun 2020 23:24:51 -0700
Message-Id: <20200619062518.1718523-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:26
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

There is no need to have two functions that have almost the same
codes for 32-bit and 64-bit imacu CPUs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1591837729-27486-3-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 437e141ef2..35a8c7853b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -142,23 +142,23 @@ static void rvxx_gcsu_priv1_10_0_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-#if defined(TARGET_RISCV32)
-
-static void rv32imcu_nommu_cpu_init(Object *obj)
+static void rvxx_imacu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
+    set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, 0x8090);
+    set_resetvec(env, DEFAULT_RSTVEC);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
-static void rv32imacu_nommu_cpu_init(Object *obj)
+#if defined(TARGET_RISCV32)
+
+static void rv32imcu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
+    set_misa(env, RV32 | RVI | RVM | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
+    set_resetvec(env, 0x8090);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
@@ -171,17 +171,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 
-#elif defined(TARGET_RISCV64)
-
-static void rv64imacu_nommu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
-    set_priv_version(env, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
-    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
-}
-
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -589,12 +578,12 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvxx_imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvxx_gcsu_priv1_10_0_cpu_init),
 #endif
 };
-- 
2.27.0


