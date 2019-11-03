Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E92DCA9ED2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 07:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C79C20848
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 07:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VUZBYAlA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tGX3zcoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C79C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRAl7-0001No-Sa
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 02:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjU-00084t-G1
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 02:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjR-0003pV-VW
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 02:55:32 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjN-0003mw-E5; Sun, 03 Nov 2019 02:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572767725; x=1604303725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o6hQdj7L0oPmZjyIXqAxLqekcwOscWKaimmvFu/uyI0=;
 b=VUZBYAlApl9/qFziXm1ZcBoBpi7AUXAkhS3vIQMSj1lbNRzWfsoZ1DP9
 wUB9ffckp7oNdBHzRk+vsacOuN4uDwwsGheG368tptaJX2ovaAaseVENg
 YsC3sguikLEngiTaLrVWt/kYEqOmeqsH6/rLLjfnVOsxlp7AJwZTqJtRv
 ys4O4WIGE+jX3IhfBJsgRQTxJFKgAKPOw9ptXe6CY2q1qaMDPemMQ3zc/
 Baw/cvpzUu7WfgYUqh7ANJl05BMTlEyyvjW+9ZyjDsGfC2RHsFJGxejh/
 7IxAouqRg3JLVr2w7MUkZH+NzClibg2wO5lLFNDFyk68QjBtQWJb2iNDM g==;
IronPort-SDR: HuseZSUvA4CThqoZzUGOXkW3sIhsHu7nbzI9KJ19a5t/ucuYxW3OnQShW4b6Q2Xff/rkL7yxPQ
 gHo/zrdl/RDNp2yQTLEKIl28oKTppl+Or/osB/WWxZ0OZcVawt582HipqeVGci7Lyza+/u6zwy
 NOxDSzQ74Jg0sZnLeGfMCslfYhKL2NKvx58WY3exImNdmrBrdK5TdGuZBhjTJZlzs0Su1V27FC
 4dK2RLGRssSraFomEAnq0w9iwFxYSODTeB5Yp5knoSxhQxPSeoG1grJsR+eDvQv9gJylVQllP2
 TvY=
X-IronPort-AV: E=Sophos;i="5.68,262,1569254400"; d="scan'208";a="229199000"
Received: from mail-dm3nam03lp2053.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.53])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2019 15:55:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcNEy32o/jPUHSXhGDXpUWbPSIIDJl0HejVmxajGHRZk4BR/JPcc+1hK5O+35teWMPWIJnUhDI6DSRCOlKpBYxJPGb5Gdu8KSRh67D6xFU4ygeedZkW9CLKTRGk63cr9OML+MDWxu9gVLIMtPjcIISiuOB/V4K3sTHCeGqzl76EDnKlok0+QBItCUxSLC1mlpijhcSiTvaMyV+3uaTb0sGmaKbnWlydD8BL4Bbdh5Ye7mbzprz4t+2pQbGK77Hy7JmamPFwKsxCgrE7XmDwWBduLi8+SykwThpkNwctkFPK9fm6ISLg8cWdbSJMqbwY4EFQUgNtuzhhkXKiAk59LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9qz/XnZ5x4KwvGwF1lN+CC+AZFDxgrFU65QSwbuSO4=;
 b=Ue8qD2zIPOrmcRYIylY5Lcv9C1NyVuTM0lrXZypHfbgzcppApo5edfq4m6sYJAS4KnO7D9xZdsXJVnrmTRwA/svO085dZSf9DCQkGEKlxQhRsg9pgn3cl5YloHuUdnkJ8Bwikro6u1sB0W6ZfpDIirMOL32LA7d1LDohSp47VePI3wYDJhcWooqiXNW/bCLosiB0oftQKnqjtMkyyCG7kHQcrziho92NRPFMwVCGaKdJJ00KCPb6X/TgRVTLO+u7k2LmnA6vDkan3qhCKmmLcWY66cf7uuwKNbzvOyRXqQ+py6idGs+XSJ9pI8yDwbVjXKAdBX12959dlZOUagcCyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9qz/XnZ5x4KwvGwF1lN+CC+AZFDxgrFU65QSwbuSO4=;
 b=tGX3zcoGVjUV/PxOH+msTVB9JtAf6BDhZ0uH2ADCoh18PEk0symZbCSVxo3IvxXg2JbocjIWgYGRN3eDsAnVI+BrcpNyJ5/wT09XyBYDpXiS7Ay/95HHu1x6pxluOkI0t22OM+M0E3K/7oIe2wU2C4OGKJDay0E3A1M7ZcCfl6M=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB4635.namprd04.prod.outlook.com (20.176.106.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Sun, 3 Nov 2019 07:55:23 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::dd8a:a9c0:97c5:cd70]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::dd8a:a9c0:97c5:cd70%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 07:55:23 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v6 1/3] hw: rtc: Add Goldfish RTC device
Thread-Topic: [PATCH v6 1/3] hw: rtc: Add Goldfish RTC device
Thread-Index: AQHVkhwL02B5pSK/0UiGl9Z4PAWbsg==
Date: Sun, 3 Nov 2019 07:55:23 +0000
Message-ID: <20191103075353.86497-2-anup.patel@wdc.com>
References: <20191103075353.86497-1-anup.patel@wdc.com>
In-Reply-To: <20191103075353.86497-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::20) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.18.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0fdee6f-f36d-4f49-aef6-08d760332e14
x-ms-traffictypediagnostic: DM6PR04MB4635:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4635E59103CE2FA7B16AA1768D7C0@DM6PR04MB4635.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(71200400001)(55236004)(4326008)(305945005)(66556008)(71190400001)(6116002)(76176011)(3846002)(14454004)(102836004)(36756003)(256004)(476003)(110136005)(14444005)(8936002)(7736002)(99286004)(54906003)(81166006)(386003)(316002)(2616005)(11346002)(966005)(6306002)(25786009)(26005)(6436002)(50226002)(66066001)(6506007)(1076003)(66476007)(478600001)(2171002)(81156014)(8676002)(9456002)(5660300002)(6512007)(64756008)(446003)(52116002)(486006)(6486002)(66946007)(44832011)(2906002)(186003)(66446008)(30864003)(86362001)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4635;
 H:DM6PR04MB6059.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z1tm5OdgDq2QNOHVc0O8/O7t6RlxZQuqluBSrcO9AFmDL+pp4eKRM+Oqjiv+Jru7cGB6o1I6ts9cEihMJYZpbXdKCLDUgjznTABm0aTYweNWr4+x8bQ5niMlmMRpLfAF+1hEuVw3wEbw9KK1FcYb3fqbkYmOG3Gbk+vAaYcJx/E7poS3ucYO7juZU4gmwkLfq0BUvv8y74WqS10eZbExCQwuJODcc4pJ2mQDJ4Bz+R8kiZFzl8f4Ln6LadqEl24RqXi3G7/rWiS2UF2Sw7feLWfPDb4EwayKH8DlqcLCilN7R9MFNOgQzv614ZMbcIoIGyddULkHD1N6YXxH2VArc59EkNt4Jmeff7YY2M8lu2W0r3fvcAke7KrtmPUtmYg+tyBZcnvqxYdw536OLsTVd7idUolXDLGh+w7tuVz2TWoAgENhpWxzvSQ07ECHB/+5kP+m3QhJv4d8jqJJO+FhlGEQpvFw5fEsDuTwN9cuYv8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fdee6f-f36d-4f49-aef6-08d760332e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 07:55:23.3348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHOizB52pkcRgUpAaIW68RaJGcq4FU1g7zCwwZdqAeIyiFkisfFh0qAdbpitraTZS/5f6JvCMZYTYTlGCNbaHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4635
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds model for Google Goldfish virtual platform RTC device.

We will be adding Goldfish RTC device to the QEMU RISC-V virt machine
for providing real date-time to Guest Linux. The corresponding Linux
driver for Goldfish RTC device is already available in upstream Linux.

For now, VM migration support is available but untested for Goldfish RTC
device. It will be hardened in-future when we implement VM migration for
KVM RISC-V.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/rtc/Kconfig                |   3 +
 hw/rtc/Makefile.objs          |   1 +
 hw/rtc/goldfish_rtc.c         | 288 ++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events           |   4 +
 include/hw/rtc/goldfish_rtc.h |  46 ++++++
 5 files changed, 342 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/rtc/goldfish_rtc.h

diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 45daa8d655..bafe6ac2c9 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -21,3 +21,6 @@ config MC146818RTC
=20
 config SUN4V_RTC
     bool
+
+config GOLDFISH_RTC
+    bool
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 8dc9fcd3a9..aa208d0d10 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -11,3 +11,4 @@ common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
 obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
 common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
 common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_rtc.o
+common-obj-$(CONFIG_GOLDFISH_RTC) +=3D goldfish_rtc.o
diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
new file mode 100644
index 0000000000..f71f6eaab0
--- /dev/null
+++ b/hw/rtc/goldfish_rtc.c
@@ -0,0 +1,288 @@
+/*
+ * Goldfish virtual platform RTC
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ *
+ * For more details on Google Goldfish virtual platform refer:
+ * https://android.googlesource.com/platform/external/qemu/+/master/docs/G=
OLDFISH-VIRTUAL-HARDWARE.TXT
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/rtc/goldfish_rtc.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
+
+#include "trace.h"
+
+#define RTC_TIME_LOW            0x00
+#define RTC_TIME_HIGH           0x04
+#define RTC_ALARM_LOW           0x08
+#define RTC_ALARM_HIGH          0x0c
+#define RTC_IRQ_ENABLED         0x10
+#define RTC_CLEAR_ALARM         0x14
+#define RTC_ALARM_STATUS        0x18
+#define RTC_CLEAR_INTERRUPT     0x1c
+
+static void goldfish_rtc_update(GoldfishRTCState *s)
+{
+    qemu_set_irq(s->irq, (s->irq_pending & s->irq_enabled) ? 1 : 0);
+}
+
+static void goldfish_rtc_interrupt(void *opaque)
+{
+    GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;
+
+    s->alarm_running =3D 0;
+    s->irq_pending =3D 1;
+    goldfish_rtc_update(s);
+}
+
+static uint64_t goldfish_rtc_get_count(GoldfishRTCState *s)
+{
+    return s->tick_offset + (uint64_t)qemu_clock_get_ns(rtc_clock);
+}
+
+static void goldfish_rtc_clear_alarm(GoldfishRTCState *s)
+{
+    timer_del(s->timer);
+    s->alarm_running =3D 0;
+}
+
+static void goldfish_rtc_set_alarm(GoldfishRTCState *s)
+{
+    uint64_t ticks =3D goldfish_rtc_get_count(s);
+    uint64_t event =3D s->alarm_next;
+
+    if (event <=3D ticks) {
+        goldfish_rtc_clear_alarm(s);
+        goldfish_rtc_interrupt(s);
+    } else {
+        /*
+         * We should be setting timer expiry to:
+         *     qemu_clock_get_ns(rtc_clock) + (event - ticks)
+         * but this is equivalent to:
+         *     event - s->tick_offset
+         */
+        timer_mod(s->timer, event - s->tick_offset);
+        s->alarm_running =3D 1;
+    }
+}
+
+static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
+                                  unsigned size)
+{
+    GoldfishRTCState *s =3D opaque;
+    uint64_t r =3D 0;
+
+    switch (offset) {
+    case RTC_TIME_LOW:
+        r =3D goldfish_rtc_get_count(s) & 0xffffffff;
+        break;
+    case RTC_TIME_HIGH:
+        r =3D goldfish_rtc_get_count(s) >> 32;
+        break;
+    case RTC_ALARM_LOW:
+        r =3D s->alarm_next & 0xffffffff;
+        break;
+    case RTC_ALARM_HIGH:
+        r =3D s->alarm_next >> 32;
+        break;
+    case RTC_IRQ_ENABLED:
+        r =3D s->irq_enabled;
+        break;
+    case RTC_ALARM_STATUS:
+        r =3D s->alarm_running;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%x\n", __func__, (uint32_t)offset)=
;
+        break;
+    }
+
+    trace_goldfish_rtc_read(offset, r);
+
+    return r;
+}
+
+static void goldfish_rtc_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    GoldfishRTCState *s =3D opaque;
+    uint64_t current_tick, new_tick;
+
+    switch (offset) {
+    case RTC_TIME_LOW:
+        current_tick =3D goldfish_rtc_get_count(s);
+        new_tick =3D current_tick & (0xffffffffULL << 32);
+        new_tick |=3D value;
+        s->tick_offset +=3D new_tick - current_tick;
+        break;
+    case RTC_TIME_HIGH:
+        current_tick =3D goldfish_rtc_get_count(s);
+        new_tick =3D current_tick & 0xffffffffULL;
+        new_tick |=3D (value << 32);
+        s->tick_offset +=3D new_tick - current_tick;
+        break;
+    case RTC_ALARM_LOW:
+        s->alarm_next &=3D (0xffffffffULL << 32);
+        s->alarm_next |=3D value;
+        goldfish_rtc_set_alarm(s);
+        break;
+    case RTC_ALARM_HIGH:
+        s->alarm_next &=3D 0xffffffffULL;
+        s->alarm_next |=3D (value << 32);
+        break;
+    case RTC_IRQ_ENABLED:
+        s->irq_enabled =3D (uint32_t)(value & 0x1);
+        goldfish_rtc_update(s);
+        break;
+    case RTC_CLEAR_ALARM:
+        goldfish_rtc_clear_alarm(s);
+        break;
+    case RTC_CLEAR_INTERRUPT:
+        s->irq_pending =3D 0;
+        goldfish_rtc_update(s);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%x\n", __func__, (uint32_t)offset)=
;
+        break;
+    }
+
+    trace_goldfish_rtc_write(offset, value);
+}
+
+static int goldfish_rtc_pre_save(void *opaque)
+{
+    uint64_t delta;
+    GoldfishRTCState *s =3D opaque;
+
+    /*
+     * We want to migrate this offset, which sounds straightforward.
+     * Unfortunately, we cannot directly pass tick_offset because
+     * rtc_clock on destination Host might not be same source Host.
+     *
+     * To tackle, this we pass tick_offset relative to vm_clock from
+     * source Host and make it relative to rtc_clock at destination Host.
+     */
+    delta =3D qemu_clock_get_ns(rtc_clock) -
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    s->tick_offset_vmstate =3D s->tick_offset + delta;
+
+    return 0;
+}
+
+static int goldfish_rtc_post_load(void *opaque, int version_id)
+{
+    uint64_t delta;
+    GoldfishRTCState *s =3D opaque;
+
+    /*
+     * We extract tick_offset from tick_offset_vmstate by doing
+     * reverse math compared to pre_save() function.
+     */
+    delta =3D qemu_clock_get_ns(rtc_clock) -
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    s->tick_offset =3D s->tick_offset_vmstate - delta;
+
+    return 0;
+}
+
+static const MemoryRegionOps goldfish_rtc_ops =3D {
+    .read =3D goldfish_rtc_read,
+    .write =3D goldfish_rtc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4
+    }
+};
+
+static const VMStateDescription goldfish_rtc_vmstate =3D {
+    .name =3D TYPE_GOLDFISH_RTC,
+    .version_id =3D 1,
+    .pre_save =3D goldfish_rtc_pre_save,
+    .post_load =3D goldfish_rtc_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(tick_offset_vmstate, GoldfishRTCState),
+        VMSTATE_UINT64(alarm_next, GoldfishRTCState),
+        VMSTATE_UINT32(alarm_running, GoldfishRTCState),
+        VMSTATE_UINT32(irq_pending, GoldfishRTCState),
+        VMSTATE_UINT32(irq_enabled, GoldfishRTCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void goldfish_rtc_reset(DeviceState *dev)
+{
+    GoldfishRTCState *s =3D GOLDFISH_RTC(dev);
+    struct tm tm;
+
+    timer_del(s->timer);
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset =3D mktimegm(&tm);
+    s->tick_offset *=3D NANOSECONDS_PER_SECOND;
+    s->tick_offset -=3D qemu_clock_get_ns(rtc_clock);
+    s->tick_offset_vmstate =3D 0;
+    s->alarm_next =3D 0;
+    s->alarm_running =3D 0;
+    s->irq_pending =3D 0;
+    s->irq_enabled =3D 0;
+}
+
+static void goldfish_rtc_realize(DeviceState *d, Error **errp)
+{
+    SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
+    GoldfishRTCState *s =3D GOLDFISH_RTC(d);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &goldfish_rtc_ops, s,
+                          "goldfish_rtc", 0x1000);
+    sysbus_init_mmio(dev, &s->iomem);
+
+    sysbus_init_irq(dev, &s->irq);
+
+    s->timer =3D timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
+}
+
+static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D goldfish_rtc_realize;
+    dc->reset =3D goldfish_rtc_reset;
+    dc->vmsd =3D &goldfish_rtc_vmstate;
+}
+
+static const TypeInfo goldfish_rtc_info =3D {
+    .name          =3D TYPE_GOLDFISH_RTC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(GoldfishRTCState),
+    .class_init    =3D goldfish_rtc_class_init,
+};
+
+static void goldfish_rtc_register_types(void)
+{
+    type_register_static(&goldfish_rtc_info);
+}
+
+type_init(goldfish_rtc_register_types)
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index d6749f4616..0bfaa26cb8 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -17,3 +17,7 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
 # aspeed-rtc.c
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value=
 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " valu=
e 0x%08" PRIx64
+
+# goldfish_rtc.c
+goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
+goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
new file mode 100644
index 0000000000..3be586bdcb
--- /dev/null
+++ b/include/hw/rtc/goldfish_rtc.h
@@ -0,0 +1,46 @@
+/*
+ * Goldfish virtual platform RTC
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ *
+ * For more details on Google Goldfish virtual platform refer:
+ * https://android.googlesource.com/platform/external/qemu/+/master/docs/G=
OLDFISH-VIRTUAL-HARDWARE.TXT
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_RTC_GOLDFISH_RTC_H
+#define HW_RTC_GOLDFISH_RTC_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_GOLDFISH_RTC "goldfish_rtc"
+#define GOLDFISH_RTC(obj) \
+OBJECT_CHECK(GoldfishRTCState, (obj), TYPE_GOLDFISH_RTC)
+
+typedef struct GoldfishRTCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    QEMUTimer *timer;
+    qemu_irq irq;
+
+    uint64_t tick_offset;
+    uint64_t tick_offset_vmstate;
+    uint64_t alarm_next;
+    uint32_t alarm_running;
+    uint32_t irq_pending;
+    uint32_t irq_enabled;
+} GoldfishRTCState;
+
+#endif
--=20
2.17.1


