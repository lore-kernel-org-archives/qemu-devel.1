Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F54C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92102075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IUi7DUYM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZErYw9Kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92102075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJxU-0006hn-2e
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvf-0004e5-Dn
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvd-00062V-5r
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvY-0005zm-Bi; Wed, 06 Nov 2019 06:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573041404; x=1604577404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KXbtW0yecdF2dj2yi8gwhpg+ewMI9AuRMIpxq//Ts3M=;
 b=IUi7DUYMjUVT9ew5dBALZ4GI9m6fPdQGDfwEl9goqrnuyAP+73GH1z9l
 4Jdw0CRPvdjviqKzEYBDix0AqROFbzNhRKs6UEzf9xGWf/0aLkl8eF0Zw
 M1X0cJbQLUK2QeRgpj90qPzFEqdm+iNI6xXJf/pHT//GjperkIxbFmRoB
 1ITXXvJslYdSZjmw5oovREEkfTfSlsaQLy42+CcyZ6Ttdr0CGnP+jhym6
 SVwMBSHb1/A7k7WEQ8AGP439Zg/wo43d98azfXDibc5uDn66rFxvSqU3W
 3ZIKFW/m+HfKAdfg2AxLj4TsH6L40IxcjzVlRWjBlvbslv35w8em+pVap w==;
IronPort-SDR: k2AZR/1xv6Ec6cqBmkd1SE2zNq29Ns0zo4ANYEIIUVvL2WpAbubTcRHMflXuO9axGI9g+5P2dM
 YGiuZ3cMxLm9mF5psU6Na363C78UldHsGmOZIuOal6szVGjwmvXKsaZWOa9fFL8zYQldcSmnOw
 OjjMVqpHNBUQmQYNVsyNYB7fTYFaC8LtjfqT/n0SzR+e45idtWVsB1+ePLYNt3QXofPTmOtM6N
 T08+d3LN710hbFNPv98az0bdEsN3roS+FjSrU0mjqIdogFFzVG6anY1yp6jdySIE6Cwbifd5Ul
 s+g=
X-IronPort-AV: E=Sophos;i="5.68,274,1569254400"; d="scan'208";a="123022214"
Received: from mail-dm3nam05lp2057.outbound.protection.outlook.com (HELO
 NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.57])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 19:56:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE2EwPcr6nyUVbhdglKVUqD+m1cNN7JhLU4EhKnDOp19xRybnKqnPTFxv+krKgKh60f27xzNQhUsPvJ+H1bQyJ8fjUouWVrOaxbVq8yP0ka35wLwibEQgI89U8ekzGOCntyFRysDFNrHdOSoGlFIchcmRZ6v6VXVWy2lVkX1bMec7prwLCk6aecCl1Q0xh1UzW7wWrsZiW6pkW5nuad8RMvkdCQiOagH8pMBbgzRlDoBDueW4Zh9Sym6QM1rf/8w9MVjSSZ1aCVc9k1Dce8Ail1ldIQVX/d5Eglgcv6OQLroHlJEeJDcxo0En2xIWIUGZiTQNkc8PD5zSabBUrfX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UESNB/El9DkJebqr2gddAc6J5InjRa8rAD+Tl8z4gCU=;
 b=eBZ2SH7hZhQdCzybXKn18jWfxXMDClv15eYETwP3C3YKyldatnPoEvSVGDE/oK0ObNoB+EZ83SSq7Tld+tWFhJT5BnmkMRitlAXeDflQu0Cf9UxeWevyIF457OJj684rOFMumYnqZwS169HdD9khFjvWO+mC1zhft348pAM2b5RnHFlCvPc59vLPtxU2PdYky/VZpi3TPwT7ljPjh9lSYJZol2BGY2enxlbUsjoBUG+RsUpyqu/5z3q2kRpPIUc8QPhHrZ/bbxj9Lbi0chBQm350Metc2/UaCD3npGgEBhaWOfZMJe1/jcZagIn3tQdj99gllBZKLVbNaJXX5+27BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UESNB/El9DkJebqr2gddAc6J5InjRa8rAD+Tl8z4gCU=;
 b=ZErYw9Khzl4Zi+pQ14r0/JkucA1vX9K4xSVdBBEXUdXw6Bpzw+2rcse/MzJO9bnhbHPEPWNyeaMKZpEkpUs9H4JBOz91bad+TqTZUtAfXp3k0yJ99jHj8pmza/ZTSdtt+gBYptcm3iaJJgG2U2cg0XufZC0zXt7SLj93L/0XNHE=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6080.namprd04.prod.outlook.com (20.178.247.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 11:56:37 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 11:56:37 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v8 1/3] hw: rtc: Add Goldfish RTC device
Thread-Topic: [PATCH v8 1/3] hw: rtc: Add Goldfish RTC device
Thread-Index: AQHVlJk9wHTH22rvOkqBg2gcURUTgw==
Date: Wed, 6 Nov 2019 11:56:36 +0000
Message-ID: <20191106115602.74299-2-anup.patel@wdc.com>
References: <20191106115602.74299-1-anup.patel@wdc.com>
In-Reply-To: <20191106115602.74299-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::11) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.25.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfcf289f-6e6d-42ae-7af7-08d762b06033
x-ms-traffictypediagnostic: MN2PR04MB6080:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6080277CA6B80623AB9BF73B8D790@MN2PR04MB6080.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(9456002)(2616005)(6506007)(99286004)(52116002)(55236004)(102836004)(186003)(36756003)(76176011)(66556008)(81156014)(8676002)(26005)(8936002)(6116002)(50226002)(476003)(256004)(2171002)(14444005)(386003)(6512007)(4326008)(44832011)(71200400001)(71190400001)(6306002)(7736002)(30864003)(966005)(2906002)(5660300002)(14454004)(6486002)(1076003)(3846002)(446003)(486006)(11346002)(66946007)(66476007)(64756008)(110136005)(54906003)(81166006)(316002)(86362001)(66066001)(478600001)(25786009)(66446008)(6436002)(305945005)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6080;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fofFfq/IvSWAoeuAmMeda5eW3rjpA0vykwA9pp+/uRg9m56v7U5g37/DECGH8fBX2qD4qeavynN5ukOjygrTFu0hjNbJneM5ZoDCzpyrljT/aichb8f8Tf1gY8otq8qx1zbc2YsLbTEYp1efgN9Ws9igc8DTtosDfE8DGeeF3UfBnwf5YEqS6MHkD6xRAHi2ienvrR/eqccnwcOEizoKipaKra5k+6tRfACSBhaNLq/jO9akLfxSCR6Yb91ESHMNiQNCjD9EjtJOnryNADkEWNfohRmYx9sHgYYQeCrCpGEWz8dpqh7V2EC8GTUHmmilbiDQzkf7oU13+NRThynubic2NPoVGQ95r6AudHRwTtmj5alauDC/7QOhjfisntIXb8ww8c/KlAdWM5zjwYopPlIDEe+63a27yMMJLrR1CinJ2sRJemhyWXCd4KE5J85vgR+fVMVrN0sqb0W69DV4SG01OVESfgiTXoF5q7TgBc8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcf289f-6e6d-42ae-7af7-08d762b06033
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 11:56:36.7715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57BtXxFDo++JNwoHsCS7nl/EfNXWRov2JBo30kC535cZmCIhTI9SQppZmx5Jzld0LN7mpEnJZfnv1au1xTTVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6080
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Anup Patel <anup@brainfault.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Philippe Mathieu-Daude <philmd@redhat.com>
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
 hw/rtc/goldfish_rtc.c         | 285 ++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events           |   4 +
 include/hw/rtc/goldfish_rtc.h |  46 ++++++
 5 files changed, 339 insertions(+)
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
index 0000000000..01e9d2b083
--- /dev/null
+++ b/hw/rtc/goldfish_rtc.c
@@ -0,0 +1,285 @@
+/*
+ * Goldfish virtual platform RTC
+ *
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ *
+ * For more details on Google Goldfish virtual platform refer:
+ * https://android.googlesource.com/platform/external/qemu/+/refs/heads/em=
u-2.0-release/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
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
+#include "qemu/bitops.h"
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
+                  "%s: offset 0x%x is UNIMP.\n", __func__, (uint32_t)offse=
t);
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
+        new_tick =3D deposit64(current_tick, 0, 32, value);
+        s->tick_offset +=3D new_tick - current_tick;
+        break;
+    case RTC_TIME_HIGH:
+        current_tick =3D goldfish_rtc_get_count(s);
+        new_tick =3D deposit64(current_tick, 32, 32, value);
+        s->tick_offset +=3D new_tick - current_tick;
+        break;
+    case RTC_ALARM_LOW:
+        s->alarm_next =3D deposit64(s->alarm_next, 0, 32, value);
+        goldfish_rtc_set_alarm(s);
+        break;
+    case RTC_ALARM_HIGH:
+        s->alarm_next =3D deposit64(s->alarm_next, 32, 32, value);
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
+                  "%s: offset 0x%x is UNIMP.\n", __func__, (uint32_t)offse=
t);
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
+                          "goldfish_rtc", 0x24);
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
index 0000000000..16f9f9e29d
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
+    OBJECT_CHECK(GoldfishRTCState, (obj), TYPE_GOLDFISH_RTC)
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


