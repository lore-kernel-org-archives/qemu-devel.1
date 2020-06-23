Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E444DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F9A20C09
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KUPvLJbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F9A20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnoqU-0000bj-TM
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojN-0003Y1-UW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:17 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojL-0005az-PJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:17 -0400
Received: by mail-pg1-x544.google.com with SMTP id d4so23351pgk.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vTCb/+JBTsRkBioBgq12HWwp1QoPq+XXUl9Yc9AuV4g=;
 b=KUPvLJbNSc801mbX205g3IWjHsgwWICYKYiYfWPXI00YKXV1T2Ih9/IF5DSYD1ItjQ
 XhBloOL5rCGw6ztEsUgtbPp5RFlNm5PKAniO1df5jTBGszQQG7gxslCu0mTJYMqnXhvS
 dN2RKqfTbjTUXZw3VbzXlkDin7Y5wvOokiQ4vblZpLVeXBC5vG93JtnPEWPKxbIDKunb
 eVaST1AYtDDEe2C+zKgB0HVTb8plZBYWcR7qS/9wpXCWkivvvIrChvRq1gIjoGytf/NL
 rGzAiiona7IhZo1ODMbeinYfBJmGhVWz67YXRVIYwtXga06CLGkFO+gGuvhSu7662wGc
 nwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vTCb/+JBTsRkBioBgq12HWwp1QoPq+XXUl9Yc9AuV4g=;
 b=kt1sgkVXgRGmxZlFoyXYkF2oT12meoVM+PDINHGO7ForPfClMQ/Qkk89UUh554MIsF
 UouDghNuQBEvEJVCAicahjU3B9AoWExMu/B0QX0uawNeLxM3KuZkSvUd2P765uAeI4Aj
 5NwVRwl79EKgAkTFxesTeYC5im142hEb8JyeX5WP7wO48jGYcbmF6nwq9zPZwzrUv2OX
 hU+iEmGC9wg+ZRSlqR74op2+yt+BISCGHFLQQLc5H366Bs5IXEQtxW7d6Z/EDMeSfBGz
 6a83zMYCMPb1IohNGcWpu15oa6/FABeA2nqrm4C2Dg8U32w/h7o5O9Xhb1ASMyic85Ax
 gYAg==
X-Gm-Message-State: AOAM5323Lb5/SPWF92y4BJiS+Qou6Xa+g8jUDmNjg/OzlLCLso8mqkox
 3z6K/xgxTcUIKagZHG4jpKXuTU36VQQ=
X-Google-Smtp-Source: ABdhPJxacp0tppHKmQVl3BlPOTrKCXxrmOb+E158iM+6pWeoEyQ/Ha5HNS0GVqH6+PvJB5tSEkA8tw==
X-Received: by 2002:a63:b915:: with SMTP id z21mr19382355pge.145.1592941034148; 
 Tue, 23 Jun 2020 12:37:14 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/45] target/arm: Revise decoding for disas_add_sub_imm
Date: Tue, 23 Jun 2020 12:36:23 -0700
Message-Id: <20200623193658.623279-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 14d51c0dd1..59f44fc412 100644
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


