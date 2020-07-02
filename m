Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A78206E2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KONPvNoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A78206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Zm-000541-5L
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ad-0006IE-68
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ab-00008e-0S
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707681; x=1625243681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qFKWc525OMQAU3pSblH9dkCjLV8hcJJiQ/QdERxidwI=;
 b=KONPvNoKOPMjz0bpMf/1L/xttayLs/7fBcrqRwiKcCsVbyNF6xK2dSL6
 TwEdFzBHnSec4vzMY4HRm3wbXijrk6LzbrHYQsJhF14ntSFLZW5BNcYXv
 X4IwfhYgL4hYyIBBjO4irhkk8LoUzIQ/S87SsxS5w/iB1eR/zuEUfbLWD
 4iNlZCJeqrdwXn2WBNZFhdmPzHBDncWoNmIkBXjHmbY4UNO5MTxcXVKyJ
 tpLoHy+8hpIXasMOSuC3NZHWrvExdGLDFB3jpYo0hgQ7HvCAyWnzJr8MK
 2xCxp+bdiZ0EcJR75TujKOeTpMY7aRJyjEDWk4xMB6ZVFP+krGi3+y/Z9 Q==;
IronPort-SDR: Xhv9DR3HECk0Ielb8IIyjrERPAH8080UZdC9aYHBmaWG0ms/XaDb/OQJHcQR9CobBDq+iFLBwC
 ubOReGAgzFRycEs3trxtEN+dNwDtriLm6Iq0rnpBTOefe5X8k6VZz5z0+u8TOWZY7RbW97jYx/
 lWow7YdoNNmqW6nKjFRylr5XPcFU51a83RtjiKWmLCWEHR5Dv6ui3lD7WYJKnW+oU8p4Mcvoz1
 dLHF3gPVwU5uSDbqrjsRgFwGWxiqCsKuiiGhDcxsJUlkmRKgpl3mk4b5Blrcd3kJzjaIEgr1LQ
 nVw=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498530"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:31 +0800
IronPort-SDR: G/qr7kgcD0DAOorbGiE1e0dEbPvzBaTeI5N//De2OMCAQYbVQ10qQmD8OU2QW0wgyAu71HS6aY
 xfWzokInwdowY50kZ11PpVRooUJPtYvaE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:46 -0700
IronPort-SDR: +3+0whprixKxU+BBrjNwP5YiWkzcG/hjVHkGrCzjBPjJm52eCC8tkm2iUPAy+a2E/ZR2BaS502
 To5BgM9z2Gkw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 43/64] target/riscv: vector floating-point classify
 instructions
Date: Thu,  2 Jul 2020 09:23:33 -0700
Message-Id: <20200702162354.928528-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200701152549.1218-41-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  4 ++
 target/riscv/internals.h                |  5 ++
 target/riscv/insn32.decode              |  1 +
 target/riscv/fpu_helper.c               | 33 +--------
 target/riscv/insn_trans/trans_rvv.inc.c |  3 +
 target/riscv/vector_helper.c            | 91 +++++++++++++++++++++++++
 6 files changed, 107 insertions(+), 30 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 0e8d241831..fb744c5ec9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -996,3 +996,7 @@ DEF_HELPER_6(vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index e59e8b30ad..f3cea478f7 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -27,4 +27,9 @@ FIELD(VDATA, VM, 8, 1)
 FIELD(VDATA, LMUL, 9, 2)
 FIELD(VDATA, NF, 11, 4)
 FIELD(VDATA, WD, 11, 1)
+
+/* float point classify helpers */
+target_ulong fclass_h(uint64_t frs1);
+target_ulong fclass_s(uint64_t frs1);
+target_ulong fclass_d(uint64_t frs1);
 #endif
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 59fb1a2425..6912eda259 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -514,6 +514,7 @@ vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
 vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
 vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
+vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index 0b79562a69..4379756dc4 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
+#include "internals.h"
 
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
 {
@@ -230,21 +231,7 @@ uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
 
 target_ulong helper_fclass_s(uint64_t frs1)
 {
-    float32 f = frs1;
-    bool sign = float32_is_neg(f);
-
-    if (float32_is_infinity(f)) {
-        return sign ? 1 << 0 : 1 << 7;
-    } else if (float32_is_zero(f)) {
-        return sign ? 1 << 3 : 1 << 4;
-    } else if (float32_is_zero_or_denormal(f)) {
-        return sign ? 1 << 2 : 1 << 5;
-    } else if (float32_is_any_nan(f)) {
-        float_status s = { }; /* for snan_bit_is_one */
-        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
-    } else {
-        return sign ? 1 << 1 : 1 << 6;
-    }
+    return fclass_s(frs1);
 }
 
 uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
@@ -353,19 +340,5 @@ uint64_t helper_fcvt_d_lu(CPURISCVState *env, uint64_t rs1)
 
 target_ulong helper_fclass_d(uint64_t frs1)
 {
-    float64 f = frs1;
-    bool sign = float64_is_neg(f);
-
-    if (float64_is_infinity(f)) {
-        return sign ? 1 << 0 : 1 << 7;
-    } else if (float64_is_zero(f)) {
-        return sign ? 1 << 3 : 1 << 4;
-    } else if (float64_is_zero_or_denormal(f)) {
-        return sign ? 1 << 2 : 1 << 5;
-    } else if (float64_is_any_nan(f)) {
-        float_status s = { }; /* for snan_bit_is_one */
-        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
-    } else {
-        return sign ? 1 << 1 : 1 << 6;
-    }
+    return fclass_d(frs1);
 }
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 791d377e3c..361bdce654 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2181,3 +2181,6 @@ GEN_OPFVF_TRANS(vmfle_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmfgt_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmfge_vf, opfvf_cmp_check)
 GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
+
+/* Vector Floating-Point Classify Instruction */
+GEN_OPFV_TRANS(vfclass_v, opfv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 0c12752f49..63f08e4554 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4103,3 +4103,94 @@ GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
 GEN_VEXT_CMP_VF(vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
+
+/* Vector Floating-Point Classify Instruction */
+#define OPIVV1(NAME, TD, T2, TX2, HD, HS2, OP)         \
+static void do_##NAME(void *vd, void *vs2, int i)      \
+{                                                      \
+    TX2 s2 = *((T2 *)vs2 + HS2(i));                    \
+    *((TD *)vd + HD(i)) = OP(s2);                      \
+}
+
+#define GEN_VEXT_V(NAME, ESZ, DSZ, CLEAR_FN)           \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
+                  CPURISCVState *env, uint32_t desc)   \
+{                                                      \
+    uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
+    uint32_t mlen = vext_mlen(desc);                   \
+    uint32_t vm = vext_vm(desc);                       \
+    uint32_t vl = env->vl;                             \
+    uint32_t i;                                        \
+                                                       \
+    for (i = 0; i < vl; i++) {                         \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {     \
+            continue;                                  \
+        }                                              \
+        do_##NAME(vd, vs2, i);                         \
+    }                                                  \
+    CLEAR_FN(vd, vl, vl * DSZ,  vlmax * DSZ);          \
+}
+
+target_ulong fclass_h(uint64_t frs1)
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
+
+target_ulong fclass_s(uint64_t frs1)
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
+
+target_ulong fclass_d(uint64_t frs1)
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
+
+RVVCALL(OPIVV1, vfclass_v_h, OP_UU_H, H2, H2, fclass_h)
+RVVCALL(OPIVV1, vfclass_v_w, OP_UU_W, H4, H4, fclass_s)
+RVVCALL(OPIVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
+GEN_VEXT_V(vfclass_v_h, 2, 2, clearh)
+GEN_VEXT_V(vfclass_v_w, 4, 4, clearl)
+GEN_VEXT_V(vfclass_v_d, 8, 8, clearq)
-- 
2.27.0


