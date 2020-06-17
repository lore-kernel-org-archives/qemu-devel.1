Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA38C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF65220786
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1IfjuLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF65220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSTO-0006cu-3H
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSE-0004ZT-Mg; Wed, 17 Jun 2020 03:25:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSD-0002aZ-44; Wed, 17 Jun 2020 03:25:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id p5so1137082wrw.9;
 Wed, 17 Jun 2020 00:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f5UdY4wcwM/YDfreLoFIdRkVZV4JAe25gaC3NdeFF78=;
 b=H1IfjuLWQTDg0N99YnplsF4EZGUHHX69/g1UTqIgv/4Ldcb/ndFj1jEWtqU/OKPY8z
 tgRYlT/3KAWvwU8m1IFr7vCsi+t19ml2pk4Jts0J7ZAZYuGBMo4+KAp0xovEg5wzONlg
 5IdduSS3fgCFY9Hraf/RnpBWg+5aC4JeN/zAX+Zhz9oNEU2dzgrY7DruiczuQ/+y5flW
 z9F/nY+kcFUh4I81Kkp+XU8goTITUFq+vNLRGyBGGqgoeYCCz0aBITTu2AX8kfvtFlVt
 EtltFpkaL+BPB45JBYlUFNiMEEa+fNCzBvCNmyrhGQiOMd74vcPYnos35T89TPGMkO9T
 einQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f5UdY4wcwM/YDfreLoFIdRkVZV4JAe25gaC3NdeFF78=;
 b=DB2oQgJodwF70rA+NSX7uwHIvQ8vsbaFAyYrIUkp9JeStgyx11Y5Mq3h43+Hk//HWF
 FYjt6kt18VmA77nARFOrYljXvXqEWS7RDmvkR6HeRm8z+cQ9AqAnkS0dNpY+Va9xVnfj
 7eB0H/YR3V/6//n8XtBTUP3RhhpaNkDYshgTGa5q1RIjRRKOdO8H4joFMu6TsnxxKyJH
 Zz5Ck8qYRInq1OwJ6dLtHQdoYJiPTfFfavkpQfrMIIs+Hii4XXI11EUjCNm1Wlhq4cnR
 /8ojHF/cE6yhNsHSE/t6QNwHiFsBVHhHC8oFrfjJ086ck5Ss+3ZkAmgEmR9wb2paVyai
 Ouuw==
X-Gm-Message-State: AOAM533e5a7Re0c9bSbFWe491WXXN+48fF4i0OWWmiGYHG0YfCRKYQxZ
 nyaabG0AZS/JCEt1No8eKnN5y9II
X-Google-Smtp-Source: ABdhPJwlhXXUzwNLOdbUx1yRlAlrggodNtho2d5Ml1UGaiOr0f4HmtFgS9ZBTyPXzstsgGb4mMG5jg==
X-Received: by 2002:adf:c385:: with SMTP id p5mr7084454wrf.409.1592378747212; 
 Wed, 17 Jun 2020 00:25:47 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/14] hw/arm: Use TYPE_VERSATILE_I2C instead of hardcoded
 string
Date: Wed, 17 Jun 2020 09:25:30 +0200
Message-Id: <20200617072539.32686-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using the TYPE_* definitions for devices, we can:
 - quickly find where devices are used with 'git-grep'
 - easily rename a device (one-line change).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/realview.c    | 3 ++-
 hw/arm/versatilepb.c | 3 ++-
 hw/arm/vexpress.c    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index f3c00fe00c..b6c0a1adb9 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -26,6 +26,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
@@ -282,7 +283,7 @@ static void realview_init(MachineState *machine,
         }
     }
 
-    dev = sysbus_create_simple("versatile_i2c", 0x10002000, NULL);
+    dev = sysbus_create_simple(TYPE_VERSATILE_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_create_slave(i2c, "ds1338", 0x68);
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 2ebdcbd8ac..e596b8170f 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -18,6 +18,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/i2c.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/irq.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
@@ -314,7 +315,7 @@ static void versatile_init(MachineState *machine, int board_id)
     /* Add PL031 Real Time Clock. */
     sysbus_create_simple("pl031", 0x101e8000, pic[10]);
 
-    dev = sysbus_create_simple("versatile_i2c", 0x10002000, NULL);
+    dev = sysbus_create_simple(TYPE_VERSATILE_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_create_slave(i2c, "ds1338", 0x68);
 
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 7ca5d523a4..24d656e653 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -42,6 +42,7 @@
 #include "hw/char/pl011.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/cpu/a15mpcore.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
@@ -640,7 +641,7 @@ static void vexpress_common_init(MachineState *machine)
     sysbus_create_simple("sp804", map[VE_TIMER01], pic[2]);
     sysbus_create_simple("sp804", map[VE_TIMER23], pic[3]);
 
-    dev = sysbus_create_simple("versatile_i2c", map[VE_SERIALDVI], NULL);
+    dev = sysbus_create_simple(TYPE_VERSATILE_I2C, map[VE_SERIALDVI], NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
     i2c_create_slave(i2c, "sii9022", 0x39);
 
-- 
2.21.3


