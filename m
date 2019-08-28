Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A454C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E2E2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 17:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZH72THi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E2E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i31Sz-0000dj-5m
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 13:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i31C7-0007eO-Gg
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i31C4-0000rN-Ct
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:14 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i31C3-0000pb-U1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 12:53:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so510836wrd.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b97onG7/lnQlcwo4RqOnNFf+XJUP3+kZkC9XBhFAYJI=;
 b=ZH72THi9x/W/YObwy4Qpze1epX+Kk+NJPpiVhuPYlxtFOWMKpH0qeG5tB7sU5hoXco
 FG++4ECrZUM+mkwNSaN90j/VeNt85IuG2zKK4MBYAksgxWDlCvy2rkNQayZjOoILI4vA
 4P3ICYE/eLxkJtloKi90VdQBNOBvV4C7tpRl7SJMJPZ1bedH9R1w4Vt6FjgZIRmWJnT2
 UNvaSuwMpZ43McdD5E6QPZjN1t0nUTn+w2FvvUO1OqT5Rx1S+f+5ZuXYM3PRghfbA59B
 rDFrAbNGDsFNOVSmJuEaQxFeQEcubyOCTc3c2RuCYnPyYr4pxUd/KEhvnFP/jBzt2HP6
 V04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b97onG7/lnQlcwo4RqOnNFf+XJUP3+kZkC9XBhFAYJI=;
 b=DaWomsiIHJVJg1H7/v/uOIdAa557nulpnBqicLQ0NGhECZNa+BKDs/jTrZZeEe9VFB
 aJ2Aw6pTJPd7uA4eIip9JsBDrqfOWuXiwN+Hb7p7WkokcY3mRVOjLpdAuI1yftgYn+qa
 +tFL62xRkVJEp+PH/Dym8NqKXsNEVmlm7aAdSW6y59V8Be7rNziBX25hSDOviMkNxa+1
 tLmjPijXiOYY+NUCnzt0PH7WdIOG42U0+XLhGoh8pKNy3cUWGige1VGRQueHwCCeT9NX
 iGPuRJPMNRR1Eb0yCM9mzXtnQqephT1nNuAcg/Z1Nkclj7FG6bTwk+RMcILQVgR1JE/3
 i44g==
X-Gm-Message-State: APjAAAXT38xdXPWuUk8WHG12ntulD//F+LE9w7SYzDhSNOX6FhiCrvgZ
 aG6Tx+aWgEzFM53AIiraKyoa3Q==
X-Google-Smtp-Source: APXvYqwMWUSyFVq8NUQjmRh+7V/911WDkhr42VYXlKevuRSCFHMbyTbAsQtRdtWFEPzfunxHo0Q9MA==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr5822642wrp.113.1567011190801; 
 Wed, 28 Aug 2019 09:53:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 24sm2124289wmf.10.2019.08.28.09.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 09:53:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A42D71FF90;
 Wed, 28 Aug 2019 17:53:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 17:53:01 +0100
Message-Id: <20190828165307.18321-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
References: <20190828165307.18321-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 3/9] target/arm: handle A-profile A32
 semihosting at translate time
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As for the other semihosting calls we can resolve this at translate
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6157e9f52fc..9dc7ec78061 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7657,6 +7657,22 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
     arm_gen_test_cc(cond ^ 1, s->condlabel);
 }
 
+static inline void gen_arm_swi(DisasContext *s, int imm24)
+{
+    if (semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        s->current_el != 0 &&
+#endif
+        (imm24 == 0x123456)) {
+        gen_exception_internal_insn(s, 0, EXCP_SEMIHOST);
+        return;
+    }
+
+    gen_set_pc_im(s, s->base.pc_next);
+    s->svc_imm = imm24;
+    s->base.is_jmp = DISAS_SWI;
+}
+
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
     unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
@@ -9195,9 +9211,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         case 0xf:
             /* swi */
-            gen_set_pc_im(s, s->base.pc_next);
-            s->svc_imm = extract32(insn, 0, 24);
-            s->base.is_jmp = DISAS_SWI;
+            gen_arm_swi(s, extract32(insn, 0, 24));
             break;
         default:
         illegal_op:
-- 
2.20.1


