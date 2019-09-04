Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE48C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A7B2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhUAS8ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A7B2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Yz7-000061-2a
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqc-0001YD-Hj
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqb-00075V-25
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqa-000751-S2; Wed, 04 Sep 2019 13:13:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id r195so4717954wme.2;
 Wed, 04 Sep 2019 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rh2gl72em/tjXVFRsaWM/1jTRmVaVLHat+KG0haXObM=;
 b=lhUAS8ekgrhb2YBCg6uJiK0BpLMJlzFP5Y4tplYbjP7LLo9u1IeBqnnbOlq4R0akTe
 4HI/fFR2/wX3bfd+7Asbrtf3w5CnTDhsE1pd1VD0DqXvHlTTB2NeIp87ByEgqW3MpT0X
 jsXMlfF0Yi3eDrqF4K4+fERR+lqPUsXr8r2RSKQoadaeVFICqGEEL+5XhyhBgGTdUZf2
 YUQBNU22/67yTP12ZII2BaR0Cofh0+kLTBWu7Y5mQbt41ihGyEwyfxXn9icn1MfI0juX
 Ynh9iVpD/exBwF12nBFMUXTL0Xg/Ps48/uES7Zk7HG0owdWMZ0rHuXPbmsGXQugyw2vO
 sufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rh2gl72em/tjXVFRsaWM/1jTRmVaVLHat+KG0haXObM=;
 b=mkSUnQDP/HqCoc5cSEpGXY8hPhUI2okOVEteIs+M1UkK+kdmwnfLf4ijVB4xW6+KDW
 zjhIdeDsjm4uccmIo48gj/JViFIb5A8jRCNaDAAvQVnC6JCd1NNIpe281SYjBDV2V1R2
 jUHidJ58kqs9q0KdLOf6cXkySTE6t0NMBnyaZvOfGlwIzjtgdFAlRGqtZdbvYErfbBzW
 H2iF7Co/EuTmBydHPRiq1xSWSporaHPJzjglaKtQWK6j36spMV9gQJapygSVLx8W/3DR
 U9Q907Puja608u/Xy29eJvbWKpMXOAWI21YGYw5tium7zSt4J5onReIHD7nYHkrHPgr8
 0mpg==
X-Gm-Message-State: APjAAAW3MKjIKDsbSCrjbmMkDD20+6KqqdTEsWYDFKGs7jhUbEghMzO7
 wnurGF/V1OcHRgVtHOa6A5A=
X-Google-Smtp-Source: APXvYqz4fkbLPQxYcZXgFFK4U7kI2lCstCrBXaq1TWOm3de6s15rtHEGSg5OSpbVcasgfxg9YW3E5A==
X-Received: by 2002:a1c:ca0b:: with SMTP id a11mr4788910wmg.87.1567617211973; 
 Wed, 04 Sep 2019 10:13:31 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:09 +0200
Message-Id: <20190904171315.8354-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 08/14] hw/arm/bcm2836: Make the SoC code modular
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This file creates the BCM2836/BCM2837 blocks.
The biggest differences with the BCM2838 we are going to add, are
the base addresses of the interrupt controller and the peripherals.
Add these addresses in the BCM283XInfo structure to make this
block more modular. Remove the MCORE_OFFSET offset as it is
not useful and rather confusing.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2836.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 493a913f89..019e67b906 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -16,15 +16,11 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 
-/* Peripheral base address seen by the CPU */
-#define BCM2836_PERI_BASE       0x3F000000
-
-/* "QA7" (Pi2) interrupt controller and mailboxes etc. */
-#define BCM2836_CONTROL_BASE    0x40000000
-
 struct BCM283XInfo {
     const char *name;
     const char *cpu_type;
+    hwaddr peri_base; /* Peripheral base address seen by the CPU */
+    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
     int clusterid;
 };
 
@@ -32,12 +28,16 @@ static const BCM283XInfo bcm283x_socs[] = {
     {
         .name = TYPE_BCM2836,
         .cpu_type = ARM_CPU_TYPE_NAME("cortex-a7"),
+        .peri_base = 0x3f000000,
+        .ctrl_base = 0x40000000,
         .clusterid = 0xf,
     },
 #ifdef TARGET_AARCH64
     {
         .name = TYPE_BCM2837,
         .cpu_type = ARM_CPU_TYPE_NAME("cortex-a53"),
+        .peri_base = 0x3f000000,
+        .ctrl_base = 0x40000000,
         .clusterid = 0x0,
     },
 #endif
@@ -104,7 +104,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
-                            BCM2836_PERI_BASE, 1);
+                            info->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
@@ -113,7 +113,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, BCM2836_CONTROL_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, info->ctrl_base);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
@@ -126,7 +126,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpus[n]),
-                                BCM2836_PERI_BASE + MCORE_OFFSET,
+                                info->peri_base,
                                 "reset-cbar", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.20.1


