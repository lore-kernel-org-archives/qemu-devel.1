Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6896BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8654D222EB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 14:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8654D222EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRGK7-0000Pd-DC
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 10:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kRGJM-00087m-7M
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 10:57:28 -0400
Received: from mail-bn8nam12olkn2064.outbound.protection.outlook.com
 ([40.92.21.64]:24416 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kRGJI-0003hq-1R
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 10:57:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpYzbpbBV2R9txu42CtMl0F8vjzM24iNczeR3ViAAcOOZsPEgbMWJhSUMLyAcsFDf5cIkm443wr7zqrS7uaOb+HPw4IX41tUrCOU4woO1McVymaujdusqFmG4MkviYyZC27Gesl/d7tGqj2BxTpest78QMhl/oXXjI5Jq07kaYlG9CdFax9kO8HuB96Y4ooA0ir0McvTcj29uVVDM7PJBSNb6xKDP2Rdv21rtpfbwfrP/esye8GTOs1VSbl6WmfGHhk1GuUXrUxrJVA63ImyODLfTrto1oPxRRxQ3S9Er/o/tDpKgaEIEnaOYcRoXUOR8l7TJ1tdj+M0rsZEsFnCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHSL++clY26ZljRKkGlHHbNotnsmb9REPI4KMP9E70=;
 b=f1CceAKXQn4ACTCt8TZAVZ6yi6I9zyyXWMHZdpP0rb3icsPKkGJSVnHCZAuZ6RM2Jdvg2K+bYEqUfgMbheG033Qe4tQ4K2zliq+JAlwallejhZgB+zFVGBl+SCyDlm6DFlWZHaNVa/2VO3ms7TD/3rnQEdXfOn2cSkMilv7AzKrrHUShMq6nIHxuGL8aRbCSgiqlWcpyuFhCTyqEYsuE4XJ8U6L71zt0pijJUb7nnjYLrTBy0MOsuZK8YfG5c2lWST3qnsIIDG0shjvGr+in6dhPLEsWI8oaQrFYh5rn4bUiC/KCawGLlwrQJH4vGuBtOHq+TDNYClzyXkqr1LIMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BHSL++clY26ZljRKkGlHHbNotnsmb9REPI4KMP9E70=;
 b=awcJveRLKHWLIo4M0uLbtZmxArRg4VI1zdWflSVd1od+mg7EMyPd8sOSBaOrlnKl6NiBLxh5u+sFKphdHzeeFeB3W0LU8Y94MUnAVhTF1UVHKP26cJcWguo+9FhLQGEkWH4yzIzBLdl5MFEQBvCE3s3UnmSjWNTkcBCzeTG+wDG6ZogFHTwEN4Xr53PzxPvHRBY7OB5zBLDQs6y4EVlGTXRuZtmz63dWMS2gRsLqD7Ff1zQkoA4k1uBmtJE4E9v+bqR4lf+Q2I4aq8Bp6aDZRyX93/DcjnR84P7Nt6Kh/XZDyTinYpfmGigSoNqsF3rwJ5SK0i9V066e978NkPiaQQ==
Received: from BN8NAM12FT013.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::43) by
 BN8NAM12HT083.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::478)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11; Sat, 10 Oct
 2020 14:34:06 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:fc66::4f) by BN8NAM12FT013.mail.protection.outlook.com
 (2a01:111:e400:fc66::227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend
 Transport; Sat, 10 Oct 2020 14:34:06 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F0C0AA87B6C54672D40C52173845018B49ADC4841A7B8121807CC4C1E0B6254A;
 UpperCasedChecksum:81EAD7110CECC8B4F1E7DD597C08E5A30FA0B1CC86D17CED806D1A7698F9175C;
 SizeAsReceived:7345; Count:44
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3455.027; Sat, 10 Oct 2020
 14:34:06 +0000
From: Heecheol Yang <heecheol.yang@outlook.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5] hw/avr: Add limited support for avr gpio registers
Date: Sat, 10 Oct 2020 14:33:42 +0000
Message-ID: <DM6PR16MB247368DBD3447ABECDD795D7E6090@DM6PR16MB2473.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN: [G+9pBkOqZYstVJd7jUy96NsUBWn9vgmN]
X-ClientProxiedBy: SLXP216CA0037.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:4::23) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <20201010143342.2903390-1-heecheol.yang@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (121.168.203.43) by
 SLXP216CA0037.KORP216.PROD.OUTLOOK.COM (2603:1096:100:4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Sat, 10 Oct 2020 14:34:03 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 10667188-f6ed-4087-81d1-08d86d2989da
X-MS-Exchange-SLBlob-MailProps: pt8ZUcDWjMWoJ7n2SSdxym/EHACs7cvLNI+tjFqiIMvWMYcUwWZJAhy4/LiQy3zydZDXc2uFKychH4HTBgRIA7ELLjj4LP83JAhplqrQnRZy+3NU12JtNTWizvYpKBfwXoAPmpAx5iXkymHWl7B8BTwJQZ+eV2cz+QHmOEeywAY1L4QoPJKee953JM86y/xJMilxG0pZWsLFV/tU9Mjb31haCo+shCiI74GEMgs/L2XNsmLBD05qFvMcNoYgP+dHEQjaxK3bcHEAoU2mCkXKj6c6rBAhKG7knQ7PztYdWRYgZ0NNflZEDoYHak2fZioa1KrwYx5+NGJ1AdMMZjPDuHx80BksznkbzGofKJibrygJK/MKCgB+KZvvxmVCE/u/PfiEkmrJclr9cz3gXcYRjCZEkEL7ykVrbZ5Ix7iLTy3IW5hAHX9Wb5TKjTqGCBJOIgIUfC/2Ahn17I9V13Av5SG85kvfpCGIzgK9OCk3UPJbQ/9JTINBQRn5RqN9ogT4BxJKeeiRe7OBeNv2So6LkAL5NV+ywhckgGPFtx3fqlDXdQs5OwOddUgvYpIy1H6KnpPF17rtgnHouZouBcD2PHL04Ka4EJh7niAh6DNRD7BdMSz/Yps2lSVi8a7zYpEJu04lF+jHC7Fk1OM3AyDgpFpjPZfSOsfctP8v/vvT50LajJpS23Bv25x/bP0RZ5sFL/1sPeMWQJBWm1xH199XeSuHTIcu2E4iK/55IbanFK+CEZcx8VCylbdoRXqZEuEFvogUPlZgkj14aFUOZF2aI9CEH2spzmz3O/GqQYKLrOCF6dM9v1/U0W+jyEWW1fI7yO9SvRGwi6jvPUtaVCCbT75Jc6irRsBOOBBX8X/t9SmVLuQ6FXbKajF0y6J5BGdFMLLhuVCMVZO0M76lbKkZyQVrWSICN27cnn94qnvwZzoKqJrygA0tf6rZk+U8DGUr
X-MS-TrafficTypeDiagnostic: BN8NAM12HT083:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wxzo3ZncK4yTI9eSefu/N4VmxXcTLH2jdYs5azljgl0hMzlRaCqhE1XnmU2DZamtW7rC01Mx2cSP7HszWSbFqCEmPQD2aqpu4/zAlktA4SMBXqRyLMCDpn8TUJA8GIcV0w80stDeHhATnVcNhBqDQJzXq9PdFe62mqr+g0PkMRD6HC0GhByAvKkgJ/4YQ1+LPuxp4yxBLQaKx0zwYHI48Yop6ikMpCUbgtoCi6SSSJR0FOIwnoYxULjhJQTLG7NK
X-MS-Exchange-AntiSpam-MessageData: /FIRwYGxVpR+j3IUlq2ZnVyQLxYtfwcW1p+e3oS0C58to3sSON+2C44alqL3gfy2HCg0lsimGzztS9XP/+8hQOeIDmGLNGoor7x2zQeKHUDrgCWfnopWZsCpBcXVnWmbC4CbYlEFbAc763vTTFK5yg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10667188-f6ed-4087-81d1-08d86d2989da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2020 14:34:06.3171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT013.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT083
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: outlook.com
Received-SPF: pass client-ip=40.92.21.64;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 10:57:21
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


