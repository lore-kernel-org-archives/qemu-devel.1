Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E064CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 22:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2B82075F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 22:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nN1tW9DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2B82075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdiV8-0001qc-RZ
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 18:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=408db4441=alistair.francis@wdc.com>)
 id 1jdiU9-00006u-H3; Tue, 26 May 2020 18:55:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=408db4441=alistair.francis@wdc.com>)
 id 1jdiU7-0007S2-KF; Tue, 26 May 2020 18:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590533747; x=1622069747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EXnkwL9IzxEIbZp7uYbwSmU4EdCEmVv+hsIZBp3KKsA=;
 b=nN1tW9DV6/Y+Sg5Kk0o01WjD/p5pNGJfGglCw2xdOAvn2Dspd8SXA8Zd
 2quyBsTGhFyNU/oLTFi+0w2ObNGrdpoe7en8RUlXoR38hmmPWs4xAn2tj
 ia8zUJ7GivbxZzm8Jjs1f22v2S8RZP4gHJOaD7Z62Cb9UvMHku1Z7jYX4
 qKFrXZpQxtokE4ZC4AOk1p3bhUz1GeIF8edPZK1WCg+Z6yYyPh0cYSTYb
 MXynC/+4HZptoVZad9ucOJWA2JM13kvAphBDzauReGyQK9mkb/dW06fn9
 NOoGXOaXfubwspajLj1GJ2twUkUGqDjDxb3JQlzLRmBPHbevKcENyNW8a w==;
IronPort-SDR: Q14Mu6JGNeKBOG/WhPBrh+UWexrKzd0LKhy5+R+2LJW1+nH8ROlRXESApW6Qhv9RtjTaWIp6ZS
 oqRvXpZn6lF4nAhtJOIsfzON14CSnMM/5rzstTe/m8u/7PUtUTXR5lKDA9PaA/HJbD0e6YM7mE
 x3/FvFGuhevCNAnBYBdGz08upXX6yBbdAtDxwIgw/LRB2toN9FYzL3oDMRsXUzEF5TyP8h/fAq
 pi44SkAyuaNfdT+XS/XmqZ3uOiUJX7bKgL4rSCnm74cbt6keOzZHu+MUc592O76s7H+yEB1wwb
 WP0=
X-IronPort-AV: E=Sophos;i="5.73,439,1583164800"; d="scan'208";a="139996089"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 06:55:46 +0800
IronPort-SDR: HDZ9QNCOcd7QruBZyMa6lJNXVGZeXtzy928lQDORPt0EBHTmPG+aPfRVEkkeq+F3LbpCR1MYB+
 melGdidcmB3+Bw+cOVLbm4MTqUh2XxpDo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 15:45:38 -0700
IronPort-SDR: NgtkxFQsvuAZCCnlK3J6YxgeYvISwOsCKa61foDOik72RdNYJLkMrTtH3vZ3zcRcHDXxCNRZeg
 AXwbeMCtvwCw==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 May 2020 15:55:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 2/3] target/riscv: Remove the deprecated CPUs
Date: Tue, 26 May 2020 15:47:13 -0700
Message-Id: <2bc9b06378f6547e4a88e70c694005e4a42db3b5.1590533156.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590533156.git.alistair.francis@wdc.com>
References: <cover.1590533156.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=408db4441=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 18:55:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, palmer@dabbelt.com,
 bmeng.cn@gmail.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 target/riscv/cpu.h              |  7 -------
 target/riscv/cpu.c              | 28 ----------------------------
 tests/qtest/machine-none-test.c |  4 ++--
 3 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0e7f5b9c5..76b98d7a33 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -40,13 +40,6 @@
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
-/* Deprecated */
-#define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
-#define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
-#define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
-#define TYPE_RISCV_CPU_RV64IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv64imacu-nommu")
-#define TYPE_RISCV_CPU_RV64GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.9.1")
-#define TYPE_RISCV_CPU_RV64GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv64gcsu-v1.10.0")
 
 #define RV32 ((target_ulong)1 << (TARGET_LONG_BITS - 2))
 #define RV64 ((target_ulong)2 << (TARGET_LONG_BITS - 2))
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..112f2e3a2f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -135,16 +135,6 @@ static void riscv_base32_cpu_init(Object *obj)
     set_misa(env, 0);
 }
 
-static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_priv_version(env, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
-    set_feature(env, RISCV_FEATURE_PMP);
-}
-
 static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -182,16 +172,6 @@ static void riscv_base64_cpu_init(Object *obj)
     set_misa(env, 0);
 }
 
-static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_priv_version(env, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
-    set_feature(env, RISCV_FEATURE_MMU);
-    set_feature(env, RISCV_FEATURE_PMP);
-}
-
 static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -621,18 +601,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
-    /* Depreacted */
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init)
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base64_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init),
-    /* Deprecated */
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init)
 #endif
 };
 
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 8bb54a6360..b52311ec2e 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -54,8 +54,8 @@ static struct arch2cpu cpus_map[] = {
     { "xtensa", "dc233c" },
     { "xtensaeb", "fsf" },
     { "hppa", "hppa" },
-    { "riscv64", "rv64gcsu-v1.10.0" },
-    { "riscv32", "rv32gcsu-v1.9.1" },
+    { "riscv64", "sifive-u54" },
+    { "riscv32", "sifive-u34" },
     { "rx", "rx62n" },
 };
 
-- 
2.26.2


