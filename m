Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECC4C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 05:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0AF206BF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 05:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0AF206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKyyY-0001QX-F1
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 01:37:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyuo-0006m6-VG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyun-0005YX-Ew
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:22 -0400
Received: from mail-oln040092254070.outbound.protection.outlook.com
	([40.92.254.70]:6235
	helo=APC01-PU1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hKyum-0005XA-TY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:21 -0400
Received: from SG2APC01FT020.eop-APC01.prod.protection.outlook.com
	(10.152.250.53) by SG2APC01HT045.eop-APC01.prod.protection.outlook.com
	(10.152.251.8) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1835.13;
	Mon, 29 Apr 2019 05:33:12 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
	SG2APC01FT020.mail.protection.outlook.com (10.152.250.219) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.1835.13 via Frontend Transport; Mon, 29 Apr 2019 05:33:12 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 05:33:12 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 3/5] hw/misc: Add the STM32F4xx EXTI device
Thread-Index: AQHU/k0JfWuZ1cs3QEqRXZOMKOZEsw==
Date: Mon, 29 Apr 2019 05:33:12 +0000
Message-ID:
 <PSXP216MB0277D0653D098FF32C5DC07DDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556515687.git.alistair@alistair23.me>
In-Reply-To: <cover.1556515687.git.alistair@alistair23.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0081.namprd07.prod.outlook.com
	(2603:10b6:a03:12b::22) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	(2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:1F2B2EA11A11F828326E0E0F8011F90DC5B1960E1C8BA9D8DA097A66CF6DAEAA;
	UpperCasedChecksum:2226D262328CC1FACD2CE5A9CEE5F7476DB98BF615137205C64BE2488F82A282;
	SizeAsReceived:7522; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-tmn: [nXNvGuN9CyD/Q9faNQ96pZCuyo669DS2AHDGlEPjO/UFJzvJSi1854Zrlhq0GMHw]
x-microsoft-original-message-id: <e9c1bd420102bd2e7f2ce6eda076f70569a4af23.1556515687.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
	SRVR:SG2APC01HT045; 
x-ms-traffictypediagnostic: SG2APC01HT045:
x-microsoft-antispam-message-info: 7dRJ38KmvUTa3xBNWmC8QWow6H1scUc/d1H2qs9d1OaT+WCzrKfQTqsS1M6XSSj7nbHOyo6bnDmX6+6p5FUZIUzOJ6XMIKruBMSskTvAi8LgPsW+9TTlSwjR2BOYeM2S0p6OBNGxxZHyjX/s6urkXPbbxHi5lL8ThbM4yGwxs9dviBhBq67H/tfkFQomqWEy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d3694cc2-7ea0-4541-fac6-08d6cc642b95
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 05:33:12.5634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT045
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.254.70
Subject: [Qemu-devel] [PATCH v1 3/5] hw/misc: Add the STM32F4xx EXTI device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429053312.iRFTEYGZR-d01k9TIEbc5xd1LkTiEE8ubUlip0fMkYE@z>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 default-configs/arm-softmmu.mak  |   1 +
 hw/misc/Kconfig                  |   3 +
 hw/misc/Makefile.objs            |   1 +
 hw/misc/stm32f4xx_exti.c         | 175 +++++++++++++++++++++++++++++++
 include/hw/misc/stm32f4xx_exti.h |  57 ++++++++++
 5 files changed, 237 insertions(+)
 create mode 100644 hw/misc/stm32f4xx_exti.c
 create mode 100644 include/hw/misc/stm32f4xx_exti.h

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index c5cfdb857d..8eb57de211 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -97,6 +97,7 @@ CONFIG_STM32F2XX_ADC=3Dy
 CONFIG_STM32F2XX_SPI=3Dy
 CONFIG_STM32F205_SOC=3Dy
 CONFIG_STM32F4XX_SYSCFG=3Dy
+CONFIG_STM32F4XX_EXTI=3Dy
 CONFIG_NRF51_SOC=3Dy
=20
 CONFIG_CMSDK_APB_TIMER=3Dy
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index c6ff39aeeb..3748b5f11a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -83,6 +83,9 @@ config STM32F2XX_SYSCFG
 config STM32F4XX_SYSCFG
     bool
=20
+config STM32F4XX_EXTI
+    bool
+
 config MIPS_ITU
     bool
=20
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 1413b1f232..74c7ca6c05 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -58,6 +58,7 @@ obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
 obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
 obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.o
 obj-$(CONFIG_STM32F4XX_SYSCFG) +=3D stm32f4xx_syscfg.o
+obj-$(CONFIG_STM32F4XX_EXTI) +=3D stm32f4xx_exti.o
 obj-$(CONFIG_MIPS_CPS) +=3D mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) +=3D mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
new file mode 100644
index 0000000000..b31f06cdca
--- /dev/null
+++ b/hw/misc/stm32f4xx_exti.c
@@ -0,0 +1,175 @@
+/*
+ * STM32F4XX EXTI
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
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
+#include "hw/sysbus.h"
+#include "qemu/log.h"
+#include "hw/misc/stm32f4xx_exti.h"
+
+#ifndef STM_EXTI_ERR_DEBUG
+#define STM_EXTI_ERR_DEBUG 0
+#endif
+
+#define DB_PRINT_L(lvl, fmt, args...) do { \
+    if (STM_EXTI_ERR_DEBUG >=3D lvl) { \
+        qemu_log("%s: " fmt, __func__, ## args); \
+    } \
+} while (0)
+
+#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
+
+#define NUM_GPIO_EVENT_IN_LINES 16
+#define NUM_INTERRUPT_OUT_LINES 16
+
+static void stm32f4xx_exti_reset(DeviceState *dev)
+{
+    STM32F4xxExtiState *s =3D STM32F4XX_EXTI(dev);
+
+    s->exti_imr =3D 0x00000000;
+    s->exti_emr =3D 0x00000000;
+    s->exti_rtsr =3D 0x00000000;
+    s->exti_ftsr =3D 0x00000000;
+    s->exti_swier =3D 0x00000000;
+    s->exti_pr =3D 0x00000000;
+}
+
+static void stm32f4xx_exti_set_irq(void *opaque, int irq, int level)
+{
+    STM32F4xxExtiState *s =3D opaque;
+
+    DB_PRINT("Set EXTI: %d to %d\n", irq, level);
+
+    if (level) {
+        qemu_irq_pulse(s->irq[irq]);
+        s->exti_pr |=3D 1 << irq;
+    }
+}
+
+static uint64_t stm32f4xx_exti_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    STM32F4xxExtiState *s =3D opaque;
+
+    DB_PRINT("0x%x\n", (uint) addr);
+
+    switch (addr) {
+    case EXTI_IMR:
+        return s->exti_imr;
+    case EXTI_EMR:
+        return s->exti_emr;
+    case EXTI_RTSR:
+        return s->exti_rtsr;
+    case EXTI_FTSR:
+        return s->exti_ftsr;
+    case EXTI_SWIER:
+        return s->exti_swier;
+    case EXTI_PR:
+        return s->exti_pr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32F4XX_exti_read: Bad offset %x\n", (int)addr);
+        return 0;
+    }
+    return 0;
+}
+
+static void stm32f4xx_exti_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    STM32F4xxExtiState *s =3D opaque;
+    uint32_t value =3D (uint32_t) val64;
+
+    DB_PRINT("0x%x, 0x%x\n", value, (uint) addr);
+
+    switch (addr) {
+    case EXTI_IMR:
+        s->exti_imr =3D value;
+        return;
+    case EXTI_EMR:
+        s->exti_emr =3D value;
+        return;
+    case EXTI_RTSR:
+        s->exti_rtsr =3D value;
+        return;
+    case EXTI_FTSR:
+        s->exti_ftsr =3D value;
+        return;
+    case EXTI_SWIER:
+        s->exti_swier =3D value;
+        return;
+    case EXTI_PR:
+        /* This bit is cleared by writing a 1 to it */
+        s->exti_pr &=3D ~value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32F4XX_exti_write: Bad offset %x\n", (int)addr);
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_exti_ops =3D {
+    .read =3D stm32f4xx_exti_read,
+    .write =3D stm32f4xx_exti_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32f4xx_exti_init(Object *obj)
+{
+    STM32F4xxExtiState *s =3D STM32F4XX_EXTI(obj);
+    int i;
+
+    s->irq =3D g_new0(qemu_irq, NUM_INTERRUPT_OUT_LINES);
+    for (i =3D 0; i < NUM_INTERRUPT_OUT_LINES; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
+    }
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
+                          TYPE_STM32F4XX_EXTI, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_exti_set_irq,
+                      NUM_GPIO_EVENT_IN_LINES);
+}
+
+static void stm32f4xx_exti_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->reset =3D stm32f4xx_exti_reset;
+}
+
+static const TypeInfo stm32f4xx_exti_info =3D {
+    .name          =3D TYPE_STM32F4XX_EXTI,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(STM32F4xxExtiState),
+    .instance_init =3D stm32f4xx_exti_init,
+    .class_init    =3D stm32f4xx_exti_class_init,
+};
+
+static void stm32f4xx_exti_register_types(void)
+{
+    type_register_static(&stm32f4xx_exti_info);
+}
+
+type_init(stm32f4xx_exti_register_types)
diff --git a/include/hw/misc/stm32f4xx_exti.h b/include/hw/misc/stm32f4xx_e=
xti.h
new file mode 100644
index 0000000000..a9a4c86ef7
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_exti.h
@@ -0,0 +1,57 @@
+/*
+ * STM32F4XX EXTI
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
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
+#ifndef HW_STM_EXTI_H
+#define HW_STM_EXTI_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define EXTI_IMR   0x00
+#define EXTI_EMR   0x04
+#define EXTI_RTSR  0x08
+#define EXTI_FTSR  0x0C
+#define EXTI_SWIER 0x10
+#define EXTI_PR    0x14
+
+#define TYPE_STM32F4XX_EXTI "stm32f4xx-exti"
+#define STM32F4XX_EXTI(obj) \
+    OBJECT_CHECK(STM32F4xxExtiState, (obj), TYPE_STM32F4XX_EXTI)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t exti_imr;
+    uint32_t exti_emr;
+    uint32_t exti_rtsr;
+    uint32_t exti_ftsr;
+    uint32_t exti_swier;
+    uint32_t exti_pr;
+
+    qemu_irq *irq;
+} STM32F4xxExtiState;
+
+#endif
--=20
2.21.0


