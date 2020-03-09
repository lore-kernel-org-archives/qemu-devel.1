Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D2CC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422702067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422702067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDqb-0003TX-Ay
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDgI-0007Ps-Nc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBDgG-0007zS-5k
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:22:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54921)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBDgF-0007aY-DK; Mon, 09 Mar 2020 04:22:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07439577|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.0951755-0.00088428-0.90394;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03295; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.GyTxIXp_1583742101; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GyTxIXp_1583742101)
 by smtp.aliyun-inc.com(10.147.41.137);
 Mon, 09 Mar 2020 16:22:02 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v3 39/60] target/riscv: vector floating-point classify
 instructions
Date: Mon,  9 Mar 2020 16:20:21 +0800
Message-Id: <20200309082042.12967-40-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200309082042.12967-1-zhiwei_liu@c-sky.com>
References: <20200309082042.12967-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  4 ++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c |  3 ++
 target/riscv/vector_helper.c            | 62 +++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 323bed038e..86f1498c06 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -978,3 +978,7 @@ DEF_HELPER_6(vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 2d61256981..18b78ed82d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -507,6 +507,7 @@ vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
 vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
 vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
+vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 9d9653e605..3971c3ebdb 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -1918,3 +1918,6 @@ GEN_OPFVF_TRANS(vmfle_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmfgt_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmfge_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
+
+/* Vector Floating-Point Classify Instruction */
+GEN_OPFV_TRANS(vfclass_v, opfv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index dd44cc57a3..e9f278643f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3852,3 +3852,65 @@ GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
+
+/* Vector Floating-Point Classify Instruction */
+static uint16_t fclass_f16(uint16_t frs1, float_status *s)
+{
+    float16 f = frs1;
+    bool sign = float16_is_neg(f);
+
+    if (float16_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float16_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float16_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float16_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+static uint32_t fclass_s(uint32_t frs1, float_status *s)
+{
+    float32 f = frs1;
+    bool sign = float32_is_neg(f);
+
+    if (float32_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float32_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float32_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float32_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+static uint64_t fclass_d(uint64_t frs1, float_status *s)
+{
+    float64 f = frs1;
+    bool sign = float64_is_neg(f);
+
+    if (float64_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float64_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float64_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float64_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+RVVCALL(OPFVV1, vfclass_v_h, OP_UU_H, H2, H2, fclass_f16)
+RVVCALL(OPFVV1, vfclass_v_w, OP_UU_W, H4, H4, fclass_s)
+RVVCALL(OPFVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
+GEN_VEXT_V_ENV(vfclass_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfclass_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfclass_v_d, 8, 8, clearq)
-- 
2.23.0


