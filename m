Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE38C11D40
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA422465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="VI+MSpak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA422465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dFN-0004X2-Nc
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBt-0004t6-9s
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBr-0005zu-Pw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:57 -0500
Received: from mail-co1nam11on2112.outbound.protection.outlook.com
 ([40.107.220.112]:43264 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBr-0005yw-GJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyIp+Zu3Dtpdepbjjb87Vn4z2G9dP9jrcxSmTbkVUciLiffoTTdMJYrlmGemcRH260V36SuWJlFVtExTmGQfvBQ6IU/DuugA1wQILshppgVWSEDxkm5Uu3PNv028xeK4JJGjAwXthSNSsKaAobusfDv9LskxOM9pV2XGEulkM8/86tiDPEJ6SLy6slXopYA+kZpW28QPUypAM4qjDk13r3aguK6dgtEWBaymaPmFtc1JnZFahlLaCA2ZJ/tKVVLZw+2CcVSaqM4wx0WEzLPyycC5P3JIpWTMJwb5ifDE8Us1zwp1t7QdptEytXyA0H21xvNU2IwoIdGCK4cTtExiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyIAbRvmMQLD2Sd3PBj5IaicBDwUApyRERMIDt1SmF8=;
 b=VPT4MPFeNKXf1FKC6ooaGn0pH0x/XzzKFU3PPSrVGx5RHHnU8dM5FH1Xl3SmJJnI4etG/9G66xsv6/EwNm08ThemIp5nHg5j1dXExwFCk+pa0mW/G9mwXQ9jlzTgfWABkVqLrQQXgmTCprMMaTXABtveRBuk+CpzkWoTc6TvwI+Y+se/NaSkz3i8Gste4SdL0BSGE3F+X8O7CULZzJ+r25ppqZWQv3GI4Z/XgRpAYcEHZlZ3x1wV+Y/Cb+nu0g74Qazw2lj4s+gpWYM87XZPMY9/X1wZ6rgl3MF2VI3CIj2TJMpXdmmDDFCGugicaxSLnnPi+KG0SJOM9XSsfXvpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyIAbRvmMQLD2Sd3PBj5IaicBDwUApyRERMIDt1SmF8=;
 b=VI+MSpak11CesCaKTab+bxBF/Ij9YsmwrMrQ0pdUEQoxsxEYNxFeRg2TvON5QFKPLEdfkY6orF3CA16hNwyWujCyZY1RSrAVMqITfJ+hz/0BkDizSIswcEDc6U04JkOHHbO7fPvDVL3ky+YsbhgcntHoN6AAOgKHW49hOIbsApM=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:54 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:54 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 19/22] fuzz: add i440fx fuzz targets
Date: Wed, 19 Feb 2020 23:11:15 -0500
Message-ID: <20200220041118.23264-20-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:53 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9ebf2e-7322-44a6-da72-08d7b5bb04f5
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3807F80E7EB75CEFC55D6D43BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR18C5+WKT32LFsCpcfJr7daJ+BZI++TZJT2gMEvP7fGLa407/cqI9DFakA1BZ0PD7urnq4nA6ipHILnE/bovt5B53C/gwv8k/YRMIOxAHi5gUZ0uVgdyoEc7jU8ZHVLKS52oSPm9Js1RoxYViP3KhAJH5PNda3GOsp827rZ8JZF20omyoLkoaBn4ERjLqsII8Yz6GhdYEmU9y+hosUmn90pK9FY1uChEfV+OgayaoAOMZaVS+b7U6rSINmXOaztMo3AIqMLmvP58iA8iGtEbyVURpO/31Pta5uxnLBsXB1HjA5geQVVvhU7/FBekEvY80jQN1paGDfeiJxIQXQb8ll6/PZ0veNRllQmdqsRL+KOS4Cw4I+Tqq8Oxrk8+8UPIFN78QO24kjSWEFMHvCmloyCpJ7q3MU5or9uuByr5N7QJGirGo2MtgnOrR+oNpDL
X-MS-Exchange-AntiSpam-MessageData: 66bBpz+R5ewrDLOSC+VRXoo84dYx+ZGhXMb++KbhjmdopNillcl2R7lACJGr+BtACpJOcavXNLr8JBWqyk1aeWifox/Zv07CPOG71JCWrAV6Ui3BoPu8TCn1VhYbwyYzoovZoW63HMJpVFAbvFz3vw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9ebf2e-7322-44a6-da72-08d7b5bb04f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:54.4946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN7r6MxjEGZuYoaPVTdspiRs2TJwm85h4eoP6emQxyY0LuIxdNcv/i+YXpJl3UB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.112
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
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These three targets should simply fuzz reads/writes to a couple ioports,
but they mostly serve as examples of different ways to write targets.
They demonstrate using qtest and qos for fuzzing, as well as using
rebooting and forking to reset state, or not resetting it at all.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/fuzz/Makefile.include |   3 +
 tests/qtest/fuzz/i440fx_fuzz.c    | 193 ++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)
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
index 0000000000..ab5f112584
--- /dev/null
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -0,0 +1,193 @@
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
+/*
+ * the input to the fuzzing functions below is a buffer of random bytes. w=
e
+ * want to convert these bytes into a sequence of qtest or qos calls. to d=
o
+ * this we define some opcodes:
+ */
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
+    /*
+     * loop over the Data, breaking it up into actions. each action has an
+     * opcode, address offset and value
+     */
+    typedef struct QTestFuzzAction {
+        uint8_t opcode;
+        uint8_t addr;
+        uint32_t value;
+    } QTestFuzzAction;
+    QTestFuzzAction a;
+
+    while (Size >=3D sizeof(a)) {
+        /* make a copy of the action so we can normalize the values in-pla=
ce */
+        memcpy(&a, Data, sizeof(a));
+        /* select between two i440fx Port IO addresses */
+        uint16_t addr =3D a.addr % 2 ? I440FX_PCI_HOST_BRIDGE_CFG :
+                                      I440FX_PCI_HOST_BRIDGE_DATA;
+        switch (a.opcode % ACTION_MAX) {
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
+        /* Move to the next operation */
+        Size -=3D sizeof(a);
+        Data +=3D sizeof(a);
+    }
+    flush_events(s);
+}
+
+static void i440fx_fuzz_qos(QTestState *s,
+        const unsigned char *Data, size_t Size) {
+    /*
+     * Same as i440fx_fuzz_qtest, but using QOS. devfn is incorporated int=
o the
+     * value written over Port IO
+     */
+    typedef struct QOSFuzzAction {
+        uint8_t opcode;
+        uint8_t offset;
+        int devfn;
+        uint32_t value;
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
+        switch (a.opcode % ACTION_MAX) {
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
2.25.0


