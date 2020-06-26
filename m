Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278172053B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5r0I66t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278172053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jof8a-0004mj-9n
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5v-000889-Su
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:03 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof5t-0001nq-VF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:03 -0400
Received: by mail-pj1-x1044.google.com with SMTP id cv18so1176787pjb.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k5GffGrEuCAXEI4+wyRvM8P4pieth2N6fosAWiwji6s=;
 b=v5r0I66tygaSQIEjkzMyIqYfk/hiFQwryZCAkQD1eFb6+Msxo5aNG8GxvXOWliD2Em
 5I2q75X4AjLO+4ufvOXacqpC39jSsY0Z9vCE+QZYzvX/fvkYoGHHX1R39N9pBG6c5uSN
 ZvGEhizkhonSEkcXohtCEBz8be2u25Zu+ppjL0fkNZ7yskBeUA0bx6VAXsDky+X5IOsk
 WwVCHnc155vBh6J6zLhAKPTiMFm4HG+05gWLBNOK1KQEfJZOfobJRA1LF18+iBfRDZtY
 gEacmDZqjiUxoKIFucPw/6QNnsXLXrNvknkktOu3gIB8gL/hyBZsznPGMyvzRPgzTZrN
 NIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k5GffGrEuCAXEI4+wyRvM8P4pieth2N6fosAWiwji6s=;
 b=dHFAuj7kwUDbI9vVC+fU2jPCCAWHqfwmJS7url96Lvypxcu8tediio0NX/S2Rl9ZAI
 wb/EyhG1WIuLIVgsvu4WFHJwsrKEYWaQACa79735EekjNJlVMrVabyl8QF/cAA5LGcDz
 x2E4qWhX84SGQQ33nPfE8osSA54IhT+JFtq8n2h0z7ryc2FgkBowHo6PNXgFOA6f12qS
 RXuvLA1y2V8TMb0HT8SJPeSZDnPz/viwp0Ok+IM9aJStm0U6DiBvafv9mSvQBcu2sArk
 3hD14p3LG33Z7tV/04PrOrCJwZc536vFmR2RGzCZWPjo7AJDXSe+ibYIx492u3wIpscy
 +C9g==
X-Gm-Message-State: AOAM532HcatO+Jak5yF9Ny00/tJPDsdU+cHSEL89ZAUqTjspJhOHXhfm
 txBGva/M6Yk0gHnaOJKnz0WZ3ZpZdVc=
X-Google-Smtp-Source: ABdhPJzgzS4RincMZ8NIIXZKj2IMytNVYwK06Q55FKfJp9mBZJdQUD2aD7KC8618tMhZs8uBsNvPtA==
X-Received: by 2002:a17:902:6945:: with SMTP id
 k5mr849606plt.336.1593142320147; 
 Thu, 25 Jun 2020 20:32:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/46] target/arm: Revise decoding for disas_add_sub_imm
Date: Thu, 25 Jun 2020 20:31:08 -0700
Message-Id: <20200626033144.790098-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current Arm ARM has adjusted the official decode of
"Add/subtract (immediate)" so that the shift field is only bit 22,
and bit 23 is part of the op1 field of the parent category
"Data processing - immediate".

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 30683061f9..03aa092598 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3754,22 +3754,22 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
 /*
  * Add/subtract (immediate)
  *
- *  31 30 29 28       24 23 22 21         10 9   5 4   0
- * +--+--+--+-----------+-----+-------------+-----+-----+
- * |sf|op| S| 1 0 0 0 1 |shift|    imm12    |  Rn | Rd  |
- * +--+--+--+-----------+-----+-------------+-----+-----+
+ *  31 30 29 28         23 22 21         10 9   5 4   0
+ * +--+--+--+-------------+--+-------------+-----+-----+
+ * |sf|op| S| 1 0 0 0 1 0 |sh|    imm12    |  Rn | Rd  |
+ * +--+--+--+-------------+--+-------------+-----+-----+
  *
  *    sf: 0 -> 32bit, 1 -> 64bit
  *    op: 0 -> add  , 1 -> sub
  *     S: 1 -> set flags
- * shift: 00 -> LSL imm by 0, 01 -> LSL imm by 12
+ *    sh: 1 -> LSL imm by 12
  */
 static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
 {
     int rd = extract32(insn, 0, 5);
     int rn = extract32(insn, 5, 5);
     uint64_t imm = extract32(insn, 10, 12);
-    int shift = extract32(insn, 22, 2);
+    bool shift = extract32(insn, 22, 1);
     bool setflags = extract32(insn, 29, 1);
     bool sub_op = extract32(insn, 30, 1);
     bool is_64bit = extract32(insn, 31, 1);
@@ -3778,15 +3778,8 @@ static void disas_add_sub_imm(DisasContext *s, uint32_t insn)
     TCGv_i64 tcg_rd = setflags ? cpu_reg(s, rd) : cpu_reg_sp(s, rd);
     TCGv_i64 tcg_result;
 
-    switch (shift) {
-    case 0x0:
-        break;
-    case 0x1:
+    if (shift) {
         imm <<= 12;
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
     }
 
     tcg_result = tcg_temp_new_i64();
@@ -4174,7 +4167,7 @@ static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
     case 0x20: case 0x21: /* PC-rel. addressing */
         disas_pc_rel_adr(s, insn);
         break;
-    case 0x22: case 0x23: /* Add/subtract (immediate) */
+    case 0x22: /* Add/subtract (immediate) */
         disas_add_sub_imm(s, insn);
         break;
     case 0x24: /* Logical (immediate) */
-- 
2.25.1


