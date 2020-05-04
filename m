Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5B4C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B26206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHaU1xmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B26206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaM3-0000MG-7S
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHj-0008LM-Gw
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHi-0000oy-GW
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id z6so8835234wml.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=M3vgvadFWkC90M8EmTrfIPMjpAv4cjLc8OSWbkOS2EQ=;
 b=BHaU1xmjxgoHhGCCPnt4qs4vycVBT1mZw3Fi3H2a+LvSATdoJkoETgm9cgL/mm/MfC
 /wKAa26QxgIEKsg9HNPnMmYfnVOntzVa1pVa/r1XA+/fjo4WK+9vI0tClvTnq1RvjD8u
 kN6xnOIanMxw959jJ5q0tj2JMLGZV10+WOg/1sfb458Lg4RE0faoMjyHY5rTuMbmkPLc
 jSDZlOdxwBG7uvNT2OaLegD6PgKWmWay3N+qJq6sp+J0BRpQVbwDouuHYk0JMydoftxY
 XK2fN45AsBmOUnVa0lC8RsB7PiYJEw8Mdgl3KQ+O9Cm4eS+jmY/TuCeSP7Bw4B/UJ+DV
 c/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M3vgvadFWkC90M8EmTrfIPMjpAv4cjLc8OSWbkOS2EQ=;
 b=n3D+BRbbdnsaL+0JHUy9dBlMDEnI3hvA96ZspGJT5cMWW7x0EgkhaQFLqpIQYIqUlP
 QyeHRf4dcQCZBHEb7OBW7f2GNiE3Oktt6pKVh75kjPfEDv+BNPPWKGkf67wgXEKFop/M
 Xz5c6CaHc2vCNtCNSQxlPhKE0hGTBaOMqcT5bp+Q9Do6aCpRtmI9IuqSp0NUno0I2sg1
 ZG63W3ME+zArjE26QuyIRUeYIO4dyAW32Wjt4mvez2AnZevPOhEMROh9AoXD7gbNE74t
 e5OULAy376GJeqnyRoNr7gyI7QFEYrvGlbcHDt3XMD+76HY4Lw/KcVk+H3hbUykEF6Py
 dPjQ==
X-Gm-Message-State: AGi0PuajT3ivW5uBpCueUReB7+X/0dqabv5/WMfSOLjHAgdljYvGypS5
 LudlfR1KZQFwRmTo+Is6lo4iXY/u0o2wxw==
X-Google-Smtp-Source: APiQypJ6+QxeDUmEmEc+H/HLcujcTmAIyWS+fO3UmiPnh/J7oeqtautJwkHPU+RCmsMjkOVCh4PkfA==
X-Received: by 2002:a7b:cf23:: with SMTP id m3mr14050982wmg.36.1588595601027; 
 Mon, 04 May 2020 05:33:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/39] target/arm: Use uint64_t for midr field in CPU state
 struct
Date: Mon,  4 May 2020 13:32:38 +0100
Message-Id: <20200504123309.3808-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

MIDR_EL1 is a 64-bit system register with the top 32-bit being RES0.
Represent it in QEMU's ARMCPU struct with a uint64_t, not a
uint32_t.

This fixes an error when compiling with -Werror=conversion
because we were manipulating the register value using a
local uint64_t variable:

  target/arm/cpu64.c: In function ‘aarch64_max_initfn’:
  target/arm/cpu64.c:628:21: error: conversion from ‘uint64_t’ {aka ‘long unsigned int’} to ‘uint32_t’ {aka ‘unsigned int’} may change value [-Werror=conversion]
    628 |         cpu->midr = t;
        |                     ^

and future-proofs us against a possible future architecture
change using some of the top 32 bits.

Suggested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20200428172634.29707-1-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 2 +-
 target/arm/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9aae324d0f6..8608da6b6fc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -894,7 +894,7 @@ struct ARMCPU {
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
     } isar;
-    uint32_t midr;
+    uint64_t midr;
     uint32_t revidr;
     uint32_t reset_fpsid;
     uint32_t ctr;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f588344df83..5d64adfe76e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2755,7 +2755,7 @@ static const ARMCPUInfo arm_cpus[] = {
 static Property arm_cpu_properties[] = {
     DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, false),
     DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
-    DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
+    DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
-- 
2.20.1


