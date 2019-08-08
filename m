Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C9DC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC432173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="li+g5mWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC432173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvp0F-0000Hl-0N
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59793)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozQ-0006yi-0c
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozO-0001FS-V4
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:23 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvozO-0001F0-Pp
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:22 -0400
Received: by mail-pf1-x442.google.com with SMTP id p184so44721210pfp.7
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h5Yd6DdTtsmby24hx/qMc8uUeIQaxSevj10drk1jtIY=;
 b=li+g5mWavems3tksgkMZq3hJ9EOkVKYmGHT+B/KsA1qEQ6FcVD/xNWJpaH/BKO7q/V
 4ze8IUbDi4v+DBlMLcNBT0I6s1P1F0DPMSGVKYujQaj+2spoJ8yApsRUfwTNtdFOisnW
 N+o5T8oXhAN9j2xKJ+2cz1Um3LlNkyWxkRrmeM4Smlx2iC2x/PKoGxUhXRV1Hi6lCS2J
 otjdKO8jyxQZjaYkPNwJqRCAFr6VRWn74uFVSHrE9v+8SeGwMQ3Mcwn1zNSRPTOLFGMR
 i+aVWsTAt9WlGVYsNuoKNVGeXACrhZcKUSvIFunRUR99CLl6UMag9uBcCg4x8lApj3Yf
 F1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=h5Yd6DdTtsmby24hx/qMc8uUeIQaxSevj10drk1jtIY=;
 b=GyWUMlE023zautPAiTLN3d+e22EypFaEiZQrN1QrjtRcHjTo0rE43O49/IEgccO8hb
 lR9TG0+sUcmmYy0ptyktUC6ZNP41C43jz2ROjlRGOlO0k72aBAjFrzLOuUN+Tf3wiI91
 jqGn+JH7jgGpezW5Tj1anRbHUPnu+GeeUpjW4VZltoG35WPBkGSSoNPIjidOtSPvodqi
 nNK1Q3JaoHt4fztk69eqkV3MB6XuBkUvzxGNZVK2zS0FDncVlivP8v5D/XtgZ86Ptvp9
 2p1N0LeOohPNtLGeWrqS0CsHU4Qo3gVUwSJZ1bLzccmTI+4wqX7lXLwI66IVlA9Fsb8i
 RMHQ==
X-Gm-Message-State: APjAAAXIpYwIkaPI345abLcw/iObTf96hJAYVSzP5ddCzZJQV+uMzN5q
 c1b7E184RpUAYqQyNKdaSvOsivD8oa4=
X-Google-Smtp-Source: APXvYqx0Te5xyAo4s/HA/bKsAxaN+WGhZmXvollxyn7Rr9UzhUyJ6DA9XARQKmuCe+qlJS1Zl8+b5g==
X-Received: by 2002:a62:cd45:: with SMTP id o66mr17681624pfg.112.1565295981490; 
 Thu, 08 Aug 2019 13:26:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm2850146pjk.13.2019.08.08.13.26.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 13:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 13:26:11 -0700
Message-Id: <20190808202616.13782-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808202616.13782-1-richard.henderson@linaro.org>
References: <20190808202616.13782-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 2/7] target/arm: Use tcg_gen_deposit_i32 for
 PKHBT, PKHTB
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

Use deposit as the composit operation to merge the
bits from the two inputs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 43e005d191..94170af134 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8769,19 +8769,16 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         shift = (insn >> 7) & 0x1f;
                         if (insn & (1 << 6)) {
                             /* pkhtb */
-                            if (shift == 0)
+                            if (shift == 0) {
                                 shift = 31;
+                            }
                             tcg_gen_sari_i32(tmp2, tmp2, shift);
-                            tcg_gen_andi_i32(tmp, tmp, 0xffff0000);
-                            tcg_gen_ext16u_i32(tmp2, tmp2);
+                            tcg_gen_deposit_i32(tmp, tmp, tmp2, 0, 16);
                         } else {
                             /* pkhbt */
-                            if (shift)
-                                tcg_gen_shli_i32(tmp2, tmp2, shift);
-                            tcg_gen_ext16u_i32(tmp, tmp);
-                            tcg_gen_andi_i32(tmp2, tmp2, 0xffff0000);
+                            tcg_gen_shli_i32(tmp2, tmp2, shift);
+                            tcg_gen_deposit_i32(tmp, tmp2, tmp, 0, 16);
                         }
-                        tcg_gen_or_i32(tmp, tmp, tmp2);
                         tcg_temp_free_i32(tmp2);
                         store_reg(s, rd, tmp);
                     } else if ((insn & 0x00200020) == 0x00200000) {
@@ -9817,19 +9814,16 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             shift = ((insn >> 10) & 0x1c) | ((insn >> 6) & 0x3);
             if (insn & (1 << 5)) {
                 /* pkhtb */
-                if (shift == 0)
+                if (shift == 0) {
                     shift = 31;
+                }
                 tcg_gen_sari_i32(tmp2, tmp2, shift);
-                tcg_gen_andi_i32(tmp, tmp, 0xffff0000);
-                tcg_gen_ext16u_i32(tmp2, tmp2);
+                tcg_gen_deposit_i32(tmp, tmp, tmp2, 0, 16);
             } else {
                 /* pkhbt */
-                if (shift)
-                    tcg_gen_shli_i32(tmp2, tmp2, shift);
-                tcg_gen_ext16u_i32(tmp, tmp);
-                tcg_gen_andi_i32(tmp2, tmp2, 0xffff0000);
+                tcg_gen_shli_i32(tmp2, tmp2, shift);
+                tcg_gen_deposit_i32(tmp, tmp2, tmp, 0, 16);
             }
-            tcg_gen_or_i32(tmp, tmp, tmp2);
             tcg_temp_free_i32(tmp2);
             store_reg(s, rd, tmp);
         } else {
-- 
2.17.1


