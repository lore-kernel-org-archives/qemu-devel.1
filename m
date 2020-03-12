Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22801C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B22206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRnC/RMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B22206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQyR-0001Zn-2u
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxH-00085R-4H
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxG-0004ze-3g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxF-0004zP-Ta
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so8380523wrl.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8CaBKL2SveIQE6UGOFKfKIzbSJiAUmm7injqvPnlpXo=;
 b=kRnC/RMUgwnUH53EFwwYPeDQL8qOVlrvnFoITNWd3NGaRzMxDKn0+v5Qx/hiMi3NnZ
 m4hdffK6Bq+HJhcCho8EdC2uXvK2DN4mmBIivJpKVOWllSHv/Xs0vnpz5XlzZ+qZk9BO
 Y6BJ/jSeDHmHZzghp/oQCgNzt1T97mTt4ivzfqWD4UoEhmb/J4g564xKL/ISOkTlF+5M
 ViWllKYcDrpJ3WUoBYYwpTnfqeuNE/4qTjAe4FcTcCQtxc2YxmRQLMUFy24LK8zmQ4Te
 Rd57HYawIlqTiYNvQ9I2uAXyzzSGuNPP3uXBmEM9mUW5JIO/36+tY7FtpIengdVCAF6E
 LoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8CaBKL2SveIQE6UGOFKfKIzbSJiAUmm7injqvPnlpXo=;
 b=ukfBvZR6cWxMFMUct0vSPy0JRP1GuuVeSBE9LA1nlqCMZZUiVtFvAdIOmb4J+r4tpP
 JCVzCRAZztKquKVHlyR1rKaRwN0fL2gD8C+ZhJ6OB7VBHBAAAjqg67DPVVQIO7F+EjtB
 e1wHEhRjWsYJocgf4SI9QrufrL+BjKh2GsYwfYV6Ls9XZbp/ao1g4PCTh3gGTec7J1m2
 B5ZZH8T55KGztbG7ZkVIbNl5hqz/KMxmROiv8L3QZ39g2SjoBnGHG4XWXo7mURCtY5iK
 kHcWTewKMf23fKpv1QzYLtJO8Ser/6V84558FuXZVnQi5p7N+27srArMV7fD13G3yEnL
 kElA==
X-Gm-Message-State: ANhLgQ25SDc0PHkS3Nz1hqk9bsPkZPBEZLm+Ri2duDl5LMCBnE07Zbnb
 Xc5X42GjIlQN0P4hB7Wf253Jts1bu0cqsg==
X-Google-Smtp-Source: ADFU+vtG7P1G8yl+RWCZXzrqdqklPzFhfrWkJ1F20lai1sUlUXvvH1sE4Xwio/rHEhp2C18RLUBPAg==
X-Received: by 2002:adf:de84:: with SMTP id w4mr12124411wrl.350.1584031504632; 
 Thu, 12 Mar 2020 09:45:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/36] target/arm: Update hflags in trans_CPS_v7m()
Date: Thu, 12 Mar 2020 16:44:25 +0000
Message-Id: <20200312164459.25924-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

For M-profile CPUs, the FAULTMASK value affects the CPU's MMU index
(it changes the NegPri bit). We update the hflags after calls
to the v7m_msr helper in trans_MSR_v7m() but forgot to do so
in trans_CPS_v7m().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200303174950.3298-3-peter.maydell@linaro.org
---
 target/arm/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6259064ea7c..7f0154194cf 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10590,7 +10590,7 @@ static bool trans_CPS(DisasContext *s, arg_CPS *a)
 
 static bool trans_CPS_v7m(DisasContext *s, arg_CPS_v7m *a)
 {
-    TCGv_i32 tmp, addr;
+    TCGv_i32 tmp, addr, el;
 
     if (!arm_dc_feature(s, ARM_FEATURE_M)) {
         return false;
@@ -10613,6 +10613,9 @@ static bool trans_CPS_v7m(DisasContext *s, arg_CPS_v7m *a)
         gen_helper_v7m_msr(cpu_env, addr, tmp);
         tcg_temp_free_i32(addr);
     }
+    el = tcg_const_i32(s->current_el);
+    gen_helper_rebuild_hflags_m32(cpu_env, el);
+    tcg_temp_free_i32(el);
     tcg_temp_free_i32(tmp);
     gen_lookup_tb(s);
     return true;
-- 
2.20.1


