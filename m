Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7897FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFD32173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bau2tH0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFD32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34FC-00084U-7M
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H0-00042c-Hn
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gz-0000nU-9T
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Gx-0000lP-8s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id y8so380069plr.12
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IEMQLOaKN2FBc7/rDBTq236Bhoug8XTI5v8qdQW1ulM=;
 b=Bau2tH0sgRmJmMrxQX33xbTNfgwGWPIY6F7XcW8sVRUtQoFNXcWT2fX9jSQe0P9Jad
 6Um4+++ulRRwwNtw5qfb185UIrCyq88uDQNbs86+CKKbiyW7qDaofXy3qdMSS6QtFL9X
 E3kCiNJgL5j64aW/bvvMx0/S8kFrsY2bXYzv+KAv2iesEogPyqL4nLGhZN4oOSVqcC20
 KuaJ9/4AspeOwmk3uvTGmCPsW1zDcotFy86fn7YDcZU532mA+t7f7fBQbF8d0Q9rXdkY
 pnuysbbh86SyfV/K8+YydRoqojIaAITtmIXc9sXf3qKuFOJyFnWovuJuwRLE40PB28I4
 3DZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IEMQLOaKN2FBc7/rDBTq236Bhoug8XTI5v8qdQW1ulM=;
 b=ZqU6u1A2GNLdgUNDUu9xZ7xYLpQrdiWcyKN+o+QtpNFDXYOcBV7TDOynemjdzpAkDk
 i3UIIrh36NcNr8X55jTQx+F0YukZuDGATTzMRNtX8yNT9j+aeEoJdwALBh34Hj8t4dB5
 Mfd3wHyZoK6ma6Zn7XbbBHPvjTw+uK4t8WzvJ8J3JQOSTRmaN14ql8vMW76tEUx6rj45
 AK+HP9s2CNyRDggSbSn61ui4Lkk/yHbxSnPTdufgrPU1OIF5+ENToevqSweQSn4jpUJy
 C0MHLuVtEQR83tdvzvY+wpyhdNbHqPerQJODuw4Jdatoo66n0aN4sIWXQnbbERPaoMWt
 cpmQ==
X-Gm-Message-State: APjAAAXLQQ28xzt/3ybb+iHRQa3rG+OksoQxY2AaUJ1lzZK6lMI5Q9eo
 xyLwXglcZfIa/TdU6M8BBtbpLbXvluk=
X-Google-Smtp-Source: APXvYqzJjGD6k0xpyaFu7+ejtVkgq5i1nsWX3hHJ4LhhL5GST9wxqlg9SS8whsD1Pg5E4YM7CqGrGQ==
X-Received: by 2002:a17:902:bcc2:: with SMTP id
 o2mr5894669pls.127.1567019180860; 
 Wed, 28 Aug 2019 12:06:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:51 -0700
Message-Id: <20190828190456.30315-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v3 64/69] target/arm: Convert T16,
 shift immediate
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++------------------------
 target/arm/t16.decode  |  8 ++++++++
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5fb0e2066b..dd292b3042 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10731,7 +10731,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rd, shift;
+    uint32_t val, rd;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10743,29 +10743,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     /* fall back to legacy decoder */
 
     switch (insn >> 12) {
-    case 0: case 1:
-
-        rd = insn & 7;
-        op = (insn >> 11) & 3;
-        if (op == 3) {
-            /*
-             * 0b0001_1xxx_xxxx_xxxx
-             *  - Add, subtract (three low registers)
-             *  - Add, subtract (two low registers and immediate)
-             * In decodetree.
-             */
-            goto illegal_op;
-        } else {
-            /* shift immediate */
-            rm = (insn >> 3) & 7;
-            shift = (insn >> 6) & 0x1f;
-            tmp = load_reg(s, rm);
-            gen_arm_shift_im(tmp, op, shift, s->condexec_mask == 0);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            store_reg(s, rd, tmp);
-        }
-        break;
+    case 0: case 1: /* add/sub (3reg, 2reg imm), shift imm; in decodetree */
     case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
         goto illegal_op;
     case 4:
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index f128110dee..79a1d66d6c 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -126,6 +126,14 @@ ADD_rri         10101 rd:3 ........ \
 STM             11000 ... ........              @ldstm
 LDM_t16         11001 ... ........              @ldstm
 
+# Shift (immediate)
+
+@shift_i        ..... shim:5 rm:3 rd:3          &s_rrr_shi %s rn=%reg_0
+
+MOV_rxri        000 00 ..... ... ...            @shift_i shty=0  # LSL
+MOV_rxri        000 01 ..... ... ...            @shift_i shty=1  # LSR
+MOV_rxri        000 10 ..... ... ...            @shift_i shty=2  # ASR
+
 # Add/subtract (three low registers)
 
 @addsub_3       ....... rm:3 rn:3 rd:3 \
-- 
2.17.1


