Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D909C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA642168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OjF+RzNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA642168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzZ5-0003Xq-Ru
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFZ-0002jQ-UP; Fri, 23 Oct 2020 11:45:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFW-0003hs-SO; Fri, 23 Oct 2020 11:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467902; x=1635003902;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jVXGCX52Qg+Wgh+2b8CgSjw05597PjIzpeo/Pxlh5yY=;
 b=OjF+RzNFtNQz8EC2OAnWHabMqktpCHh4UX+LKXX9OzejycQDiT4JwKID
 4HR3t3YlAPrRkovlAswElMoQ9W8si3lHpMVWeBTdKmheBpjgjpDTcf6IH
 CVmWT6qRw+sLODOHRg0d7yFRjG9ogrU/f7mmppFnePLtEMVkUcKVyZ4Ca
 874Bwae6cC8i2PEubsJ82hz6QegV5yi/Jp3uvmhF9sRPv4LLt7LtGP/nx
 6zyYripCy/fwaNVlfFd1mDrZNhmFWEsYFUN3/LQXWycf+Q1N1GHgRUAVb
 cIJiTLcVcpuMBFYeB+v0Kk+Hnuc8fChLUG0+CNDeYhIafJahxYiGWEsBY g==;
IronPort-SDR: jW7EHOBKJlL/zm0VB2IGNNmDPYXplAMCjSPuVhLhbO8+YrmW6F5cZPyADMn9dO/PtS1Zed7jO9
 e4W5Fi+Iu+q5ugW0G43Eslm0PLQi45M3KnHjr2qCZ0JlUU+uLtINAMkI3/MSOGAYTn7hmrC0KO
 vYcO0C3ZeWmAvzngxQy59iM9Qs3lq85Zj+4bggX767X+Rhlh47bupu9DcDw7yPKrgWKFsSDPRZ
 UWCkqquzGzqsPDJo89pFP9hsrGdJ3W/GM/F/2HzLuxIsbaUJ9lhJY1g+2rCNmddPKgYsnxNuuD
 gCU=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150653291"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:45:01 +0800
IronPort-SDR: 0Z//29Dfka7e6Vf+GKRw3OriJyH3eXPeIgk5ty6GV72JXbnaqDyhGAikdLYBHyXLmlKz0kLjug
 GN6SVc8rq9VczRCoKWD8t8QMwYLlq8ky47FJqyON5CPTe5hHKAPbhp4dbo0rgu3HVDVM6l1Vgb
 qo7rUzI7A0nztDRnmZM2UjuXO0yQyfW5PyuOLJKj0mHgKAj0U7xD1y9mYXnEKI6sy7cD+GC1aP
 MIUX/cmMjV9fFwxiyc+VkHb8Hzfs8UBT1HFPRdhiYl9uYRZ8iLWx9NEmvIs2+NSvznwivPejuL
 GOhEa/Gh1xKDD6FAjsDIg+6i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:30:16 -0700
IronPort-SDR: FLzR4j8FIzSH1g9RAeuRHVSquubj5GuEyGt9z3KVLcCbAM5SDONXP2REUZGepe4vH+dEyHe+OJ
 wl9v5/Oa6a5ylXoeCjWOgBYQPlME8Barvc5nd6piWrQO8/ujxvkNc580xP3qcVUBXb2Rduzgf2
 FCg9T3rgeMelHUFUIl+uFOE3kFvjUhjUk7BrvrGujP0KB6dck9Ky5fBemY0D+otoGqnxTz4/aQ
 7PnvM8JgqHYglLjTK7BBqwYM766uX5pXDzOaSUUWHI6FUNFYdgwt2B561E1TYzM0XHtVcwBXBe
 /zY=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:45:01 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 10/16] target/riscv: Specify the XLEN for CPUs
Date: Fri, 23 Oct 2020 08:33:40 -0700
Message-Id: <b586d3c656319962c5cd4d73bd17e6d03bdd1301.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 32234d4a70..8f8c568974 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -157,22 +157,36 @@ static void riscv_base_cpu_init(Object *obj)
     set_misa(env, 0);
 }
 
-static void rvxx_sifive_u_cpu_init(Object *obj)
+#ifdef TARGET_RISCV64
+static void rv64_sifive_u_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
 }
 
-static void rvxx_sifive_e_cpu_init(Object *obj)
+static void rv64_sifive_e_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
-    set_misa(env, RVXLEN | RVI | RVM | RVA | RVC | RVU);
+    set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
     set_priv_version(env, PRIV_VERSION_1_10_0);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
+#else
+static void rv32_sifive_u_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
+}
 
-#if defined(TARGET_RISCV32)
+static void rv32_sifive_e_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
+    qdev_prop_set_bit(DEVICE(obj), "mmu", false);
+}
 
 static void rv32_ibex_cpu_init(Object *obj)
 {
@@ -190,7 +204,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     set_resetvec(env, DEFAULT_RSTVEC);
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
-
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -647,13 +660,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_sifive_e_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32_sifive_e_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_sifive_u_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32_sifive_u_cpu_init),
 #elif defined(TARGET_RISCV64)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rvxx_sifive_e_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rvxx_sifive_u_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64_sifive_e_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64_sifive_u_cpu_init),
 #endif
 };
 
-- 
2.28.0


