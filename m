Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BC8C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96189206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFKv7Bs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96189206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8CN-0000Rg-LX
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83M-0007L0-UU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83L-00069j-0a
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id w2so1547108wmi.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rXGC6L9myFmYS2wUnlHsK7hg9ZJdOSE4jVlndthBJQE=;
 b=FFKv7Bs5Zh6uNvsI5iJa/CFcWOik6hT9Lyc8yzbOa0R40CktuOhAji0OxyiDLAnVUY
 eu17sNbffrPNoavxTUHT/e1SfosNGvRfoJMVZzdEeSKlxE+Btukj7yD0P59yt7QztusL
 HHaayxmEmTmr/JPYE1SoHMehhgCFMbckAQMACeL7DX1VeahNF6/eUIRNVHU2er3xAFHS
 586+DBJPVcKnNTtycFlAtlJ9oxPrPUVd95qLv4qfwJFo4KcMtQyLPHyuQcRlgCBDUAp7
 fAsn8HixarR7Ipi4VEp7Y8BxganTdbbH5/k4Ju7B0eS+/Nk1rj1xIcYfIubmDXXjIREb
 TBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rXGC6L9myFmYS2wUnlHsK7hg9ZJdOSE4jVlndthBJQE=;
 b=qbZhK9L9OdcFF71P4mkf87OoFJ8OedGs7GkZdyNHIrdVa8JivfOZjqyRm4IY8xhkM2
 kA9JZiHbRJuDdBJCsYvXaIEx87XDwBJwM6cgqmJbDDC3HFCYzclQfPQ11VX84xOWsfSh
 S15weQoBNfqZaEo6G4tBMswA2I0WEfhgJadvcs147GozKLH/dFfB0K8e3bpTnq2tZThQ
 XBfjds7/lKrCrB0waQGbC65Wd9G+1hxDtTh3Tlqhl/S0Ijgi+dfZY7HIO2BOOb+EOTb0
 vHwfdRJTMJBtM/UaY2ksMPqLNyHzW6+LP6RtIM5UPVCRbIJ3UePKe0ZqtsF249xvJqnU
 N4VQ==
X-Gm-Message-State: AOAM532h3/P6Gu0jJxSe8935Nz2kISCLmglZIHwpu/Uw93q5hDl9fG+G
 wfsHh/0Pf9qMFRhN3OMvXaQx1S3IPZBXTepk
X-Google-Smtp-Source: ABdhPJxTuLhBTTzb2F8Fh3AD7461pjyGQ6/FYdZ9imB42SIqlFziC0wYkRf8aJYJuSC7uDfkYk7hYQ==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr2325238wmg.33.1598973508003; 
 Tue, 01 Sep 2020 08:18:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/47] target/arm: Use correct ID register check for
 aa32_fp16_arith
Date: Tue,  1 Sep 2020 16:17:38 +0100
Message-Id: <20200901151823.29785-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
Message-id: 20200828183354.27913-3-peter.maydell@linaro.org
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


