Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB48C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60202068F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="D7cz6OtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60202068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBMb-0001IX-TA
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwl-0006QI-OG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:40595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAwk-00067k-4N
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:21:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id u5so863714pfn.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xX3TKxwO5nmbDDyxQK/BmEY05aUhOyzJvahr+HIJ9h4=;
 b=D7cz6OtPrbkQvc6NbIiVcoACkN8DH1Df5IniPbq2Mk9UaSRssiuXjt83yS+LpFHBfD
 dy1h0PMo2O0fS03gS/Fpe0+SFLYVXYDBOvHJuaoMQPus1AQt/rfVPL3KBOUok/kn6/kh
 BwjpySWhMtOWoe75bT8ZDwg9eQA+oVmyapVMztEsSyVHmKpc2JktQN54yNXBRcTWZ0rt
 imj/Hwr9McWhCOEfnCmIu6mXfWVsMMS16M9BGTxtgOBlzBEmIG8QViedptJVZezBquJy
 gb6NK5yy7x9MxL7Z2nqNyNBMLkdqhC2ryLxrPF7zTqPsVHqTKU6MZjPZmd/R0JWZOLsr
 X4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xX3TKxwO5nmbDDyxQK/BmEY05aUhOyzJvahr+HIJ9h4=;
 b=au1QACEY46gc1Gn2DQ/xh3+EJA0kQqLthpc4cw8YJYGi8SCNzdQKWZwQ+EXrgpMjJU
 hyNO53FV0NhxOZUsUXU7/zj7ChSE0JVDMsiDAGzdcpYbG3vKoYADPV4V7C7XquYLQiHB
 UdB7MYm/a0CrXzUVA4RK4eNkdBuxjDTOS94oZSovLb3D74qi5zDNQDRVaTPkWMQGx4Zv
 srWgh51FZOsqtERtOkKSzDGZ0yeueuIh0vS53elEfcHN+dc/r370CBAKRM9HlqoBxdVP
 yG3loaUlYBT+pKV6eTBTxi+BLY+G1/PgR8ej9rtDVC0Mv5fJT3aUwfmLjcJLWm7el1ir
 BpKw==
X-Gm-Message-State: AOAM531gWVTPGQzPzTj+3akL9LVnz09tXlwq/QyRPEGBxj325oOChErZ
 r7sbAknDtJ3nvfPkVgwUPpdAQWDoHH0=
X-Google-Smtp-Source: ABdhPJxWpeT75Uyjza6HMWETjZ/g1srxU+s64l+4h8wiRdQRYUyh/ru6OSYskxfsGVfa387MBNtf2g==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr25299688pgn.127.1595409712687; 
 Wed, 22 Jul 2020 02:21:52 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:21:52 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 61/76] target/riscv: rvv-0.9: floating-point/integer
 type-convert instructions
Date: Wed, 22 Jul 2020 17:16:24 +0800
Message-Id: <20200722091641.8834-62-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x433.google.com
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

* vfcvt.rtz.xu.f.v
* vfcvt.rtz.x.f.v

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/helper.h                   |  6 ++++
 target/riscv/insn32.decode              | 11 ++++---
 target/riscv/insn_trans/trans_rvv.inc.c |  2 ++
 target/riscv/vector_helper.c            | 38 +++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 9dfe1c2b10..318fe643f4 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -994,6 +994,12 @@ DEF_HELPER_5(vfcvt_f_xu_v_d, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfcvt_f_x_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_rtz_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_rtz_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_rtz_xu_f_v_d, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_rtz_x_f_v_h, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_rtz_x_f_v_w, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfcvt_rtz_x_f_v_d, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_5(vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index dc3965c050..e4b36af89e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -547,10 +547,13 @@ vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
 vfclass_v       010011 . ..... 10000 001 ..... 1010111 @r2_vm
 vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
 vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
-vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
-vfcvt_x_f_v     100010 . ..... 00001 001 ..... 1010111 @r2_vm
-vfcvt_f_xu_v    100010 . ..... 00010 001 ..... 1010111 @r2_vm
-vfcvt_f_x_v     100010 . ..... 00011 001 ..... 1010111 @r2_vm
+
+vfcvt_xu_f_v       010010 . ..... 00000 001 ..... 1010111 @r2_vm
+vfcvt_x_f_v        010010 . ..... 00001 001 ..... 1010111 @r2_vm
+vfcvt_f_xu_v       010010 . ..... 00010 001 ..... 1010111 @r2_vm
+vfcvt_f_x_v        010010 . ..... 00011 001 ..... 1010111 @r2_vm
+vfcvt_rtz_xu_f_v   010010 . ..... 00110 001 ..... 1010111 @r2_vm
+vfcvt_rtz_x_f_v    010010 . ..... 00111 001 ..... 1010111 @r2_vm
 vfwcvt_xu_f_v   100010 . ..... 01000 001 ..... 1010111 @r2_vm
 vfwcvt_x_f_v    100010 . ..... 01001 001 ..... 1010111 @r2_vm
 vfwcvt_f_xu_v   100010 . ..... 01010 001 ..... 1010111 @r2_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 9ea58bf14b..c1fc168043 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2879,6 +2879,8 @@ GEN_OPFV_TRANS(vfcvt_xu_f_v, opfv_check)
 GEN_OPFV_TRANS(vfcvt_x_f_v, opfv_check)
 GEN_OPFV_TRANS(vfcvt_f_xu_v, opfv_check)
 GEN_OPFV_TRANS(vfcvt_f_x_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_rtz_xu_f_v, opfv_check)
+GEN_OPFV_TRANS(vfcvt_rtz_x_f_v, opfv_check)
 
 /* Widening Floating-Point/Integer Type-Convert Instructions */
 
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c8d3168cee..bbd3be527c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4480,6 +4480,44 @@ GEN_VEXT_V_ENV(vfcvt_f_x_v_h, 2, 2, clearh)
 GEN_VEXT_V_ENV(vfcvt_f_x_v_w, 4, 4, clearl)
 GEN_VEXT_V_ENV(vfcvt_f_x_v_d, 8, 8, clearq)
 
+#define FCVT_RTZ_F_V(STYPE, DTYPE)                                  \
+static DTYPE##_t STYPE##_to_##DTYPE##_rtz(STYPE a, float_status *s) \
+{                                                                   \
+    signed char frm = s->float_rounding_mode;                       \
+    s->float_rounding_mode = float_round_to_zero;                   \
+    DTYPE##_t result = STYPE##_to_##DTYPE(a, s);                    \
+    s->float_rounding_mode = frm;                                   \
+    return result;                                                  \
+}
+
+/*
+ * vfcvt.rtz.xu.f.v vd, vs2, vm
+ * Convert float to unsigned integer, truncating.
+ */
+FCVT_RTZ_F_V(float16, uint16)
+FCVT_RTZ_F_V(float32, uint32)
+FCVT_RTZ_F_V(float64, uint64)
+RVVCALL(OPFVV1, vfcvt_rtz_xu_f_v_h, OP_UU_H, H2, H2, float16_to_uint16_rtz)
+RVVCALL(OPFVV1, vfcvt_rtz_xu_f_v_w, OP_UU_W, H4, H4, float32_to_uint32_rtz)
+RVVCALL(OPFVV1, vfcvt_rtz_xu_f_v_d, OP_UU_D, H8, H8, float64_to_uint64_rtz)
+GEN_VEXT_V_ENV(vfcvt_rtz_xu_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_rtz_xu_f_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_rtz_xu_f_v_d, 8, 8, clearq)
+
+/*
+ * vfcvt.rtz.x.f.v  vd, vs2, vm
+ * Convert float to signed integer, truncating.
+ */
+FCVT_RTZ_F_V(float16, int16)
+FCVT_RTZ_F_V(float32, int32)
+FCVT_RTZ_F_V(float64, int64)
+RVVCALL(OPFVV1, vfcvt_rtz_x_f_v_h, OP_UU_H, H2, H2, float16_to_int16_rtz)
+RVVCALL(OPFVV1, vfcvt_rtz_x_f_v_w, OP_UU_W, H4, H4, float32_to_int32_rtz)
+RVVCALL(OPFVV1, vfcvt_rtz_x_f_v_d, OP_UU_D, H8, H8, float64_to_int64_rtz)
+GEN_VEXT_V_ENV(vfcvt_rtz_x_f_v_h, 2, 2, clearh)
+GEN_VEXT_V_ENV(vfcvt_rtz_x_f_v_w, 4, 4, clearl)
+GEN_VEXT_V_ENV(vfcvt_rtz_x_f_v_d, 8, 8, clearq)
+
 /* Widening Floating-Point/Integer Type-Convert Instructions */
 /* (TD, T2, TX2) */
 #define WOP_UU_H uint32_t, uint16_t, uint16_t
-- 
2.17.1


