Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9FBC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C8A206E4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3tuX1HU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C8A206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHrN-0005oo-JV
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icHoj-00048p-Sx
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icHoi-0006WM-4h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:53 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icHoh-0006TX-T0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:52 -0500
Received: by mail-pf1-x442.google.com with SMTP id 2so2612097pfg.12
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lxpFC0QAcEEE37xlJz3y9LIaFzl9qGfUGofGgmNc6Hw=;
 b=o3tuX1HUoAvDNtmt+1KGIV75e1nXDZ5lRpQcyRQTnZA9WxuCk3jfTLG/KkmWuY5ddu
 OBn+p/iEQxamAbCiPJAaUy0F+ddfsz4F35QiJZMG9vr7hUc7u4kcBIXhgESFLRpE+ssB
 kye2A5nKd6ppqaEuHaCC3HzatD6VlWsaazR9f0uAxzXb031ytjhAvUkh3XVGlXfbUlAh
 bSxc9u78/8LawgVqIyYYIaTc/C/KG3zbBOvu0PUukS5Nknr3C098+BaXwhkxpy8nBYSS
 QCJUpbQfaOMoq0nQy73LxZID9BTf+YnWiAhbmB44QtPzgVSMsasLNoKaQzDukV2kIo73
 D6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lxpFC0QAcEEE37xlJz3y9LIaFzl9qGfUGofGgmNc6Hw=;
 b=KOOgP/f5sERz/tms30Bpvtl8mixslfiogvGfNo5VPJ+JEM2N8QgpYNVxSWIUBEok2k
 gpZP45KeiuJ3gddQz6yKvv3mZvUxnjg08y3QoXzkI5XHS0wZLXiQ2GDiKXv7ka88gInN
 +8X0IMEIzmzOqGmML+1yvEJabM/HdjjqNn54vyH29EwpJUZDKESf28qmaJW2f3wM8RR0
 QljQ9RC/zGtDTwVsxmq+rDFq9RkzgcoUXnsuxx5/ydx5mcymIXCulqYukmiP7LxWUwEh
 fUjhZRgMqlIXcktRviVAZcigqS7IP0b2Vy8TEZrXDb48X21HbCg+WdJZcnyHRF2MwDmv
 kagg==
X-Gm-Message-State: APjAAAWDJpcLKaoEi2RvXYVeiThUY8vvF9FbHdwBl3k6Dx3xWWWrBkaR
 xgW0GIntrEcOigYrDQutsnVktl7hdl0=
X-Google-Smtp-Source: APXvYqz8hHVuaHQtXRpMFjoe6qZcEahrgBSIlEUSZDtM/nlNUNcSmN6ToYgaRqZsXJq12XnttFZr/A==
X-Received: by 2002:a65:6916:: with SMTP id s22mr302392pgq.244.1575416570450; 
 Tue, 03 Dec 2019 15:42:50 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k5sm4128256pju.14.2019.12.03.15.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 15:42:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/arm: Implement UAO semantics
Date: Tue,  3 Dec 2019 15:42:43 -0800
Message-Id: <20191203234244.9124-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203234244.9124-1-richard.henderson@linaro.org>
References: <20191203234244.9124-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need only override the current condition under which
TBFLAG_A64.UNPRIV is set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8941a6c10f..6d7a8349b5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12050,28 +12050,29 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     }
 
     /* Compute the condition for using AccType_UNPRIV for LDTR et al. */
-    /* TODO: ARMv8.2-UAO */
-    switch (mmu_idx) {
-    case ARMMMUIdx_EL10_1:
-    case ARMMMUIdx_EL10_1_PAN:
-    case ARMMMUIdx_SE1:
-    case ARMMMUIdx_SE1_PAN:
-        /* TODO: ARMv8.3-NV */
-        flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
-        break;
-    case ARMMMUIdx_EL20_2:
-    case ARMMMUIdx_EL20_2_PAN:
-        /* TODO: ARMv8.4-SecEL2 */
-        /*
-         * Note that EL20_2 is gated by HCR_EL2.E2H == 1, but EL20_0 is
-         * gated by HCR_EL2.<E2H,TGE> == '11', and so is LDTR.
-         */
-        if (env->cp15.hcr_el2 & HCR_TGE) {
+    if (!(env->pstate & PSTATE_UAO)) {
+        switch (mmu_idx) {
+        case ARMMMUIdx_EL10_1:
+        case ARMMMUIdx_EL10_1_PAN:
+        case ARMMMUIdx_SE1:
+        case ARMMMUIdx_SE1_PAN:
+            /* TODO: ARMv8.3-NV */
             flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+            break;
+        case ARMMMUIdx_EL20_2:
+        case ARMMMUIdx_EL20_2_PAN:
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
2.17.1


