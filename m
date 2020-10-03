Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57FBC41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 12:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12951206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 12:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12951206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOgHQ-00024N-HR
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 08:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOgGV-0001c6-AF
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 08:03:51 -0400
Received: from mail-dm6nam12olkn2090.outbound.protection.outlook.com
 ([40.92.22.90]:44545 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOgGS-0007UU-Gw
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 08:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItsBXbNB2UrEsKvNvIXI81RZ0BEkTdvoQ9iIbG42ae5Zs0yDucRxkCu7CJspKUWYHYPXhkqGuDWCEQH8VL/jjtlBu2EYm+x6IJqN4bonczO1fWTpOzYKIRrijweLA7ml6OmWkM3kBjIzok3ouZ4Dt39JbttGQe8hvTwgCR7+WTliDaBFAk0uRge70kMTldOxJF9WUEoI3cg4Emtn/gtaQ0w2kvuw4zx5BdXGN5sAMwe1L5lBk3xftC/JeYU4loNP+MgY8JLNvfq2yeW4GIgQo/26xSvGi0uRJi1t5JOfiAdD8dfhhKsoaLhHsotnNbyyDYQhDgPPhkXEYNpwGnOS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TRSWADUkEx5vOgnxW8xV7Q71Cj+PxCAZTsLHFt50+s=;
 b=MFFwXpCT9Pdlopl8XP/tQEwYe2+ODnLcEobT/b6KeQF392PoPgo6e1W+hP49etaOmS1q/642XYwh+CteFwXtm4IxspuU4lbdiQe6vOLHSolJabrbHqLMG712Un3lxFuTEpfBLCfuG0kWhf89vrrDhI+R3WwDCJ7uY7srAFd0SGQOj6nmVYeLewag0QIHoudREBbUJ+4BLxJop7HKty+UVMN56hxTczOq7o1uQ8/SodDDoYpywOAh0spewS0/squZsEB5FNZ/VEEh1k7f/toN+5wZm4vXx80WDDmiJR5gBPhFQ6QqSNO8b3hj53l3Eyt6gz1xtq84u/a7DwqLLaSW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TRSWADUkEx5vOgnxW8xV7Q71Cj+PxCAZTsLHFt50+s=;
 b=dTl1dZQah+2EMePOB8k2lxR4/tfuPDP0nd2WKBkbcnCkQ8UaHrYub2IMM4z8YstpswfA2HOe9kyG9595yduSm6Sgm+PU6lum7plh5X9VCQxvZxcbLDi6AD7GVszKkuNbUo8FRwWQBUaYwNHFytOeoSe1J9vokNvw3e2wKRwg4PV+qcusl+eZmetnK0kEd2r/qnmMJkMz85QvaNgtl4TWoG74CBsFKARcD3yGAIrMIfxGarDFkLfbdDaYGXWTxNL0JKcwqw7zd9dF3FQWO0BrnDpLuu3i5J7g49NT9LoNanhQqzN6p+eZNT9NPHDxklrZaSR89S8knHvB8wZZ4KBnkw==
Received: from DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc64::4e) by
 DM6NAM12HT097.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc64::249)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.14; Sat, 3 Oct
 2020 12:03:41 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:fc64::4b) by DM6NAM12FT004.mail.protection.outlook.com
 (2a01:111:e400:fc64::154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend
 Transport; Sat, 3 Oct 2020 12:03:41 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:716AD8A1C4964077F17D7828D4E87D41745885A53F2D2B9C0F550E5FBFBEC022;
 UpperCasedChecksum:0B9E0A52313B33C3611EEFE81A426A67CC25C3DE3F9D53877A36A6A93D859199;
 SizeAsReceived:8562; Count:44
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.039; Sat, 3 Oct 2020
 12:03:41 +0000
To: qemu-devel@nongnu.org, S.E.Harris@kent.ac.uk, mrolnik@gmail.com,
 heecheol.yang@outlook.com
From: Heecheol Yang <heecheol.yang@outlook.com>
Subject: [PATCH v3] hw/avr: Add limited support for avr gpio registers
Message-ID: <DM6PR16MB2473533AB92D8C3D5EAC18E8E60E0@DM6PR16MB2473.namprd16.prod.outlook.com>
Date: Sat, 3 Oct 2020 21:03:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: multipart/alternative;
 boundary="------------019145E12CE2D065CBF1DE0C"
Content-Language: en-US
X-TMN: [vCvDOety6a4IbRrRom76KDjM8xdp/Li/]
X-ClientProxiedBy: SL2P216CA0058.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:19::20) To DM6PR16MB2473.namprd16.prod.outlook.com
 (2603:10b6:5:6e::28)
X-Microsoft-Original-Message-ID: <0e59c0ff-432e-85a3-c000-21dd64f74e72@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [121.168.203.43] (121.168.203.43) by
 SL2P216CA0058.KORP216.PROD.OUTLOOK.COM (2603:1096:100:19::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34 via Frontend Transport; Sat, 3 Oct 2020 12:03:39 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: acdfe715-70b3-45f8-bc14-08d867945e47
X-MS-Exchange-SLBlob-MailProps: =?utf-8?B?S0U1eXd1T2FONWo1Tm4vVllicXE4NDJKUjRwMDgzbW5yU0I1UWJNbjhVd2hH?=
 =?utf-8?B?WDRrV093TVlqY1pYTStBNEVnSk5iM3NXVkZBWDF2YWU1QXVBRndpdUR5VUY3?=
 =?utf-8?B?YS9NWUhJUmdNY3NSMHRhZEpZWG9CY2k4MVdmUUl6SWhDb0lERk8xdm1oVkdC?=
 =?utf-8?B?elVWaG90RjFKamVMSWJ1UkpITXdML1pqQUo2dlhleFF4SStCaWtMSGdEdlNs?=
 =?utf-8?B?TFZkQ2dBUDZ3WkRPOUdMelV5WFpEMWhuU0NhMlBLdi9DbjAydEVPMk1nT2Yr?=
 =?utf-8?B?VW9NTTRwZG9CM2hHbHdmaHhsZGJSOXo1RENjZ2k3eTYwSkVhNHZwOUl4YlEv?=
 =?utf-8?B?NG5xMzZiYnJmTFI4ZkQvVElKcVVXZURHK20wZVljdWpaZmpvMW5ZQTV5QTlT?=
 =?utf-8?B?SU95T3EvOFAxaUF4MDlTbitHTHJUdW1sOW1lb2lCd0pQbFlCYThYSnlUdjg0?=
 =?utf-8?B?V0IydlZTSGdVdm5nN29GZU5mZGhsemxRRHR2eU9JNFBjV040blo5UHl6SzRx?=
 =?utf-8?B?Qnh4Rjd0ZlA0NkNRZ0lXN1BuQUI0c1l2VnRKaEUxWTFSMk1UWXNyeTdyNGV6?=
 =?utf-8?B?aXY3SlJJejBzNlhUakFvWEpKYWs4RElXR1pZZ04vZ1ByakMyYjh4OUFTMEdy?=
 =?utf-8?B?Y25vL3FHRHR2RzA3MnRNckZDdkxSd2cwWDBXV3VlWGtwNm1TTzhJZDFDUG8x?=
 =?utf-8?B?dUd6S09Rc3FLOU54OWk3SnZzZU9HbHhTdzh3aGV4WFhGK3UyL2RtYTlJNkpO?=
 =?utf-8?B?NzlkT2dRNGs1cEpFcEJmbWdoTFNFSm9CbHNjbS85cEFpVCtQNUYzL0hZL1FM?=
 =?utf-8?B?b2FzR0ExYzRFcCtER09UM002YTRha3cwZ1BDNitTRUZPR25VcEhIaUw2NThZ?=
 =?utf-8?B?UnJRMXRFVy96MVFVSkRiRGlZeGQxcVlyV1R0d0pSY1V5LzRwZi9zQm84NkZi?=
 =?utf-8?B?VHRyQnl3UVZVeDRnd1oyNmJXWFovcXBkMXRwMDd3ZHBPTmZTOXdZK3RUWldz?=
 =?utf-8?B?cVF2djRBdUF3Y1M2dEU3b2txZERLWjhscnNjNGpoSEF6bTNwdTJodi9OYmhj?=
 =?utf-8?B?SmFVTisvQjg4a1FlY0lIQVY3SW5BV09zbVFEcGtYbTJiTkVzVHo2blFockV4?=
 =?utf-8?B?RmpCdVRXNUtBN1dYVEMrdExJZXcvcGhlRmhMcHphZnRkcWYvbnBEOGF1MWFu?=
 =?utf-8?B?cFZCU2dKdVZOUjZQYWdId3FNbllyZnNVYXlwQWFxemVPR1JEcVRIREM4Nmdh?=
 =?utf-8?Q?PqPO+DXiJezQn3vdFME0sbQEb2j9scri35GpumeRCvfU/WU?=
X-MS-TrafficTypeDiagnostic: DM6NAM12HT097:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cex+TzU9KLSHIiqaHxC9Xlz0n04ZeIYCLJOvck0Qk9X4twuyf3rhL5vsiSecZMzRQ1e3r4n//pxPctcTGXjI3oLhXp9Im9KEhOEI5/Vd8k0VCz0kq0zGc0BfZtGEpV23w8Hz/ci4uqYb7EqwX7c2qsKv9bO2qpELhk/7KZXGolazIp3nzJN1/rPjnEvC+Q+JvyCOjfFENPhUeeUzqvCL9nMIQXEfSXHJbGf34ad0G+Bfnleu/Se8h1m3DnAJLtkR
X-MS-Exchange-AntiSpam-MessageData: AODiyOWsJw5rY/OdeP6HH9ZU2wBybnbemCMoyX6pMapbqtyRLMObx4cwNXzbLQbiZrOsshe12KjYWAg9R6S7tn7dq8sVBPUIAQcqVxTBeJTNHLDkJl9SpG+5b9ta2GhOGxJPSCVk14FeN1FkBWY6nA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdfe715-70b3-45f8-bc14-08d867945e47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2020 12:03:41.6650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM12HT097
Received-SPF: pass client-ip=40.92.22.90;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 08:03:46
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------019145E12CE2D065CBF1DE0C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I am very sorry for your inconvenience. This is 3rd version of the patch 
for what I did.
I should have read the contribution guide again and again. I am very 
sorry again.

The contents of the patch is the same with the v2. This mail is just for 
patchew and making a new thread.
Here are what I changed from the v1:

  * Remove unnecessary header inclusions
  * Replace codes for unreachable conditions with g_assert_not_reached()
    function
  * Remove 'enable' field from AVRGPIOState structure: It is actually
    unnecessary. I copied this field from AVRUSARTState structure.


Thanks a lot!
With best regards
Heecheol Yang.

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
  hw/gpio/avr_gpio.c         | 112 +++++++++++++++++++++++++++++++++++++
  hw/gpio/meson.build        |   2 +
  include/hw/gpio/avr_gpio.h |  46 +++++++++++++++
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
+ sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &error_abort);
+ sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0,
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
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
+        g_assert_not_reached();
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
+        g_assert_not_reached();
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
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
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
+
+};
+
+#endif /* AVR_GPIO_H */
-- 
2.17.1


--------------019145E12CE2D065CBF1DE0C
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
    </p>
    <div class="moz-text-html" lang="ko">
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        I am very sorry for your inconvenience. This is 3rd version of
        the patch for what I did.&nbsp;</div>
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        I should have read the contribution guide again and again. I am
        very sorry again.</div>
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        The contents of the patch is the same with the v2. This mail is
        just for patchew and making a new thread.</div>
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <div style="font-size: 12pt; font-family: Gulim, 굴림, &quot;Nanum
          Gothic&quot;, sans-serif">
          Here are what I changed from the v1:</div>
        <div style="font-size: 12pt; font-family: Gulim, 굴림, &quot;Nanum
          Gothic&quot;, sans-serif">
          <ul>
            <li>Remove unnecessary header inclusions</li>
            <li>Replace codes for unreachable conditions with
              g_assert_not_reached() function</li>
            <li>Remove 'enable' field from AVRGPIOState structure: It is
              actually unnecessary. I copied this field from
              AVRUSARTState structure.</li>
          </ul>
        </div>
        <br>
      </div>
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Thanks a lot!</div>
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        With best regards</div>
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Heecheol Yang.</div>
      <div style="font-family: Gulim, 굴림, &quot;Nanum Gothic&quot;,
        sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="PlainText">Add some of these features for avr
                gpio:<br>
                <br>
                &nbsp; - GPIO I/O : PORTx registers<br>
                &nbsp; - Data Direction : DDRx registers<br>
                <br>
                Following things are not supported yet:<br>
                &nbsp; - PINx registers<br>
                &nbsp; - MCUR registers<br>
                &nbsp; - Even though read/write for DDRx registers are<br>
                &nbsp;&nbsp;&nbsp; implemented, actual direction controls are not<br>
                &nbsp;&nbsp;&nbsp; supported yet.<br>
                <br>
                Signed-off-by: Heecheol Yang
                <a class="moz-txt-link-rfc2396E" href="mailto:heecheol.yang@outlook.com">&lt;heecheol.yang@outlook.com&gt;</a><br>
                ---<br>
                &nbsp;hw/avr/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
                &nbsp;hw/avr/atmega.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 ++-<br>
                &nbsp;hw/avr/atmega.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
                &nbsp;hw/gpio/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
                &nbsp;hw/gpio/avr_gpio.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 112
                +++++++++++++++++++++++++++++++++++++<br>
                &nbsp;hw/gpio/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
                &nbsp;include/hw/gpio/avr_gpio.h |&nbsp; 46 +++++++++++++++<br>
                &nbsp;7 files changed, 171 insertions(+), 2 deletions(-)<br>
                &nbsp;create mode 100644 hw/gpio/avr_gpio.c<br>
                &nbsp;create mode 100644 include/hw/gpio/avr_gpio.h<br>
                <br>
                diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br>
                index d31298c3cc..16a57ced11 100644<br>
                --- a/hw/avr/Kconfig<br>
                +++ b/hw/avr/Kconfig<br>
                @@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU<br>
                &nbsp;&nbsp;&nbsp;&nbsp; select AVR_TIMER16<br>
                &nbsp;&nbsp;&nbsp;&nbsp; select AVR_USART<br>
                &nbsp;&nbsp;&nbsp;&nbsp; select AVR_POWER<br>
                +&nbsp;&nbsp;&nbsp; select AVR_GPIO<br>
                &nbsp;<br>
                &nbsp;config ARDUINO<br>
                &nbsp;&nbsp;&nbsp;&nbsp; select AVR_ATMEGA_MCU<br>
                diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c<br>
                index 44c6afebbb..ad942028fd 100644<br>
                --- a/hw/avr/atmega.c<br>
                +++ b/hw/avr/atmega.c<br>
                @@ -283,8 +283,11 @@ static void
                atmega_realize(DeviceState *dev, Error **errp)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devname = g_strdup_printf(&quot;atmega-gpio-%c&quot;, 'a'
                + (char)i);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_unimplemented_device(devname,<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_DATA +
                mc-&gt;dev[idx].addr, 3);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(OBJECT(dev), devname,
                &amp;s-&gt;gpio[i],<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_AVR_GPIO);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gpio[i]),
                &amp;error_abort);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gpio[i]), 0,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_DATA + mc-&gt;dev[idx].addr);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free(devname);<br>
                &nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h<br>
                index a99ee15c7e..e2289d5744 100644<br>
                --- a/hw/avr/atmega.h<br>
                +++ b/hw/avr/atmega.h<br>
                @@ -13,6 +13,7 @@<br>
                &nbsp;<br>
                &nbsp;#include &quot;hw/char/avr_usart.h&quot;<br>
                &nbsp;#include &quot;hw/timer/avr_timer16.h&quot;<br>
                +#include &quot;hw/gpio/avr_gpio.h&quot;<br>
                &nbsp;#include &quot;hw/misc/avr_power.h&quot;<br>
                &nbsp;#include &quot;target/avr/cpu.h&quot;<br>
                &nbsp;#include &quot;qom/object.h&quot;<br>
                @@ -44,6 +45,7 @@ struct AtmegaMcuState {<br>
                &nbsp;&nbsp;&nbsp;&nbsp; DeviceState *io;<br>
                &nbsp;&nbsp;&nbsp;&nbsp; AVRMaskState pwr[POWER_MAX];<br>
                &nbsp;&nbsp;&nbsp;&nbsp; AVRUsartState usart[USART_MAX];<br>
                +&nbsp;&nbsp;&nbsp; AVRGPIOState gpio[GPIO_MAX];<br>
                &nbsp;&nbsp;&nbsp;&nbsp; AVRTimer16State timer[TIMER_MAX];<br>
                &nbsp;&nbsp;&nbsp;&nbsp; uint64_t xtal_freq_hz;<br>
                &nbsp;};<br>
                diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig<br>
                index b6fdaa2586..1752d0ce56 100644<br>
                --- a/hw/gpio/Kconfig<br>
                +++ b/hw/gpio/Kconfig<br>
                @@ -10,3 +10,6 @@ config GPIO_KEY<br>
                &nbsp;<br>
                &nbsp;config SIFIVE_GPIO<br>
                &nbsp;&nbsp;&nbsp;&nbsp; bool<br>
                +<br>
                +config AVR_GPIO<br>
                +&nbsp;&nbsp;&nbsp; bool<br>
                diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c<br>
                new file mode 100644<br>
                index 0000000000..6ca8e8703a<br>
                --- /dev/null<br>
                +++ b/hw/gpio/avr_gpio.c<br>
                @@ -0,0 +1,112 @@<br>
                +/*<br>
                + * AVR processors GPIO registers emulation.<br>
                + *<br>
                + * Copyright (C) 2020 Heecheol Yang
                <a class="moz-txt-link-rfc2396E" href="mailto:heecheol.yang@outlook.com">&lt;heecheol.yang@outlook.com&gt;</a><br>
                + *<br>
                + * This program is free software; you can redistribute
                it and/or<br>
                + * modify it under the terms of the GNU General Public
                License as<br>
                + * published by the Free Software Foundation; either
                version 2 or<br>
                + * (at your option) version 3 of the License.<br>
                + *<br>
                + * This program is distributed in the hope that it will
                be useful,<br>
                + * but WITHOUT ANY WARRANTY; without even the implied
                warranty of<br>
                + * MERCHANTABILITY or FITNESS FOR A PARTICULAR
                PURPOSE.&nbsp; See the<br>
                + * GNU General Public License for more details.<br>
                + *<br>
                + * You should have received a copy of the GNU General
                Public License along<br>
                + * with this program; if not, see &lt;<a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>&gt;.<br>
                + */<br>
                +#include &quot;qemu/osdep.h&quot;<br>
                +#include &quot;qemu/log.h&quot;<br>
                +#include &quot;qemu/module.h&quot;<br>
                +#include &quot;qapi/error.h&quot;<br>
                +#include &quot;hw/sysbus.h&quot;<br>
                +#include &quot;hw/irq.h&quot;<br>
                +#include &quot;hw/gpio/avr_gpio.h&quot;<br>
                +#include &quot;hw/qdev-properties.h&quot;<br>
                +<br>
                +static void avr_gpio_reset(DeviceState *dev)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp; AVRGPIOState *gpio = AVR_GPIO(dev);<br>
                +&nbsp;&nbsp;&nbsp; gpio-&gt;ddr_val = 0u;<br>
                +&nbsp;&nbsp;&nbsp; gpio-&gt;port_val = 0u;<br>
                +}<br>
                +static uint64_t avr_gpio_read(void *opaque, hwaddr
                offset, unsigned int size)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp; AVRGPIOState *s = (AVRGPIOState *)opaque;<br>
                +&nbsp;&nbsp;&nbsp; switch (offset) {<br>
                +&nbsp;&nbsp;&nbsp; case GPIO_PIN:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Not implemented yet */<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp; case GPIO_DDR:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s-&gt;ddr_val;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp; case GPIO_PORT:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s-&gt;port_val;<br>
                +&nbsp;&nbsp;&nbsp; default:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert_not_reached();<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp; }<br>
                +&nbsp;&nbsp;&nbsp; return 0;<br>
                +}<br>
                +<br>
                +static void avr_gpio_write(void *opaque, hwaddr offset,
                uint64_t value,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int size)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp; AVRGPIOState *s = (AVRGPIOState *)opaque;<br>
                +&nbsp;&nbsp;&nbsp; switch (offset) {<br>
                +&nbsp;&nbsp;&nbsp; case GPIO_PIN:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Not implemented yet */<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp; case GPIO_DDR:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ddr_val = value &amp; 0xF;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp; case GPIO_PORT:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;port_val = value &amp; 0xF;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp; default:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_assert_not_reached();<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp; }<br>
                +}<br>
                +<br>
                +static const MemoryRegionOps avr_gpio_ops = {<br>
                +&nbsp;&nbsp;&nbsp; .read = avr_gpio_read,<br>
                +&nbsp;&nbsp;&nbsp; .write = avr_gpio_write,<br>
                +&nbsp;&nbsp;&nbsp; .endianness = DEVICE_NATIVE_ENDIAN,<br>
                +};<br>
                +<br>
                +static void avr_gpio_init(Object *obj)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp; AVRGPIOState *s = AVR_GPIO(obj);<br>
                +&nbsp;&nbsp;&nbsp; memory_region_init_io(&amp;s-&gt;mmio, obj,
                &amp;avr_gpio_ops, s, TYPE_AVR_GPIO, 3);<br>
                +&nbsp;&nbsp;&nbsp; sysbus_init_mmio(SYS_BUS_DEVICE(obj),
                &amp;s-&gt;mmio);<br>
                +}<br>
                +static void avr_gpio_realize(DeviceState *dev, Error
                **errp)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp; avr_gpio_reset(dev);<br>
                +}<br>
                +<br>
                +<br>
                +static void avr_gpio_class_init(ObjectClass *klass,
                void *data)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp; DeviceClass *dc = DEVICE_CLASS(klass);<br>
                +<br>
                +&nbsp;&nbsp;&nbsp; dc-&gt;reset = avr_gpio_reset;<br>
                +&nbsp;&nbsp;&nbsp; dc-&gt;realize = avr_gpio_realize;<br>
                +}<br>
                +<br>
                +static const TypeInfo avr_gpio_info = {<br>
                +&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = TYPE_AVR_GPIO,<br>
                +&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = TYPE_SYS_BUS_DEVICE,<br>
                +&nbsp;&nbsp;&nbsp; .instance_size = sizeof(AVRGPIOState),<br>
                +&nbsp;&nbsp;&nbsp; .instance_init = avr_gpio_init,<br>
                +&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; = avr_gpio_class_init,<br>
                +};<br>
                +<br>
                +static void avr_gpio_register_types(void)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp; type_register_static(&amp;avr_gpio_info);<br>
                +}<br>
                +<br>
                +type_init(avr_gpio_register_types)<br>
                diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build<br>
                index 86cae9a0f3..258bd5dcfc 100644<br>
                --- a/hw/gpio/meson.build<br>
                +++ b/hw/gpio/meson.build<br>
                @@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP',
                if_true: files('omap_gpio.c'))<br>
                &nbsp;softmmu_ss.add(when: 'CONFIG_RASPI', if_true:
                files('bcm2835_gpio.c'))<br>
                &nbsp;softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true:
                files('aspeed_gpio.c'))<br>
                &nbsp;softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true:
                files('sifive_gpio.c'))<br>
                +<br>
                +softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true:
                files('avr_gpio.c'))<br>
                diff --git a/include/hw/gpio/avr_gpio.h
                b/include/hw/gpio/avr_gpio.h<br>
                new file mode 100644<br>
                index 0000000000..84d783f8fc<br>
                --- /dev/null<br>
                +++ b/include/hw/gpio/avr_gpio.h<br>
                @@ -0,0 +1,46 @@<br>
                +/*<br>
                + * AVR processors GPIO registers definition.<br>
                + *<br>
                + * Copyright (C) 2020 Heecheol Yang
                <a class="moz-txt-link-rfc2396E" href="mailto:heecheol.yang@outlook.com">&lt;heecheol.yang@outlook.com&gt;</a><br>
                + *<br>
                + * This program is free software; you can redistribute
                it and/or<br>
                + * modify it under the terms of the GNU General Public
                License as<br>
                + * published by the Free Software Foundation; either
                version 2 or<br>
                + * (at your option) version 3 of the License.<br>
                + *<br>
                + * This program is distributed in the hope that it will
                be useful,<br>
                + * but WITHOUT ANY WARRANTY; without even the implied
                warranty of<br>
                + * MERCHANTABILITY or FITNESS FOR A PARTICULAR
                PURPOSE.&nbsp; See the<br>
                + * GNU General Public License for more details.<br>
                + *<br>
                + * You should have received a copy of the GNU General
                Public License along<br>
                + * with this program; if not, see &lt;<a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>&gt;.<br>
                + */<br>
                +<br>
                +#ifndef AVR_GPIO_H<br>
                +#define AVR_GPIO_H<br>
                +<br>
                +#include &quot;hw/sysbus.h&quot;<br>
                +#include &quot;qom/object.h&quot;<br>
                +<br>
                +/* Offsets of registers. */<br>
                +#define GPIO_PIN&nbsp;&nbsp; 0x00<br>
                +#define GPIO_DDR&nbsp;&nbsp; 0x01<br>
                +#define GPIO_PORT&nbsp; 0x02<br>
                +<br>
                +#define TYPE_AVR_GPIO &quot;avr-gpio&quot;<br>
                +OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)<br>
                +<br>
                +struct AVRGPIOState {<br>
                +&nbsp;&nbsp;&nbsp; /*&lt; private &gt;*/<br>
                +&nbsp;&nbsp;&nbsp; SysBusDevice parent_obj;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp; /*&lt; public &gt;*/<br>
                +&nbsp;&nbsp;&nbsp; MemoryRegion mmio;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp; uint8_t ddr_val;<br>
                +&nbsp;&nbsp;&nbsp; uint8_t port_val;<br>
                +<br>
                +};<br>
                +<br>
                +#endif /* AVR_GPIO_H */<br>
                -- <br>
                2.17.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </div>
  </body>
</html>

--------------019145E12CE2D065CBF1DE0C--

