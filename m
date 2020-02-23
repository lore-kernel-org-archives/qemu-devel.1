Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B287AC35670
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C200206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOetdeGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C200206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60k1-0004Gx-NQ
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:32:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j60ht-0001m4-93
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j60hs-0006by-58
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:30:41 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j60hr-0006b5-V4; Sun, 23 Feb 2020 18:30:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id n10so8287010wrm.1;
 Sun, 23 Feb 2020 15:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mmzX3h5HCvKUNKd1CHnk/esd8YbYWYAXpwuKwHJY+ek=;
 b=rOetdeGIusYkzeKGfDglgybHzfkxOhdY0XpSqhWDweL1AzzFgf0D1NFFdbrWBlSNxZ
 WNX+B+QR+m+dqnopKSR6p0/k1WdYRfC7WfLxACKvn574QE/MxTwj/xblPK6vJ4e+/4eb
 4/ujljPj9wo/njOevulI2MdVsouI05B7zELKWIRorCLq9MxuUnEKnDsFzvlAjXWV38of
 33g3NsRRLEfya+qNIT7TeczC9GiOx9CBQl/J/WkZmCO263DSxxOqwoCGvDoyRi6XVhwu
 Dl2kAOTuGHNXLQ1OUnBaDapJAlxF/Kz63x0tm82xk68Thl0joaPvvE7tFIgUOCQBwhCF
 ujow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mmzX3h5HCvKUNKd1CHnk/esd8YbYWYAXpwuKwHJY+ek=;
 b=kDl2/KxejZawn3krIAAlnmhfiDCLf+OaX/cCv97eUwUcq3ndB2EYdraUaC0ZLpyNQe
 GGmZiLlZw11fxWRQ/NG8okW9s2LcwLTSp/0lvl5WPQdJBfecLonet+B08u2zuEe3GQEZ
 4nFP0xIzBAx5e95Q+6kqfYdZnBvGKU1eSJXwqXJN4h/g72vH01UIAVSavH7bxG8uTleU
 ecXCnacGIeCrjwUJPDbqlRC/pNd6Ipa8k1Yz6dxl1SQOjeL+1yMpOo8cGQeCosbvnIxY
 +/ZH/UTjs1FLwT1wT9r81WKi3zs5+C8Bn0Nbwe4WAFLIJ3Zj4bTsWVlTgvRcKo7fOhev
 uEqw==
X-Gm-Message-State: APjAAAXd8WkG2LABKVUwT8m18YvbJH4DTrnyrXKydt4COLSvQ1niqIoQ
 59AQ/ZgvRN5qz5RtAL2pEh+h5EyVymI=
X-Google-Smtp-Source: APXvYqxPkMprcNMloDLoVymPoGO1iE4iDt7D580xVcFy6z1HCjFFfLG+C9W4skzBBQjU4bi9hYUbsg==
X-Received: by 2002:adf:f7c6:: with SMTP id a6mr65563822wrq.164.1582500638714; 
 Sun, 23 Feb 2020 15:30:38 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id j11sm15322117wmi.3.2020.02.23.15.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 15:30:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 2/2] hw/arm/integratorcp: Map a CFI parallel flash
Date: Mon, 24 Feb 2020 00:30:33 +0100
Message-Id: <20200223233033.15371-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200223233033.15371-1-f4bug@amsat.org>
References: <20200223233033.15371-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel displays errors why trying to detect the flash:

  Linux version 4.16.0 (linus@genomnajs) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #142 PREEMPT Wed May 9 13:24:55 CEST 2018
  CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
  CPU: VIVT data cache, VIVT instruction cache
  OF: fdt: Machine model: ARM Integrator/CP
  ...
  of-flash 24000000.flash: Integrator/CP flash protection
  of-flash 24000000.flash: do_map_probe() failed for type cfi_probe
  of-flash 24000000.flash: do_map_probe() failed

Since we have a CFI pflash model available, wire it.
The kernel properly detects it:

  of-flash 24000000.flash: Integrator/CP flash protection
  24000000.flash: Found 1 x32 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
  Intel/Sharp Extended Query Table at 0x0031
  Using buffer write method

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Kconfig change was not committed

RFC because I have no idea of the flash model, its ID code, and which
default CFI family (1 or 2).
---
 hw/arm/integratorcp.c | 11 +++++++++++
 hw/arm/Kconfig        |  1 +
 2 files changed, 12 insertions(+)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 59804140cd..40cedfd55a 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -24,6 +25,7 @@
 #include "hw/char/pl011.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
+#include "hw/block/flash.h"
 
 #define TYPE_INTEGRATOR_CM "integrator_core"
 #define INTEGRATOR_CM(obj) \
@@ -589,6 +591,7 @@ static void integratorcp_init(MachineState *machine)
     MemoryRegion *ram_alias = g_new(MemoryRegion, 1);
     qemu_irq pic[32];
     DeviceState *dev, *sic, *icp;
+    DriveInfo *dinfo;
     int i;
 
     cpuobj = object_new(machine->cpu_type);
@@ -646,6 +649,14 @@ static void integratorcp_init(MachineState *machine)
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDIN, 0));
     sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
 
+    dinfo = drive_get(IF_PFLASH, 0, 0);
+    if (!pflash_cfi01_register(0x24000000, "pflash", 16 * MiB,
+                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
+                               64 * KiB, 4, 0, 0, 0, 0, 0)) {
+        error_report("Error registering flash memory");
+        exit(1);
+    }
+
     if (nd_table[0].used)
         smc91c111_init(&nd_table[0], 0xc8000000, pic[27]);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 61635f52c4..7f179f960f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -73,6 +73,7 @@ config INTEGRATOR
     select PL050 # keyboard/mouse
     select PL110 # pl111 LCD controller
     select PL181 # display
+    select PFLASH_CFI01
     select SMC91C111
 
 config MAINSTONE
-- 
2.21.1


