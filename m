Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125AECA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA1920856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="pxvAqlJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA1920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpOd-0005ny-HE
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIa-0005DW-Ah
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIY-0007Yx-OH
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:12 -0400
Received: from mail-eopbgr690101.outbound.protection.outlook.com
 ([40.107.69.101]:31361 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIY-0007LI-FX
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P44/py842djBbbLPuJiwNxVkIfN+EarDn9Mm0gtAk4Cw6G68kdh9IepAtnGO+5PveDK6oUnFhcb2IBl4pxW9h+Kptn1UWbtwk0r78Vfj7xukQEr7cpgMyN+2VkAIBUxKbtE6ehXY9H7hVjllX1UFuekmiF/ZCphxl3L0Pph+uVzrvUOWgGLicI922pneBOp4S1gcjrLmJBUcWkCR5RhNA6R/xDOmawJgE3YCN2I7Ci1LY6IXSS3cSra2l/fU5bpQ6JrepzdJLgAYDy7p9LSNSDDz/JZE2zXVVnyEbiYgXM95/JNeZcNQUfMJEGgymNLeMVqi2GEjUsSlGP5Kej+cPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yd4RODbJ1CStSUav0f9/4+GsLSsR7kjibJSDJuOuW4=;
 b=BXwIFnZrX5T8A775Xa+PFJu48+GS460EDAtEbe+lSgngu2zWHaLfUTyw210jAUFUzj2AFD9g/rx7eN1F6A5diQxjencVCQj9lY9n5148iVb+r3zKkVkjD4AklD91IHOnYM1qbq3q5JzuxHh6LZMas8V+VBAzCfqzjhbM8CGf/+4SIlF6OBfIrB3z/t3wDRU14bqewoHe14pI4imVEXuE/HxeF3lJq6MK8Z1HUNwznZ1knZJQb5L+CeAI9ptsUeB9DK4rE4ZZwx3sN/yuJFfBbNVKXDJWIJJUiOhnMHUiu7ygmaSkQkSI0ejavOBpbNvqGhorA/8GSjqEpGvmOsYm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yd4RODbJ1CStSUav0f9/4+GsLSsR7kjibJSDJuOuW4=;
 b=pxvAqlJyIoDxUCFh34yxWW64S82+8101xpf8OzmodOAP/GBlel4jw9r0UT7+BvA4ZGvtKNDYjLuifo8gScG4jIRhzh3FVrnYAnI2x27mASq+Es6P+dgRtA3DQRUtsuKVJhtc3xxUr+vmjnsCBH070s/p8Q4lbFPj90JJq2jt8yY=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:50:03 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:50:03 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 18/20] fuzz: add i440fx fuzz targets
Thread-Topic: [PATCH v4 18/20] fuzz: add i440fx fuzz targets
Thread-Index: AQHVjzFPTzlG7xKuq0qOEmhu25uEHg==
Date: Wed, 30 Oct 2019 14:50:03 +0000
Message-ID: <20191030144926.11873-19-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3380d3c1-8017-49c3-9954-08d75d487219
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB4959EF88534E6286E40ED533BA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(25786009)(6436002)(75432002)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b0WuG9XZ7jUQjXixmsuNUD8Z0UQ20ivpQGSoA9/a3jLYUXPZKit751OefouUaI8NNTfxqnocJBwfSO2Jk4eT1hEvvQcapoPRggduDjt+UVCmKnvMzVQ2+Nh9UAX7hk3aNvHdzjmAlS5S4njQOjuLvwbM/72WUklDCGGhucmn3pbhfA8O9rE3TfVEmQyuB+OOFjfQ0UFh0fv9HWk/AA4sr2/5yrWh9Jz3uNHwCchcf7/5Z1z8gShZhsPzEJT6FzhMSCIQEusBQ6kToQechCkGmwleh7BTuZeVcs47GVt+ABSD7UYevjx86DTYDFgPM8APqGr5IG4g46Fkn/LIbjPE3Hdnq3EkJzP5qZ8Mym2TxSwSfbjMcDDB49eEVAWnNLvme7mVs0LNOyGcV6BFGF2+mVPq8RyiFCYbe0FiAoA800d5nz9wpGcKb9oT/r/MfTYL
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3380d3c1-8017-49c3-9954-08d75d487219
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:50:03.1622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJrBrBmfGnsfvDTiyKC7IBC3AhiaxtOMovXHqmVC0NXPgZxgi60eSeOIcgQhr4J9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.101
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

These three targets should simply fuzz reads/writes to a couple ioports,
but they mostly serve as examples of different ways to write targets.
They demonstrate using qtest and qos for fuzzing, as well as using
rebooting and forking to reset state, or not resetting it at all.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
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
index 0000000000..7304465b42
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
+static const char *i440fx_qtest_argv =3D "qemu_system_i386 -machine accel=
=3Dqtest"
+                                       "-m 0 -display none";
+static char *i440fx_argv(FuzzTarget *t)
+{
+    return (char *)i440fx_qtest_argv;
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


