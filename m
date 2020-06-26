Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A98EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CB120663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ikW3Sm/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CB120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowbG-0002f7-E7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowIQ-0003BY-UZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowID-00030Y-Rt
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208435; x=1624744435;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EGnsqWp9ziZy9c5dGBM3nrNp6oqL+3L7Vq0dVF3cPcY=;
 b=ikW3Sm/Q62pAS0k3p8PBCdTqgj7fjQEsgybXMwDJ8RtD3mHZ8aJGMSaM
 oRJZn1TeEa9/1FM4qUmE/F6avg6xhfsNHr9UFQKUwP8uC22Cu1d5HHB8C
 7zFfsxuxytqhEswnnj6iwmMjQ//WfkCUvzUp9NTRr59XiotfizC9WrjRz
 nsm1odJLqOooXiIHOKCQVCTssR7m47pnK1GqerYuPbJfEySsUyC1qhdFF
 sGYrFzR03SwwGw1z9WwJbHuvdW5wypwgMmx1JWwckhGvIBut2GSvZ7192
 CDRW+AQCMe3gQx6bBFBQJn7p2hzSKEuzEdK7WqEKYNNdQhzT3HaRnStIC Q==;
IronPort-SDR: /X8DvZsuDBbX4em2Cosd7GPBRTu18Ic1eDaWmEyzaRoTDLFPeXdTIr9Xn04C9oEkpCnEmMyulI
 uQUEdlOeUF090dJ1LcLLIfysHQEND6QDDjHsUivztEvmFp3ltJf5GgAz2wmZ5yGVAy/7sqqyqE
 r9eqlal7VRah4GkMchYSaJ0ula/kaG1IK/yYqBhp9rCa4iDsyLxb8Vz2cHWsvGtEu+K4vQLqHP
 P6pRxzhQ6eq5Gl897a8jKZ6day0qJ+WsvayyRmF3J8oaatgrkMOxwuqBw0e8KXm9QC9UC8Pcm+
 lyI=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048398"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:47 +0800
IronPort-SDR: hDgamhut5FlVk49zn3Zww1YRa7TRzHTMB+VC4ZXN5/V4p1KME2NFu+cqLBttWRjf9NNV0+Izpr
 pctaEWVb67apFiDBiHScDZOzcch6whshk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:44 -0700
IronPort-SDR: 5EHuDLHbnlmKJkUG0YoWNFdVAJ1WRCBecR0TAncgXLwgJSVA3WKTk1xrzm1QPtXc6s659UT1SO
 e2OUutjgK6gg==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 41/63] target/riscv: vector floating-point compare instructions
Date: Fri, 26 Jun 2020 14:43:48 -0700
Message-Id: <20200626214410.3613258-42-alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200623215920.2594-40-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  37 +++++
 target/riscv/insn32.decode              |  12 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  35 +++++
 target/riscv/vector_helper.c            | 174 ++++++++++++++++++++++++
 4 files changed, 258 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index eea4c59820..0e8d241831 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -959,3 +959,40 @@ DEF_HELPER_6(vfsgnjn_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
+DEF_HELPER_6(vmfeq_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfne_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfne_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfne_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmflt_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmflt_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmflt_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfle_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfle_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfle_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfne_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfne_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfne_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmflt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmflt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmflt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfle_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfle_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfle_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfgt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfgt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfgt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfge_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfge_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfge_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmford_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmford_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmford_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmford_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmford_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 0e173e9b71..59fb1a2425 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -502,6 +502,18 @@ vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
 vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
 vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
 vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
+vmfeq_vv        011000 . ..... ..... 001 ..... 1010111 @r_vm
+vmfeq_vf        011000 . ..... ..... 101 ..... 1010111 @r_vm
+vmfne_vv        011100 . ..... ..... 001 ..... 1010111 @r_vm
+vmfne_vf        011100 . ..... ..... 101 ..... 1010111 @r_vm
+vmflt_vv        011011 . ..... ..... 001 ..... 1010111 @r_vm
+vmflt_vf        011011 . ..... ..... 101 ..... 1010111 @r_vm
+vmfle_vv        011001 . ..... ..... 001 ..... 1010111 @r_vm
+vmfle_vf        011001 . ..... ..... 101 ..... 1010111 @r_vm
+vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
+vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
+vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
+vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 460d9bce8c..791d377e3c 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2146,3 +2146,38 @@ GEN_OPFVV_TRANS(vfsgnjx_vv, opfvv_check)
 GEN_OPFVF_TRANS(vfsgnj_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfsgnjn_vf, opfvf_check)
 GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
+
+/* Vector Floating-Point Compare Instructions */
+static bool opfvv_cmp_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_reg(s, a->rs1, false) &&
+            (s->sew != 0) &&
+            ((vext_check_overlap_group(a->rd, 1, a->rs1, 1 << s->lmul) &&
+              vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul)) ||
+             (s->lmul == 0)));
+}
+
+GEN_OPFVV_TRANS(vmfeq_vv, opfvv_cmp_check)
+GEN_OPFVV_TRANS(vmfne_vv, opfvv_cmp_check)
+GEN_OPFVV_TRANS(vmflt_vv, opfvv_cmp_check)
+GEN_OPFVV_TRANS(vmfle_vv, opfvv_cmp_check)
+GEN_OPFVV_TRANS(vmford_vv, opfvv_cmp_check)
+
+static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a)
+{
+    return (vext_check_isa_ill(s) &&
+            vext_check_reg(s, a->rs2, false) &&
+            (s->sew != 0) &&
+            (vext_check_overlap_group(a->rd, 1, a->rs2, 1 << s->lmul) ||
+             (s->lmul == 0)));
+}
+
+GEN_OPFVF_TRANS(vmfeq_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmfne_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmflt_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmfle_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmfgt_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmfge_vf, opfvf_cmp_check)
+GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index dbf8817664..feb045813d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3929,3 +3929,177 @@ RVVCALL(OPFVF2, vfsgnjx_vf_d, OP_UUU_D, H8, H8, fsgnjx64)
 GEN_VEXT_VF(vfsgnjx_vf_h, 2, 2, clearh)
 GEN_VEXT_VF(vfsgnjx_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
+
+/* Vector Floating-Point Compare Instructions */
+#define GEN_VEXT_CMP_VV_ENV(NAME, ETYPE, H, DO_OP)            \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vm = vext_vm(desc);                              \
+    uint32_t vl = env->vl;                                    \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
+    uint32_t i;                                               \
+                                                              \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {            \
+            continue;                                         \
+        }                                                     \
+        vext_set_elem_mask(vd, mlen, i,                       \
+                           DO_OP(s2, s1, &env->fp_status));   \
+    }                                                         \
+    for (; i < vlmax; i++) {                                  \
+        vext_set_elem_mask(vd, mlen, i, 0);                   \
+    }                                                         \
+}
+
+static bool float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = float16_compare_quiet(a, b, s);
+    return compare == float_relation_equal;
+}
+
+GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
+GEN_VEXT_CMP_VV_ENV(vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
+GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
+
+#define GEN_VEXT_CMP_VF(NAME, ETYPE, H, DO_OP)                      \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
+                  CPURISCVState *env, uint32_t desc)                \
+{                                                                   \
+    uint32_t mlen = vext_mlen(desc);                                \
+    uint32_t vm = vext_vm(desc);                                    \
+    uint32_t vl = env->vl;                                          \
+    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
+    uint32_t i;                                                     \
+                                                                    \
+    for (i = 0; i < vl; i++) {                                      \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {                  \
+            continue;                                               \
+        }                                                           \
+        vext_set_elem_mask(vd, mlen, i,                             \
+                           DO_OP(s2, (ETYPE)s1, &env->fp_status));  \
+    }                                                               \
+    for (; i < vlmax; i++) {                                        \
+        vext_set_elem_mask(vd, mlen, i, 0);                         \
+    }                                                               \
+}
+
+GEN_VEXT_CMP_VF(vmfeq_vf_h, uint16_t, H2, float16_eq_quiet)
+GEN_VEXT_CMP_VF(vmfeq_vf_w, uint32_t, H4, float32_eq_quiet)
+GEN_VEXT_CMP_VF(vmfeq_vf_d, uint64_t, H8, float64_eq_quiet)
+
+static bool vmfne16(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = float16_compare_quiet(a, b, s);
+    return compare != float_relation_equal;
+}
+
+static bool vmfne32(uint32_t a, uint32_t b, float_status *s)
+{
+    FloatRelation compare = float32_compare_quiet(a, b, s);
+    return compare != float_relation_equal;
+}
+
+static bool vmfne64(uint64_t a, uint64_t b, float_status *s)
+{
+    FloatRelation compare = float64_compare_quiet(a, b, s);
+    return compare != float_relation_equal;
+}
+
+GEN_VEXT_CMP_VV_ENV(vmfne_vv_h, uint16_t, H2, vmfne16)
+GEN_VEXT_CMP_VV_ENV(vmfne_vv_w, uint32_t, H4, vmfne32)
+GEN_VEXT_CMP_VV_ENV(vmfne_vv_d, uint64_t, H8, vmfne64)
+GEN_VEXT_CMP_VF(vmfne_vf_h, uint16_t, H2, vmfne16)
+GEN_VEXT_CMP_VF(vmfne_vf_w, uint32_t, H4, vmfne32)
+GEN_VEXT_CMP_VF(vmfne_vf_d, uint64_t, H8, vmfne64)
+
+static bool float16_lt(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = float16_compare(a, b, s);
+    return compare == float_relation_less;
+}
+
+GEN_VEXT_CMP_VV_ENV(vmflt_vv_h, uint16_t, H2, float16_lt)
+GEN_VEXT_CMP_VV_ENV(vmflt_vv_w, uint32_t, H4, float32_lt)
+GEN_VEXT_CMP_VV_ENV(vmflt_vv_d, uint64_t, H8, float64_lt)
+GEN_VEXT_CMP_VF(vmflt_vf_h, uint16_t, H2, float16_lt)
+GEN_VEXT_CMP_VF(vmflt_vf_w, uint32_t, H4, float32_lt)
+GEN_VEXT_CMP_VF(vmflt_vf_d, uint64_t, H8, float64_lt)
+
+static bool float16_le(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = float16_compare(a, b, s);
+    return compare == float_relation_less ||
+           compare == float_relation_equal;
+}
+
+GEN_VEXT_CMP_VV_ENV(vmfle_vv_h, uint16_t, H2, float16_le)
+GEN_VEXT_CMP_VV_ENV(vmfle_vv_w, uint32_t, H4, float32_le)
+GEN_VEXT_CMP_VV_ENV(vmfle_vv_d, uint64_t, H8, float64_le)
+GEN_VEXT_CMP_VF(vmfle_vf_h, uint16_t, H2, float16_le)
+GEN_VEXT_CMP_VF(vmfle_vf_w, uint32_t, H4, float32_le)
+GEN_VEXT_CMP_VF(vmfle_vf_d, uint64_t, H8, float64_le)
+
+static bool vmfgt16(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = float16_compare(a, b, s);
+    return compare == float_relation_greater;
+}
+
+static bool vmfgt32(uint32_t a, uint32_t b, float_status *s)
+{
+    FloatRelation compare = float32_compare(a, b, s);
+    return compare == float_relation_greater;
+}
+
+static bool vmfgt64(uint64_t a, uint64_t b, float_status *s)
+{
+    FloatRelation compare = float64_compare(a, b, s);
+    return compare == float_relation_greater;
+}
+
+GEN_VEXT_CMP_VF(vmfgt_vf_h, uint16_t, H2, vmfgt16)
+GEN_VEXT_CMP_VF(vmfgt_vf_w, uint32_t, H4, vmfgt32)
+GEN_VEXT_CMP_VF(vmfgt_vf_d, uint64_t, H8, vmfgt64)
+
+static bool vmfge16(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = float16_compare(a, b, s);
+    return compare == float_relation_greater ||
+           compare == float_relation_equal;
+}
+
+static bool vmfge32(uint32_t a, uint32_t b, float_status *s)
+{
+    FloatRelation compare = float32_compare(a, b, s);
+    return compare == float_relation_greater ||
+           compare == float_relation_equal;
+}
+
+static bool vmfge64(uint64_t a, uint64_t b, float_status *s)
+{
+    FloatRelation compare = float64_compare(a, b, s);
+    return compare == float_relation_greater ||
+           compare == float_relation_equal;
+}
+
+GEN_VEXT_CMP_VF(vmfge_vf_h, uint16_t, H2, vmfge16)
+GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
+GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
+
+static bool float16_unordered_quiet(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = float16_compare_quiet(a, b, s);
+    return compare == float_relation_unordered;
+}
+
+GEN_VEXT_CMP_VV_ENV(vmford_vv_h, uint16_t, H2, !float16_unordered_quiet)
+GEN_VEXT_CMP_VV_ENV(vmford_vv_w, uint32_t, H4, !float32_unordered_quiet)
+GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
+GEN_VEXT_CMP_VF(vmford_vf_h, uint16_t, H2, !float16_unordered_quiet)
+GEN_VEXT_CMP_VF(vmford_vf_w, uint32_t, H4, !float32_unordered_quiet)
+GEN_VEXT_CMP_VF(vmford_vf_d, uint64_t, H8, !float64_unordered_quiet)
-- 
2.27.0


