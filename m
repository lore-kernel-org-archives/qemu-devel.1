Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D1FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF0620760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF0620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPneT-00042h-C3
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 10:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kPndr-0003cB-4Z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:08:35 -0400
Received: from mail-dm6nam10olkn2084.outbound.protection.outlook.com
 ([40.92.41.84]:45537 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kPndn-0002jw-H5
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jts1r/IK8Lg/3Gzgk3d2OeKBDVovnpl4hIHBbiI40Q3wW1MgN0pXz84GbQ5SI7orrjmgMQ1VT/irGncJvX1K1HY+mj2cim7HQm7SA+hhNPHppyZWDZ48lYCpBybyhWUBd/ivRcD7pehQl6InGUXBF4WGToyB1IeUVl2MvOUXpPf4WdkP1x1glB0s34oCHjuvdRP8Mc7Ln0JwIYk5qFhs+8vaB73iB+N9sQjrZIcIzXWU+17+43dKmvD2As8rd6owjCoYTKRghK7e2t/WaVCMLC2TvuG+mGkckhvoV3rh6Ch0J92hBv0DC1u0gDUPyulj9bX8u3xXzY/0ZBmmpLjQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHSL++clY26ZljRKkGlHHbNotnsmb9REPI4KMP9E70=;
 b=kSNxZhgen0u+88J5BJT814SdU+mD+oRGVWQz0YVJKJCptHA6sLwQXQpxdBCuSoqiWZoOkjzIU5W0WQCLYqWyX1BkC83iPt2P7awYQF658AAhsk0AIu3sOA/3Bxv5O0k18uWG+gHzGvlps8affZvjCQykUMh8+5Q9V7uQKJ8SHg6+aa+WAl+eJkcflIaGE6TaxUTjlulzwDl5uRz2YOUkfFA+z0Kh2vihHV1Iu9mQeDMjP3loMllxlTJCnMwjEOo2mQugpwvrt5humw0HJcCZveaV49Z0DspPdqyLANN0wMGwcXhJKsiOrfzKtS75TVhZWu/LMWMxxMQrd57PEUUWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHSL++clY26ZljRKkGlHHbNotnsmb9REPI4KMP9E70=;
 b=n9bI05x28vfMxDEd0VRuscrRH0nBFSUau0Ybt9RdPQuacjDSfJmPwd53VGOw9c0ZQmCwgCIjh3SYzwK2RHUWJIibSgX2nWYi5PXD5vptLj3RGpOHwho2HdRTg8OeOFzGbQGTCQJ39EWiLwETv+ist4Z+PjIU0qUWAd8faDf8V12uArxC8G/hJH3t4CSiQSqxQIrOi+e/dUYRxspaHPc4J1Q62jhpA41o/23b1vwIabcQmAB47cs4qFbeGkP5r00rwSb6MEo1x+iF4R/PAsbAyTN2ZfSf7qzV86lFFPGB5Q/FCze4OEhdJWBfy8qMYrla9f3F5/oI232O3vFacNNC6g==
Received: from MW2NAM10FT048.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e87::41) by
 MW2NAM10HT186.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e87::433)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 6 Oct
 2020 13:53:24 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:7e87::45) by MW2NAM10FT048.mail.protection.outlook.com
 (2a01:111:e400:7e87::98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Tue, 6 Oct 2020 13:53:24 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4C59048F81A9934AD731E3E6C3FA8D0CD105E3FCA410BB9A7B94C994C22BD297;
 UpperCasedChecksum:9AA1C0C91B2C3BF5F3BD84A103440C236AD06B130DCDEC343BFCA7835DF4E06F;
 SizeAsReceived:7358; Count:44
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.045; Tue, 6 Oct 2020
 13:53:24 +0000
From: Heecheol Yang <heecheol.yang@outlook.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5] hw/avr: Add limited support for avr gpio registers
Date: Tue,  6 Oct 2020 13:53:01 +0000
Message-ID: <DM6PR16MB2473681AE7F2EE705C7300A6E60D0@DM6PR16MB2473.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [2CWpHpMJ9YKRguKU42t2Z5FAmaMV9zNW]
X-ClientProxiedBy: SL2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::31) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <20201006135301.3562993-1-heecheol.yang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (121.168.203.43) by
 SL2PR01CA0019.apcprd01.prod.exchangelabs.com (2603:1096:100:41::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend
 Transport; Tue, 6 Oct 2020 13:53:23 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 8f39c99d-cb59-4998-c470-08d869ff317a
X-MS-Exchange-SLBlob-MailProps: pt8ZUcDWjMWFjT9o8F2tBFnS+dLvdtTEIPzBJhp34rTXJBMUG1DDgjjP3A/CUQDdme+XSBy9qkg4JXMX+UVwnQbh8GraH9juYDg2rlYW4nOVud9xcaY85YHzGNm9EBo9rUXQ0Rn4cSPyAoL5YpqLw0Uuy/XQEm3Y6Q4o/TqpWW+QHzLzqUk2/AUlxAjg1PtecYJ8b5ENzaCeEkidNWRhpBqGBrSN/wfNX68aAcWKVnFBC7k8/6/xAnIoRX1EhM4RTlpFwEBo5H3Tup0qTWdV/pVC2ZjzKvrQ8oUPpTYWNSHVnYeYyGhafOQLnh6qkNCJPC/15LT+nzUgTjGejil1StDTuk0XYgs7a5rX09TkaES0oF2NrH8qbN+V6AR9U5L/N8/3vNxUhuKa0bqvm+iPIEvIwR5FbqvNDSmSYVpSYO2dDSZjHf+h2UwwCWKRd3xBBsxOGRG5WjA3ka3A2LrSZFxU9HOHNTJipRo6oMruCwRXN4KYALJWRUQHMikJ22f9tTHgTLGw6sC1r0PH/m70zXkeZmpNW6B+yRSvYnsg0+g8mTmo2Y+UY2KoM2zkRe9C8jqV1FLV2MfkX+denQcqyyDlC6Tis23aUb1r1fJXhNM1PANfxiqj2B/Tgc1eRHVzOjFbsAOZAC1tbjYINs/kxkC2TOah2GJjUcALMYmwvASZJxlTKszRVc7Fjoo5Ol+vEN7Mbx2z+J5CAaDxmXJkDKbCU6HxVIfd2J0uXAaY+yWmpIMsezIR/Djn1Yl5MwAH7thtq0g4DhCrwXSgbXixee380nUrPCDMSsMyfsX1bQv27qjjkPGmi9PfbN5kg/4ZtlcwtftWEuH6xAiphTQbHk3/9BV7/sN4uP4vR/dyQNJZn89iKidOFJLjqYnPTpfC0PJa9stPtnEGJ2CYU2LEjdTqigZ/F8EPzdP4zAwDKu7jtH++UVQsFaqU3fejztTG
X-MS-TrafficTypeDiagnostic: MW2NAM10HT186:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDJJeQOK5Z/1IXqGw6JSDOXLe7OiqZrxVJFZvpgkGIm8rcWTkPxix2cCgGPDXolCj6fEMK/eRCEL01MNhoVkloXKE98fE/eFLl1LYE8LJ6qc21/bkQUogN50ddm/vqszn22FhzzV0y+2H7ClopaOG77q4rTxmqv/FZ6Uq3tztGcLMcmLuGbss80ZbkeyxITo9qzm4pS47T+7CZVYsehz6/9kCN69OUHoSy31ArGAhwQi9bDXOVyJ9bwWaer18SgR
X-MS-Exchange-AntiSpam-MessageData: I1DhF+pt4jfWofgL89SsIDpKT2Jy2Vj/qxyH6W4msefkoKt2n+VdSt0wFWqRofm9QoXW7WwKuEFziGWnYQ67pMrxaf1BVcz1Vm7zaWBbI36zTLRyaDjGYhmVw8ne7HKdcBhUmSN3WFShBTsRLqMGHQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f39c99d-cb59-4998-c470-08d869ff317a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2020 13:53:24.5898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM10FT048.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM10HT186
Received-SPF: pass client-ip=40.92.41.84;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 10:08:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Heecheol Yang <heecheol.yang@outlook.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some of these features for AVR GPIO:

  - GPIO I/O : PORTx registers
  - Data Direction : DDRx registers
  - DDRx toggling : PINx registers

Following things are not supported yet:
  - MCUR registers

Signed-off-by: Heecheol Yang <heecheol.yang@outlook.com>
---
 hw/avr/Kconfig             |   1 +
 hw/avr/atmega.c            |   7 +-
 hw/avr/atmega.h            |   2 +
 hw/gpio/Kconfig            |   3 +
 hw/gpio/avr_gpio.c         | 136 +++++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build        |   2 +
 include/hw/gpio/avr_gpio.h |  53 +++++++++++++++
 7 files changed, 202 insertions(+), 2 deletions(-)
 create mode 100644 hw/gpio/avr_gpio.c
 create mode 100644 include/hw/gpio/avr_gpio.h

diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index d31298c3cc..16a57ced11 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU
     select AVR_TIMER16
     select AVR_USART
     select AVR_POWER
+    select AVR_GPIO
 
 config ARDUINO
     select AVR_ATMEGA_MCU
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 44c6afebbb..ad942028fd 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error **errp)
             continue;
         }
         devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
-        create_unimplemented_device(devname,
-                                    OFFSET_DATA + mc->dev[idx].addr, 3);
+        object_initialize_child(OBJECT(dev), devname, &s->gpio[i],
+                                TYPE_AVR_GPIO);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+            OFFSET_DATA + mc->dev[idx].addr);
         g_free(devname);
     }
 
diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
index a99ee15c7e..e2289d5744 100644
--- a/hw/avr/atmega.h
+++ b/hw/avr/atmega.h
@@ -13,6 +13,7 @@
 
 #include "hw/char/avr_usart.h"
 #include "hw/timer/avr_timer16.h"
+#include "hw/gpio/avr_gpio.h"
 #include "hw/misc/avr_power.h"
 #include "target/avr/cpu.h"
 #include "qom/object.h"
@@ -44,6 +45,7 @@ struct AtmegaMcuState {
     DeviceState *io;
     AVRMaskState pwr[POWER_MAX];
     AVRUsartState usart[USART_MAX];
+    AVRGPIOState gpio[GPIO_MAX];
     AVRTimer16State timer[TIMER_MAX];
     uint64_t xtal_freq_hz;
 };
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index b6fdaa2586..1752d0ce56 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -10,3 +10,6 @@ config GPIO_KEY
 
 config SIFIVE_GPIO
     bool
+
+config AVR_GPIO
+    bool
diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c
new file mode 100644
index 0000000000..29e799670d
--- /dev/null
+++ b/hw/gpio/avr_gpio.c
@@ -0,0 +1,136 @@
+/*
+ * AVR processors GPIO registers emulation.
+ *
+ * Copyright (C) 2020 Heecheol Yang <heecheol.yang@outlook.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "hw/gpio/avr_gpio.h"
+#include "hw/qdev-properties.h"
+
+static void avr_gpio_reset(DeviceState *dev)
+{
+    AVRGPIOState *gpio = AVR_GPIO(dev);
+    gpio->reg.pin = 0u;
+    gpio->reg.ddr = 0u;
+    gpio->reg.port = 0u;
+}
+
+static void avr_gpio_write_port(AVRGPIOState *s, uint64_t value)
+{
+    uint8_t pin;
+    uint8_t cur_port_val = s->reg.port;
+    uint8_t cur_ddr_val = s->reg.ddr;
+
+    for (pin = 0u; pin < 8u ; pin++) {
+        uint8_t cur_port_pin_val = cur_port_val & 0x01u;
+        uint8_t cur_ddr_pin_val = cur_ddr_val & 0x01u;
+        uint8_t new_port_pin_val = value & 0x01u;
+
+        if (cur_ddr_pin_val && (cur_port_pin_val != new_port_pin_val)) {
+            qemu_set_irq(s->out[pin], new_port_pin_val);
+        }
+        cur_port_val >>= 1u;
+        cur_ddr_val >>= 1u;
+        value >>= 1u;
+    }
+    s->reg.port = value & s->reg.ddr;
+}
+static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    AVRGPIOState *s = (AVRGPIOState *)opaque;
+    switch (offset) {
+    case GPIO_PIN:
+        return s->reg.pin;
+    case GPIO_DDR:
+        return s->reg.ddr;
+    case GPIO_PORT:
+        return s->reg.port;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+    return 0;
+}
+
+static void avr_gpio_write(void *opaque, hwaddr offset, uint64_t value,
+                                unsigned int size)
+{
+    AVRGPIOState *s = (AVRGPIOState *)opaque;
+    value = value & 0xF;
+    switch (offset) {
+    case GPIO_PIN:
+        s->reg.pin = value;
+        s->reg.port ^= s->reg.pin;
+        break;
+    case GPIO_DDR:
+        s->reg.ddr = value;
+        break;
+    case GPIO_PORT:
+        avr_gpio_write_port(s, value);
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+static const MemoryRegionOps avr_gpio_ops = {
+    .read = avr_gpio_read,
+    .write = avr_gpio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void avr_gpio_init(Object *obj)
+{
+    AVRGPIOState *s = AVR_GPIO(obj);
+    qdev_init_gpio_out(DEVICE(obj), s->out, ARRAY_SIZE(s->out));
+    memory_region_init_io(&s->mmio, obj, &avr_gpio_ops, s, TYPE_AVR_GPIO, 3);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+static void avr_gpio_realize(DeviceState *dev, Error **errp)
+{
+    /* Do nothing currently */
+}
+
+
+static void avr_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = avr_gpio_reset;
+    dc->realize = avr_gpio_realize;
+}
+
+static const TypeInfo avr_gpio_info = {
+    .name          = TYPE_AVR_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AVRGPIOState),
+    .instance_init = avr_gpio_init,
+    .class_init    = avr_gpio_class_init,
+};
+
+static void avr_gpio_register_types(void)
+{
+    type_register_static(&avr_gpio_info);
+}
+
+type_init(avr_gpio_register_types)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 86cae9a0f3..258bd5dcfc 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
+
+softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true: files('avr_gpio.c'))
diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h
new file mode 100644
index 0000000000..498a7275f0
--- /dev/null
+++ b/include/hw/gpio/avr_gpio.h
@@ -0,0 +1,53 @@
+/*
+ * AVR processors GPIO registers definition.
+ *
+ * Copyright (C) 2020 Heecheol Yang <heecheol.yang@outlook.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef AVR_GPIO_H
+#define AVR_GPIO_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+/* Offsets of registers. */
+#define GPIO_PIN   0x00
+#define GPIO_DDR   0x01
+#define GPIO_PORT  0x02
+
+#define TYPE_AVR_GPIO "avr-gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)
+#define AVR_GPIO_COUNT 8
+
+struct AVRGPIOState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+
+    struct {
+        uint8_t pin;
+        uint8_t ddr;
+        uint8_t port;
+    } reg;
+
+    /* PORTx data changed IRQs */
+    qemu_irq out[8u];
+
+};
+
+#endif /* AVR_GPIO_H */
-- 
2.17.1


