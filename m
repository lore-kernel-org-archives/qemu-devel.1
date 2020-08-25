Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859C1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B88E2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LTW5RE11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B88E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeF8-0003nx-IF
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAC-000463-B7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:21 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeA9-0002w2-5W
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381958; x=1629917958;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HINHzYF+ELGtPMTRwxBDMGv3GpKId+VyLEAE86OR9sY=;
 b=LTW5RE11t8mTn2wTEDCCEuz3/TL1DVktlulsGos3L3Ic5x0dF1/acreU
 2ciYV+PGqbEvRzj27M4JfGVC3bw+Ni+1EWttmjr9KAUbP0E8fDi7CCbIJ
 gL96N+1hE0EE5SvC1pDZqb0+N8UgugLmvc5wSh9ius8s2k7uclktDVh1B
 RZ5kLawlJP9VbOLbmxpRISAale7NOhrQGkS92KoofNtoFEoHBo+WHZYyS
 c8U3DKrRsx3MigLa2zebm7Fqnrr+iDjAH7CluQQLa4F7Jh79dPDpkfBcn
 z5Hi8EsWDIUFqtbNE14EwiXmk+Y9+au/i8bquC5THMoe94m+o78hVdgrH g==;
IronPort-SDR: zo95lmV2Ybg6Ef730aZAeju4F5p9OpPjrCG8/pLr5yfc68/0VPOpRyhikHz9MrgcfSa2DVfQt4
 U1jKqPAxsc90zA0JgOwkkjq6YHNEWJz4nBcgtTUg4lQwT6eTG/Dn0f7UZ0WYoiW6eG6zRUwLmP
 SokHB1bIWERirAwxq1uWiyQQCcVDFgcFQrmaxbH3jJo46N3t86puxdwV/M6P7eUPwXrM048ab0
 P01uldyBlcsK3IFgaw/pojoSYaRJF6E+Mv4TgkJX3BE6T2bq8QPpes/z+qKWtX2A654lahR4sV
 ayM=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145294"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:57 +0800
IronPort-SDR: nFIwVC4HWYatSsUGagORw32T12vEwMCfA78BEAQ+qF5Ds1BP+44JX/aPvmvncVV61L3vIKXtOf
 bcIFQqeqvzbg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:32 -0700
IronPort-SDR: JHSzUSJ36OjLfJxRgDz5bprvtpojS5EJ2n4mQp1M7UVcaWvLhVCPdMDyqaKTzSGTJlZouZG0Mi
 B2M8vSh/JT9w==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] target/riscv: Update the Hypervisor trap return/entry
Date: Tue, 25 Aug 2020 11:48:30 -0700
Message-Id: <20200825184836.1282371-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: e7e4e801234f2934306e734f65860f601a5745bd.1597259519.git.alistair.francis@wdc.com
Message-Id: <e7e4e801234f2934306e734f65860f601a5745bd.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 16 ++++++----------
 target/riscv/op_helper.c  |  8 ++------
 target/riscv/translate.c  | 10 ----------
 4 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 43617e7c1f..fb6a3e9092 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -445,6 +445,7 @@
 #define HSTATUS_VTSR         0x00400000
 #define HSTATUS_HU           0x00000200
 #define HSTATUS_GVA          0x00000040
+#define HSTATUS_SPVP         0x00000100
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 661e790fdc..dc7ae3e7b1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -929,9 +929,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
-                                         get_field(env->hstatus, HSTATUS_SPV));
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPVP,
                                          get_field(env->mstatus, SSTATUS_SPP));
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
@@ -942,13 +940,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 riscv_cpu_set_force_hs_excep(env, 0);
             } else {
                 /* Trap into HS mode */
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
-                                         get_field(env->hstatus, HSTATUS_SPV));
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
-                                         get_field(env->mstatus, SSTATUS_SPP));
-                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
-                                         riscv_cpu_virt_enabled(env));
-
+                if (!riscv_cpu_two_stage_lookup(env)) {
+                    env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                             riscv_cpu_virt_enabled(env));
+                }
+                riscv_cpu_set_two_stage_lookup(env, false);
                 htval = env->guest_phys_fault_addr;
             }
         }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 3d306c343c..4b64bfe7d2 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -97,12 +97,8 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         prev_priv = get_field(mstatus, MSTATUS_SPP);
         prev_virt = get_field(hstatus, HSTATUS_SPV);
 
-        hstatus = set_field(hstatus, HSTATUS_SPV,
-                                 get_field(hstatus, HSTATUS_SP2V));
-        mstatus = set_field(mstatus, MSTATUS_SPP,
-                            get_field(hstatus, HSTATUS_SP2P));
-        hstatus = set_field(hstatus, HSTATUS_SP2V, 0);
-        hstatus = set_field(hstatus, HSTATUS_SP2P, 0);
+        hstatus = set_field(hstatus, HSTATUS_SPV, 0);
+        mstatus = set_field(mstatus, MSTATUS_SPP, 0);
         mstatus = set_field(mstatus, SSTATUS_SIE,
                             get_field(mstatus, SSTATUS_SPIE));
         mstatus = set_field(mstatus, SSTATUS_SPIE, 1);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 3919f570f7..79dca2291b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -797,16 +797,6 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVH)) {
         ctx->virt_enabled = riscv_cpu_virt_enabled(env);
-        if (env->priv_ver == PRV_M &&
-            get_field(env->mstatus, MSTATUS_MPRV) &&
-            MSTATUS_MPV_ISSET(env)) {
-            ctx->virt_enabled = true;
-        } else if (env->priv == PRV_S &&
-                   !riscv_cpu_virt_enabled(env) &&
-                   get_field(env->hstatus, HSTATUS_SPRV) &&
-                   get_field(env->hstatus, HSTATUS_SPV)) {
-            ctx->virt_enabled = true;
-        }
     } else {
         ctx->virt_enabled = false;
     }
-- 
2.28.0


