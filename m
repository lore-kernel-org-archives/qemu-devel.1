Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5463DC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D172067C
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6riD22J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D172067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyaY-0002si-9D
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySi-0007g3-QB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySh-0006ub-S0
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:48 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySh-0006tu-Lx
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:47 -0500
Received: by mail-pf1-x441.google.com with SMTP id j9so2187558pfa.8
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Norg9fPtXVkCxAbFxqHU+mKSGwd6dWrkKXpQEb83JIc=;
 b=o6riD22JdE0vtcQzXipfO5ZeBNdpHJVMwCDEYVec3QkaTID68o6Dd+hfP7sCkGD2Qk
 8GCnYRBX7O5I/sMQhKzRuvZof7FqB0YVyRko+e5faQQJHG1dwMlbttP7d5p8mkZu0uIY
 6OygE/TNOq/gOc5fnIE8SbaTtOmAZNavbgtlkM52NJxxG38/y9SSoYQVZD9wQgu+j3Zi
 DCx940eNNB3Fwv+oajNiKpZiAVGLxTw0SP8lmbZhg7s12im8h2Wd+IvPNnFzQVx4BY3t
 kFEIkkCsG+w2a1LYh9JnPsMtL60oXHXEzcUDYi9niIQfXaBCJCSatBkx9Ychw6As4xUt
 DPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Norg9fPtXVkCxAbFxqHU+mKSGwd6dWrkKXpQEb83JIc=;
 b=Dmm3sgwYQzNlUniuV/FpXaht0zO0G9e9jJhJbCtzSDeEE6mtwW1qucBYKVpaKAUEZ3
 JDQNL3mc/Qayh5RNXRK23FC5mYPM8vRFvN7NM5aALpiThVravy0zNBaNoy6Ab2etiEDr
 FTEbsgnD8H6C0FNwSrD09Rud+IPRoH5Trm5U0eLo9eMt2fLKCSFuU1tTYnZVn7WzUDVb
 dgriljBU1SSpxUk+ajxr57+N+r+EOab4aghBYxDvcCWYLj6XKnPiTn7pIKEQE1vaa0tr
 g+FWs1RHNoHSBSg2NRbUwuRQnAOVN5FY2qO8WXBfrk5h+KLvA7qanNUdxdUC+wt5zCyN
 LeFA==
X-Gm-Message-State: APjAAAXOE5ikP7XLeNEKLxD8vJAHMxqiXZen4tOActbw+gW/6zc0vXvk
 B2xCqrQW7BVp1hiNzxcscePaPkx/950=
X-Google-Smtp-Source: APXvYqxPTJkr1P8auMD8FJ7kRayioEO30jRFI9YRcKtOzMxb7DkN9eqZRlKhuaG39G2vakjd2CVpuw==
X-Received: by 2002:a62:7a8a:: with SMTP id
 v132mr17567217pfc.111.1580585386460; 
 Sat, 01 Feb 2020 11:29:46 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 24/41] target/arm: Update ctr_el0_access for EL2
Date: Sat,  1 Feb 2020 11:28:59 -0800
Message-Id: <20200201192916.31796-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to include checks against HCR_EL2.TID2.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e41bece6b5..72b336e3b5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5264,11 +5264,27 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
-    /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
-     * but the AArch32 CTR has its own reginfo struct)
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TID2) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TID2) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
 
     if (arm_current_el(env) < 2 && arm_hcr_el2_eff(env) & HCR_TID2) {
-- 
2.20.1


