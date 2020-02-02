Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BF8C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E353820658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMhuUb+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E353820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3kx-00041S-2Z
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h7-0003rs-0F
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h5-0002IL-OH
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:00 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3h5-0002Gw-Hy
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:59 -0500
Received: by mail-pf1-x442.google.com with SMTP id y73so5542554pfg.2
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JSoxWa3cljnlHVlVCNXL6Dtt3Ft2EaSM4NkE+KvUy1o=;
 b=jMhuUb+8Iu0SZPfw/HYaoc8Iv7kFANTJKaDpqfvHl0ScGvxqcVtemXr9ef1s8WKQlI
 kkj9Bn1amg01jejKOGbemwkOwHQ2I5T4pOdmRoEKYKh3anJUHZmhra0HsMshyG6huHRK
 oNk+WfjwumlV61wCaLaPTdWGPQRfZ2kHpD68T8wkxTYe/NKd8i/cmCOW7/VLmWuW/ZQD
 p2j0vGq05xMrHwIE2PSAoLD+dYN1OSOTHUIOdw0KW+z1iPm+Ol3U7xFmfFLabpMBOYJE
 wjEhzQKtodrGCqnA0qAvhshEZ6Rht+nvlDY8YizsUaOsVEZwXQmFlD3iAH0Rh2P9MaHn
 hYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JSoxWa3cljnlHVlVCNXL6Dtt3Ft2EaSM4NkE+KvUy1o=;
 b=As8RQF9AXIUzpfFgK++AUT17aPq9hHdpQc4idUsQeGG1xHIHLKdS4z1VFMs5LnHHDb
 i7DAI2ReBS51Jj0Wtugm5F14hzAltk6qOCPJF3MUPr9rxXJvOdxJriPz0Gg7haLplnhN
 EKSyq3pHRbZYjwWItDQWg7ktjtKV+dnFegir3u8WXjYdlBVrJZAPyul/fJeDz5kIhIu0
 2t73ACqp/j5Jds13tshXSOUPABwZwrkUHl2nwM0ivNSABLNBvrgkuqMNhWqCcm+P7I1s
 qerL0GQOVEoWDl3e35l2/JOhaRsPyAYuuQ6uOS1Lce8QP9YQgyZZkg99GTaIvxtiVGiX
 +HNQ==
X-Gm-Message-State: APjAAAX0oJ6FwR76gGdCTnZOh1dpwl9/IilnMKvL95t3LxcGFGDs06hg
 gXp0PvslixvnkJgSyKpZaOf/4Lp8Q4Q=
X-Google-Smtp-Source: APXvYqw715xIgNml0iG/Vsma7M+y3BLsFCWoiN4JC6Fx5HXsV5N5GRGQET9qP/h+aL6vUPm6IYYzWw==
X-Received: by 2002:aa7:961b:: with SMTP id q27mr17953413pfg.23.1580605497176; 
 Sat, 01 Feb 2020 17:04:57 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/14] target/arm: Implement UAO semantics
Date: Sat,  1 Feb 2020 17:04:38 -0800
Message-Id: <20200202010439.6410-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

We need only override the current condition under which
TBFLAG_A64.UNPRIV is set.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d847b0f40b..b24a6a6526 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12194,28 +12194,29 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     }
 
     /* Compute the condition for using AccType_UNPRIV for LDTR et al. */
-    /* TODO: ARMv8.2-UAO */
-    switch (mmu_idx) {
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_SE10_1:
-    case ARMMMUIdx_SE10_1_PAN:
-        /* TODO: ARMv8.3-NV */
-        flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
-        break;
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-        /* TODO: ARMv8.4-SecEL2 */
-        /*
-         * Note that E20_2 is gated by HCR_EL2.E2H == 1, but E20_0 is
-         * gated by HCR_EL2.<E2H,TGE> == '11', and so is LDTR.
-         */
-        if (env->cp15.hcr_el2 & HCR_TGE) {
+    if (!(env->pstate & PSTATE_UAO)) {
+        switch (mmu_idx) {
+        case ARMMMUIdx_E10_1:
+        case ARMMMUIdx_E10_1_PAN:
+        case ARMMMUIdx_SE10_1:
+        case ARMMMUIdx_SE10_1_PAN:
+            /* TODO: ARMv8.3-NV */
             flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+            break;
+        case ARMMMUIdx_E20_2:
+        case ARMMMUIdx_E20_2_PAN:
+            /* TODO: ARMv8.4-SecEL2 */
+            /*
+             * Note that EL20_2 is gated by HCR_EL2.E2H == 1, but EL20_0 is
+             * gated by HCR_EL2.<E2H,TGE> == '11', and so is LDTR.
+             */
+            if (env->cp15.hcr_el2 & HCR_TGE) {
+                flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+            }
+            break;
+        default:
+            break;
         }
-        break;
-    default:
-        break;
     }
 
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
-- 
2.20.1


