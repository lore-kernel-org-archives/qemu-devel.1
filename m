Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B9C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3692063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OBlGWUug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3692063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7b2f-0004ty-D0
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7ar4-0007Fy-4O
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:58 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k7ar1-0004z2-Ir
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:50:57 -0400
Received: by mail-pf1-x444.google.com with SMTP id k18so7887217pfp.7
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=a/CXePUPDWWqKTfF5Ww5nuV0MbLPoMMlNNjIQw5rqQo=;
 b=OBlGWUug8bNbfFxqWXjSK0kyxgUOfAnrhwv/usm8ZXY9m2by8dRH/G+b+94V0MEGmE
 SbE6ReCTMs++qEiBvuQ/uIGHVKk5JjBwhdLv36B2kbLlcBi2RhCSS3AgQTVQBfFaWvEx
 LGrDpygA2B6qE8/0iW6uFU9cA3zvpoV9/09tXrCFvzLbWfZ8TGBYRkkNCCm7nlsRFaXL
 +65ASNJGa/GUfytMrRG4cPSWQa5Ur56EwEz4rr6RENicrI4ac0id0RCJKfCjOV+qVuRY
 S64nRpOHzuXa1XNiTpbT9xva5UoGRsb57VyUB+37x6rWsoJeVRfeXKy2u+QAB6pObyFz
 1I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=a/CXePUPDWWqKTfF5Ww5nuV0MbLPoMMlNNjIQw5rqQo=;
 b=HiTFeh/C3LOCAWJoBCbgcG94LRXT5ecGR+iqJrcTb0ztFA+GXAS76Gw/fF8VTi6Xpm
 wMe9otV8zzpbAfwtFr6vAiMGEi5PZdb9HKRhycS1HuEzM6VIWf7EiXNekvL8XMXTVXj2
 FKFTbqWisgWjfVypsI95bTYasrj+PEpkrOgK4Lk0Y8enAGOzHToHkyfcdx4MS2pv6G29
 d4phckpe4AeyuiKzLGJ4TaFS6/kZ1TLzEF+nvpwSMdFtZEOBfSGf5Q8t0lwm1E3OeEjK
 i2GaTyXpXdZ4Tp5V0yoMAXUloC1Qr+GBNcfylB/VFq0ETYzBTq6LXMm5Gb5J1lINXCAh
 0aMQ==
X-Gm-Message-State: AOAM530SQnvc/u4niL9YW29efgc/asToZyHfzrG4D0gSMjtegiWGoNjV
 uwcNpApncSMWTVH73v/wODDKftQDzNgwxQ==
X-Google-Smtp-Source: ABdhPJzRtue50tgfbp5qImD/bscluuq6SohIzK7VCKfariHtQd4x80IlO1CKrm4QP7kRBT64fqeQ3w==
X-Received: by 2002:a63:3ec2:: with SMTP id l185mr9605594pga.365.1597654254095; 
 Mon, 17 Aug 2020 01:50:54 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id d9sm16478588pgv.45.2020.08.17.01.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:50:53 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v4 17/70] target/riscv: rvv-1.0: configure instructions
Date: Mon, 17 Aug 2020 16:49:02 +0800
Message-Id: <20200817084955.28793-18-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
References: <20200817084955.28793-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x444.google.com
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
 target/riscv/insn_trans/trans_rvv.inc.c | 12 ++++++++----
 target/riscv/vector_helper.c            | 14 +++++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 4b8ae5470c3..4efe323920b 100644
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
index 7b4b1151b97..430b25d16c2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -31,12 +31,24 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
 {
     int vlmax, vl;
     RISCVCPU *cpu = env_archcpu(env);
+    uint64_t lmul = FIELD_EX64(s2, VTYPE, VLMUL);
     uint16_t sew = 8 << FIELD_EX64(s2, VTYPE, VSEW);
     uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
     bool vill = FIELD_EX64(s2, VTYPE, VILL);
     target_ulong reserved = FIELD_EX64(s2, VTYPE, RESERVED);
 
-    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
+    if (lmul & 4) {
+        /* Fractional LMUL. */
+        if (lmul == 4 ||
+            cpu->cfg.elen >> (8 - lmul) < sew) {
+            vill = true;
+        }
+    }
+
+    if ((sew > cpu->cfg.elen)
+        || vill
+        || (ediv != 0)
+        || (reserved != 0)) {
         /* only set vill bit. */
         env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
         env->vl = 0;
-- 
2.17.1


