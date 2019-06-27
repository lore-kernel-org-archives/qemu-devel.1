Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4276C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC91420656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC91420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWSl-0005NE-VA
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWGc-0001l0-K6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWGa-0007cS-0v
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:24:54 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:39226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWGY-00071I-Ux
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:24:51 -0400
Received: by mail-pl1-f173.google.com with SMTP id b7so1484720pls.6
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=f47wk3zk+NrAkxWNULcRjGx8TZzZ5xzH7RJlcRZY1+U=;
 b=Qr1bmkQTuiWpRmPpGIHEuDehNWM7//yd+Eh4+CvbnXEnUoPuL3dalyBYdYevLOQCfB
 gyimL/Rt4bDFwwJLrFNaUGoVzqYTrJj7rndBqgaM/Zk/WEh7mHrlZWrJAKUj7eQz/Eh+
 2Z6GHRhRkR+knDYFsZJ34plUvZb+bvSqBs+uwtJ74dZBo4H3BpqHSt9DsK5mREU8FXxe
 v/zJ7fjv8eNTx+WkX1JD/TkyvsjjMKYsf6rfaWDsF15q6mMEM/DtVc0CZCudBb1Rj4BI
 pBhqkKM82w5zQVusOsEpE+vJHBzYKzNokRDxdvLN/f+D5YRSXUYxcMgVhAVNQdgewT1B
 Wnzw==
X-Gm-Message-State: APjAAAXAwBb7TuOudnxVkwgc1g8PMdiBteD2Q/K+WlQvDyDyToC9BPfG
 E0EXASZmBMHDR75CtgBmiKurxg==
X-Google-Smtp-Source: APXvYqxR5iOKD9MBtwxw88Bz8JzTXzb+lyy9NHsUm1AvKlcLO7HNsdDFYLSpXlS7s3GKXbH/8gmmRQ==
X-Received: by 2002:a17:902:294a:: with SMTP id
 g68mr5427324plb.169.1561649048711; 
 Thu, 27 Jun 2019 08:24:08 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id t2sm3302141pfh.166.2019.06.27.08.24.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:08 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:56 -0700
Message-Id: <20190627152011.18686-20-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.173
Subject: [Qemu-devel] [PULL 19/34] target/riscv: Remove user version
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Remove the user version information. This was never used and never
publically exposed in a release of QEMU, so let's just remove it. In
future to manage versions we can extend the extension properties to
specify version.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 32 +++++++++-----------------------
 target/riscv/cpu.h |  2 --
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1689ffecf85f..6a54ebf10c62 100644
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
index d559d28bcda8..0855277b92d4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -78,7 +78,6 @@ enum {
     RISCV_FEATURE_MISA
 };
 
-#define USER_VERSION_2_02_0 0x00020200
 #define PRIV_VERSION_1_09_1 0x00010901
 #define PRIV_VERSION_1_10_0 0x00011000
 #define PRIV_VERSION_1_11_0 0x00011100
@@ -105,7 +104,6 @@ struct CPURISCVState {
 
     target_ulong badaddr;
 
-    target_ulong user_ver;
     target_ulong priv_ver;
     target_ulong misa;
     target_ulong misa_mask;
-- 
2.21.0


