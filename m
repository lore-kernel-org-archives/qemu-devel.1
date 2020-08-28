Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF61C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7968B207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOuO0aRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7968B207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjDu-0004D6-JL
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCT-00028l-6v
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCK-0005vS-VO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id a65so114446wme.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=k0ud5uE8Pk3z964JEoUoy6xdQiGva9otrDBqT+HZWCM=;
 b=uOuO0aRQgUOghGStr3dx6DhjthsfDJpBqPWg2dQNNKuOhq4vesNuPT+qvvojDq02Ai
 7PxaBOOo49bDWotwWF8597MI0oRJCkhmYFyt5sahVSur4mwF5j0lp6Y4Ef7ciVTadGhd
 bJhpwe0wzt7I6A1HvX4/yrRAB0lGdK2PkcUr1H6KXR12VzIZ+Re9XwrGwxXvZrbDnI9P
 YXTBdpTjeLpx4DT5Lh/Uml2Gz1BpDe530/wUkaDk5FGOptwx9C07/bdYj91l6G62XMY6
 g3wPr4G7Z3s+zew20S3vFL8f7tglYEmEhOqVSMhdVf7UgA5nzn7/j2qVO56PcKfkXCrx
 gZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k0ud5uE8Pk3z964JEoUoy6xdQiGva9otrDBqT+HZWCM=;
 b=Wy8Ci7tZnYcj8TbTmZ1tumd5jjP5T4vvQMTHg3vb48114xkTDiGJTcO1wNP8PQJQgC
 xMvn5sy5p8UNgdJrSl+DpXMK4QgH4+gInTIRy1ipVxz/6JTqVbVW37ytI48uazOjZTuW
 53kXal6+o1QpIYFrLXU3PngtZvXaoEftzv5exjCZe+a9VxUPyO8TIYE4VNaOqFOtdf9Y
 eMl1ztgPrZLgxTXnsYq2h2Bh6Dmil7npihBDvTfd8VnwdvsamRArGEWf4lwuqE8coGhj
 11fct7UXG8CNHSYOaOq3ZyJoEs7AHxX8BNNSKko0YvCE52mgvq0BmPZCxQ+ZCpm9i9nK
 CJAQ==
X-Gm-Message-State: AOAM530S4woPmQSoppaLWeaVp4UC4fHvXkR7sXWfSBoxcIqfSPVE00wb
 vjlrahVkiMtxZXRFCXa8wOy8PA==
X-Google-Smtp-Source: ABdhPJxAz/BTzFCDTps+xumf7/3azfVPt5E48QmCS0Uu9MSCwi7lmQ2uwX8UrISerZHk3C5oimEA8A==
X-Received: by 2002:a1c:9a47:: with SMTP id c68mr20953wme.33.1598639639287;
 Fri, 28 Aug 2020 11:33:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:33:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/45] target/arm: Use correct ID register check for
 aa32_fp16_arith
Date: Fri, 28 Aug 2020 19:33:11 +0100
Message-Id: <20200828183354.27913-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

The aa32_fp16_arith feature check function currently looks at the
AArch64 ID_AA64PFR0 register. This is (as the comment notes) not
correct. The bogus check was put in mostly to allow testing of the
fp16 variants of the VCMLA instructions and it was something of
a mistake that we allowed them to exist in master.

Switch the feature check function to testing VMFR1.FPHP, which is
what it ought to be.

This will remove emulation of the VCMLA and VCADD insns from
AArch32 code running on an AArch64 '-cpu max' using system emulation.
(They were never enabled for aarch32 linux-user and system-emulation.)
Since we weren't advertising their existence via the AArch32 ID
register, well-behaved guests wouldn't have been using them anyway.

Once we have implemented all the AArch32 support for the FP16 extension
we will advertise it in the MVFR1 ID register field, which will reenable
these insns along with all the others.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ac857bdc2c1..a1c7d8ebae5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3519,12 +3519,7 @@ static inline bool isar_feature_aa32_predinv(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
-    /*
-     * This is a placeholder for use by VCMA until the rest of
-     * the ARMv8.2-FP16 extension is implemented for aa32 mode.
-     * At which point we can properly set and check MVFR1.FPHP.
-     */
-    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
+    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) >= 3;
 }
 
 static inline bool isar_feature_aa32_vfp_simd(const ARMISARegisters *id)
-- 
2.20.1


