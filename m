Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2126C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D31A2088E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TvA0HP/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D31A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowpp-0001Fb-SG
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJP-0005Eh-Bb
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJM-00033f-JJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208512; x=1624744512;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rMLBiwoqWu7jW2jq2fWfbDYsMCbqN/XRZiEKT7mQRhM=;
 b=TvA0HP/9WX4C6Zpp4esFr5HdtXoPipFXo0mrKinczfwg8aIAO2gAo9uL
 QgMwGJNRoQcxdGigMKg4TDK/VzFFWdHwugNKbPhJZTkWi+m3nE/LUjj4i
 gcd4qK/wVxo9m/y/Ig9TpbGaEiDhqJdBgSATQLC6v/5oD+yED77biibRR
 rIAWCoVtZEdYS6GSbjDuLOBgFsCM1njy5iK2YPJTVcrw0yIO+eO7+hcv0
 mo5jG3Xb4DR/zMj2GgfrRWbkVBF3J9UBIoq2EgxFwCdeu5e/jQvmhQv0u
 CPnubqjAMfaKV2nt/miskClWXXTDvWDq6XEftwdroxMWf+3goT2RmPj74 Q==;
IronPort-SDR: JkOYbkwYzHunI5S2YxKLXCUEc354EimHdtAAsh/UOK5Iwr2rEE1wtwXfjMNGZTb8ra528JDoOA
 hmMgxno+u144aN3n2HIGM2Gff+goB2tgYT+b/WWrRXAvtZY25tN5h64SRLayqL/yX/v2yQwbH+
 7BuIHyvMOo8kPwL229uqvfA/o9iNIBzrmEySn15xRBNGtShUJX/bSODPc395TUgGP5Q5f1uDmO
 8v7MoFVlwWx/3iGEakKg8GtkuvZcvE7bI3dZnIprfStvtCgejH04AcT1vvNWG65IRFyjQ1Lqq4
 kpo=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048418"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:51 +0800
IronPort-SDR: URnhU5LUUECPBbxIUmWEAtlzF/+FeBiaeYcGPxOO02uTw3U6xc8s5tZM0jMGOlAqP6r4t9ViZo
 pR6oQXU9v7iCkQEZ92jzb9kBpkEbgYu1k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:49 -0700
IronPort-SDR: hH+qrfLBf/40+GJ835oZrFJKQ676Sf/vRRoTaw+oRoXnyNI5QX7TtEGm6tdGgR4ELILSCmJ1v5
 UP5k6FLe8XJQ==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:51 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 59/63] target/riscv: floating-point scalar move instructions
Date: Fri, 26 Jun 2020 14:44:06 -0700
Message-Id: <20200626214410.3613258-60-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:44
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200623215920.2594-58-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode              |  3 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 49 +++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index e06c0ffc22..17288a3c95 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -72,6 +72,7 @@
 @r2_vm   ...... vm:1 ..... ..... ... ..... ....... &rmr %rs2 %rd
 @r1_vm   ...... vm:1 ..... ..... ... ..... ....... %rd
 @r_nfvm  ... ... vm:1 ..... ..... ... ..... ....... &rnfvm %nf %rs2 %rs1 %rd
+@r2rd    .......   ..... ..... ... ..... ....... %rs2 %rd
 @r_vm    ...... vm:1 ..... ..... ... ..... ....... &rmrr %rs2 %rs1 %rd
 @r_vm_1  ...... . ..... ..... ... ..... .......    &rmrr vm=1 %rs2 %rs1 %rd
 @r_vm_0  ...... . ..... ..... ... ..... .......    &rmrr vm=0 %rs2 %rs1 %rd
@@ -565,6 +566,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
+vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
+vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index b10b89daa9..7af16ce0a8 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2709,3 +2709,52 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
     }
     return false;
 }
+
+/* Floating-Point Scalar Move Instructions */
+static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
+{
+    if (!s->vill && has_ext(s, RVF) &&
+        (s->mstatus_fs != 0) && (s->sew != 0)) {
+        unsigned int len = 8 << s->sew;
+
+        vec_element_loadi(s, cpu_fpr[a->rd], a->rs2, 0);
+        if (len < 64) {
+            tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd],
+                            MAKE_64BIT_MASK(len, 64 - len));
+        }
+
+        mark_fs_dirty(s);
+        return true;
+    }
+    return false;
+}
+
+/* vfmv.s.f vd, rs1 # vd[0] = rs1 (vs2=0) */
+static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
+{
+    if (!s->vill && has_ext(s, RVF) && (s->sew != 0)) {
+        TCGv_i64 t1;
+        /* The instructions ignore LMUL and vector register group. */
+        uint32_t vlmax = s->vlen >> 3;
+
+        /* if vl == 0, skip vector register write back */
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        /* zeroed all elements */
+        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), vlmax, vlmax, 0);
+
+        /* NaN-box f[rs1] as necessary for SEW */
+        t1 = tcg_temp_new_i64();
+        if (s->sew == MO_64 && !has_ext(s, RVD)) {
+            tcg_gen_ori_i64(t1, cpu_fpr[a->rs1], MAKE_64BIT_MASK(32, 32));
+        } else {
+            tcg_gen_mov_i64(t1, cpu_fpr[a->rs1]);
+        }
+        vec_element_storei(s, a->rd, 0, t1);
+        tcg_temp_free_i64(t1);
+        gen_set_label(over);
+        return true;
+    }
+    return false;
+}
-- 
2.27.0


