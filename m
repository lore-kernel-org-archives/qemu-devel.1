Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73F2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA132067C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0qLfelh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA132067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQaG-0000Xe-Bz
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQXO-0003wp-2X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:39:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQXL-0002o2-5N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:39:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id z4so7739304wrr.4
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QeNzMtOZTYV0IOHCApAJqADotFnerf/bH2WL1EVEpCU=;
 b=V0qLfelhP5Exlq4MjriXLd7sYqS2X3wd9wHutRBM9NAMnn12UFgREvmSOg6XH1E9xq
 bPLqclF3Ebaaht24FU6/8+gOHefrQ6H5Gi99nMe56O1L7htcY/9FPx9SDzyyXeomomao
 Yea4bzVTkwLa80apZ3benSWXVS8PbytQ5ERffXMGFaVjaTcj8rGqUFMs0J7D5QZ6J182
 DftvUocP2SYa6YXJXwan+XjTh6ZutF7cykObhgR+Z/KsjIDKQowSfGh9zNwX/tSnpcV6
 tAWzH0v17X70eRuzY4LigPNduLaPyki1WdK2fYRqnzXVht683q6NWt+zUdLxp5kdWWW2
 yGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QeNzMtOZTYV0IOHCApAJqADotFnerf/bH2WL1EVEpCU=;
 b=mGBh3ErO3/vrB+oUG8RHdpiK+Kt+jg3x8HvDfgVa404EX6z4Z7tY24K+xxcbyn8VLB
 Du9ryizewJEEF+2CMWiOj7Rkx6YxIQ9Glyk6k3g+Dr2pRwXEHWMieUdwVfHwes17mVjn
 ZF4+lMzyrxMg5+0xWRuFBmxGHYO9+JdgLuoH0XoH4o34g+3QLhDb5fwzohMqrGrXAUZR
 Xd+KYv4gJJvNgJgcpJuwf5AzvXKEeg0P3CYTtFAEJV2GaqK5IvMb0naKzwopm1pS/r/R
 VhTtKm3TvUdC8Oco/HK8LHti5IxWCvPMMJMLCjmeknQKCycrwPZJiTA45kudOxsOkBXo
 ApsA==
X-Gm-Message-State: AOAM530ukOIwgBJcNqc5VkEMQuQvGJ1c7JqBwmGfMS+nNg7F9l4XJprt
 4k38CTg9CHUI0ygcjdhqxQzCoA==
X-Google-Smtp-Source: ABdhPJwaGsdt6HgdztPcu8/KtMr0kxghPrLr+Sk5b5qJDqkaiRJEOJcA+2tQm3O0GNU+JBWF3UbeGw==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr10016798wrm.422.1599759545755; 
 Thu, 10 Sep 2020 10:39:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q186sm4603128wma.45.2020.09.10.10.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 10:39:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/arm: Add ID register values for Cortex-M0
Date: Thu, 10 Sep 2020 18:38:54 +0100
Message-Id: <20200910173855.4068-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910173855.4068-1-peter.maydell@linaro.org>
References: <20200910173855.4068-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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


