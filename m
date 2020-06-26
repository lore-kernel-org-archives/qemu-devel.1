Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD244C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DFD207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKgrCgYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DFD207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqID-0002c4-P4
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq47-0002PP-2C
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq45-0006PR-1O
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id z13so9868327wrw.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z0lRJqULuNMXERsdHXo4sn61X1OFLxEJyzOhHFNclDo=;
 b=cKgrCgYo8puFlpGPDhYJbcC85AeAJy4TTSutuFXDjq9WBTHQ3aeb1OngvIsHpmDQOC
 KvUFZ2ljO+N5AxEcO7Teg/00jTZLJC0NkZA3TWh6hTNf2CjpkHY2/tz4UtsD5gOVuL4k
 T+7J4ph5GecIDTkvPqT/lE7D9qMQC9Cnj0UStnO5rKMCu+dRnQOSLd7WyOxBYn7qk7PS
 vMwslapTD4qwGKCQQFGG+yvvCupYiu2V21PnNhZrtUBxtQGtNq83T9XTE/YyHKO9zeN1
 487GP5UWexD3k9QwSHQj58ieSq/CvtoJvE+zNzwrj16k/tcy8CeIhQQNEyFwooLwg/DO
 7LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z0lRJqULuNMXERsdHXo4sn61X1OFLxEJyzOhHFNclDo=;
 b=ksIoGM5F5r5btGzWOzXoLWPS6+Pozvyo2HEuOuSumZwVEF8Biz9SDktpQ2TcP1OIx6
 BEFYbFOyjaMSOFQ124gT116cT7pgqeaECJZNZqq7So61CDi9x6OX5SKdkji2ZifNdDeg
 pWwcYuo6hi0j3+PG5oSK4J7nIdB8n9zp+OeMYLgD2lz7B9kS5ktj6E0u3J+Il3PuOqjw
 XuhgHBi8Bi5XPrtknWRRubbl5TwgoDIOl6KG8sn673svsgMlFcHmPaLJ+u4QRHozdL2q
 pqez2hXY+pSkv059x7P7U8nRw1oPe0HanTakEYLgZvqF7qvX2A86ZyXjxQvtb6PV7gi2
 XhuQ==
X-Gm-Message-State: AOAM531pxHp1Lvry7wXQh4OG0lqXVVRJSCGUjVT//BObccUY+26Bdn4x
 gAKv4w8xvE8AWSeOMwbCu6GklN16SEU0XA==
X-Google-Smtp-Source: ABdhPJzUFl/K06e1wWq3nqO7kqav9dMfIXSyNWGg1nksp30lASgmWbp0eMhHeHuKTwOfSZNvx0HSjQ==
X-Received: by 2002:adf:a396:: with SMTP id l22mr4308707wrb.24.1593184491181; 
 Fri, 26 Jun 2020 08:14:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/57] target/arm: Revise decoding for disas_add_sub_imm
Date: Fri, 26 Jun 2020 16:13:49 +0100
Message-Id: <20200626151424.30117-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The current Arm ARM has adjusted the official decode of
"Add/subtract (immediate)" so that the shift field is only bit 22,
and bit 23 is part of the op1 field of the parent category
"Data processing - immediate".

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-11-richard.henderson@linaro.org
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 30683061f94..03aa0925983 100644
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
2.20.1


