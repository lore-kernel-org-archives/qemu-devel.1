Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C4C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6962206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ub76s5jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6962206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35181 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSk9A-0006f2-OI
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7x-0004Tf-ST
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7w-0004JH-VU
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk7w-0004IU-B2; Sun, 26 Apr 2020 12:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918452; x=1619454452;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0M21gRlekZx1wtRW6augJMxmwAitPLsaPAqrpA+aVwk=;
 b=Ub76s5jvgdyM4TYHQ0gb9dw9e1SbEtsZb7R8rWQSUnRv3+4f1xeLgMuR
 z4EhIvLwZ5HtWyM04UU9Hxxesq9tkY3PIWDg9gYp3qB3LZayPKJWCiatZ
 mUPOuwpbBoJtB8e9iYEv9oxzgS9b/1MdBHEwLWY25IaCDL6g1htN8tf9g
 KcKoa18p1FtPQdWUrgg8sOW7tRnFP9sodqzkkEI76z5Eb4wT089X8n9N3
 t+Wv45NB6LePM9PQc2+8V7ZSTVGyMQiTVE+keNXlf8qdmsDpIzlo6fwZW
 J0xoyWb5rhmWKul6YBL+TrihK9lFnbOlt5dXkCsWuNF5NT2L8sbZrbcWX Q==;
IronPort-SDR: kCtt4lI7Iyktb/+0IZvlvT5NsfAL5n6MKBXpH/XXqxfuwmEsD63h5xQkTtbB/UdnW9E5I6FVh/
 o0gJpf3JOddiDSNQ2rD2yXbS1vnH1im+Z4ZThHkd5b8TaQMhIKzvrGoPqdjkJ1r16nyoRYOVhj
 sCkKr02xRM7mPLpdPw8CZzIUmnFF+IaaBG33QB0HleLNSOiFeFg/Jr8jF17OTO88ODfrk9bMEC
 BoxycQqGKbtG5bKO76kkytp2l1Ud1uNZriNSCZXMxKcXDjQ5Sk9NJgx/iBvJKDEw85Kb3FW3uv
 1Ww=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="136193237"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:30 +0800
IronPort-SDR: kkH9iceGJRVrSHjesfGdz8zgA85Hxg8BFT2C+4cnF0mswAOL3t1CobTbWibX7IBqN9X5W3d8Rs
 e+6Jez56/aLIOrO7ZOKEB8pmSIhBk4FJE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:17:40 -0700
IronPort-SDR: /P67STBwE2Xrd7m1swM+tD4yMzlhOckSp9DE6oAjcBp41xvurO0A6+zF7AUOlbK8NnJCzi1RCi
 GyG7DaYCjhdg==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 03/15] target/riscv: Move the hfence instructions to the
 rvh decode
Date: Sun, 26 Apr 2020 09:19:19 -0700
Message-Id: <59e67210a356f9ccc3e62bf56ba8b4a819f05f45.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode                    |  6 +-
 .../riscv/insn_trans/trans_privileged.inc.c   | 40 -------------
 target/riscv/insn_trans/trans_rvh.inc.c       | 57 +++++++++++++++++++
 target/riscv/translate.c                      |  1 +
 4 files changed, 62 insertions(+), 42 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvh.inc.c

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b883672e63..05266f5a36 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
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
+hfence_bvma 0010001  .....  ..... 000 00000 1110011 @hfence_bvma
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index 76c2fad71c..c187ead774 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -103,43 +103,3 @@ static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
 #endif
     return false;
 }
-
-static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
-{
-#ifndef CONFIG_USER_ONLY
-    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
-        has_ext(ctx, RVH)) {
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
-    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
-        has_ext(ctx, RVH)) {
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
index 0000000000..2e91d6ae57
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
+static bool trans_hfence_bvma(DisasContext *ctx, arg_sfence_vma *a)
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


