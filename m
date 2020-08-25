Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCFE20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULTV3v1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCFE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgMF-00042O-OZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3r-0008OB-CO
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:55 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3p-0001wf-0C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:54 -0400
Received: by mail-pj1-x1042.google.com with SMTP id nv17so122845pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j79ljoP5zzbkRewQNHGjmrrLK+0Gv9JhkSWBpicBIVs=;
 b=ULTV3v1R49EuzP5+A8e98MreymoinxCGXW4hj6I06y34y8S2++ADqyyB8KUhNNwrd2
 JfnMmung4nHdh8fqXI5JCIK3r4cWxRxNfhmbsQ+5fBdF3H8B0o6QzuNlJ9hSZcARWbWx
 TgZHRQxM4uPsrnLdbvwnWT10Do55njB6st4Fl5W4kr0WKnrnqAK1bDfHjoQ3gQqJWMuW
 KbtI1C+gV0zOajquPBa92GRLf65+MqeSqiHtC/FhPt+hymHEGEHrdcjColymG0yhS5xX
 yIFF4LasgomDH/Hfqj9fbQ9L0N2ldUabmPYd0W6HG4n/7VENjOdHYJ77tU94yZwbBhbH
 U8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j79ljoP5zzbkRewQNHGjmrrLK+0Gv9JhkSWBpicBIVs=;
 b=WF/LqyjmiUDMwKdbuGCfG3vD9z9Vbcdhop4Qn7EHG3Mhuvp0ySgVzpojrwoWd31k6N
 LtOEhl8vA2YQRUNnDHQDCzVdkWVzXTHezmzl2Rqrf1Xi3Vb1QvtuQx9JiHlnuVenH/XM
 Pe1T/LpZQkluTn+Oma0hQqFhQ+Df6lDw1PJOV2I3+RzhZQsfrRLAGcjl+zD6R5OL62Ok
 zGyhkN2NpziKLAjeBzbViOxk88JQX5rRwjnYZMIgD3e/XozdZXQrjQ+UrQGAIDJTcMR8
 HiG9nXH8YUwngty8ieJ10jRp46lb9g4H9vLrUe664n7EKxnadZiKBIJtVC7feeP5x9Gn
 bAYQ==
X-Gm-Message-State: AOAM530/+4zDnSdpDdFUVt6olcZIaj8AM5l4Zs5E1/rY8JmCQKE+uH8h
 Ke0Dhy+ORkUq2JfYo7b338qayuU+1xD6AQ==
X-Google-Smtp-Source: ABdhPJzp1+QLnqS5IBhF+RPWc/YkNV4NpbePqkuA/AfLmXRIiKIG0Vaeu6KKRUV+iD339E2azELTAQ==
X-Received: by 2002:a17:90a:4803:: with SMTP id
 a3mr3094542pjh.192.1598389250812; 
 Tue, 25 Aug 2020 14:00:50 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 47/77] target/microblaze: Convert dec_fpu to decodetree
Date: Tue, 25 Aug 2020 13:59:20 -0700
Message-Id: <20200825205950.730499-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current dec_check_fpuv2 test, raising an FPU exception for
an unimplemented instruction, appears to be contradictory to
the manual.  Drop that and merely check use_fpu == 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  19 +++++
 target/microblaze/translate.c  | 152 +++++++++------------------------
 2 files changed, 60 insertions(+), 111 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index a7eb7d4e6f..ea6743c7e5 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -73,6 +73,25 @@ clz             100100 ..... ..... 00000 000 1110 0000  @typea0
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+fadd            010110 ..... ..... ..... 0000 000 0000  @typea
+frsub           010110 ..... ..... ..... 0001 000 0000  @typea
+fmul            010110 ..... ..... ..... 0010 000 0000  @typea
+fdiv            010110 ..... ..... ..... 0011 000 0000  @typea
+fcmp_un         010110 ..... ..... ..... 0100 000 0000  @typea
+fcmp_lt         010110 ..... ..... ..... 0100 001 0000  @typea
+fcmp_eq         010110 ..... ..... ..... 0100 010 0000  @typea
+fcmp_le         010110 ..... ..... ..... 0100 011 0000  @typea
+fcmp_gt         010110 ..... ..... ..... 0100 100 0000  @typea
+fcmp_ne         010110 ..... ..... ..... 0100 101 0000  @typea
+fcmp_ge         010110 ..... ..... ..... 0100 110 0000  @typea
+
+# Note that flt and fint, unlike fsqrt, are documented as having the RB
+# operand which is unused.  So allow the field to be non-zero but discard
+# the value and treat as 2-operand insns.
+flt             010110 ..... ..... ----- 0101 000 0000  @typea0
+fint            010110 ..... ..... ----- 0110 000 0000  @typea0
+fsqrt           010110 ..... ..... 00000 0111 000 0000  @typea0
+
 idiv            010010 ..... ..... ..... 000 0000 0000  @typea
 idivu           010010 ..... ..... ..... 000 0000 0010  @typea
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c1d19f4678..7d1ada7aad 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -318,6 +318,14 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_val(dc, a, SE, FN); }
 
+#define ENV_WRAPPER2(NAME, HELPER) \
+    static void NAME(TCGv_i32 out, TCGv_i32 ina) \
+    { HELPER(out, cpu_env, ina); }
+
+#define ENV_WRAPPER3(NAME, HELPER) \
+    static void NAME(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb) \
+    { HELPER(out, cpu_env, ina, inb); }
+
 /* No input carry, but output carry. */
 static void gen_add(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
@@ -464,6 +472,39 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+ENV_WRAPPER3(gen_fadd, gen_helper_fadd)
+ENV_WRAPPER3(gen_frsub, gen_helper_frsub)
+ENV_WRAPPER3(gen_fmul, gen_helper_fmul)
+ENV_WRAPPER3(gen_fdiv, gen_helper_fdiv)
+ENV_WRAPPER3(gen_fcmp_un, gen_helper_fcmp_un)
+ENV_WRAPPER3(gen_fcmp_lt, gen_helper_fcmp_lt)
+ENV_WRAPPER3(gen_fcmp_eq, gen_helper_fcmp_eq)
+ENV_WRAPPER3(gen_fcmp_le, gen_helper_fcmp_le)
+ENV_WRAPPER3(gen_fcmp_gt, gen_helper_fcmp_gt)
+ENV_WRAPPER3(gen_fcmp_ne, gen_helper_fcmp_ne)
+ENV_WRAPPER3(gen_fcmp_ge, gen_helper_fcmp_ge)
+
+DO_TYPEA_CFG(fadd, use_fpu, true, gen_fadd)
+DO_TYPEA_CFG(frsub, use_fpu, true, gen_frsub)
+DO_TYPEA_CFG(fmul, use_fpu, true, gen_fmul)
+DO_TYPEA_CFG(fdiv, use_fpu, true, gen_fdiv)
+DO_TYPEA_CFG(fcmp_un, use_fpu, true, gen_fcmp_un)
+DO_TYPEA_CFG(fcmp_lt, use_fpu, true, gen_fcmp_lt)
+DO_TYPEA_CFG(fcmp_eq, use_fpu, true, gen_fcmp_eq)
+DO_TYPEA_CFG(fcmp_le, use_fpu, true, gen_fcmp_le)
+DO_TYPEA_CFG(fcmp_gt, use_fpu, true, gen_fcmp_gt)
+DO_TYPEA_CFG(fcmp_ne, use_fpu, true, gen_fcmp_ne)
+DO_TYPEA_CFG(fcmp_ge, use_fpu, true, gen_fcmp_ge)
+
+ENV_WRAPPER2(gen_flt, gen_helper_flt)
+ENV_WRAPPER2(gen_fint, gen_helper_fint)
+ENV_WRAPPER2(gen_fsqrt, gen_helper_fsqrt)
+
+DO_TYPEA0_CFG(flt, use_fpu >= 2, true, gen_flt)
+DO_TYPEA0_CFG(fint, use_fpu >= 2, true, gen_fint)
+DO_TYPEA0_CFG(fsqrt, use_fpu >= 2, true, gen_fsqrt)
+
+/* Does not use ENV_WRAPPER3, because arguments are swapped as well. */
 static void gen_idiv(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
     gen_helper_divs(out, cpu_env, inb, ina);
@@ -1389,116 +1430,6 @@ static void dec_rts(DisasContext *dc)
     tcg_gen_add_i32(cpu_btarget, cpu_R[dc->ra], *dec_alu_op_b(dc));
 }
 
-static int dec_check_fpuv2(DisasContext *dc)
-{
-    if ((dc->cpu->cfg.use_fpu != 2) && (dc->tb_flags & MSR_EE_FLAG)) {
-        gen_raise_hw_excp(dc, ESR_EC_FPU);
-    }
-    return (dc->cpu->cfg.use_fpu == 2) ? PVR2_USE_FPU2_MASK : 0;
-}
-
-static void dec_fpu(DisasContext *dc)
-{
-    unsigned int fpu_insn;
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_fpu)) {
-        return;
-    }
-
-    fpu_insn = (dc->ir >> 7) & 7;
-
-    switch (fpu_insn) {
-        case 0:
-            gen_helper_fadd(cpu_R[dc->rd], cpu_env, cpu_R[dc->ra],
-                            cpu_R[dc->rb]);
-            break;
-
-        case 1:
-            gen_helper_frsub(cpu_R[dc->rd], cpu_env, cpu_R[dc->ra],
-                             cpu_R[dc->rb]);
-            break;
-
-        case 2:
-            gen_helper_fmul(cpu_R[dc->rd], cpu_env, cpu_R[dc->ra],
-                            cpu_R[dc->rb]);
-            break;
-
-        case 3:
-            gen_helper_fdiv(cpu_R[dc->rd], cpu_env, cpu_R[dc->ra],
-                            cpu_R[dc->rb]);
-            break;
-
-        case 4:
-            switch ((dc->ir >> 4) & 7) {
-                case 0:
-                    gen_helper_fcmp_un(cpu_R[dc->rd], cpu_env,
-                                       cpu_R[dc->ra], cpu_R[dc->rb]);
-                    break;
-                case 1:
-                    gen_helper_fcmp_lt(cpu_R[dc->rd], cpu_env,
-                                       cpu_R[dc->ra], cpu_R[dc->rb]);
-                    break;
-                case 2:
-                    gen_helper_fcmp_eq(cpu_R[dc->rd], cpu_env,
-                                       cpu_R[dc->ra], cpu_R[dc->rb]);
-                    break;
-                case 3:
-                    gen_helper_fcmp_le(cpu_R[dc->rd], cpu_env,
-                                       cpu_R[dc->ra], cpu_R[dc->rb]);
-                    break;
-                case 4:
-                    gen_helper_fcmp_gt(cpu_R[dc->rd], cpu_env,
-                                       cpu_R[dc->ra], cpu_R[dc->rb]);
-                    break;
-                case 5:
-                    gen_helper_fcmp_ne(cpu_R[dc->rd], cpu_env,
-                                       cpu_R[dc->ra], cpu_R[dc->rb]);
-                    break;
-                case 6:
-                    gen_helper_fcmp_ge(cpu_R[dc->rd], cpu_env,
-                                       cpu_R[dc->ra], cpu_R[dc->rb]);
-                    break;
-                default:
-                    qemu_log_mask(LOG_UNIMP,
-                                  "unimplemented fcmp fpu_insn=%x pc=%x"
-                                  " opc=%x\n",
-                                  fpu_insn, (uint32_t)dc->base.pc_next,
-                                  dc->opcode);
-                    dc->abort_at_next_insn = 1;
-                    break;
-            }
-            break;
-
-        case 5:
-            if (!dec_check_fpuv2(dc)) {
-                return;
-            }
-            gen_helper_flt(cpu_R[dc->rd], cpu_env, cpu_R[dc->ra]);
-            break;
-
-        case 6:
-            if (!dec_check_fpuv2(dc)) {
-                return;
-            }
-            gen_helper_fint(cpu_R[dc->rd], cpu_env, cpu_R[dc->ra]);
-            break;
-
-        case 7:
-            if (!dec_check_fpuv2(dc)) {
-                return;
-            }
-            gen_helper_fsqrt(cpu_R[dc->rd], cpu_env, cpu_R[dc->ra]);
-            break;
-
-        default:
-            qemu_log_mask(LOG_UNIMP, "unimplemented FPU insn fpu_insn=%x pc=%x"
-                          " opc=%x\n",
-                          fpu_insn, (uint32_t)dc->base.pc_next, dc->opcode);
-            dc->abort_at_next_insn = 1;
-            break;
-    }
-}
-
 static void dec_null(DisasContext *dc)
 {
     if (trap_illegal(dc, true)) {
@@ -1551,7 +1482,6 @@ static struct decoder_info {
     {DEC_BR, dec_br},
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
-    {DEC_FPU, dec_fpu},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
     {{0, 0}, dec_null}
-- 
2.25.1


