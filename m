Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C8BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CC420684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXgQ6/qX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CC420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyBC-0003r7-Bc
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxF-0003Kd-Oz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxA-0008QG-QN
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:18 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxxA-0008Hc-Gp
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:16 -0500
Received: by mail-pf1-x443.google.com with SMTP id s18so985809pfm.4
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GDr0htatS+6R/DlKCxhohN0bwVQjve2P3dt6OUDDnew=;
 b=xXgQ6/qXBmXh0e7CTiB3ETD86w6CeII2P9TYDc63utlIjSzZ6sasDKHiQFFzROaNB1
 JkgjhWbHsgS/w3jCa1DvrF0a/TOkKeW9Qv+k4x/W4ly3oos9A77pbXDxiGkFRQlCXpYd
 7G5okRO0M24CcrXQe4DmwgSQvFQRoKdy8+F9pB0D38N3EnRuN7eGXk+pKohwd7OwpemD
 Dg3qgo2KWxy7bR1XukY0JckWVpUp2JilYnkwkqd8EHd5otnbwenfXd5mqFlSx7OQgmfn
 200ly/oXvGJgDbUkrIshqHP7FpOR/eKVuX8S2ILCGnEitmX4z7MMFHYzq9GexjbHqx8s
 VJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GDr0htatS+6R/DlKCxhohN0bwVQjve2P3dt6OUDDnew=;
 b=VmMd3KMGmzSgJ3jXKotBwRj3u/0Z0QABajz9K15LLJcj2cUf6H9LRqnIIxjXmqqF58
 HeURn6XseMt/DXbt+vfKshZ6o0uiAhrztl7YNmsTrMR/z9nRmHwZTpc6HyBvjpIDtrov
 dh4SrexdH/Q44gvIWVF358WgFGtgqhzSD00TvWtaWboEfzztwm5p81vj0JdWG8jogUUP
 4pOVuf4rFbtT+1I1g1bt0adN8ayj76LWfZNL+jRlFjhLlqLWrVxxbsAlczl8jo0FxSqL
 NC9gCpRClokCYm5ZBybMjFk9kAXCtZlWNSBuaNFeplsb+RCAFYDx16qHF2JlyQnMheKS
 nAVg==
X-Gm-Message-State: APjAAAWnHdO6iLzxcorZX8gMSIE2FpB2nxR8/NeGa1R7ZiDtm4j1naNz
 bWsKpiB54MD/T6ee9QqH8MFKpVNig70=
X-Google-Smtp-Source: APXvYqyzhDrlLS21TTEEdHFXT/H6A+YjV1HVXuc+4ofrVctgXS6Sw+aR2MLexiLaxcxYw6ayP4IwGg==
X-Received: by 2002:a62:3141:: with SMTP id x62mr2359713pfx.214.1575340205188; 
 Mon, 02 Dec 2019 18:30:05 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:30:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 20/40] target/arm: Update arm_mmu_idx for VHE
Date: Mon,  2 Dec 2019 18:29:17 -0800
Message-Id: <20191203022937.1474-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

Return the indexes for the EL2&0 regime when the appropriate bits
are set within HCR_EL2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27adf24fa6..c6b4c0a25f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11172,12 +11172,16 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
+    /* See ARM pseudo-function ELIsInHost.  */
     switch (el) {
     case 0:
-        /* TODO: ARMv8.1-VHE */
         if (arm_is_secure_below_el3(env)) {
             return ARMMMUIdx_SE0;
         }
+        if ((env->cp15.hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)
+            && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_EL20_0;
+        }
         return ARMMMUIdx_EL10_0;
     case 1:
         if (arm_is_secure_below_el3(env)) {
@@ -11185,8 +11189,11 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
         }
         return ARMMMUIdx_EL10_1;
     case 2:
-        /* TODO: ARMv8.1-VHE */
         /* TODO: ARMv8.4-SecEL2 */
+        /* Note that TGE does not apply at EL2.  */
+        if ((env->cp15.hcr_el2 & HCR_E2H) && arm_el_is_aa64(env, 2)) {
+            return ARMMMUIdx_EL20_2;
+        }
         return ARMMMUIdx_E2;
     case 3:
         return ARMMMUIdx_SE3;
-- 
2.17.1


