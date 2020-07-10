Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC479207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KBB/zwv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC479207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt4L-0001Eq-4U
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqf5-0005xP-45
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:47 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:41213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqf3-0006vv-FK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:46 -0400
Received: by mail-pg1-x52a.google.com with SMTP id g67so2366791pgc.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dXTMaAytKPgGZOYeyuxp0EWgMM3z2nIrmJVAFe7+Hao=;
 b=KBB/zwv5c6qxCKaKAn9hZDdnGprEAOI7k/HC1dJr85VrzU6Enx56RRMEljq4se79wA
 mqglcCMLByHGhwC330W67z5AfRAXzjmUFRMB12+t99LkXbVrk11FzXaPauhOQJDC7tin
 mtMud9V0NGxsPYG/R9EoPuEpOmK4ctkulRJ3tfvpmcNhiVdL6rHiA0kmIlB+eho2S9al
 2wdAu1rQR2Q5xd4giTsjofBZ3URH7nW9RScD8q+xkmfeAtf3jR17KsBy6A+MYtADEeT8
 2XoRTYXwYyBfdkU5PPGJdxGc6II3FQemmZYdk0QGyFIhK56h+Z5fx/YC81cWUkw20MKT
 TndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dXTMaAytKPgGZOYeyuxp0EWgMM3z2nIrmJVAFe7+Hao=;
 b=RYJht9kt32JdJvOnP++j9E3AXMjU0fO1+XwB3b7K7rGooFS/Qi3wAuccShHg/xE6Fq
 Tx7VDKIgGf3AUYdvnLMjzT2vReiku+zu9oVejzJsqhpzDDvMyCbGJ+fma3GLr8wL2yll
 /Sh/6tMmS3y+4xwGMlRSgLMpvHvJi0Yg84Pxh1dbCYtQYFhCawYzAwFsZjq6Ap81+z1n
 gnSqKjN9KsT6RN/FAioeFbwL1E3IutOn1x4zyNTULkwo35IRrKVoctN+0pGWS2FAzFN/
 Ffa7VxfUqCWSRmafv5/4LcPHIn/JRETJlEnvoNGPGmQDo8pS0Fgr+7MAduHfL6bO9hMY
 0vZA==
X-Gm-Message-State: AOAM5312jldS/Nl5ocEr3Z8wwi+6il9h21qx7+yL8KOQNfQBpUK3L+Wf
 yt3Yw2Lg3m7wchCGGY0WkCwqk+6b9/317g==
X-Google-Smtp-Source: ABdhPJzpCzypn7STcLlHGeGT+U4vaGkyo4jBY5Lf96pVIX+YY5YbTvxKOStaZndzxQTxfqOnVJxzJw==
X-Received: by 2002:a63:4b44:: with SMTP id k4mr60185561pgl.305.1594378424063; 
 Fri, 10 Jul 2020 03:53:44 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:53:43 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 47/65] target/riscv: rvv-0.9: floating-point slide instructions
Date: Fri, 10 Jul 2020 18:49:01 +0800
Message-Id: <20200710104920.13550-48-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52a.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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
index 2a4e1ea773..d2bf9be551 100644
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
index dab642ab7a..f46cccc9bb 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3248,6 +3248,10 @@ GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
 GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
 GEN_OPIVI_TRANS(vslidedown_vi, 1, vslidedown_vx, slidedown_check)
 
+/* Vector Floating-Point Slide Instructions */
+GEN_OPFVF_TRANS(vfslide1up_vf, slideup_check)
+GEN_OPFVF_TRANS(vfslide1down_vf, slidedown_check)
+
 /* Vector Register Gather Instruction */
 static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 050f4fd895..cf245e0145 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5016,6 +5016,57 @@ GEN_VEXT_VSLIDE1DOWN_VX(vslide1down_vx_h, uint16_t, H2)
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


