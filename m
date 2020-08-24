Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A53C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4591C20639
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufbZLRYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4591C20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9CS-0002vp-DF
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95l-0005Qo-46
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95j-0004pJ-EH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id o4so3962061wrn.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=q1SGsLtGvl8tkzfyXqvO5I14atXH9ou0bzu3JEMmqBE=;
 b=ufbZLRYVgZbbTrWSo1TdSiwhLY7l3+1iCJH59ITVCE8nIemKQCvZ1lUSmGJhdosesQ
 Yc/eDIeTlDVEQNOkZBoEWMpOe+uR57VK4Nn6/mNPC26SwfM1kvq+t6Y4tADGzfus0SkF
 Bg6CWujILW4ilYYKGnRS3ZW3F3HzWTXk0DwlgzU3dJ6xOMtMmoMZ52dSclQaohcOhKqo
 4pBwMBPVpWK1F6WDKP2iF322swMTMUYhHmD/mVWJ3mrCe/aZctJkH2SH/PJqNCyqTY4H
 9t4Rr21ZLKdiGTIA7toKs7R8dnosDTS2B6yXbtUHiBh0NONUvgnSqnkOGycBnDB87YcD
 rXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q1SGsLtGvl8tkzfyXqvO5I14atXH9ou0bzu3JEMmqBE=;
 b=dru7mfnk2UVHkszgiZEA+s1tVHg1RVGsrUijej47k+KgVf7TNDiOmMivocyl4gQcZD
 F9eDoNc7KluLLo8Jah8fzOu/XkZui8lYLuAWLPy6dL55B6y8UexkiEA64Gr4Ha1dgwXB
 ZW77zHcdOlQX1XPaYwy/zoYKm3Q2AeOs+NLPzcI6PgKcliLK56SBK68O0rZ+SO3vZKmO
 IyPiHqouhjqXTuS4UDrV0D61et11tAy9vHTCtJraIldURq5QiIJiGvCTOGeEUIyoFebT
 IJ3EeSC0F7TB+VaDf+/AlbG8pJqmPBGF055E6Pa5sCfe3ASnpUk42tTK72WBdmJgJyV7
 6sRA==
X-Gm-Message-State: AOAM532bSCSYKj9DpltmYZpEfF1LQQAP99clSJqU+QGrEUdQgnDMbfxK
 vlf1spB1QiMjKpSUld2u4JHm5rAmqEyOnZ7y
X-Google-Smtp-Source: ABdhPJwgL8KwRAkFdjU8z5WK4jDSy+nY644r7TJnWC8LU2h7KCV+LrNdyDY2G4LI7sUUiR+bQE/VCg==
X-Received: by 2002:adf:aa9e:: with SMTP id h30mr4799936wrc.377.1598262517836; 
 Mon, 24 Aug 2020 02:48:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/27] target/arm: Remove ARCH macro
Date: Mon, 24 Aug 2020 10:48:04 +0100
Message-Id: <20200824094811.15439-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The ARCH() macro was used a lot in the legacy decoder, but
there are now just two uses of it left. Since a macro which
expands out to a goto is liable to be confusing when reading
code, replace the last two uses with a simple open-coded
qeuivalent.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200803111849.13368-8-peter.maydell@linaro.org
---
 target/arm/translate.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e2ae4f79445..b74a4350e39 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -49,8 +49,6 @@
 #define ENABLE_ARCH_7     arm_dc_feature(s, ARM_FEATURE_V7)
 #define ENABLE_ARCH_8     arm_dc_feature(s, ARM_FEATURE_V8)
 
-#define ARCH(x) do { if (!ENABLE_ARCH_##x) goto illegal_op; } while(0)
-
 #include "translate.h"
 
 #if defined(CONFIG_USER_ONLY)
@@ -7909,7 +7907,7 @@ static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
 {
     TCGv_i32 tmp;
 
-    /* For A32, ARCH(5) is checked near the start of the uncond block. */
+    /* For A32, ARM_FEATURE_V5 is checked near the start of the uncond block. */
     if (s->thumb && (a->imm & 2)) {
         return false;
     }
@@ -8275,7 +8273,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
          * choose to UNDEF. In ARMv5 and above the space is used
          * for miscellaneous unconditional instructions.
          */
-        ARCH(5);
+        if (!arm_dc_feature(s, ARM_FEATURE_V5)) {
+            unallocated_encoding(s);
+            return;
+        }
 
         /* Unconditional instructions.  */
         /* TODO: Perhaps merge these into one decodetree output file.  */
@@ -8400,7 +8401,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             goto illegal_op;
         }
     } else if ((insn & 0xf800e800) != 0xf000e800)  {
-        ARCH(6T2);
+        if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+            unallocated_encoding(s);
+            return;
+        }
     }
 
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
-- 
2.20.1


