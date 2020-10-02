Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682F6C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6A3206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6A3206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kON4N-0001mi-Sf
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOMvi-0000fI-OD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:25:07 -0400
Received: from mail-dm6nam11olkn2108.outbound.protection.outlook.com
 ([40.92.19.108]:28481 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOMvc-0001mJ-A1
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:25:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTtadiFVjgs9pUQAuFsam7GZFOC2Yb8DrUsXOmX8CC1yFTf1jhKaQ5rMLBg1rLYdIMPTp9/VrpkQIfzdVoBatHbv6Imjr1kPJqOeSB6kSHePTFBlufvhGRwyZrNta9umKUDLa2vkQQFGxF9BqgOMSxpU6H5RPMsLzTZZP/2h5qwBcnGpzRoJBvcQJZTkIwdpHmJKvJw83snRo5MaOwHylwIdAhXnL6/RfpFO6qZEH6Lz8pFI6hkn3ylFP+blIzcGWSaql8exrKzwOr+gQO3mF18LAU/+qwbll/LLw/0IIW0pNe8iFjC9rERKzHvuFxt3p9832Tul3RQSl02K5bp7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2g9hYEgCligVp0dFNG1UUItuWe9Lyrq9RnODDuQOv4=;
 b=dZS68/Th+9iUAZaBMDnWw2EgPncLf8EHWEQOBAdx3Nlk0hJ8L7FzWdwNg8d1Jpnmfo9qtwCCXZX0O6Lb6ct1FwoWQz/21d67hIP8XHYitHMic3ApLPqMXnr5Phr9bp20dbqP6uA3Cft7xNqrh44evIStb2zRPo8Zc6D+r6jWDu+zmleSQSnviqkQjQKaQz5EfUct3bPwtIguapYxNKye7EO1+4tqugexHIBuvMtSCwUvzOkdgRstSMGmd/i6o/lRv/rI4c98H4l+zJq6GhTccFm8edyoF84JxC85D6sFCYzJrzOiUaGbyO/QOlpivHJLwdGJ6wf84dcGE+BKQMh58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2g9hYEgCligVp0dFNG1UUItuWe9Lyrq9RnODDuQOv4=;
 b=dhJWGLcUsAxZTYfI4c4FdIyvMnkBXCbiq/GPNeGzoiNOYKDSACGzuNRDKPwmP4FQqNTc/v8qSwlqEtgQTXeyHhyN/hbnCndM5NWW7KaogEH3a/i2B7DYbofEfrN474EyvdsvnVBIiqebiqUY33jGMAq6M5wOsJbj02yIb79z0LWwWmHlFjKWgmIBShKFukBD8MLXBMbSnyqeCDzRsZ66kdaWWqgJ/QaAFsHXu75eIWUDxwtnVVyUCrg8essUwxTMiocIYGVd4nPgN0D48LAmdhfUgra6qMEXMVxK1YvxzmxOBHaYRNzCcJvm4MqxbMOuRSB3p8T9ruY16JrlI4OAOQ==
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::47) by
 BN8NAM11HT152.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::419)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 15:24:57 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:fc4b::4f) by BN8NAM11FT047.mail.protection.outlook.com
 (2a01:111:e400:fc4b::476) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Fri, 2 Oct 2020 15:24:57 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:5C0122AFA3E4F5474692898BCE4A65E5B16E740C133F4EAA4C940957DC80AB64;
 UpperCasedChecksum:B432E6F847B380E85DC8A11E191498CD53A94FF7B1C5AD4CC47EB57D453AEB40;
 SizeAsReceived:8545; Count:45
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 15:24:57 +0000
To: qemu-devel@nongnu.org
From: Heecheol Yang <heecheol.yang@outlook.com>
Subject: [PATCH] hw/avr: Add limited support for avr gpio registers
Message-ID: <DM6PR16MB24737F911BD260F1FA8EBC37E6310@DM6PR16MB2473.namprd16.prod.outlook.com>
Date: Sat, 3 Oct 2020 00:24:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: multipart/alternative;
 boundary="------------05D7FE08FA15F909CA62EF22"
Content-Language: en-US
X-TMN: [alndI9+P4kjwBptWSqFCllRJeJSWyZ0u]
X-ClientProxiedBy: SL2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::21) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <190ea1dd-5a97-09bf-dd63-e942cfcec0ce@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [121.168.203.43] (121.168.203.43) by
 SL2PR01CA0009.apcprd01.prod.exchangelabs.com (2603:1096:100:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35 via Frontend
 Transport; Fri, 2 Oct 2020 15:24:55 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: b19823f8-83f5-47c3-7f77-08d866e75180
X-MS-TrafficTypeDiagnostic: BN8NAM11HT152:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9LGwQRgZEqclBkuFaLkek1gVwi4bVTXHqVt7OKvHFhPkq6FdCNu7hVr3E6U+QOfWbDaXXG+ckfURUd0/ROoN/dsvY+cZ60JPBKsaxi83s3h/z//p7uNP4hafPRop4x9gfn/quJ++fqEmOhjL3mu752QN8xGCZWOn6tjkgDWt4vQwVlxEX0GWxXEZ+bEuFqUaAdN3+pAiRnULNcu2LprspXTVgH7AAeL1B68i6QH8cKBcSCPtt/LNeZBVVghZj4Y
X-MS-Exchange-AntiSpam-MessageData: KSOoBGtoQEGE9CNKgiZEdoAR6tcdtsYEo0SFB6t/CbcbhxYTSUWEz/WfDG3izkydTf3rYX/x+Wjn+l0fT7H1iyfUSL94MX0Ue4uUS2dcGgrtxHPamc7GZBtBE0fot7OCWpdDqIMRlnvB6VL82cLJFw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19823f8-83f5-47c3-7f77-08d866e75180
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 15:24:56.9276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT152
Received-SPF: pass client-ip=40.92.19.108;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:24:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: S.E.Harris@kent.ac.uk, mrolnik@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------05D7FE08FA15F909CA62EF22
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

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
  hw/avr/Kconfig             |   1 +
  hw/avr/atmega.c            |   7 ++-
  hw/avr/atmega.h            |   2 +
  hw/gpio/Kconfig            |   3 +
  hw/gpio/avr_gpio.c         | 117 +++++++++++++++++++++++++++++++++++++
  hw/gpio/meson.build        |   2 +
  include/hw/gpio/avr_gpio.h |  48 +++++++++++++++
  7 files changed, 178 insertions(+), 2 deletions(-)
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
+    select AVR_GPIO

  config ARDUINO
      select AVR_ATMEGA_MCU
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 44c6afebbb..ad942028fd 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error 
**errp)
              continue;
          }
          devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
-        create_unimplemented_device(devname,
-                                    OFFSET_DATA + mc->dev[idx].addr, 3);
+        object_initialize_child(OBJECT(dev), devname, &s->gpio[i],
+                                TYPE_AVR_GPIO);
+        sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
+            OFFSET_DATA + mc->dev[idx].addr);
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
+    AVRGPIOState gpio[GPIO_MAX];
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
+    bool
diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c
new file mode 100644
index 0000000000..7114216847
--- /dev/null
+++ b/hw/gpio/avr_gpio.c
@@ -0,0 +1,117 @@
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "hw/gpio/avr_gpio.h"
+#include "hw/qdev-properties.h"
+#include "chardev/char-fe.h"
+
+static void avr_gpio_reset(DeviceState *dev)
+{
+    AVRGPIOState *gpio = AVR_GPIO(dev);
+    gpio->ddr_val = 0u;
+    gpio->port_val = 0u;
+}
+static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int 
size)
+{
+    AVRGPIOState *s = (AVRGPIOState *)opaque;
+    switch (offset) {
+    case GPIO_PIN:
+        /* Not implemented yet */
+        break;
+    case GPIO_DDR:
+        return s->ddr_val;
+        break;
+    case GPIO_PORT:
+        return s->port_val;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %lx\n",
+                __func__, offset);
+        break;
+    }
+    return 0;
+}
+
+static void avr_gpio_write(void *opaque, hwaddr offset, uint64_t value,
+                                unsigned int size)
+{
+    AVRGPIOState *s = (AVRGPIOState *)opaque;
+    switch (offset) {
+    case GPIO_PIN:
+        /* Not implemented yet */
+        break;
+    case GPIO_DDR:
+        s->ddr_val = value & 0xF;
+        break;
+    case GPIO_PORT:
+        s->port_val = value & 0xF;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %lx\n",
+                __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps avr_gpio_ops = {
+    .read = avr_gpio_read,
+    .write = avr_gpio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void avr_gpio_init(Object *obj)
+{
+    AVRGPIOState *s = AVR_GPIO(obj);
+    memory_region_init_io(&s->mmio, obj, &avr_gpio_ops, s, 
TYPE_AVR_GPIO, 3);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+    s->enabled = true;
+}
+static void avr_gpio_realize(DeviceState *dev, Error **errp)
+{
+    avr_gpio_reset(dev);
+}
+
+
+static void avr_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = avr_gpio_reset;
+    dc->realize = avr_gpio_realize;
+}
+
+static const TypeInfo avr_gpio_info = {
+    .name          = TYPE_AVR_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AVRGPIOState),
+    .instance_init = avr_gpio_init,
+    .class_init    = avr_gpio_class_init,
+};
+
+static void avr_gpio_register_types(void)
+{
+    type_register_static(&avr_gpio_info);
+}
+
+type_init(avr_gpio_register_types)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 86cae9a0f3..258bd5dcfc 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true: 
files('omap_gpio.c'))
  softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
  softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
  softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: 
files('sifive_gpio.c'))
+
+softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true: files('avr_gpio.c'))
diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h
new file mode 100644
index 0000000000..45d42753c8
--- /dev/null
+++ b/include/hw/gpio/avr_gpio.h
@@ -0,0 +1,48 @@
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
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
+#include "chardev/char-fe.h"
+
+/* Offsets of registers. */
+#define GPIO_PIN   0x00
+#define GPIO_DDR   0x01
+#define GPIO_PORT  0x02
+
+#define TYPE_AVR_GPIO "avr-gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)
+
+struct AVRGPIOState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+
+    uint8_t ddr_val;
+    uint8_t port_val;
+    bool enabled;
+
+};
+
+#endif /* AVR_GPIO_H */
--
2.17.1

--------------05D7FE08FA15F909CA62EF22
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div style="-webkit-font-smoothing: antialiased; margin: 0px;
      padding: 0px; border: 0px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-variant-numeric: inherit; font-variant-east-asian: inherit;
      font-weight: 400; font-stretch: inherit; font-size: 12pt;
      line-height: inherit; font-family: Gulim, 굴림, &quot;Nanum
      Gothic&quot;, sans-serif; vertical-align: baseline; color: rgb(0,
      0, 0); letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">Add some of these
      features for avr gpio:<br style="-webkit-font-smoothing:
        antialiased;">
    </div>
    <div class="x_BodyFragment" style="-webkit-font-smoothing:
      antialiased; margin: 0px; padding: 0px; border: 0px; font-style:
      normal; font-variant-ligatures: normal; font-variant-caps: normal;
      font-variant-numeric: inherit; font-variant-east-asian: inherit;
      font-weight: 400; font-stretch: inherit; font-size: 15px;
      line-height: inherit; font-family: &quot;Malgun Gothic&quot;,
      Gulim, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont,
      Roboto, &quot;Helvetica Neue&quot;, sans-serif; vertical-align:
      baseline; color: rgb(32, 31, 30); letter-spacing: normal; orphans:
      2; text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255); text-decoration-style: initial; text-decoration-color:
      initial;"><font style="-webkit-font-smoothing: antialiased;" size="2"><span style="-webkit-font-smoothing: antialiased;
          margin: 0px; padding: 0px; border: 0px; font-style: inherit;
          font-variant: inherit; font-weight: inherit; font-stretch:
          inherit; font-size: 11pt; line-height: inherit; font-family:
          inherit; vertical-align: baseline; color: inherit;">
          <div class="x_PlainText" style="-webkit-font-smoothing:
            antialiased; margin: 0px; padding: 0px; border: 0px; font:
            inherit; vertical-align: baseline; color: inherit;"><br style="-webkit-font-smoothing: antialiased;">
            &nbsp; - GPIO I/O : PORTx registers<br style="-webkit-font-smoothing: antialiased;">
            &nbsp; - Data Direction : DDRx registers<br style="-webkit-font-smoothing: antialiased;">
            <br style="-webkit-font-smoothing: antialiased;">
            Following things are not supported yet:<br style="-webkit-font-smoothing: antialiased;">
            &nbsp; - PINx registers<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp; - MCUR registers<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp; - Even though read/write for DDRx registers are<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp; implemented, actual direction controls are not<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp; supported yet.<br style="-webkit-font-smoothing:
              antialiased;">
            <br style="-webkit-font-smoothing: antialiased;">
            Signed-off-by: Heecheol Yang
            <a class="moz-txt-link-rfc2396E" href="mailto:heecheol.yang@outlook.com">&lt;heecheol.yang@outlook.com&gt;</a><br style="-webkit-font-smoothing: antialiased;">
            ---<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;hw/avr/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;hw/avr/atmega.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 ++-<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;hw/avr/atmega.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;hw/gpio/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;hw/gpio/avr_gpio.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 117
            +++++++++++++++++++++++++++++++++++++<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;hw/gpio/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;include/hw/gpio/avr_gpio.h |&nbsp; 48 +++++++++++++++<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;7 files changed, 178 insertions(+), 2 deletions(-)<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;create mode 100644 hw/gpio/avr_gpio.c<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;create mode 100644 include/hw/gpio/avr_gpio.h<br style="-webkit-font-smoothing: antialiased;">
            <br style="-webkit-font-smoothing: antialiased;">
            diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br style="-webkit-font-smoothing: antialiased;">
            index d31298c3cc..16a57ced11 100644<br style="-webkit-font-smoothing: antialiased;">
            --- a/hw/avr/Kconfig<br style="-webkit-font-smoothing:
              antialiased;">
            +++ b/hw/avr/Kconfig<br style="-webkit-font-smoothing:
              antialiased;">
            @@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; select AVR_TIMER16<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; select AVR_USART<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; select AVR_POWER<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; select AVR_GPIO<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;config ARDUINO<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; select AVR_ATMEGA_MCU<br style="-webkit-font-smoothing:
              antialiased;">
            diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c<br style="-webkit-font-smoothing: antialiased;">
            index 44c6afebbb..ad942028fd 100644<br style="-webkit-font-smoothing: antialiased;">
            --- a/hw/avr/atmega.c<br style="-webkit-font-smoothing:
              antialiased;">
            +++ b/hw/avr/atmega.c<br style="-webkit-font-smoothing:
              antialiased;">
            @@ -283,8 +283,11 @@ static void atmega_realize(DeviceState
            *dev, Error **errp)<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devname = g_strdup_printf(&quot;atmega-gpio-%c&quot;, 'a' +
            (char)i);<br style="-webkit-font-smoothing: antialiased;">
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_unimplemented_device(devname,<br style="-webkit-font-smoothing: antialiased;">
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_DATA +
            mc-&gt;dev[idx].addr, 3);<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(OBJECT(dev), devname,
            &amp;s-&gt;gpio[i],<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_AVR_GPIO);<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gpio[i]),
            &amp;error_abort);<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gpio[i]),
            0,<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_DATA + mc-&gt;dev[idx].addr);<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free(devname);<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; }<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;<br style="-webkit-font-smoothing: antialiased;">
            diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h<br style="-webkit-font-smoothing: antialiased;">
            index a99ee15c7e..e2289d5744 100644<br style="-webkit-font-smoothing: antialiased;">
            --- a/hw/avr/atmega.h<br style="-webkit-font-smoothing:
              antialiased;">
            +++ b/hw/avr/atmega.h<br style="-webkit-font-smoothing:
              antialiased;">
            @@ -13,6 +13,7 @@<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;#include &quot;hw/char/avr_usart.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;#include &quot;hw/timer/avr_timer16.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            +#include &quot;hw/gpio/avr_gpio.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;#include &quot;hw/misc/avr_power.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;#include &quot;target/avr/cpu.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;#include &quot;qom/object.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            @@ -44,6 +45,7 @@ struct AtmegaMcuState {<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; DeviceState *io;<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; AVRMaskState pwr[POWER_MAX];<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; AVRUsartState usart[USART_MAX];<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; AVRGPIOState gpio[GPIO_MAX];<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; AVRTimer16State timer[TIMER_MAX];<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; uint64_t xtal_freq_hz;<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;};<br style="-webkit-font-smoothing: antialiased;">
            diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig<br style="-webkit-font-smoothing: antialiased;">
            index b6fdaa2586..1752d0ce56 100644<br style="-webkit-font-smoothing: antialiased;">
            --- a/hw/gpio/Kconfig<br style="-webkit-font-smoothing:
              antialiased;">
            +++ b/hw/gpio/Kconfig<br style="-webkit-font-smoothing:
              antialiased;">
            @@ -10,3 +10,6 @@ config GPIO_KEY<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;config SIFIVE_GPIO<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;&nbsp;&nbsp;&nbsp; bool<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +config AVR_GPIO<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; bool<br style="-webkit-font-smoothing: antialiased;">
            diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c<br style="-webkit-font-smoothing: antialiased;">
            new file mode 100644<br style="-webkit-font-smoothing:
              antialiased;">
            index 0000000000..7114216847<br style="-webkit-font-smoothing: antialiased;">
            --- /dev/null<br style="-webkit-font-smoothing:
              antialiased;">
            +++ b/hw/gpio/avr_gpio.c<br style="-webkit-font-smoothing:
              antialiased;">
            @@ -0,0 +1,117 @@<br style="-webkit-font-smoothing:
              antialiased;">
            +/*<br style="-webkit-font-smoothing: antialiased;">
            + * AVR processors GPIO registers emulation.<br style="-webkit-font-smoothing: antialiased;">
            + *<br style="-webkit-font-smoothing: antialiased;">
            + * Copyright (C) 2020 Heecheol Yang
            <a class="moz-txt-link-rfc2396E" href="mailto:heecheol.yang@outlook.com">&lt;heecheol.yang@outlook.com&gt;</a><br style="-webkit-font-smoothing: antialiased;">
            + *<br style="-webkit-font-smoothing: antialiased;">
            + * This program is free software; you can redistribute it
            and/or<br style="-webkit-font-smoothing: antialiased;">
            + * modify it under the terms of the GNU General Public
            License as<br style="-webkit-font-smoothing: antialiased;">
            + * published by the Free Software Foundation; either
            version 2 or<br style="-webkit-font-smoothing: antialiased;">
            + * (at your option) version 3 of the License.<br style="-webkit-font-smoothing: antialiased;">
            + *<br style="-webkit-font-smoothing: antialiased;">
            + * This program is distributed in the hope that it will be
            useful,<br style="-webkit-font-smoothing: antialiased;">
            + * but WITHOUT ANY WARRANTY; without even the implied
            warranty of<br style="-webkit-font-smoothing: antialiased;">
            + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp;
            See the<br style="-webkit-font-smoothing: antialiased;">
            + * GNU General Public License for more details.<br style="-webkit-font-smoothing: antialiased;">
            + *<br style="-webkit-font-smoothing: antialiased;">
            + * You should have received a copy of the GNU General
            Public License along<br style="-webkit-font-smoothing:
              antialiased;">
            + * with this program; if not, see &lt;<a href="http://www.gnu.org/licenses/" target="_blank" rel="noopener noreferrer" data-auth="NotApplicable" style="-webkit-font-smoothing: antialiased; margin: 0px;
              padding: 0px; border: 0px; font: inherit; vertical-align:
              baseline; cursor: pointer;">http://www.gnu.org/licenses/</a>&gt;.<br style="-webkit-font-smoothing: antialiased;">
            + */<br style="-webkit-font-smoothing: antialiased;">
            +#include &quot;qemu/osdep.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;qemu/log.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;qemu/module.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;qemu/timer.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;qapi/error.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;hw/sysbus.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;hw/irq.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;hw/gpio/avr_gpio.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            +#include &quot;hw/qdev-properties.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            +#include &quot;chardev/char-fe.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +static void avr_gpio_reset(DeviceState *dev)<br style="-webkit-font-smoothing: antialiased;">
            +{<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; AVRGPIOState *gpio = AVR_GPIO(dev);<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; gpio-&gt;ddr_val = 0u;<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; gpio-&gt;port_val = 0u;<br style="-webkit-font-smoothing: antialiased;">
            +}<br style="-webkit-font-smoothing: antialiased;">
            +static uint64_t avr_gpio_read(void *opaque, hwaddr offset,
            unsigned int size)<br style="-webkit-font-smoothing:
              antialiased;">
            +{<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; AVRGPIOState *s = (AVRGPIOState *)opaque;<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; switch (offset) {<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; case GPIO_PIN:<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Not implemented yet */<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; case GPIO_DDR:<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s-&gt;ddr_val;<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; case GPIO_PORT:<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s-&gt;port_val;<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; default:<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad offset
            %lx\n&quot;,<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__, offset);<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; }<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; return 0;<br style="-webkit-font-smoothing:
              antialiased;">
            +}<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +static void avr_gpio_write(void *opaque, hwaddr offset,
            uint64_t value,<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int size)<br style="-webkit-font-smoothing: antialiased;">
            +{<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; AVRGPIOState *s = (AVRGPIOState *)opaque;<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; switch (offset) {<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; case GPIO_PIN:<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Not implemented yet */<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; case GPIO_DDR:<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ddr_val = value &amp; 0xF;<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; case GPIO_PORT:<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;port_val = value &amp; 0xF;<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; default:<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Bad offset
            %lx\n&quot;,<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__, offset);<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; }<br style="-webkit-font-smoothing: antialiased;">
            +}<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +static const MemoryRegionOps avr_gpio_ops = {<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; .read = avr_gpio_read,<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; .write = avr_gpio_write,<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; .endianness = DEVICE_NATIVE_ENDIAN,<br style="-webkit-font-smoothing: antialiased;">
            +};<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +static void avr_gpio_init(Object *obj)<br style="-webkit-font-smoothing: antialiased;">
            +{<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; AVRGPIOState *s = AVR_GPIO(obj);<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; memory_region_init_io(&amp;s-&gt;mmio, obj,
            &amp;avr_gpio_ops, s, TYPE_AVR_GPIO, 3);<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; sysbus_init_mmio(SYS_BUS_DEVICE(obj), &amp;s-&gt;mmio);<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; s-&gt;enabled = true;<br style="-webkit-font-smoothing:
              antialiased;">
            +}<br style="-webkit-font-smoothing: antialiased;">
            +static void avr_gpio_realize(DeviceState *dev, Error
            **errp)<br style="-webkit-font-smoothing: antialiased;">
            +{<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; avr_gpio_reset(dev);<br style="-webkit-font-smoothing:
              antialiased;">
            +}<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +static void avr_gpio_class_init(ObjectClass *klass, void
            *data)<br style="-webkit-font-smoothing: antialiased;">
            +{<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; DeviceClass *dc = DEVICE_CLASS(klass);<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; dc-&gt;reset = avr_gpio_reset;<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; dc-&gt;realize = avr_gpio_realize;<br style="-webkit-font-smoothing: antialiased;">
            +}<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +static const TypeInfo avr_gpio_info = {<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = TYPE_AVR_GPIO,<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = TYPE_SYS_BUS_DEVICE,<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; .instance_size = sizeof(AVRGPIOState),<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; .instance_init = avr_gpio_init,<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; = avr_gpio_class_init,<br style="-webkit-font-smoothing: antialiased;">
            +};<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +static void avr_gpio_register_types(void)<br style="-webkit-font-smoothing: antialiased;">
            +{<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; type_register_static(&amp;avr_gpio_info);<br style="-webkit-font-smoothing: antialiased;">
            +}<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +type_init(avr_gpio_register_types)<br style="-webkit-font-smoothing: antialiased;">
            diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build<br style="-webkit-font-smoothing: antialiased;">
            index 86cae9a0f3..258bd5dcfc 100644<br style="-webkit-font-smoothing: antialiased;">
            --- a/hw/gpio/meson.build<br style="-webkit-font-smoothing:
              antialiased;">
            +++ b/hw/gpio/meson.build<br style="-webkit-font-smoothing:
              antialiased;">
            @@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP',
            if_true: files('omap_gpio.c'))<br style="-webkit-font-smoothing: antialiased;">
            &nbsp;softmmu_ss.add(when: 'CONFIG_RASPI', if_true:
            files('bcm2835_gpio.c'))<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true:
            files('aspeed_gpio.c'))<br style="-webkit-font-smoothing:
              antialiased;">
            &nbsp;softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true:
            files('sifive_gpio.c'))<br style="-webkit-font-smoothing:
              antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true:
            files('avr_gpio.c'))<br style="-webkit-font-smoothing:
              antialiased;">
            diff --git a/include/hw/gpio/avr_gpio.h
            b/include/hw/gpio/avr_gpio.h<br style="-webkit-font-smoothing: antialiased;">
            new file mode 100644<br style="-webkit-font-smoothing:
              antialiased;">
            index 0000000000..45d42753c8<br style="-webkit-font-smoothing: antialiased;">
            --- /dev/null<br style="-webkit-font-smoothing:
              antialiased;">
            +++ b/include/hw/gpio/avr_gpio.h<br style="-webkit-font-smoothing: antialiased;">
            @@ -0,0 +1,48 @@<br style="-webkit-font-smoothing:
              antialiased;">
            +/*<br style="-webkit-font-smoothing: antialiased;">
            + * AVR processors GPIO registers definition.<br style="-webkit-font-smoothing: antialiased;">
            + *<br style="-webkit-font-smoothing: antialiased;">
            + * Copyright (C) 2020 Heecheol Yang
            <a class="moz-txt-link-rfc2396E" href="mailto:heecheol.yang@outlook.com">&lt;heecheol.yang@outlook.com&gt;</a><br style="-webkit-font-smoothing: antialiased;">
            + *<br style="-webkit-font-smoothing: antialiased;">
            + * This program is free software; you can redistribute it
            and/or<br style="-webkit-font-smoothing: antialiased;">
            + * modify it under the terms of the GNU General Public
            License as<br style="-webkit-font-smoothing: antialiased;">
            + * published by the Free Software Foundation; either
            version 2 or<br style="-webkit-font-smoothing: antialiased;">
            + * (at your option) version 3 of the License.<br style="-webkit-font-smoothing: antialiased;">
            + *<br style="-webkit-font-smoothing: antialiased;">
            + * This program is distributed in the hope that it will be
            useful,<br style="-webkit-font-smoothing: antialiased;">
            + * but WITHOUT ANY WARRANTY; without even the implied
            warranty of<br style="-webkit-font-smoothing: antialiased;">
            + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp;
            See the<br style="-webkit-font-smoothing: antialiased;">
            + * GNU General Public License for more details.<br style="-webkit-font-smoothing: antialiased;">
            + *<br style="-webkit-font-smoothing: antialiased;">
            + * You should have received a copy of the GNU General
            Public License along<br style="-webkit-font-smoothing:
              antialiased;">
            + * with this program; if not, see &lt;<a href="http://www.gnu.org/licenses/" target="_blank" rel="noopener noreferrer" data-auth="NotApplicable" style="-webkit-font-smoothing: antialiased; margin: 0px;
              padding: 0px; border: 0px; font: inherit; vertical-align:
              baseline; cursor: pointer;">http://www.gnu.org/licenses/</a>&gt;.<br style="-webkit-font-smoothing: antialiased;">
            + */<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +#ifndef AVR_GPIO_H<br style="-webkit-font-smoothing:
              antialiased;">
            +#define AVR_GPIO_H<br style="-webkit-font-smoothing:
              antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +#include &quot;hw/sysbus.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;qom/object.h&quot;<br style="-webkit-font-smoothing:
              antialiased;">
            +#include &quot;chardev/char-fe.h&quot;<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +/* Offsets of registers. */<br style="-webkit-font-smoothing: antialiased;">
            +#define GPIO_PIN&nbsp;&nbsp; 0x00<br style="-webkit-font-smoothing:
              antialiased;">
            +#define GPIO_DDR&nbsp;&nbsp; 0x01<br style="-webkit-font-smoothing:
              antialiased;">
            +#define GPIO_PORT&nbsp; 0x02<br style="-webkit-font-smoothing:
              antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +#define TYPE_AVR_GPIO &quot;avr-gpio&quot;<br style="-webkit-font-smoothing: antialiased;">
            +OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +struct AVRGPIOState {<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; /*&lt; private &gt;*/<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; SysBusDevice parent_obj;<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; /*&lt; public &gt;*/<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; MemoryRegion mmio;<br style="-webkit-font-smoothing:
              antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +&nbsp;&nbsp;&nbsp; uint8_t ddr_val;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; uint8_t port_val;<br style="-webkit-font-smoothing:
              antialiased;">
            +&nbsp;&nbsp;&nbsp; bool enabled;<br style="-webkit-font-smoothing:
              antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +};<br style="-webkit-font-smoothing: antialiased;">
            +<br style="-webkit-font-smoothing: antialiased;">
            +#endif /* AVR_GPIO_H */<br style="-webkit-font-smoothing:
              antialiased;">
            --<br style="-webkit-font-smoothing: antialiased;">
            2.17.1</div>
        </span></font></div>
  </body>
</html>

--------------05D7FE08FA15F909CA62EF22--

