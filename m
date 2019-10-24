Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3166BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EBA205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYmn6HIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EBA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgtw-0007kE-I5
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyQ-0008VX-Lv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyP-00017D-F3
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyP-00016u-86
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id p4so26810092wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PQl3KRLLMTqQVuIeb30pOMqlU1Q+h9n4TjUf1vQdg9c=;
 b=fYmn6HIBA7dRRro2xV4cZaHTLEOMMlxD0C0n7MgBh8Vj1ozFkfrm9+omC7HNvko6Ct
 fV9IKXMADK3BDdQhFS4hMaT+llFrDCF/zDtgxCCmjknjQ14g3DNh+oZUJ682o1yyeU3r
 B4iuZX6uTS+e+GteP3JlB+TexOrNIShgAvUSSs3sgqXQMd8J/niSFi2Sz/N1Rzbysg7C
 HmWROBDlZzptg+/0IjlZ+MsdbgD8x3vklM9yDBgLhR7vgkLqJsE5WRbq4C3Rgo0sGMHu
 ChZj6bIFOchgFhfD2K0INRgZAo6gY0NGF6kjDwgxv3Mr71lS8OalKecmKkIncRssAkFn
 H0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PQl3KRLLMTqQVuIeb30pOMqlU1Q+h9n4TjUf1vQdg9c=;
 b=kYWsVQjvx1afr6a0FXtSPS+j/WzV3LW6sVPm4P3tmSBn+Tyd6YoY1e39s3VQu6iNbM
 vb8Ik4tTbxxv4ZB3auAhPXF/KXrXSiTE5qkajUbzgM+90FvoyKbNV8i6hXZcg7pgYRGE
 DY2m+rhjKqReiCa8KL8ZGqf5OzYEUY4McM6wW8CVx7bIFwKDVgXeAtY26Wun0HDkc/9t
 rF6XOcK8wtcpXYYlaLH1bDBpJsIwLfQ9AQPPXTWIzTs5eazahoh1F5IgvuAA91IeaL6j
 D9XytH0BOiFpinurSERwV2bsesKw9Cxi09ONUKkSi3dZWR0kLQyEScYSxh4sRP6bLEU4
 lU0A==
X-Gm-Message-State: APjAAAUhI9NEhbdMUPNfvodjh/P5cbb/+4dX5u0iwD6tNbFHXOBiJA50
 QSlLg5+Yrg6vTOGky3EXdnubmXhjFbA=
X-Google-Smtp-Source: APXvYqwG0L67Q+K133w0CcBAr74CSaiB6KGmJqCtjYNfyH/b5jUG4geUNXsFeBR4hoAa7JjGNjBNUA==
X-Received: by 2002:adf:e850:: with SMTP id d16mr4459575wrn.251.1571934508049; 
 Thu, 24 Oct 2019 09:28:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/51] hw/arm/bcm2836: Make the SoC code modular
Date: Thu, 24 Oct 2019 17:27:21 +0100
Message-Id: <20191024162724.31675-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

This file creates the BCM2836/BCM2837 blocks.
The biggest differences with the BCM2838 we are going to add, are
the base addresses of the interrupt controller and the peripherals.
Add these addresses in the BCM283XInfo structure to make this
block more modular. Remove the MCORE_OFFSET offset as it is
not useful and rather confusing.

Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191019234715.25750-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2836.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 723aef6bf51..019e67b9068 100644
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
-                                BCM2836_PERI_BASE + MSYNC_OFFSET,
+                                info->peri_base,
                                 "reset-cbar", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.20.1


