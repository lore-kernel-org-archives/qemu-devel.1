Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C04C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7744D207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hdn4ASpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7744D207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN9L-0004ox-LR
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48059)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsb-0004q2-2X
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsX-0002EB-30
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsV-0002BV-1X; Fri, 07 Jun 2019 17:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944718; x=1591480718;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3r0rnJKxky1k1303Ow03vzZghGPK40tyE2AGu4Wbl6A=;
 b=Hdn4ASpQhsUh5ul/jBnLm7DbKYQwWAhxu8u8z4GbA/egxNI7h9e0mSrT
 3m0Iz0RKJbglMxoSQaGWTjmb596f58oRDGblRr1nU1natmYN5p2JtgVAt
 c8rvvYmMGEOGOdMwmzpbkJEyZOs9TANwtXJ6kqRcB5vSJo0raZc9jV5Mz
 2Tpt/MGiD5ATk+tHD75Zel1FlmzJwBKhN1qKa5stxua2f2ikMnvUbKfWd
 QGWft59cilq4nGvdMk21hjJvBEx7oKiDGVsNxFHZ+gImed0kmbpPPsw0l
 VxikPKiXETIOafpFDOv/alBp5jv/lm//ZSvggF9Nv5Mu1ubG3ffNbJGEj Q==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="209711286"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:34 +0800
IronPort-SDR: LoiIYj88QYhvPFBw3obBLBrETYTu0bdFVXQ+wtiYZ++33Zr+44PNCKYDKtVJCRx4f74v8Q/BGW
 Kn8+750/hQVg4+d3yLo5qBaY4KXvP3KMeHgB3NU3Lzvjk8E0ulNbWZZrgh4neOKUPgNHqAHY8W
 NduWdi/YGVmCQ4+eDHMsPW9TOkC4ykgq1Ka4JDURtanNiLITFX5OtNxG5d/5AEbxK2exH/bmIc
 7ihsECCJGO8uVlJTiqtiPNrbKdEYmRcxTsKlHlzOr+KhzK74xVXaxsYebqS/YOEgKe4kSiJI/V
 KpXou3FXAcTTFpQpxcGeea15
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:33:16 -0700
IronPort-SDR: MH/+9PLGNiB9QKCecC9fg7RF0DJmMkp/MCx6et5HxnTndWfijKt8QOtR0bPR2iU0VNvE8ot+IN
 /ghYHT1RffjqmIntv4W8KRV9AA3KVDPAAmx/f6XXSN4o3fQCs9rGxRaI3q4rD4ycuo01eTm91T
 W9TZb4b0LZpgCIHlhpGvuyPhNTNbqaU4prpu+JMkU8OY7nWjptVSk+wyb/P8J28oInG1yD7j5N
 gxakMe6Va4CFW6ouJV22OnffnXoE6slZkXRMGh0VWPnR+i9t+BjxUNBuVp20I/2tZvPDBCzGGg
 1ys=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:14 -0700
Message-Id: <7e98057587fcb614456fddd0f5d17ab1c250226e.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 17/27] target/riscv: Add hypvervisor trap
 support
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  4 +--
 target/riscv/cpu_helper.c | 71 +++++++++++++++++++++++++++++++++------
 target/riscv/csr.c        |  4 +--
 3 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 28117bdd32..8966c1bff6 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -508,8 +508,8 @@
 #define RISCV_EXCP_STORE_AMO_ADDR_MIS      0x6
 #define RISCV_EXCP_STORE_AMO_ACCESS_FAULT  0x7
 #define RISCV_EXCP_U_ECALL                 0x8
-#define RISCV_EXCP_S_ECALL                 0x9
-#define RISCV_EXCP_H_ECALL                 0xa
+#define RISCV_EXCP_HS_ECALL                0x9
+#define RISCV_EXCP_VS_ECALL                0xa
 #define RISCV_EXCP_M_ECALL                 0xb
 #define RISCV_EXCP_INST_PAGE_FAULT         0xc /* since: priv-1.10.0 */
 #define RISCV_EXCP_LOAD_PAGE_FAULT         0xd /* since: priv-1.10.0 */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6d6fff83a3..d1f73396e4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -605,6 +605,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    target_ulong s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -614,13 +615,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong deleg = async ? env->mideleg : env->medeleg;
     target_ulong tval = 0;
 
-    static const int ecall_cause_map[] = {
-        [PRV_U] = RISCV_EXCP_U_ECALL,
-        [PRV_S] = RISCV_EXCP_S_ECALL,
-        [PRV_H] = RISCV_EXCP_H_ECALL,
-        [PRV_M] = RISCV_EXCP_M_ECALL
-    };
-
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
@@ -641,7 +635,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* ecall is dispatched as one cause so translate based on mode */
         if (cause == RISCV_EXCP_U_ECALL) {
             assert(env->priv <= 3);
-            cause = ecall_cause_map[env->priv];
+
+            if (env->priv == PRV_M) {
+                cause = RISCV_EXCP_M_ECALL;
+            } else if (env->priv == PRV_S && riscv_cpu_virt_enabled(env)) {
+                cause = RISCV_EXCP_VS_ECALL;
+            } else if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) {
+                cause = RISCV_EXCP_HS_ECALL;
+            } else if (env->priv == PRV_U) {
+                cause = RISCV_EXCP_U_ECALL;
+            }
         }
     }
 
@@ -651,7 +654,42 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
         /* handle the trap in S-mode */
-        target_ulong s = env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
+
+            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
+                !riscv_cpu_force_hs_excep_enabled(env)) {
+                /* Trap to VS mode */
+            } else if (riscv_cpu_virt_enabled(env)) {
+                /* Trap into HS mode, from virt */
+                riscv_cpu_swap_background_regs(env);
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+
+                if (riscv_cpu_force_hs_excep_enabled(env)) {
+                    env->hstatus = set_field(env->hstatus, HSTATUS_STL, 1);
+                } else {
+                    env->hstatus = set_field(env->hstatus, HSTATUS_STL, 0);
+                }
+
+                riscv_cpu_set_virt_enabled(env, VIRT_OFF);
+                riscv_cpu_set_force_hs_excep(env, CLEAR_HS_EXCEP);
+            } else {
+                /* Trap into HS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+            }
+        }
+
+        s = env->mstatus;
         s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_SPP, env->priv);
@@ -665,7 +703,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
-        target_ulong s = env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            if (riscv_cpu_virt_enabled(env)) {
+                riscv_cpu_swap_background_regs(env);
+            }
+            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
+                                     riscv_cpu_virt_enabled(env));
+            env->mstatus = set_field(env->mstatus, MSTATUS_MTL,
+                                     riscv_cpu_force_hs_excep_enabled(env));
+
+            /* Trapping to M mode, virt is disabled */
+            riscv_cpu_set_virt_enabled(env, VIRT_OFF);
+        }
+
+        s = env->mstatus;
         s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c55eea44ec..9a1e29f39c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -239,8 +239,8 @@ static const target_ulong delegable_excps =
     (1ULL << (RISCV_EXCP_STORE_AMO_ADDR_MIS)) |
     (1ULL << (RISCV_EXCP_STORE_AMO_ACCESS_FAULT)) |
     (1ULL << (RISCV_EXCP_U_ECALL)) |
-    (1ULL << (RISCV_EXCP_S_ECALL)) |
-    (1ULL << (RISCV_EXCP_H_ECALL)) |
+    (1ULL << (RISCV_EXCP_VS_ECALL)) |
+    (1ULL << (RISCV_EXCP_HS_ECALL)) |
     (1ULL << (RISCV_EXCP_M_ECALL)) |
     (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) |
     (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) |
-- 
2.21.0


