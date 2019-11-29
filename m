Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1911C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144AE24649
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="PqxXepP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144AE24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iao1E-0007bu-J4
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianul-0000Ba-Jc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianuk-0002we-3S
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:59 -0500
Received: from mail-eopbgr790122.outbound.protection.outlook.com
 ([40.107.79.122]:35989 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianuj-0002ny-R1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYAWinlpL6GXyKWytPh33jXkUS5yw9ehQEEAa1Yv3I6gWaCqprgesTctuI/iI/FSWRumUVQ5BezSCj/5n+i0n+bbQYuxrSZX0ls6eNplyBq16Ybens/3erKsHz9dY074l31NidVZSHPMtaUNpXEbxyp00l+QThmimsFoJmFm49xFnISNoEa3SScI0MGSwnGtCZlzeLzhT51CFC0H0/QeF1FaclYhkZ74sGWEgam5+5BHpBBoN26gpkfP1uIyS0QN5Dzuz9B1bgIV3lXc9Dt5PlKniCwy/UlVqbslR/qkLK12mv9iCptQEWTF1Z6WaH+oh6iyLV3m2uZwMcXPcwp9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GnWoepaykdKFds1p6UTHY7cr1VJ/cGlja/4gOdEhos=;
 b=Y0PhjhKMThk/6A5N2lUxn7gtEB4MY9V3nugpfBf/CqsQe4hhTPaplhKi0TwFxUWKulnZJspU4GjZAcyS8+MJ4Bkmjb5Lc67o/1tSAIWHDwVfOisGF03ZF8ra9iUDauixHqBJhynDlfvBAcItOmvHkUPt41pxoUC1vzXULdqrrwda8wlQsWFTvi6oi6/5XHAmYlLd/P9jBmezUNN3VbO4eTUayefv+yrsW69DhVrvFYsIBBiQG3fFgRGEGLk0FrIKAf5I+iKLfojFX8gcHNCM8YVhsffDXYWQQAUqEBQy/06wJbFsv3KXHo946B+k73nHZFcL/0Xvo8AE8tr7V2C5Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GnWoepaykdKFds1p6UTHY7cr1VJ/cGlja/4gOdEhos=;
 b=PqxXepP9tyFIiUmpltV6qQvAuD0jlGD6JlGYF0awpxbLJn4yR+KENR6Xiu3ELq7T558fWcNpGct7mmuz/Ij09yf1Kwxk75WwVQAQ3SFKDnJi+Q0rNy7WQhLbQMXtXFGQwTds3u9FbM3ccVLQS6vGL9xxYwbaKk1zMfVkko4PUCY=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:52 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:52 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 18/21] fuzz: add i440fx fuzz targets
Thread-Topic: [PATCH v6 18/21] fuzz: add i440fx fuzz targets
Thread-Index: AQHVpvzVq/zDopVBXkWvtIh4i5XFag==
Date: Fri, 29 Nov 2019 21:34:52 +0000
Message-ID: <20191129213424.6290-19-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4512fd53-f1c5-4a74-276d-08d77513f7f1
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050BB6BB7354E5A35457AEDBA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6JMtIp9sUBKiVudY5DxgQRL2+VIQBnbvX/OG6Ln57VT6EdO9GBpa2ktyGPjL1PjPOb9VZ0G9nKswAlznN6IHpp79n8NFf55WbNEU02pPHwKiiS5MSdPmXdSNV7olrtuTDiQWYeelX/4zzR4UhKrkLuyRM3kiiAp9YSBh5LlQmzfbxi/4bIiveBrrpHUj1qNVetLJQzLqQ+f9VmusCjzf7//mwj8mtvGiLmUDchP+SNW9jUHgGHP2qbF24av6BqpH/2FwOHxyYBXtkIUgcSLMuQw10Z07WP+EMfsfak5/RK/Al7fjTBA0IC+k5oqOlqRdS4LKYfPuRwAw3gUpjA0E4v2pCh3Ep2BobO1Jbj6nHIQ+4TapM7pxK7vsxPhW8z/l2CX1zkuHU2keTUUKozdJcneADRT/LNVk+vcOu1a8tPKDkaELMQlGLmRKEh/USHM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4512fd53-f1c5-4a74-276d-08d77513f7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:52.2458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUqE3NAUYFXgJieYwO09cYpwrE6gm9vOb7ID8eZn+usK6q2FKJUPJxPQCM8jFmVX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.122
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These three targets should simply fuzz reads/writes to a couple ioports,
but they mostly serve as examples of different ways to write targets.
They demonstrate using qtest and qos for fuzzing, as well as using
rebooting and forking to reset state, or not resetting it at all.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/fuzz/Makefile.include |   3 +
 tests/fuzz/i440fx_fuzz.c    | 176 ++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 tests/fuzz/i440fx_fuzz.c

diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
index 687dacce04..37d6821bee 100644
--- a/tests/fuzz/Makefile.include
+++ b/tests/fuzz/Makefile.include
@@ -3,5 +3,8 @@ fuzz-obj-y =3D $(libqos-obj-y)
 fuzz-obj-y +=3D tests/libqtest.o
 fuzz-obj-y +=3D tests/fuzz/fuzz.o
 fuzz-obj-y +=3D tests/fuzz/fork_fuzz.o
+fuzz-obj-y +=3D tests/fuzz/qos_fuzz.o
+
+fuzz-obj-y +=3D tests/fuzz/i440fx_fuzz.o
=20
 FUZZ_LDFLAGS +=3D -Xlinker -T$(SRC_PATH)/tests/fuzz/fork_fuzz.ld
diff --git a/tests/fuzz/i440fx_fuzz.c b/tests/fuzz/i440fx_fuzz.c
new file mode 100644
index 0000000000..56e3315a88
--- /dev/null
+++ b/tests/fuzz/i440fx_fuzz.c
@@ -0,0 +1,176 @@
+/*
+ * I440FX Fuzzing Target
+ *
+ * Copyright Red Hat Inc., 2019
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "fuzz.h"
+#include "tests/libqtest.h"
+#include "fuzz/qos_fuzz.h"
+#include "fuzz/fork_fuzz.h"
+#include "qemu/main-loop.h"
+#include "tests/libqos/pci.h"
+#include "tests/libqos/pci-pc.h"
+
+
+#define I440FX_PCI_HOST_BRIDGE_CFG 0xcf8
+#define I440FX_PCI_HOST_BRIDGE_DATA 0xcfc
+
+enum action_id {
+    WRITEB,
+    WRITEW,
+    WRITEL,
+    READB,
+    READW,
+    READL,
+    ACTION_MAX
+};
+
+static void i440fx_fuzz_qtest(QTestState *s,
+        const unsigned char *Data, size_t Size) {
+    typedef struct QTestFuzzAction {
+        uint32_t value;
+        uint8_t id;
+        uint8_t addr;
+    } QTestFuzzAction;
+    QTestFuzzAction a;
+
+    while (Size >=3D sizeof(a)) {
+        memcpy(&a, Data, sizeof(a));
+        uint16_t addr =3D a.addr % 2 ? I440FX_PCI_HOST_BRIDGE_CFG :
+                                      I440FX_PCI_HOST_BRIDGE_DATA;
+        switch (a.id % ACTION_MAX) {
+        case WRITEB:
+            qtest_outb(s, addr, (uint8_t)a.value);
+            break;
+        case WRITEW:
+            qtest_outw(s, addr, (uint16_t)a.value);
+            break;
+        case WRITEL:
+            qtest_outl(s, addr, (uint32_t)a.value);
+            break;
+        case READB:
+            qtest_inb(s, addr);
+            break;
+        case READW:
+            qtest_inw(s, addr);
+            break;
+        case READL:
+            qtest_inl(s, addr);
+            break;
+        }
+        Size -=3D sizeof(a);
+        Data +=3D sizeof(a);
+    }
+    flush_events(s);
+}
+
+static void i440fx_fuzz_qos(QTestState *s,
+        const unsigned char *Data, size_t Size) {
+
+    typedef struct QOSFuzzAction {
+        uint32_t value;
+        int devfn;
+        uint8_t offset;
+        uint8_t id;
+    } QOSFuzzAction;
+
+    static QPCIBus *bus;
+    if (!bus) {
+        bus =3D qpci_new_pc(s, fuzz_qos_alloc);
+    }
+
+    QOSFuzzAction a;
+    while (Size >=3D sizeof(a)) {
+        memcpy(&a, Data, sizeof(a));
+        switch (a.id % ACTION_MAX) {
+        case WRITEB:
+            bus->config_writeb(bus, a.devfn, a.offset, (uint8_t)a.value);
+            break;
+        case WRITEW:
+            bus->config_writew(bus, a.devfn, a.offset, (uint16_t)a.value);
+            break;
+        case WRITEL:
+            bus->config_writel(bus, a.devfn, a.offset, (uint32_t)a.value);
+            break;
+        case READB:
+            bus->config_readb(bus, a.devfn, a.offset);
+            break;
+        case READW:
+            bus->config_readw(bus, a.devfn, a.offset);
+            break;
+        case READL:
+            bus->config_readl(bus, a.devfn, a.offset);
+            break;
+        }
+        Size -=3D sizeof(a);
+        Data +=3D sizeof(a);
+    }
+    flush_events(s);
+}
+
+static void i440fx_fuzz_qos_fork(QTestState *s,
+        const unsigned char *Data, size_t Size) {
+    if (fork() =3D=3D 0) {
+        i440fx_fuzz_qos(s, Data, Size);
+        _Exit(0);
+    } else {
+        wait(NULL);
+    }
+}
+
+static const char *i440fx_qtest_argv =3D TARGET_NAME " -machine accel=3Dqt=
est"
+                                       "-m 0 -display none";
+static const char *i440fx_argv(FuzzTarget *t)
+{
+    return i440fx_qtest_argv;
+}
+
+static void fork_init(void)
+{
+    counter_shm_init();
+}
+
+static void register_pci_fuzz_targets(void)
+{
+    /* Uses simple qtest commands and reboots to reset state */
+    fuzz_add_target(&(FuzzTarget){
+                .name =3D "i440fx-qtest-reboot-fuzz",
+                .description =3D "Fuzz the i440fx using raw qtest commands=
 and"
+                               "rebooting after each run",
+                .get_init_cmdline =3D i440fx_argv,
+                .fuzz =3D i440fx_fuzz_qtest});
+
+    /* Uses libqos and forks to prevent state leakage */
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name =3D "i440fx-qos-fork-fuzz",
+                .description =3D "Fuzz the i440fx using raw qtest commands=
 and"
+                               "rebooting after each run",
+                .pre_vm_init =3D &fork_init,
+                .fuzz =3D i440fx_fuzz_qos_fork,},
+                "i440FX-pcihost",
+                &(QOSGraphTestOptions){}
+                );
+
+    /* Uses libqos. Doesn't do anything to reset state. Note that if we we=
re to
+     reboot after each run, we would also have to redo the qos-related
+     initialization (qos_init_path) */
+    fuzz_add_qos_target(&(FuzzTarget){
+                .name =3D "i440fx-qos-noreset-fuzz",
+                .description =3D "Fuzz the i440fx using raw qtest commands=
 and"
+                               "rebooting after each run",
+                .fuzz =3D i440fx_fuzz_qos,},
+                "i440FX-pcihost",
+                &(QOSGraphTestOptions){}
+                );
+}
+
+fuzz_target_init(register_pci_fuzz_targets);
--=20
2.23.0


