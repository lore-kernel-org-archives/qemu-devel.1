Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C0BC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2462173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4x3IifJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2462173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvp0H-0000QA-AR
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59852)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozS-00075E-At
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozR-0001Iv-BP
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:26 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvozR-0001IE-6H
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:25 -0400
Received: by mail-pf1-x443.google.com with SMTP id b13so44724458pfo.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nqzQU642U0COih1CmgjWbkQy5lirJcAcLB93HWWBZtw=;
 b=f4x3IifJ5NF4+rRGiMDD/6mffiSedpgiTboNBBfCNIUABOKv4uEyTedewTSTZGif2G
 OK3b6LiDTatS2yds7cbMJsul3xUL73d5M/A221BuTd/xCE+bP/c4q3rYpsCE9/s//biT
 y3byX0n20EyREj7D6Qp9/o0kFA1E8M/qHp1mvSQzn+ITbz8Bxx8rSqiQV2T/7oRqUtFg
 evltcs0K+vibzQ3Af5AO9WH23zdK1+TCgXzmBrvQFmQt/bMha1dgxJgCJD3//k0qgjN0
 /9KvgZIFtlhXRpQfSOzIU+ZqpLVBqC/X1Hs/ZqgVnoJMnWF2LVTceAtBb5jCLyZpX976
 InIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nqzQU642U0COih1CmgjWbkQy5lirJcAcLB93HWWBZtw=;
 b=ZCjm+lht42sn1y3f5hvrBU1wkCvYvjbvCPFTA8xwnPUC9TXXzlUH6d8t8Ef/cl6m0m
 hqfOw1XipMbSvnIfqx6nRoOJDMozf8MURAWyvPbQn5KS+iMNy37f8WfLau7VjFD7LEUG
 sdeRttFRS8JSnYw7xYJRd/isUOFxDj376h+HsbFs19AtBVXC8u17O9KPPpkawuSUW1Ck
 gkcpNz/1X5+w9rlnUgDxqvuzB/JH41F8g5us3G/VC9ei6qqX5b/64RLMLIIl/xmCvlvd
 S2uRx8Q3oWC1VYcLhXJF8jyR4V/h4MlnzjCNokyTOZ8eSF8Ergw9H3csgpig2Cd2rVZz
 oOeQ==
X-Gm-Message-State: APjAAAW7z9ZT3NSoNmRlJQR1dWJun6QK7X4cXAKnsEcccD1dUPHF9aw3
 2C0FZ5TK8TyUCRJBdPIIYcTdY/jD7eY=
X-Google-Smtp-Source: APXvYqxBoha2CfxdKMixIZb3G2CsT6uFGiBuX1rzJKdj/9McrVOkHD9PY8588KeXAtZLb8f1sRXRlg==
X-Received: by 2002:a17:90a:3aed:: with SMTP id
 b100mr5814407pjc.63.1565295983855; 
 Thu, 08 Aug 2019 13:26:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm2850146pjk.13.2019.08.08.13.26.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 13:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 13:26:13 -0700
Message-Id: <20190808202616.13782-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808202616.13782-1-richard.henderson@linaro.org>
References: <20190808202616.13782-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 4/7] target/arm: Use ror32 instead of
 open-coding the operation
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

The helper function is more documentary, and also already
handles the case of rotate by zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3ddc404b3b..b40f163bab 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7979,8 +7979,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 /* CPSR = immediate */
                 val = insn & 0xff;
                 shift = ((insn >> 8) & 0xf) * 2;
-                if (shift)
-                    val = (val >> shift) | (val << (32 - shift));
+                val = ror32(val, shift);
                 i = ((insn & (1 << 22)) != 0);
                 if (gen_set_psr_im(s, msr_mask(s, (insn >> 16) & 0xf, i),
                                    i, val)) {
@@ -8243,9 +8242,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* immediate operand */
             val = insn & 0xff;
             shift = ((insn >> 8) & 0xf) * 2;
-            if (shift) {
-                val = (val >> shift) | (val << (32 - shift));
-            }
+            val = ror32(val, shift);
             tmp2 = tcg_temp_new_i32();
             tcg_gen_movi_i32(tmp2, val);
             if (logic_cc && shift) {
-- 
2.17.1


