Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D6C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209F921556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 19:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxL+IhZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209F921556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6g3F-0007DR-8O
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 14:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6g2G-0006I2-QU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6g2F-0007UM-Aw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:38:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6g2F-0007RX-2S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:38:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id a9so440761wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 11:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f7lizJW39lrCrOSU4Pue7Wc6hbrhiEMu+Lp7n3SwT3I=;
 b=UxL+IhZtH8qghvDvr4gPV8rzVvFEyD534RRZ9v6vfXVF22iC0BtPNshDHbXlaiLlzv
 Fvdx8Z40WnMN3YmQcyspH+itMYbEFS9y1/p8c4yGxYJLL0nIM3LdyKZEPs1haRKIi5FS
 gm+69csvJ05Tj1KHkcwCRr6VRJ6FzupOj/IAlozsXThLD6gHPLj8uMY1nULaF1xmAWJ/
 F6d+AJRFTFUEbmana168bOnCADZwK7ahiBNAASsxi8NKkSgAGzmix1NwYqpR08KJe0/M
 /0Xlmsf0E5Xi2xlcxfnXm9jkCQQaj+9YABB9nxzloSxKZCktdxgEkhTbXimnBwtaJKkw
 XfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=f7lizJW39lrCrOSU4Pue7Wc6hbrhiEMu+Lp7n3SwT3I=;
 b=JvQs9dkZWsDA5MZE1AKg4OVUtlKupWaw7AazA7cZL0FShO40ACJ+vppnSJOnSuYumu
 jBh+x/ypANOfYHycMRIVAA71eoyE/PxbfmjXwGKAc78wHtNLUvGI0IhgL7zOUbG/UFcc
 uWa7s39uxufFyiOBnZTTOutNDiTKHDA1xD7IZBpkzsPwLB8eyLy1O79ct0c3Pnp4hxvP
 Oh67bgIHd7CrCKC1gxrOJnfOhBpyfV93x1ydlsuuJ6WHZ3XUv/1Ig+u9FoNOh8w67lkF
 6Kp9374/MCbC8a6xqsodeQV061QzyZ53kcd0g6ikIbxWu9yC0NOEDq1aE96SLWp2U0x2
 Jkwg==
X-Gm-Message-State: APjAAAU+V9DgsQ47f2HBk7IaN+iUxAm1907Huc1Iu5ABf6KMKt0sADca
 2Sd5yIWzbQYGJ9jnHsC8svZ6Ww==
X-Google-Smtp-Source: APXvYqzdu3vj+sgIgBJaxRIaBlxsvI/+PBhMtH3SSCaqqH0N86xNbQ8ZyBgS3u2uvD+jWawmG1eBJQ==
X-Received: by 2002:a1c:1b11:: with SMTP id b17mr726822wmb.93.1582659505735;
 Tue, 25 Feb 2020 11:38:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g9sm3578527wme.41.2020.02.25.11.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 11:38:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Implement (trivially) ARMv8.2-TTCNP
Date: Tue, 25 Feb 2020 19:38:22 +0000
Message-Id: <20200225193822.18874-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ARMv8.2-TTCNP extension allows an implementation to optimize by
sharing TLB entries between multiple cores, provided that software
declares that it's ready to deal with this by setting a CnP bit in
the TTBRn_ELx.  It is mandatory from ARMv8.2 onward.

For QEMU's TLB implementation, sharing TLB entries between different
cores would not really benefit us and would be a lot of work to
implement.  So we implement this extension in the "trivial" manner:
we allow the guest to set and read back the CnP bit, but don't change
our behaviour (this is an architecturally valid implementation
choice).

The only code path which looks at the TTBRn_ELx values for the
long-descriptor format where the CnP bit is defined is already doing
enough masking to not get confused when the CnP bit at the bottom of
the register is set, so we can simply add a comment noting why we're
relying on that mask.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c    | 1 +
 target/arm/cpu64.c  | 2 ++
 target/arm/helper.c | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2eadf4dcb8b..64dc9509927 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2720,6 +2720,7 @@ static void arm_max_initfn(Object *obj)
             t = cpu->isar.id_mmfr4;
             t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
             t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
+            t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
             cpu->isar.id_mmfr4 = t;
         }
 #endif
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0929401a4dd..e4d793a2415 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -679,6 +679,7 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64mmfr2;
         t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1); /* TTCNP */
         cpu->isar.id_aa64mmfr2 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
@@ -705,6 +706,7 @@ static void aarch64_max_initfn(Object *obj)
 
         u = cpu->isar.id_mmfr4;
         u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
+        t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
         cpu->isar.id_mmfr4 = u;
 
         u = cpu->isar.id_aa64dfr0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 79db169e046..911baf7bcb7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10572,6 +10572,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
 
     /* Now we can extract the actual base address from the TTBR */
     descaddr = extract64(ttbr, 0, 48);
+    /*
+     * We rely on this masking to clear the RES0 bits at the bottom of the TTBR
+     * and also to mask out CnP (bit 0) which could validly be non-zero.
+     */
     descaddr &= ~indexmask;
 
     /* The address field in the descriptor goes up to bit 39 for ARMv7
-- 
2.20.1


