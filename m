Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D7BC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EE62082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="auU1JfQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EE62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd5L-0006uA-LB
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0a-0006me-3q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0Z-0003De-1M
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:27 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0Y-0003CI-RT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:26 -0500
Received: by mail-wm1-x343.google.com with SMTP id f129so17476863wmf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ovq6zgHOTulKMgq/xQFAYxCo50RIglYC4qMYC5kDj6w=;
 b=auU1JfQwFWFbSUdQSiEFjkA4aOa1gGSpGsPZWvy7UkWbApt8hct8aS0C2/+Ue5mRdn
 gpRNX9L/4dTUTUGP3ry3vGw/j9pC5U6cgamZMaN7nmcZJgnYS0ZStyz8vMqNgW+dQkIm
 dZ0EfrYf8R/EC+7xxFjiIr6x4iW26SEdp/mM5UxaLEu8H9763pYJu3YcxxQ6H57hrIey
 uRSKax1b+ci9FL78j5xjON8ctRT0v2B40+QIXhYpXqNmHS7Wf4tBT8T/pJ7p956nbNKD
 OZW6QnNHg8Mh+o+UCWgOeG9b7sf07qGFdv7UnBQk8OaFjDFSchkxqfNmqqqmHhoQ/EOv
 vw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ovq6zgHOTulKMgq/xQFAYxCo50RIglYC4qMYC5kDj6w=;
 b=aJzmady6C4X00TFEz6MeH9/+tnCJgmz9LTzZb8KlOs6WbMuaxova+uicXwA7OeeARW
 t/vRYX82ezzUxcHItZxOxlpCYgzvQn2NmdpIlz3rXM8nEH9qFs0vfbM2z7yRJBtK9aQj
 FUp5G9tVrV2dBWCFbk5iKBpRQIvwmpNvZL9HBO57ujHqRBAkBnqJKEKukWcdrumZEmXu
 CtDHxl7nEsAmTxTut3ykCv5E1fW9Hhcn5fg4qC6xldWOSQLoklV8NQ7VIFQrFpPYTAK2
 Hp8GXJiqDHCxkWM/0tslAUuj+8zATKmEHlSdelAEBHFu231R4MMdwsE1g/Rdr5XadLvS
 AjsA==
X-Gm-Message-State: APjAAAUvrPUpL6q0MX+8/EjsKh0ko59FY99/q6n0skGdspKsmX3nHB49
 4sVtsrwNi7tIKBTzZM862lM8jdkbzAQexg==
X-Google-Smtp-Source: APXvYqzjqwFe5eY4Kok2wFA0JxeiBF6n9T4/gvVZTnLA3zJ0g8EazZI3ThJT0mtBcSsPoANNNKuXXg==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr30109328wmi.89.1580741245709; 
 Mon, 03 Feb 2020 06:47:25 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/20] target/arm: Remove CPSR_RESERVED
Date: Mon,  3 Feb 2020 14:47:04 +0000
Message-Id: <20200203144716.32204-9-richard.henderson@linaro.org>
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

The only remaining use was in op_helper.c.  Use PSTATE_SS
directly, and move the commentary so that it is more obvious
what is going on.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       | 6 ------
 target/arm/op_helper.c | 9 ++++++++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 694b074298..c6dff1d55b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1186,12 +1186,6 @@ void pmu_init(ARMCPU *cpu);
 #define CPSR_IT_2_7 (0xfc00U)
 #define CPSR_GE (0xfU << 16)
 #define CPSR_IL (1U << 20)
-/* Note that the RESERVED bits include bit 21, which is PSTATE_SS in
- * an AArch64 SPSR but RES0 in AArch32 SPSR and CPSR. In QEMU we use
- * env->uncached_cpsr bit 21 to store PSTATE.SS when executing in AArch32,
- * where it is live state but not accessible to the AArch32 code.
- */
-#define CPSR_RESERVED (0x7U << 21)
 #define CPSR_J (1U << 24)
 #define CPSR_IT_0_1 (3U << 25)
 #define CPSR_Q (1U << 27)
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index acf1815ea3..af3020b78f 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -387,7 +387,14 @@ void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
 
 uint32_t HELPER(cpsr_read)(CPUARMState *env)
 {
-    return cpsr_read(env) & ~(CPSR_EXEC | CPSR_RESERVED);
+    /*
+     * We store the ARMv8 PSTATE.SS bit in env->uncached_cpsr.
+     * This is convenient for populating SPSR_ELx, but must be
+     * hidden from aarch32 mode, where it is not visible.
+     *
+     * TODO: ARMv8.4-DIT -- need to move SS somewhere else.
+     */
+    return cpsr_read(env) & ~(CPSR_EXEC | PSTATE_SS);
 }
 
 void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
-- 
2.20.1


