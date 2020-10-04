Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61948C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 19:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66E72067C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 19:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66E72067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP9vS-0005sm-RP
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 15:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kP9tD-0004ga-6D
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 15:41:47 -0400
Received: from mail-oln040092005022.outbound.protection.outlook.com
 ([40.92.5.22]:16337 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kP9tA-0002OH-RV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 15:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIKdxDa5DF5NUKyskCsyyvYVJ0CaQxRjmkSOX4IgqmIRa5r9Y3FEmlxg+MK5uQGEULqKasRX04UbPMUWM+vq4j7gVOonsLVa+DaGeEtDDyqZ2EnR8hNqVt9AP1ArFzqUMHamknM/Xuv34D9tzLx2CGhEis26E9Q5mf9cH7NELFV2uq5Zy66DBa923BA5OyqGskzviUI2zUlNcIiQsvcpy0jCmwpPvQ57aV5dkHorxnv3+4ED2U+na5tlGfL3Ud36ucMaLEmwLhWv1dX7RbXIm0gxrFFxMXzq+0fkfqfHZ7s+icG/vRqXVi3AkQJiYhSSbM6QoDjsxjF0FXBqsOjNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX1yhj6Z9v9guQF2F49tFwe8tyg6RM8XT+wAkrokJP8=;
 b=PrSbUmxI77eaEEF5BRuQdnxLtt58Jex7gKthTFnTEUTUpxDdi2IA/T23WpLUXDIMRruBeRef5wHdELJ/WQQh9fYWwEeh0I7b0oZHYzCYMniKHHiQgCD2jv2geGlosGSa1y8qPIe1GCtXgV5Xw7QY1lHv7iJaEtEtHix31hB7fFfhgLBYKjoEya81tiH2JYjYCbA3bPW0+IJgYVm3r8PaOBTWBKYmZANqX2fdFNJu3O+na/6ycdBVsO1FJJCxOgTr0tRCJ7E/buurHHELmiMQouNfZC9ImBQUCAHNzAJ9t+k7AboKR45fwr9q1EaYKEi68tEh478EoFJVzx13597xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX1yhj6Z9v9guQF2F49tFwe8tyg6RM8XT+wAkrokJP8=;
 b=KitaJWcBAwzy/MF3s20n4LrUnL1NRt78NN/B3ezt01A5TJ5puFHMvrrMvzZyrawiBkO4MD/kKJ04Dk7IXsSE6htl6QRoH8CvEbwxoOhYWJjKwo0qtNX5BIpMcp3V0qj7j3d66qazpDQuKBZ9knOYG1zM6FrJVFGJ2W0uzm8CRpZ8qsbFJQbE4AMzAlpkenBvYQemEeS1Y4otgj2zShnCnca9AKAazagcuH4LWPMp56xx+KJM7c0b1vHYVZiPiK1CVHM2zZCetFW/5SE1mtCcYxqqll4C7iU1nqJZAlgZkgepZg20s/Q/9AeEYMsn7ax79hryihWjoBCtvtOmqpTbvA==
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (10.152.74.51) by CY1NAM02HT133.eop-nam02.prod.protection.outlook.com
 (10.152.74.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Sun, 4 Oct
 2020 13:17:12 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:7e45::46) by CY1NAM02FT032.mail.protection.outlook.com
 (2a01:111:e400:7e45::440) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39 via Frontend
 Transport; Sun, 4 Oct 2020 13:17:12 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0B7C4579C71F04FA11BA76ECCAF4EB84F2326FE28B6071D847F95C125284AF3D;
 UpperCasedChecksum:59D5932625202A5960C23E9788837ECBC4BB35818071071463DF8D106539B1FA;
 SizeAsReceived:7334; Count:44
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.043; Sun, 4 Oct 2020
 13:17:12 +0000
From: Heecheol Yang <heecheol.yang@outlook.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] hw/avr: Add limited support for avr gpio registers
Date: Sun,  4 Oct 2020 13:16:56 +0000
Message-ID: <DM6PR16MB2473130E0A6A463C43B66AF0E60F0@DM6PR16MB2473.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [L9NH89I+/nPrTLQIfTbHGvVgIo96nPFR]
X-ClientProxiedBy: SLXP216CA0069.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:5::31) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <20201004131656.1769361-1-heecheol.yang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (121.168.203.43) by
 SLXP216CA0069.KORP216.PROD.OUTLOOK.COM (2603:1096:100:5::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 13:17:10 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 93cd8605-6b7f-4d62-7ccd-08d86867cdb4
X-MS-Exchange-SLBlob-MailProps: pt8ZUcDWjMVYzmKoUTWUfl6Wc0xRL3YCXLEIsALcjTjI++D1is3Z8QSfWbcHNCqLUgLaMnTSQEWujfqzGX3799uqVY9vQUQTNHXytJtuKAKqSDHid/Sn7IV9PU8NPIPzbzPGfB8/CY8xcvW2Jk5AyHSOhxo1Ts6EdHNVKbTbHsRW7uSsnQ2Z4J9gVgHWwgDmC+pk+tGlXQerdb8Jz2Nqaw9eEtBiKsiijRsCmeDbq2UYxL9vIrzH0qeHkMo07wFdeMLBEiumY8drOo5ZV7f/8/2fqiLpWBrHADi63W0yA1HJZ025ASq/cLLmfa75JY0HReuekaROqIiUxnh3ukU4eIo/gyToSucWQ0RHOld6xx03HrbnJtkmvmahUHnbQT3Dut4eNCs2ginz7LfckZUhiedj8ExQqplBrfb9vpENqsXoWMnY8AIPIa+drvEId6sHfafZ/yjEl/660CfDjj1QIEDZsLKKaD4BUtLDLYsvFfNrsfXZaA4JqlIJHNForXtn5+FPvVA+5Sl+C7sDxHyb2Gyd7D0M1lSWCQ3XdWs/oWcdjZT8ivL1Nma5SJ7J/16JaTXqS68DEA7tDmFdRbAgP6emx1BWLxhUNicDLHSyaVfusIMY7YUNz39YkMfQPUIFYjqW32BjDlfiUSH4bPyjDwK92BpWpZ/18n9rSLQSvY3rBfNPZ6uFPo9tHgHrrOfifcJXKQZCZwOi+MblGOkoK3cbPay8/r9+al+M3x8IFcLEr7kw1hJoc9k4eQpKpUFXNIuQvaMmAz/lSc2yvyq8adAAsXsWwrt86YO8MmoPNGWYsG40fMcQyaU4qYLdp1fZJzN3T32m4N2jWoFYYoB7zh03x00gu29yvOWWh0lLBexE4vNwiSIYyZAFPdW4ROYQuujmFdmEmBCsvvGDdDm07YoDiCuF76Ys8m1IAp6Bxe0acpzUCfYgOvdyG203g5wc
X-MS-TrafficTypeDiagnostic: CY1NAM02HT133:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyNEAQUnYzEQ4LRKrsyVdGl7d2Gi0TT+JHxPXXM/O794MiLOYsSba9kXN5hEkFUnj/4S/BTwKaLF/XT08Z+XC70bb0vzX7+8/ZGWNvFHEpCethXatYGEUXotV+otKEglGenEaJCoVio56OIImHczFcfN2Suob5u4U1iNMoQgdY8rxEc7yb/eeQIUcJj+MLNFMNEj5Ik9uTog+zzEjRBs7u8IyIi1waBT3FGH5n6bu4mtkfrl/4+OLuyJBf4aI6Wg
X-MS-Exchange-AntiSpam-MessageData: yCON7KPdnMZ9YXB04a/1zI/Y9ZKIhVoYKIwZ+C4o4OjDKFHzWfSjLWpvmnZgXpsyxV/LshH2f+zea39fRPaxCkGQQgKPWNxuryMSe4iQDJBtD4yemW23eB7Saeyt81BC2eYv5orPG44eP0HljQJ7ew==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cd8605-6b7f-4d62-7ccd-08d86867cdb4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 13:17:12.1439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1NAM02HT133
Received-SPF: pass client-ip=40.92.5.22;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 15:41:43
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

Add some of these features for avr gpio:

  - GPIO I/O : PORTx registers
  - Data Direction : DDRx registers

Following things are not supported yet:
  - PINx registers
  - MCUR registers
  - Even though read/write for DDRx registers are
    implemented, actual direction controls are not
    supported yet.

Signed-off-by: Heecheol Yang <heecheol.yang@outlook.com>
---
 hw/avr/Kconfig             |   1 +
 hw/avr/atmega.c            |   7 ++-
 hw/avr/atmega.h            |   2 +
 hw/gpio/Kconfig            |   3 +
 hw/gpio/avr_gpio.c         | 112 +++++++++++++++++++++++++++++++++++++
 hw/gpio/meson.build        |   2 +
 include/hw/gpio/avr_gpio.h |  46 +++++++++++++++
 7 files changed, 171 insertions(+), 2 deletions(-)
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
index 0000000000..6ca8e8703a
--- /dev/null
+++ b/hw/gpio/avr_gpio.c
@@ -0,0 +1,112 @@
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
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "hw/gpio/avr_gpio.h"
+#include "hw/qdev-properties.h"
+
+static void avr_gpio_reset(DeviceState *dev)
+{
+    AVRGPIOState *gpio = AVR_GPIO(dev);
+    gpio->ddr_val = 0u;
+    gpio->port_val = 0u;
+}
+static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    AVRGPIOState *s = (AVRGPIOState *)opaque;
+    switch (offset) {
+    case GPIO_PIN:
+        /* Not implemented yet */
+        break;
+    case GPIO_DDR:
+        return s->ddr_val;
+        break;
+    case GPIO_PORT:
+        return s->port_val;
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
+    switch (offset) {
+    case GPIO_PIN:
+        /* Not implemented yet */
+        break;
+    case GPIO_DDR:
+        s->ddr_val = value & 0xF;
+        break;
+    case GPIO_PORT:
+        s->port_val = value & 0xF;
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
+    memory_region_init_io(&s->mmio, obj, &avr_gpio_ops, s, TYPE_AVR_GPIO, 3);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+static void avr_gpio_realize(DeviceState *dev, Error **errp)
+{
+    avr_gpio_reset(dev);
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
index 0000000000..84d783f8fc
--- /dev/null
+++ b/include/hw/gpio/avr_gpio.h
@@ -0,0 +1,46 @@
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
+
+struct AVRGPIOState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+
+    uint8_t ddr_val;
+    uint8_t port_val;
+
+};
+
+#endif /* AVR_GPIO_H */
-- 
2.17.1


