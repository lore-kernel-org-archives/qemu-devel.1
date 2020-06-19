Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA99C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFAE214DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EX1S/uCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFAE214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKWg-0005Vw-8f
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUD-0000fi-E2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUB-0004PR-9q
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586447; x=1624122447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VU9o6OYV0MkgJqJ+P7yL/zRcCvBETb4yUFY3HT80i6k=;
 b=EX1S/uCarhHy1ygo45RbSwBiIAAy4qSdQm4kLQ8WjTZtlsfZHHc2gqOp
 3EAzZHuDxBALQ6YUU7+8TaiYXRaCmkHvswSM3ix+OTxpP41oGpOaX3DYq
 S6ZndqO2nS9sVKaEqppxaDOdzo75FXGd4IXEh/i1ZnMmBfD+LN+gl3lvv
 Eqt6JWzMj4DpbKEQsLC8pm/0vl+m+Fz3TLlqRWI/EoU4y96PbYLUC1FK8
 TzJ20nUg8DqPPd74uHs43vdzSFIPxlcGzKz4jTmV4nEUPUqeU2g51+BYZ
 Zosr6tntqIiRcY5fzCNWLhQCDRfOT6l9ZPAAKJ1hvlOu8JWJ2yXetVUVF Q==;
IronPort-SDR: l71BXK/rnGw/I1KLwHcNG78hP3tlUE3Q+mNTFcBbRFNai6aK8LUAnYltQZKOXunD2fMG+YLZwD
 5ETIpKqozFYcnlGmuuXTxfFkQX5xpWuw5B0Upi6qfKmjv0p+D40YkBw8W/ffvclZY/bpeYNfGK
 SUxBoPaUSaSyjNI4XFjUNOLcwfuR6uDWBCBti0yqVhzsJmkEXN+smsXWsjsSswXJSSbipCwep5
 A8TzZTWpNuXPL2MMtw1OjlZ2TUE4EoMn9NuRgTFbxrr9CtTO/nXUJN9X5AiIheWL5tMVLOh5l5
 eOA=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="144763304"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:21 +0800
IronPort-SDR: CamgmRcIaeXfCpsTwDgWSyXeuDoJBVRpUQ99uBm0btUq//37G8cRNxO31ugBeJ0+762U4kYHXL
 Me7OnNxG12Sh/Jwov3Vg/5/lk4ULgk0ls=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:55:59 -0700
IronPort-SDR: NslU3WMGBYWaUDXrA6sWAmVPA8sz07BriKgxT+snsoYTvZrWMupanquYGHt5+Z3+Z5JDa3oXWY
 pZ6AawrhIA4A==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 03/32] riscv: Generalize CPU init routine for the base CPU
Date: Fri, 19 Jun 2020 09:57:48 -0700
Message-Id: <20200619165817.4144200-4-alistair.francis@wdc.com>
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

There is no need to have two functions that have exactly the same
codes for 32-bit and 64-bit base CPUs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591837729-27486-1-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591837729-27486-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3a6d202d03..81cdea8680 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -126,9 +126,7 @@ static void riscv_any_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
-#if defined(TARGET_RISCV32)
-
-static void riscv_base32_cpu_init(Object *obj)
+static void riscv_base_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
@@ -136,6 +134,8 @@ static void riscv_base32_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
+#if defined(TARGET_RISCV32)
+
 static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -173,14 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
 
 #elif defined(TARGET_RISCV64)
 
-static void riscv_base64_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    /* We set this in the realise function */
-    set_misa(env, 0);
-    set_resetvec(env, DEFAULT_RSTVEC);
-}
-
 static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -603,13 +595,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     },
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
-    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32imcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
 #elif defined(TARGET_RISCV64)
-    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
 #endif
-- 
2.27.0


