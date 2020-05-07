Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC4C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCAC208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IdIf0P89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCAC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWm4t-0006r4-Px
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm3b-0005KV-JW; Thu, 07 May 2020 15:19:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm3a-0001c1-GS; Thu, 07 May 2020 15:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588879225; x=1620415225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JD/vYyr6oWYsn/kZY6r2A/nm1zGVZ8t2uZ3IwlLhVTQ=;
 b=IdIf0P898RKxE0PyjGCF0YuzWUmig1pS7UZsdRWb700orR8ZbCpr14Dd
 JDmLIjIi8EkHlPEe9sF+LHXwsyKVBQHfq/poi+N5EPWI86pchPoCWSvJy
 q+7Puk2f9WwPSO2E8BulgHm+tYmtOabKiRCoH4yfC46VvPLKtAdSsnhQ1
 vqOxtes9CpOXrd2tmfnwLe2At1cMVeDYQuBzwPPmKW3FtqzenyUgI1OjY
 nP0PmX1/X3jSES+MCYQ5uLHdpv13LK+ChvPFJEkPkSuH9/Fm52RzpiO4R
 fBIK0rdOpbwpeByf34/9rsMJ11IMXxB2HLEC/bNmMr0ASgoMDlNEp9ADv A==;
IronPort-SDR: tREH/1hbldzlUQvTh9fg4fzQ1OfPBNeCHNFXo9ERL/Kv0Zy0Bf/ibAmjEUp++T8RP1W25ZYnKx
 B8nZabETFw+c9gM7HZAkZDY/Speobx1eLw87ulU2hPr8Wbab8wAAxAMuG13P9zNeoU6eUL9nkL
 rVyXQnzf3troKBBW1Lm2ZcOOFqbwK4BiI9IMIhyQDMr5BsjprwCXgVVDQEBat5m8PayaJuYFUV
 hfa8HwaKfjvTRAzyLeA6ZcKP3hJBYQuVIEWasj6A/oOVQs2h1mosTyvO+sAaGaTBsmQ7oFLCAv
 fqA=
X-IronPort-AV: E=Sophos;i="5.73,364,1583164800"; d="scan'208";a="239807073"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 03:20:22 +0800
IronPort-SDR: 7VyVC5O2leQkr1QkdOAUyqL0T0I6DoYwOFWQE/mOr1GodCUGvXGZPSR8Xzu4Mzyj1vGoU2dfhg
 scyE4apIqlqkunS1CgwoXfR3fUOHHcFn4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 12:10:03 -0700
IronPort-SDR: Vb22lpVCJ5CnPJGulxuwmP7EeYWhcIiuSWM1sM6itgWcZ9dfI1LzxnSbxCr1U8lKqrMPlf+CzN
 +aMQYrIfrQrA==
WDCIronportException: Internal
Received: from uscxm6l72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.6])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 May 2020 12:19:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 2/3] target/riscv: Remove the deprecated CPUs
Date: Thu,  7 May 2020 12:11:20 -0700
Message-Id: <7316f5f5fef7314dfef662862eba93cdbed4ddb9.1588878640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588878640.git.alistair.francis@wdc.com>
References: <cover.1588878640.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=38990af3b=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:19:37
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c              | 28 ----------------------------
 target/riscv/cpu.h              |  7 -------
 tests/qtest/machine-none-test.c |  4 ++--
 3 files changed, 2 insertions(+), 37 deletions(-)

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


