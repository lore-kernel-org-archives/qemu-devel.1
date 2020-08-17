Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52D52063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UPCBo2Ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52D52063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b1a-00028g-Vp
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arw-000180-9o
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:41729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7arp-00057X-WC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:51:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id f10so7159468plj.8
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6riu72clT9/ZXOmnARZwFZnI/yROdE4xjZWMhO0/1y8=;
 b=UPCBo2YasEuW040FphKfhpXGA2k4WOLb2sJbpVCCksrpbvLvlIJuvuYQCXXEMk+y0f
 eb0FsEFZ1Yb3z1tlyACKLmAi3pira/cueORedre5Fg6OcM9l8q82csRumCDyTHeOnLMF
 JbbpW75w9MsGCPhgbxek27VYJsrLIkInC+FzRJaIZZfZP4r+c4vfPVV2EA87axw/x317
 mVC+febPjOXPOZ3/gc1YsGOByKzkZLSpwFv8no+ydh6lplIEId6r76KIIAnKWBxCAB0F
 ZIsYCGlXxtlgGn+F+AiwNnQ82HhIJYBxIoNUxDLlAyzNv4piz1bd3430zOwkR1pUSZHt
 wl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6riu72clT9/ZXOmnARZwFZnI/yROdE4xjZWMhO0/1y8=;
 b=J53qiF/qwiEa1W4KBx8/uLSGC37+tZ2MMpBw80ieNVjpRh5YEYcHBQDpcCgatCR4P8
 /PEq1VY0huLR8Fg9UU5/CbkNu+yPwuDoPEO9CUhcEtNFbBiUWilJyDCpuJsRE2ZFEjGH
 gl/C4lRR/CcXukmJP8F0GC8of9bj8nQJMDLqcYFC5zhkGZCvamkhXm0u/48l0VdUkq7Y
 st/V+sKZvaUEhT94uvbKsZYjUV9BiMBzmWFqDkx27YO/OU5H5Mnndbr7hMG2C85Bfk/H
 kb1hThNvMyVXS3OxcRcUMnjaJX7HeZYqFOUt+92n037U8p+VSQ0z2do4l4FLBBmk5D4F
 6wNg==
X-Gm-Message-State: AOAM530jKX1q7X0rZ6knSf0h8YQUZB1PNKWodt7aAXsvYz29Oktb6+Rm
 4N7nhloXsu4vuxcShM9+RbddGOAIbC/5Ng==
X-Google-Smtp-Source: ABdhPJwGDRJIMyZ5C76npaMjl6B9IHMS+p8ESviXxpR1hsehyBWsfFz9Jn6l13tkcMLkNjjATjq51g==
X-Received: by 2002:a17:90a:3627:: with SMTP id
 s36mr12350468pjb.70.1597654304484; 
 Mon, 17 Aug 2020 01:51:44 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:51:44 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 35/70] target/riscv: rvv-1.0: integer scalar move instructions
Date: Mon, 17 Aug 2020 16:49:20 +0800
Message-Id: <20200817084955.28793-36-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62d.google.com
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

* Remove "vmv.s.x: dothing if rs1 == 0" constraint.
* Add vmv.x.s instruction.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn32.decode              |  3 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 45 ++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 67306ac7161..6b90b67c7cc 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -598,8 +598,9 @@ vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
+vmv_x_s         010000 1 ..... 00000 010 ..... 1010111 @r2rd
+vmv_s_x         010000 1 00000 ..... 110 ..... 1010111 @r2
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
-vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
 vfmv_s_f        001101 1 00000 ..... 101 ..... 1010111 @r2
 vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 392a1eba6b9..92d34be5a99 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3207,27 +3207,56 @@ static void vec_element_storei(DisasContext *s, int vreg,
     store_element(val, cpu_env, endian_ofs(s, vreg, idx), s->sew);
 }
 
+/* vmv.x.s rd, vs2 # x[rd] = vs2[0] */
+static bool trans_vmv_x_s(DisasContext *s, arg_vmv_x_s *a)
+{
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s)) {
+        TCGv_i64 t1;
+        TCGv dest;
+
+        t1 = tcg_temp_new_i64();
+        dest = tcg_temp_new();
+        /*
+         * load vreg and sign-extend to 64 bits,
+         * then truncate to XLEN bits before storing to gpr.
+         */
+        vec_element_loadi(s, t1, a->rs2, 0, true);
+        tcg_gen_trunc_i64_tl(dest, t1);
+        gen_set_gpr(a->rd, dest);
+        tcg_temp_free_i64(t1);
+        tcg_temp_free(dest);
+
+        return true;
+    }
+    return false;
+}
+
 /* vmv.s.x vd, rs1 # vd[0] = rs1 */
 static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
 {
-    if (vext_check_isa_ill(s)) {
+    if (require_rvv(s) &&
+        vext_check_isa_ill(s)) {
         /* This instruction ignores LMUL and vector register groups */
-        int maxsz = s->vlen >> 3;
         TCGv_i64 t1;
+        TCGv s1;
         TCGLabel *over = gen_new_label();
 
         tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-        tcg_gen_gvec_dup_imm(SEW64, vreg_ofs(s, a->rd), maxsz, maxsz, 0);
-        if (a->rs1 == 0) {
-            goto done;
-        }
 
         t1 = tcg_temp_new_i64();
-        tcg_gen_extu_tl_i64(t1, cpu_gpr[a->rs1]);
+        s1 = tcg_temp_new();
+
+        /*
+         * load gpr and sign-extend to 64 bits,
+         * then truncate to SEW bits when storing to vreg.
+         */
+        gen_get_gpr(s1, a->rs1);
+        tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei(s, a->rd, 0, t1);
         tcg_temp_free_i64(t1);
+        tcg_temp_free(s1);
         mark_vs_dirty(s);
-    done:
         gen_set_label(over);
         return true;
     }
-- 
2.17.1


