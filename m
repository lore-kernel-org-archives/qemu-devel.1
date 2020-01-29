Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0526C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BECC207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="TLlgMj62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BECC207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg7c-0006PL-Ig
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfzi-0008C4-LB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzg-00028i-Iw
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:30 -0500
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com
 ([40.107.94.98]:3168 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzg-0001yv-99
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCwrwsOAoUlInG6LsIvAQ5da9d0qMfI/cIroK8eOz5n9X5cwCpLY0WmT5XI9hBQU6Mgxqg3OTCV3GxVwZYI/QLxThSWyo6It/EzOAQ+mdrzMEMR28t2A7yxeGWEawHG70LZQoxZKfP6umQZXo5MgyNg/Msn9u6aAs6Ada8ApEdzuMllcORSQzHpp7/4ueTB6AYrbBsU5NN+V4VfUUklpe8IkTOd7ELDIVJcaaux8158uT9Bc2bCrsrpZCgzyDh9IHixGlqUFPr8Mw4+p2xLvZ23oZVQVFQYRvBlp3vG+MEHhVhyss+eMJycKMHmoQvyIcSElonooSqbIR++C/CXgmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jacTnSYQO9B6P4X+uTDjis9yDkqwXHMLQYl0ahzxws=;
 b=WGkjxyNVBK30upJk+DMBQ6/woC8BIzF7ux9yI4gf8x93+hzH3nid52fcQn+9VKRUAYwZk4eSgYDS6ry4/zV2hxwFrlCg/P59daxqD6Jb55wMPRl13s9EEEhmcjGBaldWs0wxA31Cgig/d0Ku4UFvms8SdJvu4Bc+S6fkY9kMv2u+VBdQvU1jZHvHsiDl35J3yQ6vR/2CXcP7BtYX6ybY9jNhRE9nYIno5jwyP8rpJ2t6GpjNG0FGzYzbsRZk926ooLdIWoyFcQGbe7jBOM8rTFSx2MgvfM3Dv146wlJUTfQhlKlNYVlgY0ULf7PzKePthihB6uxgbmj0seT5sXr65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jacTnSYQO9B6P4X+uTDjis9yDkqwXHMLQYl0ahzxws=;
 b=TLlgMj62MIPParUpHJ3HUXWvL4Li33hy8seQtYq+3PXH63YSt6XOnpi8XCwQoIX+7IoeXYABvrITuvZd8nAfqHScCiV+INpwxQMg6u8ZT9L4VfBhgyHkWIO+gHSP3u/qqz8sC8u45XUeUsyZY4xL5YL741WXQCG0W3dMTEgoz5M=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:26 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:26 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:25 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 18/21] fuzz: add i440fx fuzz targets
Thread-Topic: [PATCH v8 18/21] fuzz: add i440fx fuzz targets
Thread-Index: AQHV1mXFovhkozf61EevymsGtmbDUw==
Date: Wed, 29 Jan 2020 05:34:26 +0000
Message-ID: <20200129053357.27454-19-alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:c0::42) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba9afd5-16b3-4d83-22a5-08d7a47ce78e
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB420609472F40BCA9A98ED063BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(478600001)(75432002)(36756003)(316002)(6916009)(2906002)(786003)(4326008)(54906003)(26005)(186003)(956004)(2616005)(6486002)(7696005)(52116002)(16526019)(1076003)(5660300002)(71200400001)(86362001)(66446008)(66556008)(66946007)(66476007)(8936002)(81156014)(81166006)(64756008)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4206;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iuuk+jHU6otu9UBW0URlCsbvk26P/VJ6MlFrivXzVXFc6RQX+tbxegMvDv9peeOxesKqn9O3iE0CkMqZJceCVQmyIoUJswvDeLR+yIztbFeOOvisFqbXmXkvqrHGUfkmEXTx/gINXY8YsJXMVlWv0AdUacrWhWEVmnGcoJc6NiyO33tU7TbPErUdNbPWGDI+0KJ8JWRT5aSSlWhTEl0UszTfcIKme/UqeH1AKVehrnzoE8v70wE3kY2QqQlA/pA8S3zUd+1XdC4CSOHrIfSZ+Kpc2l71Q3617HvJQxr4EEZQZAuS7bLzoxf/ZRSUnINS3sXePZObUMvF0U5+3eeVHBY+XKObO5tj7RkyerWH24aUb3AIFtEvD5cq6vjElg1smesgg5V5RVDu7mrT6Tcx4xQhmDNcN0yNfGEdIPl9yZupHnWIE5Ovz/vkkO0Cps2
x-ms-exchange-antispam-messagedata: RqeB4fqK5SCNIewwrEBHcVY3fhmesahK3uLqWP3Vr1ofRpGU09OGSyhu3XJauj0k9CHo5Pjs0x9EFpl316oZGoTxtaqeHnYrqqqClxdicDhPbUHtYhK2mPp5+tU1lyvT1M80zhMnDtZhY3VxplSUNw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: bba9afd5-16b3-4d83-22a5-08d7a47ce78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:26.6005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cW84iFXEtZciAw3wZTYcjnPImp2tQotIQZdRv/t0oPgqwAqJrV/kBPPPxY3LX+Uy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.98
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Bulekov, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
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
 tests/qtest/fuzz/Makefile.include |   3 +
 tests/qtest/fuzz/i440fx_fuzz.c    | 178 ++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 tests/qtest/fuzz/i440fx_fuzz.c

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.=
include
index e3bdd33ff4..38b8cdd9f1 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -6,6 +6,9 @@ fuzz-obj-y +=3D tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
 fuzz-obj-y +=3D tests/qtest/fuzz/fork_fuzz.o
 fuzz-obj-y +=3D tests/qtest/fuzz/qos_fuzz.o
=20
+# Targets
+fuzz-obj-y +=3D tests/qtest/fuzz/i440fx_fuzz.o
+
 FUZZ_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
=20
 # Linker Script to force coverage-counters into known regions which we can=
 mark
diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.=
c
new file mode 100644
index 0000000000..c7791182b8
--- /dev/null
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -0,0 +1,178 @@
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
+#include "qemu/main-loop.h"
+#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/pci.h"
+#include "tests/qtest/libqos/pci-pc.h"
+#include "fuzz.h"
+#include "fuzz/qos_fuzz.h"
+#include "fuzz/fork_fuzz.h"
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
+    /*
+     * Uses libqos. Doesn't do anything to reset state. Note that if we we=
re to
+     * reboot after each run, we would also have to redo the qos-related
+     * initialization (qos_init_path)
+     */
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


