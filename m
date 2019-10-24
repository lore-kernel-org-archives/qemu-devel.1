Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F28CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FEA20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCg1sKpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FEA20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgTV-0006mo-MB
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxe-00076g-7e
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxc-0000i9-3C
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxb-0000hr-TK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id p21so2099009wmg.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HFxRD9cQcWniuYeniFsehWwir7VzmPqYaumnJ4Y7pcY=;
 b=yCg1sKprtJlTwGko3Fgo0RZR29KzFptM/pmjw6ikqFGl3q+0y6wha6Qzp1D2U+zqYJ
 UKGzBz47sgJv6/kMh0TCuwyTWl31hmmq1I7jbG1FNiSsjAzwB61ai8R+nKb8pZ6kOVmn
 V+5WQY6ODMVzAdqKbLfx7VxottE7EJXXLTZx5yUHWYqoeT0TsFdvkrHGegmc8rkCY6v3
 qIWLWDphHz+viE5NZPSlbuhB/9vO9NqV59EanvWIJho0217hdZGwBijnX6iPR/zf+TrF
 pwFnzqXBis0NuTMmH0mwHPKpI2vdzNXvZs/MEzvR178gUw8hduUmUwpsNtoIy+DKYtrm
 dymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HFxRD9cQcWniuYeniFsehWwir7VzmPqYaumnJ4Y7pcY=;
 b=p4RLNrLYSwluilE+uGRK5Sn4CNoYOFtwNlbmBoZ1ThC+XJF347lFxIt0/xo4MLnUSF
 Xj8utHLPUNaDXeLcV6nO1aLdVPcHuiGrW4qS+7jHv+CxlJiqaxBox8qnZmVUZ/WLJIVH
 U2qSguDD7NVJ+ggis2xQGpKmzo8Dlokx5ZWr0wtsB/Xhku7Zj2GCtWXbkj0CoIYhXSgU
 u9DX4wknQnN6GsbVqL/YWCsx8p+vwSZuXsmw7XghoIbCINdrvwR8J5Xxl2qYH/LnC6Ax
 NZtjBZAm8ek/tu78GlvgyBzJrOt4UOCyZSrTnyv2Pv1Ii591qemmKqU3yNmG+1iTItC3
 BmmQ==
X-Gm-Message-State: APjAAAXht3tSkkbeBl9eTg9dayVJ5Ci+H8qE03OWbe1A/6M4h0wSeQuI
 Rmty8Lairlp5Qasql55TvtSL/lgOae4=
X-Google-Smtp-Source: APXvYqxay4Pvu0+RYXxrldDU9oOSq7uBGCAPpA8EXHaAMLcLTSfZPNDdfm1BYQY8eRJJyUru6D4NEQ==
X-Received: by 2002:a1c:1b07:: with SMTP id b7mr5674323wmb.111.1571934458406; 
 Thu, 24 Oct 2019 09:27:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/51] target/arm: Split out rebuild_hflags_a32
Date: Thu, 24 Oct 2019 17:26:42 +0100
Message-Id: <20191024162724.31675-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

Currently a trivial wrapper for rebuild_hflags_common_32.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 296a4b2232c..d1cd54cc931 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,6 +11106,12 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
+                                   ARMMMUIdx mmu_idx)
+{
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+}
+
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
@@ -11218,7 +11224,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                 flags = FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
             }
         } else {
-            flags = rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+            flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-- 
2.20.1


