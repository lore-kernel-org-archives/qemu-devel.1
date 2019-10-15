Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4889BC4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 01:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE9A20873
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 01:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMVRpRIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE9A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKBfU-000648-8g
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 21:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKBef-0005aj-RO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKBee-0007Rf-FA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:29:41 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKBee-0007RB-9J
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 21:29:40 -0400
Received: by mail-pl1-x643.google.com with SMTP id u12so8746836pls.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id;
 bh=uV4GgIG9lLtnR/n38vsAmt8bgLODKyr1VTQJdCQjsA8=;
 b=mMVRpRIBctieScsqgen4eLEQPAUFknpOrR83OFFFpalpJ8NS/1b3KCVYAcxcUSA9VH
 zN/r+V8R8AeGWptrzwLMoiTcXgQPUKd+vDnHD8a5GHfuM3SvtXePOyVVqfzwrgKcPe8i
 QOWlsU4cnX7v2Pl8SbYU2lLKylPMIzOAAAf6IQQ4M/SqIm4uAfgebzb2QDHJGlochMjG
 C+3fj8rn41U0uzSMQxca57Io7XDq7KEA0gTYPki/mi3LCFx7aKdA9CJDS7gEhor67SVv
 YbMLce34bZZlJevT8i0XQ/K56ySO2iToZqW/UinBGG59yNwaoDYBCtjBSMWK4LX0kVbO
 Q0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=uV4GgIG9lLtnR/n38vsAmt8bgLODKyr1VTQJdCQjsA8=;
 b=LTrOAn1qH0RZ3x2dr0esVt0YgZ6dqWPaBhs318Aai4TXRWPp19ToTBr4MGkaygWv1/
 Xz44E35WtkWdeQt54OFlAeXON03ZNhfw5NGEpUuAWF+mk84aZLicV+5J/cSNSflqEJzK
 32l7PIOqMlw74n9KVJxqZH4mAvU3SIp0cFXEQ8h9AEM0p9W7yORFaRSBRoMe/f3gaHaw
 SAdSqPhj2HKz4WQk0+DrDSv8xxcBnoo5UvsBrbixArwTIK/Hr+HzIYjZseyHWvLQencO
 j32jS2fyjHC+eFGQ/F5jmT5rD/q1bkvuEFEniOmtL3KEUO8XqH3mZ0Jc/+pvATIiipC2
 sTnw==
X-Gm-Message-State: APjAAAXUbn0GV5G2HtuJ7p/Ere0v7qxUkhIoXA/ZvBMmJdNhRqvdySNB
 PpRRBPM44EObOuI2+wqK80SgMOlTsWY=
X-Google-Smtp-Source: APXvYqzOwy9qMT3Jq9yLg+SUyzH4UKzKjluRTROE5BJ/qqSSz+UpgjRYshawxWKkOkN687HaJ8ybVQ==
X-Received: by 2002:a17:902:b210:: with SMTP id
 t16mr31692093plr.250.1571102978364; 
 Mon, 14 Oct 2019 18:29:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x5sm5983703pfi.32.2019.10.14.18.29.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 18:29:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg/arm: Expand epilogue inline
Date: Mon, 14 Oct 2019 18:29:36 -0700
Message-Id: <20191015012936.16275-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

It is, after all, just two instructions.

Profiling on a cortex-a15, using -d nochain to increase the number
of exit_tb that are executed, shows a minor improvement of 0.5%.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 94d80d79d1..2a9ebfe25a 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1745,24 +1745,18 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 #endif
 }
 
-static tcg_insn_unit *tb_ret_addr;
+static void tcg_out_epilogue(TCGContext *s);
 
-static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
-                const TCGArg *args, const int *const_args)
+static void tcg_out_op(TCGContext *s, TCGOpcode opc,
+                       const TCGArg *args, const int *const_args)
 {
     TCGArg a0, a1, a2, a3, a4, a5;
     int c;
 
     switch (opc) {
     case INDEX_op_exit_tb:
-        /* Reuse the zeroing that exists for goto_ptr.  */
-        a0 = args[0];
-        if (a0 == 0) {
-            tcg_out_goto(s, COND_AL, s->code_gen_epilogue);
-        } else {
-            tcg_out_movi32(s, COND_AL, TCG_REG_R0, args[0]);
-            tcg_out_goto(s, COND_AL, tb_ret_addr);
-        }
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, args[0]);
+        tcg_out_epilogue(s);
         break;
     case INDEX_op_goto_tb:
         {
@@ -2284,19 +2278,17 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
       + TCG_TARGET_STACK_ALIGN - 1) \
      & -TCG_TARGET_STACK_ALIGN)
 
+#define STACK_ADDEND  (FRAME_SIZE - PUSH_SIZE)
+
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
-    int stack_addend;
-
     /* Calling convention requires us to save r4-r11 and lr.  */
     /* stmdb sp!, { r4 - r11, lr } */
     tcg_out32(s, (COND_AL << 28) | 0x092d4ff0);
 
     /* Reserve callee argument and tcg temp space.  */
-    stack_addend = FRAME_SIZE - PUSH_SIZE;
-
     tcg_out_dat_rI(s, COND_AL, ARITH_SUB, TCG_REG_CALL_STACK,
-                   TCG_REG_CALL_STACK, stack_addend, 1);
+                   TCG_REG_CALL_STACK, STACK_ADDEND, 1);
     tcg_set_frame(s, TCG_REG_CALL_STACK, TCG_STATIC_CALL_ARGS_SIZE,
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 
@@ -2310,11 +2302,13 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      */
     s->code_gen_epilogue = s->code_ptr;
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
+    tcg_out_epilogue(s);
+}
 
-    /* TB epilogue */
-    tb_ret_addr = s->code_ptr;
+static void tcg_out_epilogue(TCGContext *s)
+{
     tcg_out_dat_rI(s, COND_AL, ARITH_ADD, TCG_REG_CALL_STACK,
-                   TCG_REG_CALL_STACK, stack_addend, 1);
+                   TCG_REG_CALL_STACK, STACK_ADDEND, 1);
 
     /* ldmia sp!, { r4 - r11, pc } */
     tcg_out32(s, (COND_AL << 28) | 0x08bd8ff0);
-- 
2.17.1


