Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E0C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDED92082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgZtczPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDED92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd6a-0001xV-5D
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0Y-0006gP-Cl
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0X-0003A2-7j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:26 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0X-00039A-18
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:25 -0500
Received: by mail-wm1-x343.google.com with SMTP id c84so17460286wme.4
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XUwRqb79kS8kGVWucDBWbJCOx+r2N7qBqeKITwaONR0=;
 b=zgZtczPIN+/hrjYqx8CgswcleCDQ44VBwl4AIca2dMGd0NK+ncAgMkK0qqosLjURLQ
 YJSgvVHNvG7AW5AntyuP7Ci6hmeNUXW26cQpRFI6/e9tdfUYChcKHQBRCNyJWP1Mb2gf
 508JDwbRk+v8FMRiHd2PDUl0p0GRSjWE171v/sebMkAcJcPzpZAcOmcZ/ck9X7D1vKJb
 WgYFo/4Sf/oXKikA8z5bxC2Ror8WjcDnitV8fTgXKvOK2wRpconRww8QhvyrfWLOFbcm
 eDLg1ZHPn4ANnzWX9rup0+4Wj+FiZ4iem+GdVV7ZOiceIO6wNLy8Wa61BWUSMYUZn+xE
 w/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XUwRqb79kS8kGVWucDBWbJCOx+r2N7qBqeKITwaONR0=;
 b=B4x03CHy4/X2iFaVzbDywtK8j6Ct63o5yDfREE7VbMYaL4D7fi8V4I1gJ8sLdttwb8
 j4XXJeDl3wzQnmbNZg5xBLoTqyNBFoyis5uPDMpmiUV/3z0UEoOo2EONpPIgW5wFR43O
 qhghOc85WzOmTmWV5yPnYo80ny23IGNwNZr3MaS1ReV8aLPC1JAIlf9256EeqcmB9HO8
 8AcCVUTiqbuqC9kopytCOtRaCaeKIrztiSGPH8i6XOKN8Dk9opB6tI8NgfiG5AU7HI4d
 OOOI5O2no0Ne3HJJ+e6JT0u15EDalryla9AAMbHz5yDTLmtmNh8HvbXKVjjCoferuplp
 HFKQ==
X-Gm-Message-State: APjAAAUFWde4gpQ6sjs3q3mcKH8ZxY7nU5tLANXcEf0IMZg5ujT6gdt3
 YuoOcFaNygXnSIjL5mpFzQ8Z/7WOvFd+Jg==
X-Google-Smtp-Source: APXvYqxSUU9SPHvZ6E7kPxVtsSvDlWqYQ3kxXgulklYti+ZnHIqGE3BnMZEtBuMWZobk9o+/tzZfsw==
X-Received: by 2002:a05:600c:118a:: with SMTP id
 i10mr30361140wmf.142.1580741243790; 
 Mon, 03 Feb 2020 06:47:23 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/20] target/arm: Replace CPSR_ERET_MASK with
 aarch32_cpsr_valid_mask
Date: Mon,  3 Feb 2020 14:47:02 +0000
Message-Id: <20200203144716.32204-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPSR_ERET_MASK was a useless renaming of CPSR_RESERVED.
The function also takes into account bits that the cpu
does not support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 2 --
 target/arm/op_helper.c | 5 ++++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 08b2f5d73e..694b074298 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1209,8 +1209,6 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_USER (CPSR_NZCV | CPSR_Q | CPSR_GE)
 /* Execution state bits.  MRS read as zero, MSR writes ignored.  */
 #define CPSR_EXEC (CPSR_T | CPSR_IT | CPSR_J | CPSR_IL)
-/* Mask of bits which may be set by exception return copying them from SPSR */
-#define CPSR_ERET_MASK (~CPSR_RESERVED)
 
 /* Bit definitions for M profile XPSR. Most are the same as CPSR. */
 #define XPSR_EXCP 0x1ffU
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 27d16ad9ad..acf1815ea3 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -400,11 +400,14 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 /* Write the CPSR for a 32-bit exception return */
 void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
 {
+    uint32_t mask;
+
     qemu_mutex_lock_iothread();
     arm_call_pre_el_change_hook(env_archcpu(env));
     qemu_mutex_unlock_iothread();
 
-    cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
+    mask = aarch32_cpsr_valid_mask(env->features, &env_archcpu(env)->isar);
+    cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
 
     /* Generated code has already stored the new PC value, but
      * without masking out its low bits, because which bits need
-- 
2.20.1


