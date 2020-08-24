Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F31C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC3B206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPZt7m8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC3B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA96H-00067I-6a
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95O-0004Qj-6L
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95M-0004lj-IG
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id p17so2325966wrj.8
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nnYvgpj+yfRsy7MXb9YbrfpjgfASX8TYRFoNG96nT04=;
 b=aPZt7m8JkaQvwbTXMevz23ilxf0f13elevH6ENQ0HyhGa4QSrpjGH3rs3/hmTvBnoP
 peHdLzndhRCsOHq6jw0mhL3Rku0X+K74hT538BkqZIzcSIWHIKv7hG60O1bQLEBpPm7/
 k9YOmsHXHrx/WxHDagNlI2UvWkF54wGtMsxy3mL+swUyKIcKsCovGKhU82f1Bfc3+lkt
 wKmSOccLxYcktp8JHLJi/6OuNgcWKieLUWpCd00opCcyJcPIcmvBXZcpuIJnTLB3zwJO
 pIbOU9spdoDPb6XIlT+iqAbETejpaLkHo9rj0WHAjEvupyz3Ig4YqR6AaPixFak/sKgJ
 mKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nnYvgpj+yfRsy7MXb9YbrfpjgfASX8TYRFoNG96nT04=;
 b=YIH8s0q8X9zkMaEaW8abB1MXh5QJxtjrpv+9h6BfGzWjj/1sORIuTOMVumd9YVbtUX
 vinOJpq6n+C+mZTLsSuFzEVlv4TDo2ZDmpCmiYd+91rVf17seCZ8xS0IOgyc+/Zue4To
 8aC3cnCawv0MG+JwcWlH4Aa9eo8sIlYF6ZpHbyemkJbkL3W8/OwCLVrngqKO9prdAIpi
 qw+dwiSQdiKeUErc2/O4s9gkqKQqtyMuC7c4Px2LhmItSjnxeoykpUvvTpeLpjlZey2F
 3QMFqMH9H7igagtj8cfE+IV+ce++MpsCo0hZeLOoZv0a+bPka/YwVCii8sBCf38ibqMz
 PG2w==
X-Gm-Message-State: AOAM531AvDCABfynlkuJBFEdycnKTR+m3LvL6FfRYv57UcuugyE1XC3r
 DLKPjK5SIr4SNYk37Y7QDX7POJWHBaXsu6vB
X-Google-Smtp-Source: ABdhPJxHGG/Y4o7bQF12Sih+oJWcyZ97XuTtHHhmNWVQEHJoyrVPoQFjtCwWqPo6T/eOHyfTMcenSA==
X-Received: by 2002:a5d:6806:: with SMTP id w6mr3775560wru.395.1598262494827; 
 Mon, 24 Aug 2020 02:48:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/27] hw/cpu/a9mpcore: Verify the machine use Cortex-A9 cores
Date: Mon, 24 Aug 2020 10:47:45 +0100
Message-Id: <20200824094811.15439-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

The 'Cortex-A9MPCore internal peripheral' block can only be
used with Cortex A5 and A9 cores. As we don't model the A5
yet, simply check the machine cpu core is a Cortex A9. If
not return an error.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200709152337.15533-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a9mpcore.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 351295e5187..ec186d49abd 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -15,6 +15,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
+#include "cpu.h"
 
 #define A9_GIC_NUM_PRIORITY_BITS    5
 
@@ -52,8 +53,18 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
                  *wdtbusdev;
     int i;
     bool has_el3;
+    CPUState *cpu0;
     Object *cpuobj;
 
+    cpu0 = qemu_get_cpu(0);
+    cpuobj = OBJECT(cpu0);
+    if (strcmp(object_get_typename(cpuobj), ARM_CPU_TYPE_NAME("cortex-a9"))) {
+        /* We might allow Cortex-A5 once we model it */
+        error_setg(errp,
+                   "Cortex-A9MPCore peripheral can only use Cortex-A9 CPU");
+        return;
+    }
+
     scudev = DEVICE(&s->scu);
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
@@ -70,7 +81,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
      */
-    cpuobj = OBJECT(qemu_get_cpu(0));
     has_el3 = object_property_find(cpuobj, "has_el3", NULL) &&
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
-- 
2.20.1


