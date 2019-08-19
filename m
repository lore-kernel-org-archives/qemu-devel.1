Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A38DC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC8922CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AandmyT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC8922CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq6S-0000h8-1I
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMx-0002wu-6M
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMw-0006vN-0h
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:14 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMv-0006uz-Rl
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:13 -0400
Received: by mail-pf1-x444.google.com with SMTP id c81so1937653pfc.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=M247+waxxQ2hFTPZWsca/mTPO3c20Nu5WDueYuMimjE=;
 b=AandmyT7HPMjVSMaMH89CbOA7ivydNTRJGV69ZnPB33Knv3spsaObO9fJHxCyJ7/l1
 nV/hSRmFRr+WSoSW387d3RH0+qzzajBgZe+/CddOlZDTi6T2UZSynWAyz+abBVI95SiY
 +ODJY9wy0XQzWLpabMjRwckvUoRM+5neoq++vttpBJxaq8yM2kPDED2xhcpTEwnccX+M
 ag3VIICw0fgSpHe4W3RqlBdJqhaO6lZ9SsgJOg3GT/77PDKm8zkQWyzN7Q2iwt22sin8
 3Mt6Q6K9uvytPrWa3dr5ld6jz8VaFzFMBtshg1dW6h7iUnQlO+K6PCZOIVIOQlJd0hWV
 SSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=M247+waxxQ2hFTPZWsca/mTPO3c20Nu5WDueYuMimjE=;
 b=DmeSyVASk0C30MHhAf+pe1V+w36iz6EtTCdIcF0bq44iAbiYxGlcbuLQBJbwoHHrEj
 MmaZlIurR9Qd0pL7H0ki8c5zraUP9qzPGKzv0mewR/8UBOsN9HRB5kVi8DbMlYTl3ZMp
 LBWRkjoMgcGRveZzrn1Y32CYCORdh4pGkV5sA3ZeaI2JBhfwhdKQ1WGLtsI1yQbkKnZq
 eVYbRT1oz7llbJrvO0pIYhZFbweERRPlF6jgZOpDbn0/hXiPxBhO4f9l+h5oPf0N8C40
 eLkjYd2/eV0hfaYh6qzdsx7ejxEM+irr/3MJ4QPlDl/Npx23t4DokTN7P11NQrfJpJpn
 /e8Q==
X-Gm-Message-State: APjAAAW0KUWT1CQiGAg4VqJ4m169ncpSNXzeKySo3fNUOdDevW38s+ZG
 zlGQl/8RtYMsh5HM2TCwkIou2KWkNAY=
X-Google-Smtp-Source: APXvYqxfQ6RFjePIYx/CG6Dk6KvzTcKrlLwXJw/djcV2gqiYh9V0DJBA8H3Zqg5u+7e9lARA/CcdAg==
X-Received: by 2002:a63:3203:: with SMTP id y3mr22153883pgy.191.1566250752576; 
 Mon, 19 Aug 2019 14:39:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:48 -0700
Message-Id: <20190819213755.26175-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 61/68] target/arm: Convert T16,
 Conditional branches, Supervisor call
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 +++-----------------------
 target/arm/t16.decode  | 12 ++++++++++++
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5f876290ba..941266df14 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10599,7 +10599,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rd, shift, cond;
+    uint32_t val, op, rm, rd, shift;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10738,28 +10738,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         }
         break;
 
-    case 13:
-        /* conditional branch or swi */
-        cond = (insn >> 8) & 0xf;
-        if (cond == 0xe)
-            goto undef;
-
-        if (cond == 0xf) {
-            /* swi */
-            gen_set_pc_im(s, s->base.pc_next);
-            s->svc_imm = extract32(insn, 0, 8);
-            s->base.is_jmp = DISAS_SWI;
-            break;
-        }
-        /* generate a conditional jump to next instruction */
-        arm_skip_unless(s, cond);
-
-        /* jump to the offset */
-        val = read_pc(s);
-        offset = ((int32_t)insn << 24) >> 24;
-        val += offset << 1;
-        gen_jmp(s, val);
-        break;
+    case 13: /* conditional branch or swi, in decodetree */
+        goto illegal_op;
 
     case 14:
         if (insn & (1 << 11)) {
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index d731402036..98d60952a1 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -28,11 +28,13 @@
 &rr              !extern rd rm
 &ri              !extern rd imm
 &r               !extern rm
+&i               !extern imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
 &ldst_block      !extern rn i b u w list
 &setend          !extern E
 &cps             !extern mode imod M A I F
+&ci              !extern cond imm
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -231,3 +233,13 @@ STM             1011 010 ......... \
                 &ldst_block i=0 b=1 u=0 w=1 rn=13 list=%push_list
 LDM_t16         1011 110 ......... \
                 &ldst_block i=1 b=0 u=0 w=1 rn=13 list=%pop_list
+
+# Conditional branches, Supervisor call
+
+%imm8_0x2       0:s8 !function=times_2
+
+{
+  UDF           1101 1110 ---- ----
+  SVC           1101 1111 imm:8                 &i
+  B_cond_thumb  1101 cond:4 ........            &ci imm=%imm8_0x2
+}
-- 
2.17.1


