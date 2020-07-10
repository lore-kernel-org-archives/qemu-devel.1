Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5608C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F46920578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AWVsaqT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F46920578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt7Q-0007re-Mz
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfD-000608-EN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:55 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqfB-0006wr-SS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:55 -0400
Received: by mail-pl1-x643.google.com with SMTP id b9so2100150plx.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EmjSuzx85cSvrK8QLftoQBD3joP+WMRu0V7hzKLsOtM=;
 b=AWVsaqT8uuqMekSaBfOqGUG7RhBp5yd09+GzNaCfCJGW9Bha3GhkmpFNZNKqflV+Ck
 tB7EVX90SnkRRwAjcKezq4xYgXpo+jycv0cNF8JNkZ5nnULDdmER+DunmjnjH4lzlS5U
 YDtqcz1uz83kReXd3LSx4WeBvhVr9xpB4LqJJalZjM8FFGVE4+SrVAaGYC4rKpFtC09n
 QWZFVSmeURpD0BJExUjr4AKSeHjSKdny/nQQ3faQUoyi/48hsJDXHNG8O7Gviu5lwNQQ
 7enc5FT94zu+gOMvxgpYqL8G1TgQ8ze1uxTn29qEaKSVUtom+Y/CayQJKSWmrrdZkdkv
 NV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EmjSuzx85cSvrK8QLftoQBD3joP+WMRu0V7hzKLsOtM=;
 b=SdcAHSuBgE2rXYGig3+9SB2nCyJrus60k41c9T/rKyrbCd8WxvJFXoZb3u7qAYAC5l
 o4I/FjFDdJPPOLXuHMwGFC5xvPn0zhFmHw8C2VNx8Mh2vKkkLI3BdY9ziMtkLdmfGGek
 7iPN4/zr+BUDGTDzplJF283qOoYcxkl6PRDoJ/9lnmem2ot3lGhgumNsl5ZuZ2+KYDMk
 xLzQnV/vPsizgK9Z2QglkZ7Yoe6JSLsrgI5v9fiSgjYTwmn1cKbtBW7Nb+Q7s4dNerhU
 Gl/Yuyse0cTuE7xlF32yNkpkrGZgUuiodUmEn/JCwEKu1lkuUfbNAVPOZmcQ+j6PQ93e
 5lUg==
X-Gm-Message-State: AOAM5310Iabec38nEVpGEZn8Ht97m9mHQ6zIlwIiT+9nSePR7cGqi/M3
 18VfTY/ElmemDyWVOPxdyogQycmo/qUINA==
X-Google-Smtp-Source: ABdhPJzin3myzTkXflH1OYV3qhFZhCkCf5N5qYokn6krMzB8NOBVZoblGkgperoRXkVw860Tvpab8g==
X-Received: by 2002:a17:90a:ba05:: with SMTP id
 s5mr4676947pjr.132.1594378432542; 
 Fri, 10 Jul 2020 03:53:52 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:53:52 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 49/65] target/riscv: rvv-0.9: floating-point move instructions
Date: Fri, 10 Jul 2020 18:49:03 +0800
Message-Id: <20200710104920.13550-50-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x643.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 57 ++++++++++++-------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 986f62dabc..264cd6509f 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2600,37 +2600,36 @@ GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
 
 static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 {
-    if (vext_check_isa_ill(s) &&
-        vext_check_reg(s, a->rd, false) &&
-        (s->sew != 0)) {
+    REQUIRE_RVV;
+    VEXT_CHECK_ISA_ILL(s);
+    require_align(a->rd, s->flmul);
+    require(s->sew != 0);
 
-        if (s->vl_eq_vlmax) {
-            tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
-                                 MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
-        } else {
-            TCGv_ptr dest;
-            TCGv_i32 desc;
-            uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
-            static gen_helper_vmv_vx * const fns[3] = {
-                gen_helper_vmv_v_x_h,
-                gen_helper_vmv_v_x_w,
-                gen_helper_vmv_v_x_d,
-            };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-
-            dest = tcg_temp_new_ptr();
-            desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
-            tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
-            fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
-
-            tcg_temp_free_ptr(dest);
-            tcg_temp_free_i32(desc);
-            gen_set_label(over);
-        }
-        return true;
+    if (s->vl_eq_vlmax) {
+        tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
+                             MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
+    } else {
+        TCGv_ptr dest;
+        TCGv_i32 desc;
+        uint32_t data = FIELD_DP32(0, VDATA, LMUL, s->lmul);
+        static gen_helper_vmv_vx * const fns[3] = {
+            gen_helper_vmv_v_x_h,
+            gen_helper_vmv_v_x_w,
+            gen_helper_vmv_v_x_d,
+        };
+        TCGLabel *over = gen_new_label();
+        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
+
+        dest = tcg_temp_new_ptr();
+        desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+        tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
+        fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
+
+        tcg_temp_free_ptr(dest);
+        tcg_temp_free_i32(desc);
+        gen_set_label(over);
     }
-    return false;
+    return true;
 }
 
 /* Single-Width Floating-Point/Integer Type-Convert Instructions */
-- 
2.17.1


