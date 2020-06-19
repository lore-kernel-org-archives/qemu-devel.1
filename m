Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E076C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B70C2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LZ35UPuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B70C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAoz-0003CB-Gb
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbx-0005fw-Vd
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbp-00028R-6o
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548481; x=1624084481;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iMetX1AG2MztuekpTz0Vq0px5OhOLtHAmGALKic8XNY=;
 b=LZ35UPuvgWTHpfSrdgyUZpcOEmCCplR4qd8ylnlyxSAsj8kyAiTIrNCH
 zxNkyi/wEtRIppC6OK++2W4u/L1RNO6U46Fgq6at2D9w5K1Jn1gP+1rHA
 wRWp7T2boXL3/4uHISsyVHp60rCHqkspyDJa8vAyA0FZagWmIRNPys7S/
 ZVfhvvJTzNQYrK5z8GgTWkNgMapB2zeyRebQ9QiFXtyNY1GopRg2ZSKAd
 +LmaYYh55c66hQRKfGoMKMWaVW9NJEuUmkeovWQAqSwpeUQOhBJnmMC7H
 +PwRDpBLB6FSlC4/l+jdDOovS58R/2+dJNeqRiZY3sNGuxTGZm3v+hns7 g==;
IronPort-SDR: 10jj6sM6m8bDFxe/Rzf78J5S05hfU3GHGC3yZFgLINkiO+1gfBIImedXGs23gyl9sAhA7Eoj+l
 wigTmSn1hj3maIytcgnYpZUchG2bMS//9QdH/gCPW3RSHqZEESKZyA/MJWc3T05jiP8QKIvlK+
 NWRiHxZpxsv3iYf7PUh8u4ZpQLtUMAhHzd/hIYz6mNyFPr5cKwxtUVCZ1hXrMc6ckGis6cEjeD
 sLTAWWNSVfFOuvLYbj0RNMsinQV+jXZNHb+SWm7rdbisFZ3XOB71M7kpddBImqPUwXt4jSINrd
 bE0=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="144724290"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:28 +0800
IronPort-SDR: LVLpx5yElZt9O/Nwmx5TvJDqKAtEkLxDOBQVmbiPX3HNm6P6X0G0ppLwnBM/mJs3GTsMVSoDU9
 gQ3NdtY/x+H3vie1pC2IlW78QjnyowfF0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:39 -0700
IronPort-SDR: DslVcYIr9FOHX+iirK/1GjBiHfZaj3oPoTsqr0gmB1XAOBhRZTI/ff2gVZO9SAFUR5L3K+Ml+6
 bUVleipxNdug==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/32] target/riscv: Move the hfence instructions to the rvh
 decode
Date: Thu, 18 Jun 2020 23:24:55 -0700
Message-Id: <20200619062518.1718523-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also correct the name of the VVMA instruction.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn32.decode                    |  8 ++-
 .../riscv/insn_trans/trans_privileged.inc.c   | 38 -------------
 target/riscv/insn_trans/trans_rvh.inc.c       | 57 +++++++++++++++++++
 target/riscv/translate.c                      |  1 +
 4 files changed, 63 insertions(+), 41 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvh.inc.c

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b883672e63..4c8d1215ce 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -64,7 +64,7 @@
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 
 @hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
-@hfence_bvma ....... ..... .....   ... ..... ....... %rs2 %rs1
+@hfence_vvma ....... ..... .....   ... ..... ....... %rs2 %rs1
 
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
@@ -77,8 +77,6 @@ uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
-hfence_gvma 0110001    ..... ..... 000 00000 1110011 @hfence_gvma
-hfence_bvma 0010001    ..... ..... 000 00000 1110011 @hfence_bvma
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
@@ -207,3 +205,7 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
 fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
+
+# *** RV32H Base Instruction Set ***
+hfence_gvma 0110001  .....  ..... 000 00000 1110011 @hfence_gvma
+hfence_vvma 0010001  .....  ..... 000 00000 1110011 @hfence_vvma
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index 5f26e0f5ea..2a61a853bf 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -95,41 +95,3 @@ static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
 {
     return false;
 }
-
-static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
-{
-#ifndef CONFIG_USER_ONLY
-    if (has_ext(ctx, RVH)) {
-        /* Hpervisor extensions exist */
-        /*
-         * if (env->priv == PRV_M ||
-         *   (env->priv == PRV_S &&
-         *    !riscv_cpu_virt_enabled(env) &&
-         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
-         */
-            gen_helper_tlb_flush(cpu_env);
-            return true;
-        /* } */
-    }
-#endif
-    return false;
-}
-
-static bool trans_hfence_bvma(DisasContext *ctx, arg_sfence_vma *a)
-{
-#ifndef CONFIG_USER_ONLY
-    if (has_ext(ctx, RVH)) {
-        /* Hpervisor extensions exist */
-        /*
-         * if (env->priv == PRV_M ||
-         *   (env->priv == PRV_S &&
-         *    !riscv_cpu_virt_enabled(env) &&
-         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
-         */
-            gen_helper_tlb_flush(cpu_env);
-            return true;
-        /* } */
-    }
-#endif
-    return false;
-}
diff --git a/target/riscv/insn_trans/trans_rvh.inc.c b/target/riscv/insn_trans/trans_rvh.inc.c
new file mode 100644
index 0000000000..2c0359819d
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvh.inc.c
@@ -0,0 +1,57 @@
+/*
+ * RISC-V translation routines for the RVXI Base Integer Instruction Set.
+ *
+ * Copyright (c) 2020 Western Digital
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
+        has_ext(ctx, RVH)) {
+        /* Hpervisor extensions exist */
+        /*
+         * if (env->priv == PRV_M ||
+         *   (env->priv == PRV_S &&
+         *    !riscv_cpu_virt_enabled(env) &&
+         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
+         */
+            gen_helper_tlb_flush(cpu_env);
+            return true;
+        /* } */
+    }
+#endif
+    return false;
+}
+
+static bool trans_hfence_vvma(DisasContext *ctx, arg_sfence_vma *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
+        has_ext(ctx, RVH)) {
+        /* Hpervisor extensions exist */
+        /*
+         * if (env->priv == PRV_M ||
+         *   (env->priv == PRV_S &&
+         *    !riscv_cpu_virt_enabled(env) &&
+         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
+         */
+            gen_helper_tlb_flush(cpu_env);
+            return true;
+        /* } */
+    }
+#endif
+    return false;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 43bf7e39a6..ce71ca7a92 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -711,6 +711,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rva.inc.c"
 #include "insn_trans/trans_rvf.inc.c"
 #include "insn_trans/trans_rvd.inc.c"
+#include "insn_trans/trans_rvh.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
 /* Include the auto-generated decoder for 16 bit insn */
-- 
2.27.0


