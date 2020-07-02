Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F40F20720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WRsrxMQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F40F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2Ml-0004LH-OR
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ah-0006S1-7L
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ae-0000BG-TK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707684; x=1625243684;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HzbQoGogG3ZxKg2vf6XJfFZu93ClzHb9/9RhC6GtIHQ=;
 b=WRsrxMQGw7Oc0f/2GmwHqXWU1WAf9lKcRGp2VYhYdXDGSnZng0Xyu6R1
 TJ+gJkIDzXK+vRZDr2lmR3orVmt+r5p4XlDX5OzyRVwFN2MBIB3nGMwU4
 VJuXax8kd2ozJJyA2tMMQemHT/ZFUKwlgg6NTCMFAotH2TA5deMwtlYqw
 l4VZEDUJjDSJmkvmx4gA5gSvvtLzXjPid7gbBfi/AuNrotD0Syfxr3bAN
 EZ84yO5RcXKrKDu92vodPcMoEKZSeddx1ZGIpvlGgxHmm8ZuwjwG0s/+x
 ZQrEmWEp503aYbRgZWbuqbNeyGCCphq6nAbEABNWp29Si+GflsSgDFpXz Q==;
IronPort-SDR: shCzbs5zxFwfkPlijjkCMT94rKRfVIR8gPZNuQW8VAd4uJwj3QQiDr6zuxWrgdhF91zEFjw9wF
 Q+snDMCmEzXnVCIY5sFxH23X/Z9YLMGOnu1LDiqgUOM3S+C6Ri3P9NcA8QaedmgQykZJ4JGndK
 vLfv0fVxWdgMnPy65Kgrj8gwn+S7uPyLw1z4eAaSTgpLXMehNtNbVir/SmTWBzczGzkFFhGNNj
 iBqTPlBqy0LWVBOojwCMv6OaEu0s5rhZ5ap/Ji5//709r4xV4H3Osj2RFLQczr8pWNW/Q8nwpk
 Y/A=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498539"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:32 +0800
IronPort-SDR: TF+xTG8qkSsZsFVi1xaggRwqpj+0oS2STgJ0cMr29Apzu13qHtxTEf/A0JWA13gY2TbTFFZw1X
 dmGn14CnAnHtfafVc3iRIcIFXHFqT1FSk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:47 -0700
IronPort-SDR: 6y0P4DZGLF5FJENFZ8M+ojM5H/2xrXdmQkMCoDRCKj3+udg9LRd0IV64/d6U+WzZF5ie73XMis
 Yc87yGGqjAWw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:32 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 47/64] target/riscv: narrowing floating-point/integer
 type-convert instructions
Date: Thu,  2 Jul 2020 09:23:37 -0700
Message-Id: <20200702162354.928528-48-alistair.francis@wdc.com>
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
Message-Id: <20200701152549.1218-45-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   | 11 ++++++
 target/riscv/insn32.decode              |  5 +++
 target/riscv/insn_trans/trans_rvv.inc.c | 48 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 39 ++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index c5f1f298f2..5870c4041e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1028,3 +1028,14 @@ DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_5(vfncvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index eda09f0c15..55fbe166d8 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -526,6 +526,11 @@ vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
 vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
 vfwcvt_f_x_v    100010 . ..... 01011 001 ..... 1010111 @r2_vm
 vfwcvt_f_f_v    100010 . ..... 01100 001 ..... 1010111 @r2_vm
+vfncvt_xu_f_v   100010 . ..... 10000 001 ..... 1010111 @r2_vm
+vfncvt_x_f_v    100010 . ..... 10001 001 ..... 1010111 @r2_vm
+vfncvt_f_xu_v   100010 . ..... 10010 001 ..... 1010111 @r2_vm
+vfncvt_f_x_v    100010 . ..... 10011 001 ..... 1010111 @r2_vm
+vfncvt_f_f_v    100010 . ..... 10100 001 ..... 1010111 @r2_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 0fc8947389..6c46d893b0 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2276,3 +2276,51 @@ GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_f_xu_v)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_f_x_v)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v)
+
+/* Narrowing Floating-Point/Integer Type-Convert Instructions */
+
+/*
+ * If the current SEW does not correspond to a supported IEEE floating-point
+ * type, an illegal instruction exception is raised
+ */
+static bool opfv_narrow_check(DisasContext *s, arg_rmr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_overlap_mask(s, a->rd, a->vm, false) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, true) &&
+            vext_check_overlap_group(a->rd, 1 << s->lmul, a->rs2,
+                                     2 << s->lmul) &&
+            (s->lmul < 0x3) && (s->sew < 0x3) && (s->sew != 0));
+}
+
+#define GEN_OPFV_NARROW_TRANS(NAME)                                \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
+{                                                                  \
+    if (opfv_narrow_check(s, a)) {                                 \
+        uint32_t data = 0;                                         \
+        static gen_helper_gvec_3_ptr * const fns[2] = {            \
+            gen_helper_##NAME##_h,                                 \
+            gen_helper_##NAME##_w,                                 \
+        };                                                         \
+        TCGLabel *over = gen_new_label();                          \
+        gen_set_rm(s, 7);                                          \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
+                                                                   \
+        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
+                           vreg_ofs(s, a->rs2), cpu_env, 0,        \
+                           s->vlen / 8, data, fns[s->sew - 1]);    \
+        gen_set_label(over);                                       \
+        return true;                                               \
+    }                                                              \
+    return false;                                                  \
+}
+
+GEN_OPFV_NARROW_TRANS(vfncvt_xu_f_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_x_f_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_x_v)
+GEN_OPFV_NARROW_TRANS(vfncvt_f_f_v)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 742080dc7d..05dcf7cd09 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4293,3 +4293,42 @@ RVVCALL(OPFVV1, vfwcvt_f_f_v_h, WOP_UU_H, H4, H2, vfwcvtffv16)
 RVVCALL(OPFVV1, vfwcvt_f_f_v_w, WOP_UU_W, H8, H4, float32_to_float64)
 GEN_VEXT_V_ENV(vfwcvt_f_f_v_h, 2, 4, clearl)
 GEN_VEXT_V_ENV(vfwcvt_f_f_v_w, 4, 8, clearq)
+
+/* Narrowing Floating-Point/Integer Type-Convert Instructions */
+/* (TD, T2, TX2) */
+#define NOP_UU_H uint16_t, uint32_t, uint32_t
+#define NOP_UU_W uint32_t, uint64_t, uint64_t
+/* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
+RVVCALL(OPFVV1, vfncvt_xu_f_v_h, NOP_UU_H, H2, H4, float32_to_uint16)
+RVVCALL(OPFVV1, vfncvt_xu_f_v_w, NOP_UU_W, H4, H8, float64_to_uint32)
+GEN_VEXT_V_ENV(vfncvt_xu_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_xu_f_v_w, 4, 4, clearl)
+
+/* vfncvt.x.f.v vd, vs2, vm # Convert double-width float to signed integer. */
+RVVCALL(OPFVV1, vfncvt_x_f_v_h, NOP_UU_H, H2, H4, float32_to_int16)
+RVVCALL(OPFVV1, vfncvt_x_f_v_w, NOP_UU_W, H4, H8, float64_to_int32)
+GEN_VEXT_V_ENV(vfncvt_x_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_x_f_v_w, 4, 4, clearl)
+
+/* vfncvt.f.xu.v vd, vs2, vm # Convert double-width unsigned integer to float */
+RVVCALL(OPFVV1, vfncvt_f_xu_v_h, NOP_UU_H, H2, H4, uint32_to_float16)
+RVVCALL(OPFVV1, vfncvt_f_xu_v_w, NOP_UU_W, H4, H8, uint64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_xu_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_xu_v_w, 4, 4, clearl)
+
+/* vfncvt.f.x.v vd, vs2, vm # Convert double-width integer to float. */
+RVVCALL(OPFVV1, vfncvt_f_x_v_h, NOP_UU_H, H2, H4, int32_to_float16)
+RVVCALL(OPFVV1, vfncvt_f_x_v_w, NOP_UU_W, H4, H8, int64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_x_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_x_v_w, 4, 4, clearl)
+
+/* vfncvt.f.f.v vd, vs2, vm # Convert double float to single-width float. */
+static uint16_t vfncvtffv16(uint32_t a, float_status *s)
+{
+    return float32_to_float16(a, true, s);
+}
+
+RVVCALL(OPFVV1, vfncvt_f_f_v_h, NOP_UU_H, H2, H4, vfncvtffv16)
+RVVCALL(OPFVV1, vfncvt_f_f_v_w, NOP_UU_W, H4, H8, float64_to_float32)
+GEN_VEXT_V_ENV(vfncvt_f_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)
-- 
2.27.0


