Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB71CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BDA20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="feQ0hQs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BDA20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKcy-00053r-GM
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUE-0000hD-Gd
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUC-0004Pg-LK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586448; x=1624122448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oVrn5w9HfRb0TvrN5CP3m58pdTdH4CK0+0WfxcCouCQ=;
 b=feQ0hQs6tQUwvh6IvKh6CC4w4fGhVVQ6u2IaDUv6T0VfDD7rVmO/h10u
 bPJvKdOboeMbpQ1AQIQc4JIngNz4mtFySupl8J2JSveW3b/jt5gSGzXfC
 WUjYaRTApwro3qzzKyGQxSwG4A5tcaGJcshkUpbxS7s/IVUK/6BYWlmf0
 gfHOmVVb9cMLYHzv4AoCNh8El3KXQ5pumlzDaGhuW6iqtkvElPzkzmYq4
 ZmS/XdRBS7jOrl5ihPgSrkNOI8Of9b2atpKYyX4EoenSMYMtOUI/sfoQq
 E1K3Z6W48xSMGyCwZpugWuJOkwVloPtx4rgzHEWgtrhvQUZPVBKLXLCAV g==;
IronPort-SDR: hax4ubTb6bcg8HwMqaP/4iq9pBld8qm9gUaVpbsoR0abkBiJqQ1Kq+flTCf20b4BLwRbRiN1Ef
 DT7n/KYKMZjUxfnD2+SZ9qhing00oGdBiCMiTr8DkAuxdnoAZNmJuAX0wWL8f7/ClA3uDfPvwI
 /xlf2Z5+vWWD43XbVfeUZS2+l1TrBrLKawYjUX97X8gPrP32AvVA5LvRV6RA3GAuOZF1/PxSxE
 087knH7YyqvDQ9llHFYhw6XJrYhglnKGJUIdHrGSkAjxHFGzwYnKPGCWe4okQKoUzJFC+/GNnf
 b3Q=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="144763311"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:22 +0800
IronPort-SDR: FFVX2v67vxl4NozG2NFAAzWBO48v6mJY1EI9kXqfSI+si5EJ/gnXgAvhII6fEFyOCY80dhwhcw
 xQZTixLM1ZI02gqRzSTD8zgGm8LqB+byc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:55:59 -0700
IronPort-SDR: vejzWv0e42uTZaiMvqBN8CU5X9FrMFWNU643yjOYl2eQGtmQ8p8L+XeOB8HhrKo6VLlrndw6QA
 6I9VBXtVfM6w==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 05/32] riscv: Generalize CPU init routine for the imacu CPU
Date: Fri, 19 Jun 2020 09:57:50 -0700
Message-Id: <20200619165817.4144200-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:21
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


