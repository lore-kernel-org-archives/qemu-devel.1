Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MISSING_HEADERS,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B75BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 08:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377F220880
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 08:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="Xokx8CWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377F220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8KGN-0007dB-E4
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 03:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1j8KFg-00075t-Sh
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 03:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1j8KFe-0003OA-MD
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 03:47:08 -0500
Received: from mail-eopbgr1280138.outbound.protection.outlook.com
 ([40.107.128.138]:20960 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>)
 id 1j8KFZ-0003Id-5i; Sun, 01 Mar 2020 03:47:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1DDUKcSmtw6iqgUmFA3//8cSlBH/zMHxruTDHnuRYEbT3TaMPcl1SZ7Fu4A2I+Ut31VXYBSJAL8i+KzMP8C4eLsN6fuMhGp9qZv7mD+oOBwgG65g/IVsOKRw7xQzLHWrO72Di0l3A1QD7glgBzMHZx00q24M+WJDzSxodKcHl78BmkamOIwRBwErmAcL0p5aZvZE+QRTmyg/Ry2zXxUFhxRsEXn+IVSJ2iZ05ir8NI67vxFQMYIax5aV/a3QE1i9lh4z7/3d680W7RfIV5M1dYcUhChiY1BiNegXP/8bGufBBGLPw78IPGr4y7BhmWeTS5oeIgpNohxkUZZok64kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s3Ksu5dVLWBvyTcTMfp9/hivIDFfS+lkBtJzsq8GtA=;
 b=jAmuNhXUCXr/3PuIqDWerM8BxrV9urVzgozMXSqkPDgxpodWBgrSC6OL+ripOJ1q3u49s3iHkgKWc0TnhPg66eWgRnG+iR5rQjj1d11hzXF3WQ7sUJ/5LgPKlJ5glP2kWENJCXR3O+0UJjTZUaWxjc+I1Mp3hrXQf6VZ7CFW251/0H2QgX21NanKHNWBREBtC2f5P1iYIigBSt3hRrWee8BlxWOfLzqy3RWw5GtLnR62NY+WBaRWkRASpx6ZUpLSc/YHIPXYWF1PLkJ9yNdKikgx3q6AGaza8M6+XGfpcGvBORU1Iqiubc8AiStzzuE3OzeQ4m6PdJkmWkwedy4HFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s3Ksu5dVLWBvyTcTMfp9/hivIDFfS+lkBtJzsq8GtA=;
 b=Xokx8CWPjT9aPp6tmvGT9PPnwrkP21Lpa5TYhO90kCB8DXZFwsvvRhWGV1Unj/GeAcwBN/hssrG0mAhbYbqjcCbGURKh7m/wz/wX/vb+LIn3IFA8XpdDaCQFGhPbrCS8IA8Bgnu8WI5bUaW1js7NnJkCa4n6Wbmfcp66KgFj5LA=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0032.KORP216.PROD.OUTLOOK.COM (10.174.35.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Sun, 1 Mar 2020 08:45:01 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 08:45:01 +0000
Received: from DOMINUS.corp.kimin.kr (1.214.196.86) by
 HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Sun, 1 Mar 2020 08:45:00 +0000
From: Stephanos Ioannidis <root@stephanos.io>
Subject: [PATCH] hw/arm/stm32f405: Add preliminary flash interface emulation
 support
Thread-Topic: [PATCH] hw/arm/stm32f405: Add preliminary flash interface
 emulation support
Thread-Index: AQHV76WxZe46p89OQkyRrUq4sIubZA==
Date: Sun, 1 Mar 2020 08:45:01 +0000
Message-ID: <20200301084427.93823-1-root@stephanos.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::20) To SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:9::8)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.214.196.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ceb679d-a187-419b-1c39-08d7bdbcd458
x-ms-traffictypediagnostic: SLXP216MB0032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SLXP216MB0032296D00E22BFE7A99DC5EBDE60@SLXP216MB0032.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:109;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39830400003)(376002)(136003)(346002)(189003)(199004)(86362001)(66946007)(52116002)(186003)(16526019)(26005)(478600001)(19627235002)(956004)(2616005)(66446008)(64756008)(66556008)(66476007)(81166006)(8676002)(81156014)(5660300002)(8936002)(1076003)(36756003)(6512007)(109986005)(2906002)(30864003)(316002)(71200400001)(54906003)(6506007)(66574012)(6486002)(4326008)(36456003)(42976004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0032;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ri9I0zsPQ2DA1i0hNjY/rY0rg9KYFsPfQ3Nljj+IJlxrVpV0zHVg4iuRE78lFXd7wC/vV45l1B0c+CFP9GB1GIE+SkxBR7dNx4Jn+b1pELeVcw4s/TUMT0pO6ZhYWhO3zCLsKi//9qwjdFC4cePouamDEMogl5WSo8Zzg5wCclO5N8spQ1R1IyKac8MBNY21y0VO4e03srU5Me0ykdOZjcFGzZs2W1OobfHYFjdLG8UuRJDF6s06LJ0G6cKrROhSb7S/7HfvKJSBTAgPqiaPugzPj+EIf42ryMMybK2xOlGzZ0yW5KKoIahEUv2s0Z+1A2LSBmkWwuoiOIkIdsttB1Dtn4VRhs4Bs16WF9UUuYZ4LUo+khKFYF1e2TtBG+pBDonMTBDMVpGabclvCmn1lJBGVWgRzsW39dSvSgOTwZMteKp5JgCgo3Bl3IvV2V+Tl4ZI32FKuPWemkEqK0Oa0NX5L1glh3VB1Wti+oFdD04YuCL0AgX08DRLu9GohwDnrfr31qqI2mghkyByMAu+Q==
x-ms-exchange-antispam-messagedata: Wc1+KQChZpnfhoxjQzlaLiFjBsRpYlRDOOHfVNsXkrGHuVURUNmHAQGW+jZwMhUXyxsARPbyG64sDz/JR9O4IIgS9Rperux8BDEdqARpCN2oqdmUnCx/+7VwJ66wURZ06fMOVHS2YlV60J+oxa8MKA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ceb679d-a187-419b-1c39-08d7bdbcd458
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 08:45:01.3348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpBXxjnaVF8Yq4+ek0J9VnCKoEqWyOH+XH8e2km4pDaR1K+lW4yxLNKZN+98bMVQhNvri3mY30L2h7RiSFScqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0032
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.138
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

The flash interface (FLASHIF) peripheral provides a control interface
for the SoC embedded flash memory on the STM32F4xx series devices.

This commit adds preliminary support for the flash interface peripheral
emulation, in order to support proper emulation of the firmware images
that use the STM32Cube driver, which configures and validates the
FLASH_ACR register during system initialisation.

Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
---
 hw/arm/Kconfig                      |   1 +
 hw/arm/stm32f405_soc.c              |  15 +-
 hw/misc/Kconfig                     |   3 +
 hw/misc/Makefile.objs               |   1 +
 hw/misc/stm32f4xx_flashif.c         | 215 ++++++++++++++++++++++++++++
 hw/misc/trace-events                |   4 +
 include/hw/arm/stm32f405_soc.h      |   2 +
 include/hw/misc/stm32f4xx_flashif.h | 144 +++++++++++++++++++
 8 files changed, 384 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/stm32f4xx_flashif.c
 create mode 100644 include/hw/misc/stm32f4xx_flashif.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d86691ae0..179696ec91 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -314,6 +314,7 @@ config STM32F205_SOC
 config STM32F405_SOC
     bool
     select ARM_V7M
+    select STM32F4XX_FLASHIF
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
=20
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 9bcad97853..72b16910c7 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -30,6 +30,7 @@
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/misc/unimp.h"
=20
+#define FLASHIF_ADDR                   0x40023C00
 #define SYSCFG_ADD                     0x40013800
 static const uint32_t usart_addr[] =3D { 0x40011000, 0x40004400, 0x4000480=
0,
                                        0x40004C00, 0x40005000, 0x40011400,
@@ -59,6 +60,9 @@ static void stm32f405_soc_initfn(Object *obj)
     sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
                           TYPE_ARMV7M);
=20
+    sysbus_init_child_obj(obj, "flashif", &s->flashif, sizeof(s->flashif),
+                          TYPE_STM32F4XX_FLASHIF);
+
     sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
                           TYPE_STM32F4XX_SYSCFG);
=20
@@ -130,6 +134,16 @@ static void stm32f405_soc_realize(DeviceState *dev_soc=
, Error **errp)
         return;
     }
=20
+    /* Flash interface */
+    dev =3D DEVICE(&s->flashif);
+    object_property_set_bool(OBJECT(&s->flashif), true, "realized", &err);
+    if (err !=3D NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev =3D SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, FLASHIF_ADDR);
+
     /* System configuration controller */
     dev =3D DEVICE(&s->syscfg);
     object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
@@ -261,7 +275,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc,=
 Error **errp)
     create_unimplemented_device("GPIOI",       0x40022000, 0x400);
     create_unimplemented_device("CRC",         0x40023000, 0x400);
     create_unimplemented_device("RCC",         0x40023800, 0x400);
-    create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
     create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
     create_unimplemented_device("DMA1",        0x40026000, 0x400);
     create_unimplemented_device("DMA2",        0x40026400, 0x400);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index bdd77d8020..e333a955b2 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -79,6 +79,9 @@ config IMX
     select SSI
     select USB_EHCI_SYSBUS
=20
+config STM32F4XX_FLASHIF
+    bool
+
 config STM32F2XX_SYSCFG
     bool
=20
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index da993f45b7..1aea0b9bb9 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -58,6 +58,7 @@ common-obj-$(CONFIG_RASPI) +=3D bcm2835_thermal.o
 common-obj-$(CONFIG_SLAVIO) +=3D slavio_misc.o
 common-obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
 common-obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
+common-obj-$(CONFIG_STM32F4XX_FLASHIF) +=3D stm32f4xx_flashif.o
 common-obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.o
 common-obj-$(CONFIG_STM32F4XX_SYSCFG) +=3D stm32f4xx_syscfg.o
 common-obj-$(CONFIG_STM32F4XX_EXTI) +=3D stm32f4xx_exti.o
diff --git a/hw/misc/stm32f4xx_flashif.c b/hw/misc/stm32f4xx_flashif.c
new file mode 100644
index 0000000000..d280fc5b2c
--- /dev/null
+++ b/hw/misc/stm32f4xx_flashif.c
@@ -0,0 +1,215 @@
+/*
+ * STM32F4xx FLASHIF
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
+#include "migration/vmstate.h"
+#include "hw/misc/stm32f4xx_flashif.h"
+
+static void stm32f4xx_flashif_reset(DeviceState *dev)
+{
+    STM32F4xxFlashIfState *s =3D STM32F4XX_FLASHIF(dev);
+
+    /* Initialise states */
+    s->cr_key_index =3D 0;
+    s->optcr_key_index =3D 0;
+
+    /* Initialise register values */
+    s->flash_acr.reg =3D 0x00000000;
+    s->flash_keyr.reg =3D 0x00000000;
+    s->flash_optkeyr.reg =3D 0x00000000;
+    s->flash_sr.reg =3D 0x00000000;
+    s->flash_cr.reg =3D 0x80000000;
+    s->flash_optcr.reg =3D 0x0FFFAAED;
+}
+
+static uint64_t stm32f4xx_flashif_read(void * opaque, hwaddr addr,
+                                       unsigned int size)
+{
+    STM32F4xxFlashIfState *s =3D opaque;
+
+    trace_stm32f4xx_flashif_read(addr);
+
+    switch (addr) {
+    case FLASH_ACR:
+        return s->flash_acr.reg;
+    case FLASH_SR:
+        return s->flash_sr.reg;
+    case FLASH_CR:
+        return s->flash_cr.reg;
+    case FLASH_OPTCR:
+        return s->flash_optcr.reg;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+        return 0;
+    }
+}
+
+static void flash_acr_write(STM32F4xxFlashIfState *s, FlashAcrType val)
+{
+    /* Set latency */
+    s->flash_acr.latency =3D val.latency;
+    /* Set prefetch status */
+    s->flash_acr.prften =3D val.prften;
+    /* Set instruction cache status */
+    s->flash_acr.icen =3D val.icen;
+    /* Set data cache status */
+    s->flash_acr.dcen =3D val.dcen;
+}
+
+static void flash_cr_write(STM32F4xxFlashIfState *s, FlashCrType val)
+{
+    /* Lock FLASH_CR if lock bit is set */
+    if (val.lock) {
+        s->flash_cr.lock =3D 1;
+        s->cr_key_index =3D 0;
+        return;
+    }
+}
+
+static void flash_optcr_write(STM32F4xxFlashIfState *s, FlashOptcrType val=
)
+{
+    /* Lock FLASH_OPTCR if lock bit is set */
+    if (val.optlock) {
+        s->flash_optcr.optlock =3D 1;
+        s->optcr_key_index =3D 0;
+        return;
+    }
+}
+
+static void stm32f4xx_flashif_write(void *opaque, hwaddr addr,
+                                    uint64_t val64, unsigned int size)
+{
+    STM32F4xxFlashIfState *s =3D opaque;
+    uint32_t value =3D val64;
+
+    trace_stm32f4xx_flashif_write(value, addr);
+
+    switch (addr) {
+    case FLASH_ACR:
+        flash_acr_write(s, (FlashAcrType)value);
+        return;
+    case FLASH_KEYR:
+        if (s->cr_key_index =3D=3D 0 && value =3D=3D 0x45670123) {
+            s->cr_key_index =3D 1;
+        } else if (s->cr_key_index =3D=3D 1 && value =3D=3D 0xCDEF89AB) {
+            /* Valid key; unlock FLASH_CR */
+            s->flash_cr.lock =3D 0;
+            s->cr_key_index =3D 0;
+        } else {
+            /* Invalid key; permanently lock FLASH_CR until reset */
+            s->flash_cr.lock =3D 1;
+            s->cr_key_index =3D -1;
+        }
+        return;
+    case FLASH_OPTKEYR:
+        if (s->optcr_key_index =3D=3D 0 && value =3D=3D 0x08192A3B) {
+            s->optcr_key_index =3D 1;
+        } else if (s->optcr_key_index =3D=3D 1 && value =3D=3D 0x4C5D6E7F)=
 {
+            /* Valid key; unlock FLASH_OPTCR */
+            s->flash_optcr.optlock =3D 0;
+            s->optcr_key_index =3D 0;
+        } else {
+            /* Invalid key; lock FLASH_OPTCR until reset */
+            s->flash_optcr.optlock =3D 1;
+            s->optcr_key_index =3D -1;
+        }
+        return;
+    case FLASH_SR:
+        if (s->flash_sr.eop)        s->flash_sr.eop =3D 0;
+        if (s->flash_sr.operr)      s->flash_sr.operr =3D 0;
+        if (s->flash_sr.wrperr)     s->flash_sr.wrperr =3D 0;
+        if (s->flash_sr.pgaerr)     s->flash_sr.pgaerr =3D 0;
+        if (s->flash_sr.pgperr)     s->flash_sr.pgperr =3D 0;
+        if (s->flash_sr.pgserr)     s->flash_sr.pgserr =3D 0;
+        return;
+    case FLASH_CR:
+        flash_cr_write(s, (FlashCrType)value);
+        return;
+    case FLASH_OPTCR:
+        flash_optcr_write(s, (FlashOptcrType)value);
+        return;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_flashif_ops =3D {
+    .read =3D stm32f4xx_flashif_read,
+    .write =3D stm32f4xx_flashif_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN
+};
+
+static void stm32f4xx_flashif_init(Object *obj)
+{
+    STM32F4xxFlashIfState *s =3D STM32F4XX_FLASHIF(obj);
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_flashif_ops, s,
+                          TYPE_STM32F4XX_FLASHIF, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static const VMStateDescription vmstate_stm32f4xx_flashif =3D {
+    .name =3D TYPE_STM32F4XX_FLASHIF,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(flash_acr.reg, STM32F4xxFlashIfState),
+        VMSTATE_UINT32(flash_keyr.reg, STM32F4xxFlashIfState),
+        VMSTATE_UINT32(flash_optkeyr.reg, STM32F4xxFlashIfState),
+        VMSTATE_UINT32(flash_sr.reg, STM32F4xxFlashIfState),
+        VMSTATE_UINT32(flash_cr.reg, STM32F4xxFlashIfState),
+        VMSTATE_UINT32(flash_optcr.reg, STM32F4xxFlashIfState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32f4xx_flashif_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->reset =3D stm32f4xx_flashif_reset;
+    dc->vmsd =3D &vmstate_stm32f4xx_flashif;
+}
+
+static const TypeInfo stm32f4xx_flashif_info =3D {
+    .name          =3D TYPE_STM32F4XX_FLASHIF,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(STM32F4xxFlashIfState),
+    .instance_init =3D stm32f4xx_flashif_init,
+    .class_init    =3D stm32f4xx_flashif_class_init
+};
+
+static void stm32f4xx_flashif_register_types(void)
+{
+    type_register_static(&stm32f4xx_flashif_info);
+}
+
+type_init(stm32f4xx_flashif_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 7f0f5dff3a..bd9a5dd483 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -84,6 +84,10 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, uint64_t val) "reg=3D0x%"PRIx64 " val=3D0x%"P=
RIx64
 mos6522_read(uint64_t addr, unsigned val) "reg=3D0x%"PRIx64 " val=3D0x%x"
=20
+# stm32f4xx_flashif
+stm32f4xx_flashif_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
+stm32f4xx_flashif_write(uint64_t addr, uint64_t data) "reg write: addr: 0x=
%" PRIx64 " val: 0x%" PRIx64 ""
+
 # stm32f4xx_syscfg
 stm32f4xx_syscfg_set_irq(int gpio, int line, int level) "Interupt: GPIO: %=
d, Line: %d; Level: %d"
 stm32f4xx_pulse_exti(int irq) "Pulse EXTI: %d"
diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.=
h
index 1fe97f8c3a..a94c3c51ac 100644
--- a/include/hw/arm/stm32f405_soc.h
+++ b/include/hw/arm/stm32f405_soc.h
@@ -25,6 +25,7 @@
 #ifndef HW_ARM_STM32F405_SOC_H
 #define HW_ARM_STM32F405_SOC_H
=20
+#include "hw/misc/stm32f4xx_flashif.h"
 #include "hw/misc/stm32f4xx_syscfg.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "hw/char/stm32f2xx_usart.h"
@@ -57,6 +58,7 @@ typedef struct STM32F405State {
=20
     ARMv7MState armv7m;
=20
+    STM32F4xxFlashIfState flashif;
     STM32F4xxSyscfgState syscfg;
     STM32F4xxExtiState exti;
     STM32F2XXUsartState usart[STM_NUM_USARTS];
diff --git a/include/hw/misc/stm32f4xx_flashif.h b/include/hw/misc/stm32f4x=
x_flashif.h
new file mode 100644
index 0000000000..e364ca39c7
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_flashif.h
@@ -0,0 +1,144 @@
+/*
+ * STM32F4xx FLASHIF
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
+#ifndef HW_STM_FLASHIF_H
+#define HW_STM_FLASHIF_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define TYPE_STM32F4XX_FLASHIF "stm32f4xx-flashif"
+#define STM32F4XX_FLASHIF(obj) \
+    OBJECT_CHECK(STM32F4xxFlashIfState, (obj), TYPE_STM32F4XX_FLASHIF)
+
+#define FLASH_ACR       0x00
+#define FLASH_KEYR      0x04
+#define FLASH_OPTKEYR   0x08
+#define FLASH_SR        0x0C
+#define FLASH_CR        0x10
+#define FLASH_OPTCR     0x14
+
+typedef union {
+    struct {
+        uint32_t latency : 3;
+        uint32_t reserved0 : 5;
+        uint32_t prften : 1;
+        uint32_t icen : 1;
+        uint32_t dcen : 1;
+        uint32_t icrst : 1;
+        uint32_t dcrst : 1;
+        uint32_t reserved1 : 19;
+    };
+    uint32_t reg;
+} FlashAcrType;
+
+typedef union {
+    struct {
+        uint32_t key : 32;
+    };
+    uint32_t reg;
+} FlashKeyrType;
+
+typedef union {
+    struct {
+        uint32_t optkey : 32;
+    };
+    uint32_t reg;
+} FlashOptkeyrType;
+
+typedef union {
+    struct {
+        uint32_t eop : 1;
+        uint32_t operr : 1;
+        uint32_t reserved0 : 2;
+        uint32_t wrperr : 1;
+        uint32_t pgaerr : 1;
+        uint32_t pgperr : 1;
+        uint32_t pgserr : 1;
+        uint32_t reserved1 : 8;
+        uint32_t bsy : 1;
+        uint32_t reserved2 : 15;
+    };
+    uint32_t reg;
+} FlashSrType;
+
+typedef union {
+    struct {
+        uint32_t pg : 1;
+        uint32_t ser : 1;
+        uint32_t mer : 1;
+        uint32_t snb : 4;
+        uint32_t reserved0 : 1;
+        uint32_t psize : 2;
+        uint32_t reserved1 : 6;
+        uint32_t strt : 1;
+        uint32_t reserved2 : 7;
+        uint32_t eopie : 1;
+        uint32_t reserved3 : 6;
+        uint32_t lock : 1;
+    };
+    uint32_t reg;
+} FlashCrType;
+
+typedef union {
+    struct {
+        uint32_t optlock : 1;
+        uint32_t optstrt : 1;
+        uint32_t bor_lev : 2;
+        uint32_t reserved0 : 1;
+        uint32_t wdg_sw : 1;
+        uint32_t nrst_stop : 1;
+        uint32_t nrst_stdby : 1;
+        uint32_t rdp : 8;
+        uint32_t nwrp : 12;
+        uint32_t reserved1 : 4;
+    };
+    uint32_t reg;
+} FlashOptcrType;
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    int32_t cr_key_index;
+    int32_t optcr_key_index;
+
+    /* Access control register (FLASH_ACR) */
+    FlashAcrType flash_acr;
+    /* Key register (FLASH_KEYR) */
+    FlashKeyrType flash_keyr;
+    /* Option key register (FLASH_OPTKEYR) */
+    FlashOptkeyrType flash_optkeyr;
+    /* Status register (FLASH_SR) */
+    FlashSrType flash_sr;
+    /* Control register (FLASH_CR) */
+    FlashCrType flash_cr;
+    /* Option control register (FLASH_OPTCR) */
+    FlashOptcrType flash_optcr;
+} STM32F4xxFlashIfState;
+
+#endif
--=20
2.17.1


