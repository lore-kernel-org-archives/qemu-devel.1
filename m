Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDDEC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27A62082C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 01:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MuT29wwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27A62082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd3Ac-00082S-6T
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 21:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30I-0006vf-JL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30H-0000CR-6s
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 21:33:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0651fb9a1=alistair.francis@wdc.com>)
 id 1hd30G-0000A1-Rj; Mon, 17 Jun 2019 21:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560821621; x=1592357621;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PhCUtrqF7yEAsHBc4uhl3pPi0G+raSB/DW34xH+qBXU=;
 b=MuT29wwKEB0DJ2WSba9/q82ueFBrzuCbsEWlN73X0FiHq12/0Tt+mehG
 3JnDC5Kta7f4AGa62mqgp6Se1W1BwP6ROSTdRU4RzlEH4s6QAiS8/6bW+
 CY132+rzQ304LOtDT6TxUmUzVjj9d+yNSs01JEXn3LDrWYzDTPuNjaOcf
 HKGevQA+nxlwQFKURI68LtqO7TPrlggEz00IDxbxe82jRqiWJMgcxeICr
 n4E6Dooo6Dtu4zDWHzlDoJZxioTTXmO4YVgugwlZl95vdvm/pJVJJtFs1
 FJyIhN6QUO5nzhaBO7SbAjR9Wmc+6mZ4vbu2T4Y+kccJK9fDkKO24+cSh w==;
X-IronPort-AV: E=Sophos;i="5.63,386,1557158400"; d="scan'208";a="112055104"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 09:33:41 +0800
IronPort-SDR: N3ufcin+DTbSh1gHE2mMW7bXW0Ec0nS9zLBWz+57eh40y0HX6n3QWac8fcWiqdo1eVStqBEP+P
 I0yE8QgRNduGNP7xkzzyORfhbmX1LwB4m0dLCDKdggCZ6+b9rTm3etVl0MnVEX3XYepvRMHsQe
 q3oGA6b7QpvNA7qWT/CpuFTP9QBVIQf9+5veS1qzBDblZ+wkyrPFg0fSfqy6+M7giCyA4DghnL
 37sytLWbKL3qQeDPcoHik75h8TwpDjekbv7+WpnwpN6TfZVvydN9BkVx9zTvtf/iszAQkvNHkc
 cELOZyKHuhXQw8kytCHHOrtb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jun 2019 18:33:10 -0700
IronPort-SDR: pw5EqYkyx4rgnErmzenbDgD0AWqTrOYnrhyoZIBsPUSuW/X7Ar7gwOBPZm8IYE8+GNMTv6LZVq
 81MNybvCnNxkhz9FoQabOTJGmT8A0DBhIfoAvwDiyhPVgFsG5270ZwgAxq1fCLAlBZA4jL10Nv
 OdWQ7xk0WDLXAkgq8SQowq97+oCaRqyO/dDKZ3lUNlS1oCdH/mDDbIdSE7RfnJNfyn3z7rke09
 gwn/o2uD+SxzLkYKARLBdgLeGFS3HsN64JS0rfdQ+z9z2Lb/dL1Lph+PsY+/O6vy76iTPkhx7z
 2bY=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2019 18:33:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 17 Jun 2019 18:31:19 -0700
Message-Id: <8d6536823ee1969cd5effbf58b2041ce44f08eec.1560821342.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560821342.git.alistair.francis@wdc.com>
References: <cover.1560821342.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 7/9] target/riscv: Remove user version
 information
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the user version information. This was never used and never
publically exposed in a release of QEMU, so let's just remove it. In
future to manage versions we can extend the extension properties to
specify version.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 32 +++++++++-----------------------
 target/riscv/cpu.h |  2 --
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 21bfaa9722..ddbe922958 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -89,9 +89,8 @@ static void set_misa(CPURISCVState *env, target_ulong misa)
     env->misa_mask = env->misa = misa;
 }
 
-static void set_versions(CPURISCVState *env, int user_ver, int priv_ver)
+static void set_priv_version(CPURISCVState *env, int priv_ver)
 {
-    env->user_ver = user_ver;
     env->priv_ver = priv_ver;
 }
 
@@ -111,7 +110,7 @@ static void riscv_any_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_11_0);
+    set_priv_version(env, PRIV_VERSION_1_11_0);
     set_resetvec(env, DEFAULT_RSTVEC);
 }
 
@@ -128,7 +127,7 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
+    set_priv_version(env, PRIV_VERSION_1_09_1);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
@@ -138,7 +137,7 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
@@ -148,7 +147,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
 }
@@ -166,7 +165,7 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
+    set_priv_version(env, PRIV_VERSION_1_09_1);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
@@ -176,7 +175,7 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
     set_feature(env, RISCV_FEATURE_PMP);
@@ -186,7 +185,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
-    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
     set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_PMP);
 }
@@ -317,7 +316,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
-    int user_version = USER_VERSION_2_02_0;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
 
@@ -342,18 +340,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (cpu->cfg.user_spec) {
-        if (!g_strcmp0(cpu->cfg.user_spec, "v2.02.0")) {
-            user_version = USER_VERSION_2_02_0;
-        } else {
-            error_setg(errp,
-                       "Unsupported user spec version '%s'",
-                       cpu->cfg.user_spec);
-            return;
-        }
-    }
-
-    set_versions(env, user_version, priv_version);
+    set_priv_version(env, priv_version);
     set_resetvec(env, DEFAULT_RSTVEC);
 
     if (cpu->cfg.mmu) {
@@ -454,7 +441,6 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
-    DEFINE_PROP_STRING("user_spec", RISCVCPU, cfg.user_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4e58c3b856..a558c353f0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -78,7 +78,6 @@ enum {
     RISCV_FEATURE_MISA
 };
 
-#define USER_VERSION_2_02_0 0x00020200
 #define PRIV_VERSION_1_09_1 0x00010901
 #define PRIV_VERSION_1_10_0 0x00011000
 #define PRIV_VERSION_1_11_0 0x00011100
@@ -104,7 +103,6 @@ struct CPURISCVState {
 
     target_ulong badaddr;
 
-    target_ulong user_ver;
     target_ulong priv_ver;
     target_ulong misa;
     target_ulong misa_mask;
-- 
2.22.0


