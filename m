Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6D821D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OD/dP5+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6D821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9LU-0002Hx-3X
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO913-00056y-7i
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO911-0004Qp-SC
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90y-0004Kl-38; Fri, 25 Oct 2019 19:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046147; x=1603582147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QVhzzf6G/cwWMvjltlcI2Xks00Gn23/VEt5ZK7oRJzc=;
 b=OD/dP5+PHw52xBmLBAHpvWxtvfGE3vkApeRZzF8r3+SOQ5sBOA8GyRIo
 Uvu1oNHdmT3SxRVbBghCMWpiEHoovizaiS5rMRmftYf7zsU1dGGly8uGk
 JKUuz+tcHEF+WmQF99M2CigXkyH08KHB3x19TyKljapFpOlVYqrrgt8eC
 /qPMNteaSYyxfEdQB9rLgMi1vWcFDIzSSQixeq2HrCJgvRxgXpG6/82WK
 4Vw7ZGLSrw03E1Vli2CesrktvO69SyWfeHM7TNAhoklMBb/VdTMpX/g7N
 7CldduMRjRKeZ+oTvx6Yzdj4dOxIIpfPJ32kkmnBCSQ8WjKnDjUSgYto0 w==;
IronPort-SDR: Gmw2Oc9SBlBFiq8Bywv9yBAZ1Eh931Qn5tO5TVWhgbhzd5pPNUh6ogRLA6q1iJTl1llUQRFtd0
 PfHGIwlPT/u1Vnz43H1wgzl6GDJ6Hw6mF8eLORf15yQPO64+32aFAahyRGo4P0cYbCu8JtDEfJ
 jzCy34grzUfalhMJZqV+VRx6O9dTvbPPpYBQMN0e2jpu11Vyw/3MCkmhs9Rp9pTd45rwOTUo9N
 GApIWGyhToqpzYYU0zWziaqByIohp30MLqhh0RnOtWerMuKoBNrdDUcTKAvep6mAKLfaeRJHll
 HyU=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="222508980"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:04 +0800
IronPort-SDR: 5zxl717LS6WcfYHsgOB7XkIjl7uKOdY3PoHhLjRicwSptwuFvloTKZBEh+tvQAF4/lmsp8iHXo
 6u7COKxTfGdQdvn6ckC1MiclLyj2klcRHTOO1ZSgMLYytft/M9vPigB0JCLq2FGJG12DMotiXb
 /m1wvM1p7YgUDMd9u0IBb9cL1xl53J4zJ9wcyT+3yv750PJOIc6LWnNbTZRriz6Up91muWhdmw
 0x7zBkyiRd3a9DngASqEb+YriS/I1Z2wQqbe4MiKCdliWbBm3QcOTvZbfGiTrG9CI1BoX+uf5E
 CUzTSdfD/KJ9OKyJEC5v0T0A
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:33 -0700
IronPort-SDR: 6Mr8tlU56ov/ZxgJZDdWmjeyZUxXYdQIYUgNhE2aLhRmySJZtq7HoKO2dsX0u3m3DcvTILAbtD
 ZlqzBinRECu1JLUW/3k54ufZdKYRsxY3n8k2a0US02v7lHAPrmlGhCogbljdQ6j/RC+/qZ6Jti
 oU33J2LHno7Soqhsf8+TL77ru8RNOgeSRNrnqIqEpP/AJM/mxz1DzlLZ18vvS0kNPkL2J1AX2p
 lVBysluW+2178SjUxbTMYso1Sr+pj5AMtX9RFrzvXjlhsnnFRbbVkkc6QZ08Cw1Hf3ZZxkOWMi
 AoU=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:29:01 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 17/27] target/riscv: Add hypvervisor trap support
Date: Fri, 25 Oct 2019 16:24:06 -0700
Message-Id: <26b40460641cf77d31d2f20fb3b00bdd0a9d3970.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_bits.h   |  4 +--
 target/riscv/cpu_helper.c | 71 +++++++++++++++++++++++++++++++++------
 target/riscv/csr.c        |  4 +--
 3 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index d66a29bdb1..17d168852c 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -510,8 +510,8 @@
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
index 637e05996a..41cd314f64 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -669,6 +669,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    target_ulong s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -678,13 +679,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -705,7 +699,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
 
@@ -715,7 +718,42 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
         /* handle the trap in S-mode */
-        target_ulong s = *env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
+
+            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
+                !riscv_cpu_force_hs_excep_enabled(env)) {
+                /* Trap to VS mode */
+            } else if (riscv_cpu_virt_enabled(env)) {
+                /* Trap into HS mode, from virt */
+                riscv_cpu_swap_hypervisor_regs(env);
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(*env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+
+                if (riscv_cpu_force_hs_excep_enabled(env)) {
+                    env->hstatus = set_field(env->hstatus, HSTATUS_STL, 1);
+                } else {
+                    env->hstatus = set_field(env->hstatus, HSTATUS_STL, 0);
+                }
+
+                riscv_cpu_set_virt_enabled(env, 0);
+                riscv_cpu_set_force_hs_excep(env, 0);
+            } else {
+                /* Trap into HS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(*env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+            }
+        }
+
+        s = *env->mstatus;
         s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_SPP, env->priv);
@@ -729,7 +767,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
-        target_ulong s = *env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            if (riscv_cpu_virt_enabled(env)) {
+                riscv_cpu_swap_hypervisor_regs(env);
+            }
+            *env->mstatus = set_field(*env->mstatus, MSTATUS_MPV,
+                                      riscv_cpu_virt_enabled(env));
+            *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
+                                      riscv_cpu_force_hs_excep_enabled(env));
+
+            /* Trapping to M mode, virt is disabled */
+            riscv_cpu_set_virt_enabled(env, 0);
+        }
+
+        s = *env->mstatus;
         s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ef9c95f94d..a795a02968 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -255,8 +255,8 @@ static const target_ulong delegable_excps =
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
2.23.0


