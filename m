Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9965C35254
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA1320726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAdebjwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA1320726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Php-0002AY-OM
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgn-0000Qe-U7
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgm-0004fG-Vl
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:25 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgm-0004eX-Pt
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:24 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so2042148wrh.5
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vAUcjHBqsvT+BhxEKa5AU6R34xRpNG4GK3faR8zhdYE=;
 b=HAdebjwJYDJGDdwlquEmVGbZUyBdDD82fX9Rat/iA1lhOHwcKKoClsWtZooy9wBkdQ
 GdO0MzHIS0mTVMHOz3krZnnVkwGR7iRM/D41sO2F1QHZsL0tYTv5jrFH9D1xp6xknrW6
 QSzYl51/y4VBGh8Uoy70zQV7nCFng/C/WfETZBOolq6yCBvuxBmBDe74BjDscDi211Dk
 PqOgnnndjd3WIWUT61BGzBseVntj254e0w+tDY7OPoeyEl6eQzJgM3ZVI92nYrG6P9PR
 DN0eZZiS9h0ipNSt0w7iWirep2nuZo79XP5SQ0b9aIYxWLfO0+UdUwjngIzpcgH4xnHr
 1HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vAUcjHBqsvT+BhxEKa5AU6R34xRpNG4GK3faR8zhdYE=;
 b=T/nDN9PDLmnzX9uvoq9mzTQWwHs0wgJz0AbcnO5XgDz5Kn5INHbysNEl9qbT0miZTk
 hVVq+O91NSV1df7sxilElSOW7Ko77YOw9NHEh7VJguOHeQ3gD7+MlX+5xmW6gjuCv/3H
 KYMH+fy/8ZfklgrgZ1iZBTvQISKfHahvBKJkVQDmzoh9hvpGv8WZZeNvDdEOdiz4oIW3
 NcPoj6axv8Laasg6OC/7bVe5hzxc2Ms6DE0LN90DogHWt80KZ5E38ZUNGDmeJKwGQdqu
 K2KtLxlJQno7Wsh4AuuUrAow0Yr0aH+EAigpq42FDvLyK8WFTgJHIDZZ7pbGBiwkZg9l
 Na7g==
X-Gm-Message-State: APjAAAXw/hsBXtH4jO3DzCIAVmEIVoSSz2/4Q4hrmWFMEvPoJcLVPOJt
 EFy2tJGFEomLOnj0x0yKtEKLme//jCWeMA==
X-Google-Smtp-Source: APXvYqyx5wOc+ZzK0HDup2wtaNcy/KcF8v/s8uW9rNd7FfSRMlLEiKFN+k6bda355CqtGnQZwRaqnw==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr5165273wrs.270.1581166703687; 
 Sat, 08 Feb 2020 04:58:23 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/20] target/arm: Mask CPSR_J when Jazelle is not enabled
Date: Sat,  8 Feb 2020 12:58:02 +0000
Message-Id: <20200208125816.14954-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

The J bit signals Jazelle mode, and so of course is RES0
when the feature is not enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v4: Split out from aarch32_cpsr_valid_mask creation in previous patch.
---
 target/arm/internals.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d4896fcdc..0569c96fd9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1064,7 +1064,7 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
 static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
                                                const ARMISARegisters *id)
 {
-    uint32_t valid = CPSR_M | CPSR_AIF | CPSR_IL | CPSR_NZCV | CPSR_J;
+    uint32_t valid = CPSR_M | CPSR_AIF | CPSR_IL | CPSR_NZCV;
 
     if ((features >> ARM_FEATURE_V4T) & 1) {
         valid |= CPSR_T;
@@ -1078,6 +1078,9 @@ static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
     if ((features >> ARM_FEATURE_THUMB2) & 1) {
         valid |= CPSR_IT;
     }
+    if (isar_feature_jazelle(id)) {
+        valid |= CPSR_J;
+    }
 
     return valid;
 }
-- 
2.20.1


