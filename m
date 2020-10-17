Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04FCC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF742073A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyaAtxeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF742073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTqeK-0001PK-B6
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 14:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqcJ-0000B5-0W; Sat, 17 Oct 2020 14:07:43 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqcH-00051S-I8; Sat, 17 Oct 2020 14:07:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id x7so7010455wrl.3;
 Sat, 17 Oct 2020 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oqn2dPFn8mKbR1de5rALVSO4XjboTwebIxIYduVVNiA=;
 b=QyaAtxeJXVu/7u6sAccHxcHgusL8VK2T9LODq95t1dGJjFOxLuZcGIrOaUPgGrTEzR
 Hvq30rnw1X8vZ8pwQzDEm05lTTaZ68sTu1RlGc6Ke674NKx/neMlfTFYi5seGHazvdIU
 8AOGO1ed51nCTqiYtfCtYBKAnhjBAdn0vkB2QJVllVc5to0+b/yHcv9ELkUKoIiRxRHJ
 v0sOAUb54k434IQ92ASck4QqQL+spw9gRML/qsElC2XoxINqzjvQ4HY57rcfVzqh15jC
 358/HxTa9yKiiPwoZubuqE2cJ0EhmfTEznJPWgU7AYJrkHOo8/psKWRLWTl1jtZxau40
 h2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Oqn2dPFn8mKbR1de5rALVSO4XjboTwebIxIYduVVNiA=;
 b=qaAgQ72Fruwaxl2fCvmabcRjzXQevXg5ypvliU3tRh23LfDvmGXDxJrDZ1M9NZzep+
 XnPA09/+Xg7kMDgFE2lZqaFa30T3+ZJ32jD067LoscdLThFWTQUwHl8XOtQHT6FThbPL
 vRZoxxycge9fktMWcWklGzV4AIUPsTZzZ2/ylQp/jzFW/VktHNdtSR/Y5bbaWN/1NzUG
 soJ/hpxoPFGQU+jxPQS8Ci0GgbZOxXKpuU+58mJuEmkw5i5AJmHL4rzGgiN/WXx2h8W1
 FnlrAkbMkmbGog4ghHxlIjDcs84lPYiDDgdULDRiXVas2dSn7VXtgr2xuKjfeh1NBwaG
 fMiA==
X-Gm-Message-State: AOAM533D/X/aCWmCFtXddwrWGPaRyIlf3J8Wd8wQtGM2qhx//qeOck4l
 Imd+0bvZVrylG+qRfHYvacfEl8L0T9U=
X-Google-Smtp-Source: ABdhPJzRndVMEA7K+LRLSUy/iH21kzjMnX4RcSIgh4FGiHtUpBD1MvAdYl7WVK5GrrYaAfCBJ4fqVQ==
X-Received: by 2002:adf:eb41:: with SMTP id u1mr10659131wrn.94.1602958059356; 
 Sat, 17 Oct 2020 11:07:39 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id v6sm3503342wrp.69.2020.10.17.11.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 11:07:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
Date: Sat, 17 Oct 2020 20:07:30 +0200
Message-Id: <20201017180731.1165871-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017180731.1165871-1-f4bug@amsat.org>
References: <20201017180731.1165871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace events for GPU and CPU IRQs.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.26.2


