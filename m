Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34811C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3945207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIDFg/il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3945207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5FK-0007kF-6s
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58k-00084a-ME; Tue, 16 Jun 2020 02:32:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58j-0003Mp-38; Tue, 16 Jun 2020 02:32:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so1724103wmj.0;
 Mon, 15 Jun 2020 23:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YSemiN4fbL6V0zVgew+3sXrasP2DCRMVckmXdCuQt0Q=;
 b=rIDFg/ilVdF18P/muCtqY2rGWKrLtSdARF1XIyJZhfyKw68ALtIaXRBbefq5eIS/pN
 KcMAyFKiME8ibiIV8rmURcD6ha5u3Y9PXL2bLuA/D82rY4fwExp2LJt49gPkKB1eDgcf
 hj8pKJ1e5Nn0YA88iS0kW5g3IXdTLq48fdUD0NA+effKSzyTG5byKKCTQXTbniL3JpS2
 1TBsVf+KpP1RQhYnsO1TtzCkueO0Y1rnLhFYqr2FzmoF+4FPYwmzNk3pei+qhLxEC5gc
 NkbNVu1T8i4+Eqt/KaGkM6jUSBvF/db3YfqgfiU+VXpI8C9xrrwIcNhuRLhmyL3zmPlj
 bXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YSemiN4fbL6V0zVgew+3sXrasP2DCRMVckmXdCuQt0Q=;
 b=riwRADmysHHvZlbdi+wtjrdEoqY2IcjnaDd7plL+cxigGMHb7lnGpGwFGlfO5LdfIb
 FDwepOUCJ6A7zY+xkxzDQPUxad6nPrxR1W814eJk9WZpZptNArD80DrlTsZ6EgTBNWsJ
 r4EozAo3r6I+UF4SLhTlOtxeGVYC5hDWKmSth6PVz9g0M4NHsGR1AyCTEnhmihqCtgjb
 TaGdCoGBFhyvjdJxLM88IL5mkM/GsBxZHE2UeLDjT0VgVoIuKiSHY54/eGGkBtqlkQlZ
 VMlhd4eT9q5jt0+e4PIyHeMyYsnU1UszroBcjun0pHzA591conXJPp9zjNSpENIwt+r2
 wMAw==
X-Gm-Message-State: AOAM5319pZ21+nRXWJ5NA7dW0L8yheAAz2RLygawVqgv0PmSXTBNe7+r
 CMFwnf/iyokJJdNOMyotKB2LfvTd
X-Google-Smtp-Source: ABdhPJxxgHEQNQ2LBe0zTFb7hlj7T+WX7pCJkCYySyoCnuCUOAq/D0Zw3YqPydNNq8hScoShj9CDTg==
X-Received: by 2002:a1c:59c7:: with SMTP id n190mr1453521wmb.61.1592289127191; 
 Mon, 15 Jun 2020 23:32:07 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t188sm2483250wmt.27.2020.06.15.23.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:32:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] hw/misc/mps2-fpgaio: Implement push-buttons
Date: Tue, 16 Jun 2020 08:31:57 +0200
Message-Id: <20200616063157.16389-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616063157.16389-1-f4bug@amsat.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The FPGA system control block has 2 push-buttons labelled PB0/PB1.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/mps2-fpgaio.h |  1 +
 hw/misc/mps2-fpgaio.c         | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.h
index 69e265cd4b..521900ae81 100644
--- a/include/hw/misc/mps2-fpgaio.h
+++ b/include/hw/misc/mps2-fpgaio.h
@@ -34,6 +34,7 @@ typedef struct {
     MemoryRegion iomem;
 
     uint32_t led0;
+    uint32_t button;
     uint32_t prescale;
     uint32_t misc;
 
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 2f3fbeef34..655e7a14fc 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "hw/sysbus.h"
@@ -36,6 +37,13 @@ REG32(PRESCALE, 0x1c)
 REG32(PSCNTR, 0x20)
 REG32(MISC, 0x4c)
 
+static void mps2_fpgaio_push_button(void *opaque, int irq, int level)
+{
+    MPS2FPGAIO *s = MPS2_FPGAIO(opaque);
+
+    s->button = deposit32(s->button, irq, 1, level);
+}
+
 static uint32_t counter_from_tickoff(int64_t now, int64_t tick_offset, int frq)
 {
     return muldiv64(now - tick_offset, frq, NANOSECONDS_PER_SECOND);
@@ -131,7 +139,7 @@ static uint64_t mps2_fpgaio_read(void *opaque, hwaddr offset, unsigned size)
         /* User-pressable board buttons. We don't model that, so just return
          * zeroes.
          */
-        r = 0;
+        r = s->button;
         break;
     case A_PRESCALE:
         r = s->prescale;
@@ -232,6 +240,7 @@ static void mps2_fpgaio_reset(DeviceState *dev)
 
     trace_mps2_fpgaio_reset();
     s->led0 = 0;
+    s->button = 0;
     s->prescale = 0;
     s->misc = 0;
     s->clk1hz_tick_offset = tickoff_from_counter(now, 0, 1);
@@ -249,6 +258,8 @@ static void mps2_fpgaio_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &mps2_fpgaio_ops, s,
                           "mps2-fpgaio", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
+
+    qdev_init_gpio_in_named(DEVICE(s), mps2_fpgaio_push_button, "PB", 2);
 }
 
 static bool mps2_fpgaio_counters_needed(void *opaque)
-- 
2.21.3


