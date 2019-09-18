Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947F5C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A930218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fShz5ApA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A930218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjQ4-0004n7-6m
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEj-0000bI-Vv
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEi-0002ir-Ch
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:49 -0400
Received: from mail-eopbgr700099.outbound.protection.outlook.com
 ([40.107.70.99]:57953 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEi-0002fm-5T
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/aq8fHSkG8u+nu8+bdM3QUgzQc76XyZF8/cVZBFh/91xXzJHFaEABTPA/Txn54/aWVdGLUBN4H/O9864QK9hW0hbjXd6QimrNhBz82tESyeDRPRr+h5uRfU1RjojhQuuSw2ZK6ttKOjAsZEVt23c8aIpDlk/4KXNXO64zS9wQIM6yFu08yCW8YRJcUXk0DIe/4DTNerEHtw2LamV7fi4BATryYjwVIkKyPGKzAAAxwavl9ZfoVSBzUm9RV3rOPwpzfyJ36K/xQSrSWMVcamORTdt2rXvEIB8iAAKLgwDNcHsIjtW02vrF7fBUxolRmRxiTSDJ8LL1LZyl+Rox5f3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6ZesvWEygiaQIocLMsVJpfvQ9+yaIZ4TexpfQD12OI=;
 b=WolBjTo0C5bh+h1/HjgwPEFrdCplkwC5VguGcRwmpu2B2vN2zmtvBw1FluxMJs2r2XJvfbQH66Zf5u3QWBqRBUjgeujzmsx75jhsWXnqsvXfmbg6Xatcn7KtFJZnAEHHaSSNDLOgzRqPpJAEU6eu5WzdJaf44kEXbtVC1r4A+fPu32ticaGM8wtyHehEu00ezROs4NSjNIqPRkSH3Zcq8tUvTTydAUq9FmSaYCmCchU8n6GUbMztxBWdDLD+HH2ab4Xcha01xvh3SLn/ShutaxwMrGHB3GxzmJaQqxuz9H+0npM5HeEIvkqoLWhKFMUhcc9k7rgA2x8r4pZoMJbRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6ZesvWEygiaQIocLMsVJpfvQ9+yaIZ4TexpfQD12OI=;
 b=fShz5ApATosY+uUjvJw4uZJ7zVBOuorq+26GoUoBEXpfJ0JvmYd9Q3Hgh8O8sxXQpzANLIMdO7FwZHe/94wNC3X5wyO+ZJi26VZwDKKDXUtKAsoKeySJ0Lj0C4McsSo3V1qEf6or311dVAPqpnqIMtk49yv5D5EnbDFc74+c/zQ=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:47 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:47 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 20/22] fuzz: add i440fx fuzz targets
Thread-Index: AQHVbnePWtatfk9UsEqKSplQiZtFcw==
Date: Wed, 18 Sep 2019 23:19:47 +0000
Message-ID: <20190918231846.22538-21-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba506178-4ec1-4e02-6e0c-08d73c8eb243
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016C2833E329A02D156F762BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(1496009)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V+yBaU5eyWnotseTuIW/FRSDZ76FoB7Has6Apy5khnCHWZ1FfhUwKwBqiNH0Bc90iGPPIegW1tNpQCw0Nr5gtuAmf8mNVv5CE7Md/lwDnUBKFhyfd1X34pCBuPg6amgvnIQYUeLcTgjWdqa0yfu01CX89sLwU5pysxjTI8lcy9fFGyXwxStAha7HHJMLMr+JPMAxeLJruV8POv/u6lL7xQgJlL7Hobb0/t+HPqHCXuyeC7cwyXBFEdu48XOmcVPpKtBRlOz+kugyAILFiY/rNh/B2SuKXEmywbFJSOIPZTz9SeO9fH4LbR9ocQBcXy3/e+Lgvd2NQKq3HsNDP7vnaRPd/mSRXjRHN9AZvnoqa/T9eBr/qe70uXjQFH2tkPIBJK3eeNautQMsKxXdr6ytCHpdqWpa/ml6cS/hdq5c2hk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ba506178-4ec1-4e02-6e0c-08d73c8eb243
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:47.1180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8zsjnjqtm0bN0QrBGZWIG32eELOWF6AQ68zdq+uefpvvuuoO3Y9gBIRWb7x7Qr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.99
Subject: [Qemu-devel] [PATCH v3 20/22] fuzz: add i440fx fuzz targets
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include |   3 +
 tests/fuzz/i440fx_fuzz.c    | 158 ++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
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
index 0000000000..9079c40f55
--- /dev/null
+++ b/tests/fuzz/i440fx_fuzz.c
@@ -0,0 +1,158 @@
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
+enum action_id {
+    WRITEB,
+    WRITEW,
+    WRITEL,
+    READB,
+    READW,
+    READL,
+};
+
+static void i440fx_fuzz_qtest(QTestState *s,
+        const unsigned char *Data, size_t Size) {
+
+    typedef struct QTestFuzzAction {
+        uint8_t id;
+        uint8_t addr;
+        uint32_t value;
+    } QTestFuzzAction;
+    QTestFuzzAction *a =3D (QTestFuzzAction *)Data;
+    while (Size >=3D sizeof(QTestFuzzAction)) {
+        uint16_t addr =3D a->addr % 2 ? 0xcf8 : 0xcfc;
+        switch (a->id) {
+        case WRITEB:
+            qtest_outb(s, addr, (uint8_t)a->value);
+            break;
+        case WRITEW:
+            qtest_outw(s, addr, (uint16_t)a->value);
+            break;
+        case WRITEL:
+            qtest_outl(s, addr, (uint32_t)a->value);
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
+        a++;
+        Size -=3D sizeof(QTestFuzzAction);
+    }
+    qtest_clock_step_next(s);
+    main_loop_wait(true);
+    reboot(s);
+}
+
+static void i440fx_fuzz_qos(QTestState *s,
+        const unsigned char *Data, size_t Size) {
+
+    typedef struct QOSFuzzAction {
+        uint8_t id;
+        int devfn;
+        uint8_t offset;
+        uint32_t value;
+    } QOSFuzzAction;
+
+    QOSFuzzAction *a =3D (QOSFuzzAction *)Data;
+    static QPCIBus *bus;
+    if (!bus) {
+        bus =3D qpci_new_pc(s, fuzz_qos_alloc);
+    }
+
+    while (Size >=3D sizeof(QOSFuzzAction)) {
+        switch (a->id) {
+        case WRITEB:
+            bus->config_writeb(bus, a->devfn, a->offset, (uint8_t)a->value=
);
+            break;
+        case WRITEW:
+            bus->config_writew(bus, a->devfn, a->offset, (uint16_t)a->valu=
e);
+            break;
+        case WRITEL:
+            bus->config_writel(bus, a->devfn, a->offset, (uint32_t)a->valu=
e);
+            break;
+        case READB:
+            bus->config_readb(bus, a->devfn, a->offset);
+            break;
+        case READW:
+            bus->config_readw(bus, a->devfn, a->offset);
+            break;
+        case READL:
+            bus->config_readl(bus, a->devfn, a->offset);
+            break;
+        }
+        a++;
+        Size -=3D sizeof(QOSFuzzAction);
+    }
+    qtest_clock_step_next(s);
+    main_loop_wait(true);
+}
+
+static void i440fx_fuzz_qos_fork(QTestState *s,
+        const unsigned char *Data, size_t Size) {
+    if (fork() =3D=3D 0) {
+        i440fx_fuzz_qos(s, Data, Size);
+        counter_shm_store();
+        _Exit(0);
+    } else {
+        wait(NULL);
+        counter_shm_load();
+    }
+}
+
+static void fork_init(QTestState *s)
+{
+    counter_shm_init();
+}
+static const char *i440fx_qtest_argv[] =3D {"qemu_system_i386", "-machine"=
, "accel=3Dqtest"};
+
+static void register_pci_fuzz_targets(void)
+{
+    /* Uses simple qtest commands and reboots to reset state */
+    fuzz_add_target("i440fx-qtest-reboot-fuzz",
+            "Fuzz the i440fx using raw qtest commands and rebooting"
+            "after each run",
+            &(FuzzTarget){
+                .fuzz =3D i440fx_fuzz_qtest,
+                .main_argc =3D 3,
+                .main_argv =3D (char **)i440fx_qtest_argv,
+                });
+
+    /* Uses libqos and forks to prevent state leakage */
+    fuzz_add_qos_target("i440fx-qos-fork-fuzz",
+            "Fuzz the i440fx using qos helpers and forking"
+            "for each run",
+            "i440FX-pcihost",
+            &(QOSGraphTestOptions){},
+            &(FuzzTarget){
+            .pre_main =3D &qos_setup,
+            .pre_fuzz =3D &fork_init,
+            .fuzz =3D &i440fx_fuzz_qos_fork
+            });
+
+    /* Uses libqos. Doesn't do anything to reset state. Note that if we we=
re to
+     reboot after each run, we would also have to redo the qos-related
+     initialization (qos_init_path) */
+    fuzz_add_qos_target("i440fx-qos-nocleanup-fuzz",
+            "Fuzz the i440fx using qos helpers. No cleanup done after each=
 run",
+            "i440FX-pcihost",
+            &(QOSGraphTestOptions){},
+            &(FuzzTarget){
+            .pre_main =3D &qos_setup,
+            .fuzz =3D &i440fx_fuzz_qos
+            });
+}
+
+fuzz_target_init(register_pci_fuzz_targets);
--=20
2.23.0


