Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC2BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4014120729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VcVKOF9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4014120729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBTq-0005sE-Ht
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwd-0006E0-9G
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:47 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:46096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwb-00066I-JE
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:46 -0400
Received: by mail-pg1-x532.google.com with SMTP id s189so860940pgc.13
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wwWnFYhgiAsGU9GssgKhfj0XKT6lILK/t0ZSavv8d7E=;
 b=VcVKOF9VrFYiUuCfn5V48pm30uaOH6aIISKUoYJ2IsLVu9ON1W235TsULUOHOwjgRB
 aRMhSWgY4Rd72XZczgWH5VmIdjdKtCOPViuXP5eMC+F1J6SzOx1D0GNo1LqaZk6Pqb2f
 8csfpEc7Nt5vBdjjqfVAIHZCIz2sJyIvqtKRVZLcku6Pqr8KzsFsdi7FAclm4tbMbusU
 aOkKLQUeylwDcDB7p12GlZJ/8WJxASx03I0VL3MjbkiNKYTD7Ncb4hdjq0VVsVgbD82m
 1lfiAfy6OTTkuBFaAs35gOYr1AcxxjQpBNMK1D8glwjnjWdaCL5ebHrr9LaHbvCY82XS
 MrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wwWnFYhgiAsGU9GssgKhfj0XKT6lILK/t0ZSavv8d7E=;
 b=ufjLkV4Q8EEVWQPb30X+6J6NVBpLGDndNmEYE9SA0ixXNvFHYe6zUn5s4MJdA+h5PP
 q0L/CLWj3uPPNml+Lg5hsVLOdswoTQF3p61T5/pmSEHYv0lNBX7MhrgKTb19nbS5gSsw
 hilZBDPjQaWlOaK5MPuFtMWLXszQjlgrZNQf8/ibaj2vMcn4HvNzIqhN1QmPyJWOCquX
 pqxXsiqb/zE135MoJ8ejqln91YIqq+s6FYxMMvKLVJeGGK7D05e9Wkno4VnEZhUTAMFE
 hoCSS/NChUQgiRnndIeaCDDDKwXjKcDNc09p7XqMoFwKPINiRXQhgQ1P8EjKY9CVjNUC
 RF8A==
X-Gm-Message-State: AOAM533gMmzqcRlBgzpoe7vjGD7yhhbOcCVqMwrh9vWEzQ530eOBw71i
 iXJXjGcCzbYrTMTH1DO7SINTO+gp2KI=
X-Google-Smtp-Source: ABdhPJxFKAtQ7XWKMSU1UWbUMpue98RxS3lwhaubYmhsFtv8IahKoQpwxmQpXp/Y08sdjfUjemXG8A==
X-Received: by 2002:a65:5201:: with SMTP id o1mr11334281pgp.404.1595409704098; 
 Wed, 22 Jul 2020 02:21:44 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:43 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 59/76] target/riscv: rvv-0.9: floating-point slide
 instructions
Date: Wed, 22 Jul 2020 17:16:22 +0800
Message-Id: <20200722091641.8834-60-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x532.google.com
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

Add the following instructions:

* vfslide1up.vf
* vfslide1down.vf

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  7 ++++
 target/riscv/insn32.decode              |  2 +
 target/riscv/insn_trans/trans_rvv.inc.c |  4 ++
 target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++++
 4 files changed, 64 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b8a436d3aa..c6738336e8 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1114,6 +1114,13 @@ DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
 
+DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1up_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1down_vf_h, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1down_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfslide1down_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+
 DEF_HELPER_6(vrgather_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vrgather_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index acd65cb3a7..ed34ccd0e3 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -530,6 +530,8 @@ vfsgnjn_vv      001001 . ..... ..... 001 ..... 1010111 @r_vm
 vfsgnjn_vf      001001 . ..... ..... 101 ..... 1010111 @r_vm
 vfsgnjx_vv      001010 . ..... ..... 001 ..... 1010111 @r_vm
 vfsgnjx_vf      001010 . ..... ..... 101 ..... 1010111 @r_vm
+vfslide1up_vf   001110 . ..... ..... 101 ..... 1010111 @r_vm
+vfslide1down_vf 001111 . ..... ..... 101 ..... 1010111 @r_vm
 vmfeq_vv        011000 . ..... ..... 001 ..... 1010111 @r_vm
 vmfeq_vf        011000 . ..... ..... 101 ..... 1010111 @r_vm
 vmfne_vv        011100 . ..... ..... 001 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 5004707b87..d16db7f61a 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3514,6 +3514,10 @@ GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
 GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
 GEN_OPIVI_TRANS(vslidedown_vi, IMM_ZX, vslidedown_vx, slidedown_check)
 
+/* Vector Floating-Point Slide Instructions */
+GEN_OPFVF_TRANS(vfslide1up_vf, slideup_check)
+GEN_OPFVF_TRANS(vfslide1down_vf, slidedown_check)
+
 /* Vector Register Gather Instruction */
 static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index b47ca6c406..4036be4425 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5023,6 +5023,57 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_w, uint32_t, H4)
 GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_d, uint64_t, H8)
 
+/* Vector Floating-Point Slide Instructions */
+#define GEN_VEXT_VFSLIDE1UP_VF(NAME, ETYPE, H)                            \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,             \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
+            continue;                                                     \
+        }                                                                 \
+        if (i == 0) {                                                     \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
+        }                                                                 \
+    }                                                                     \
+}
+
+/* vfslide1up.vf vd, vs2, rs1, vm # vd[0]=f[rs1], vd[i+1] = vs2[i] */
+GEN_VEXT_VFSLIDE1UP_VF(vfslide1up_vf_h, uint16_t, H1)
+GEN_VEXT_VFSLIDE1UP_VF(vfslide1up_vf_w, uint32_t, H1)
+GEN_VEXT_VFSLIDE1UP_VF(vfslide1up_vf_d, uint64_t, H1)
+
+#define GEN_VEXT_VFSLIDE1DOWN_VF(NAME, ETYPE, H)                          \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,             \
+                  CPURISCVState *env, uint32_t desc)                      \
+{                                                                         \
+    uint32_t vm = vext_vm(desc);                                          \
+    uint32_t vl = env->vl;                                                \
+    uint32_t i;                                                           \
+                                                                          \
+    for (i = 0; i < vl; i++) {                                            \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
+            continue;                                                     \
+        }                                                                 \
+        if (i == vl - 1) {                                                \
+            *((ETYPE *)vd + H(i)) = s1;                                   \
+        } else {                                                          \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + 1));           \
+        }                                                                 \
+    }                                                                     \
+}
+
+/* vfslide1down.vf vd, vs2, rs1, vm # vd[i] = vs2[i+1], vd[vl-1]=f[rs1] */
+GEN_VEXT_VFSLIDE1DOWN_VF(vfslide1down_vf_h, uint16_t, H1)
+GEN_VEXT_VFSLIDE1DOWN_VF(vfslide1down_vf_w, uint32_t, H1)
+GEN_VEXT_VFSLIDE1DOWN_VF(vfslide1down_vf_d, uint64_t, H1)
+
 /* Vector Register Gather Instruction */
 #define GEN_VEXT_VRGATHER_VV(NAME, ETYPE, H, CLEAR_FN)                    \
 void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
-- 
2.17.1


