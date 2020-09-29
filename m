Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4068CC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA0A20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C4Qxj0GQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA0A20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLOC-0001gC-7p
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyY-0006DN-2Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyU-0002J4-EC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id y14so4609481pgf.12
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sndHmprS2w63ooEUMnoTQgLS3NsQleOteVJzHjHw4fw=;
 b=C4Qxj0GQ/ZtoRRJ+MpbXC21YwhedzYvaF4rJcyp59FUqTdOzVpM1f/3de7eccwod6c
 ch65BW9wogVFP6UOOIpKDUeYRZA2oZYcoaNBtDFQol2BypUy5jR05uQIDDwaH059GriS
 ltm5CHGBj//PzhrwDa5cZIESO0+CXoqdtJ+h9eSxK8X5L/MZc8qosrGrtAHPZlya9Uks
 40Dz4OP5tpxXphMsVhXjTqedrSGkrbf2RTW7NoU5x0epQH/5Gj8cTJI4EJ0JpGqXbyP8
 kxXqmFPDJpeSccrEFOTFCpQOHvL9H/xSXxpjtdcEV9L8E8wwU/RSyCk3VAl1S1IIX+Uh
 XVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sndHmprS2w63ooEUMnoTQgLS3NsQleOteVJzHjHw4fw=;
 b=XEr4tt1oKeNd+Z9dbL78Lwk4hhYEmz1E2Z4BheqLW8+pHifs0uBTdBQcItQ0goB8yR
 jmxaCPAfg7MVwf0aEbsU/r9ry22JBK+ZfRChr6C7EJEhVisrHISkkngCHNQlCgi35oRp
 iipQL04pVOj+BY2ptaaWHMTsUYnxQ4hJGnsqs37pMf7Eq9lGLfSKqNWa8BNzpgpYTX56
 di198oiFj0K+XHpZE/5WYa+TCwqwRbxvdVikU4KT2TmBpm1nr8K35xrct+4F7Q9ybfXv
 ulH6I5xQtFN48Ci41XT2oAd+FhBdPFwwkftQWVGhRY+/hQkJnkCJHr1fCb77C4aOt94Q
 MFDw==
X-Gm-Message-State: AOAM532kuBoyS3/XQHK4Rn8A/bGoZYZoQHObu7Ue9dcQYqKwscXPZNNJ
 zXO/eG2vtNq7tWfYLg0AuXXwCbNNF42WGg==
X-Google-Smtp-Source: ABdhPJzG1csughHwGYGieZcliHEi3G/ZWhntGfmvURsq//S1bVI3ylLxnquuPru6Xi/14r+G0Ie2cg==
X-Received: by 2002:a62:3401:0:b029:150:e9ad:569 with SMTP id
 b1-20020a6234010000b0290150e9ad0569mr5392308pfa.75.1601406460411; 
 Tue, 29 Sep 2020 12:07:40 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:39 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 40/68] target/riscv: rvv-1.0: single-width averaging add and
 subtract instructions
Date: Wed, 30 Sep 2020 03:04:15 +0800
Message-Id: <20200929190448.31116-41-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x542.google.com
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

Add the following instructions:

* vaaddu.vv
* vaaddu.vx
* vasubu.vv
* vasubu.vx

Remove the following instructions:

* vadd.vi

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   | 16 ++++++
 target/riscv/insn32.decode              | 13 +++--
 target/riscv/insn_trans/trans_rvv.c.inc |  5 +-
 target/riscv/vector_helper.c            | 74 +++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 6 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index fd59b07af3..290d32078e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -698,18 +698,34 @@ DEF_HELPER_6(vaadd_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vaadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vaadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vaadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaaddu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vaaddu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vasub_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vasub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vasub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vasub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasubu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasubu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasubu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vasubu_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vaadd_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vaadd_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vaadd_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vaadd_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaaddu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaaddu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaaddu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vaaddu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vasub_vx_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasubu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasubu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasubu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vasubu_vx_d, void, ptr, ptr, tl, ptr, env, i32)
 
 DEF_HELPER_6(vsmul_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vsmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 158ef6e49f..9fcb985e9f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -468,11 +468,14 @@ vssubu_vv       100010 . ..... ..... 000 ..... 1010111 @r_vm
 vssubu_vx       100010 . ..... ..... 100 ..... 1010111 @r_vm
 vssub_vv        100011 . ..... ..... 000 ..... 1010111 @r_vm
 vssub_vx        100011 . ..... ..... 100 ..... 1010111 @r_vm
-vaadd_vv        100100 . ..... ..... 000 ..... 1010111 @r_vm
-vaadd_vx        100100 . ..... ..... 100 ..... 1010111 @r_vm
-vaadd_vi        100100 . ..... ..... 011 ..... 1010111 @r_vm
-vasub_vv        100110 . ..... ..... 000 ..... 1010111 @r_vm
-vasub_vx        100110 . ..... ..... 100 ..... 1010111 @r_vm
+vaadd_vv        001001 . ..... ..... 010 ..... 1010111 @r_vm
+vaadd_vx        001001 . ..... ..... 110 ..... 1010111 @r_vm
+vaaddu_vv       001000 . ..... ..... 010 ..... 1010111 @r_vm
+vaaddu_vx       001000 . ..... ..... 110 ..... 1010111 @r_vm
+vasub_vv        001011 . ..... ..... 010 ..... 1010111 @r_vm
+vasub_vx        001011 . ..... ..... 110 ..... 1010111 @r_vm
+vasubu_vv       001010 . ..... ..... 010 ..... 1010111 @r_vm
+vasubu_vx       001010 . ..... ..... 110 ..... 1010111 @r_vm
 vsmul_vv        100111 . ..... ..... 000 ..... 1010111 @r_vm
 vsmul_vx        100111 . ..... ..... 100 ..... 1010111 @r_vm
 vwsmaccu_vv     111100 . ..... ..... 000 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 12250c776d..cce1712af0 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2254,10 +2254,13 @@ GEN_OPIVI_TRANS(vsadd_vi, IMM_SX, vsadd_vx, opivx_check)
 
 /* Vector Single-Width Averaging Add and Subtract */
 GEN_OPIVV_TRANS(vaadd_vv, opivv_check)
+GEN_OPIVV_TRANS(vaaddu_vv, opivv_check)
 GEN_OPIVV_TRANS(vasub_vv, opivv_check)
+GEN_OPIVV_TRANS(vasubu_vv, opivv_check)
 GEN_OPIVX_TRANS(vaadd_vx,  opivx_check)
+GEN_OPIVX_TRANS(vaaddu_vx,  opivx_check)
 GEN_OPIVX_TRANS(vasub_vx,  opivx_check)
-GEN_OPIVI_TRANS(vaadd_vi, 0, vaadd_vx, opivx_check)
+GEN_OPIVX_TRANS(vasubu_vx,  opivx_check)
 
 /* Vector Single-Width Fractional Multiply with Rounding and Saturation */
 GEN_OPIVV_TRANS(vsmul_vv, opivv_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 40ef5ab53a..c37d040411 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2502,6 +2502,43 @@ GEN_VEXT_VX_RM(vaadd_vx_h, 2, 2)
 GEN_VEXT_VX_RM(vaadd_vx_w, 4, 4)
 GEN_VEXT_VX_RM(vaadd_vx_d, 8, 8)
 
+static inline uint32_t aaddu32(CPURISCVState *env, int vxrm,
+                               uint32_t a, uint32_t b)
+{
+    uint64_t res = (uint64_t)a + b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res >> 1) + round;
+}
+
+static inline uint64_t aaddu64(CPURISCVState *env, int vxrm,
+                               uint64_t a, uint64_t b)
+{
+    uint64_t res = a + b;
+    uint8_t round = get_round(vxrm, res, 1);
+    uint64_t over = (uint64_t)(res < a) << 63;
+
+    return ((res >> 1) | over) + round;
+}
+
+RVVCALL(OPIVV2_RM, vaaddu_vv_b, OP_UUU_B, H1, H1, H1, aaddu32)
+RVVCALL(OPIVV2_RM, vaaddu_vv_h, OP_UUU_H, H2, H2, H2, aaddu32)
+RVVCALL(OPIVV2_RM, vaaddu_vv_w, OP_UUU_W, H4, H4, H4, aaddu32)
+RVVCALL(OPIVV2_RM, vaaddu_vv_d, OP_UUU_D, H8, H8, H8, aaddu64)
+GEN_VEXT_VV_RM(vaaddu_vv_b, 1, 1)
+GEN_VEXT_VV_RM(vaaddu_vv_h, 2, 2)
+GEN_VEXT_VV_RM(vaaddu_vv_w, 4, 4)
+GEN_VEXT_VV_RM(vaaddu_vv_d, 8, 8)
+
+RVVCALL(OPIVX2_RM, vaaddu_vx_b, OP_UUU_B, H1, H1, aaddu32)
+RVVCALL(OPIVX2_RM, vaaddu_vx_h, OP_UUU_H, H2, H2, aaddu32)
+RVVCALL(OPIVX2_RM, vaaddu_vx_w, OP_UUU_W, H4, H4, aaddu32)
+RVVCALL(OPIVX2_RM, vaaddu_vx_d, OP_UUU_D, H8, H8, aaddu64)
+GEN_VEXT_VX_RM(vaaddu_vx_b, 1, 1)
+GEN_VEXT_VX_RM(vaaddu_vx_h, 2, 2)
+GEN_VEXT_VX_RM(vaaddu_vx_w, 4, 4)
+GEN_VEXT_VX_RM(vaaddu_vx_d, 8, 8)
+
 static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
 {
     int64_t res = (int64_t)a - b;
@@ -2538,6 +2575,43 @@ GEN_VEXT_VX_RM(vasub_vx_h, 2, 2)
 GEN_VEXT_VX_RM(vasub_vx_w, 4, 4)
 GEN_VEXT_VX_RM(vasub_vx_d, 8, 8)
 
+static inline uint32_t asubu32(CPURISCVState *env, int vxrm,
+                               uint32_t a, uint32_t b)
+{
+    int64_t res = (int64_t)a - b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res >> 1) + round;
+}
+
+static inline uint64_t asubu64(CPURISCVState *env, int vxrm,
+                               uint64_t a, uint64_t b)
+{
+    uint64_t res = (uint64_t)a - b;
+    uint8_t round = get_round(vxrm, res, 1);
+    uint64_t over = (uint64_t)(res > a) << 63;
+
+    return ((res >> 1) | over) + round;
+}
+
+RVVCALL(OPIVV2_RM, vasubu_vv_b, OP_UUU_B, H1, H1, H1, asubu32)
+RVVCALL(OPIVV2_RM, vasubu_vv_h, OP_UUU_H, H2, H2, H2, asubu32)
+RVVCALL(OPIVV2_RM, vasubu_vv_w, OP_UUU_W, H4, H4, H4, asubu32)
+RVVCALL(OPIVV2_RM, vasubu_vv_d, OP_UUU_D, H8, H8, H8, asubu64)
+GEN_VEXT_VV_RM(vasubu_vv_b, 1, 1)
+GEN_VEXT_VV_RM(vasubu_vv_h, 2, 2)
+GEN_VEXT_VV_RM(vasubu_vv_w, 4, 4)
+GEN_VEXT_VV_RM(vasubu_vv_d, 8, 8)
+
+RVVCALL(OPIVX2_RM, vasubu_vx_b, OP_UUU_B, H1, H1, asubu32)
+RVVCALL(OPIVX2_RM, vasubu_vx_h, OP_UUU_H, H2, H2, asubu32)
+RVVCALL(OPIVX2_RM, vasubu_vx_w, OP_UUU_W, H4, H4, asubu32)
+RVVCALL(OPIVX2_RM, vasubu_vx_d, OP_UUU_D, H8, H8, asubu64)
+GEN_VEXT_VX_RM(vasubu_vx_b, 1, 1)
+GEN_VEXT_VX_RM(vasubu_vx_h, 2, 2)
+GEN_VEXT_VX_RM(vasubu_vx_w, 4, 4)
+GEN_VEXT_VX_RM(vasubu_vx_d, 8, 8)
+
 /* Vector Single-Width Fractional Multiply with Rounding and Saturation */
 static inline int8_t vsmul8(CPURISCVState *env, int vxrm, int8_t a, int8_t b)
 {
-- 
2.17.1


