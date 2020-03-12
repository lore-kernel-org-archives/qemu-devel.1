Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9C3C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE0B206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE0B206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRBu-00032S-DA
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCR0R-0006Li-9C
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCR0P-0006AS-Tz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:48:23 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCR0P-00067h-FJ; Thu, 12 Mar 2020 12:48:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07810162|-1; CH=blue; DM=||false|;
 DS=CONTINUE|ham_system_inform|0.482373-0.000284395-0.517343;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03279; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=10; RT=10; SR=0; TI=SMTPD_---.H-QGAAB_1584031686; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H-QGAAB_1584031686)
 by smtp.aliyun-inc.com(10.147.41.120);
 Fri, 13 Mar 2020 00:48:07 +0800
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: richard.henderson@linaro.org, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
Subject: [PATCH v5 54/60] target/riscv: integer extract instruction
Date: Thu, 12 Mar 2020 22:58:54 +0800
Message-Id: <20200312145900.2054-55-zhiwei_liu@c-sky.com>
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
 target/riscv/helper.h                   |  5 ++++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.inc.c | 33 +++++++++++++++++++++++++
 target/riscv/vector_helper.c            | 20 +++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e3f2970221..d94347a9a5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1101,3 +1101,8 @@ DEF_HELPER_4(vid_v_b, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vid_v_h, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vid_v_w, void, ptr, ptr, env, i32)
 DEF_HELPER_4(vid_v_d, void, ptr, ptr, env, i32)
+
+DEF_HELPER_3(vext_x_v_b, tl, ptr, tl, env)
+DEF_HELPER_3(vext_x_v_h, tl, ptr, tl, env)
+DEF_HELPER_3(vext_x_v_w, tl, ptr, tl, env)
+DEF_HELPER_3(vext_x_v_d, tl, ptr, tl, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 1504059415..c26a186d6a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -555,6 +555,7 @@ vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010110 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010110 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1ff72a6406..46651dfb10 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2210,3 +2210,36 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
     }
     return false;
 }
+
+/*
+ *** Vector Permutation Instructions
+ */
+/* Integer Extract Instruction */
+typedef void (* gen_helper_vext_x_v)(TCGv, TCGv_ptr, TCGv, TCGv_env);
+static bool trans_vext_x_v(DisasContext *s, arg_r *a)
+{
+    if (vext_check_isa_ill(s, RVV)) {
+        TCGv_ptr src2;
+        TCGv dest, src1;
+        gen_helper_vext_x_v fns[4] = {
+            gen_helper_vext_x_v_b, gen_helper_vext_x_v_h,
+            gen_helper_vext_x_v_w, gen_helper_vext_x_v_d
+        };
+
+        dest = tcg_temp_new();
+        src1 = tcg_temp_new();
+        src2 = tcg_temp_new_ptr();
+
+        gen_get_gpr(src1, a->rs1);
+        tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
+
+        fns[s->sew](dest, src2, src1, cpu_env);
+        gen_set_gpr(a->rd, dest);
+
+        tcg_temp_free(dest);
+        tcg_temp_free(src1);
+        tcg_temp_free_ptr(src2);
+        return true;
+    }
+    return false;
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ff3b60e9c8..8704ee120f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4440,3 +4440,23 @@ GEN_VEXT_VID_V(vid_v_b, uint8_t, H1, clearb)
 GEN_VEXT_VID_V(vid_v_h, uint16_t, H2, clearh)
 GEN_VEXT_VID_V(vid_v_w, uint32_t, H4, clearl)
 GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
+
+/*
+ *** Vector Permutation Instructions
+ */
+/* Integer Extract Instruction */
+#define GEN_VEXT_X_V(NAME, ETYPE, H)                    \
+target_ulong HELPER(NAME)(void *vs2, target_ulong s1,   \
+        CPURISCVState *env)                             \
+{                                                       \
+    uint32_t vlen = env_archcpu(env)->cfg.vlen / 8;     \
+                                                        \
+    if (s1 >= vlen / sizeof(ETYPE)) {                   \
+        return 0;                                       \
+    }                                                   \
+    return *((ETYPE *)vs2 + s1);                        \
+}
+GEN_VEXT_X_V(vext_x_v_b, uint8_t, H1)
+GEN_VEXT_X_V(vext_x_v_h, uint16_t, H2)
+GEN_VEXT_X_V(vext_x_v_w, uint32_t, H4)
+GEN_VEXT_X_V(vext_x_v_d, uint64_t, H8)
-- 
2.23.0


