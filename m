Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB782063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QKY5E423"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB782063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bCT-00011B-7y
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7ash-0002KS-FN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:39 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:53946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7asf-0005GK-DX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:52:39 -0400
Received: by mail-pj1-x1036.google.com with SMTP id l60so7483428pjb.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9tOqXvDf5H2RV1rUlXt1sgNa5HwivVzLXeWBQnTM4cs=;
 b=QKY5E423QjnLq0c/RAP3ciqUvfnz7hks/9wr7w/bNsCrov6cWPZQvYZtGMYdfkJNvM
 mtoomit+nvh7srAwTWLMBSJvmjZVZFMFomwkDrZO/c8r43TI9XJ8A+Uz/JslfqjZ5nbN
 FEv9hcT2hB+ahVq9fzTIHQN4DD7w9Cji7R73y56uJcdA65pADA/gelqtl3ChTZDmrY8o
 zkPMjPErjwH2AzeEXJONBCJCtB5NbppcmT5zBm06FdqdFYfsOZCzz7LIuKvN1EWNSfp+
 Tu4B2be0N0zmueNBpTAKPZX31QxV6xE2t/wjx4Y3PXf23uinJ8xCEH+EiSP648tz28xa
 x31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9tOqXvDf5H2RV1rUlXt1sgNa5HwivVzLXeWBQnTM4cs=;
 b=nu4cf0NxHR8bjxN2IIZn59r0DTUw7UMgPExZEESiJe9kG9xM3Eoo7PYq7GnZe68xWq
 3wo6rSOWHSokKn6fG8ci13OdJqocZrfxFqS9PrZj+HKAsaFt7JT523mmpOtOuacMmkW5
 ptFaIU0EIEp9arJ760shvHbOgk/MMl0M2Mt2VriapyVCY0yfvI40+aEhKs4GSIPECbtx
 YJtIQYGmQa+wghHrQrCyHe2d/FvgFPA8FdbqLXL93atV4jgsUgagXSKd5ftZ7rf8UKbr
 TDXl7626pitLVVtQKpqy8sk0ove0D3BUCYKI2pWiBGpUUzEDvpMXgUbJQG1T4jo4j/qW
 Px9w==
X-Gm-Message-State: AOAM533kHCUSfeTe0Xu1NzHxRw4PVMfaSDTQxCdkkCdgDSchw883gqUV
 GQyup9KOmbQ9YUcIzSSDf3RlUtIY7ux2Ag==
X-Google-Smtp-Source: ABdhPJywA4JsS9Pi4LOROLH8EBmLAT4jetgWZvT0BZfek8pUSfp+MS5At9SOgSF8eJbKL8T1mzSA3Q==
X-Received: by 2002:a17:90a:19d1:: with SMTP id
 17mr11264095pjj.93.1597654355896; 
 Mon, 17 Aug 2020 01:52:35 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:52:35 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 54/70] target/riscv: rvv-1.0: narrowing fixed-point clip
 instructions
Date: Mon, 17 Aug 2020 16:49:39 +0800
Message-Id: <20200817084955.28793-55-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   | 24 ++++++------
 target/riscv/insn32.decode              | 12 +++---
 target/riscv/insn_trans/trans_rvv.inc.c | 12 +++---
 target/riscv/vector_helper.c            | 52 ++++++++++++-------------
 4 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 6d98de1be15..0a21440d98d 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -786,18 +786,18 @@ DEF_HELPER_6(vssra_vx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssra_vx_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vssra_vx_d, void, ptr, ptr, tl, ptr, env, i32)
 
-DEF_HELPER_6(vnclip_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vnclip_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vnclip_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vnclipu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vnclipu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vnclipu_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
-DEF_HELPER_6(vnclipu_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vnclipu_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vnclipu_vx_w, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vnclip_vx_b, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vnclip_vx_h, void, ptr, ptr, tl, ptr, env, i32)
-DEF_HELPER_6(vnclip_vx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclip_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclip_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclip_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclipu_wv_b, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclipu_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclipu_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vnclipu_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclipu_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclipu_wx_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclip_wx_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclip_wx_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vnclip_wx_w, void, ptr, ptr, tl, ptr, env, i32)
 
 DEF_HELPER_6(vfadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index d181db197ef..39565ef047c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -487,12 +487,12 @@ vssrl_vi        101010 . ..... ..... 011 ..... 1010111 @r_vm
 vssra_vv        101011 . ..... ..... 000 ..... 1010111 @r_vm
 vssra_vx        101011 . ..... ..... 100 ..... 1010111 @r_vm
 vssra_vi        101011 . ..... ..... 011 ..... 1010111 @r_vm
-vnclipu_vv      101110 . ..... ..... 000 ..... 1010111 @r_vm
-vnclipu_vx      101110 . ..... ..... 100 ..... 1010111 @r_vm
-vnclipu_vi      101110 . ..... ..... 011 ..... 1010111 @r_vm
-vnclip_vv       101111 . ..... ..... 000 ..... 1010111 @r_vm
-vnclip_vx       101111 . ..... ..... 100 ..... 1010111 @r_vm
-vnclip_vi       101111 . ..... ..... 011 ..... 1010111 @r_vm
+vnclipu_wv      101110 . ..... ..... 000 ..... 1010111 @r_vm
+vnclipu_wx      101110 . ..... ..... 100 ..... 1010111 @r_vm
+vnclipu_wi      101110 . ..... ..... 011 ..... 1010111 @r_vm
+vnclip_wv       101111 . ..... ..... 000 ..... 1010111 @r_vm
+vnclip_wx       101111 . ..... ..... 100 ..... 1010111 @r_vm
+vnclip_wi       101111 . ..... ..... 011 ..... 1010111 @r_vm
 vfadd_vv        000000 . ..... ..... 001 ..... 1010111 @r_vm
 vfadd_vf        000000 . ..... ..... 101 ..... 1010111 @r_vm
 vfsub_vv        000010 . ..... ..... 001 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c452292652c..41a60cf2fb9 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2376,12 +2376,12 @@ GEN_OPIVI_TRANS(vssrl_vi, IMM_ZX, vssrl_vx, opivx_check)
 GEN_OPIVI_TRANS(vssra_vi, IMM_SX, vssra_vx, opivx_check)
 
 /* Vector Narrowing Fixed-Point Clip Instructions */
-GEN_OPIVV_NARROW_TRANS(vnclipu_vv)
-GEN_OPIVV_NARROW_TRANS(vnclip_vv)
-GEN_OPIVX_NARROW_TRANS(vnclipu_vx)
-GEN_OPIVX_NARROW_TRANS(vnclip_vx)
-GEN_OPIVI_NARROW_TRANS(vnclipu_vi, IMM_ZX, vnclipu_vx)
-GEN_OPIVI_NARROW_TRANS(vnclip_vi, IMM_ZX, vnclip_vx)
+GEN_OPIWV_NARROW_TRANS(vnclipu_wv)
+GEN_OPIWV_NARROW_TRANS(vnclip_wv)
+GEN_OPIWX_NARROW_TRANS(vnclipu_wx)
+GEN_OPIWX_NARROW_TRANS(vnclip_wx)
+GEN_OPIWI_NARROW_TRANS(vnclipu_wi, IMM_ZX, vnclipu_wx)
+GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
 
 /*
  *** Vector Float Point Arithmetic Instructions
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 09f0b03e2c5..15a646af361 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3128,19 +3128,19 @@ vnclip32(CPURISCVState *env, int vxrm, int64_t a, int32_t b)
     }
 }
 
-RVVCALL(OPIVV2_RM, vnclip_vv_b, NOP_SSS_B, H1, H2, H1, vnclip8)
-RVVCALL(OPIVV2_RM, vnclip_vv_h, NOP_SSS_H, H2, H4, H2, vnclip16)
-RVVCALL(OPIVV2_RM, vnclip_vv_w, NOP_SSS_W, H4, H8, H4, vnclip32)
-GEN_VEXT_VV_RM(vnclip_vv_b, 1, 1)
-GEN_VEXT_VV_RM(vnclip_vv_h, 2, 2)
-GEN_VEXT_VV_RM(vnclip_vv_w, 4, 4)
-
-RVVCALL(OPIVX2_RM, vnclip_vx_b, NOP_SSS_B, H1, H2, vnclip8)
-RVVCALL(OPIVX2_RM, vnclip_vx_h, NOP_SSS_H, H2, H4, vnclip16)
-RVVCALL(OPIVX2_RM, vnclip_vx_w, NOP_SSS_W, H4, H8, vnclip32)
-GEN_VEXT_VX_RM(vnclip_vx_b, 1, 1)
-GEN_VEXT_VX_RM(vnclip_vx_h, 2, 2)
-GEN_VEXT_VX_RM(vnclip_vx_w, 4, 4)
+RVVCALL(OPIVV2_RM, vnclip_wv_b, NOP_SSS_B, H1, H2, H1, vnclip8)
+RVVCALL(OPIVV2_RM, vnclip_wv_h, NOP_SSS_H, H2, H4, H2, vnclip16)
+RVVCALL(OPIVV2_RM, vnclip_wv_w, NOP_SSS_W, H4, H8, H4, vnclip32)
+GEN_VEXT_VV_RM(vnclip_wv_b, 1, 1)
+GEN_VEXT_VV_RM(vnclip_wv_h, 2, 2)
+GEN_VEXT_VV_RM(vnclip_wv_w, 4, 4)
+
+RVVCALL(OPIVX2_RM, vnclip_wx_b, NOP_SSS_B, H1, H2, vnclip8)
+RVVCALL(OPIVX2_RM, vnclip_wx_h, NOP_SSS_H, H2, H4, vnclip16)
+RVVCALL(OPIVX2_RM, vnclip_wx_w, NOP_SSS_W, H4, H8, vnclip32)
+GEN_VEXT_VX_RM(vnclip_wx_b, 1, 1)
+GEN_VEXT_VX_RM(vnclip_wx_h, 2, 2)
+GEN_VEXT_VX_RM(vnclip_wx_w, 4, 4)
 
 static inline uint8_t
 vnclipu8(CPURISCVState *env, int vxrm, uint16_t a, uint8_t b)
@@ -3178,7 +3178,7 @@ static inline uint32_t
 vnclipu32(CPURISCVState *env, int vxrm, uint64_t a, uint32_t b)
 {
     uint8_t round, shift = b & 0x3f;
-    int64_t res;
+    uint64_t res;
 
     round = get_round(vxrm, a, shift);
     res   = (a >> shift)  + round;
@@ -3190,19 +3190,19 @@ vnclipu32(CPURISCVState *env, int vxrm, uint64_t a, uint32_t b)
     }
 }
 
-RVVCALL(OPIVV2_RM, vnclipu_vv_b, NOP_UUU_B, H1, H2, H1, vnclipu8)
-RVVCALL(OPIVV2_RM, vnclipu_vv_h, NOP_UUU_H, H2, H4, H2, vnclipu16)
-RVVCALL(OPIVV2_RM, vnclipu_vv_w, NOP_UUU_W, H4, H8, H4, vnclipu32)
-GEN_VEXT_VV_RM(vnclipu_vv_b, 1, 1)
-GEN_VEXT_VV_RM(vnclipu_vv_h, 2, 2)
-GEN_VEXT_VV_RM(vnclipu_vv_w, 4, 4)
+RVVCALL(OPIVV2_RM, vnclipu_wv_b, NOP_UUU_B, H1, H2, H1, vnclipu8)
+RVVCALL(OPIVV2_RM, vnclipu_wv_h, NOP_UUU_H, H2, H4, H2, vnclipu16)
+RVVCALL(OPIVV2_RM, vnclipu_wv_w, NOP_UUU_W, H4, H8, H4, vnclipu32)
+GEN_VEXT_VV_RM(vnclipu_wv_b, 1, 1)
+GEN_VEXT_VV_RM(vnclipu_wv_h, 2, 2)
+GEN_VEXT_VV_RM(vnclipu_wv_w, 4, 4)
 
-RVVCALL(OPIVX2_RM, vnclipu_vx_b, NOP_UUU_B, H1, H2, vnclipu8)
-RVVCALL(OPIVX2_RM, vnclipu_vx_h, NOP_UUU_H, H2, H4, vnclipu16)
-RVVCALL(OPIVX2_RM, vnclipu_vx_w, NOP_UUU_W, H4, H8, vnclipu32)
-GEN_VEXT_VX_RM(vnclipu_vx_b, 1, 1)
-GEN_VEXT_VX_RM(vnclipu_vx_h, 2, 2)
-GEN_VEXT_VX_RM(vnclipu_vx_w, 4, 4)
+RVVCALL(OPIVX2_RM, vnclipu_wx_b, NOP_UUU_B, H1, H2, vnclipu8)
+RVVCALL(OPIVX2_RM, vnclipu_wx_h, NOP_UUU_H, H2, H4, vnclipu16)
+RVVCALL(OPIVX2_RM, vnclipu_wx_w, NOP_UUU_W, H4, H8, vnclipu32)
+GEN_VEXT_VX_RM(vnclipu_wx_b, 1, 1)
+GEN_VEXT_VX_RM(vnclipu_wx_h, 2, 2)
+GEN_VEXT_VX_RM(vnclipu_wx_w, 4, 4)
 
 /*
  *** Vector Float Point Arithmetic Instructions
-- 
2.17.1


