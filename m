Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE90DC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FC120780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0Ayx3eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FC120780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzyj-0004SQ-Dt
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsU-0004q9-9w
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsS-0002xM-Gm
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so3432441wme.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9fs8CDgZB0euLlKk3g1JwM1NPKjUQ8Bto5n+KMpexUU=;
 b=n0Ayx3euAVxMQQfkyRHMVzOFpjnpFqvX4hb8t343zEar4Tn7MXmrHiP7OKzTsgJLX8
 kajY2DmFFNsBp9UcK69192o5EvYe10MqOge0UMPvx0XZd3Hr/Sa4GAcMZsjmV014PIZM
 QXxfErvDl5vHaA7cpgtLvnBp+vQLLRbsxjJot6iSpnmipdGKSKgB6WHRsMY1PegjlkTx
 mITR5DxzsCE8dn4wNsL4Y2vbo3FaolcSrfCB6qTgDJv1jN+JiUJDkYYXuN+w4wxoJfHc
 BividLLDw7z2G34Fem7+mHEUd32zuORnXz8gp761FSWETYIybZp06sPAgAJGV3Rnu8Ej
 JDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9fs8CDgZB0euLlKk3g1JwM1NPKjUQ8Bto5n+KMpexUU=;
 b=gbrpFQS6r2rCyS+x1ksw3vFfwDdcu/pOuSKX9G/LThj9k+lICNkVWsQdl6PQLdWGf3
 WJWU1a5I+CnCQj0NQYixJ1ROp6NH1n4Q0LBFTxEV5c8zrlGMec8uKCaBrnx/ml830tbG
 GUy+PVbNoQPGhB37XVSzGanA2ibgiovrJ9jDGV17Gdu3zDCEbDlDetxRHiAipZskFoXJ
 eS2g7nkcCXhmivz6BApF+mzszs6zERGhpNLSXiLBui6hN5+NYc5NeSn8lvH/Q6urt4yX
 WYCBQu8DzbzgTcVRr7o15KCMVCJM2oqg8Z2+wJitq5YFlO4VYKDiTyS/Hq6LcqbxGBg1
 RaAg==
X-Gm-Message-State: AOAM532qTHwH4GGux8jJrZgZ+YD+Ooj1gThUVbJiqRbc3knyn6nfeQsR
 YqiTpeD/oXHNwCTSM2SH1Pixu9Gc7Ei+Joza
X-Google-Smtp-Source: ABdhPJwsdUuqmOudMHbFjC/TmA7m9hAFqSoOA/ig/MQ8OqYvhic2XEYSeWm1OqquvVMGA+FySjQIUA==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr328238wmk.153.1601563690826;
 Thu, 01 Oct 2020 07:48:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] target/arm: Add ID register values for Cortex-M0
Date: Thu,  1 Oct 2020 15:47:45 +0100
Message-Id: <20201001144759.5964-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Give the Cortex-M0 ID register values corresponding to its
implemented behaviour.  These will not be guest-visible but will be
used to govern the behaviour of QEMU's emulation.  We use the same
values that the Cortex-M3 does.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200910173855.4068-5-peter.maydell@linaro.org
---
 target/arm/cpu_tcg.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
index a9b7cf52550..0013e25412f 100644
--- a/target/arm/cpu_tcg.c
+++ b/target/arm/cpu_tcg.c
@@ -256,6 +256,30 @@ static void cortex_m0_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M);
 
     cpu->midr = 0x410cc200;
+
+    /*
+     * These ID register values are not guest visible, because
+     * we do not implement the Main Extension. They must be set
+     * to values corresponding to the Cortex-M0's implemented
+     * features, because QEMU generally controls its emulation
+     * by looking at ID register fields. We use the same values as
+     * for the M3.
+     */
+    cpu->isar.id_pfr0 = 0x00000030;
+    cpu->isar.id_pfr1 = 0x00000200;
+    cpu->isar.id_dfr0 = 0x00100000;
+    cpu->id_afr0 = 0x00000000;
+    cpu->isar.id_mmfr0 = 0x00000030;
+    cpu->isar.id_mmfr1 = 0x00000000;
+    cpu->isar.id_mmfr2 = 0x00000000;
+    cpu->isar.id_mmfr3 = 0x00000000;
+    cpu->isar.id_isar0 = 0x01141110;
+    cpu->isar.id_isar1 = 0x02111000;
+    cpu->isar.id_isar2 = 0x21112231;
+    cpu->isar.id_isar3 = 0x01111110;
+    cpu->isar.id_isar4 = 0x01310102;
+    cpu->isar.id_isar5 = 0x00000000;
+    cpu->isar.id_isar6 = 0x00000000;
 }
 
 static void cortex_m3_initfn(Object *obj)
-- 
2.20.1


