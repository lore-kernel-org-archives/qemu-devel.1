Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F025AC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBD922CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c0iTk3h8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBD922CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5TPJ-0002Av-To
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 07:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TLh-00076e-3X
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5TLe-0007Fl-Ma
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5TLd-0007DS-V6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:21:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id u16so20841823wrr.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HTKrWQY9yW6MYIS8zgDhcyDleaXQJ6g1pyLY7/mvmEw=;
 b=c0iTk3h8iuUJigERyboXNR8krGbUfi2N/BJbQAAqiN2gVHFbxSzQ1aZiU08kNEoWy8
 4a2eHIIl8eK7TlwnW3bXUEu5P+iN3HoADHWKk4LYy8QXzYVrZG3bzeP1Y8HDPjGMlneT
 1Q/P4UfhWTvUOzoDmmexTdCZ0lIBsOvjN5gjcyTYdCVr0Frb78YCp+3yf+AccB36cAOE
 cKpg/lMJYT1PkYa6qij15ENcHl8kWD61TmlanUFgDgmeT313jq/3OONETde3sA+uTgQ4
 Jh2fm9KgYA/eFY/YcMwzRp32NCXG/qDXiZSKsCp4ZyhKGX2/FnHs6zbnsGcWreqizfXX
 un2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HTKrWQY9yW6MYIS8zgDhcyDleaXQJ6g1pyLY7/mvmEw=;
 b=ITh4QnGPFj0Oy/kWELjGV+nHiHRsGOVVDk30v0o9UTANm6neJ+UecI6OzogaKftTcM
 VX6xu2XbHyWdlOfUIjkTqGLcnzpPnqx0M4FvaX04EL6dvzMGK1XSeDZMp5ILaWNV91Xy
 FRx3yqOMbagT6c133wTW2epUJrCbfNNx0zH267RioFt3MIeyY2X1uABICC1a/x6wTDDs
 CS/zsm4a0yJgaD7nkgKT5FLBEGGoeL8NLdOiqRkJCtm/GBOY/TGPEIO6ZbWcOlPSj8O+
 AnTWSzeZ6PSBwMP7hM8IriMkMrbn00qfqzHn7FEQnNDtt2ITdCNlNVPJ7hVZnU4TCEVA
 WMZg==
X-Gm-Message-State: APjAAAU4c/bRjNJRnL9J9CgH6I80d8FgKitNySa7TBnydmv1Ft2CH82x
 swyUMUkFvnbQiSKCtGzyb17vHegJVyQ=
X-Google-Smtp-Source: APXvYqyhVYVo9Sh1Qb5fAsB49h9hBBGmoeZ5uonuj4JT2NqqsVPRk7HuWZ1RLOwET2t2HBgPQYetwQ==
X-Received: by 2002:a5d:5606:: with SMTP id l6mr20200805wrv.108.1567596072636; 
 Wed, 04 Sep 2019 04:21:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n12sm2582678wmc.24.2019.09.04.04.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 04:21:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4E1AF1FF90;
 Wed,  4 Sep 2019 12:21:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:21:06 +0100
Message-Id: <20190904112108.2341-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904112108.2341-1-alex.bennee@linaro.org>
References: <20190904112108.2341-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 3/5] target/arm: handle A-profile A32
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
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
v2
  - update for change to gen_exception_internal_insn API
---
 target/arm/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 673994ed1a1..03396a1dde3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7683,6 +7683,22 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
     arm_gen_test_cc(cond ^ 1, s->condlabel);
 }
 
+static inline void gen_arm_swi(DisasContext *s, int imm24)
+{
+    if (semihosting_enabled() &&
+#ifndef CONFIG_USER_ONLY
+        s->current_el != 0 &&
+#endif
+        (imm24 == 0x123456)) {
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
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
@@ -9230,9 +9246,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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


