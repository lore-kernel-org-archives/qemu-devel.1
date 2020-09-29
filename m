Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E2C47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74245207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fGe83gXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74245207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLX5-0005Zw-Fl
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKy8-0005mc-VM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:21 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:41110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKy7-0002Do-8l
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:20 -0400
Received: by mail-pg1-x536.google.com with SMTP id 197so4628663pge.8
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Xq6Iw2hoDfvQ4Ml31Pq+NunnSNa6vOOggEqLC3ydkBc=;
 b=fGe83gXENt1eSJu6l0JdkqvBiaSvchNtbhdPoBcBZmJvp0/2oahTIJQLp4i4QP5Eeo
 pQSbS7IC5P9gCN+z4ZcdA7C0YQhC33G8WCg9IGrZXPOw6gluwMN0yAiF0jAbEfqckbJH
 llqCyDOLou13n1bGiHRkoMd0fflrvNjalsZxqsrER7gFCAc0oI3MEeSJPhoOrezfV2yL
 S9UtzzFWbOkf/HHEd9G9jpo6/9z9QQludECUKMpfIr21jeqTorBYqM9UOi2ip2VAynem
 /aaPSbO8SdiHCaZQBniWx990G/3mKCctc5lTFTEVvjKJJJNoHER7fVpF8rAFtpWGWT2q
 6Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Xq6Iw2hoDfvQ4Ml31Pq+NunnSNa6vOOggEqLC3ydkBc=;
 b=Svie1rfxxaPh71e6M4tHrDKOHZcYRBs2hDON96w+6HbVyZAzLhnC/Liq9oBPFNBs8V
 nwhnN8Aps2msvomu9IaXVt57cfcopOKlY5NABNxhRfo0Q1LfvR16Xq+ua6WAWjAw4HOh
 6vQorSud/0NiNiy/tFoSInR5JGjNVBBcsdokB3KvtSazIkJ9zN1hN2cvAFa3aBuntK7w
 RkrtjYig8eE1mz/M6SaTKqO4jZZkDT5FbFxpoxvOz0hi0Nh3fBcxSP/EBLP8PnwkaYm7
 RK9rZD9sKhPrYFi19pBqwnzKiP8pHUNWaRmMaYKXssCCCGGX/DfK9OXbXP9boCZ68iS2
 +1OQ==
X-Gm-Message-State: AOAM530xo4KKJs/h7RoR/c08Fn6Qk2X8E9vNu6t2/GBK66qpCRB9l22H
 aPeKDoH1yPS31h1z8Jq3jbJKP6Vu2wRu8A==
X-Google-Smtp-Source: ABdhPJyXhXSmUjswfmsUjSFKS5YZfQ4tj1bzooSJHXzoc3yadROgjJA7cM/9/ar0ZdMvbLT4lZqEXg==
X-Received: by 2002:a63:1226:: with SMTP id h38mr4311356pgl.196.1601406437708; 
 Tue, 29 Sep 2020 12:07:17 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:17 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 34/68] target/riscv: rvv-1.0: register gather instructions
Date: Wed, 30 Sep 2020 03:04:09 +0800
Message-Id: <20200929190448.31116-35-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x536.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

* Add vrgatherei16.vv instruction.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  4 ++++
 target/riscv/insn32.decode              |  1 +
 target/riscv/insn_trans/trans_rvv.c.inc | 23 ++++++++++++++++++++---
 target/riscv/vector_helper.c            | 23 ++++++++++++++---------
 4 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 8d40009871..287500db8b 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1109,6 +1109,10 @@ DEF_HELPER_6(vrgather_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgatherei16_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgatherei16_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgatherei16_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vrgatherei16_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vrgather_vx_w, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index c3b42b051c..5555fa2906 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -620,6 +620,7 @@ vslidedown_vx   001111 . ..... ..... 100 ..... 1010111 @r_vm
 vslidedown_vi   001111 . ..... ..... 011 ..... 1010111 @r_vm
 vslide1down_vx  001111 . ..... ..... 110 ..... 1010111 @r_vm
 vrgather_vv     001100 . ..... ..... 000 ..... 1010111 @r_vm
+vrgatherei16_vv 001110 . ..... ..... 000 ..... 1010111 @r_vm
 vrgather_vx     001100 . ..... ..... 100 ..... 1010111 @r_vm
 vrgather_vi     001100 . ..... ..... 011 ..... 1010111 @r_vm
 vcompress_vm    010111 - ..... ..... 010 ..... 1010111 @r
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 6c542a97d8..97a7ff0251 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3335,7 +3335,21 @@ static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
            require_vm(a->vm, a->rd);
 }
 
+static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
+{
+    int8_t emul = MO_16 - s->sew + s->lmul;
+    return require_rvv(s) &&
+           vext_check_isa_ill(s) &&
+           (emul >= -3 && emul <= 3) &&
+           require_align(a->rd, s->lmul) &&
+           require_align(a->rs1, emul) &&
+           require_align(a->rs2, s->lmul) &&
+           (a->rd != a->rs2 && a->rd != a->rs1) &&
+           require_vm(a->vm, a->rd);
+}
+
 GEN_OPIVV_TRANS(vrgather_vv, vrgather_vv_check)
+GEN_OPIVV_TRANS(vrgatherei16_vv, vrgatherei16_vv_check)
 
 static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
 {
@@ -3355,7 +3369,8 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax) {
-        int vlmax = s->vlen;
+        int scale = s->lmul - (s->sew + 3);
+        int vlmax = scale < 0 ? s->vlen >> -scale : s->vlen << scale;
         TCGv_i64 dest = tcg_temp_new_i64();
 
         if (a->rs1 == 0) {
@@ -3386,8 +3401,10 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax) {
-        if (a->rs1 >= s->vlen) {
-            tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd),
+        int scale = s->lmul - (s->sew + 3);
+        int vlmax = scale < 0 ? s->vlen >> -scale : s->vlen << scale;
+        if (a->rs1 >= vlmax) {
+            tcg_gen_gvec_dup_imm(MO_64, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), 0);
         } else {
             tcg_gen_gvec_dup_mem(s->sew, vreg_ofs(s, a->rd),
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8ccf538141..782fe086f3 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4666,11 +4666,11 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8)
 
 /* Vector Register Gather Instruction */
-#define GEN_VEXT_VRGATHER_VV(NAME, ETYPE, H)                              \
+#define GEN_VEXT_VRGATHER_VV(NAME, TS1, TS2, HS1, HS2)                    \
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(ETYPE)));           \
+    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(TS1)));             \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t index, i;                                                    \
@@ -4679,20 +4679,25 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
-        index = *((ETYPE *)vs1 + H(i));                                   \
+        index = *((TS1 *)vs1 + HS1(i));                                   \
         if (index >= vlmax) {                                             \
-            *((ETYPE *)vd + H(i)) = 0;                                    \
+            *((TS2 *)vd + HS2(i)) = 0;                                    \
         } else {                                                          \
-            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(index));           \
+            *((TS2 *)vd + HS2(i)) = *((TS2 *)vs2 + HS2(index));           \
         }                                                                 \
     }                                                                     \
 }
 
 /* vd[i] = (vs1[i] >= VLMAX) ? 0 : vs2[vs1[i]]; */
-GEN_VEXT_VRGATHER_VV(vrgather_vv_b, uint8_t,  H1)
-GEN_VEXT_VRGATHER_VV(vrgather_vv_h, uint16_t, H2)
-GEN_VEXT_VRGATHER_VV(vrgather_vv_w, uint32_t, H4)
-GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, H8)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_b, uint8_t,  uint8_t,  H1, H1)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_h, uint16_t, uint16_t, H2, H2)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_w, uint32_t, uint32_t, H4, H4)
+GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, uint64_t, H8, H8)
+
+GEN_VEXT_VRGATHER_VV(vrgatherei16_vv_b, uint16_t, uint8_t,  H2, H1)
+GEN_VEXT_VRGATHER_VV(vrgatherei16_vv_h, uint16_t, uint16_t, H2, H2)
+GEN_VEXT_VRGATHER_VV(vrgatherei16_vv_w, uint16_t, uint32_t, H2, H4)
+GEN_VEXT_VRGATHER_VV(vrgatherei16_vv_d, uint16_t, uint64_t, H2, H8)
 
 #define GEN_VEXT_VRGATHER_VX(NAME, ETYPE, H)                              \
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
-- 
2.17.1


