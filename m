Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C4F207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnMKUCej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C4F207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR6q-0007Xe-Bc
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzn-0002qt-F2; Wed, 17 Jun 2020 01:52:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzl-0004TM-US; Wed, 17 Jun 2020 01:52:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id b82so603337wmb.1;
 Tue, 16 Jun 2020 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I3W9cifnD7DOZZ455FCgCr8VTTmTQL8v0YMmJYG05f0=;
 b=AnMKUCejKyYOV4Abe+F6mS+gWkYrGV7kuhz3seyz+H6W2Cbj2cfc+RQ0UPjkKLOPWx
 ewXOvGjOzESReAdVCDI6VX++TqhTsClUfuSPXUvefyUWSqlcgohVbhkxgJq3TTF+KitY
 fufWD5P5zI2aVhXQlBjw250HW3ASJMG9hQy3wnzQvvY4q6/CW5AJismwkLMvADDZoFZp
 J3DM2y81CRfZmT+Dt98AIC8koiMns3juwzuVaRjPwHwEYpQD3+YOhaueVO/QoSS8+s2Q
 9uwwoPVdUKsTdCc4TtX3LgEcu50+xud9O3MtE2UEfCptxRGe7rMN5XMxvNDMHdt3KUg3
 5WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=I3W9cifnD7DOZZ455FCgCr8VTTmTQL8v0YMmJYG05f0=;
 b=uY6u9mwsVXU0TZykY0e0Sb798s+wRRkmMfkhVIBRYWpOee7ojLBkWSZpn/OC+FKLNg
 BS4wELTISuBiABwHk5auVxV2unnR6YIH3le5qhn4nTYcDN6LdErsIvFi3rMSS6mfGcge
 8ao6Cb6Q0lbJbH50m68nmGejy2U16t9AA4HPWB8djyhiXwuGPQTuNivE5Rmwtx9TD1B3
 r0j7V5CSdYk9+qblwOJdNWQDKe7y89cr4le9PwIMvt6fCxS/4rLN/rZtvizr3uXx6okE
 lFIRrbT/Rvu7xQQuj6HCGacgNKNgC1AtD6POlP5D/p+Tm8zxNZ5yuRaEMPu1QFk42vPO
 Oncw==
X-Gm-Message-State: AOAM533dqbj0Nu+kly4sr4OYd0O03f4V4yWWhLIb0S3D8AV+Vt17uYoA
 m/93e/utKDI/TrNP8amHY5B7YuHu
X-Google-Smtp-Source: ABdhPJz+9soz5V1sYOZjeDQ16ZdccX7WKWPfc9dtQK7CaNEDUHj0vd5matdFdfbLjbeRmYSokKoOkw==
X-Received: by 2002:a1c:8107:: with SMTP id c7mr6717423wmd.20.1592373139029;
 Tue, 16 Jun 2020 22:52:19 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d28sm3000809wrc.50.2020.06.16.22.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 22:52:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/14] hw/arm/mps2: Map the FPGA I/O block
Date: Wed, 17 Jun 2020 07:52:01 +0200
Message-Id: <20200617055205.3576-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617055205.3576-1-f4bug@amsat.org>
References: <20200617055205.3576-1-f4bug@amsat.org>
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: 25MHz prescale-clk property
---
 hw/arm/mps2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index c66c595d4a..e106123225 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -38,8 +38,10 @@
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
+#include "hw/misc/mps2-fpgaio.h"
 #include "hw/net/lan9118.h"
 #include "net/net.h"
+#include "hw/watchdog/cmsdk-apb-watchdog.h"
 
 typedef enum MPS2FPGAType {
     FPGA_AN385,
@@ -67,8 +69,10 @@ typedef struct {
     MemoryRegion sram;
     /* FPGA APB subsystem */
     MPS2SCC scc;
+    MPS2FPGAIO fpgaio;
     /* CMSDK APB subsystem */
     CMSDKAPBDualTimer dualtimer;
+    CMSDKAPBWatchdog watchdog;
 } MPS2MachineState;
 
 #define TYPE_MPS2_MACHINE "mps2"
@@ -332,6 +336,11 @@ static void mps2_common_init(MachineState *machine)
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
     sysbus_realize(SYS_BUS_DEVICE(&mms->scc), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(sccdev), 0, 0x4002f000);
+    object_initialize_child(OBJECT(mms), "fpgaio",
+                            &mms->fpgaio, TYPE_MPS2_FPGAIO);
+    qdev_prop_set_uint32(DEVICE(&mms->fpgaio), "prescale-clk", 25000000);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->fpgaio), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
-- 
2.21.3


