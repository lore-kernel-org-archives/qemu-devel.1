Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7D7C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F376D206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F376D206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRHC-000460-VD
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCR4D-0001Nc-Aw
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCR4C-0008Hu-2U
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:17 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43901)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCR4B-0008Dw-5C; Thu, 12 Mar 2020 12:52:16 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07476402|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.411059-0.000646204-0.588295;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03293; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-QPI7._1584031928; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-QPI7._1584031928)
 by smtp.aliyun-inc.com(10.147.41.231);
 Fri, 13 Mar 2020 00:52:09 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 56/60] target/riscv: floating-point scalar move instructions
Date: Thu, 12 Mar 2020 22:58:56 +0800
Message-Id: <20200312145900.2054-57-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  9 +++++
 target/riscv/insn32.decode              |  2 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 47 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 36 +++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 41cecd266c..7a689a5c07 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1111,3 +1111,12 @@ DEF_HELPER_3(vmv_s_x_b, void, ptr, tl, env)
 DEF_HELPER_3(vmv_s_x_h, void, ptr, tl, env)
 DEF_HELPER_3(vmv_s_x_w, void, ptr, tl, env)
 DEF_HELPER_3(vmv_s_x_d, void, ptr, tl, env)
+
+DEF_HELPER_2(vfmv_f_s_b, i64, ptr, env)
+DEF_HELPER_2(vfmv_f_s_h, i64, ptr, env)
+DEF_HELPER_2(vfmv_f_s_w, i64, ptr, env)
+DEF_HELPER_2(vfmv_f_s_d, i64, ptr, env)
+DEF_HELPER_3(vfmv_s_f_b, void, ptr, i64, env)
+DEF_HELPER_3(vfmv_s_f_h, void, ptr, i64, env)
+DEF_HELPER_3(vfmv_s_f_w, void, ptr, i64, env)
+DEF_HELPER_3(vfmv_s_f_d, void, ptr, i64, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 7e1efeec05..bfdce0979c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -557,6 +557,8 @@ viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
+vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
+vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 7720ffecde..99cd45b0aa 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2269,3 +2269,50 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
     }
     return false;
 }
+
+/* Floating-Point Scalar Move Instructions */
+typedef void (* gen_helper_vfmv_f_s)(TCGv_i64, TCGv_ptr, TCGv_env);
+static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
+{
+    if (vext_check_isa_ill(s, RVV)) {
+        TCGv_ptr src2;
+        gen_helper_vfmv_f_s fns[4] = {
+            gen_helper_vfmv_f_s_b, gen_helper_vfmv_f_s_h,
+            gen_helper_vfmv_f_s_w, gen_helper_vfmv_f_s_d
+        };
+
+        src2 = tcg_temp_new_ptr();
+        tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
+
+        fns[s->sew](cpu_fpr[a->rd], src2, cpu_env);
+
+        tcg_temp_free_ptr(src2);
+        return true;
+    }
+    return false;
+}
+
+typedef void (* gen_helper_vfmv_s_f)(TCGv_ptr, TCGv_i64, TCGv_env);
+static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
+{
+    if (vext_check_isa_ill(s, RVV | RVF) ||
+        vext_check_isa_ill(s, RVV | RVD)) {
+        TCGv_ptr dest;
+        TCGv_i64 src1;
+        gen_helper_vfmv_s_f fns[4] = {
+            gen_helper_vfmv_s_f_b, gen_helper_vfmv_s_f_h,
+            gen_helper_vfmv_s_f_w, gen_helper_vfmv_s_f_d
+        };
+
+        src1 = tcg_temp_new_i64();
+        dest = tcg_temp_new_ptr();
+        tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+
+        fns[s->sew](dest, src1, cpu_env);
+
+        tcg_temp_free_i64(src1);
+        tcg_temp_free_ptr(dest);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 66ee69da99..3235c3fbe1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4475,3 +4475,39 @@ GEN_VEXT_VMV_S_X(vmv_s_x_b, uint8_t, H1, clearb)
 GEN_VEXT_VMV_S_X(vmv_s_x_h, uint16_t, H2, clearh)
 GEN_VEXT_VMV_S_X(vmv_s_x_w, uint32_t, H4, clearl)
 GEN_VEXT_VMV_S_X(vmv_s_x_d, uint64_t, H8, clearq)
+
+/* Floating-Point Scalar Move Instructions */
+#define GEN_VEXT_VFMV_S_F(NAME, ETYPE, H, CLEAR_FN)                     \
+void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env)            \
+{                                                                       \
+    if (env->vl == 0) {                                                 \
+        return;                                                         \
+    }                                                                   \
+    *((ETYPE *)vd + H(0)) = s1;                                         \
+    CLEAR_FN(vd, 1, sizeof(ETYPE), env_archcpu(env)->cfg.vlen / 8);     \
+}
+GEN_VEXT_VFMV_S_F(vfmv_s_f_b, uint8_t, H1, clearb)
+GEN_VEXT_VFMV_S_F(vfmv_s_f_h, uint16_t, H2, clearh)
+GEN_VEXT_VFMV_S_F(vfmv_s_f_w, uint32_t, H4, clearl)
+GEN_VEXT_VFMV_S_F(vfmv_s_f_d, uint64_t, H8, clearq)
+
+uint64_t HELPER(vfmv_f_s_b)(void *vs2, CPURISCVState *env)
+{
+    return deposit64(-1ULL, 0, 8, *((uint8_t *)vs2 + H1(0)));
+}
+uint64_t HELPER(vfmv_f_s_h)(void *vs2, CPURISCVState *env)
+{
+    return deposit64(-1ULL, 0, 16, *((uint16_t *)vs2 + H2(0)));
+}
+uint64_t HELPER(vfmv_f_s_w)(void *vs2, CPURISCVState *env)
+{
+    return deposit64(-1ULL, 0, 32, *((uint32_t *)vs2 + H4(0)));
+}
+uint64_t HELPER(vfmv_f_s_d)(void *vs2, CPURISCVState *env)
+{
+    if (env->misa & RVD) {
+        return *((uint64_t *)vs2);
+    } else {
+        return deposit64(*((uint64_t *)vs2), 32, 32, 0xffffffff);
+    }
+}
-- 
2.23.0


