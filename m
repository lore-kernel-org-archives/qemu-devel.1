Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA6C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26711207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXz6++ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26711207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCui-00065z-8r
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCsy-0004LU-IR; Sun, 20 Sep 2020 23:53:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCsx-0002zY-23; Sun, 20 Sep 2020 23:53:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id q9so10701963wmj.2;
 Sun, 20 Sep 2020 20:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dcCXq9EmDF/ND5OQIcbMSYGFUbh9qfqOjQv8VK2LW0A=;
 b=ZXz6++ulUuofMXLwMdkIFvVYbVfptOwYGMHDECsZA2fVY/cXk4fKyoqg8+K8RGdTVV
 WMFFpIPcfH3iP4DO1Gzeo3RY1gpQrkwrzpUc27+vRG03RExbSU/QWPUpwpu5N+pnYky5
 dchThiTyq1ovWX4xeYh6Qz0Sc30T09qD49SAUacGFsqaMHY7HBrMMc1UpPUGoA1Nq7Mt
 d8FhUvZcyF3qojmnUC6gTXJypfbIi1m2iuWi5p5AEKIp6lAan2FV0G3668A3Tkrr+0ZK
 jPvp0qaYollresdg8LSy2rxK5IGt/3Rn66drq2WT5eXUre5vkSj7zS8qtSzGwEPFI9i1
 galg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dcCXq9EmDF/ND5OQIcbMSYGFUbh9qfqOjQv8VK2LW0A=;
 b=djpNlScLbbQkNACaULGzjUm4BwhTfmyF959u710laNaw2Pzcz5FM57WjeaQzKPWzjS
 oA/AP05fDWUlcCMjRXVSPukyegupQdjFvhi83skQzMg+rQXV8npl7nI3lz3PwH3n8lad
 pIKrEKMkhgUJJK+R86NCwe9nfYbg8pHOzXT7N5FH1xPs8u44+msgnYnHEJFG3+AjQLaI
 JOyUyBPFGMpjubqEfThppKGZHvYKnKo9i9e10GAKZ8/6KQgoFb6JnVtjAZSzGOGJU7oc
 3IgilE1x1jcLYxJFPgsO1mLdnqVhjiWlc6B+YsUNbNj/P69pimr1scvX/8q6M/73WuCq
 TJyw==
X-Gm-Message-State: AOAM531Y64IbMNQbZf5QR8760nJ5q195wDsjJrPjnvcJ194yQbjnAR3X
 jypFbsjSLirUTIQ1xNTbXjEvEAuU5K8=
X-Google-Smtp-Source: ABdhPJwRl3Z5WIikTR6gR38co3WDSTZo81ph0bORf7hpIY/ds2mvi4K2+q+lEmrWAxcDsY8qPqIWYA==
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr27599378wmc.21.1600660381007; 
 Sun, 20 Sep 2020 20:53:01 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a17sm19633754wra.24.2020.09.20.20.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 20:53:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
Date: Mon, 21 Sep 2020 05:52:53 +0200
Message-Id: <20200921035257.434532-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921035257.434532-1-f4bug@amsat.org>
References: <20200921035257.434532-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace events for GPU and CPU IRQs.

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


