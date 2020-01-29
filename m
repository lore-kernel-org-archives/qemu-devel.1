Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61828C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2262071E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 05:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="DzEyENu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2262071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwg4Z-0000e5-AA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 00:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iwfze-00081W-MX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iwfzc-00023a-QS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:26 -0500
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com
 ([40.107.94.98]:3168 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iwfzc-0001yv-JW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 00:34:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPlAx+3u/Qh61qwje6BhAOkmqls4oQYFGAF8Brp5XgGALwoeVbhsCx45vay9vrVWZ7DlNU+jeVpMKWiSIkE41dqRJDbnWIVgT4CAlKOjme3NJFdCFIj56Ker/Nrnw6Gv2BWmg/UyjA6IHCwxzOeJrBLu1uJ4f9rDHYFAGHX6bC22FlxPOusJkofztVeGrwgqZGfEOe2Z3JNqNXXrPypyaM8wZf3661da13KI/9lf64CPEYJ1AjJliBo5rL6sBV0JAY/lIGsofToQNm3KoXfJSirpYKpMc0y+OTF3RFfP0ly1SW7iePg2DJeaIXXvXD5Kdh6+7jXrJTEppPJWmmc6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toT/WI9KXvNf9J/kQU+FipO7JDB1RCpX0zle0UZW2mc=;
 b=lhBxsXeEeM05A8QInXUx3AGF9oHglcp06DtCcmukqhggp6OQv/WKe/vOlk122IWbmmFcfPNAhuYSoOTsD0tursIW/nAbXd/XOZgKDuq9BFdgVam2nGl4r6bt2KL02QTFWMOgL85DD82F6AL5l5QSjq4HQW4UaSMnlbJel1jSkOmmxlAoQJwHV1EWIVFdKJsS5lT28vV8dIgLFVv9sLWV9DtWUJN4dwLCL3KBoB8WH3NTlWeBu2jo2dU0qPhgSdUSOJyGs/yYzHFDGZW54iWEzObdL/h5o+CkTbnwLOgDIxewkdHceJXsiJnIDxyeYNXjRSwLVKkuWQiSugS1bh+YeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toT/WI9KXvNf9J/kQU+FipO7JDB1RCpX0zle0UZW2mc=;
 b=DzEyENu+baG3O1fLffbulJCuu1YjgQKO5AkV0ZeeuKwVQ/TcOr5zVzK5t4io/3pthh0aIV9nB/EPwqKSW40KsDrcNlRw1G1fMN3fIm/b1ovtOgaGre+JlOPgci14aAznBzW7Ojay7Cj2NzhG3v57vZd3OC1FnfD2aAyEZhDzv4o=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4206.namprd03.prod.outlook.com (52.135.110.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Wed, 29 Jan 2020 05:34:22 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 05:34:22 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:c0::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19 via Frontend Transport; Wed, 29 Jan 2020 05:34:20 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v8 11/21] fuzz: add fuzzer skeleton
Thread-Topic: [PATCH v8 11/21] fuzz: add fuzzer skeleton
Thread-Index: AQHV1mXBODJcqzH0AEWyTrehxjp55A==
Date: Wed, 29 Jan 2020 05:34:20 +0000
Message-ID: <20200129053357.27454-12-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: f3ed7b38-703d-43a6-7d32-08d7a47ce415
x-ms-traffictypediagnostic: SN6PR03MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB42069E6EC48916DABD42C6E8BA050@SN6PR03MB4206.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
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
x-microsoft-antispam-message-info: 0DHIsM1jWTp8xt3tlNtbarET4kzdIQUNnAW7UQ+qvA+fG+PKw5TTGl9FlJYSmPNO1BLGj/j3rN/Hb41/PKHz6fJxbEDDweDAMqnaBBMtSBVtB3J/2Sr8hmVB9L9FD89684EOI+5xt2uvTIdkNpmP4JUvF5ihxinMrOriDkRpIzg/2xBuSqn8euigwLIn+tzLHBlf+SF96z2uI5gDan36f0DytIlrmsnDTfnqUdHfh1ihS0fLkuekwPp/nE0GiyVvJQiYp0p1c2bfaJpjFKdlXMZR2COPL0ZApFma757crmqXzLc7xdBHLT1ejlyyue+i3HLTXhrMunzN0b0Lcupk/lKqTEwKvoE71viDJR0/TMOcE/366DTTMfzQhafZZbSPJois8hFwYmZ8UXVZWxqMKsb32thqOhLejT4Ap3hqk9u7X94LzcYG+ZIEBvAmD6aH
x-ms-exchange-antispam-messagedata: Ta8QyhesrFuNIJNFDrHKDmGQ9plWk98NWXCGixPaWEmoT3+6QECIGm3IHj+5Bmqs9t5c15W6D6Y5PTD+YVSRU+3hqUV15EEpfCslv4Hh7bFhiYCWvATJ+fzwxP+2jLkxtFrt1RKm6Mu3ZmRitmJDxg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ed7b38-703d-43a6-7d32-08d7a47ce415
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 05:34:20.7876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DXNDHDVWbzYfMTUVbqpYZfn71M6ZL7KjMBANYVmUscx7zpN8Xe6etOonyaIF/sAo
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

tests/fuzz/fuzz.c serves as the entry point for the virtual-device
fuzzer. Namely, libfuzzer invokes the LLVMFuzzerInitialize and
LLVMFuzzerTestOneInput functions, both of which are defined in this
file. This change adds a "FuzzTarget" struct, along with the
fuzz_add_target function, which should be used to define new fuzz
targets.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/fuzz/Makefile.include |   6 +
 tests/qtest/fuzz/fuzz.c           | 179 ++++++++++++++++++++++++++++++
 tests/qtest/fuzz/fuzz.h           |  95 ++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 tests/qtest/fuzz/Makefile.include
 create mode 100644 tests/qtest/fuzz/fuzz.c
 create mode 100644 tests/qtest/fuzz/fuzz.h

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.=
include
new file mode 100644
index 0000000000..8632bb89f4
--- /dev/null
+++ b/tests/qtest/fuzz/Makefile.include
@@ -0,0 +1,6 @@
+QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
+
+fuzz-obj-y +=3D tests/qtest/libqtest.o
+fuzz-obj-y +=3D tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
+
+FUZZ_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
new file mode 100644
index 0000000000..0d78ac8d36
--- /dev/null
+++ b/tests/qtest/fuzz/fuzz.c
@@ -0,0 +1,179 @@
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
+#include <wordexp.h>
+
+#include "sysemu/qtest.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/qgraph.h"
+#include "fuzz.h"
+
+#define MAX_EVENT_LOOPS 10
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
+    int i =3D MAX_EVENT_LOOPS;
+    while (g_main_context_pending(NULL) && i-- > 0) {
+        main_loop_wait(false);
+    }
+}
+
+static QTestState *qtest_setup(void)
+{
+    qtest_server_set_send_handler(&qtest_client_inproc_recv, &fuzz_qts);
+    return qtest_inproc_init(&fuzz_qts, false, fuzz_arch,
+            &qtest_server_inproc_recv);
+}
+
+void fuzz_add_target(const FuzzTarget *target)
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
+        printf(" * %s  : %s\n", tmp->target->name,
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
+    /*
+     * Do the pre-fuzz-initialization before the first fuzzing iteration,
+     * instead of before the actual fuzz loop. This is needed since libfuz=
zer
+     * may fork off additional workers, prior to the fuzzing loop, and if
+     * pre_fuzz() sets up e.g. shared memory, this should be done for the
+     * individual worker processes
+     */
+    static int pre_fuzz_done;
+    if (!pre_fuzz_done && fuzz_target->pre_fuzz) {
+        fuzz_target->pre_fuzz(fuzz_qts);
+        pre_fuzz_done =3D true;
+    }
+
+    fuzz_target->fuzz(fuzz_qts, Data, Size);
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
+    if (fuzz_target->pre_vm_init) {
+        fuzz_target->pre_vm_init();
+    }
+
+    /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
+    const char *init_cmdline =3D fuzz_target->get_init_cmdline(fuzz_target=
);
+
+    /* Split the runcmd into an argv and argc */
+    wordexp_t result;
+    wordexp(init_cmdline, &result, 0);
+
+    qemu_init(result.we_wordc, result.we_wordv, NULL);
+
+    return 0;
+}
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
new file mode 100644
index 0000000000..03901d414e
--- /dev/null
+++ b/tests/qtest/fuzz/fuzz.h
@@ -0,0 +1,95 @@
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
+
+#include "tests/qtest/libqtest.h"
+
+/**
+ * A libfuzzer fuzzing target
+ *
+ * The QEMU fuzzing binary is built with all available targets, each
+ * with a unique @name that can be specified on the command-line to
+ * select which target should run.
+ *
+ * A target must implement ->fuzz() to process a random input.  If QEMU
+ * crashes in ->fuzz() then libfuzzer will record a failure.
+ *
+ * Fuzzing targets are registered with fuzz_add_target():
+ *
+ *   static const FuzzTarget fuzz_target =3D {
+ *       .name =3D "my-device-fifo",
+ *       .description =3D "Fuzz the FIFO buffer registers of my-device",
+ *       ...
+ *   };
+ *
+ *   static void register_fuzz_target(void)
+ *   {
+ *       fuzz_add_target(&fuzz_target);
+ *   }
+ *   fuzz_target_init(register_fuzz_target);
+ */
+typedef struct FuzzTarget {
+    const char *name;         /* target identifier (passed to --fuzz-targe=
t=3D)*/
+    const char *description;  /* help text */
+
+
+    /*
+     * returns the arg-list that is passed to qemu/softmmu init()
+     * Cannot be NULL
+     */
+    const char* (*get_init_cmdline)(struct FuzzTarget *);
+
+    /*
+     * will run once, prior to running qemu/softmmu init.
+     * eg: set up shared-memory for communication with the child-process
+     * Can be NULL
+     */
+    void(*pre_vm_init)(void);
+
+    /*
+     * will run once, after QEMU has been initialized, prior to the fuzz-l=
oop.
+     * eg: detect the memory map
+     * Can be NULL
+     */
+    void(*pre_fuzz)(QTestState *);
+
+    /*
+     * accepts and executes an input from libfuzzer. this is repeatedly
+     * executed during the fuzzing loop. Its should handle setup, input
+     * execution and cleanup.
+     * Cannot be NULL
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
+void fuzz_add_target(const FuzzTarget *target);
+
+int LLVMFuzzerTestOneInput(const unsigned char *Data, size_t Size);
+int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp);
+
+#endif
+
--=20
2.23.0


