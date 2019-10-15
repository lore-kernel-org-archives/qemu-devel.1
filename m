Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA95ECE58E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BE72064B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G56guoy4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FoCvmQmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BE72064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIK9-0008Vl-Py
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIIy-00077Z-Fx
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIIs-0004SF-A5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49833)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1843cfbdc=Anup.Patel@wdc.com>)
 id 1iKIIn-0004Ik-II; Tue, 15 Oct 2019 04:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571128534; x=1602664534;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=P15lxcgohDyu36MDbduDpdWuOGjvpXySqTq7JaHfo4k=;
 b=G56guoy4Lr8zZUjFt3GgzW7XWBnGYV+p3XIvZ/uEACFv445sEQyS8D27
 aahs2jn3HYYY2pu0zngTiWoBiPDHpMcnum8sEU8s62yhdBtLQiqB8tUsn
 3Bl8sQkYul00md/UNjSQCBOoM/HctMbd7dIwa2PqjgV+qnc0y48ui47bA
 Rq6a0h/OzBFlRFpuTObSMA3n4eGHS/ZrqTKGgpPRDCkuZQj64MRP3PRcw
 qoyjvrJYOjYQWQSfn7eqtEK/DQXjPsMoN1vdJhuy87QsDnJumR6dCdBqO
 AZyP+lkNs2I/ZVv6AU8D/jcpHx2FrQ1eoSw9zBno6YDjQocndX6j+Wkp9 w==;
IronPort-SDR: u+uNYDMOAibfMX8dfwOHK+RsJmAfrib2xZtGDhgEqLEsJjSnCMoyadrboIDNxinhEpeKQCBKwC
 Df4Z7mrYcvoddORR2ynjpSxQRLMqQ6hBvDNoG6lW0lb/HMeMwBkQmrHwHSDJXhG3vowiDB7qlM
 7shcqS7bYuyZZx6yNjbFeu2zqyO0cOMtNjvUlzPvD0PBjWaoBhW5LOY8UCZxlBCAJlzjnsa4jI
 hj4A/XX7eEdc9Bx5jjcNMXQcxIVM+gaLciSUfdNcrilgigSnf7/X5Ppm93Z5LAHvx2PMrrRDBN
 opo=
X-IronPort-AV: E=Sophos;i="5.67,298,1566835200"; d="scan'208";a="124990119"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
 by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2019 16:35:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egKtogwSzRo2Bjb6+PhshoVmdW9C+OznagIka3KaDRgdzSfs/Y7vCTqzDyZ5KdRBKEhRK1ofcR7IEA1C2Mvkx36Nskiqzny2bNGsC6C1F1gDrRUeDHtoJl+Synj79wYEp/iy7YUNMREpyGt93fpUHAlJKSZ+V7lij8VjKYLMyMKVWuFI47uyU5pi2RmJfRoZ/4MJ/JC0M7HeOSKWxRpV0GRhmzBNsYZA2LPmTGABeQ/LkyV2TLLiBwYF+AE4ml+2mypRfMurWZKnbuptvcYjWZZ4biPa+JZDvsm2CoYfh1u66DMjWwGy00hRnis14tAn2zlYjZp5nqkmfnjZNGLTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M6++CEVWku1oBRGvgS1Pd63cuMYPV9DsIEKbgqFbjg=;
 b=fiCvLTAQptHuPYwCLwuTztyPYiuRPtwWqCe5IAirkZxInXX3vK8HR9LGlcWvOqlj0Qn807amoHWvlhg0JqX7IrBbxcByhUYzTnkXyzBWaLnPNqwPUUFLoyDKoHew4Bo54D14omdEepo8dzH6nSWMF1yFRmwVp6uBxBZX8zesULam4JLmqQAKvPPYK3ivWd+1FHFeeMy09f9p5hBCgofIHrR/+DR+voS8PXtDSbJck7hsQ1IoBbUzYNEO5IorM4n65tuKgpPd7UffO3Ua6joh4qOGd9+mF3DfCfgJ6CoV4mabQsBju8pbuJH2TOjHuARqBiDWKQ0h6tcpM4G6nAfQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M6++CEVWku1oBRGvgS1Pd63cuMYPV9DsIEKbgqFbjg=;
 b=FoCvmQmItAwHK3jK4jrfN897ocfKlaNt5c5FVjojDzSGpSNWommAVXs9juyvcTbdwA1yZ7yzrdn194Llt9sSpzJtmsMmwtnUq1gJTHbOMfUqqkYNYyL0bKqnIJ7qth0l/C2++TNz33MrfAx5zo4Ecs6SIvYycAxStQOV8G3H+t0=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB7071.namprd04.prod.outlook.com (10.186.146.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 15 Oct 2019 08:35:31 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:35:31 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v3 1/2] hw: timer: Add Goldfish RTC device
Thread-Topic: [PATCH v3 1/2] hw: timer: Add Goldfish RTC device
Thread-Index: AQHVgzOBWMKi/ApwYEm2Tq90mJ++Ng==
Date: Tue, 15 Oct 2019 08:35:31 +0000
Message-ID: <20191015083459.76959-2-anup.patel@wdc.com>
References: <20191015083459.76959-1-anup.patel@wdc.com>
In-Reply-To: <20191015083459.76959-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0128.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::22) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d51f8e51-0931-4945-de21-08d7514aa37c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB70713D1880CE80B06A90DF5C8D930@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(189003)(199004)(26005)(71200400001)(11346002)(256004)(14444005)(446003)(66946007)(386003)(6506007)(66476007)(66556008)(64756008)(66446008)(14454004)(966005)(36756003)(71190400001)(102836004)(186003)(478600001)(44832011)(66066001)(476003)(486006)(2616005)(2906002)(25786009)(5660300002)(86362001)(81166006)(3846002)(316002)(50226002)(305945005)(1076003)(4326008)(2171002)(6306002)(6512007)(6486002)(54906003)(30864003)(8676002)(8936002)(110136005)(76176011)(7736002)(52116002)(99286004)(6116002)(6436002)(81156014)(2004002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB7071;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDZUt6Y3juCWvHehvifoAHLjeXKKZsZVc5FSaVSNyNw+s6zhZWsI/bSMh+SK5o6VFV0pzLujsZkyCcdG0C5mX9eNyw3EuPO1arvzcBXXDPNEKqLcugjk5gqeiuQyvbjDlyQsu5QKuxhCyJRJcPp0bphhXoFu1UpVudn3q2GGmJ1M7191kMn2GpW+9GdUgK2wWuoQN5ifAGlGMOY1kDaYjYkD4Oizqs2Ek/Wu2EWtZmKjhgxoMYOWROEEwmubCpUhvb3CIJbhDBMU56ltm3SRv3H3BICsfzmby8JD0WKTEYQuNfuY4p4YeuL8O2Rw+I72ZMlLIOK1RARgTicvNx4qjxJs7I7ZMkj/VzWVI+eI4NdRazPRr5NtmQXLaZ6MLv/eiVMjf87xbXDkcMbCebjmJA1eTh+mAVFbh5Bn9Diacl2yC21U6MPF3XP+XnZJPFKEfEtwvDoHOFZfWyqMlhWz+w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51f8e51-0931-4945-de21-08d7514aa37c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 08:35:31.0642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wb//qyIusOzwLzTdF5pf3MjDlQjPtzEy4zgpyOlRUtMHnOMZf6Cw2cyv1UD2VknpiaVXvAYJv8pdtdViyGxvKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
---
 hw/rtc/Kconfig                  |   3 +
 hw/rtc/Makefile.objs            |   1 +
 hw/rtc/goldfish_rtc.c           | 278 ++++++++++++++++++++++++++++++++
 include/hw/timer/goldfish_rtc.h |  46 ++++++
 4 files changed, 328 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/timer/goldfish_rtc.h

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
index 0000000000..223616ed75
--- /dev/null
+++ b/hw/rtc/goldfish_rtc.c
@@ -0,0 +1,278 @@
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
+#include "hw/timer/goldfish_rtc.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qemu/timer.h"
+#include "sysemu/sysemu.h"
+#include "qemu/cutils.h"
+#include "qemu/log.h"
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
+        int64_t now =3D qemu_clock_get_ns(rtc_clock);
+        timer_mod(s->timer, now + (event - ticks));
+        s->alarm_running =3D 1;
+    }
+}
+
+static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
+                                  unsigned size)
+{
+    GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;
+    uint64_t r;
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
+                      "goldfish_rtc_read: Bad offset 0x%x\n", (int)offset)=
;
+        r =3D 0;
+        break;
+    }
+
+    return r;
+}
+
+static void goldfish_rtc_write(void *opaque, hwaddr offset,
+                               uint64_t value, unsigned size)
+{
+    uint64_t current_tick, new_tick;
+    GoldfishRTCState *s =3D (GoldfishRTCState *)opaque;
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
+                      "goldfish_rtc_write: Bad offset 0x%x\n", (int)offset=
);
+        break;
+    }
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
+     * rtc_clock on destinetion Host might not be same source Host.
+     *
+     * To tackle, this we pass tick_offset relative to vm_clock from
+     * source Host and make it relative to rtc_clock at destinetion Host.
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
diff --git a/include/hw/timer/goldfish_rtc.h b/include/hw/timer/goldfish_rt=
c.h
new file mode 100644
index 0000000000..dfb6d70b86
--- /dev/null
+++ b/include/hw/timer/goldfish_rtc.h
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
+#ifndef HW_TIMER_GOLDFISH_RTC_H
+#define HW_TIMER_GOLDFISH_RTC_H
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


