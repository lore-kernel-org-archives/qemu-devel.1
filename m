Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82069C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F8522D74
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ScfVnrR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F8522D74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dsC-0002Oh-Az
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTB-0004eR-84
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:58 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:37220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dT7-00085F-DF
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id s26so24716511pfm.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vY2lbA6woX2KiM9/SKOS5oHJ8x4EHcHF3Lh9OQafu80=;
 b=ScfVnrR2Sbz/JIIo31PIFy3fRE3TNYYJR+nvuI2MGJ+aQxAM0W2eiafv/IjW/Xks8d
 ely0OCic0OOufHrifNvl4Gbx4z8HFli/yWEKwxBeuSthFkNQxUXX0J2210TPU/+/0Qxa
 m0TnwRMeF5H8s0rInuqsFxd0coPepFVkbR0YL7eLaIDlOmxU5vXWbSdqBbTQhGJp+1Hb
 TKj2PCXgQOrHGXhQEHEQV94djccmsCRC+Su9+TaRNq7wkWvSXC8MvbM1dLmKwzj+waWZ
 vjQODDFCraqmSlZ/bQwE7zG0yVIju3ZRmQVVxgOSgnmhMkS4Kam3dnW0sxr5mEGgEkZF
 4foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vY2lbA6woX2KiM9/SKOS5oHJ8x4EHcHF3Lh9OQafu80=;
 b=FoPyW0PgCD84TeoPDwpZoh/SeW8DfmdIqx+C79SpfkKAOwzc4lSGbiI1Yc/pyOPewJ
 +4yxiErj4LzHV90+aDGyg4a01Nu9rpYvsouO6Kibim2F4XIAsT2ztSR7rrf6gqkh+pte
 SqzhdZB7dA247HWlvGNIbgtbc4EHWzb3TrtexGFSnt2cIYYVw5pWvcF9Jb50LQMx1soE
 iODvCsu7Hgz/z5fRWxgQwi5rA9m0I+EMHE3kFH2MooahnmayPk4tHSJN+gzSFtX8bIA7
 QAItGVSnlFHozcAwio2Tm7wUIInSC7BACwianROqK9ooKyzqjy35oajfU0VoRkNT9Dle
 OU1w==
X-Gm-Message-State: AOAM530lkiqVRa4hTQOh/BmNyisE2gzhBDWOvSfLM1i+obwlRufE3RRa
 ign6FsvP+tZgz59cwrpmmlRxy8BIe7g=
X-Google-Smtp-Source: ABdhPJyOtqSaHuQ782OU5h4iyqzHl6oYcG0K6XPs91zQZCPagmgzRKS2jmHatQnlCqKNLLYLiTEMXg==
X-Received: by 2002:aa7:9357:: with SMTP id 23mr7632552pfn.278.1596710991115; 
 Thu, 06 Aug 2020 03:49:51 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:50 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 62/71] target/riscv: rvv-1.0: remove integer extract
 instruction
Date: Thu,  6 Aug 2020 18:46:59 +0800
Message-Id: <20200806104709.13235-63-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 target/riscv/insn32.decode              |  1 -
 target/riscv/insn_trans/trans_rvv.inc.c | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 994ef3031b5..425cfd7cb32 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -603,7 +603,6 @@ viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
 vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
 vmv_x_s         010000 1 ..... 00000 010 ..... 1010111 @r2rd
 vmv_s_x         010000 1 00000 ..... 110 ..... 1010111 @r2
-vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vfmv_f_s        010000 1 ..... 00000 001 ..... 1010111 @r2rd
 vfmv_s_f        010000 1 00000 ..... 101 ..... 1010111 @r2
 vslideup_vx     001110 . ..... ..... 100 ..... 1010111 @r_vm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 718a8834962..f2bd3972558 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -3146,8 +3146,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
  *** Vector Permutation Instructions
  */
 
-/* Integer Extract Instruction */
-
 static void load_element(TCGv_i64 dest, TCGv_ptr base,
                          int ofs, int sew, bool sign)
 {
@@ -3249,27 +3247,6 @@ static void vec_element_loadi(DisasContext *s, TCGv_i64 dest,
     load_element(dest, cpu_env, endian_ofs(s, vreg, idx), s->sew, sign);
 }
 
-static bool trans_vext_x_v(DisasContext *s, arg_r *a)
-{
-    TCGv_i64 tmp = tcg_temp_new_i64();
-    TCGv dest = tcg_temp_new();
-
-    if (a->rs1 == 0) {
-        /* Special case vmv.x.s rd, vs2. */
-        vec_element_loadi(s, tmp, a->rs2, 0);
-    } else {
-        /* This instruction ignores LMUL and vector register groups */
-        int vlmax = s->vlen >> (3 + s->sew);
-        vec_element_loadx(s, tmp, a->rs2, cpu_gpr[a->rs1], vlmax);
-    }
-    tcg_gen_trunc_i64_tl(dest, tmp);
-    gen_set_gpr(a->rd, dest);
-
-    tcg_temp_free(dest);
-    tcg_temp_free_i64(tmp);
-    return true;
-}
-
 /* Integer Scalar Move Instruction */
 
 static void store_element(TCGv_i64 val, TCGv_ptr base,
-- 
2.17.1


