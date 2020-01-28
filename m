Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A0C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF65224656
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 00:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABrSWf5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF65224656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwEt6-0002Gk-S2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 19:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iwEsW-0001rz-8v
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iwEsV-0002JO-4h
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:37:16 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iwEsU-0002Ie-Vh
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 19:37:15 -0500
Received: by mail-pg1-x544.google.com with SMTP id k3so6029865pgc.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 16:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=AWWcrjrRUrv6VKPqk5YGn+r2k0P325YrnQEeGWK+JcM=;
 b=ABrSWf5WHgrGFdeTaSNvk/X27px5dVbvyULhxB+Ct1MgsLz9KMb1Qlr7PVRR8KsMN4
 HsSajHxvbx6oUnya5/54pEi2IrRmxl99ksXrP3SYy2xQE6RAdwELyAxMJ9GB1bz9xlUK
 LajRAGnJT5SBwBR5WAvklshEcKoQw+lHpJ2Iws3jhHR7rwmqTSxgqACa4oeTtSyOSckE
 wkNJskOOPUFAp3aG0kG01ruCBSchYy9HN6tZH8dbqkXR+LMyuh8OqiRMt8LddWpQCqIO
 fSEovm00Tb4nSWL7m9lLw5rTtsdU8A4FPu7t+XMSJpS/G0VW0mwebq5OUmLJGAzeFG5Z
 Pk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=AWWcrjrRUrv6VKPqk5YGn+r2k0P325YrnQEeGWK+JcM=;
 b=IxWn7cyoMo0uPwgGnVzPz3RogVejIXqSSd3FyltDmT1g06jj8DUgZQcMnDChNIwA+c
 oeF813/qwPfodYDADFyTWlPOyFayKO/USAMxxXB47M/s68JHBFl0ltmr1/jeo/RjzrdJ
 rvxzHyFdXhwfaClbk8JPilvYMCjJxw/w9gNKy4P4+VduoxLMiY8qddWvrk4E1kVVAifc
 +56kAK6+dUv9G1rpTxqfrV/qiZH4aNd/kpzNkR6kGhkrl3/XfquWx5Nxbe0tLCmu1t2Z
 +WY8uZHpQFoY1iCVSQrsEJqoNGQKMk7i0+fpLJTWtE+DVqw7HJfzNH7OV7/Qdy7gvRtX
 Kmbg==
X-Gm-Message-State: APjAAAW78P8gev6WoeDKUQ7ihwTOESJVWUulc/6QtpDGudGt0Wmwzz7U
 eY+ToFZDhAhf33YtEh6QZf4KRInKYO4=
X-Google-Smtp-Source: APXvYqxbmaxKcMfOMmkhKEzgLrlnWR10mb0aIPMPjHW2MTrevFuq1Y8SvS89nbgjHPxK3ah6swboRw==
X-Received: by 2002:a63:358a:: with SMTP id
 c132mr22867041pga.286.1580171833461; 
 Mon, 27 Jan 2020 16:37:13 -0800 (PST)
Received: from localhost.localdomain ([115.171.62.39])
 by smtp.googlemail.com with ESMTPSA id s13sm341792pjp.1.2020.01.27.16.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 16:37:13 -0800 (PST)
From: Ian Jiang <ianjiang.ict@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] riscv: Add helper to make NaN-boxing for FP register
Date: Tue, 28 Jan 2020 08:37:07 +0800
Message-Id: <20200128003707.17028-1-ianjiang.ict@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Ian Jiang <ianjiang.ict@gmail.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function that makes NaN-boxing when a 32-bit value is assigned
to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
Then it is applied in translating of the FLW instruction.

Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
---
 target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index e23cd639a6..3bfd8881e7 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -23,6 +23,20 @@
         return false;                       \
 } while (0)
 
+/*
+ * RISC-V requires NaN-boxing of narrower width floating
+ * point values.  This applies when a 32-bit value is
+ * assigned to a 64-bit FP register.  Thus this does not
+ * apply when the RVD extension is not present.
+ */
+static void gen_nanbox_fpr(DisasContext *ctx, int regno)
+{
+    if (has_ext(ctx, RVD)) {
+        tcg_gen_ori_i64(cpu_fpr[regno], cpu_fpr[regno],
+                        MAKE_64BIT_MASK(32, 32));
+    }
+}
+
 static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv t0 = tcg_temp_new();
@@ -32,8 +46,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     tcg_gen_addi_tl(t0, t0, a->imm);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
-    /* RISC-V requires NaN-boxing of narrower width floating point values */
-    tcg_gen_ori_i64(cpu_fpr[a->rd], cpu_fpr[a->rd], 0xffffffff00000000ULL);
+    gen_nanbox_fpr(ctx, a->rd);
 
     tcg_temp_free(t0);
     mark_fs_dirty(ctx);
-- 
2.17.1


