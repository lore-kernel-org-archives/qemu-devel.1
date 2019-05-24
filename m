Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52869C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CD42075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p7QSJbHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CD42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKBQ-0003Wg-8m
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:05:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK3z-0005Im-DE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJv3-0004ZY-Fu
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJv2-0004TN-W3; Fri, 24 May 2019 19:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741693; x=1590277693;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=AGxFaCnLEVaI8iI/Q11K2wsC8x55sUCoLQ8TgKS2bzo=;
	b=p7QSJbHz1oqtXhzUCdyF2/SxY1g7krN/+zDtdzjXOAL0LJqwBh5gKgIH
	PQnJDVwYFiGeNkAWbgN49mRiDffz8zY/Zjegafx49cxOof/n+Xyigycip
	JRSBCDI6gMF5HIMlZ4CJjwBqp2+SGtFvJ+sxj7C8RozM2d52NMdgwg3ut
	cSJ/g7eHt8b4nx23ZjYVs9DqWjMCdQSg3hr2SThI+YKyQlUn59bcuNP7M
	PNFqaq6yShBnHOXWEBIBiZ028ZWM236AkDQoNYiIEWjvjQ9P3EnbgQGa2
	PSSfYJsMPp++V7gqWdM5hEbmTHX6Wkx6JR6RH5WU2cEs5oRJeg5dFLXj+ g==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="215265022"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:48:12 +0800
IronPort-SDR: nYA/G2hDPXQv7pj28bCgZJQIsJbAWtNKq8orfB+ObijIstrRrmRbiqlGCyjAxRFIC4EiEU6f03
	7sAwjuaSu0DmKbhgsaLBXprkEsuXMrWipV+f0iA3cIz94EhMtEBIohZ/Mi9Sv/TXCW1tzP6MTH
	qb+7MUKERrIJTmY66eMkKar2xLHCj5qpKUQllcX/zorzMmNZSc5rLnuDs0/prngQxdr/qWKxJe
	tP8YLBB//cD32rLXbZDefQRI3BpzDlC3xyudasiTS2lXc6c/rtu8wlxvzwundf1DpJCfKzElj5
	SqYV1PVO3El/sQvU/1d4GzoK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:51 -0700
IronPort-SDR: 4/lVYVSXfpE3CZW1K4WpT1MIm/6AvMzhZzrsG4Uz0QEV/FoKMCk6DgvsrP4PF0O9Iy8jZaLnVp
	Fn2ZtViCRC/FALh9vqugamIjEx12N9+NQPcLt6VcDpreYLndmQ1HyUUghlmmBv6EcGSS+c/FpN
	Q5moyJowqmrGykUhibUYovhhEHeXiBqx14ZhaekHfWG7U9B3LBLMPrmgUkyUfjJUCh3L9OXM7V
	C238fxYI503+M9jfMAmLSbooiD6Vmg1DlD/xdqjXsfnvOHdZwd5ahyBaeunbxR1TQd+6l/rXcL
	VIQ=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip01.wdc.com with ESMTP; 24 May 2019 16:48:13 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:17 -0700
Message-Id: <5ed7686620e75fbaaacb0d4ec6c44d5ec6f2c552.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [RFC v1 16/23] target/riscv: Add hypvervisor trap
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
index 81f1cc83e5..b7e47b97f5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -595,6 +595,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    target_ulong s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -604,13 +605,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -631,7 +625,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
 
@@ -641,7 +644,42 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -655,7 +693,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index 908e166426..43d9bb941d 100644
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


