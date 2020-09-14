Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA14C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F942074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qh/FQTPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F942074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpHE-0007xR-7k
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8V-00035D-FY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8T-0007cZ-Hg
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:07:15 -0400
Received: by mail-wr1-x42e.google.com with SMTP id e16so18928909wrm.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=t7GgsIy/CKDFP2Rw0R3wmNWViXiOV67C9XbYARPcce0=;
 b=qh/FQTPFSDZmo6X7AM3S0XLPrL0wo+WRZZ9mIq9cl9x7aigfG4W/+FFNilFe6mOIVd
 Yhsc0Y61vZxbIoggYinDzAD8YCshDWcc/ks2iQ06Yu6Eb5CBXvGYTvJ5oe1I7DTvWMmP
 soq1r93aoQDNzORR7h9lGKIQTU3zY+HEMlrPKNLQtcCmElQ6e8ULPFwvq0kzLxG+5mNX
 rabhiG7T3GG9WR/qe3m+J2H/rJkypBORqsNmkDy6uW0PCpscZnns1m9sIDYCEmEp3cLh
 eU91pP7G5qrvdXJGFvkBOIemUJ7oB0THGdSQaTmLm65PbIx0/ovhlYtL2pq923EAtxku
 jYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t7GgsIy/CKDFP2Rw0R3wmNWViXiOV67C9XbYARPcce0=;
 b=b9Jfb4p9jOsMrjuZLAQNG+rfXcGzQMyiiy49wwJgJ+9N7gzQgdEcJngCx6sCaKpLbP
 egQhYMi1/Rc8RCU47WMhh1zehXwSVULvXWysRpzwYJng6hRfi4DqV44SIjwNOwe+L0GM
 xJ4FHrASSzuMJAqcFggKDvD4dDmnzAe4PT6ooNz/Bj9tT63Ms/6wxc4A2PxajIZtGBZo
 3EqFQdOt4RlA/jzGCOVNTLtZ/1d19SzLhmh+rkHa40rlW10Xn0aEudPICVpthdlSL7pK
 KMAZMxbojuhhFxdsLN4f0r3WkqDyNsbGMC0TMFA23YIflLWV2nIdof1cLC6ZlojoFobS
 x0zg==
X-Gm-Message-State: AOAM533js+Bw1T6cYrbGCRTYOOw4DitWXWV06IZburO3puDvqwnbaIT9
 rX5b1wnGyLjxDa+JdTTcXxT0OL1V7+m9WXnO
X-Google-Smtp-Source: ABdhPJwAurgwM0J/3UbKuFVoKTExKrC3u+6GTLhZWmxWiwlhiVpMpwswfdTWWlYzARVylf6u0wpSGA==
X-Received: by 2002:adf:b306:: with SMTP id j6mr15443875wrd.279.1600092431823; 
 Mon, 14 Sep 2020 07:07:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.07.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:07:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/36] hw/arm: Load -bios image as a boot ROM for npcm7xx
Date: Mon, 14 Sep 2020 15:06:30 +0100
Message-Id: <20200914140641.21369-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Havard Skinnemoen <hskinnemoen@google.com>

If a -bios option is specified on the command line, load the image into
the internal ROM memory region, which contains the first instructions
run by the CPU after reset.

If -bios is not specified, the vbootrom included with qemu is loaded by
default.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-id: 20200911052101.2602693-8-hskinnemoen@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx_boards.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 939391c3a3c..b4c772d6b52 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -19,12 +19,42 @@
 #include "exec/address-spaces.h"
 #include "hw/arm/npcm7xx.h"
 #include "hw/core/cpu.h"
+#include "hw/loader.h"
 #include "qapi/error.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
+#include "sysemu/sysemu.h"
 
 #define NPCM750_EVB_POWER_ON_STRAPS 0x00001ff7
 #define QUANTA_GSJ_POWER_ON_STRAPS 0x00001fff
 
+static const char npcm7xx_default_bootrom[] = "npcm7xx_bootrom.bin";
+
+static void npcm7xx_load_bootrom(MachineState *machine, NPCM7xxState *soc)
+{
+    g_autofree char *filename = NULL;
+    int ret;
+
+    if (!bios_name) {
+        bios_name = npcm7xx_default_bootrom;
+    }
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (!filename) {
+        error_report("Could not find ROM image '%s'", bios_name);
+        if (!machine->kernel_filename) {
+            /* We can't boot without a bootrom or a kernel image. */
+            exit(1);
+        }
+        return;
+    }
+    ret = load_image_mr(filename, &soc->irom);
+    if (ret < 0) {
+        error_report("Failed to load ROM image '%s'", filename);
+        exit(1);
+    }
+}
+
 static void npcm7xx_connect_dram(NPCM7xxState *soc, MemoryRegion *dram)
 {
     memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, dram);
@@ -61,6 +91,7 @@ static void npcm750_evb_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
+    npcm7xx_load_bootrom(machine, soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
@@ -72,6 +103,7 @@ static void quanta_gsj_init(MachineState *machine)
     npcm7xx_connect_dram(soc, machine->ram);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
+    npcm7xx_load_bootrom(machine, soc);
     npcm7xx_load_kernel(machine, soc);
 }
 
-- 
2.20.1


