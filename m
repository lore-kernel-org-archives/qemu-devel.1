Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DDEC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9922620829
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI0P0bmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9922620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH5oe-0006cx-Po
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 09:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lw-0001qn-SI; Sat, 12 Sep 2020 09:40:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lv-0007rZ-0L; Sat, 12 Sep 2020 09:40:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id c18so14076849wrm.9;
 Sat, 12 Sep 2020 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5jonLkEs0bfAQb56MWErimOd7AbsJVnkd4i01BNhPLw=;
 b=tI0P0bmrLxrX57L1IDZSIKcu56JJVbF+8DbAneZ+thrh2Jgayed6PtWT5lFu5teUpE
 OLZfA9qnpvno1CLUhnDVziuV0pdnfuJQ6k3TLktzVzXJEh0MHmcJrv/CVFLFjQiZiMvd
 dMg/w9eDE+CLJ2WdWt+S2X1XRawranqRlWDCVThag+l4TVbuAZkpP4+ackHe84nI9WJF
 Y1pc0hkg977W0JWaKODRz8+JPuTs/S+vSH9gK+CUfNtFzDU+M/5VDCzhNaFUO1ry8ydx
 qnvk2uivMAkBQss8CNZ+KBVy0eggPm1tWFWFM+qfZKMhZcEOSm3oN2v9kBfhWhpjoQGl
 I+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5jonLkEs0bfAQb56MWErimOd7AbsJVnkd4i01BNhPLw=;
 b=iHXO0YwkpCj+txKAOrgdV4RTOa/5180plQYX5fU73FsAicRSQkuj5lGcrUOHx9/AYI
 7zK0lkMlioswcqBrEoeKSAYUgvxw8+5I+FmMJPAunHTJBLxvKt3I1CUA0dEsX7/KGmHF
 m6chavQ4S7Ay3NS1CD0kelWtL5Cdw/5t0Q+JXbMryRacCNFDz5u/woAxDt1l8K8fPNds
 fVJwSGp3TIIZCudRryIYdGpJBwyLiPxXtKKSd4MpWrj27fuz0gq+7wpTPngyecaQpFnq
 fhtajGzU/ACZTBRShGoCRh4mbsuFeLcFUl9wvS89cDGBt9WNZCo4kanpvq2x41einadj
 5pgA==
X-Gm-Message-State: AOAM531HOarM9k2v54bd95AV87PrL//1wCHxwK2nF0nl/d47jPk1ktZo
 C8ZYpWPByyUeUUQ+NWv1xlvzA/g9/mQ=
X-Google-Smtp-Source: ABdhPJxhWP0JKUptI2SmQz/OShye0bsqZuRq+MbseRg1L5BdOEfDt+RogckwOpbUDq24vz/q8OwajA==
X-Received: by 2002:a5d:4e0f:: with SMTP id p15mr6936109wrt.155.1599918053110; 
 Sat, 12 Sep 2020 06:40:53 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm10309144wmg.44.2020.09.12.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 06:40:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 6/7] hw/misc/mps2-scc: Use the LED device
Date: Sat, 12 Sep 2020 15:40:40 +0200
Message-Id: <20200912134041.946260-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912134041.946260-1-f4bug@amsat.org>
References: <20200912134041.946260-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
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

This replaces the 'mps2_scc_leds' trace events by the generic
'led_set_intensity' event.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/misc/mps2-scc.h |  2 ++
 hw/misc/mps2-scc.c         | 27 ++++++++++++++++-----------
 hw/misc/Kconfig            |  1 +
 hw/misc/trace-events       |  1 -
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/hw/misc/mps2-scc.h b/include/hw/misc/mps2-scc.h
index 445e268b1fd..0009479ae83 100644
--- a/include/hw/misc/mps2-scc.h
+++ b/include/hw/misc/mps2-scc.h
@@ -13,6 +13,7 @@
 #define MPS2_SCC_H
 
 #include "hw/sysbus.h"
+#include "hw/misc/led.h"
 #include "qom/object.h"
 
 #define TYPE_MPS2_SCC "mps2-scc"
@@ -28,6 +29,7 @@ struct MPS2SCC {
 
     /*< public >*/
     MemoryRegion iomem;
+    LEDState *led[8];
 
     uint32_t cfg0;
     uint32_t cfg1;
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 9d0909e7b35..ce1dfe93562 100644
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
+            led_set_state(s->led[i], extract32(value, i, 1));
+        }
         break;
     case A_CFGDATA_OUT:
         s->cfgdata_out = value;
@@ -236,6 +230,9 @@ static void mps2_scc_reset(DeviceState *dev)
     for (i = 0; i < NUM_OSCCLK; i++) {
         s->oscclk[i] = s->oscclk_reset[i];
     }
+    for (i = 0; i < ARRAY_SIZE(s->led); i++) {
+        device_cold_reset(DEVICE(s->led[i]));
+    }
 }
 
 static void mps2_scc_init(Object *obj)
@@ -249,6 +246,14 @@ static void mps2_scc_init(Object *obj)
 
 static void mps2_scc_realize(DeviceState *dev, Error **errp)
 {
+    MPS2SCC *s = MPS2_SCC(dev);
+
+    for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
+        char *name = g_strdup_printf("SCC LED%zu", i);
+        s->led[i] = led_create_simple(OBJECT(dev), GPIO_POLARITY_ACTIVE_HIGH,
+                                      LED_COLOR_GREEN, name);
+        g_free(name);
+    }
 }
 
 static const VMStateDescription mps2_scc_vmstate = {
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 0cecad45aad..7557a3e7b46 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,6 +97,7 @@ config MPS2_FPGAIO
 
 config MPS2_SCC
     bool
+    select LED
 
 config TZ_MPC
     bool
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 908272e8593..97f511aa58c 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -84,7 +84,6 @@ aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64
 mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_scc_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_scc_reset(void) "MPS2 SCC: reset"
-mps2_scc_leds(char led7, char led6, char led5, char led4, char led3, char led2, char led1, char led0) "MPS2 SCC LEDs: %c%c%c%c%c%c%c%c"
 mps2_scc_cfg_write(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config write: function %d device %d data 0x%" PRIx32
 mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config read: function %d device %d data 0x%" PRIx32
 
-- 
2.26.2


