Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE1F20720
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwfS5gqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE1F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw57Z-0007U1-Nv
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iw56a-0006PH-O1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iw56Z-00006x-KF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:11:08 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iw56Z-00005F-EP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:11:07 -0500
Received: by mail-pl1-x642.google.com with SMTP id q13so3803627pls.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Zx5/HpGJnoKLwxVx5KM/5+NKfVufg4Gprym0XQFn6fk=;
 b=WwfS5gqz2c2zLgnbXiTRoz9BxYNCg+ruYoVZgzZBO7iLRheh3gkFHnj9u4gFlvJ2kG
 yLGmc8HvKKsC46JMJ9uefp3SNMrIpzX47JbbEN+cuXb0noQ+lDQRqo9XugtmlCTc+XCQ
 uNT5vraG0CShUM1Xrb4S1OuV3uwzON/vUrSd7/z0oBt2POetg1TOSyQsN9sz0L+fy5m/
 br0h8NUhu0VxLIdc6Ou1mvFXolq2QWYRyro4FcafqXdBUiWoCtWXkTn2TreenQvoKaBl
 hsPLKCXVynRPZ0r0DNSZ7i5tQeVsSgt4HT9jV2La965OlK6pcm/htphVPBDCxKvTvDJm
 8o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Zx5/HpGJnoKLwxVx5KM/5+NKfVufg4Gprym0XQFn6fk=;
 b=kd/RDE9y/E29YX37VOSOccyLRiomlGRieN5+UMZ7EJJ8FRnOSPESgg1tcaR4efCOj/
 Egl8N8FEJNNlxjq3vKDKD3+crnGrXKCFgWHrDhKmFz1OucvwR3j/ctsgIQ5jwpyn304H
 hWRTM2iX2MuraiKjz9n0tJm0J+nOxEnpKPx1SQR3Q8d5w9u7joDL6+mySzQ7U+HpvYKJ
 xRzF1iodzI2GxSQb+EZTNaGobRT7cwGF8DyGAJLChr7lpf0PQYMdJC9P6StEBWA99Z6H
 Sh73da3lD4lxOmcAMxpG6Fz1p757We9dy1AKr/1Vt9YKIONAsF4r83hZkXihcle++hfD
 y9yQ==
X-Gm-Message-State: APjAAAW7qp2ZMmigXNo/LOProd0JW0BtwUCS9h1lgJszm0cOzgOMQL16
 khOBUAO0uqpk2TL6L+j5t9Qo0goZuwk=
X-Google-Smtp-Source: APXvYqwB4LrchcTw2N5sCpWMbNq9L9yQ1XWFpwj6OnF3kZQC95BeoWqwgBJxkQloQpBM9Gr5mDOEgw==
X-Received: by 2002:a17:902:7d8c:: with SMTP id
 a12mr16866611plm.47.1580134264231; 
 Mon, 27 Jan 2020 06:11:04 -0800 (PST)
Received: from localhost.localdomain ([115.171.62.39])
 by smtp.googlemail.com with ESMTPSA id s13sm16605599pjp.1.2020.01.27.06.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 06:11:03 -0800 (PST)
From: Ian Jiang <ianjiang.ict@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] riscv: Add helper to make NaN-boxing for FP register
Date: Mon, 27 Jan 2020 22:10:51 +0800
Message-Id: <20200127141051.12543-1-ianjiang.ict@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

This also applies for other instructions when the RVD extension is
present, such as FMV.W.W, FADD.S, FSUB.S and so on.

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


