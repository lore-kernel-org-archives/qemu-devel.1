Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7D2207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFqJzO0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7D2207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYPk-00065z-1C
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtYOo-0005Xx-0D; Thu, 09 Jul 2020 11:23:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtYOk-0001lj-EW; Thu, 09 Jul 2020 11:23:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id j18so2282316wmi.3;
 Thu, 09 Jul 2020 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LuF+C5cF6VHL6bfWO5MRQe0ZzHmgVYS8GhF2dPRIe7U=;
 b=IFqJzO0HnKTV+DVqaOT0KJfYC3VhRP1cbAcAnD8ZqLnKPcLgX98N0s8gmNroI2Kd19
 hc1fkgGHqjedDb9+XCGZcxR+7PRN1u+BJYGY1CMED2uoswIdKFB6Yk1U7XBhoHyRnEhG
 UTcRe7cyvgwdCrqVLNEmTnrClzXOBvgND4s5K4qxqY/ykYEBDA42kOWYhjT6WjAU2h2F
 OfP/modk818kP5yW5novwbbe9bXSE/pzX6E8H4OvWYgA9f0c/gN7RJuiYzCyLh3CABg3
 1o4OYtk8u3380nh//LaqsABLrgNunDBisyw9+6ttA+DDTihHZdJ7VRQYidrL4vHuqTGo
 QDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=LuF+C5cF6VHL6bfWO5MRQe0ZzHmgVYS8GhF2dPRIe7U=;
 b=aUrOvYKKIRiUUf3KFDfX6Wg1yZrIfzLK7cobeaZO79DVtGL+7EEUSbVp7/4eDmulHS
 p+SJi2PNyfG9TQ1SsE9UAdYbRSLUXlnwwC/k2WKr2bdmuTuf9TIbbHP8aUcIBZAGDrNw
 Ftb+v2oQs5hQHuzJXAVIoEHxlvofDe8wY9CBMsbPX3iM0w9zhasKFIV9Bix5hkvfONO0
 OTbCNSpeWM9/DzAsLZgd4XVuBwxeD+RzZtrGnPFM9RFS75EIfsxeDggcjdoRz8q48Wgm
 P1qf3mSr43EwnLwazIWpDr0oZXeelAZ6XEcHnlYM5y/DnrDmtT/dt4wjeAmTJWAjBMt8
 F7CA==
X-Gm-Message-State: AOAM532mUC6WE1g4lBtjMXRwlA3RAD4sTmAt9HhI8U+vL/WvbuVjZw2g
 to/WeDw4h/rhe6iQF1i6e6mwYdNeXDo=
X-Google-Smtp-Source: ABdhPJwRGEF79M8I6/Ut8nUsYzYU7vqvJ5aJdw7njXPom4itKjTBsOjMOrLKTh5sGB26s1d+wHdkoA==
X-Received: by 2002:a1c:5646:: with SMTP id k67mr549252wmb.61.1594308219580;
 Thu, 09 Jul 2020 08:23:39 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 1sm4916107wmf.0.2020.07.09.08.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 08:23:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/cpu/a9mpcore: Verify the machine use Cortex-A9 cores
Date: Thu,  9 Jul 2020 17:23:37 +0200
Message-Id: <20200709152337.15533-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Rob Herring <robh@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Randy Yates <yates@ieee.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'Cortex-A9MPCore internal peripheral' block can only be
used with Cortex A5 and A9 cores. As we don't model the A5
yet, simply check the machine cpu core is a Cortex A9. If
not return an error.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/cpu/a9mpcore.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 642363d2f4..1724baf17c 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -15,6 +15,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
+#include "cpu.h"
 
 #define A9_GIC_NUM_PRIORITY_BITS    5
 
@@ -53,8 +54,18 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
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
     sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err);
@@ -73,7 +84,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
      */
-    cpuobj = OBJECT(qemu_get_cpu(0));
     has_el3 = object_property_find(cpuobj, "has_el3", NULL) &&
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
-- 
2.21.3


