Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA076C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8339B2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PEvOkN9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8339B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd9F-0007BK-Mj
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0f-00071S-3a
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0d-0003Ib-Fb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:33 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0d-0003Hm-9Y
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id a6so18494509wrx.12
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4YEwUgXqMm4/ex3vX/ecAj+lmJE3iRPAxqCBL/YGcWE=;
 b=PEvOkN9EB66cctkdi8BaRf1PrzLNOaa4iXeV2OheGE7R78rHNQ0VgvpUvqjJyHSfZw
 kPR29tbOK9ccoF4mOI5RTs9rZeZrkAU2Oh46mMca1oy6fHYcM7Pm5bpadUvlTGVoVZbW
 3OhPdhGlHCLI8YKNEQfBe6/c9Ovp3O87KDgzAwjhA5tNjPkyADmR+Rzmi7BIFW5NmHG5
 nDVunaaQxGPkF1/sFnY2uyO3KrVDBzKNZA0l87KDvTkAKLirov6W/R1jA7DQI97SetYj
 cKKYssM4Dde6LAZaHcegJ5A5G5KRTxwYQdfO4PvtgvtTvInwVWMY6iHb8tmRQPsUXCxm
 auxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4YEwUgXqMm4/ex3vX/ecAj+lmJE3iRPAxqCBL/YGcWE=;
 b=aWTAn31uKR8KadDYhsBMMO5Eg7qOe6L2LYk1WsD5UT4sTR3IZG7R9pPcbNXWhZWf89
 W/38whqsVEWswf4TkHX6VLS+zdJWm+CGSQXhpl/7AtlwlN+alfESaaVb1K1FLv3t8jdg
 SOm/kygaettYHzLCNnny/XCFMeF5jz1IASnH4VWX/z0kDyG6HtKwOVAHhbfqyB/DI3PF
 Qh4ahaWtY/518KYuMnzrLSqun6xCSUMO5nady5iaUDaP3GMqkPc2sjZj/XXBsX2hlWb1
 c2LJNxoVvmMM+ilPzcCiF+NyH4MJwwPxnGH5ChX5mzypbqy0gUA8agZTk9PIyOYzxqrB
 dt7w==
X-Gm-Message-State: APjAAAXVpNCd7VUw2xR2CZ5SVC0errZE6o0mG/PQsmm01IYwJTg7T71t
 EWYXaTIENjzRDJ2h2bNLeEu6KmFGdxfAxw==
X-Google-Smtp-Source: APXvYqyCJm+SMzPv8vyhjLW9IX4Uos0fpAOIkuAigrnfnDar8Ofq3wMca/QX25162vXbvFn6l6AGbg==
X-Received: by 2002:adf:f986:: with SMTP id f6mr12272124wrr.182.1580741250129; 
 Mon, 03 Feb 2020 06:47:30 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/20] target/arm: Enforce PAN semantics in get_S1prot
Date: Mon,  3 Feb 2020 14:47:09 +0000
Message-Id: <20200203144716.32204-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

If we have a PAN-enforcing mmu_idx, set prot == 0 if user_rw != 0.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 13 +++++++++++++
 target/arm/helper.c    |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f6709a2b08..4a139644b5 100644
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
index 638abe6af0..18e4cbb63c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9578,6 +9578,9 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
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


