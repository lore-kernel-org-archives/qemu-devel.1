Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13AEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B2322D2C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MsB8JrE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B2322D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dqX-0007y7-Rl
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSI-0003H1-Mo
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:03 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:50787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSF-0007wC-IQ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:02 -0400
Received: by mail-pj1-x1032.google.com with SMTP id e4so6462233pjd.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PiCEwek3GwYlV43qpUnwxVVCiWPiDa7KHjCJA4ZX0UQ=;
 b=MsB8JrE7I5MFPmHot0vneajUmpA6M7gNqOTOAUpo04jMn1X2BMZrvHj8dCwvglpBp3
 qnxM2oukwU3ASvtzMlPRpgXniMFnkSRTt5AH6D2lFmfp4lmyHK3cQLtzkFtrtXa/tPzQ
 yHIAKx6V/fnCoHEDuUnQx9NTgncHv0NLEb5MhGqM79Om3tqM6BBZvfMsGx5GPMD7Ao0F
 WQEh5OWQqdBg+aajKQjdT4PNebzgrSKEYv7TSUIwxHhFs5p/whMYTK6zFKdlEXX5d0UF
 3RAFGn71QuCsWFfiJMPrSlNQkxHV8pidDnPXYFh18thdc3cSjP9Q1N9LNfHLmSM/OUwf
 huAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PiCEwek3GwYlV43qpUnwxVVCiWPiDa7KHjCJA4ZX0UQ=;
 b=f62V86DHmBBhN8JGbQykRDEHxJkOvFrpsKRwmEX4tofoK6Cg3L6GfPAKQ4L6tTMD/B
 zZ2Ssx52BRGjo9Vsbzjw4ZPCqhYzArE5mgwXVliEsJeOQv8JNPlcQFZxY3Qs14OUoTaC
 U0CrtkBlxkfHWvWkNgYVvosWREzhd3/vc/oRZg/n0v86dYxnkae16AQU+5BI1vpqTKVo
 YkTanxx2EzIEiWDNafa/3egkir2tNfUxAPu1jldbUtZE72907j1lIFiLIwaqvljWx6q7
 goFwEM9Str6rejHw97qG+JCaHtVMx7vXuagl+2aAWwI6qeKvYaHzlnN+F34MkzakdRkm
 KGHA==
X-Gm-Message-State: AOAM5302B0K8LOqwcN3T7U/eCVYmGqJ1TlPnMZaVOk71qEwHsNuyGyEw
 QdeswG3T6+mDv8OG58KwI3x9H89W0Cg=
X-Google-Smtp-Source: ABdhPJz10N+TBes7c7VQd+tZVK5m/60+N6vJWOcd/0LqTnB1MU0e/stF0NLfw9JVjCjX3XvjIzKQLQ==
X-Received: by 2002:a17:90a:c003:: with SMTP id
 p3mr7718660pjt.120.1596710935496; 
 Thu, 06 Aug 2020 03:48:55 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:55 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 38/71] target/riscv: rvv-1.0: floating-point move instruction
Date: Thu,  6 Aug 2020 18:46:35 +0800
Message-Id: <20200806104709.13235-39-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1032.google.com
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

NaN-boxed the scalar floating-point register based on RVV 1.0's rules.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 61d913fb4d9..60ec83e412e 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2678,12 +2678,17 @@ GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
 static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 {
     if (require_rvv(s) &&
+        has_ext(s, RVF) &&
         vext_check_isa_ill(s) &&
         require_align(a->rd, s->flmul) &&
         (s->sew != 0)) {
+        TCGv_i64 t1 = tcg_temp_local_new_i64();
+        /* NaN-box f[rs1] */
+        do_nanbox(s, t1, cpu_fpr[a->rs1]);
+
         if (s->vl_eq_vlmax) {
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
-                                 MAXSZ(s), MAXSZ(s), cpu_fpr[a->rs1]);
+                                 MAXSZ(s), MAXSZ(s), t1);
             mark_vs_dirty(s);
         } else {
             TCGv_ptr dest;
@@ -2700,13 +2705,15 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             dest = tcg_temp_new_ptr();
             desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
             tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
-            fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
+
+            fns[s->sew - 1](dest, t1, cpu_env, desc);
 
             tcg_temp_free_ptr(dest);
             tcg_temp_free_i32(desc);
             mark_vs_dirty(s);
             gen_set_label(over);
         }
+        tcg_temp_free_i64(t1);
         return true;
     }
     return false;
-- 
2.17.1


