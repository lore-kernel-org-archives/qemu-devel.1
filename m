Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51848C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F97A22D05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dOAlFjYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F97A22D05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dl4-0004rX-PS
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRT-000211-D8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:45705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dRQ-0007mF-IN
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:48:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id bh1so14210316plb.12
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FGOh+A6IVpmY/plCM7TtdvaB7Halabe2EZ+P5FsPKfw=;
 b=dOAlFjYdOyh1yqGbOHNJn0JUtzch5/HEHGD2QQZsm3/HCTwvCXhPTRB+fzdhbTYsB/
 inn/7/fTymhDXAoHykgwSSqn71COBD/Fug+Z/OOxhWIxd+7yeuVLnrHcaYjqjGIb7hq9
 OBLfyLr0HOeKT7HxX/qRBSaVnnquB93ej0gAUaNrIbYUKcQNOgS2M89yUaQu76enmxIc
 sEjYf0jAQCJCvXQN9aTnHsZfltckUTwe/qBQTWmEsYvYCRQ99/6jaPbZZQNRvqRbo6Ll
 Y0WUsjuVf6rcUoSXvGvUN2uPCBxT6NJnotvvNPMR8BxESnFPptZTXOIssAga6hPrx/rE
 K9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FGOh+A6IVpmY/plCM7TtdvaB7Halabe2EZ+P5FsPKfw=;
 b=eNDnHsWMofiApgJJVT+79fUoQhWic5hMgtqCUGqpzEkZhdSizLy+SXAm9ftsLArOCd
 YbpGmUFbxD3bLB7D1CKGI3MhUJlOVNiElVFnQ1lQzE6ajj5RPlBhfX3Q87JLZMVxSm+X
 HY7WMxZgHlou/22ozp0C4OAbOZpBnNHI3GG8J0LcEndFkik5J1uUarO2L7DASGnI298N
 xl6NvI0KMmb7gBcgE7L44kb+FytL8LsKCASUYzYpmrGJpJjrZ/2ycQnZzNUlAb0LOwfe
 ZXpGuZ6uXoAcAiRW8oSU7uTjLiJQpALLlBNUEVv9wMkmPgFJXBhQcX5jM9+yKf0YpGjd
 rEEg==
X-Gm-Message-State: AOAM533qRHlX95qBSrDDEz6ar6xE7rNypzRMCXx0UCI+aJ5fvPr0G+6r
 1acw3XUYLLOcJPgV2IIJBxrjw1eCQdA=
X-Google-Smtp-Source: ABdhPJwbaFlpC5O91Xz5GM5vCZPUj1L31VJcPeHEb1AUuC8Wbsh1xTt/A/TFmdPuP86X16BPDscZbQ==
X-Received: by 2002:a17:90b:4acd:: with SMTP id
 mh13mr8060142pjb.147.1596710886460; 
 Thu, 06 Aug 2020 03:48:06 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:48:06 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 18/71] target/riscv: rvv-1.0: apply nanbox helper in
 opfvf_trans
Date: Thu,  6 Aug 2020 18:46:15 +0800
Message-Id: <20200806104709.13235-19-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62a.google.com
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
---
 target/riscv/insn_trans/trans_rvv.inc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 525aff06815..8a6050f6b32 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -2156,6 +2156,7 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 {
     TCGv_ptr dest, src2, mask;
     TCGv_i32 desc;
+    TCGv_i64 t1;
 
     TCGLabel *over = gen_new_label();
     tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
@@ -2169,12 +2170,17 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     tcg_gen_addi_ptr(src2, cpu_env, vreg_ofs(s, vs2));
     tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
 
-    fn(dest, mask, cpu_fpr[rs1], src2, cpu_env, desc);
+    /* NaN-box f[rs1] */
+    t1 = tcg_temp_new_i64();
+    do_nanbox(s, t1, cpu_fpr[rs1]);
+
+    fn(dest, mask, t1, src2, cpu_env, desc);
 
     tcg_temp_free_ptr(dest);
     tcg_temp_free_ptr(mask);
     tcg_temp_free_ptr(src2);
     tcg_temp_free_i32(desc);
+    tcg_temp_free_i64(t1);
     mark_vs_dirty(s);
     gen_set_label(over);
     return true;
-- 
2.17.1


