Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5AC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095A7206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="wp2JNHEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095A7206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1ln-0000yz-6N
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TW-00088a-E1
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TU-0007oi-Ur
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:58 -0500
Received: from mail-dm3nam03on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::714]:27886
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TU-0007jr-GI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0VlmkOYhOSSSN/Wc807mcaq9fyGd5Kgr7qZ+OYh9qMos4aWqmpx6yZa2D1GedwMldWLxrUlAmbC4gEwH8RaGHxf+OWAtN18lOFwxbhhr1/cuHGdD7BZVlzf1C5zIRWVnS+UgbxTcfDBIggKoBCV/S4KfzkgByQN4tm4javobAO5zRjk0IRi3GToPnSJgcahzbjiWVOPi2WP2pH9n+hIgZJuWu9nYwSP0GZeLFU5a8/E9YYoGuQJEBBLKQf+i9gDAXF2n6zzE6Kka4ZMFbKrt2RtYYSFlwTQG0bG6rU0m9h171N7FlfVkdHpXASy+yrEH+zPH0vy7GGjNpNDZt/V/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su4aN+WRz8v6isuZqAViEfkAg8a6OLLJglmV3+pjfbQ=;
 b=LiKKlLJRsmx8HSyB7Ib0cHl7AYDZvk48v6AhU6BLH5/mTx9bP1+Y/14RcrMWJb56gJTnge4Qmk2ukAdeefSS/joUTHduq/kJ5OpChvweoktNe8koDUMhDjXKnJ7/V+Nf7VVooBYLYDheelX/VjWnxEJ8a8kId6PiE7cZhN703LpVp/3vYDcShTknTh6hYd6fh8c+9REwEdObPXS57xTC3vObRP3zjZrCVQtHonTQRbLkRjAx/u51LfVpl0J/b0U+qQOAh1N0nbKc4ifBZwes3i/xL+BJ4/I36Aq/qMwbOpaIQJILgIBWP9ntlGP5ejW4ir/T6bNNPgAEXmwWR3OQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su4aN+WRz8v6isuZqAViEfkAg8a6OLLJglmV3+pjfbQ=;
 b=wp2JNHEG53ZeEQObVxoXgjSKsz6QDKPwyX44aZ3zgN98SbiiQVKdjAtKmwB0iKzaaBk+Ee97WqW4JGD8TDOy2YUqc04czduLzko4mFaqaLwASNY4o0y11jBjzjs+YlmK3GH1tMHZdlao/YVa/aTKiUfgnNr3OoOVjQLHW/4jduk=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:53 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:53 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 18/20] fuzz: add i440fx fuzz targets
Thread-Topic: [PATCH v5 18/20] fuzz: add i440fx fuzz targets
Thread-Index: AQHVmnTNMdkDF+Tafk2JmjjFUiddBg==
Date: Wed, 13 Nov 2019 22:50:53 +0000
Message-ID: <20191113225030.17023-19-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c06dc8ba-85c2-471d-138e-08d7688befec
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB50241C00023FA5E55C016B15BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(1496009)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M7iJ1zIH6pUe+IhX+pepj1FWqECpBFggyQaI4AzzaRyiV6MzyOo98LSSN6v0FRbIwNdfgVZcDrUYCmSJfKzUEzudnZXAL3/LnBvoEnb5WT0nK4bdQmsl+qKs1fzC0PUz31NW/2udEVWfBWvlhdbB1pkUaCXphS5XvlvuKQNJto005+0g6VPLkSdYX8P99WxMgDwQ3NYEySzqdnDBGZhJzBtsrc3+8lAzTOGMcfTOKWzkHvn3WzV9jN43gu92kU5a3fJ84TtYao+5wxM5ExSTFxtJHNgJNVPALwpI69IIVZQrFuujCmXd1V/OIZ+eXfD+itpGVJaHtQ6Bl2H+K7wT5a3qGZaH4bhisB6neJAgilSaWScG0X3U4N1PkoEh2FjSisBWajTSA7+zsvyHYC0PpcycjoQnx6daoGoh17ZpWIoKLgmalipF3HmLWWbwtLPm
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c06dc8ba-85c2-471d-138e-08d7688befec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:53.2912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhKuLL2WQTKL1im0BrqjTMadMN4GjIjDHGGIirn8/Ntz6Hyi569hsYE1smWGhRDl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::714
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


