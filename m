Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7489CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4263C206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OxTxe4aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4263C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JSk-0001nf-Ut
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCA-0000yi-62
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC8-0000Ex-Qu
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC8-0000Dt-I8; Fri, 23 Aug 2019 19:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603775; x=1598139775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t/r3M4Y2K/wZDmgVRpnFSqDAZnLrb7FZWSdrui9tnc4=;
 b=OxTxe4ajjPG+9ejmKNsHV/DsKfnxr9UdISOAEX9MpM4T6bSae0WvF5Fr
 OzTveV+bfw/oDjMq04/S6sVrqqg4npY94my/i2jOVOX9bKCujVX0Ubsp5
 EJbPj3YXvb4+YxHH1J50TzmmvUmTMgX5QAHnPaXDYlMeQz5s4O8x0BxnM
 yr5TnfeztzzsL+86pfWcqtZXExLi5td1aQNs6P41rdfXilzXW/7IFc3dH
 jOzgT/eRfT89liZOkx4JZ4CeOpB+Un9sfnON50yVS5JhCWu04ix37KUI5
 c2zrMpIKVV00heevz9NUtIBDFKBB9rwvuXzLgCqRYj/yn39DWg+pw47e2 A==;
IronPort-SDR: b0cOR73aPBYGKPto8r+DBlJex2IJWAL9oaXRXZU9B9lhQhpFu4ELnuR6L1UHPH8mMmuovD+i3d
 b5xMrI1txQkzesQ1FGP/W+uupSBg+sbttVvGZJKiby1fc34Axr+RZlV+dcYO2C2twQ5bmpy7eV
 Gl9ACIroaAhbtaHv+R6GVvpG6HUoyJNLBKPH8GQSZuaB4XatzquYqdLKMUuhzmDPgquYb8xYKz
 OuSMfJoTRgPNIFuuo3fgfh5tEOTcK8Jc9SmprNOOO5YktEak5ogugVm5ljx8KJ2Isnuohrwevc
 IfE=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="217013905"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:54 +0800
IronPort-SDR: yp+zHC1BaDiDPTZ9aChnRlx0lzeaYb67kQY87ORCnzaZ34vo39heaBnGN/jWq098H/qfYcFWx8
 PLIFpCXTJqqmMr8b6ShxXHqoZrKLC88R2CK/T4XFtQjxwxoqIAiOu/W7SCqlvjzbb6azhJMOev
 mZg6pUFNilgTAz70wP3RU5I0AimcqVxst3bLUgZAQ30hjpv6x7OVuPRm39XVQY+rNkW1k73qqb
 kpKUk+Y1lN/2PGCtifH5hUzYA3TyFfyHHetY30AogQK+QvOcsr+XRWt05Ocqs6yy8rYMGvotmZ
 g7qP0Uy9SbfgI4/in+5mApxw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:29 -0700
IronPort-SDR: 1H2oMbWBUi+L2sEGxj1zyLiiVJnGDximN+uU9XnRTncU7toxYJGF2useCbGnKVP3cCHhG47vZW
 JpqpBFeSmFEy/Kppu0+Hq4oBMwARMUzzxmLm0wFwhTRrwtKgz/GAqqGI3kRbos1hP6UmhQe/ec
 DoAKkXfCj+KLIgkoJpCgMqZ6jQgvZNKSiaIeD3j+rcqHA2mZJ3/iEIuzAz3UPESBClqn2VoHKJ
 TE3IesYICokZPacPJ3L4cVTFQlykQiXUzisYkiQBIOhZ55C8wwgXKknrdKZpWkz629AObbGgh6
 OPc=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:11 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:31 -0700
Message-Id: <f8cb17bfb8abe59261394c36d915c2eabd2f4703.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 16/28] target/riscv: Add hypvervisor trap
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
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
index 5cee72b726..353fc9a24a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -513,8 +513,8 @@
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
index 8e8b156fc0..17eec6217b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -668,6 +668,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    target_ulong s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -677,13 +678,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -704,7 +698,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
 
@@ -714,7 +717,42 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
+                riscv_cpu_set_virt_enabled(env, VIRT_OFF);
+                riscv_cpu_set_force_hs_excep(env, CLEAR_HS_EXCEP);
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
@@ -728,7 +766,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
+            riscv_cpu_set_virt_enabled(env, VIRT_OFF);
+        }
+
+        s = *env->mstatus;
         s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 30ec8c0a8e..47be4b1d42 100644
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
2.22.0


