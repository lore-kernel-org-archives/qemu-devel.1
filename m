Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB55CC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A887C20726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYEPhxPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A887C20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PlQ-0000po-Pg
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgv-0000kc-6l
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgu-00056p-6t
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:33 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgu-00052a-0g
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:32 -0500
Received: by mail-wr1-x441.google.com with SMTP id w12so2064816wrt.2
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ENQgvGHJlgOvyNIKuMG2rnxdNRZFYiYT8ZYfYWz3WUI=;
 b=WYEPhxPx5xLyyzO+9sogxoawsKbGdaU29SDxiv8YD/0yNxy7tcy7888GBhbxBbyXH9
 6Df3SX3WSjocUDZILpCWM5K4Pn5lWL4TuX+nWeM45Pkt7vwW5NkmQoUIHg7dzFvjWRju
 lKYN6MzaT82FlMdeWuklLSXwZxYXKmLy/bbQ/Xkdu6qNZKjXMTy2Dj50CrfqLUdx25Ho
 EzcS8RGfNbbQrIO6U4jEPSMuYPluJRiJW35svSzx8vyWWFeJIdAhA5+5UKfPYXBu4AGQ
 tvanrEnVI8RXpyElleywz0cicQr/IchA6Mys1n2CtspBDf3LSI9036guP2LMDucUcovf
 25lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ENQgvGHJlgOvyNIKuMG2rnxdNRZFYiYT8ZYfYWz3WUI=;
 b=ON03Orq3P+n6e09sEx0NYtbVELcwvzAXA4V1Mbu9ExGbgyNYQ797rN+T1BlG/Oh876
 lOEZVFb16mpgyby10nn1Pc7Wu49Bm2EU1QwVDPGF0z91EUXr+wH2TDZK1RPhgmzdgXEF
 vL5wscP5PuCyANQJ1Iv7k6HFwPLjTaiODp0B3WGkymFbi6sRxZmvM9UGqXnfi2yPvbyx
 54F5RHpDGtZACXA/Me9os/DZfYw7OtznunbaUtDntrOPp8ok/eL9dSST2mCFvZ853OHO
 DXzjFmc8eL4TEGbhKdD19eepk9EpdwhY5bwsoLBejAvo2Gxs3Q7nHJE74MymhejHFbK2
 nxeg==
X-Gm-Message-State: APjAAAUbkbHQjuAAunI1ndmFIhxAD1W8UF95xtfB3VAkafa7ySkZO2QS
 PSY+xJ3GONBnRZ/vjYOGR+FhlNtnX2651Q==
X-Google-Smtp-Source: APXvYqzofesoZsfs/ozK57FE8d716E2x90MhhzgvjOXia00pQbMXaNBaSwklLeNBdeINGkPhUcox/g==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr5581291wrv.358.1581166710819; 
 Sat, 08 Feb 2020 04:58:30 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/20] target/arm: Enforce PAN semantics in get_S1prot
Date: Sat,  8 Feb 2020 12:58:09 +0000
Message-Id: <20200208125816.14954-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f6a600aa00..178757d271 100644
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


