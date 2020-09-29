Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58FC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60FB20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dKoz1VCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60FB20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLbN-0003FO-Ka
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyy-0006zr-Bv
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:12 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:37866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyv-0002Np-Hu
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:12 -0400
Received: by mail-pg1-x536.google.com with SMTP id e18so4651261pgd.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E9RTi514wB1x4upiCcYJC88mFJzj05fsXS9Z3A/1lI8=;
 b=dKoz1VCMzZnan+149PXvC6hq6r1kfbFmDv4mPNtv4cGbxcg5fSQMzRsn8zgb3mq67W
 gW/mKYMxSrcM0oQQGg1ZvQOttZ/L0NV0qoNvHUuHQziZtTTi9TNSJS2QtozRbUQZsGda
 FukxLG2lx09iSWz2L77pOk6hFyax+HWslnfcLeQh70RScMy+qBuMEvs8x71EYGdgGUIM
 9iKdfeoE12Nis9EyuUZxxyuef7eOb2OGa1+hiDzNNi+ru9EcGI9d8yicnu6ZjZgqxy8A
 wLFy4/loyhDxB7FunulBFVbKvFMExy3lL8HXfWRwt3UqIusfl6HB0aAiGJGzbpmttK1Q
 YigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E9RTi514wB1x4upiCcYJC88mFJzj05fsXS9Z3A/1lI8=;
 b=Uy2E9p1Fc4CLr50/Aq//HITgxDZygi93QHn8mR0LKD6n+hsFzvORUGZ8VZHempNmj0
 47i4Nv0lmjN8qcmFhG3AeZF0B4K/qUs6ypmSFsSocHl2LVL0Pr96ChWP9zR4MdkIn7SM
 2NjZIO1JUfdhme00xrL4gjOMW1OSFDXpcWYIos3lJ5F4MBrUle+OW1uVTfsXDPvPequH
 pvP+Dg6ofJBzd1clbp40iP7qj412U/KVDkHftkJ127aWQwRBMnnP4AaeDTFX47zAqZtE
 jGlLieq8GIrQ50gvALRP9ZL7ivxHBh2QJe9BNmjE6k6sRBHke1XE5KGfGg4zlV5MAgV/
 A5AQ==
X-Gm-Message-State: AOAM532fWtVWYkPuraJAb3oQdpB01xiQ1BI3I7jsqKI4VeNnMFJAQNBJ
 cbgHKz9uxMYCeVcrhc48jV5QSSsdjmE6Vw==
X-Google-Smtp-Source: ABdhPJxwnRz3i7Z+QZT0XR7PymbYRKlN4RErBiDgSHLx9QDaFsI4kdEJQmToA/F0Q7pdOhVLN/Yr/w==
X-Received: by 2002:a17:902:fe81:b029:d2:abce:b4a8 with SMTP id
 x1-20020a170902fe81b02900d2abceb4a8mr3722153plm.38.1601406488151; 
 Tue, 29 Sep 2020 12:08:08 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:08:07 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 48/68] target/riscv: rvv-1.0: mask-register logical
 instructions
Date: Wed, 30 Sep 2020 03:04:23 +0800
Message-Id: <20200929190448.31116-49-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x536.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 ++-
 target/riscv/vector_helper.c            | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b1f0fa76b2..5726fd7133 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2899,7 +2899,8 @@ GEN_OPFVV_WIDEN_TRANS(vfwredsum_vs, reduction_check)
 #define GEN_MM_TRANS(NAME)                                         \
 static bool trans_##NAME(DisasContext *s, arg_r *a)                \
 {                                                                  \
-    if (vext_check_isa_ill(s)) {                                   \
+    if (require_rvv(s) &&                                          \
+        vext_check_isa_ill(s)) {                                   \
         uint32_t data = 0;                                         \
         gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
         TCGLabel *over = gen_new_label();                          \
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 93ed6f54e9..a2ef6b708c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4440,7 +4440,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
 {                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;          \
     uint32_t vl = env->vl;                                \
     uint32_t i;                                           \
     int a, b;                                             \
@@ -4450,9 +4449,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         b = vext_elem_mask(vs2, i);                       \
         vext_set_elem_mask(vd, i, OP(b, a));              \
     }                                                     \
-    for (; i < vlmax; i++) {                              \
-        vext_set_elem_mask(vd, i, 0);                     \
-    }                                                     \
 }
 
 #define DO_NAND(N, M)  (!(N & M))
-- 
2.17.1


