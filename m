Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1BDC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932552224B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSpgnK1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932552224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuHP-0002A2-KB
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0r-0004hM-Lc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:56274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0p-0003tJ-3z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id a72so2329650wme.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L0lYmOUonCsI2H/sVY4IV71YZ7WBk/jN9yG1LepsCeQ=;
 b=VSpgnK1LEpn0kGA3tyU60mbWTI15NvlO9OZqUz/GPAqw/w6xLBJ5J5Lrlphy/szOBP
 fcGUMkCjVJYYEM6i+TDKoyXwQy+R0yCl/Fz9Z6AGBurZMrWCu94DSZSn5oyu6FTwuj5M
 CvZg+Yv7P0kcw4J7cvY2wI450FDjglYedmDTl64NGIBBxDVEPhllVso/Tp3nOo/smaLO
 zIp3OHTi6IiNgFrm2ZNiiOd2dabrTiqhvtn0T2lvU8WAYBHJxf7qY8+/wFKfHng6lHiM
 BV/stjT/Wv8J7WNeTvVIW+tjG4pQRFtCPKvhSEutNoSuTp0fR6v7ACJzOGRqKgh5HXxo
 Q4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L0lYmOUonCsI2H/sVY4IV71YZ7WBk/jN9yG1LepsCeQ=;
 b=N2iDOgcxzc97zsBTJ52PuGJrkdIL3HbGAX++WpjZzBbIPAchD93SL6YRp1DPep/1ea
 /6JagGoCy/sQnMFZ45abchq16l4cV7n2YyacP1q8cpkDVyoA1Cs06df3yymsDCNCTVKl
 g5arT3rQOJGJRTTf+IDFk6zL6ScJ8t7cVo2MLGwjOxXsG/J9kfXafDAm/7znJV3Q9QGT
 HbxqUmqspDgWSeMij1kgmP02q7/bxBRx9OhVeohbu6mqBk65AK2rNtKpFd0opEhi7uXN
 lG+nqUsZwpPjzqs3DDbPffwFCdV9Bi6InsHHToX3mV8lXU18wQw0BX/QLtH6G/6UWjvC
 NXsA==
X-Gm-Message-State: AOAM5307SiPs2mzldfi0n4/HIXgMXhxiFg9kLT3bh2jA+rYL+3NT3Ys2
 IPSxHye5sExRGRPH8Yq1013ElPWXwykgyA==
X-Google-Smtp-Source: ABdhPJw9xpDEM6/8lvjdRXuPRhqj3rooHKWmbhCBef9cHUlvi+ezrysOKpV6h2RyDPY10GnD5rFM0A==
X-Received: by 2002:a1c:b40b:: with SMTP id d11mr3543359wmf.152.1603209441497; 
 Tue, 20 Oct 2020 08:57:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/41] hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
Date: Tue, 20 Oct 2020 16:56:28 +0100
Message-Id: <20201020155656.8045-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add trace events for GPU and CPU IRQs.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201017180731.1165871-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/bcm2835_ic.c | 4 +++-
 hw/intc/trace-events | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 53ab8f58810..9000d995e81 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -18,6 +18,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 #define GPU_IRQS 64
 #define ARM_IRQS 8
@@ -51,7 +52,6 @@ static void bcm2835_ic_update(BCM2835ICState *s)
     set = (s->gpu_irq_level & s->gpu_irq_enable)
         || (s->arm_irq_level & s->arm_irq_enable);
     qemu_set_irq(s->irq, set);
-
 }
 
 static void bcm2835_ic_set_gpu_irq(void *opaque, int irq, int level)
@@ -59,6 +59,7 @@ static void bcm2835_ic_set_gpu_irq(void *opaque, int irq, int level)
     BCM2835ICState *s = opaque;
 
     assert(irq >= 0 && irq < 64);
+    trace_bcm2835_ic_set_gpu_irq(irq, level);
     s->gpu_irq_level = deposit64(s->gpu_irq_level, irq, 1, level != 0);
     bcm2835_ic_update(s);
 }
@@ -68,6 +69,7 @@ static void bcm2835_ic_set_arm_irq(void *opaque, int irq, int level)
     BCM2835ICState *s = opaque;
 
     assert(irq >= 0 && irq < 8);
+    trace_bcm2835_ic_set_cpu_irq(irq, level);
     s->arm_irq_level = deposit32(s->arm_irq_level, irq, 1, level != 0);
     bcm2835_ic_update(s);
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 527c3f76cae..22782b3f089 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -199,3 +199,7 @@ nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg wri
 heathrow_write(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
 heathrow_read(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
 heathrow_set_irq(int num, int level) "set_irq: num=0x%02x level=%d"
+
+# bcm2835_ic.c
+bcm2835_ic_set_gpu_irq(int irq, int level) "GPU irq #%d level %d"
+bcm2835_ic_set_cpu_irq(int irq, int level) "CPU irq #%d level %d"
-- 
2.20.1


