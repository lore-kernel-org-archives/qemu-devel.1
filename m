Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D3AC41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 12:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432BF206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 12:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432BF206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOgqC-0000Qo-2l
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 08:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOgp2-0008KS-4Z
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 08:39:32 -0400
Received: from mail-dm6nam12olkn2103.outbound.protection.outlook.com
 ([40.92.22.103]:30305 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOgox-0002Kj-Vc
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 08:39:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hwmrx0Nw4Gn7YMlCKgOCQDdlnIFyxrgR59hgbgzfHzTz3OexLMJhJ8VFjFyoKIp+Od+8oYZJ6lBSCpG4fIYS2VAelDVm/nOoXgGxPkbyjTjib/Fx/gyZNw223w/Dt8eyI9i4y36cEUSgfIqGKN2x47fcP1mO8/NyJzitJmBZ/taQYqQZJaJV3RCg6t5g/sqlDXsgidzeenhxNe5O6vPPpJA3nUbLU1K+wleew8Mlw9VRtyUChS/knkVJ5pYo3On6V+ZOKPvxbaQC/Vl+SmcleMpXDHKsoD5vWTjqxSBbjYXkAPc+0KmHGrhxSZgbkh0KvjgFYUMECczZt/yyZxveuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX1yhj6Z9v9guQF2F49tFwe8tyg6RM8XT+wAkrokJP8=;
 b=K9vr1mKQt0npgYzvPtzY1amMhYW+fbELFZ7TA+djRAYpUb5YLzqTQsC/fyz4ZRCX1GphaBxc3XxOxxWPMz/IUo7RWDAvclULbb7MfOzo56XrXtp6aXr70bIiky6WqsqUr+yRqBNTU5DS0pPaq6sTW8vM25UObr9x6Y8IpZHUqt/vTMbE73P92P3vjfWAF/RmHOnN3UawfX32FTJ+tN+4KsBkazzw8jhErYLI+6T7qb9/tAIzLR/bkrufjdYL07YWmXA73wK531nBxYBDS6KzQ8gxoQ0GVoFe0dz6bg4fmI/ldcKAt0VzmFbUSqWw0NkLvx8WnipGGGpt4xep98efIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX1yhj6Z9v9guQF2F49tFwe8tyg6RM8XT+wAkrokJP8=;
 b=Q+vc/IKfuM3D5qzSxxeiTjMNWKrTuQV1RiQcA3dHeNxMN+8fSN4sYsCunI+1GLAIWoIwVzcgWx4a3OgImePDzgGrGH377HeqmS8hsgBaTmWrzpLI4ywrbcYE1wjcs8bWAosb6ut6v+yV51eK+m1fzcwo/nKyRa6II3ykFCpumI/LUwTWs4RSo4DAgsDgsj0J5fHcyjH3fkaS2A6LiYS+yvX0HlxhI7yrEXHqMEJGBM/RQ7pPYhD1jmUm20wmYOv9Pxzy0z87Xmt+dnRRTy5QFdla3YM+cstLXZdGXaQaPjykgnwhZXBs+/fkpX5K3usKrq2EcPrAWIq4rjKlAL74Mw==
Received: from BN8NAM12FT018.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::41) by
 BN8NAM12HT004.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::285)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.14; Sat, 3 Oct
 2020 12:39:24 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:fc66::53) by BN8NAM12FT018.mail.protection.outlook.com
 (2a01:111:e400:fc66::347) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend
 Transport; Sat, 3 Oct 2020 12:39:24 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:73E16CA555FD92408F99281F1094C903B442DC2C5707E4D58C599854EA4AA097;
 UpperCasedChecksum:517779720B2FB027AD271FC4F755FD25778BE8CB024D2696B414DDDE1466D6BC;
 SizeAsReceived:7348; Count:44
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.039; Sat, 3 Oct 2020
 12:39:24 +0000
From: Heecheol Yang <heecheol.yang@outlook.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/avr: Add limited support for avr gpio registers
Date: Sat,  3 Oct 2020 12:38:59 +0000
Message-ID: <DM6PR16MB2473C5A77E009CA2FEF3D8ECE60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [6nrDrQf8dX8lET42p2OlaqH6TAuSuNcd]
X-ClientProxiedBy: SL2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:100:2d::24) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <20201003123859.872041-1-heecheol.yang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (121.168.203.43) by
 SL2PR04CA0012.apcprd04.prod.outlook.com (2603:1096:100:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34 via Frontend Transport; Sat, 3 Oct 2020 12:39:22 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e968ae44-ec2b-488a-f609-08d867995bb5
X-MS-Exchange-SLBlob-MailProps: =?us-ascii?Q?KE5ywuOaN5j5Nn/VYbqq842JR4p083mnwxjgoo0ndyK7GU2IEMntu8XRa48+?=
 =?us-ascii?Q?gnIKt9xAsRRKLXs7uN/i3CYEsp9VtF+63ZG/O8sUnmPq7RgByjvcmQoxB8nB?=
 =?us-ascii?Q?imJgOGKvnE2wKSI39+AT00aKEaA3k+dzFmG9JVwex7NoXuIl0HRc3/vNb79E?=
 =?us-ascii?Q?iy6BXlMeAOMl6k7SVsda8EOBkf9E3Se3qvPT1eSpAmVcJuFNaUZK35Ll+VBb?=
 =?us-ascii?Q?b4P0b+ZbEP0vJ+JtdHHJqs9L3a9BaX0Y4srK1Zw3ECBW2UDkTyEoS2eNgKG/?=
 =?us-ascii?Q?dnX+5UN0cHZSik9UA+NFfwG0vxpBB8ZdlGPuQC23eZ7jLvnqfKIP0sK0dFPk?=
 =?us-ascii?Q?jU7Yzwt44n5MVwIgODs5ElgxSdhDo7HBpeiRApIMN4pO6gL8wwkx80LoUr4y?=
 =?us-ascii?Q?G9ilSgKtOQ5xMHoaY9/Xb3/W9j0m3AW3Z+4zoH85FQX9+6ufyGkWRkz6wrwn?=
 =?us-ascii?Q?Iausf4i4KOimt17EFwWOu4vJ1xigDJ5joVefJv0H4FpW8ieXl47SQFTk0OPU?=
 =?us-ascii?Q?mvjWb8fNgjvRzbk71nECYs4GQjp19wftrmHWC8sWtjCWb91GGRxDcHCSV1IN?=
 =?us-ascii?Q?Wkhz7rN9QyDlCuwutMxzgBi1MZX3HViN2zf53CGhZFMYLu4bb/5gVaShe4Ch?=
 =?us-ascii?Q?h/kBJ6YanrhrrBHSz42ooYIapMNTuwaeacp+gBsewHJgcflfM0ymS6zUQdNh?=
 =?us-ascii?Q?4h/ElwrdR29cvZ5R+Aolr/pL6kLM/y1UwwF0S1BffQ9TzvnE5MwyNKjp7hzL?=
 =?us-ascii?Q?THGFMH+nRFP/1Pa11sb61XpqfSxEXmHi4qnMLiDItadX7cMWyCM4HICvgbVT?=
 =?us-ascii?Q?ykSHEb0tv3OZ8wOgWNZY1fofnSe/bLYa2z3fr5k0xcuBku/s3P9PxXSi/YvF?=
 =?us-ascii?Q?ulkhxymeOJoTFegGV+stjl4Cs5WMt3AsP9YPrXUgykEpYYrY4HyeBjDMV0Ae?=
 =?us-ascii?Q?bJwIbipphhAuEKm6kVCerpPyIv7aueHw?=
X-MS-TrafficTypeDiagnostic: BN8NAM12HT004:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQ0K0i9u0zajJyuDAorGMUdVPqUISWQwgzEekHffuMlFJ/uNyisFRnwzeQ5QBji3hr0RUgMw/WoEgToDQuqcP3jpnLbhkU4Pt5zczZWc6jHZSrq/HP/m78IMPUWNZDMXMuojb0pTzM6aFw8pVEL5yth2wUq7lkyQnywQCN8Qjg7EGny0xDCSQcSN+VTA9AQPug5gXouNo0HjdBopAc2Ok2Mn41mQuO2R3vH9fcEaYAGPpM1rvHNHKgda3b6xQhs0
X-MS-Exchange-AntiSpam-MessageData: ly3njUi23+2V7n0lygN6uAceWH1MqKh0GtPFLZ76uTTH3sl7h9S8pvyrsktgjiiVg0DpewiRfPnIPsDgVeXoNdNp/9qNl99UobCfzCRkf2jjvOUOtSCal9Cp7lkVpT0YtnQ/yeGrEP0c4Ldx3AyyCw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e968ae44-ec2b-488a-f609-08d867995bb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2020 12:39:24.3021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT018.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT004
Received-SPF: pass client-ip=40.92.22.103;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 08:39:25
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


