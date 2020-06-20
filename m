Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669F0246EF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4xvfzZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669F0246EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmfK-0007Rp-Ma
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmaD-0007Dk-Ru; Sat, 20 Jun 2020 19:07:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmaC-0002Mu-1n; Sat, 20 Jun 2020 19:07:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id l10so13144705wrr.10;
 Sat, 20 Jun 2020 16:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iRQDsCaGbstPl2leufRUxE6mmev54DrPXBIJv8GpU9I=;
 b=c4xvfzZyfG+QNtJZMuNlZkc63tl1l5maSRo9RKUW+BK1bc6uFzssPcX4WaDmsbVskW
 VMawIC3lAXb3Ptrgpg8+zSq3MPLyjeeWc/fj6UBnhBr2+6r/kYuWF9EHD/vfvVh0ebN8
 knKV0PuGRQMsPoMMpRD7HEGGI6nSfBzfMQqaPizF/Z83N2AegA9o1+ZAvnGSKfwQUXuS
 20ga8LTksAcFAXfwhpcsHwsSzptRpPpSo7pDZODGSPCEqljwVG1TLpMJPRmyPJBNXUIT
 B3JTxFyH9Dt7q+DGykQYS6zHBP/X5rj/R3I5P9tJqfJikZTooXaQ98IM76mAic6DWbNZ
 V/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iRQDsCaGbstPl2leufRUxE6mmev54DrPXBIJv8GpU9I=;
 b=S/xSqjjwZR+QTBMABkUJ8KNdPel7lhT8pDBXkXZP6t7ztTqveND92R0d+EqLgpI+94
 zX/kHLneVq3Z9bd+4DpVVoC67aqpPYdbm0w9iTo8wZC9xPA3ukGYRbPyc4RDPv+ZP8W0
 3gCBxsGmyYX0LVsYI5ev9iGcCPO/e4OnO7A3ok7Y5b3DCGDH9KgMhOiRiZohW9foNVZp
 6S9Xsdwv9QDCFu8HBI6vUIrGB/kOQBU9CPIc3NVWBFZGeoIEhefuuwTv1UgbbnsH2cGw
 60th8UIjdYHIAavwpMl7ip5ejwaIan+AfDBj3aYSvBJ4BojWFKVmwblLDbg242wi9RBd
 Tjfg==
X-Gm-Message-State: AOAM532rcwYuuoc/dzmIxaWwKuJycuIPBBASpqy8OJDoo5d4lhnfYnN6
 C2DklLW11QQLjpNEE+Vc356bcO2n
X-Google-Smtp-Source: ABdhPJwV8hIOSd0q181rY0A5eLseezbMdmJEFrPYScCZKBppOuMc4rn/DNTTY05+WawPAsQVJF/45Q==
X-Received: by 2002:adf:bb02:: with SMTP id r2mr11613908wrg.143.1592694450151; 
 Sat, 20 Jun 2020 16:07:30 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o82sm11455037wmo.40.2020.06.20.16.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 16:07:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/7] hw/misc/mps2-scc: Use the LED device
Date: Sun, 21 Jun 2020 01:07:18 +0200
Message-Id: <20200620230719.32139-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620230719.32139-1-f4bug@amsat.org>
References: <20200620230719.32139-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the 'ARM MPS2 and MPS2+ FPGA Prototyping Boards Technical
Reference Manual' (100112_0200_07_en):

  2.1  Overview of the MPS2 and MPS2+ hardware

       The MPS2 and MPS2+ FPGA Prototyping Boards contain the
       following components and interfaces:

       * User switches and user LEDs:

         - Two green LEDs and two push buttons that connect to
           the FPGA.
         - Eight green LEDs and one 8-way dip switch that connect
           to the MCC.

Add the 8 LEDs connected to the MCC.

This remplaces the 'mps2_scc_leds' trace events by the generic
'led_set_intensity' event.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
https://youtu.be/l9kD70uPchk?t=288
---
 include/hw/misc/mps2-scc.h |  1 +
 hw/misc/mps2-scc.c         | 23 ++++++++++++-----------
 hw/misc/Kconfig            |  1 +
 hw/misc/trace-events       |  1 -
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/hw/misc/mps2-scc.h b/include/hw/misc/mps2-scc.h
index 7045473788..29e12b832b 100644
--- a/include/hw/misc/mps2-scc.h
+++ b/include/hw/misc/mps2-scc.h
@@ -25,6 +25,7 @@ typedef struct {
 
     /*< public >*/
     MemoryRegion iomem;
+    DeviceState *led[8];
 
     uint32_t cfg0;
     uint32_t cfg1;
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 9d0909e7b3..2e59a382ec 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -20,11 +20,13 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 #include "trace.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
+#include "hw/misc/led.h"
 #include "hw/qdev-properties.h"
 
 REG32(CFG0, 0)
@@ -152,18 +154,10 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
         s->cfg0 = value;
         break;
     case A_CFG1:
-        /* CFG1 bits [7:0] control the board LEDs. We don't currently have
-         * a mechanism for displaying this graphically, so use a trace event.
-         */
-        trace_mps2_scc_leds(value & 0x80 ? '*' : '.',
-                            value & 0x40 ? '*' : '.',
-                            value & 0x20 ? '*' : '.',
-                            value & 0x10 ? '*' : '.',
-                            value & 0x08 ? '*' : '.',
-                            value & 0x04 ? '*' : '.',
-                            value & 0x02 ? '*' : '.',
-                            value & 0x01 ? '*' : '.');
         s->cfg1 = value;
+        for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
+            led_set_state(LED(s->led[i]), !!extract32(value, i, 1));
+        }
         break;
     case A_CFGDATA_OUT:
         s->cfgdata_out = value;
@@ -245,6 +239,13 @@ static void mps2_scc_init(Object *obj)
 
     memory_region_init_io(&s->iomem, obj, &mps2_scc_ops, s, "mps2-scc", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
+
+    for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
+        char *name = g_strdup_printf("SCC LED%zu", i);
+        s->led[i] = create_led(obj, LED_COLOR_GREEN,
+                               name, LED_RESET_INTENSITY_ACTIVE_HIGH);
+        g_free(name);
+    }
 }
 
 static void mps2_scc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 889757731b..f278f7f354 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,6 +97,7 @@ config MPS2_FPGAIO
 
 config MPS2_SCC
     bool
+    select LED
 
 config TZ_MPC
     bool
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 8bc7a675e8..490a0f341a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -81,7 +81,6 @@ aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64
 mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_scc_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_scc_reset(void) "MPS2 SCC: reset"
-mps2_scc_leds(char led7, char led6, char led5, char led4, char led3, char led2, char led1, char led0) "MPS2 SCC LEDs: %c%c%c%c%c%c%c%c"
 mps2_scc_cfg_write(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config write: function %d device %d data 0x%" PRIx32
 mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config read: function %d device %d data 0x%" PRIx32
 
-- 
2.21.3


