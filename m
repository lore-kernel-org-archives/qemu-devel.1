Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF120CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65D9205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M40LfjeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65D9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgxl-0000WR-Nh
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyT-000089-28
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyR-00017v-OS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyR-00017K-IG
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id p21so2101721wmg.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DYAw+JFUSShxadh7hIyLKy0VSgftJwrYe33MmrE6aTY=;
 b=M40LfjeEYv2ob6JYDv4HpJ/kowyBFQpxUwA4Yh4uXOzaII8oNUBzU5WfS2JX2FBqOd
 qzdtQmxkZ2oZtnhnCxx3ULaLKttk1VYBBZVJ5oTh1tX+hLKL1R/37wp6ceFntQ708XSK
 gpGUKTxYfea32s051YKpoVHDUhQl/lFUNB/0EZy4tosgb5SqZC9RNzD92n4OOKd6ST9Q
 nEZK/8dU9lM8J5Qsfoshe4ZysBrFqwH60a6FdGsTQNUv9IPPBLjNBGZkGaVStX6lGZzn
 VUb2Bi+rBASHieUXli2JxqHHlpt3Rh9QAPth1Ci6zh6WSPXCT/NqWnzkHjjL4m9ZtwYD
 yJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DYAw+JFUSShxadh7hIyLKy0VSgftJwrYe33MmrE6aTY=;
 b=d5eklWd9rI8yj5lKFudvMQq6AbZS2dml9K2fd6gKioOzLosyPGpwPCcj5YOLZ0Qm3X
 i8nmyk4TMwFoZ6MiUmYPxwbplNWWGIinGR/LFYyl5G36YBfShQCfH5qPhOyGrvKuPpWT
 KS7radd0UXZ0p0Y37XmcCW72214dgO9l6zv4Mv9/1A9uBd0YTrZZeQ570ncCIxIUzqQA
 KbRghGCwwZTrCyM0uCBAhGRK3yyL0acQ0BpVM9sUWh5mWmk6+9qsqjqF+NvHxgF642Fp
 zRoROKtAlZ+RsR9NvXPeC7C/adYekJU2vjXkkGnDPlqO5mRZfbf6vdKtEWsbHklCf9HM
 NXMQ==
X-Gm-Message-State: APjAAAVXMM98ohEaBqnZd7P4banI3U0rENNSerlXTldcl3GOuUg9ydlm
 Qwmk6RtLtRG23F+Vokb9233ckMBMnL4=
X-Google-Smtp-Source: APXvYqwIydKvpv1tjnbZN9F1ekRR2EO+V9YsgDB7BSIRSEQi2zWwNNwlNULytMuoWI4eUgzyGxCYhQ==
X-Received: by 2002:a1c:7917:: with SMTP id l23mr5276198wme.60.1571934509184; 
 Thu, 24 Oct 2019 09:28:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/51] hw/arm/bcm2836: Rename cpus[] as cpu[].core
Date: Thu, 24 Oct 2019 17:27:22 +0100
Message-Id: <20191024162724.31675-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

As we are going to add more core-specific fields, add a 'cpu'
structure and move the ARMCPU field there as 'core'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191019234715.25750-7-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2836.h |  4 +++-
 hw/arm/bcm2836.c         | 26 ++++++++++++++------------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 97187f72be9..92a6544816b 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -35,7 +35,9 @@ typedef struct BCM283XState {
     char *cpu_type;
     uint32_t enabled_cpus;
 
-    ARMCPU cpus[BCM283X_NCPUS];
+    struct {
+        ARMCPU core;
+    } cpu[BCM283X_NCPUS];
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
 } BCM283XState;
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 019e67b9068..221ff068956 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -51,8 +51,9 @@ static void bcm2836_init(Object *obj)
     int n;
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
-        object_initialize_child(obj, "cpu[*]", &s->cpus[n], sizeof(s->cpus[n]),
-                                info->cpu_type, &error_abort, NULL);
+        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
+                                sizeof(s->cpu[n].core), info->cpu_type,
+                                &error_abort, NULL);
     }
 
     sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
@@ -122,10 +123,10 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
         /* TODO: this should be converted to a property of ARM_CPU */
-        s->cpus[n].mp_affinity = (info->clusterid << 8) | n;
+        s->cpu[n].core.mp_affinity = (info->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
-        object_property_set_int(OBJECT(&s->cpus[n]),
+        object_property_set_int(OBJECT(&s->cpu[n].core),
                                 info->peri_base,
                                 "reset-cbar", &err);
         if (err) {
@@ -134,14 +135,15 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         }
 
         /* start powered off if not enabled */
-        object_property_set_bool(OBJECT(&s->cpus[n]), n >= s->enabled_cpus,
+        object_property_set_bool(OBJECT(&s->cpu[n].core), n >= s->enabled_cpus,
                                  "start-powered-off", &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
 
-        object_property_set_bool(OBJECT(&s->cpus[n]), true, "realized", &err);
+        object_property_set_bool(OBJECT(&s->cpu[n].core), true,
+                                 "realized", &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -149,18 +151,18 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
         /* Connect irq/fiq outputs from the interrupt controller. */
         qdev_connect_gpio_out_named(DEVICE(&s->control), "irq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpus[n]), ARM_CPU_IRQ));
+                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_IRQ));
         qdev_connect_gpio_out_named(DEVICE(&s->control), "fiq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpus[n]), ARM_CPU_FIQ));
+                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_FIQ));
 
         /* Connect timers from the CPU to the interrupt controller */
-        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_PHYS,
+        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_PHYS,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpnsirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_VIRT,
+        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_VIRT,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntvirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_HYP,
+        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_HYP,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cnthpirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpus[n]), GTIMER_SEC,
+        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
     }
 }
-- 
2.20.1


