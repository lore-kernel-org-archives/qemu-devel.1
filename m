Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MISSING_HEADERS,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B33C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 14:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29CE24680
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="Z3iUTXLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29CE24680
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j82rH-0000ku-Tx
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 09:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1j82pZ-0008At-Fl
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 09:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1j82pW-0005x3-AS
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 09:11:01 -0500
Received: from mail-eopbgr1280097.outbound.protection.outlook.com
 ([40.107.128.97]:19232 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>)
 id 1j82pO-0005if-Qs; Sat, 29 Feb 2020 09:10:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPrnoc7tT5wuBSFg3d8IEYGlGpzjD4BIw2/CkfAGhD7JX1l/T96m72oRT0tU+r1qSgFVoKyYDCz/sg8oo4gKSiWJj8uIIeC79nqwhcy+dLz/FjRxxkkl5F1w3mpWrUqaHEmmUdOOJKkyD0YIwfHbsAv+f/dchiVdMz/Hsv0Jr4X6qyZq4vAp/hCDmAMAEbVscubA4y63hiUtmUlux2ClY9EUat6f+7gDIH8chUBalvbNKLV0b3Z4IlkYJ/VsiYy/2rUuds7N3lY8U2490BounpXpAWsMgvtb7n5XU4zR06ScXuZ5TbAdbyAvJ0zZVt92e0p+Kf0QgMWWidykbi/0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM/GFBcluLE3RXq2SOGAv+RQIs04rRgco+6eY+lzKOg=;
 b=cq93pqg60hVVey8BccHphYcKPJsKgUTmBVAYn3wwOcgLEEpQZ9rnhoWyeFMhhDpZJ82Sp44vBLSxrIwdunr0GZaZO8kIJG7QBffaFYAvL+WYZ0tgGFHcx3HrBjBO9KOXRPbtVox84FNoYRbyT3EWtN8Od0o3y/axzKpkRw9ui6JA0DNPSQ/Aqpn9Lkxxfuiy36c5vlUSo8JwTIOvUl2XnVJgEQc2HYQS7f+egoBEXjFvB3CUpOk5zFYWMWRT3XvR0p8EfQNVCd5AR88XlhrgiUIjPbUX8whTcIbmTP6DPMARRkKrYqPoj+kw8r2CnBN9WSYJnB2R5imMEEwWocyCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM/GFBcluLE3RXq2SOGAv+RQIs04rRgco+6eY+lzKOg=;
 b=Z3iUTXLdwTgiIBtdvKfyeieBobnO3+2HoMnb80f6n0/hIyFhftwL5K4gCgcbPKAOyQieun2sVCf4bAIuNRSOIYAAXGqjpemDICQ08A0tkTM9hcQFeJGFWJMCVZiM7F0LuAFW7yGTAQkJaguUAekcLV+14tP0do50C3JxksZtkGo=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0783.KORP216.PROD.OUTLOOK.COM (10.174.41.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Sat, 29 Feb 2020 14:10:44 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2772.018; Sat, 29 Feb 2020
 14:10:44 +0000
Received: from DOMINUS.corp.kimin.kr (1.214.196.86) by
 HK2PR0401CA0023.apcprd04.prod.outlook.com (2603:1096:202:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Sat, 29 Feb 2020 14:10:42 +0000
From: Stephanos Ioannidis <root@stephanos.io>
Subject: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
Thread-Topic: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
Thread-Index: AQHV7woHqkXTlwmtzEaPvIqQyhXhpw==
Date: Sat, 29 Feb 2020 14:10:43 +0000
Message-ID: <20200229141011.58989-1-root@stephanos.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0401CA0023.apcprd04.prod.outlook.com
 (2603:1096:202:2::33) To SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:9::8)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.214.196.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4093f0f2-cbb2-4f89-3af5-08d7bd212a2e
x-ms-traffictypediagnostic: SLXP216MB0783:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SLXP216MB0783D4B46A431D921C5D0A5CBDE90@SLXP216MB0783.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39830400003)(199004)(189003)(316002)(54906003)(186003)(66946007)(66556008)(66476007)(16526019)(109986005)(5660300002)(19627235002)(2906002)(30864003)(2616005)(71200400001)(4326008)(1076003)(66446008)(64756008)(956004)(36756003)(81156014)(81166006)(8676002)(6512007)(86362001)(6506007)(8936002)(6486002)(478600001)(26005)(52116002)(36456003)(42976004)(579004)(559001)(473944003)(414714003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0783;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OaRdBmXUtUMm/UEltYs9pxCNeyPn1qAb3fnAeEVIvfIVTDKYMl0IaC6cme+e9NR/d6MdQ2uy+8S2A/0wnI8CaKPtB1snhxs1ejcO96jVClWTEJOK3eP6sKwd5gAjTQ/yi94519WUBe9S0UxbDOl+KiHy1IDa28mIiR4VnltIDRlwD+hrurPneNNkgcu1ZM3mpois9pjXIBlV5rtOiw59xz6W01kPMxGE7HWNJKq7w05xMggly1Pqw/eC1Xn9vGZu5YK6fNr9dvI0vemXFCFB7FlzI75+qSDawIDG2tEFcaV6osdJ5tIDixmhtbAJ37qcUFoQlgqaRGIhLF/9uztlgeMjW+6GkfwUBvtHtJfsc2MOZ1n6mtw/kn/FIllch18OuhXYlVRCRz5dbH/2vB6S7DmoLwIgedfJvqEZ0zkLC6EBy0aEpiGYsu6uoA+3Q/Prz8XcE1bueGT4gi2Q3cuhXmFwnoNN/OEVRdvC1k5AVvJDDULJ77SF0Zo8RfHFC2cPHWyxlfyz+aUbEPvR+h122GBGZzOS4p5Q+0/w5fCBu8aOgoZwUF1p2z9boPpLOAg9
x-ms-exchange-antispam-messagedata: UlCcM85tSOKGhrhcgHGEJcoGG4cvmORDwhb8W0rHmAuOniWHG1gMR0IDx0nmfLn3n8TcznRCQ+SDmGjqMEDwHKWU+kpcQ5/+uFpFJB8KCF0WWtpyn+pTPx3APbI2mCoA5i1iB8mCnRGOfvf/iABTCw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 4093f0f2-cbb2-4f89-3af5-08d7bd212a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 14:10:43.8566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiw+Oq91oyl2vhUMDBgWb0Ri5qBV3zzCqUo0JonfgyOxRq0s2zaLkswrZMZSxUudVCwPcL9QGWGeWF31II4W3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0783
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.97
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
 Alistair Francis <alistair@alistair23.me>,
 Stephanos Ioannidis <root@stephanos.io>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>, "open
 list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The RCC (reset and clock control) is a hardware peripheral reset and
clock configuration controller available on the STM32F4xx series
devices.

This commit adds preliminary support for the RCC peripheral emulation,
in order to support proper emulation of the firmware images that use
the STM32Cube driver, which configures and validates the RCC registers
during system initialisation.

In addition, the current STM32F405 SoC implementation does not specify
the Cortex-M SysTick clock scaling factor and this causes the QEMU to
become unresponsive as soon as the SysTick timer is enabled by the
guest. This problem is addressed by configuring the SysTick clock
scaling factor from the AHB clock frequency computed using the RCC
clock configurations.

Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
---
 hw/arm/Kconfig                  |   1 +
 hw/arm/netduinoplus2.c          |   1 +
 hw/arm/stm32f405_soc.c          |  17 +-
 hw/misc/Kconfig                 |   3 +
 hw/misc/Makefile.objs           |   1 +
 hw/misc/stm32f4xx_rcc.c         | 472 ++++++++++++++++++++++++++++++++
 hw/misc/trace-events            |   4 +
 include/hw/arm/stm32f405_soc.h  |   3 +
 include/hw/misc/stm32f4xx_rcc.h | 316 +++++++++++++++++++++
 9 files changed, 817 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/stm32f4xx_rcc.c
 create mode 100644 include/hw/misc/stm32f4xx_rcc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d86691ae0..16442b3c4b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -314,6 +314,7 @@ config STM32F205_SOC
 config STM32F405_SOC
     bool
     select ARM_V7M
+    select STM32F4XX_RCC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
=20
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index e5e247edbe..37d57dafe4 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -36,6 +36,7 @@ static void netduinoplus2_init(MachineState *machine)
=20
     dev =3D qdev_create(NULL, TYPE_STM32F405_SOC);
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    qdev_prop_set_uint32(dev, "hse-frequency", 25000000);
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu),
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 9bcad97853..5abbbc96c0 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -30,6 +30,7 @@
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/misc/unimp.h"
=20
+#define RCC_ADDR                       0x40023800
 #define SYSCFG_ADD                     0x40013800
 static const uint32_t usart_addr[] =3D { 0x40011000, 0x40004400, 0x4000480=
0,
                                        0x40004C00, 0x40005000, 0x40011400,
@@ -59,6 +60,9 @@ static void stm32f405_soc_initfn(Object *obj)
     sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
                           TYPE_ARMV7M);
=20
+    sysbus_init_child_obj(obj, "rcc", &s->rcc, sizeof(s->rcc),
+                          TYPE_STM32F4XX_RCC);
+
     sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
                           TYPE_STM32F4XX_SYSCFG);
=20
@@ -130,6 +134,17 @@ static void stm32f405_soc_realize(DeviceState *dev_soc=
, Error **errp)
         return;
     }
=20
+    /* Reset and clock control */
+    dev =3D DEVICE(&s->rcc);
+    qdev_prop_set_uint32(dev, "hse-frequency", s->hse_frequency);
+    object_property_set_bool(OBJECT(&s->rcc), true, "realized", &err);
+    if (err !=3D NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev =3D SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, RCC_ADDR);
+
     /* System configuration controller */
     dev =3D DEVICE(&s->syscfg);
     object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
@@ -260,7 +275,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
     create_unimplemented_device("GPIOI",       0x40022000, 0x400);
     create_unimplemented_device("CRC",         0x40023000, 0x400);
-    create_unimplemented_device("RCC",         0x40023800, 0x400);
     create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
     create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
     create_unimplemented_device("DMA1",        0x40026000, 0x400);
@@ -274,6 +288,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc,=
 Error **errp)
=20
 static Property stm32f405_soc_properties[] =3D {
     DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
+    DEFINE_PROP_UINT32("hse-frequency", STM32F405State, hse_frequency, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index bdd77d8020..0cb5f2af68 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -79,6 +79,9 @@ config IMX
     select SSI
     select USB_EHCI_SYSBUS
=20
+config STM32F4XX_RCC
+    bool
+
 config STM32F2XX_SYSCFG
     bool
=20
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index da993f45b7..58a856c00d 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -58,6 +58,7 @@ common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o
 common-obj-$(CONFIG_SLAVIO) +=3D slavio_misc.o
 common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
 common-obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
+common-obj-$(CONFIG_STM32F4XX_RCC) +=3D stm32f4xx_rcc.o
 common-obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.o
 common-obj-$(CONFIG_STM32F4XX_SYSCFG) +=3D stm32f4xx_syscfg.o
 common-obj-$(CONFIG_STM32F4XX_EXTI) +=3D stm32f4xx_exti.o
diff --git a/hw/misc/stm32f4xx_rcc.c b/hw/misc/stm32f4xx_rcc.c
new file mode 100644
index 0000000000..297f2430b8
--- /dev/null
+++ b/hw/misc/stm32f4xx_rcc.c
@@ -0,0 +1,472 @@
+/*
+ * STM32F4xx RCC
+ *
+ * Copyright (c) 2020 Stephanos Ioannidis <root@stephanos.io>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "hw/misc/stm32f4xx_rcc.h"
+#include "hw/timer/armv7m_systick.h"
+
+#define HSI_FREQ    (16000000)
+
+static void rcc_update_clock(STM32F4xxRccState *s)
+{
+    uint32_t pll_src, pll_prediv, pll_mult, pll_postdiv, pll_freq;
+    uint32_t ahb_div, ahb_freq;
+    uint32_t sysclk_freq;
+    uint32_t systick_freq;
+
+    /* Resolve PLL clock source */
+    pll_src =3D s->rcc_pllcfgr.pllsrc ? s->hse_frequency : HSI_FREQ;
+
+    /* Resolve PLL input division factor */
+    switch (s->rcc_pllcfgr.pllm) {
+    case 0b000010 ... 0b111111:
+        pll_prediv =3D s->rcc_pllcfgr.pllm;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Invalid PLLM\n", __func__);
+        return;
+    }
+
+    /* Resolve PLL VCO multiplication factor */
+    switch (s->rcc_pllcfgr.plln) {
+    case 0b000110010 ... 0b110110000:
+        pll_mult =3D s->rcc_pllcfgr.plln;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Invalid PLLN\n", __func__);
+        return;
+    }
+
+    /* Resolve PLL output division factor */
+    switch (s->rcc_pllcfgr.pllp) {
+    case 0b00:
+        pll_postdiv =3D 2;
+        break;
+    case 0b01:
+        pll_postdiv =3D 4;
+        break;
+    case 0b10:
+        pll_postdiv =3D 6;
+        break;
+    case 0b11:
+        pll_postdiv =3D 8;
+        break;
+    }
+
+    /* Compute PLL output frequency */
+    pll_freq =3D pll_src / pll_prediv * pll_mult / pll_postdiv;
+
+    /* Resolve SYSCLK frequency */
+    switch (s->rcc_cfgr.sw) {
+    case 0b00: /* High-speed internal oscillator (fixed at 16MHz) */
+        sysclk_freq =3D HSI_FREQ;
+        break;
+    case 0b01: /* High-speed external oscillator */
+        sysclk_freq =3D s->hse_frequency;
+        break;
+    case 0b10: /* PLL */
+        sysclk_freq =3D pll_freq;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Invalid system clock source selected\n", __func__);
+        return;
+    }
+
+    /* Resolve AHB prescaler division ratio */
+    switch (s->rcc_cfgr.hpre) {
+    case 0b0000 ... 0b0111:
+        ahb_div =3D 1;
+        break;
+    case 0b1000:
+        ahb_div =3D 2;
+        break;
+    case 0b1001:
+        ahb_div =3D 4;
+        break;
+    case 0b1010:
+        ahb_div =3D 8;
+        break;
+    case 0b1011:
+        ahb_div =3D 16;
+        break;
+    case 0b1100:
+        ahb_div =3D 64;
+        break;
+    case 0b1101:
+        ahb_div =3D 128;
+        break;
+    case 0b1110:
+        ahb_div =3D 256;
+        break;
+    case 0b1111:
+        ahb_div =3D 512;
+        break;
+    }
+
+    /* Compute AHB frequency */
+    ahb_freq =3D sysclk_freq / ahb_div;
+
+    /* Compute and set Cortex-M SysTick timer clock frequency */
+    systick_freq =3D ahb_freq / 8;
+    system_clock_scale =3D 1000000000 / systick_freq;
+}
+
+static void stm32f4xx_rcc_reset(DeviceState *dev)
+{
+    STM32F4xxRccState *s =3D STM32F4XX_RCC(dev);
+
+    /* Initialise register values */
+    s->rcc_cr.reg =3D 0x00000083;
+    s->rcc_pllcfgr.reg =3D 0x24003010;
+    s->rcc_cfgr.reg =3D 0x00000000;
+    s->rcc_cir.reg =3D 0x00000000;
+    s->rcc_ahb1rstr.reg =3D 0x00000000;
+    s->rcc_ahb2rstr.reg =3D 0x00000000;
+    s->rcc_ahb3rstr.reg =3D 0x00000000;
+    s->rcc_apb1rstr.reg =3D 0x00000000;
+    s->rcc_apb2rstr.reg =3D 0x00000000;
+    s->rcc_ahb1enr.reg =3D 0x00100000;
+    s->rcc_ahb2enr.reg =3D 0x00000000;
+    s->rcc_ahb3enr.reg =3D 0x00000000;
+    s->rcc_apb1enr.reg =3D 0x00000000;
+    s->rcc_apb2enr.reg =3D 0x00000000;
+    s->rcc_ahb1lpenr.reg =3D 0x7E6791FF;
+    s->rcc_ahb2lpenr.reg =3D 0x000000F1;
+    s->rcc_ahb3lpenr.reg =3D 0x00000001;
+    s->rcc_apb1lpenr.reg =3D 0x36FEC9FF;
+    s->rcc_apb2lpenr.reg =3D 0x00075F33;
+    s->rcc_bdcr.reg =3D 0x00000000;
+    s->rcc_csr.reg =3D 0x0E000000;
+    s->rcc_sscgr.reg =3D 0x00000000;
+    s->rcc_plli2scfgr.reg =3D 0x20003000;
+
+    /* Update clock based on the reset state */
+    rcc_update_clock(s);
+}
+
+static void rcc_cr_write(STM32F4xxRccState *s, RccCrType val)
+{
+    /* Set internal high-speed clock state */
+    s->rcc_cr.hsirdy =3D s->rcc_cr.hsion =3D val.hsion;
+    /* Set external high-speed clock state */
+    s->rcc_cr.hserdy =3D s->rcc_cr.hseon =3D val.hseon;
+    /* Set external clock bypass state */
+    s->rcc_cr.hsebyp =3D s->rcc_cr.hserdy && val.hsebyp;
+    /* Set PLL state */
+    s->rcc_cr.pllrdy =3D s->rcc_cr.pllon =3D val.pllon;
+    /* Set I2S PLL state */
+    s->rcc_cr.plli2srdy =3D s->rcc_cr.plli2son =3D val.plli2son;
+
+    /* Update clock */
+    rcc_update_clock(s);
+}
+
+static void rcc_pllcfgr_write(STM32F4xxRccState *s, RccPllcfgrType val)
+{
+    /* Set PLL entry clock source */
+    s->rcc_pllcfgr.pllsrc =3D val.pllsrc;
+    /* Set main PLL input division factor */
+    s->rcc_pllcfgr.pllm =3D val.pllm;
+    /* Set main PLL multiplication factor for VCO */
+    s->rcc_pllcfgr.plln =3D val.plln;
+    /* Set main PLL output division factor */
+    s->rcc_pllcfgr.pllp =3D val.pllp;
+
+    /* Update clock */
+    rcc_update_clock(s);
+}
+
+static void rcc_cfgr_write(STM32F4xxRccState *s, RccCfgrType val)
+{
+    /* Set clock switch status */
+    s->rcc_cfgr.sw =3D s->rcc_cfgr.sws =3D val.sw;
+    /* Set AHB prescaler clock division factor */
+    s->rcc_cfgr.hpre =3D val.hpre;
+
+    /* Update clock */
+    rcc_update_clock(s);
+}
+
+static void rcc_csr_write(STM32F4xxRccState *s, RccCsrType val)
+{
+    /* Set internal low-speed oscillator state */
+    s->rcc_csr.lsirdy =3D s->rcc_csr.lsion =3D val.lsion;
+
+    /* Update clock */
+    rcc_update_clock(s);
+}
+
+static uint64_t stm32f4xx_rcc_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    STM32F4xxRccState *s =3D opaque;
+
+    trace_stm32f4xx_rcc_read(addr);
+
+    switch (addr) {
+    case RCC_CR:
+        return s->rcc_cr.reg;
+    case RCC_PLLCFGR:
+        return s->rcc_pllcfgr.reg;
+    case RCC_CFGR:
+        return s->rcc_cfgr.reg;
+    case RCC_CIR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: Clock interrupt configuration is not supported in QEMU\n"=
,
+            __func__);
+        return s->rcc_cir.reg;
+    case RCC_AHB1RSTR:
+        return s->rcc_ahb1rstr.reg;
+    case RCC_AHB2RSTR:
+        return s->rcc_ahb2rstr.reg;
+    case RCC_AHB3RSTR:
+        return s->rcc_ahb3rstr.reg;
+    case RCC_APB1RSTR:
+        return s->rcc_apb1rstr.reg;
+    case RCC_APB2RSTR:
+        return s->rcc_apb2rstr.reg;
+    case RCC_AHB1ENR:
+        return s->rcc_ahb1enr.reg;
+    case RCC_AHB2ENR:
+        return s->rcc_ahb2enr.reg;
+    case RCC_AHB3ENR:
+        return s->rcc_ahb3enr.reg;
+    case RCC_APB1ENR:
+        return s->rcc_apb1enr.reg;
+    case RCC_APB2ENR:
+        return s->rcc_apb2enr.reg;
+    case RCC_AHB1LPENR:
+        return s->rcc_ahb1lpenr.reg;
+    case RCC_AHB2LPENR:
+        return s->rcc_ahb2lpenr.reg;
+    case RCC_AHB3LPENR:
+        return s->rcc_ahb3lpenr.reg;
+    case RCC_APB1LPENR:
+        return s->rcc_apb1lpenr.reg;
+    case RCC_APB2LPENR:
+        return s->rcc_apb2lpenr.reg;
+    case RCC_BDCR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: Backup domain control is not supported in QEMU\n",
+            __func__);
+        return s->rcc_bdcr.reg;
+    case RCC_CSR:
+        return s->rcc_csr.reg;
+    case RCC_SSCGR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: Spread spectrum clock generation is not supported in QEMU=
\n",
+            __func__);
+        return s->rcc_sscgr.reg;
+    case RCC_PLLI2SCFGR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: PLLI2S configuration is not supported in QEMU\n",
+            __func__);
+        return s->rcc_plli2scfgr.reg;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        return 0;
+    }
+}
+
+static void stm32f4xx_rcc_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    STM32F4xxRccState *s =3D opaque;
+    uint32_t value =3D val64;
+
+    trace_stm32f4xx_rcc_write(value, addr);
+
+    switch (addr) {
+    case RCC_CR:
+        rcc_cr_write(s, (RccCrType)value);
+        return;
+    case RCC_PLLCFGR:
+        rcc_pllcfgr_write(s, (RccPllcfgrType)value);
+        return;
+    case RCC_CFGR:
+        rcc_cfgr_write(s, (RccCfgrType)value);
+        return;
+    case RCC_CIR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: Clock interrupt configuration is not supported in QEMU\n"=
,
+            __func__);
+        return;
+    case RCC_AHB1RSTR ... RCC_APB2RSTR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: Peripheral reset is a no-op in QEMU\n", __func__);
+        return;
+    case RCC_AHB1ENR:
+        /* Store peripheral enable status; otherwise, this is no-op */
+        s->rcc_ahb1enr.reg =3D value;
+        return;
+    case RCC_AHB2ENR:
+        s->rcc_ahb2enr.reg =3D value;
+        return;
+    case RCC_AHB3ENR:
+        s->rcc_ahb3enr.reg =3D value;
+        return;
+    case RCC_APB1ENR:
+        s->rcc_apb1enr.reg =3D value;
+        return;
+    case RCC_APB2ENR:
+        s->rcc_apb2enr.reg =3D value;
+        return;
+    case RCC_AHB1LPENR:
+        /* Store peripheral low power status; otherwise, this is no-op */
+        s->rcc_ahb1lpenr.reg =3D value;
+        return;
+    case RCC_AHB2LPENR:
+        s->rcc_ahb2lpenr.reg =3D value;
+        return;
+    case RCC_AHB3LPENR:
+        s->rcc_ahb3lpenr.reg =3D value;
+        return;
+    case RCC_APB1LPENR:
+        s->rcc_apb1lpenr.reg =3D value;
+        return;
+    case RCC_APB2LPENR:
+        s->rcc_apb2lpenr.reg =3D value;
+        return;
+    case RCC_BDCR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: Backup domain control is not supported in QEMU\n",
+            __func__);
+        return;
+    case RCC_CSR:
+        rcc_csr_write(s, (RccCsrType)value);
+        return;
+    case RCC_SSCGR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: Spread spectrum clock generation is not supported in QEMU=
\n",
+            __func__);
+        return;
+    case RCC_PLLI2SCFGR:
+        qemu_log_mask(
+            LOG_UNIMP,
+            "%s: PLLI2S configuration is not supported in QEMU\n",
+            __func__);
+        return;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_rcc_ops =3D {
+    .read =3D stm32f4xx_rcc_read,
+    .write =3D stm32f4xx_rcc_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32f4xx_rcc_init(Object *obj)
+{
+    STM32F4xxRccState *s =3D STM32F4XX_RCC(obj);
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_rcc_ops, s,
+                          TYPE_STM32F4XX_RCC, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static const VMStateDescription vmstate_stm32f4xx_rcc =3D {
+    .name =3D TYPE_STM32F4XX_RCC,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(rcc_cr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_pllcfgr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_cfgr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_cir.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb1rstr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb2rstr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb3rstr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_apb1rstr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_apb2rstr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb1enr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb2enr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb3enr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_apb1enr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_apb2enr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb1lpenr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb2lpenr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_ahb3lpenr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_apb1lpenr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_apb2lpenr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_bdcr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_csr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_sscgr.reg, STM32F4xxRccState),
+        VMSTATE_UINT32(rcc_plli2scfgr.reg, STM32F4xxRccState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property stm32f4xx_rcc_properties[] =3D {
+    DEFINE_PROP_UINT32("hse-frequency", STM32F4xxRccState, hse_frequency, =
0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void stm32f4xx_rcc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->reset =3D stm32f4xx_rcc_reset;
+    dc->vmsd =3D &vmstate_stm32f4xx_rcc;
+    device_class_set_props(dc, stm32f4xx_rcc_properties);
+}
+
+static const TypeInfo stm32f4xx_rcc_info =3D {
+    .name          =3D TYPE_STM32F4XX_RCC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(STM32F4xxRccState),
+    .instance_init =3D stm32f4xx_rcc_init,
+    .class_init    =3D stm32f4xx_rcc_class_init,
+};
+
+static void stm32f4xx_rcc_register_types(void)
+{
+    type_register_static(&stm32f4xx_rcc_info);
+}
+
+type_init(stm32f4xx_rcc_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 7f0f5dff3a..0fa47598b5 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -84,6 +84,10 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=3D0x%"PRIx64 " val=3D0x%"P=
RIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=3D0x%"PRIx64 " val=3D0x%x"
=20
+# stm32f4xx_rcc
+stm32f4xx_rcc_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
+stm32f4xx_rcc_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" P=
RIx64 " val: 0x%" PRIx64 ""
+
 # stm32f4xx_syscfg
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %=
d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.=
h
index 1fe97f8c3a..037db62a58 100644
--- a/include/hw/arm/stm32f405_soc.h
+++ b/include/hw/arm/stm32f405_soc.h
@@ -25,6 +25,7 @@
 #ifndef HW_ARM_STM32F405_SOC_H
 #define HW_ARM_STM32F405_SOC_H
=20
+#include "hw/misc/stm32f4xx_rcc.h"
 #include "hw/misc/stm32f4xx_syscfg.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "hw/char/stm32f2xx_usart.h"
@@ -54,9 +55,11 @@ typedef struct STM32F405State {
     /*< public >*/
=20
     char *cpu_type;
+    uint32_t hse_frequency;
=20
     ARMv7MState armv7m;
=20
+    STM32F4xxRccState rcc;
     STM32F4xxSyscfgState syscfg;
     STM32F4xxExtiState exti;
     STM32F2XXUsartState usart[STM_NUM_USARTS];
diff --git a/include/hw/misc/stm32f4xx_rcc.h b/include/hw/misc/stm32f4xx_rc=
c.h
new file mode 100644
index 0000000000..5c269753c0
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_rcc.h
@@ -0,0 +1,316 @@
+/*
+ * STM32F4xx RCC
+ *
+ * Copyright (c) 2020 Stephanos Ioannidis <root@stephanos.io>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_STM_RCC_H
+#define HW_STM_RCC_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define TYPE_STM32F4XX_RCC "stm32f4xx-rcc"
+#define STM32F4XX_RCC(obj) \
+    OBJECT_CHECK(STM32F4xxRccState, (obj), TYPE_STM32F4XX_RCC)
+
+#define RCC_CR         0x00
+#define RCC_PLLCFGR    0x04
+#define RCC_CFGR       0x08
+#define RCC_CIR        0x0C
+#define RCC_AHB1RSTR   0x10
+#define RCC_AHB2RSTR   0x14
+#define RCC_AHB3RSTR   0x18
+#define RCC_APB1RSTR   0x20
+#define RCC_APB2RSTR   0x24
+#define RCC_AHB1ENR    0x30
+#define RCC_AHB2ENR    0x34
+#define RCC_AHB3ENR    0x38
+#define RCC_APB1ENR    0x40
+#define RCC_APB2ENR    0x44
+#define RCC_AHB1LPENR  0x50
+#define RCC_AHB2LPENR  0x54
+#define RCC_AHB3LPENR  0x58
+#define RCC_APB1LPENR  0x60
+#define RCC_APB2LPENR  0x64
+#define RCC_BDCR       0x70
+#define RCC_CSR        0x74
+#define RCC_SSCGR      0x80
+#define RCC_PLLI2SCFGR 0x84
+
+typedef union {
+    struct {
+        uint32_t hsion : 1;
+        uint32_t hsirdy : 1;
+        uint32_t reserved0 : 1;
+        uint32_t hsitrim : 5;
+        uint32_t hsical : 8;
+        uint32_t hseon : 1;
+        uint32_t hserdy : 1;
+        uint32_t hsebyp : 1;
+        uint32_t csson : 1;
+        uint32_t reserved1 : 4;
+        uint32_t pllon : 1;
+        uint32_t pllrdy : 1;
+        uint32_t plli2son : 1;
+        uint32_t plli2srdy : 1;
+        uint32_t reserved2 : 4;
+    };
+    uint32_t reg;
+} RccCrType;
+
+typedef union {
+    struct {
+        uint32_t pllm : 6;
+        uint32_t plln : 9;
+        uint32_t reserved0 : 1;
+        uint32_t pllp : 2;
+        uint32_t reserved1 : 4;
+        uint32_t pllsrc : 1;
+        uint32_t reserved2 : 1;
+        uint32_t pllq : 4;
+        uint32_t reserved3 : 4;
+    };
+    uint32_t reg;
+} RccPllcfgrType;
+
+typedef union {
+    struct {
+        uint32_t sw : 2;
+        uint32_t sws : 2;
+        uint32_t hpre : 4;
+        uint32_t reserved0 : 2;
+        uint32_t ppre1 : 3;
+        uint32_t ppre2: 3;
+        uint32_t rtcpre : 5;
+        uint32_t mco1 : 2;
+        uint32_t i2sscr : 1;
+        uint32_t mco1pre : 3;
+        uint32_t mco2pre : 3;
+        uint32_t mco2 : 2;
+    };
+    uint32_t reg;
+} RccCfgrType;
+
+typedef union {
+    struct {
+        uint32_t lsirdyf : 1;
+        uint32_t lserdyf : 1;
+        uint32_t hsirdyf : 1;
+        uint32_t hserdyf : 1;
+        uint32_t pllrdyf : 1;
+        uint32_t plli2srdyf : 1;
+        uint32_t reserved0 : 1;
+        uint32_t cssf : 1;
+        uint32_t lsirdyie : 1;
+        uint32_t lserdyie : 1;
+        uint32_t hsirdyie : 1;
+        uint32_t hserdyie : 1;
+        uint32_t pllrdyie : 1;
+        uint32_t plli2srdyie : 1;
+        uint32_t reserved1 : 2;
+        uint32_t lsirdyc : 1;
+        uint32_t lserdyc : 1;
+        uint32_t hsirdyc : 1;
+        uint32_t hserdyc : 1;
+        uint32_t pllrdyc : 1;
+        uint32_t plli2srdyc : 1;
+        uint32_t reserved2 : 1;
+        uint32_t cssc : 1;
+        uint32_t reserved3 : 8;
+    };
+    uint32_t reg;
+} RccCirType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb1rstrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb2rstrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb3rstrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccApb1rstrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccApb2rstrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb1enrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb2enrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb3enrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccApb1enrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccApb2enrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb1lpenrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb2lpenrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccAhb3lpenrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccApb1lpenrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccApb2lpenrType;
+
+typedef union {
+    struct {
+        uint32_t lseon : 1;
+        uint32_t lserdy : 1;
+        uint32_t lsebyp : 1;
+        uint32_t reserved0 : 5;
+        uint32_t rtcsel : 2;
+        uint32_t reserved1 : 5;
+        uint32_t rtcen : 1;
+        uint32_t bdrst : 1;
+        uint32_t reserved2 : 15;
+    };
+    uint32_t reg;
+} RccBdcrType;
+
+typedef union {
+    struct {
+        uint32_t lsion : 1;
+        uint32_t lsirdy : 1;
+        uint32_t reserved0 : 22;
+        uint32_t rmvf : 1;
+        uint32_t borrstf : 1;
+        uint32_t pinrstf : 1;
+        uint32_t porrstf : 1;
+        uint32_t sftrstf : 1;
+        uint32_t iwdgrstf : 1;
+        uint32_t wwdgrstf : 1;
+        uint32_t lpwrrstf : 1;
+    };
+    uint32_t reg;
+} RccCsrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccSscgrType;
+
+typedef struct {
+    /* Fields are not specified */
+    uint32_t reg;
+} RccPlli2scfgrType;
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+    uint32_t hse_frequency;
+
+    /* Clock control register (RCC_CR) */
+    RccCrType rcc_cr;
+    /* PLL configuration register (RCC_PLLCFGR) */
+    RccPllcfgrType rcc_pllcfgr;
+    /* Clock configuration register (RCC_CFGR) */
+    RccCfgrType rcc_cfgr;
+    /* Clock interrupt register (RCC_CIR) */
+    RccCirType rcc_cir;
+    /* AHB1 peripheral reset register (RCC_AHB1RSTR) */
+    RccAhb1rstrType rcc_ahb1rstr;
+    /* AHB2 peripheral reset register (RCC_AHB2RSTR) */
+    RccAhb2rstrType rcc_ahb2rstr;
+    /* AHB3 peripheral reset register (RCC_AHB3RSTR) */
+    RccAhb3rstrType rcc_ahb3rstr;
+    /* APB1 peripheral reset register (RCC_APB1RSTR) */
+    RccApb1rstrType rcc_apb1rstr;
+    /* APB2 peripheral reset register (RCC_APB2RSTR) */
+    RccApb2rstrType rcc_apb2rstr;
+    /* AHB1 peripheral clock register (RCC_AHB1ENR) */
+    RccAhb1enrType rcc_ahb1enr;
+    /* AHB2 peripheral clock register (RCC_AHB2ENR) */
+    RccAhb2enrType rcc_ahb2enr;
+    /* AHB3 peripheral clock register (RCC_AHB3ENR) */
+    RccAhb3enrType rcc_ahb3enr;
+    /* APB1 peripheral clock register (RCC_APB1ENR) */
+    RccApb1enrType rcc_apb1enr;
+    /* APB2 peripheral clock register (RCC_APB1ENR) */
+    RccApb2enrType rcc_apb2enr;
+    /* AHB1 peripheral low power mode register (RCC_AHB1LPENR) */
+    RccAhb1lpenrType rcc_ahb1lpenr;
+    /* AHB2 peripheral low power mode register (RCC_AHB2LPENR) */
+    RccAhb2lpenrType rcc_ahb2lpenr;
+    /* AHB3 peripheral low power mode register (RCC_AHB3LPENR) */
+    RccAhb3lpenrType rcc_ahb3lpenr;
+    /* APB1 peripheral low power mode register (RCC_APB1LPENR) */
+    RccApb1lpenrType rcc_apb1lpenr;
+    /* APB2 peripheral low power mode register (RCC_APB2LPENR) */
+    RccApb2lpenrType rcc_apb2lpenr;
+    /* Backup domain control register (RCC_BDCR) */
+    RccBdcrType rcc_bdcr;
+    /* Clock control and status register (RCC_CSR) */
+    RccCsrType rcc_csr;
+    /* Spread spectrum clock generation register (RCC_SSCGR) */
+    RccSscgrType rcc_sscgr;
+    /* PLLI2S configuration register (RCC_PLLI2SCFGR) */
+    RccPlli2scfgrType rcc_plli2scfgr;
+} STM32F4xxRccState;
+
+#endif
--=20
2.17.1


