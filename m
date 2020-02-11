Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BC5C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE932086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tX+E3GiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE932086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZUv-0007YE-Rm
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTh-0005hB-8y
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTc-00040p-Jb
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:38 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTc-0003x3-C4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id r11so10241790wrq.10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UvzHW7FwqyjZQe8719x2kLtn+42I2f2TvPE23s84PqM=;
 b=tX+E3GiGu6WA7ifzMjUhi/CC98DUnr0kUUJkkHzN7B1Lk7wuu5RLBih59V0XJrapQR
 Qwfa+Bey285yu3e20165GeU1DdSATgvZlbKjtsw0hWuTDS0yyGLRuiGLnGGOBS5c0AKe
 7BrhzNIDmYzINp85mGBu6Z3Ejwg/0GbbyJ6VBe9U3SwkGpM7ii3CTiE2zkMvRMGvYr/K
 HJ2uMf0XgBiWY4Nv3IJS3ekqTARqYg3UdnkUJAPjPLBjlzteHTv5dVWvIiGuom6eEN9q
 4CMQ1ry/h7XGxIjAt31/c25SniLhoTLR0zvqVmtVDWPoSA5xtkcdOMcnrErBCnR/PZ2n
 4JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UvzHW7FwqyjZQe8719x2kLtn+42I2f2TvPE23s84PqM=;
 b=qSjwpRBeHCfYjJlGmcPY6Kx9F0SmFxSJwLVcMRoyc3lxc+Z7hWHzbbUMxsrMLxx8qr
 nCPASsPpRXumZNgYLGhCiXbFUiXIxXlGwzT29Z/O0Ma1lSJlFEQAFRB58NcXQh46m3qK
 dgRs4eejqCnAZKRZ8c8DQbkGTT+zr8Aj1EIEI7U7jGLI9zZ4S4yAOI+RER4s0Yy8mo4Z
 N0MplsEjjNy+0IDwTpa14WxRYg1MR2KfjhuHDWgB3kutwSSOrJnSfrTXuyfQ8RLDjfGL
 XVkUDnYf6R2sGg105nYElqo5XRcLC4+7rU4u+PAdf/D/gS13Nk+0OuT1g5FHGPbzmkuL
 2haA==
X-Gm-Message-State: APjAAAVP9+9Q1NamyP9Ke/pv+ZcsMaPiEhxrVejFprjmBGqQHMnNRpQr
 eppi6vdqZLc4q3v52dJo5ubnQg==
X-Google-Smtp-Source: APXvYqxznI1aVmtFndQ745mgezIUQUXYnbWd5UycQQSNB3Hydl1vXHXZF0VmIHBZfSC3kB5G5glSnw==
X-Received: by 2002:adf:e910:: with SMTP id f16mr9517620wrm.20.1581442652239; 
 Tue, 11 Feb 2020 09:37:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/13] target/arm: Add isar_feature_any_fp16 and document
 naming/usage conventions
Date: Tue, 11 Feb 2020 17:37:15 +0000
Message-Id: <20200211173726.22541-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our current usage of the isar_feature feature tests almost always
uses an _aa32_ test when the code path is known to be AArch32
specific and an _aa64_ test when the code path is known to be
AArch64 specific. There is just one exception: in the vfp_set_fpscr
helper we check aa64_fp16 to determine whether the FZ16 bit in
the FP(S)CR exists, but this code is also used for AArch32.
There are other places in future where we're likely to want
a general "does this feature exist for either AArch32 or
AArch64" check (typically where architecturally the feature exists
for both CPU states if it exists at all, but the CPU might be
AArch32-only or AArch64-only, and so only have one set of ID
registers).

Introduce a new category of isar_feature_* functions:
isar_feature_any_foo() should be tested when what we want to
know is "does this feature exist for either AArch32 or AArch64",
and always returns the logical OR of isar_feature_aa32_foo()
and isar_feature_aa64_foo().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        | 19 ++++++++++++++++++-
 target/arm/vfp_helper.c |  2 +-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ad2f0e172a7..ac4b7950166 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3400,7 +3400,16 @@ extern const uint64_t pred_esz_masks[4];
  * Naming convention for isar_feature functions:
  * Functions which test 32-bit ID registers should have _aa32_ in
  * their name. Functions which test 64-bit ID registers should have
- * _aa64_ in their name.
+ * _aa64_ in their name. These must only be used in code where we
+ * know for certain that the CPU has AArch32 or AArch64 respectively
+ * or where the correct answer for a CPU which doesn't implement that
+ * CPU state is "false" (eg when generating A32 or A64 code, if adding
+ * system registers that are specific to that CPU state, for "should
+ * we let this system register bit be set" tests where the 32-bit
+ * flavour of the register doesn't have the bit, and so on).
+ * Functions which simply ask "does this feature exist at all" have
+ * _any_ in their name, and always return the logical OR of the _aa64_
+ * and the _aa32_ function.
  */
 
 /*
@@ -3702,6 +3711,14 @@ static inline bool isar_feature_aa64_bti(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr1, ID_AA64PFR1, BT) != 0;
 }
 
+/*
+ * Feature tests for "does this exist in either 32-bit or 64-bit?"
+ */
+static inline bool isar_feature_any_fp16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_fp16(id) || isar_feature_aa32_fp16_arith(id);
+}
+
 /*
  * Forward to the above feature tests given an ARMCPU pointer.
  */
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 0ae7d4f34a9..930d6e747f6 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -185,7 +185,7 @@ uint32_t vfp_get_fpscr(CPUARMState *env)
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
     /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
-    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
+    if (!cpu_isar_feature(any_fp16, env_archcpu(env))) {
         val &= ~FPCR_FZ16;
     }
 
-- 
2.20.1


