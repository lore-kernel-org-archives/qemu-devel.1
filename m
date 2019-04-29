Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFBEC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 05:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAF42087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 05:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAF42087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKz12-0002ex-PP
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 01:39:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyvE-00076O-Im
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyvD-0005n7-A4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:48 -0400
Received: from mail-oln040092255063.outbound.protection.outlook.com
	([40.92.255.63]:54848
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hKyvC-0005lA-Tz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:47 -0400
Received: from PU1APC01FT057.eop-APC01.prod.protection.outlook.com
	(10.152.252.52) by PU1APC01HT070.eop-APC01.prod.protection.outlook.com
	(10.152.253.75) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1835.13;
	Mon, 29 Apr 2019 05:33:39 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.252.56) by
	PU1APC01FT057.mail.protection.outlook.com (10.152.253.7) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13 via Frontend Transport; Mon, 29 Apr 2019 05:33:39 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 05:33:38 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
Thread-Index: AQHU/k0ZzptDvPD+1U6L6aru7zHWWg==
Date: Mon, 29 Apr 2019 05:33:38 +0000
Message-ID:
 <PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556515687.git.alistair@alistair23.me>
In-Reply-To: <cover.1556515687.git.alistair@alistair23.me>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0008.namprd02.prod.outlook.com
	(2603:10b6:a02:ee::21) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	(2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:83938E20C9C607DF476504A32348826778B06D6CD084A164A6DCAB55D7EBB26C;
	UpperCasedChecksum:45CABC4A613EFF97A9E519FCAA54B8CC6E443192B66534A1A0F7A22D3E93DDE9;
	SizeAsReceived:7502; Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-tmn: [sCbaDkStg/yD3WsutGwZ2Yk1TJgxYJwLgSoq7ShJFyPHjbL8XeeHCwlSXMlC6dDK]
x-microsoft-original-message-id: <f1caf47809b085ea1534a2e7a872b8157191ef82.1556515687.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
	SRVR:PU1APC01HT070; 
x-ms-traffictypediagnostic: PU1APC01HT070:
x-microsoft-antispam-message-info: Yagh8Ed8By98yEhvD/zvroBgmsdWDOfmTcFqPrYj3RtrS0t2A2h4G2Rac8ifH1FIkdJc7XOZhE4YrCDgb3d3jwB9uMRj85rtk2HRsM941VuiywpwiGdESkY67u3ccaqsOqSDL/Dt5vJlVdnDvEnJNniW/t5xWnn4B4EqyxA71+tfY1/OgfFyK7hQJaNJRKHH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 019bf201-c930-4992-58c1-08d6cc643b45
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 05:33:38.9025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT070
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.255.63
Subject: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
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
Message-ID: <20190429053338.yJuyFmIU7ut0fC70BbNmCcmONFOOTSoJSz58dp2-hkU@z>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS                     |  6 +++
 default-configs/arm-softmmu.mak |  1 +
 hw/arm/Kconfig                  |  3 ++
 hw/arm/Makefile.objs            |  1 +
 hw/arm/netduinoplus2.c          | 77 +++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+)
 create mode 100644 hw/arm/netduinoplus2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c9772735cf..9b0af5a0b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -817,6 +817,12 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: hw/arm/netduino2.c
=20
+Netduino Plus 2
+M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: hw/arm/netduinoplus2.c
+
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index e079f10624..1e2c82f201 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -46,6 +46,7 @@ CONFIG_A15MPCORE=3Dy
=20
 CONFIG_ARM_V7M=3Dy
 CONFIG_NETDUINO2=3Dy
+CONFIG_NETDUINOPLUS2=3Dy
=20
 CONFIG_ARM_GIC=3Dy
 CONFIG_ARM_TIMER=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3a98bce15a..13fc779308 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -26,6 +26,9 @@ config MUSICPAL
 config NETDUINO2
     bool
=20
+config NETDUINOPLUS2
+    bool
+
 config NSERIES
     bool
=20
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 36c3ff54c3..1f216f4d93 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -8,6 +8,7 @@ obj-$(CONFIG_INTEGRATOR) +=3D integratorcp.o
 obj-$(CONFIG_MAINSTONE) +=3D mainstone.o
 obj-$(CONFIG_MUSICPAL) +=3D musicpal.o
 obj-$(CONFIG_NETDUINO2) +=3D netduino2.o
+obj-$(CONFIG_NETDUINOPLUS2) +=3D netduinoplus2.o
 obj-$(CONFIG_NSERIES) +=3D nseries.o
 obj-$(CONFIG_OMAP) +=3D omap_sx1.o palm.o
 obj-$(CONFIG_PXA2XX) +=3D gumstix.o spitz.o tosa.o z2.o
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
new file mode 100644
index 0000000000..1f585cf09f
--- /dev/null
+++ b/hw/arm/netduinoplus2.c
@@ -0,0 +1,77 @@
+/*
+ * Netduino Plus 2 Machine Model
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
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32f405_soc.h"
+#include "hw/arm/arm.h"
+
+typedef struct ARMV7MResetArgs {
+    ARMCPU *cpu;
+    uint32_t reset_sp;
+    uint32_t reset_pc;
+} ARMV7MResetArgs;
+
+static void armv7m_reset(void *opaque)
+{
+    ARMV7MResetArgs *args =3D opaque;
+
+    cpu_reset(CPU(args->cpu));
+
+    args->cpu->env.regs[13] =3D args->reset_sp & 0xFFFFFFFC;
+    args->cpu->env.thumb =3D args->reset_pc & 1;
+    args->cpu->env.regs[15] =3D args->reset_pc & ~1;
+}
+
+static void netduinoplus2_init(MachineState *machine)
+{
+    DeviceState *dev;
+    ARMV7MResetArgs reset_args;
+    uint64_t entry;
+
+    dev =3D qdev_create(NULL, TYPE_STM32F405_SOC);
+    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                       FLASH_SIZE, &entry);
+
+    reset_args =3D (ARMV7MResetArgs) {
+        .cpu =3D ARM_CPU(first_cpu),
+        .reset_pc =3D entry,
+        .reset_sp =3D (SRAM_BASE_ADDRESS + (SRAM_SIZE * 2) / 3),
+    };
+    qemu_register_reset(armv7m_reset,
+                        g_memdup(&reset_args, sizeof(reset_args)));
+}
+
+static void netduinoplus2_machine_init(MachineClass *mc)
+{
+    mc->desc =3D "Netduino Plus 2 Machine";
+    mc->init =3D netduinoplus2_init;
+}
+
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
--=20
2.21.0


