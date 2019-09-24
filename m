Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F73C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CF520872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ua5gTN8Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WEpfAH/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CF520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClEj-0005Z9-AI
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkc5-0000Xx-1s
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkc3-0002v8-1Z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkbv-0002of-Qu; Tue, 24 Sep 2019 09:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569330728; x=1600866728;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GvEpSctGXUnDYvqPL5rNFLzx2V79D/KEfxKLeAg0VqY=;
 b=Ua5gTN8Q0Ffef5DEG0Dkhc8Zn+SWvT2QoIMg+pc8aHRQw3BQ43HCFRSb
 fp4Dijzp2PT5uZSzRM95lc77mkzJEqsmpy7gK9kX2ULDrEuiPi9+Sn3X3
 rtUP2bZ9uwMuaHKCKBovlfiK4BTlnEdGJQofj8e8DOUUnxp5W8I+GFttT
 DPkuLJJ0L0F/bMHNFzEJu2MHwDinGlmKqXciS32pGAYNCiT4afC3iLgwD
 PTLfSY8QqKCo1CznrXp5OIRxs2Y9+gfbU46kBABvbMDNRQQUp1vOkPb0a
 plsp01160wMK0ewq9epdiA/JhQtbefOmxQYIkphGpO89Tr5jwtWggAP/y w==;
IronPort-SDR: VWOYrlBbaJQ3ZWRpjcYHdUc/+J8emK7IoScBesGdmb4xSgoED21JxyeWxcK8PSTUMKqWyDkZ94
 hb0NSqFf29QkOmsQ9zTbuvcY42RAGjN4USd3a0gEoiyQMfHlHjGnoOVi3/JiNCR0v6K71qgx7U
 a/pcw8NaaGNJEU8qS5bXA9WHunVgcFg/u+S/CqLCg9ktQQxurckiCQdVBYaVqq8LUgRtNbxhqO
 iRWFu/N69Zmda0uyc544BUIFgAiAQUXwytSEcPEAajSN85lV66/m9k20hbTsxDroaHOdQGAWGI
 qcg=
X-IronPort-AV: E=Sophos;i="5.64,544,1559491200"; d="scan'208";a="118970951"
Received: from mail-by2nam03lp2050.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.50])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 21:12:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmJvzKEPLPMqzy3J/8Zn6clvnMP7YccDKBEqFmsh3EBw/IsSaRjm19aNueBGzq6ggDctQ5SzFLc3uzWD20Uoi3Lf5w9TVFeF13iGzlC6sMPMOht3XSCSOcQtXzxWKrL2JtvA/tAA5BLqO8RKAsC4BH+/X6qyDFs9UWDTpUbxuPsDuBSylna0Bst9ZI5yCrSZxOX8wl8S6Wfi979eGYvGCtnuAYAR/1qy+539V9ihhcHc1oIfXRffeE1MjjB01KUNlf3OUKFqHQlRrM0SM7WwXR5Laeg9pMDXV/n/5zcSCz3TdteEY9sqPJr8eMriQrGBo8vhT6FUmWx2MGp7umoZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6YtIbj7YgkN+WbX5sNtsPkhG2fEqT7XjGwgC7WQQAw=;
 b=m+4i+txGw1LlJrPnZSwvDrGZSdMZNaOOq8h1Ic9VgzpthS7favclxsCDQROid9XRcCwXRCoc6DFL+Eb8hZDzgq71XtwXQ3dwNGCyB3XUrnvdpbUAgCUeCzABSZ6ls1e6YfNUFHPuE4/fcn55NXdWdIZz2e1Uo56GeZK6C7+x7EFsLXvbYO3wSFgvSyT45aekW28NcpDy/BMfwVTgJDc7LcNoVZVV/NmVZEsRGlSe2zmrvUnLrANSvpgadkayvE3xi/iml9c3v7ve6sHYlSn9YI0x1ldNuJGEm4SmL3pDZIh4fOwaVIKdhnzGmxkVnxCacwUF1foYE0iE7v7OGS6b8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6YtIbj7YgkN+WbX5sNtsPkhG2fEqT7XjGwgC7WQQAw=;
 b=WEpfAH/z6CKze8t2uzQP/xkA/QLegsWWq7U+2JnLoTjjhTV5oQNZl0Un6b7j+N4WTZ+MocIRmR3gRveqXGCI17sBzhQQPcoUJZBEJlYQ0XhcuM+Y4pM1KBLevvyDvqftCm7L8wi/KwGp86T5NGwixhmzZAOu+YoYlHjjiU5hfsE=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6318.namprd04.prod.outlook.com (52.132.168.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 13:12:03 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 13:12:03 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v2 1/2] hw: timer: Add Goldfish RTC device
Thread-Topic: [PATCH v2 1/2] hw: timer: Add Goldfish RTC device
Thread-Index: AQHVctmnZsqCfyFEDEKNZLG9WEX7cA==
Date: Tue, 24 Sep 2019 13:12:02 +0000
Message-ID: <20190924131131.118155-2-anup.patel@wdc.com>
References: <20190924131131.118155-1-anup.patel@wdc.com>
In-Reply-To: <20190924131131.118155-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.51.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbc125b5-437f-402c-84a2-08d740f0ca65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MN2PR04MB6318; 
x-ms-traffictypediagnostic: MN2PR04MB6318:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6318E83B8B7E86288F4775738D840@MN2PR04MB6318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(8676002)(25786009)(476003)(305945005)(8936002)(81156014)(81166006)(6512007)(36756003)(3846002)(6116002)(6306002)(6436002)(5660300002)(110136005)(54906003)(44832011)(71190400001)(71200400001)(2616005)(486006)(316002)(256004)(66066001)(7736002)(14444005)(6486002)(11346002)(50226002)(446003)(6506007)(66946007)(1076003)(30864003)(14454004)(64756008)(2906002)(186003)(99286004)(102836004)(966005)(2171002)(386003)(52116002)(26005)(478600001)(66476007)(76176011)(66556008)(86362001)(55236004)(66446008)(4326008)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6318;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WNQm9UETlJYxzp+ChfAkxhSWF7SSnA3op20BTHP+/ZMXaso4OVPE7RM56YkUXzVfuMFSxBvZ9JcwmyIgfGELcdo2QqU9Dni+Zo3oSVXmTNdS2p1GQgUpy5lMRAlzhbyrox86lZmDaPpUl5/I6FWYhbDgzUim3pa84nrK1XRL00XCPqRpsY06npw+xW/IQs7cvchdAit2aPGwOvFZFTMXL+ZLZmDHDWjdb8Exbgfb7n7OXC2SmYxPd2UImRb2T569CpwdswDj5VD3gjkbleD+vd6qI7DStFZyEL5VxD+QMa48MDk2OscqdYdMrAFpx9SjQQ3h9r/J0jnMlzZ2Rw7Fg/Q1IL2Ah21vEpklYuGDSgIase7ZqUbSbLnWIGXqK0VV+X7DRkmxR0pcgDlxEwkUpAv+LRmKjO9ZiWjZyJEVKIaQYtBFxUktKywIoGCa9TL8cmdgAA5fnO+ZveK3e6rXYw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc125b5-437f-402c-84a2-08d740f0ca65
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 13:12:02.9703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lke/v7EPXbHqas1mbCsWUj2rO5aLevoRT8xQXCyUnZAlbyhVgEvAwIwNBk4TDj9D44IhNPxPVrGxe2xrEa1myw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6318
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
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
 hw/timer/goldfish_rtc.c         | 278 ++++++++++++++++++++++++++++++++
 include/hw/timer/goldfish_rtc.h |  46 ++++++
 4 files changed, 328 insertions(+)
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
index 0000000000..223616ed75
--- /dev/null
+++ b/hw/timer/goldfish_rtc.c
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


