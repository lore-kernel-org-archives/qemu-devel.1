Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E7CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101762087F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="pM3hs4Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101762087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpPl-0007Uv-23
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIW-000571-1N
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIT-0007N2-0I
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:07 -0400
Received: from mail-eopbgr690101.outbound.protection.outlook.com
 ([40.107.69.101]:31361 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIS-0007LI-5z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP9W5aOeo8XtIGZWwY24d9FLajcvmKkqtIwzaBQlXMEN+EQLvfdZEELImM99ZGbRqBb1ox3TGaZtn6h8CaaSdythHZZNJsGhJjLerbhl7Hq1+kUUHDpFXhptRFW5j+7wFyyy4Q6lP1D0R4fLJU+fHkHKMCbqsvNmCjUH3f2CNNXtmD84oQ23MZtIW2UMFJUVB8RI/l0OjLmRRF0Ol8bYyk2pZ55FWgpBOFQPzC1Sa58mS77cpvpZkrkPmDxRg96aKgD7WYUPWODb9GIb3ITn2J0zR4XdSUIWdhZvNY9ObvHp/gtXv18t/bM/d6zcaPgYcsqBUGuZeIe5JdukqHpR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCYM1YkE/sLSoqw8gf/IFf74ztBP1BgoWkVkRs8e7KA=;
 b=DJxkmKrOWm+rjC1hLaDHH8+f6Mkyd8BveO9nqVcct5wp2YBi33IZSiJ8VC7niAkvsxzOXEqQ/OXktO5Wc6vNhXbr98rBEfHZEGlHnxh6nTkUieKHU/qmXFPUh8q4tpg0JUCiD0Jhs//h/D/NjEXmxmdItU1Q/mSdvPXAbw63+tnldQjub3Ptww/L9Em0coizbjWBsXO6bnsSiq8fCQPv+RK99scwu6k3RW1TPvlGVw6GJ3MU2LAaAeg6r/G9oz4INrLHNhZgXvfaisQGK9YrvkEsy8fNxnDG7GHK4X7CyzBmQw046XvU0suxVs4ypoOa9q3oms0atdrK9sMeUCA+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCYM1YkE/sLSoqw8gf/IFf74ztBP1BgoWkVkRs8e7KA=;
 b=pM3hs4KmlPp5b0yEyIXKC8ebqkjOQOoSc8pd9O9qm+8Bw5qRIvyGuwwVG6jVyJBCF6Gnefy51n2OvewUgCOeRUToF8zWMDGpejxwnCEYjbxvLy1qB3phnpIPhP8CZdkAeFOs9xkCc1rrA13ejp/uzs294bfMw5gYciWhu/y7VyM=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:50:01 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:50:01 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 15/20] fuzz: add fuzzer skeleton
Thread-Topic: [PATCH v4 15/20] fuzz: add fuzzer skeleton
Thread-Index: AQHVjzFOZqFs6T13M0yTJWMjIF12kA==
Date: Wed, 30 Oct 2019 14:50:00 +0000
Message-ID: <20191030144926.11873-16-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 6661ea61-efe7-4e63-ebde-08d75d4870a9
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB4959A3B2673CD018ADA4FF99BA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(14444005)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(25786009)(6436002)(75432002)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qFffnGe3QE1n1LvlYO/Fiyuc4BTMbdu4gVn1UHqWMzCN1wfRtrqtPlzC++tJdiLnY5FSEoz4eKjFCTHSP7Uc9uETamRSDseb36cqO3fOKxgNghH58nLb348uabTMcnZcuWnroCs+1zOsejcxBuxSkhtJNm2evPWQ9qFJs0tGj7Q0n1HzyeM9UuAM7EttlQ/f/5Mkzueu/jSbGawgrMlTDJuDd4Fylva0Gh+HIJA3jAbD+hrG1h2L+hfPJ9GnHcs1sedtRpO5lYplhdTcwxj8xQ+d0lbKO9lpEi/Md5/lpbdOSeciMqwKKj++fYAd3lRZ1cmCrz9q8FzxvXbAUxMCHwt7+TG4/GoyM2IoOaHBBP1dqtIfdpq8+Qb10B4kikr+kYNRmt4xChEKJXrTVdP5N2eKvOEEXrJRSe0Gof6GTBVJdKNse0Wxsrfvd/JefNZs
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6661ea61-efe7-4e63-ebde-08d75d4870a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:50:00.7475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXueM/A0QIrFZcX3XnwHrprZ+zcyTv7ZB51hssQU2QjLYkd46raKI/SeXy1kNZHf
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

tests/fuzz/fuzz.c serves as the entry point for the virtual-device
fuzzer. Namely, libfuzzer invokes the LLVMFuzzerInitialize and
LLVMFuzzerTestOneInput functions, both of which are defined in this
file. This change adds a "FuzzTarget" struct, along with the
fuzz_add_target function, which should be used to define new fuzz
targets.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include |   4 +-
 tests/fuzz/fuzz.c           | 177 ++++++++++++++++++++++++++++++++++++
 tests/fuzz/fuzz.h           |  66 ++++++++++++++
 3 files changed, 245 insertions(+), 2 deletions(-)
 create mode 100644 tests/fuzz/fuzz.c
 create mode 100644 tests/fuzz/fuzz.h

diff --git a/tests/fuzz/Makefile.include b/tests/fuzz/Makefile.include
index 324e6c1433..b415b056b0 100644
--- a/tests/fuzz/Makefile.include
+++ b/tests/fuzz/Makefile.include
@@ -1,4 +1,4 @@
-# QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
+QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
 fuzz-obj-y =3D $(libqos-obj-y)
 fuzz-obj-y +=3D tests/libqtest.o
-
+fuzz-obj-y +=3D tests/fuzz/fuzz.o
diff --git a/tests/fuzz/fuzz.c b/tests/fuzz/fuzz.c
new file mode 100644
index 0000000000..0e38f81c48
--- /dev/null
+++ b/tests/fuzz/fuzz.c
@@ -0,0 +1,177 @@
+/*
+ * fuzzing driver
+ *
+ * Copyright Red Hat Inc., 2019
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <wordexp.h>
+
+
+#include "tests/libqtest.h"
+#include "sysemu/qtest.h"
+#include "fuzz.h"
+#include "tests/libqos/qgraph.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+
+typedef struct FuzzTargetState {
+        FuzzTarget *target;
+        QSLIST_ENTRY(FuzzTargetState) target_list;
+} FuzzTargetState;
+
+typedef QSLIST_HEAD(, FuzzTargetState) FuzzTargetList;
+
+static const char *fuzz_arch =3D TARGET_NAME;
+
+static FuzzTargetList *fuzz_target_list;
+static FuzzTarget *fuzz_target;
+static QTestState *fuzz_qts;
+
+
+
+void flush_events(QTestState *s)
+{
+    int i =3D 10;
+    while (g_main_context_pending(NULL) && i-- > 0) {
+        main_loop_wait(false);
+    }
+}
+
+static QTestState *qtest_setup(void)
+{
+    qtest_server_set_tx_handler(&qtest_client_inproc_recv, NULL);
+    return qtest_inproc_init(false, fuzz_arch, &qtest_server_inproc_recv);
+}
+
+void fuzz_add_target(FuzzTarget *target)
+{
+    FuzzTargetState *tmp;
+    FuzzTargetState *target_state;
+    if (!fuzz_target_list) {
+        fuzz_target_list =3D g_new0(FuzzTargetList, 1);
+    }
+
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        if (g_strcmp0(tmp->target->name, target->name) =3D=3D 0) {
+            fprintf(stderr, "Error: Fuzz target name %s already in use\n",
+                    target->name);
+            abort();
+        }
+    }
+    target_state =3D g_new0(FuzzTargetState, 1);
+    target_state->target =3D g_new0(FuzzTarget, 1);
+    *(target_state->target) =3D *target;
+    QSLIST_INSERT_HEAD(fuzz_target_list, target_state, target_list);
+}
+
+
+
+static void usage(char *path)
+{
+    printf("Usage: %s --fuzz-target=3DFUZZ_TARGET [LIBFUZZER ARGUMENTS]\n"=
, path);
+    printf("where FUZZ_TARGET is one of:\n");
+    FuzzTargetState *tmp;
+    if (!fuzz_target_list) {
+        fprintf(stderr, "Fuzz target list not initialized\n");
+        abort();
+    }
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        printf(" %s  : %s\n", tmp->target->name,
+                tmp->target->description);
+    }
+    exit(0);
+}
+
+static FuzzTarget *fuzz_get_target(char* name)
+{
+    FuzzTargetState *tmp;
+    if (!fuzz_target_list) {
+        fprintf(stderr, "Fuzz target list not initialized\n");
+        abort();
+    }
+
+    QSLIST_FOREACH(tmp, fuzz_target_list, target_list) {
+        if (strcmp(tmp->target->name, name) =3D=3D 0) {
+            return tmp->target;
+        }
+    }
+    return NULL;
+}
+
+
+/* Executed for each fuzzing-input */
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size)
+{
+    if (fuzz_target->fuzz) {
+        fuzz_target->fuzz(fuzz_qts, Data, Size);
+    }
+    return 0;
+}
+
+/* Executed once, prior to fuzzing */
+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
+{
+
+    char *target_name;
+
+    /* Initialize qgraph and modules */
+    qos_graph_init();
+    module_call_init(MODULE_INIT_FUZZ_TARGET);
+    module_call_init(MODULE_INIT_QOM);
+    module_call_init(MODULE_INIT_LIBQOS);
+
+    if (*argc <=3D 1) {
+        usage(**argv);
+    }
+
+    /* Identify the fuzz target */
+    target_name =3D (*argv)[1];
+    if (!strstr(target_name, "--fuzz-target=3D")) {
+        usage(**argv);
+    }
+
+    target_name +=3D strlen("--fuzz-target=3D");
+
+    fuzz_target =3D fuzz_get_target(target_name);
+    if (!fuzz_target) {
+        usage(**argv);
+    }
+
+    fuzz_qts =3D qtest_setup();
+
+    if (!fuzz_target) {
+        fprintf(stderr, "Error: Fuzz fuzz_target name %s not found\n",
+                target_name);
+        usage(**argv);
+    }
+
+    if (fuzz_target->pre_vm_init) {
+        fuzz_target->pre_vm_init();
+    }
+
+    /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
+    char *init_cmdline =3D fuzz_target->get_init_cmdline(fuzz_target);
+
+    wordexp_t result;
+    wordexp(init_cmdline, &result, 0);
+
+    qemu_init(result.we_wordc, result.we_wordv, NULL);
+
+    if (fuzz_target->pre_fuzz) {
+        fuzz_target->pre_fuzz(fuzz_qts);
+    }
+
+    return 0;
+}
diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
new file mode 100644
index 0000000000..b569b622d7
--- /dev/null
+++ b/tests/fuzz/fuzz.h
@@ -0,0 +1,66 @@
+/*
+ * fuzzing driver
+ *
+ * Copyright Red Hat Inc., 2019
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef FUZZER_H_
+#define FUZZER_H_
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "exec/memory.h"
+#include "tests/libqtest.h"
+
+
+typedef struct FuzzTarget {
+    const char *name;         /* command-line option(FUZZ_TARGET) for the =
target */
+    const char *description;  /* help text */
+
+
+    /* returns the arg-list that is passed to qemu/softmmu init() */
+    char* (*get_init_cmdline)(struct FuzzTarget *);
+
+    /*
+     * will run once, prior to running qemu/softmmu init.
+     * eg: set up shared-memory for communication with the child-process
+     */
+    void(*pre_vm_init)(void);
+
+    /*
+     * will run once, prior to to the fuzz-loop.
+     * eg: detect the memory map
+     */
+    void(*pre_fuzz)(QTestState *);
+
+    /*
+     * accepts and executes an input from libfuzzer. this is repeatedly
+     * executed during the fuzzing loop. Its should handle setup, input
+     * execution and cleanup
+     */
+    void(*fuzz)(QTestState *, const unsigned char *, size_t);
+
+} FuzzTarget;
+
+void flush_events(QTestState *);
+void reboot(QTestState *);
+
+/*
+ * makes a copy of *target and adds it to the target-list.
+ * i.e. fine to set up target on the caller's stack
+ */
+void fuzz_add_target(FuzzTarget *target);
+
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
+
+#endif
+
--=20
2.23.0


