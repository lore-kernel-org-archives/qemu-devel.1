Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909ABC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DDD2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BX43y6za";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qRBfhYLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DDD2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgSM-00015k-JY
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPa-0007Zq-J2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPX-0004qL-GH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:43:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:18288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPR-0004jt-5m; Tue, 24 Sep 2019 04:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569314745; x=1600850745;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mp/aY7pw0zeNVnjehXKYxVDk8LhQ/SEiI0xHe6aoTuI=;
 b=BX43y6zaV2QeNVA2jD3TIcObos9vSJZnchSQlkCEbPQmQSKQbRMa1YpM
 2/SgnMQDqwsJKSzQrBddlF9ZVFrvabWzEbUHGa7ibt5ypI6I3Ta7I2/jK
 VfUFv16tkr7isYx6FHfoLWND8D6/MCylF+JRgEHf8uRpkFuRngiqAMo4H
 ivrfKtHWvNaKxFJFmQmvB2G0mxavUv3uoj+EhWQnmdkb2oKEKC3h3bV16
 eB91lc2rZpc8tKaTCQVSv0x+MsGblcw1VgHKhkTgz1Fc/gTbFYxJeBgFJ
 g19Z4B0sp/CGzmbubZx1ZxZIN3EHO4VmhQurtPBTtVFJFzEsQp+zhh4ml A==;
IronPort-SDR: HepMsxZugNlq+XCHk+eAmpnuVcbjWrVQjb1CNXU6puSXHikGL13/Y2zZtb6a63osnYeNwa9A6I
 nuXI/SNxxcUW4me+9lsw4+iUCXzALzg57SqJHWeCP/mvkrXuCuDdJ5J49W2gUiyOgkZSsth3F7
 X5b2of9OlkE9EhidRubJG2URQBHB+v1MFY4pVt6wMgCYDyplo0pVcZxAxMa6NFhaUvS2a/OfrJ
 vhg6xRJCFRAcicVtLH1AGapoDErO/r02D/vJDzpWzGnp1lR01OwBcGDD9SuAKr2DIntRDA2XGK
 1wQ=
X-IronPort-AV: E=Sophos;i="5.64,543,1559491200"; d="scan'208";a="219790926"
Received: from mail-by2nam01lp2053.outbound.protection.outlook.com (HELO
 NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.53])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 16:45:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJaiwY6T+jn3L+M7fFU7j176yQDdlc9uyT+lR/aMgRfTo8mBejMjSrxkjZICr+cDdWo8uOCIMKc4mFqyvevUKJ3KIdPArzv3JcFjtubaG59R0B9ERKf5N5dEp7n6Q59PRaemZJdO0Y93aHBNnLdjs0Gu0hPpeirfLZxqF4fMNutKB3chWr6VKg7vBzH0/IYVaaCUU4m5BK5jZzXwbuppRsFnjei/dOj0iJdrNnnJq++HsI5cHoJ7nU7vfZyGweGkAIWiyFCBtRcPZxIH2kql4fv7oI7EbJIGI06KQJ39x3Eda25dphqpVRw11DRtvzIU8mycFAY2SQnuse2bm8enYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKfwltsteghdnOhYqJsBtyik+Gu6VWzyk8bsxuPReMA=;
 b=P+pG07r7/6w9gQIl2hOdoLva+r8y1M+b0Tjme/Hma6GCg3Sele2556jy9lj/EQIInIniIIzqMuZQBVgsV5zyrtaIuCp/bAVzSbpdBithwDuV58XZ9L2Hrb0WvVZHrApSjC8tQ2gsiPoxyCHh1608xpESxZAYzYmoOekR5j1anMyAjFd+CQlD1b3lpFG0drDU2YHXsl+LSz8vH2Ls8zypHY3bS4utCcnijNhnJoWaCYaZUu12cHSJB+fl/Ox+/cTNsSiEp9lYVsXM2akfSDoXBRJK39UrNv+87XXRUE7dXRXUixQEzfMFJt2rOOjjt1388YhKsILTZOzAW9dAccO7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKfwltsteghdnOhYqJsBtyik+Gu6VWzyk8bsxuPReMA=;
 b=qRBfhYLx7/rrrmSrU0/h7wq8q4fddBHUC3DNwl8YnD935z4vd0pApgLaNnMTA2DqXsVHR7UfRh5/CFJ+rJEhhupC8Bos06d4ypG7IBscZmV8AD/FH2mB1RJduI5jScgCTwvDZKe0G48Mb/La54bkRIWhoPngNmKzJBusm5kcK40=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6957.namprd04.prod.outlook.com (10.186.147.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Tue, 24 Sep 2019 08:42:52 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:42:52 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH 1/2] hw: timer: Add Goldfish RTC device
Thread-Topic: [PATCH 1/2] hw: timer: Add Goldfish RTC device
Thread-Index: AQHVcrQNCvgG16FtZEeROSOS3DihBQ==
Date: Tue, 24 Sep 2019 08:42:51 +0000
Message-ID: <20190924084201.107958-2-anup.patel@wdc.com>
References: <20190924084201.107958-1-anup.patel@wdc.com>
In-Reply-To: <20190924084201.107958-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fef5224f-ba79-483f-8d49-08d740cb2f3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MN2PR04MB6957; 
x-ms-traffictypediagnostic: MN2PR04MB6957:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB69570D9E71DCD7768C4DA9698D840@MN2PR04MB6957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:328;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(76176011)(66446008)(2171002)(5660300002)(66556008)(25786009)(99286004)(86362001)(14444005)(50226002)(966005)(44832011)(66066001)(1076003)(8936002)(2616005)(6506007)(54906003)(256004)(305945005)(446003)(81156014)(478600001)(6306002)(8676002)(81166006)(3846002)(2906002)(6486002)(71190400001)(14454004)(26005)(71200400001)(11346002)(7736002)(386003)(66946007)(316002)(52116002)(64756008)(4326008)(186003)(6512007)(6116002)(66476007)(36756003)(110136005)(476003)(6436002)(102836004)(486006)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6957;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fj1k1JhrJczrlBVRJJ8adLspbi4kOVhy7VvCFXi4DtwI3Oe/cEpjHgXcK8G9uPRSabhg1RVPVK6/MXMAGSqsq4qLcsNFYhRA3WsjWwr3p6C9nu42fddMaO0eKA/GpmyfbdBHPEdmzXaWs7eK5ZAIkOzUcpYVtKHI0s4VeTkUHr/j2ZS7iFBElW0Rp7Nqtq/gh2lihj9xPn4C8upXKYV+LVk/yLHhveCdqdXbBNzoILjV31hfRf+68vEtTe6j5ore/6ln/T1OPBvheRfJt4PKIGnhIroLdFAo1SsFElJtzZOWNcFawKAJIcgprXK4vKC+Vj0r/wTchxeqIes+fsuocxWkWF/z2cpOVvyP25NoUW1vlw9Xm6VmteLiOG2vCRNrIF/3SP5kk7pRtYV1s0To7HJjlel5ue2x/9Ek0i4lZX8QXMWbGnTimkL9XCarlKJMAQgkXPIpmeL8ic1l70pulQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef5224f-ba79-483f-8d49-08d740cb2f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:42:51.8715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SePqHBWva/eW/O0oQsy3cuU0RePsj7Dd12pO8JJV3MIwgSkiCPf0NEmInggwraF8BKNiweTYI4PQmIa0o3VVlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6957
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
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

For now, VM migration support is not available for Goldfish RTC device
but it will be added later when we implement VM migration for KVM RISC-V.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/timer/Kconfig                |   3 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/goldfish_rtc.c         | 221 ++++++++++++++++++++++++++++++++
 include/hw/timer/goldfish_rtc.h |  45 +++++++
 4 files changed, 270 insertions(+)
 create mode 100644 hw/timer/goldfish_rtc.c
 create mode 100644 include/hw/timer/goldfish_rtc.h

diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index eefc95f35e..bd1831fbe8 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -58,3 +58,6 @@ config CMSDK_APB_TIMER
 config CMSDK_APB_DUALTIMER
     bool
     select PTIMER
+
+config GOLDFISH_RTC
+    bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 123d92c969..5dc6f880af 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -47,3 +47,4 @@ common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
 common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
 common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
 common-obj-$(CONFIG_MSF2) +=3D mss-timer.o
+common-obj-$(CONFIG_GOLDFISH_RTC) +=3D goldfish_rtc.o
diff --git a/hw/timer/goldfish_rtc.c b/hw/timer/goldfish_rtc.c
new file mode 100644
index 0000000000..a3349d7cb4
--- /dev/null
+++ b/hw/timer/goldfish_rtc.c
@@ -0,0 +1,221 @@
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
+        timer_del(s->timer);
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
+static void goldfish_rtc_init(Object *obj)
+{
+    GoldfishRTCState *s =3D GOLDFISH_RTC(obj);
+    SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
+    struct tm tm;
+
+    memory_region_init_io(&s->iomem, obj, &goldfish_rtc_ops, s,
+                          "goldfish_rtc", 0x1000);
+    sysbus_init_mmio(dev, &s->iomem);
+
+    sysbus_init_irq(dev, &s->irq);
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset =3D mktimegm(&tm);
+    s->tick_offset *=3D NANOSECONDS_PER_SECOND;
+    s->tick_offset -=3D qemu_clock_get_ns(rtc_clock);
+
+    s->timer =3D timer_new_ns(rtc_clock, goldfish_rtc_interrupt, s);
+}
+
+static Property goldfish_rtc_properties[] =3D {
+    DEFINE_PROP_UINT64("tick-offset", GoldfishRTCState, tick_offset, 0),
+    DEFINE_PROP_UINT64("alarm-next", GoldfishRTCState, alarm_next, 0),
+    DEFINE_PROP_UINT32("alarm-running", GoldfishRTCState, alarm_running, 0=
),
+    DEFINE_PROP_UINT32("irq-pending", GoldfishRTCState, irq_pending, 0),
+    DEFINE_PROP_UINT32("irq-enabled", GoldfishRTCState, irq_enabled, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void goldfish_rtc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    dc->props =3D goldfish_rtc_properties;
+}
+
+static const TypeInfo goldfish_rtc_info =3D {
+    .name          =3D TYPE_GOLDFISH_RTC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(GoldfishRTCState),
+    .instance_init =3D goldfish_rtc_init,
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
index 0000000000..f96a5f5158
--- /dev/null
+++ b/include/hw/timer/goldfish_rtc.h
@@ -0,0 +1,45 @@
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
+    uint64_t alarm_next;
+    uint32_t alarm_running;
+    uint32_t irq_pending;
+    uint32_t irq_enabled;
+} GoldfishRTCState;
+
+#endif
--=20
2.17.1


