Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4694DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD50D22CF7
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A164OJm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD50D22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dWk-0002YC-Vj
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRC-0001Rq-Ce
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:54 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:41229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dR8-0007js-Vn
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:54 -0400
Received: by mail-pg1-x533.google.com with SMTP id s15so14938723pgc.8
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sjuXKk73Zhx7raSEYzx5IgPONGCP5t1kTRqQVkY1AVg=;
 b=A164OJm89AqG7ySMu5esoF0r+dfu35tpKh7arYUISfjsaZBJFQia03bt6V6HUfxJ+J
 vmvPot6nm4Raqh8jdh0TJBC2xxDR0a/bMNMhP4grJoZSMEa4It4w/jcSbrNw4U7ykFGP
 3FVKXC9J1KuyC//bnMd+fAa/TOS0tWmsFGUgv/qE9ix8i+GGfO7QB6wmkYoIr62tmcnZ
 YJKJvDbQ6WAhWMcG5Wfi4/f86IJrGJ46j7FDpZ39VVWZqlZ/1vmbqQs8dMY1c/Qlu8YH
 9Jwt2qukCs5YXxROEfz3Kmidf8yQcBX950dEmKHMHZ2aQNNUVRQEn5ctKtfgdfinxnn8
 6vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sjuXKk73Zhx7raSEYzx5IgPONGCP5t1kTRqQVkY1AVg=;
 b=gD62+Oho0qk57dCuHqPUpjpGGGtbJKEm0s6irjWKyMGX/PtcQ4HVlPTwrIak1xejpN
 qXCPJAHeecM7Yi8Mvwp8IitbSqpb6f0MOnVHkEwX9LvDc4HkIHkh7wgjNTs8O06Y6XS8
 K4jYEaDv7Fhp0PNstfpZfBu8TQj0PJe6VitngW+bEyPzCHYFq4g/uAIo277JTalo3YQW
 uGri4DAuLxT3ISwqVDWcvs8yCtvT8YjZ8uRIDAtHUacaI0UDshx1nFZjYVJakrDDukHt
 awCSqDyK7KM0aKdXafLysj0c2gyd4Y9PyufjOMrzmR6WyzpYWNFSjU0D2ACQ8Jyify4A
 nKRA==
X-Gm-Message-State: AOAM532fy+EL/pfoGPM0zHKeXQz7pE3wff/4uLOVTJ7UEQJ3cVt9NcuJ
 3pVyzORvVtn1+tvWhi8GMtvlyp/LKak=
X-Google-Smtp-Source: ABdhPJzpMsF4CI1/wjtuejZ6p7JJnjSrEEwh4MSC8VkUDEdeHkmNX3j0I2R88imC1oL1vQcdo6MWXQ==
X-Received: by 2002:a63:e907:: with SMTP id i7mr6963385pgh.210.1596710868478; 
 Thu, 06 Aug 2020 03:47:48 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:47 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 11/71] target/riscv: rvv-1.0: remove MLEN calculations
Date: Thu,  6 Aug 2020 18:46:08 +0800
Message-Id: <20200806104709.13235-12-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

As in RVV 1.0 design, MLEN is hardcoded with value 1 (Section 4.5).
Thus, remove all MLEN related calculations.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.inc.c |  35 +---
 target/riscv/internals.h                |   9 +-
 target/riscv/translate.c                |   2 -
 target/riscv/vector_helper.c            | 250 ++++++++++--------------
 4 files changed, 110 insertions(+), 186 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1b021603c1c..b529474403e 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -247,7 +247,6 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
         return false;
     }
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
@@ -300,7 +299,6 @@ static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
         return false;
     }
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
@@ -387,7 +385,6 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
         return false;
     }
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
@@ -426,7 +423,6 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
           gen_helper_vsse_v_w,  gen_helper_vsse_v_d }
     };
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
@@ -518,7 +514,6 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
         return false;
     }
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
@@ -570,7 +565,6 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
         return false;
     }
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
@@ -649,7 +643,6 @@ static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
         return false;
     }
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
@@ -760,7 +753,6 @@ static bool amo_op(DisasContext *s, arg_rwdvm *a, uint8_t seq)
         }
     }
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     data = FIELD_DP32(data, VDATA, WD, a->wd);
@@ -839,7 +831,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
     } else {
         uint32_t data = 0;
 
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
@@ -885,7 +876,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     src1 = tcg_temp_new();
     gen_get_gpr(src1, rs1);
 
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
@@ -1034,7 +1024,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     } else {
         src1 = tcg_const_tl(sextract64(imm, 0, 5));
     }
-    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
     desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
@@ -1130,7 +1119,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
@@ -1219,7 +1207,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
@@ -1298,7 +1285,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         TCGLabel *over = gen_new_label();                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
@@ -1489,7 +1475,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         TCGLabel *over = gen_new_label();                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
@@ -1859,7 +1844,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         gen_set_rm(s, 7);                                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
@@ -1932,7 +1916,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
             gen_helper_##NAME##_d,                                \
         };                                                        \
         gen_set_rm(s, 7);                                         \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);            \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);            \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
@@ -1973,7 +1956,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         gen_set_rm(s, 7);                                        \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);        \
                                                                  \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
@@ -2011,7 +1993,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
         gen_set_rm(s, 7);                                        \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
@@ -2048,7 +2029,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         gen_set_rm(s, 7);                                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
@@ -2084,7 +2064,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
         gen_set_rm(s, 7);                                        \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);           \
         data = FIELD_DP32(data, VDATA, VM, a->vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
@@ -2164,7 +2143,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         gen_set_rm(s, 7);                                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
@@ -2307,7 +2285,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         gen_set_rm(s, 7);                                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
@@ -2356,7 +2333,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         gen_set_rm(s, 7);                                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
@@ -2419,7 +2395,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         TCGLabel *over = gen_new_label();                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
                            vreg_ofs(s, a->rs1),                    \
@@ -2449,7 +2424,6 @@ static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
         TCGv dst;
         TCGv_i32 desc;
         uint32_t data = 0;
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
 
@@ -2481,7 +2455,6 @@ static bool trans_vmfirst_m(DisasContext *s, arg_rmr *a)
         TCGv dst;
         TCGv_i32 desc;
         uint32_t data = 0;
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
 
@@ -2517,7 +2490,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         TCGLabel *over = gen_new_label();                          \
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
         data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
         tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd),                     \
@@ -2545,7 +2517,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         static gen_helper_gvec_3_ptr * const fns[4] = {
@@ -2572,7 +2543,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
         data = FIELD_DP32(data, VDATA, VM, a->vm);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         static gen_helper_gvec_2_ptr * const fns[4] = {
@@ -2863,7 +2833,7 @@ static bool trans_vrgather_vx(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax) {
-        int vlmax = s->vlen / s->mlen;
+        int vlmax = s->vlen;
         TCGv_i64 dest = tcg_temp_new_i64();
 
         if (a->rs1 == 0) {
@@ -2894,7 +2864,7 @@ static bool trans_vrgather_vi(DisasContext *s, arg_rmrr *a)
     }
 
     if (a->vm && s->vl_eq_vlmax) {
-        if (a->rs1 >= s->vlen / s->mlen) {
+        if (a->rs1 >= s->vlen) {
             tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), 0);
         } else {
@@ -2934,7 +2904,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
         TCGLabel *over = gen_new_label();
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
-        data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
                            vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index f1a546dba64..bca48297dab 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -22,11 +22,10 @@
 #include "hw/registerfields.h"
 
 /* share data between vector helpers and decode code */
-FIELD(VDATA, MLEN, 0, 8)
-FIELD(VDATA, VM, 8, 1)
-FIELD(VDATA, LMUL, 9, 2)
-FIELD(VDATA, NF, 11, 4)
-FIELD(VDATA, WD, 11, 1)
+FIELD(VDATA, VM, 0, 1)
+FIELD(VDATA, LMUL, 1, 3)
+FIELD(VDATA, NF, 4, 4)
+FIELD(VDATA, WD, 4, 1)
 
 /* float point classify helpers */
 target_ulong fclass_h(uint64_t frs1);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index eb42777aa28..7b6088677d4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -62,7 +62,6 @@ typedef struct DisasContext {
     uint8_t lmul;
     uint8_t sew;
     uint16_t vlen;
-    uint16_t mlen;
     bool vl_eq_vlmax;
 } DisasContext;
 
@@ -853,7 +852,6 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
-    ctx->mlen = 1 << (ctx->sew  + 3 - ctx->lmul);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
 }
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 43ba272c09b..f42346cb9ca 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -81,11 +81,6 @@ static inline uint32_t vext_nf(uint32_t desc)
     return FIELD_EX32(simd_data(desc), VDATA, NF);
 }
 
-static inline uint32_t vext_mlen(uint32_t desc)
-{
-    return FIELD_EX32(simd_data(desc), VDATA, MLEN);
-}
-
 static inline uint32_t vext_vm(uint32_t desc)
 {
     return FIELD_EX32(simd_data(desc), VDATA, VM);
@@ -188,19 +183,24 @@ static void clearq(void *vd, uint32_t idx, uint32_t cnt, uint32_t tot)
     vext_clear(cur, cnt, tot);
 }
 
-static inline void vext_set_elem_mask(void *v0, int mlen, int index,
+static inline void vext_set_elem_mask(void *v0, int index,
         uint8_t value)
 {
-    int idx = (index * mlen) / 64;
-    int pos = (index * mlen) % 64;
+    int idx = index / 64;
+    int pos = index % 64;
     uint64_t old = ((uint64_t *)v0)[idx];
-    ((uint64_t *)v0)[idx] = deposit64(old, pos, mlen, value);
+    ((uint64_t *)v0)[idx] = deposit64(old, pos, 1, value);
 }
 
-static inline int vext_elem_mask(void *v0, int mlen, int index)
+/*
+ * Earlier designs (pre-0.9) had a varying number of bits
+ * per mask value (MLEN). In the 0.9 design, MLEN=1.
+ * (Section 4.6)
+ */
+static inline int vext_elem_mask(void *v0, int index)
 {
-    int idx = (index * mlen) / 64;
-    int pos = (index * mlen) % 64;
+    int idx = index / 64;
+    int pos = index  % 64;
     return (((uint64_t *)v0)[idx] >> pos) & 1;
 }
 
@@ -277,12 +277,11 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
 {
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         probe_pages(env, base + stride * i, nf * msz, ra, access_type);
@@ -290,7 +289,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
     /* do real access */
     for (i = 0; i < env->vl; i++) {
         k = 0;
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         while (k < nf) {
@@ -506,12 +505,11 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     uint32_t i, k;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         probe_pages(env, get_index_addr(base, i, vs2), nf * msz, ra,
@@ -520,7 +518,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     /* load bytes from guest memory */
     for (i = 0; i < env->vl; i++) {
         k = 0;
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         while (k < nf) {
@@ -604,7 +602,6 @@ vext_ldff(void *vd, void *v0, target_ulong base,
 {
     void *host;
     uint32_t i, k, vl = 0;
-    uint32_t mlen = vext_mlen(desc);
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
@@ -612,7 +609,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
 
     /* probe every access*/
     for (i = 0; i < env->vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         addr = base + nf * i * msz;
@@ -653,7 +650,7 @@ ProbeSuccess:
     }
     for (i = 0; i < env->vl; i++) {
         k = 0;
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         while (k < nf) {
@@ -784,18 +781,17 @@ vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
     target_long addr;
     uint32_t wd = vext_wd(desc);
     uint32_t vm = vext_vm(desc);
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vlmax = vext_maxsz(desc) / esz;
 
     for (i = 0; i < env->vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         probe_pages(env, get_index_addr(base, i, vs2), msz, ra, MMU_DATA_LOAD);
         probe_pages(env, get_index_addr(base, i, vs2), msz, ra, MMU_DATA_STORE);
     }
     for (i = 0; i < env->vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         addr = get_index_addr(base, i, vs2);
@@ -911,13 +907,12 @@ static void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
                        opivv2_fn *fn, clear_fn *clearfn)
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     uint32_t i;
 
     for (i = 0; i < vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         fn(vd, vs1, vs2, i);
@@ -976,13 +971,12 @@ static void do_vext_vx(void *vd, void *v0, target_long s1, void *vs2,
                        opivx2_fn fn, clear_fn *clearfn)
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     uint32_t i;
 
     for (i = 0; i < vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         fn(vd, s1, vs2, i);
@@ -1172,7 +1166,6 @@ GEN_VEXT_VX(vwsub_wx_w, 4, 8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
                   CPURISCVState *env, uint32_t desc)          \
 {                                                             \
-    uint32_t mlen = vext_mlen(desc);                          \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
     uint32_t vlmax = vext_maxsz(desc) / esz;                  \
@@ -1181,7 +1174,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     for (i = 0; i < vl; i++) {                                \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        uint8_t carry = vext_elem_mask(v0, mlen, i);          \
+        uint8_t carry = vext_elem_mask(v0, i);                \
                                                               \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, s1, carry);         \
     }                                                         \
@@ -1202,7 +1195,6 @@ GEN_VEXT_VADC_VVM(vsbc_vvm_d, uint64_t, H8, DO_VSBC, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
                   CPURISCVState *env, uint32_t desc)                     \
 {                                                                        \
-    uint32_t mlen = vext_mlen(desc);                                     \
     uint32_t vl = env->vl;                                               \
     uint32_t esz = sizeof(ETYPE);                                        \
     uint32_t vlmax = vext_maxsz(desc) / esz;                             \
@@ -1210,7 +1202,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,        \
                                                                          \
     for (i = 0; i < vl; i++) {                                           \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                               \
-        uint8_t carry = vext_elem_mask(v0, mlen, i);                     \
+        uint8_t carry = vext_elem_mask(v0, i);                           \
                                                                          \
         *((ETYPE *)vd + H(i)) = DO_OP(s2, (ETYPE)(target_long)s1, carry);\
     }                                                                    \
@@ -1235,7 +1227,6 @@ GEN_VEXT_VADC_VXM(vsbc_vxm_d, uint64_t, H8, DO_VSBC, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
                   CPURISCVState *env, uint32_t desc)          \
 {                                                             \
-    uint32_t mlen = vext_mlen(desc);                          \
     uint32_t vl = env->vl;                                    \
     uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
     uint32_t i;                                               \
@@ -1243,12 +1234,12 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     for (i = 0; i < vl; i++) {                                \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        uint8_t carry = vext_elem_mask(v0, mlen, i);          \
+        uint8_t carry = vext_elem_mask(v0, i);                \
                                                               \
-        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, s1, carry));\
+        vext_set_elem_mask(vd, i, DO_OP(s2, s1, carry));      \
     }                                                         \
     for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, mlen, i, 0);                   \
+        vext_set_elem_mask(vd, i, 0);                         \
     }                                                         \
 }
 
@@ -1266,20 +1257,19 @@ GEN_VEXT_VMADC_VVM(vmsbc_vvm_d, uint64_t, H8, DO_MSBC)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1,          \
                   void *vs2, CPURISCVState *env, uint32_t desc) \
 {                                                               \
-    uint32_t mlen = vext_mlen(desc);                            \
     uint32_t vl = env->vl;                                      \
     uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);          \
     uint32_t i;                                                 \
                                                                 \
     for (i = 0; i < vl; i++) {                                  \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                      \
-        uint8_t carry = vext_elem_mask(v0, mlen, i);            \
+        uint8_t carry = vext_elem_mask(v0, i);                  \
                                                                 \
-        vext_set_elem_mask(vd, mlen, i,                         \
+        vext_set_elem_mask(vd, i,                               \
                 DO_OP(s2, (ETYPE)(target_long)s1, carry));      \
     }                                                           \
     for (; i < vlmax; i++) {                                    \
-        vext_set_elem_mask(vd, mlen, i, 0);                     \
+        vext_set_elem_mask(vd, i, 0);                           \
     }                                                           \
 }
 
@@ -1353,7 +1343,6 @@ GEN_VEXT_VX(vxor_vx_d, 8, 8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
                   void *vs2, CPURISCVState *env, uint32_t desc)           \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t esz = sizeof(TS1);                                           \
@@ -1361,7 +1350,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,                          \
     uint32_t i;                                                           \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         TS1 s1 = *((TS1 *)vs1 + HS1(i));                                  \
@@ -1391,7 +1380,6 @@ GEN_VEXT_SHIFT_VV(vsra_vv_d, uint64_t, int64_t, H8, H8, DO_SRL, 0x3f, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
         void *vs2, CPURISCVState *env, uint32_t desc)                 \
 {                                                                     \
-    uint32_t mlen = vext_mlen(desc);                                  \
     uint32_t vm = vext_vm(desc);                                      \
     uint32_t vl = env->vl;                                            \
     uint32_t esz = sizeof(TD);                                        \
@@ -1399,7 +1387,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,                \
     uint32_t i;                                                       \
                                                                       \
     for (i = 0; i < vl; i++) {                                        \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                    \
+        if (!vm && !vext_elem_mask(v0, i)) {                          \
             continue;                                                 \
         }                                                             \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                              \
@@ -1448,7 +1436,6 @@ GEN_VEXT_SHIFT_VX(vnsra_vx_w, int32_t, int64_t, H4, H8, DO_SRL, 0x3f, clearl)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
                   CPURISCVState *env, uint32_t desc)          \
 {                                                             \
-    uint32_t mlen = vext_mlen(desc);                          \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
     uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
@@ -1457,13 +1444,13 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     for (i = 0; i < vl; i++) {                                \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {            \
+        if (!vm && !vext_elem_mask(v0, i)) {                  \
             continue;                                         \
         }                                                     \
-        vext_set_elem_mask(vd, mlen, i, DO_OP(s2, s1));       \
+        vext_set_elem_mask(vd, i, DO_OP(s2, s1));             \
     }                                                         \
     for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, mlen, i, 0);                   \
+        vext_set_elem_mask(vd, i, 0);                         \
     }                                                         \
 }
 
@@ -1501,7 +1488,6 @@ GEN_VEXT_CMP_VV(vmsle_vv_d, int64_t, H8, DO_MSLE)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
                   CPURISCVState *env, uint32_t desc)                \
 {                                                                   \
-    uint32_t mlen = vext_mlen(desc);                                \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
     uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
@@ -1509,14 +1495,14 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,   \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                  \
+        if (!vm && !vext_elem_mask(v0, i)) {                        \
             continue;                                               \
         }                                                           \
-        vext_set_elem_mask(vd, mlen, i,                             \
+        vext_set_elem_mask(vd, i,                                   \
                 DO_OP(s2, (ETYPE)(target_long)s1));                 \
     }                                                               \
     for (; i < vlmax; i++) {                                        \
-        vext_set_elem_mask(vd, mlen, i, 0);                         \
+        vext_set_elem_mask(vd, i, 0);                               \
     }                                                               \
 }
 
@@ -2078,14 +2064,13 @@ GEN_VEXT_VMV_VX(vmv_v_x_d, int64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
                   CPURISCVState *env, uint32_t desc)                 \
 {                                                                    \
-    uint32_t mlen = vext_mlen(desc);                                 \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t vlmax = vext_maxsz(desc) / esz;                         \
     uint32_t i;                                                      \
                                                                      \
     for (i = 0; i < vl; i++) {                                       \
-        ETYPE *vt = (!vext_elem_mask(v0, mlen, i) ? vs2 : vs1);      \
+        ETYPE *vt = (!vext_elem_mask(v0, i) ? vs2 : vs1);            \
         *((ETYPE *)vd + H(i)) = *(vt + H(i));                        \
     }                                                                \
     CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                         \
@@ -2100,7 +2085,6 @@ GEN_VEXT_VMERGE_VV(vmerge_vvm_d, int64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
                   void *vs2, CPURISCVState *env, uint32_t desc)      \
 {                                                                    \
-    uint32_t mlen = vext_mlen(desc);                                 \
     uint32_t vl = env->vl;                                           \
     uint32_t esz = sizeof(ETYPE);                                    \
     uint32_t vlmax = vext_maxsz(desc) / esz;                         \
@@ -2108,7 +2092,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1,               \
                                                                      \
     for (i = 0; i < vl; i++) {                                       \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                           \
-        ETYPE d = (!vext_elem_mask(v0, mlen, i) ? s2 :               \
+        ETYPE d = (!vext_elem_mask(v0, i) ? s2 :                     \
                    (ETYPE)(target_long)s1);                          \
         *((ETYPE *)vd + H(i)) = d;                                   \
     }                                                                \
@@ -2146,11 +2130,11 @@ do_##NAME(void *vd, void *vs1, void *vs2, int i,                    \
 static inline void
 vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              CPURISCVState *env,
-             uint32_t vl, uint32_t vm, uint32_t mlen, int vxrm,
+             uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn)
 {
     for (uint32_t i = 0; i < vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         fn(vd, vs1, vs2, i, env, vxrm);
@@ -2164,26 +2148,25 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
              opivv2_rm_fn *fn, clear_fn *clearfn)
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
 
     switch (env->vxrm) {
     case 0: /* rnu */
         vext_vv_rm_1(vd, v0, vs1, vs2,
-                     env, vl, vm, mlen, 0, fn);
+                     env, vl, vm, 0, fn);
         break;
     case 1: /* rne */
         vext_vv_rm_1(vd, v0, vs1, vs2,
-                     env, vl, vm, mlen, 1, fn);
+                     env, vl, vm, 1, fn);
         break;
     case 2: /* rdn */
         vext_vv_rm_1(vd, v0, vs1, vs2,
-                     env, vl, vm, mlen, 2, fn);
+                     env, vl, vm, 2, fn);
         break;
     default: /* rod */
         vext_vv_rm_1(vd, v0, vs1, vs2,
-                     env, vl, vm, mlen, 3, fn);
+                     env, vl, vm, 3, fn);
         break;
     }
 
@@ -2266,11 +2249,11 @@ do_##NAME(void *vd, target_long s1, void *vs2, int i,               \
 static inline void
 vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              CPURISCVState *env,
-             uint32_t vl, uint32_t vm, uint32_t mlen, int vxrm,
+             uint32_t vl, uint32_t vm, int vxrm,
              opivx2_rm_fn *fn)
 {
     for (uint32_t i = 0; i < vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         fn(vd, s1, vs2, i, env, vxrm);
@@ -2284,26 +2267,25 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
              opivx2_rm_fn *fn, clear_fn *clearfn)
 {
     uint32_t vlmax = vext_maxsz(desc) / esz;
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
 
     switch (env->vxrm) {
     case 0: /* rnu */
         vext_vx_rm_1(vd, v0, s1, vs2,
-                     env, vl, vm, mlen, 0, fn);
+                     env, vl, vm, 0, fn);
         break;
     case 1: /* rne */
         vext_vx_rm_1(vd, v0, s1, vs2,
-                     env, vl, vm, mlen, 1, fn);
+                     env, vl, vm, 1, fn);
         break;
     case 2: /* rdn */
         vext_vx_rm_1(vd, v0, s1, vs2,
-                     env, vl, vm, mlen, 2, fn);
+                     env, vl, vm, 2, fn);
         break;
     default: /* rod */
         vext_vx_rm_1(vd, v0, s1, vs2,
-                     env, vl, vm, mlen, 3, fn);
+                     env, vl, vm, 3, fn);
         break;
     }
 
@@ -3188,13 +3170,12 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   uint32_t desc)                          \
 {                                                         \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
-    uint32_t mlen = vext_mlen(desc);                      \
     uint32_t vm = vext_vm(desc);                          \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
                                                           \
     for (i = 0; i < vl; i++) {                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+        if (!vm && !vext_elem_mask(v0, i)) {              \
             continue;                                     \
         }                                                 \
         do_##NAME(vd, vs1, vs2, i, env);                  \
@@ -3223,13 +3204,12 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
                   uint32_t desc)                          \
 {                                                         \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;              \
-    uint32_t mlen = vext_mlen(desc);                      \
     uint32_t vm = vext_vm(desc);                          \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
                                                           \
     for (i = 0; i < vl; i++) {                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+        if (!vm && !vext_elem_mask(v0, i)) {              \
             continue;                                     \
         }                                                 \
         do_##NAME(vd, s1, vs2, i, env);                   \
@@ -3794,7 +3774,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         CPURISCVState *env, uint32_t desc)             \
 {                                                      \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
-    uint32_t mlen = vext_mlen(desc);                   \
     uint32_t vm = vext_vm(desc);                       \
     uint32_t vl = env->vl;                             \
     uint32_t i;                                        \
@@ -3803,7 +3782,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
         return;                                        \
     }                                                  \
     for (i = 0; i < vl; i++) {                         \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {     \
+        if (!vm && !vext_elem_mask(v0, i)) {           \
             continue;                                  \
         }                                              \
         do_##NAME(vd, vs2, i, env);                    \
@@ -3935,7 +3914,6 @@ GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
                   CPURISCVState *env, uint32_t desc)          \
 {                                                             \
-    uint32_t mlen = vext_mlen(desc);                          \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
     uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
@@ -3944,14 +3922,14 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     for (i = 0; i < vl; i++) {                                \
         ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {            \
+        if (!vm && !vext_elem_mask(v0, i)) {                  \
             continue;                                         \
         }                                                     \
-        vext_set_elem_mask(vd, mlen, i,                       \
+        vext_set_elem_mask(vd, i,                             \
                            DO_OP(s2, s1, &env->fp_status));   \
     }                                                         \
     for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, mlen, i, 0);                   \
+        vext_set_elem_mask(vd, i, 0);                         \
     }                                                         \
 }
 
@@ -3969,7 +3947,6 @@ GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
 void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
                   CPURISCVState *env, uint32_t desc)                \
 {                                                                   \
-    uint32_t mlen = vext_mlen(desc);                                \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
     uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);              \
@@ -3977,14 +3954,14 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                          \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                  \
+        if (!vm && !vext_elem_mask(v0, i)) {                        \
             continue;                                               \
         }                                                           \
-        vext_set_elem_mask(vd, mlen, i,                             \
+        vext_set_elem_mask(vd, i,                                   \
                            DO_OP(s2, (ETYPE)s1, &env->fp_status));  \
     }                                                               \
     for (; i < vlmax; i++) {                                        \
-        vext_set_elem_mask(vd, mlen, i, 0);                         \
+        vext_set_elem_mask(vd, i, 0);                               \
     }                                                               \
 }
 
@@ -4117,13 +4094,12 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
                   CPURISCVState *env, uint32_t desc)   \
 {                                                      \
     uint32_t vlmax = vext_maxsz(desc) / ESZ;           \
-    uint32_t mlen = vext_mlen(desc);                   \
     uint32_t vm = vext_vm(desc);                       \
     uint32_t vl = env->vl;                             \
     uint32_t i;                                        \
                                                        \
     for (i = 0; i < vl; i++) {                         \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {     \
+        if (!vm && !vext_elem_mask(v0, i)) {           \
             continue;                                  \
         }                                              \
         do_##NAME(vd, vs2, i);                         \
@@ -4200,7 +4176,6 @@ GEN_VEXT_V(vfclass_v_d, 8, 8, clearq)
 void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
                   CPURISCVState *env, uint32_t desc)          \
 {                                                             \
-    uint32_t mlen = vext_mlen(desc);                          \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
     uint32_t esz = sizeof(ETYPE);                             \
@@ -4210,7 +4185,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2, \
     for (i = 0; i < vl; i++) {                                \
         ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
         *((ETYPE *)vd + H(i))                                 \
-          = (!vm && !vext_elem_mask(v0, mlen, i) ? s2 : s1);  \
+          = (!vm && !vext_elem_mask(v0, i) ? s2 : s1);        \
     }                                                         \
     CLEAR_FN(vd, vl, vl * esz, vlmax * esz);                  \
 }
@@ -4341,7 +4316,6 @@ GEN_VEXT_V_ENV(vfncvt_f_f_v_w, 4, 4, clearl)
 void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         void *vs2, CPURISCVState *env, uint32_t desc)     \
 {                                                         \
-    uint32_t mlen = vext_mlen(desc);                      \
     uint32_t vm = vext_vm(desc);                          \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
@@ -4350,7 +4324,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                                                           \
     for (i = 0; i < vl; i++) {                            \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {        \
+        if (!vm && !vext_elem_mask(v0, i)) {              \
             continue;                                     \
         }                                                 \
         s1 = OP(s1, (TD)s2);                              \
@@ -4424,7 +4398,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
                   void *vs2, CPURISCVState *env,           \
                   uint32_t desc)                           \
 {                                                          \
-    uint32_t mlen = vext_mlen(desc);                       \
     uint32_t vm = vext_vm(desc);                           \
     uint32_t vl = env->vl;                                 \
     uint32_t i;                                            \
@@ -4433,7 +4406,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
                                                            \
     for (i = 0; i < vl; i++) {                             \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {         \
+        if (!vm && !vext_elem_mask(v0, i)) {               \
             continue;                                      \
         }                                                  \
         s1 = OP(s1, (TD)s2, &env->fp_status);              \
@@ -4462,7 +4435,6 @@ GEN_VEXT_FRED(vfredmin_vs_d, uint64_t, uint64_t, H8, H8, float64_minnum, clearq)
 void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
                             void *vs2, CPURISCVState *env, uint32_t desc)
 {
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     uint32_t i;
@@ -4471,7 +4443,7 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
 
     for (i = 0; i < vl; i++) {
         uint16_t s2 = *((uint16_t *)vs2 + H2(i));
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         s1 = float32_add(s1, float16_to_float32(s2, true, &env->fp_status),
@@ -4484,7 +4456,6 @@ void HELPER(vfwredsum_vs_h)(void *vd, void *v0, void *vs1,
 void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
                             void *vs2, CPURISCVState *env, uint32_t desc)
 {
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     uint32_t i;
@@ -4493,7 +4464,7 @@ void HELPER(vfwredsum_vs_w)(void *vd, void *v0, void *vs1,
 
     for (i = 0; i < vl; i++) {
         uint32_t s2 = *((uint32_t *)vs2 + H4(i));
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         s1 = float64_add(s1, float32_to_float64(s2, &env->fp_status),
@@ -4512,19 +4483,18 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    uint32_t mlen = vext_mlen(desc);                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;          \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
     int a, b;                                             \
                                                           \
     for (i = 0; i < vl; i++) {                            \
-        a = vext_elem_mask(vs1, mlen, i);                 \
-        b = vext_elem_mask(vs2, mlen, i);                 \
-        vext_set_elem_mask(vd, mlen, i, OP(b, a));        \
+        a = vext_elem_mask(vs1, i);                       \
+        b = vext_elem_mask(vs2, i);                       \
+        vext_set_elem_mask(vd, i, OP(b, a));              \
     }                                                     \
     for (; i < vlmax; i++) {                              \
-        vext_set_elem_mask(vd, mlen, i, 0);               \
+        vext_set_elem_mask(vd, i, 0);                     \
     }                                                     \
 }
 
@@ -4548,14 +4518,13 @@ target_ulong HELPER(vmpopc_m)(void *v0, void *vs2, CPURISCVState *env,
                               uint32_t desc)
 {
     target_ulong cnt = 0;
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     int i;
 
     for (i = 0; i < vl; i++) {
-        if (vm || vext_elem_mask(v0, mlen, i)) {
-            if (vext_elem_mask(vs2, mlen, i)) {
+        if (vm || vext_elem_mask(v0, i)) {
+            if (vext_elem_mask(vs2, i)) {
                 cnt++;
             }
         }
@@ -4567,14 +4536,13 @@ target_ulong HELPER(vmpopc_m)(void *v0, void *vs2, CPURISCVState *env,
 target_ulong HELPER(vmfirst_m)(void *v0, void *vs2, CPURISCVState *env,
                                uint32_t desc)
 {
-    uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     int i;
 
     for (i = 0; i < vl; i++) {
-        if (vm || vext_elem_mask(v0, mlen, i)) {
-            if (vext_elem_mask(vs2, mlen, i)) {
+        if (vm || vext_elem_mask(v0, i)) {
+            if (vext_elem_mask(vs2, i)) {
                 return i;
             }
         }
@@ -4591,39 +4559,38 @@ enum set_mask_type {
 static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
                    uint32_t desc, enum set_mask_type type)
 {
-    uint32_t mlen = vext_mlen(desc);
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     int i;
     bool first_mask_bit = false;
 
     for (i = 0; i < vl; i++) {
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+        if (!vm && !vext_elem_mask(v0, i)) {
             continue;
         }
         /* write a zero to all following active elements */
         if (first_mask_bit) {
-            vext_set_elem_mask(vd, mlen, i, 0);
+            vext_set_elem_mask(vd, i, 0);
             continue;
         }
-        if (vext_elem_mask(vs2, mlen, i)) {
+        if (vext_elem_mask(vs2, i)) {
             first_mask_bit = true;
             if (type == BEFORE_FIRST) {
-                vext_set_elem_mask(vd, mlen, i, 0);
+                vext_set_elem_mask(vd, i, 0);
             } else {
-                vext_set_elem_mask(vd, mlen, i, 1);
+                vext_set_elem_mask(vd, i, 1);
             }
         } else {
             if (type == ONLY_FIRST) {
-                vext_set_elem_mask(vd, mlen, i, 0);
+                vext_set_elem_mask(vd, i, 0);
             } else {
-                vext_set_elem_mask(vd, mlen, i, 1);
+                vext_set_elem_mask(vd, i, 1);
             }
         }
     }
     for (; i < vlmax; i++) {
-        vext_set_elem_mask(vd, mlen, i, 0);
+        vext_set_elem_mask(vd, i, 0);
     }
 }
 
@@ -4650,19 +4617,18 @@ void HELPER(vmsof_m)(void *vd, void *v0, void *vs2, CPURISCVState *env,
 void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
                   uint32_t desc)                                          \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = sum;                                      \
-        if (vext_elem_mask(vs2, mlen, i)) {                               \
+        if (vext_elem_mask(vs2, i)) {                                     \
             sum++;                                                        \
         }                                                                 \
     }                                                                     \
@@ -4678,14 +4644,13 @@ GEN_VEXT_VIOTA_M(viota_m_d, uint64_t, H8, clearq)
 #define GEN_VEXT_VID_V(NAME, ETYPE, H, CLEAR_FN)                          \
 void HELPER(NAME)(void *vd, void *v0, CPURISCVState *env, uint32_t desc)  \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     int i;                                                                \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = i;                                        \
@@ -4707,14 +4672,13 @@ GEN_VEXT_VID_V(vid_v_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
     for (i = offset; i < vl; i++) {                                       \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
@@ -4732,15 +4696,14 @@ GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     target_ulong offset = s1, i;                                          \
                                                                           \
     for (i = 0; i < vl; ++i) {                                            \
         target_ulong j = i + offset;                                      \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
@@ -4758,14 +4721,13 @@ GEN_VEXT_VSLIDEDOWN_VX(vslidedown_vx_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         if (i == 0) {                                                     \
@@ -4787,14 +4749,13 @@ GEN_VEXT_VSLIDE1UP_VX(vslide1up_vx_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t i;                                                           \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         if (i == vl - 1) {                                                \
@@ -4817,14 +4778,13 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t index, i;                                                    \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         index = *((ETYPE *)vs1 + H(i));                                   \
@@ -4847,14 +4807,13 @@ GEN_VEXT_VRGATHER_VV(vrgather_vv_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
     uint32_t index = s1, i;                                               \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
-        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
             continue;                                                     \
         }                                                                 \
         if (index >= vlmax) {                                             \
@@ -4877,13 +4836,12 @@ GEN_VEXT_VRGATHER_VX(vrgather_vx_d, uint64_t, H8, clearq)
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t mlen = vext_mlen(desc);                                      \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
+    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
     uint32_t vl = env->vl;                                                \
     uint32_t num = 0, i;                                                  \
                                                                           \
     for (i = 0; i < vl; i++) {                                            \
-        if (!vext_elem_mask(vs1, mlen, i)) {                              \
+        if (!vext_elem_mask(vs1, i)) {                                    \
             continue;                                                     \
         }                                                                 \
         *((ETYPE *)vd + H(num)) = *((ETYPE *)vs2 + H(i));                 \
-- 
2.17.1


