Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93502C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FC620776
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FC620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRdS-0007Gm-O1
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kPRcp-0006pJ-JL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:38:03 -0400
Received: from mail-oln040092011010.outbound.protection.outlook.com
 ([40.92.11.10]:39905 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kPRcm-0005qH-FP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvkXEyG1TjFqKJoKV/EdmfKdiSr1hfpDqKQShJv8a6hPaNbDW3dvKFdROtf2Dxji8a8gE3ucCtlZ6YairrJ2ik+crtlo2M0I5VSjMzlMIOPLzjagF/7HMBHmocCj+sPtvEqd+ZZlBZ/Pu0/i0/1WiSArX8ljjwUpqtqw9AQGSz8s0T+eWJToS2UnJqRYY2iSnzdXTSRD7HXUGcu7+kkVEsVYdE3xMjrblWjV+qpIJsuqENDkLn7zQavXdaJQw0B0UP75hDl2P30UoDPbPxEOZSa46fTHGJpmP0dAw6L6X3FzaYX+ULRm0x7tsguDx193ba1hcuJRJYQNMUXtwHtygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHSL++clY26ZljRKkGlHHbNotnsmb9REPI4KMP9E70=;
 b=MG315p4XdNy1EomJChuZMl/pj5CTg8xv7N43qZCVsNja3RQVDgQM6/+g4MWTGZx3DDNcc22LTK0Pqhy/im1wXFbncpoOP3DpVWXXp/YEVCUHGEHlYk2iY4o8p/gbFBnPi89CpPnHQtCBpuF+N0i5muz/+cNHRkxh2M5u93jwelhjeRXb+oUrcuqtjr9wipDGh3vY4AAn59cR+i+GqclTgpX5LHOzh0p4trbnEVUdcrw+eRj/kSkQO4tG1R6Esk/r5fVYGeeV54Ta8kX3qWkATZZI2zLb7h+37EYAVIOnSFvlsbJ8mhV4GEHTnzl4yoX4fgNjOlRBfoHrDiFeZYjg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHSL++clY26ZljRKkGlHHbNotnsmb9REPI4KMP9E70=;
 b=R8cEF4ZRRxvChqKYlzDz8q7l4wSQZjpWkCtDPbmgk0972MELqEtvO2pojg3VMj6AffdvhK/n93HD5kTjcXHMkmjQK31giwaNFvAk4ptODgAsJJ3lBTkPVq2n2naPb9HcPgKjFlsmuFktLpErNbMm742XG+/NQZs8TEpazMZ8Ks1VhD+mqeHfIB6baJumOg2YcATa+m5wgApAjKKx27MVxZSEgg1f8pP7dUYqVTpVniyg+srrrmWXjXTYoyUSiD6OrJXANtxkH75v3Hu0tF+JLMWLA33xV6cU/UhWnMwoYtYxqjS2ZGFvdU2QluTxuwLf4YysD+ZhI9H7HaAryldRRw==
Received: from SN1NAM04FT010.eop-NAM04.prod.protection.outlook.com
 (10.152.88.59) by SN1NAM04HT124.eop-NAM04.prod.protection.outlook.com
 (10.152.89.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Mon, 5 Oct
 2020 14:37:56 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:7e4c::51) by SN1NAM04FT010.mail.protection.outlook.com
 (2a01:111:e400:7e4c::129) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Mon, 5 Oct 2020 14:37:56 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:25D3087B57D480F5A02FB0E8CD4F759F4B5F28350540C20DCC9A223480D3DDE0;
 UpperCasedChecksum:C5DA2A87A61EC65258027586C78BD76E6EEEAC2D281FE62CCBEA8E7D9147D668;
 SizeAsReceived:7344; Count:44
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 14:37:56 +0000
From: Heecheol Yang <heecheol.yang@outlook.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5] hw/avr: Add limited support for avr gpio registers
Date: Mon,  5 Oct 2020 14:37:40 +0000
Message-ID: <DM6PR16MB2473D96C4D975DE569A330F2E60C0@DM6PR16MB2473.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [Z3x7CBGkwF4N0/dHq15yU8aF776xcZZ+]
X-ClientProxiedBy: SLXP216CA0055.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:5::17) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <20201005143740.2715308-1-heecheol.yang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (121.168.203.43) by
 SLXP216CA0055.KORP216.PROD.OUTLOOK.COM (2603:1096:100:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32 via Frontend Transport; Mon, 5 Oct 2020 14:37:54 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 85b87aad-f55a-4234-2086-08d8693c3f9d
X-MS-Exchange-SLBlob-MailProps: =?us-ascii?Q?KE5ywuOaN5jihPY872v/cvB0I3eak1stts5xKeXOkNKvQO09JNHDsEmhJEfY?=
 =?us-ascii?Q?TEO9ok9Ml3yJGfoKgBgov6za8+SgQQq5nMx7V+0kJNJDdTKHZueakCUAFOOa?=
 =?us-ascii?Q?y3JFHxz3qZS5G/5QEgqRC4OvV9XCl619Imo7gRmrEP9Obd/22Yj4OW9RoDOX?=
 =?us-ascii?Q?NSNWmRqLcpV8AsdS97R7StJ/5RrE+JhKo9S5CVNQtcasvz9+M8WB08lMYrOK?=
 =?us-ascii?Q?O7rmtc3sIFWpbrWZ9GWRUm1ZENzE+losr3qWJ+oGFqwyWv48OSLjqKKXnrcf?=
 =?us-ascii?Q?el8RqIz52alNhu0ZrCxSuY/xrxQZa05bBOxoopuxxpXMsaWnpWSYLeGnsx0p?=
 =?us-ascii?Q?RvgLdEU9zVf6VTb7kRjAnmDyjK8sIMP39Dfyou91h5PbfBEtSys7kGB0TsNo?=
 =?us-ascii?Q?+OVujmryf6j9TBB3R26ROxLRav+KV/Xa2p5nyrMaT+uL6x5RcKDJSkJOsHCP?=
 =?us-ascii?Q?BjENnfxppJ8wD31IDx79KnIyQ83l5yXf/hPSyCMONA77zh5x/6lFEHKYLYe8?=
 =?us-ascii?Q?J5WZYW7uT4A2qNtRwNV2vBaNhm89FUYz2tvpQZ16ThdLrjl2EENi+NggaSMt?=
 =?us-ascii?Q?cjmSVVjwA+MqJ+vsEkKQaTbDMn0alP6SK8A6yJAE3EeVg1gWx/3+JLgnQRTX?=
 =?us-ascii?Q?OIBC3QzrP3v5HddsWMeFtkgN2+w9OObfMFALo9BUDhsLIA8ClwGEv2L6ZP9z?=
 =?us-ascii?Q?owPnT1S2Mg/9Xd4mJLvhTESVYzhFe6kOPSP5r3YO3xHzTGQLqrb8UaX4BYeN?=
 =?us-ascii?Q?GG5iOAKwaLpvPPR8NFhRQlBAuz4NeZJnRe1+U3qTGNwiAuui2t5hKJikGdG0?=
 =?us-ascii?Q?dENIxnL87h2dVOOsHqwpNK2cNsqrVkB39/K5Th2t6qJt/5Xkq8I+QsX9xFTi?=
 =?us-ascii?Q?r1NCVK1UX1gCS6ILh2AghfDb9NsipN+MHGBV4YeVudBSws6v9bx8eipydWEH?=
 =?us-ascii?Q?Ijm89iEMkdN+aAphHP3VkVWty1Fpwu3c?=
X-MS-TrafficTypeDiagnostic: SN1NAM04HT124:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVvQvhQWEOfbtTes/nKO3olvedvwqHQ8jxbVB7UYjue+8GkyjLhyfEvs8THcFf3lJVqN5q80ySiBcNjiwVF5+0TIZ2H2BLxH4Br/+s51DcG+CxznBDzGdhgdb6i1jNRg8bpVfHtWV1TwUCgC7qecdMz4Sr5BlyuwrnuqdqIRPcwoFObNK1xXsvLlysRdadvzz/p9t/GydEcNmpqByVBG16hFNVpand9pnUjM4CD4w9d2Ew5ZhTh6KPIWz4U1Zhwd
X-MS-Exchange-AntiSpam-MessageData: hiXZwBk0p5ezeVKT1JRSv+0NnL2apkXGtZI+UHmGWLLZ4IlC3+OhLPXY3KCgCXs07TwC0gQXp1i3oncgrCBHECgyuiydaYtAbnYsfejAeEZDlNcVRSCXNrlI6v2yCbUqsxbK3ZfP5UnHLk8kAt7Nbg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b87aad-f55a-4234-2086-08d8693c3f9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 14:37:56.4468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM04FT010.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM04HT124
Received-SPF: pass client-ip=40.92.11.10;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 10:37:58
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


