Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FBDC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D9A2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KC57Snri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D9A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ftc-0003gG-Qa
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh6-0004Zo-VT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh4-000263-Sq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:19 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fh4-0001zp-LP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:18 -0500
Received: by mail-wr1-x42f.google.com with SMTP id w12so6996642wrt.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eUOODysUqf1q2j4ZfZKabNnAho8TBvSzmUy4kFZOZEM=;
 b=KC57SnribGbr5a+lxGajajstwia0ncnP4dgmyKQ19/JtCMCydrW5PcNf+kx/CxjOPc
 1AdUQdalg9x7LWotut5G7wd6j9/iSxlOoR5NbG08k+779/bN78nYQ694A90KOvx50zlf
 lfjfOT7FtfU2h5GWYQe9xANE/VbJDwkI8vYJFM2MAZNGivLGeRYNO7S1/4bJsHUEXeQW
 hGbvDnJJ6xXaJeaTR/8vcVPqoPoCb2M5h7BRmpstnum1WtUJwHubw1OZFnkTkL7qN95T
 afetggkk7a5kgmk4CrNvjXXasmJJUT4hoJdxhInkZzNETAfeYVZlWhErpWrp3OvoQmcY
 i9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eUOODysUqf1q2j4ZfZKabNnAho8TBvSzmUy4kFZOZEM=;
 b=ffXwWhqOUTI6LG1jGNT0NWW9ZFtiNcID7pfPy6oCI9TEGw9SjKihLATMp90QKy4nyl
 PO5HxYQIj0Im3VCsICex2tFj7MzrAt5TGEM3bXfItHQwykr0Vc4/lgN+JV6ByayiyUcj
 7cJ6DJx2BGzaQ+V5bFZ4qDLASvWuKCg08DUJxPf8PsdxBFg50aP9D9Sd2YTKYbDLatGY
 QlNoByZ9thFvhKTEP7gvSEDuDAooA4aVqsf76qDFeCv83B5SO9/Nlh3Ufdm8hE/3EPiR
 03UJnj0ibTqmgcoIIkBSKkfG8WAtt3p3Wv8OmfFNt2tD196DxEN4igYd9G3VC2/TI8af
 qLIg==
X-Gm-Message-State: APjAAAXyMZ+dppSuGws6vnTlRf7bfCijsivfH532DcmTXzT3hzjfWTXD
 JyHNORXc/JOHxzG37dt/2Dcuz59gc0E=
X-Google-Smtp-Source: APXvYqwZQTr7PpYUEAxRb5nNKVSo9Eo8Jylr198RVi0wb7nlHrcw7TkNXn8xnEskOTR5nqm+KcIWng==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr21852258wru.402.1581604933936; 
 Thu, 13 Feb 2020 06:42:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/46] target/arm: Enforce PAN semantics in get_S1prot
Date: Thu, 13 Feb 2020 14:41:21 +0000
Message-Id: <20200213144145.818-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

From: Richard Henderson <richard.henderson@linaro.org>

If we have a PAN-enforcing mmu_idx, set prot == 0 if user_rw != 0.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 13 +++++++++++++
 target/arm/helper.c    |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f6709a2b08d..4a139644b54 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -893,6 +893,19 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_E10_1_PAN:
+    case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_SE10_1_PAN:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /* Return the FSR value for a debug exception (watchpoint, hardware
  * breakpoint or BKPT insn) targeting the specified exception level.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f6a600aa004..178757d2719 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9569,6 +9569,9 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     if (is_user) {
         prot_rw = user_rw;
     } else {
+        if (user_rw && regime_is_pan(env, mmu_idx)) {
+            return 0;
+        }
         prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
     }
 
-- 
2.20.1


