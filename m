Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8ADC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87E720720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HSic4g62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87E720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2eg-0003cz-Vv
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ae-0006Kl-AJ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr2Ac-0000Az-83
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707682; x=1625243682;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VkSd+rjGLnkS591IuVwDrdQgJV/0ZYuRrhez6yw5Bq0=;
 b=HSic4g62Vimw/8ACtwGfJs77rnLOhaKtab45kL8JkmuU641sKfqvUZGm
 p/Eh9CuYdym+dPgi4KB/2ulv7dIeWs8K+HXSQWMm6Fi97QKTcSSbK7lPa
 k3zgh8FRlCvIX9BwuHMpnHpkrDrpEr4Kv5PImz12ChDBd3FgxERjIYzcZ
 sszCjwSyUw6EpQf32cLn8JT4VolEE00KwGzcnnboCJvfcO/bI36VDbk2A
 t1y2I9Tld87Jvb6ssMq1Lx+/Tape47O+Apcv2rFyr9TO+YvQRP2wnDsqe
 NGLGtjthA9Jf2wkTk42ANBvCe8x4HkEs4mxz6ZihrDyfgWgC4e2IfvYlL Q==;
IronPort-SDR: D8I0lpNZ2jP8Cs2rYhqNyn5u+o5Jeuscmr/omsU+dUTNEvRQ5IANwTSjeYxdQoSsRd8zaaNO1e
 Px0bmQ06g6zj+fs4YDx5izqgmwofhYWEPHp+YHCUInwF+F1x4/cZBs/nZkA7rRY6HcV/rLpGrn
 PqwHVeOVF1S+/2SCu5Gbe5RCm03yXKxFTsq/BqTyC+YUo1gUnJLavjyetgbhTsxP0Y65oqqD6+
 i6rpDU8GmQskYmYe9x5MEGMHbMZRtPJsR01+6+AOr/Irr7RNSftlebxf8+2iYDTchj4Ln2goJ0
 BzA=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498533"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:31 +0800
IronPort-SDR: Zkaq1nh2WGr7nGwJLdADv//7w2nd1p323iYKlblE9ECq0IdRciNOjdYLjW8mvHpmM3TAm3v5wB
 QTRQsL7QWei5jmTpwPHTXybmjBy2g0WMg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:46 -0700
IronPort-SDR: 8S5ZMrbRfDaMLSj3E29CnIPUslG3atnOJUEtC8l0acjSjFpl0Snb2NcIiTctVXEHew0bVmhxk2
 Gqqa9Pqvtkdg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 44/64] target/riscv: vector floating-point merge instructions
Date: Thu,  2 Jul 2020 09:23:34 -0700
Message-Id: <20200702162354.928528-45-alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200701152549.1218-42-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  4 +++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 38 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 24 ++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fb744c5ec9..2c3f0a4e0c 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1000,3 +1000,7 @@ DEF_HELPER_6(vmford_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_6(vfmerge_vfm_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmerge_vfm_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmerge_vfm_d, void, ptr, ptr, i64, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6912eda259..38e7445a16 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -515,6 +515,8 @@ vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
 vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
+vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
+vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 361bdce654..b6872376ce 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2184,3 +2184,41 @@ GEN_OPFVF_TRANS(vmford_vf, opfvf_cmp_check)
 
 /* Vector Floating-Point Classify Instruction */
 GEN_OPFV_TRANS(vfclass_v, opfv_check)
+
+/* Vector Floating-Point Merge Instruction */
+GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
+
+static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
+{
+    if (vext_check_isa_ill(s) &&
+        vext_check_reg(s, a->rd, false) &&
+        (s->sew != 0)) {
+
+        if (s->vl_eq_vlmax) {
+            tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
+                                 MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
+        } else {
+            TCGv_ptr dest;
+            TCGv_i32 desc;
+            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+            static gen_helper_vmv_vx * const fns[3] = {
+                gen_helper_vmv_v_x_h,
+                gen_helper_vmv_v_x_w,
+                gen_helper_vmv_v_x_d,
+            };
+            TCGLabel *over = gen_new_label();
+            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+            dest = tcg_temp_new_ptr();
+            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+            fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
+
+            tcg_temp_free_ptr(dest);
+            tcg_temp_free_i32(desc);
+            gen_set_label(over);
+        }
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 63f08e4554..1d5667f471 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4194,3 +4194,27 @@ RVVCALL(OPIVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
 GEN_VEXT_V(vfclass_v_h, 2, 2, clearh)
 GEN_VEXT_V(vfclass_v_w, 4, 4, clearl)
 GEN_VEXT_V(vfclass_v_d, 8, 8, clearq)
+
+/* Vector Floating-Point Merge Instruction */
+#define GEN_VFMERGE_VF(NAME, ETYPE, H, CLEAR_FN)              \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
+                  CPURISCVState *env, uint32_t desc)          \
+{                                                             \
+    uint32_t mlen = vext_mlen(desc);                          \
+    uint32_t vm = vext_vm(desc);                              \
+    uint32_t vl = env->vl;                                    \
+    uint32_t esz = sizeof(ETYPE);                             \
+    uint32_t vlmax = vext_maxsz(desc) / esz;                  \
+    uint32_t i;                                               \
+                                                              \
+    for (i = 0; i < vl; i++) {                                \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
+        *((ETYPE *)vd + H(i))                                 \
+          = (!vm && !vext_elem_mask(v0, mlen, i) ? s2 : s1);  \
+    }                                                         \
+    CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
+}
+
+GEN_VFMERGE_VF(vfmerge_vfm_h, int16_t, H2, clearh)
+GEN_VFMERGE_VF(vfmerge_vfm_w, int32_t, H4, clearl)
+GEN_VFMERGE_VF(vfmerge_vfm_d, int64_t, H8, clearq)
-- 
2.27.0


