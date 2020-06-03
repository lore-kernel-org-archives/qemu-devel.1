Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1868EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E6020659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cTH4zhn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E6020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWJ4-0003oi-3P
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAH-0007kX-8q
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAG-000625-1P
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591201372; x=1622737372;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Fgg3345956zxk99n2jIXknf1y0dvGyV+F26ZZmZZlA=;
 b=cTH4zhn+jRBsqxJC3yeZhvhhsYFeCg2idW10OndTVYVlie72NS8WPvCi
 ljTFS1kghlNzef4EluO83W5lOrOihHt9QfNCHOAeMJ0TztWyKWnQI46mB
 RRWk20MH+aaipXrytlWs1xns9w8H7BN9ddhrMInR6aBmBxZrLYGCehgIW
 ielCrfAH3eDgehmweHKlPfA7Og7xXbgaSIkkt6s04MtOvYHJ7DwnxsamQ
 FQEniYjVDStmemBc68ojpj+7olAMqYC+7IsrEedIRwn4t+EqnzgDpnTMP
 EiBrO1r8EbpUIO8myU66dWwvxjoX4KLx7L7p4G6BgZiPWdcI1F5GCQGdV w==;
IronPort-SDR: f0KAtwOifeEqydTVgnZCJA+7bpmUMFVXu7d+hjxyxIEuRm6gPhAT/+Ee9hcxTYqxPNkiBTMdtn
 BrDZGoIbKauxfQRduCUrZ3MOBtL7JOXZU6QOlRMTQvZcoxRYg303Astd4a0DLLKxvSLBDaUwNW
 MwcM2zjBN2evfG3Y/rmI0ZrWK1Wr+f9w6haRZuzL+GLea5dBYs/wmZjCYNAf7Svg3I/LKuAlMx
 riX2elC1F5ohEXEM8sGzcz5ckMzxiyBJa+TXRoUCCXtf9xIrPC7P8UWyzbr9mKJKU5IRpVs8ah
 2bQ=
X-IronPort-AV: E=Sophos;i="5.73,468,1583164800"; d="scan'208";a="143451365"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 00:22:42 +0800
IronPort-SDR: hF04aASCRbQ5u1yXyyfBVkkVkj3Oo+nU2ngtIPnswKdr0weAAMwVeTTHIfv3oE5EezBTxfvcqm
 bNi+dHcr4pkC7MlWCvhB//6sYVj/fXPOU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 09:11:47 -0700
IronPort-SDR: gTrNAOaiHCsNwEHUNG85rreKH1WQSf97T4iUVOk83wT7JdMFeBSCjy9iZkgmAeDjYfsb5OuC9I
 BcZxt5F6+gmA==
WDCIronportException: Internal
Received: from cne220230.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.144])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2020 09:22:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 06/15] target/riscv: Remove the deprecated CPUs
Date: Wed,  3 Jun 2020 09:13:49 -0700
Message-Id: <20200603161352.744204-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603161352.744204-1-alistair.francis@wdc.com>
References: <20200603161352.744204-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=416cc4bc0=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:22:40
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 docs/system/deprecated.rst      | 33 ++++++++++++++++++---------------
 target/riscv/cpu.h              |  7 -------
 target/riscv/cpu.c              | 28 ----------------------------
 tests/qtest/machine-none-test.c |  4 ++--
 4 files changed, 20 insertions(+), 52 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 50927bad74..bb14de9848 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -314,21 +314,6 @@ should be used instead of the 1.09.1 version.
 System emulator CPUS
 --------------------
 
-RISC-V ISA CPUs (since 4.1)
-'''''''''''''''''''''''''''
-
-The RISC-V cpus with the ISA version in the CPU name have been depcreated. The
-four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
-``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
-option when using the ``rv32`` or ``rv64`` CPUs.
-
-RISC-V ISA CPUs (since 4.1)
-'''''''''''''''''''''''''''
-
-The RISC-V no MMU cpus have been depcreated. The two CPUs: ``rv32imacu-nommu`` and
-``rv64imacu-nommu`` should no longer be used. Instead the MMU status can be specified
-via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
-
 ``compat`` property of server class POWER CPUs (since 5.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -486,6 +471,24 @@ The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (removed in 5.0
 The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
 'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
 
+System emulator CPUS
+--------------------
+
+RISC-V ISA Specific CPUs (removed in 5.1)
+'''''''''''''''''''''''''''''''''''''''''
+
+The RISC-V cpus with the ISA version in the CPU name have been removed. The
+four CPUs are: ``rv32gcsu-v1.9.1``, ``rv32gcsu-v1.10.0``, ``rv64gcsu-v1.9.1`` and
+``rv64gcsu-v1.10.0``. Instead the version can be specified via the CPU ``priv_spec``
+option when using the ``rv32`` or ``rv64`` CPUs.
+
+RISC-V no MMU CPUs (removed in 5.1)
+'''''''''''''''''''''''''''''''''''
+
+The RISC-V no MMU cpus have been removed. The two CPUs: ``rv32imacu-nommu`` and
+``rv64imacu-nommu`` can no longer be used. Instead the MMU status can be specified
+via the CPU ``mmu`` option when using the ``rv32`` or ``rv64`` CPUs.
+
 System emulator machines
 ------------------------
 
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
index 8bb54a6360..10d8ec26a9 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -54,8 +54,8 @@ static struct arch2cpu cpus_map[] = {
     { "xtensa", "dc233c" },
     { "xtensaeb", "fsf" },
     { "hppa", "hppa" },
-    { "riscv64", "rv64gcsu-v1.10.0" },
-    { "riscv32", "rv32gcsu-v1.9.1" },
+    { "riscv64", "rv64" },
+    { "riscv32", "rv32" },
     { "rx", "rx62n" },
 };
 
-- 
2.26.2


