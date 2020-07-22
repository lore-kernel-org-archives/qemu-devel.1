Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E4BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C776206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EjVf2Uy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C776206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyB4z-0006JG-BY
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAu1-0000Rf-Ll
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:05 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAtz-0005Wb-3d
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:19:05 -0400
Received: by mail-pg1-x543.google.com with SMTP id l63so858633pge.12
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lVeIL6sco3ONh+Bbp+QoLOvs2rU2KjxsD48epcvi0xM=;
 b=EjVf2Uy9LM2r2fcwRB72VK7hQaoqvYib8AOkE367YBVhiXXwmCNpoNqodH3Qja6Rky
 muY7b6wb8hD4rLuSx/yfr3gkPC0iHq8XeQPJjGmEVAYL4JycZvqXCkzUAyAXfREsuQhv
 JLPTJKVeahXslxiDfZXka2LlF4m2jJxeynDmiM0mjUROfpqU8UvYh1wLe2EHfnJB3xhV
 S3sskPFx4Ozjfz8ZmvHbXC5L4mnFazOswJjs1aJILllHk8gqytZXVEZ+Ye9Mn6N16a5P
 +lpZMXzV08wC9ChVLJYw4A3aTZw/Q11ArTa7XQzuizn1fSBvgPympegI0BS0ruzsXZ/m
 DkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lVeIL6sco3ONh+Bbp+QoLOvs2rU2KjxsD48epcvi0xM=;
 b=mrnkyF0T1kIVrY0h9M4SD60kPWF0tsGqRa8bhzj51+KPnR5td/sP8kkg/xsK6J9+kY
 R1apLnSA3DHyXqukNOBHmuAzIfc93jBvU/leLzspDISYCXb2nHDM02x8dFxIKjsMzbkC
 X5yyec/9vwYye/45tmpeu7dLs27L+LbpyUnQ8QDTqaso5e8mxhPH5UuRimNuWZP/fNQB
 4KXt9Ej3V2g2f5UUsGNX0B+bXO23n/WG19x3GBSw0lHuuFxz/dFEM42bvjuvKz6+TmnT
 kvbJu2ke/jDb3berTTlEXh/1xmabjKRRkV771CdlGXnxOB9koR8G5J2aAgMkapPve9ZV
 QI5A==
X-Gm-Message-State: AOAM531JptwWkWlpWcHNKg2Oo1HsY7aSD2iOjA03UBFnCyCeIWk9aD+o
 O6uxo6WYhOv1y40pNy9K9Yvhx67blng=
X-Google-Smtp-Source: ABdhPJw64aCt3pf0FJ5M1wE2OWKkAmRPTHmmsVTrirt2HeTLUuKDKJG2GYua1VP9fSA95KMlMLYVWw==
X-Received: by 2002:a62:6201:: with SMTP id w1mr28589831pfb.254.1595409541786; 
 Wed, 22 Jul 2020 02:19:01 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:19:01 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 21/76] target/riscv: rvv-0.9: configure instructions
Date: Wed, 22 Jul 2020 17:15:44 +0800
Message-Id: <20200722091641.8834-22-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x543.google.com
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn_trans/trans_rvv.inc.c | 12 ++++++++----
 target/riscv/vector_helper.c            | 10 +++++++++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 85738ba4f7..ca2ae59bb3 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -98,8 +98,10 @@ static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
     s2 = tcg_temp_new();
     dst = tcg_temp_new();
 
-    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
-    if (a->rs1 == 0) {
+    if (a->rd == 0 && a->rs1 == 0) {
+        s1 = tcg_temp_new();
+        tcg_gen_mov_tl(s1, cpu_vl);
+    } else if (a->rs1 == 0) {
         /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
         s1 = tcg_const_tl(RV_VLEN_MAX);
     } else {
@@ -131,8 +133,10 @@ static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
     s2 = tcg_const_tl(a->zimm);
     dst = tcg_temp_new();
 
-    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
-    if (a->rs1 == 0) {
+    if (a->rd == 0 && a->rs1 == 0) {
+        s1 = tcg_temp_new();
+        tcg_gen_mov_tl(s1, cpu_vl);
+    } else if (a->rs1 == 0) {
         /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
         s1 = tcg_const_tl(RV_VLEN_MAX);
     } else {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fb689ab3f9..9320eeabfd 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -36,7 +36,15 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     bool vill = FIELD_EX64(s2, VTYPE, VILL);
     target_ulong reserved = FIELD_EX64(s2, VTYPE, RESERVED);
 
-    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
+    uint64_t lmul = (FIELD_EX64(s2, VTYPE, VFLMUL) << 2)
+        | FIELD_EX64(s2, VTYPE, VLMUL);
+    float vflmul = flmul_table[lmul];
+
+    if ((sew > cpu->cfg.elen)
+        || vill
+        || vflmul < ((float)sew / cpu->cfg.elen)
+        || (ediv != 0)
+        || (reserved != 0)) {
         /* only set vill bit. */
         env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
         env->vl = 0;
-- 
2.17.1


