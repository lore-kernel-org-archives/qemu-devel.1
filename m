Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A82DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE5E2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEOZ/GDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE5E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhik-0007tr-SH
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHK-0003Zk-1U
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHI-0003QK-6W
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id g18so11115320wrm.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=93DPZhJ1c1kkfDUxuVzeumq5Pucl+HwBkMTUco5Vv4s=;
 b=sEOZ/GDyjhvVCbIlCJvzcF5VFWIEdBoz72F2afWiErqUcTUpLc1jOZiLTuP1/klN1j
 RVAtgBU3Bdu47Jn/1u1oSui6D9gNkolO/c81o4wyJRzennyLaeYpGx/xLarrUbE5E8QK
 SFrCGEjonIA3i3AJpvgrRHryoAep+bvV2jfIUEdqcI7Eie2gmrM+VCnJ/RzxFquJmVKq
 CCdbcW7+y3H2qrtXF+rg4wlXm6EPaipExOblzTNX+FNnnvGiUJN2bNl6wV0w+bUWaXwK
 U7CLCALM3/3/xsHN5T6Db3pmDOjx6tuicoABlqbbh2UtvPNidYGKQ4UPsccZoySgBfr1
 QMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=93DPZhJ1c1kkfDUxuVzeumq5Pucl+HwBkMTUco5Vv4s=;
 b=h22Id99MM+/GrHfixAZvNXoBnKrIKg4iyY+DCSSTLwqWP3pvsd/9y0fwBVQWDWrnf9
 y1xeaGA975uwsDf1PKvgZlY51i7I91icYwxfFF9dJLRnEyrg43P4FA1Jas00HQytZhh2
 sS9TTDu2BbLWr6aXU+r6K+UZWKNkubLpJqZL1c6z9IOeNM2gwDeT0CvuIa+BrJcPuJGX
 vykjUwKgtpn78djXcDBKZqSUvpsEqpdaorpTvFVLlRkYPF/mwNK0FdoCgjPW+cXH+q9U
 nsxigeO1o7PEnXVM/fMEIpEPBpPHYrrMqx5Mcxtsrg5XKoaQgKlcLuJc+broOdrPS4mv
 6wsQ==
X-Gm-Message-State: AOAM530/lYCrNgkJSqtx+g7xHm2APXJ7iDmMZfG1JCEfjMEc2VIClj/K
 qRXQw4R/mWxCCwJ5HKAEp5y9SCCJC7uNYg==
X-Google-Smtp-Source: ABdhPJxPycm0Ikd8zT3zc99AWXQxkI8AN51v/lDK9OociMTo4wmZC2Pz5emckJjutVidFplvWIAU5A==
X-Received: by 2002:adf:c382:: with SMTP id p2mr24322388wrf.283.1592912386516; 
 Tue, 23 Jun 2020 04:39:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/42] hw/arm/mps2: Map the FPGA I/O block
Date: Tue, 23 Jun 2020 12:38:57 +0100
Message-Id: <20200623113904.28805-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-11-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index c66c595d4a0..e1061232254 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -38,8 +38,10 @@
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
+#include "hw/misc/mps2-fpgaio.h"
 #include "hw/net/lan9118.h"
 #include "net/net.h"
+#include "hw/watchdog/cmsdk-apb-watchdog.h"
 
 typedef enum MPS2FPGAType {
     FPGA_AN385,
@@ -67,8 +69,10 @@ typedef struct {
     MemoryRegion sram;
     /* FPGA APB subsystem */
     MPS2SCC scc;
+    MPS2FPGAIO fpgaio;
     /* CMSDK APB subsystem */
     CMSDKAPBDualTimer dualtimer;
+    CMSDKAPBWatchdog watchdog;
 } MPS2MachineState;
 
 #define TYPE_MPS2_MACHINE "mps2"
@@ -332,6 +336,11 @@ static void mps2_common_init(MachineState *machine)
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
     sysbus_realize(SYS_BUS_DEVICE(&mms->scc), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
+    object_initialize_child(OBJECT(mms), "fpgaio",
+                            &mms->fpgaio, TYPE_MPS2_FPGAIO);
+    qdev_prop_set_uint32(DEVICE(&mms->fpgaio), "prescale-clk", 25000000);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->fpgaio), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
-- 
2.20.1


