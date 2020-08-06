Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E208922D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DPc5i97W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E208922D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dmU-0007OR-0b
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRv-0002mL-1p
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:39023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRt-0007ss-A6
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id z20so6559941plo.6
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TQUW5yEXaSqtuF8JpWOtroDX50qPmyztu1PCtMnroQQ=;
 b=DPc5i97WRA81UrNHjQ9AGyNEf0P9rkttV+tu4U9tlh1EjMRp2Qjxa25BZDgcgZ1Qbw
 uXG+C+r1pbEXZUpqMhb7qHK+tRT4PMoCuK7k0BWJDtICbdS6xeOsgcgGzoeWUPrT4V75
 jeLnMjqMbZFMxvUO6gpMtFKgaWSa+dj+xwZ2K0EZyTHWYhcUTi5gGq115U74nBQorH4c
 8Vcd5Nd0jlLkFN4nQgiqoGrGUgUFmLdzIVJFEpWLjZFJI1ho8kgP4s4RzQPbtbkKz+vl
 1vq2RkBdY0HdMQ0OURswhN3zZ8gSqCMq3Rn+PienemO7QjpFkFc9t8OzkCgCMY5gQ5oc
 eY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TQUW5yEXaSqtuF8JpWOtroDX50qPmyztu1PCtMnroQQ=;
 b=ousF+WwDDKOqiWTZ2qxm60szWgoomZXU3AiULcSzK7AxtVVykTGEboDHCsE5yr2VLP
 i7inx/6pQ1S4e/tYLrDNZRQnrv1wrrgG9QpFhkteGTBmfY2GPvtrasFi6m19dWL0Wafj
 SbU5T27tNn3E07g+BgpJUUIJDvuOAKIL6KrrWUhQyfBEn8OGJADl0xW3tioPhLWQcWMX
 phtCYSnA69hzdTz+sHEklybPNW+u4q1P3Zz6a4aaLjWxlE4GjCDhNGkPGesvE+9lPvCa
 +cAhXm2yQsIRfGNEc0Rgua40Siv+z2wiZjyg+ryRBjJgd09uaDCm5jrs4KI9JMidgAna
 0oTg==
X-Gm-Message-State: AOAM533wFT0sQBxUbBtwWY5uLLjJZgoO4RoI+HATruCEZBvYFWmg8gq4
 nq9NBwjfnH8MxCfrX2fMp4vNTmcbdgM=
X-Google-Smtp-Source: ABdhPJyzJIDjwYVBkIPowcxss3TtYiyKRfJxWN1SRNaYzM2pfGVQzNUyjRgvTBmO9MLCjKFyjNbNiQ==
X-Received: by 2002:a17:902:ab83:: with SMTP id
 f3mr7307058plr.125.1596710915388; 
 Thu, 06 Aug 2020 03:48:35 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:35 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 30/71] target/riscv: rvv-1.0: mask population count
 instruction
Date: Thu,  6 Aug 2020 18:46:27 +0800
Message-Id: <20200806104709.13235-31-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x636.google.com
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
 target/riscv/helper.h                   | 2 +-
 target/riscv/insn32.decode              | 2 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 7 ++++---
 target/riscv/vector_helper.c            | 6 +++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 25d076d71a8..0a1179370b1 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1066,7 +1066,7 @@ DEF_HELPER_6(vmnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmornot_mm, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmxnor_mm, void, ptr, ptr, ptr, ptr, env, i32)
 
-DEF_HELPER_4(vmpopc_m, tl, ptr, ptr, env, i32)
+DEF_HELPER_4(vpopc_m, tl, ptr, ptr, env, i32)
 
 DEF_HELPER_4(vmfirst_m, tl, ptr, ptr, env, i32)
 
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a800c989050..3d2d43ebd8a 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -591,7 +591,7 @@ vmor_mm         011010 - ..... ..... 010 ..... 1010111 @r
 vmnor_mm        011110 - ..... ..... 010 ..... 1010111 @r
 vmornot_mm      011100 - ..... ..... 010 ..... 1010111 @r
 vmxnor_mm       011111 - ..... ..... 010 ..... 1010111 @r
-vmpopc_m        010100 . ..... ----- 010 ..... 1010111 @r2_vm
+vpopc_m         010000 . ..... 10000 010 ..... 1010111 @r2_vm
 vmfirst_m       010101 . ..... ----- 010 ..... 1010111 @r2_vm
 vmsbf_m         010110 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010110 . ..... 00011 010 ..... 1010111 @r2_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 82403dff4b9..e6ec5d24012 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2884,8 +2884,8 @@ GEN_MM_TRANS(vmnor_mm)
 GEN_MM_TRANS(vmornot_mm)
 GEN_MM_TRANS(vmxnor_mm)
 
-/* Vector mask population count vmpopc */
-static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
+/* Vector mask population count vpopc */
+static bool trans_vpopc_m(DisasContext *s, arg_rmr *a)
 {
     if (require_rvv(s) &&
         vext_check_isa_ill(s)) {
@@ -2904,13 +2904,14 @@ static bool trans_vmpopc_m(DisasContext *s, arg_rmr *a)
         tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, a->rs2));
         tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
 
-        gen_helper_vmpopc_m(dst, mask, src2, cpu_env, desc);
+        gen_helper_vpopc_m(dst, mask, src2, cpu_env, desc);
         gen_set_gpr(a->rd, dst);
 
         tcg_temp_free_ptr(mask);
         tcg_temp_free_ptr(src2);
         tcg_temp_free(dst);
         tcg_temp_free_i32(desc);
+
         return true;
     }
     return false;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 77f62c86e02..a18c02eb124 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4465,9 +4465,9 @@ GEN_VEXT_MASK_VV(vmnor_mm, DO_NOR)
 GEN_VEXT_MASK_VV(vmornot_mm, DO_ORNOT)
 GEN_VEXT_MASK_VV(vmxnor_mm, DO_XNOR)
 
-/* Vector mask population count vmpopc */
-target_ulong HELPER(vmpopc_m)(void *v0, void *vs2, CPURISCVState *env,
-                              uint32_t desc)
+/* Vector mask population count vpopc */
+target_ulong HELPER(vpopc_m)(void *v0, void *vs2, CPURISCVState *env,
+                             uint32_t desc)
 {
     target_ulong cnt = 0;
     uint32_t vm = vext_vm(desc);
-- 
2.17.1


