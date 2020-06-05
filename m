Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C12C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED192067B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AiPy+zNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED192067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1CA-0002ow-Fv
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1Ay-0000zo-UG; Thu, 04 Jun 2020 21:29:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1Ax-0008Vi-NZ; Thu, 04 Jun 2020 21:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320581; x=1622856581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=70LPdx2tDUg+MG9PbYhk77PmRs6I3ZQoa//hFZ5/6VI=;
 b=AiPy+zNqaqez67/5tOb1PKJR+eDm/Tcyyx/qLN/vNuWrFQcSCi36oiUT
 dt+/g6M1e6hg4qbaUJPtQ2QvVf8Q2BzfH2oURjxCGgkRlNMIg6Vmccnkp
 TxR2gDN2zAg/OrLHNbhcV2DbGPR5xIy0LNw+KZyaneewB0PwijWBJF/1t
 z6nd3fhX/IRYhby9zH3dhW10HyMRdzmvanUuPuPZYKCZl21GKxO50wi3z
 jfvCb+c2T+mV50p51a03e1ojhYEu6cMOfDPqOJZJdC2ClqaztNsZtrj8t
 l4li4uG9iXviYsDRQSAZCLhzhSXFSJUt3eaEpslspdvJNNrca9YuLCk7A g==;
IronPort-SDR: tE9AofRLOtNe2PEvYVdAlOdRc8FXiwXmHy8lVO/bQ2DJs4vnLHSSDBZW6TjoJT2OGLWmlqKCKh
 IBRc7vNXNj35tL7L7Rfy1vC9YiB6zlMuG1ypQofNaqDU1ng29BhdVZyiFkAR0LL8JgqQ9MPUJe
 aspsACh/PJ9SVOn6J7RvsskKvYdgkkl6jzca14L3btynYEhJBLrvwsdNij3sZHOORie6VD9T6W
 SC0ZaPBUCBT/ibEMTT9I5ARupzYNHAvtcqCLUvvQgvzKTUau+LI3mEJ/h++8ABqQ78a6Y1Bd1J
 uQE=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="139561719"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:39 +0800
IronPort-SDR: 4ezoAGmnmxzKeGIsjArcyHebTMfjmhhuWpCDtpBjdNsTEwpFkoVquKyURF59+xRfpLKVnm/Jyb
 oTpJjcw3LhCfR+LEBHcquWjLDOPMZxE48=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:14 -0700
IronPort-SDR: OfjdVt6DP7XW5KtHbDZsg517s4BenlBI/FRIkJyMUDrPpsVcPHS/aD6SA/t44VibPTBhjGGYQU
 eOvjVAR7AKYg==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2020 18:29:38 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 03/17] target/riscv: Move the hfence instructions to the
 rvh decode
Date: Thu,  4 Jun 2020 18:20:50 -0700
Message-Id: <6f88ddc816f7828e4b58acc82e3e4b61bd86e158.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:30
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also correct the name of the VVMA instruction.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.26.2


