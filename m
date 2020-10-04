Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D802C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 19:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E0F20637
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 19:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E0F20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP9ja-0000CY-P4
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 15:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kP9id-0008CA-R3
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 15:30:51 -0400
Received: from mail-bn8nam12olkn2069.outbound.protection.outlook.com
 ([40.92.21.69]:63073 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kP9ia-0001Ap-RU
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 15:30:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjoHUsTkq/carrxDiKOm/LN+f7Hf6vxXV4hMnm9Im+QDQoZTro04eYv2zUVdQy3vaDmlCNo2+6szLZmoVpkJ8QMk3B9mmDDBF13oryze71iSiYXjOclkIWhHOlfrMoITlnod0Me8wKsPLROQb0vZYJdjP4KVVGRAYu3WIs8yB9rL6ZZIuwtV+G4khZe6VSTTuAHhQS+HtsjBJi2NVXxstdfKxAswKfnk9FaXnKuvP9yx35WlHf1B6RFS13xxH2dPLGZ1Ta27mhBf6EaXKKTJ/bfREYokYklyc2bYKneAxD5CUc+2q0fieEhoVVU2+wP0B/P0hIr2cTBsQFx0vh6ZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX1yhj6Z9v9guQF2F49tFwe8tyg6RM8XT+wAkrokJP8=;
 b=k87wtKH4tjK/r8TqNJRNt9lR7NXGhsM6RZ59rj7CzyaWEPzY2vkxfo0u4iwalcmg7jQ8sFnw92DfFpXnf6O59oppRT35BRo/0YH9OVgmz75a6ZMhfPXAnrhwaGAGpCUbCrNTPWZ9Pwb+PghcRCAJgYNb875hvpibnPSlsgaLWuU4Uq1x7C+MT5UKqpFbWA6Ihl2lrCkH93MhB3vpJiQ884oDi/cIQbSHswpvNwSl4OcdTNlipYUvXWrOoMNN1yTdVkg7mHl1OnPlVBW45EPwmqi9M7l9EfVwAYbUMGCOLKL8KfHkO3n51XcJaoW11wmCeCzbE7Ebbn2hrqfpC+oABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX1yhj6Z9v9guQF2F49tFwe8tyg6RM8XT+wAkrokJP8=;
 b=izcQT3nzYoSaCGNdx6HPINJfN2XwpgZmyGmM06E3r0KeCbvdfP9d7n8O97/zuln9IYmL+tr7LDxtWl3vX86tgg5kbmrvIilUT6RzBpgQMv/uLsHcDMWWzuDZ7Dbt4Dt4hn6jD554qPBiwaKDprD8srR/+SZR6ywuvMuHP2JvkJM14hSpjuPUkt1odlEOkp1qSGyh3PcCMSgr28At/SVYqCbfrLwv3vZxGdJkkSDOUjpW3s3fQ13e9z/r+bbLSbBvQgUPNtlwehhEntAh8y0PZ4ky6DzSUcs/GgvSJVMywnQJ9RcP9GAh+e11wrI0IbvenDcFtxqsL0NuU6hJSSvHwQ==
Received: from BN8NAM12FT009.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::47) by
 BN8NAM12HT065.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::417)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.14; Sun, 4 Oct
 2020 05:07:02 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:fc66::4d) by BN8NAM12FT009.mail.protection.outlook.com
 (2a01:111:e400:fc66::242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend
 Transport; Sun, 4 Oct 2020 05:07:02 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A81F39AD0E1BBD6970C665E783AA3DB697AAB705B90F016F15552CE4657B6490;
 UpperCasedChecksum:584F692351C6AE5C30870A0385C3D0D568DF6821479372F87E66C158DC36F865;
 SizeAsReceived:7346; Count:44
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.039; Sun, 4 Oct 2020
 05:07:02 +0000
From: Heecheol Yang <heecheol.yang@outlook.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4] hw/avr: Add limited support for avr gpio registers
Date: Sun,  4 Oct 2020 05:06:39 +0000
Message-ID: <DM6PR16MB24739EA3E07AA842527C9814E60F0@DM6PR16MB2473.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [iMkePC/uDz9S3dYsfb5xDcnqJGJHi5tE]
X-ClientProxiedBy: SL2P216CA0038.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:1a::24) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <20201004050639.1471486-1-heecheol.yang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (121.168.203.43) by
 SL2P216CA0038.KORP216.PROD.OUTLOOK.COM (2603:1096:100:1a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Sun, 4 Oct 2020 05:07:00 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: f80c0722-bae9-44cb-c832-08d8682353c9
X-MS-Exchange-SLBlob-MailProps: pt8ZUcDWjMVYzmKoUTWUfuKqnf5IhFDNN7eMPuu4Ct0mHnPynYIxm26GXoSy1wTbg8Kn1MnOJU8CXso3zkzsra5czbWNNN+Rt4GZxgwdjf26s2NI/Hxjk5Ha7cLSpe7ODIoff4AI3d9nWg5BOokRneOkTWngd9lSLeraV+4eXZVpG9gRvOqehoUp+kei0V2PTuzx2iTNZOdAkYCuCS5MVdYcAGR5eZIemOTmo6LIDVPTxuw1nSAKyWVi6SpDOw3gBxWDoGNnAQP9mxULs8ZFnTuHf+xSMQYLaXxX9qXo0YTYrY71AH+iiDtQT+7Ov814849GAbRn8PuaW3th2/XzkaN985rohM1wUst3O+c+zlFM6F26PDD2lqs+z8DtyCpxQ4dd9Ccb2+VM0G5F7t1YE/9Hr3ySN75+oP11RSBAugqjETXBTxe++UNM4uaoEOmja/sjHUXcoW9yLuwQzGD7tAsPM1UQYZa4QEaa26S6nvTcseQmshxrk9al5tqhtGIZHBw+hHN+z47vNA2VXTzxyUidlyzoHOYzWu5ekL6/W7Ved5j8AVoZWRt4GqwTJ1U79qnV7UkU/voTDL4k2CEQ9CeTVY5gdQ3k2Y0/oVczcWItYKa0cmtsH25OebAFDdOBSickCE1nsZhn9HG6eNN99A87C9RtKQJne87xLY7B8hiT3HlsDpbl/+0lyzlWf2k9LknzP9rlzHry8rW2Ih5YtTzxytShBO7P9jCEy5NZZfTR6Gvb/uu+HR9JdY7qbkh3qXtGbpL/4RVFNC6ktluTDQhbNDF2am9tiU2zovA3ZMduEqnk24HicX5YdAraMcgHe5G4vqW+VB1mst8mxkNlL4se+EcDNnoDEZ/jR7mv8lkpPf4BuTgvqQAfXtj/RVDWIrTuQBCVRKlwBP/m+/5g/9YfVhYyNSkXG0PUzwr5XsNULWJHCDxVBYA1izj+Lc0T
X-MS-TrafficTypeDiagnostic: BN8NAM12HT065:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQcriJaDgeJFqctaPaHEaPywVwaUxt2q/odFZ7MjCIQzlb84zgW/73c9/MLCuClxrR0y/Gxv8ts+2o0pxKdtmQFpyp9UuMxfwf+xXi01pRkE568wf7V5ZKxwM+uVN7GUZqtyK0MlgnAYlQOVvUKYIhOjICyspE5g2obruOKGt8FvqtjXQGHHRoq6PxwurAH00pQz5ON7eTqv/EvgBDCy/oLb2L/G5/5TYoMFg/wG5o4vGbX/SKvc+8pTtsa/1pPW
X-MS-Exchange-AntiSpam-MessageData: CS+z50qheZbkX5a8vyXshpO/6b9UkpO+0vNDJFr1ATK/FhzCO50chKzjIWlznX6iHKGuPx2FqqpyAcgtDN3bKn4Bsx+IKAIThuLVvXWuiYN4TBoC4v7YXqE4tXeW9cE5kk6lm//dYGZB6CIRP+VarA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f80c0722-bae9-44cb-c832-08d8682353c9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 05:07:02.0157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT009.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT065
X-OriginatorOrg: outlook.com
Received-SPF: pass client-ip=40.92.21.69;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 15:30:47
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


