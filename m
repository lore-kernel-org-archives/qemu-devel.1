Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B41C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8238A206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="EjuxycWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8238A206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1mf-0001RB-KE
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TS-00085W-Qh
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TQ-0007jO-U1
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:54 -0500
Received: from mail-dm3nam03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::72d]:36592
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TQ-0007S1-KN
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVH45VoTVDDQ1phoVHPWW/ke6iZOLDNe9X05FxsW8izNWbE7KkK9SLd2BTRtxMISZhChmw1Dqxo/p6UJStVMH5x1+juThh/rcMXjijuhY0M8ulHNQE5MZEL4hrLI8UuGGcyiDUkTfYNkGLqPNt/ilFxoVRlOyn361G7pXbcMPxru5YpSv1ZBnTYGJ8wuwwQCe//gNFCUmebU5ksPpAlO0lFj7AbSOe555lD6YXO8B9KtwwEPG/sHd2ODyv6uVTo+dPCzOY9q5TBHiO42WJ+/T7rQjQ+eUsjHNL4YHTgS+CfSMtNACaSyibx3YTeRkuAbfJXxq9o59k8NahnhPMcgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz2CIfHaatsfk//makhzsZ/4HZEjgxkCxYEtKXrVpk4=;
 b=XUhQkr/7uVUGa+FLiCY3LIMql45ohNvZCMg50uMuzs7i2hk9jAU9/Njktl8VMMw6n9JPKeGSBusSD50NXemx6h0fVabhrXwhIY2FU5BZfxU+mAMdNZzJczgFGjxJdXfDveu1QRZ8h6Y3l3ei0bCWVZBq3k+7bNnO/zvAxbtBe4zkR2mKwlmX5gmlG2H9z5QlVQcpgTH85Xxpcu8StzjagFepNKFkrbNkn1N+iECnxj5Bx1horF0sRSh+srhNrzJHrCCtbBXhGg/KTq7obXdfmkmyQCo8TUOPPfzm3eebSP725Fw4fn6UzG/2G3coFkZ7vfx+1ADRDkJSif3D7jTTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz2CIfHaatsfk//makhzsZ/4HZEjgxkCxYEtKXrVpk4=;
 b=EjuxycWGlZ8Zvm0o8PpHViXRmZbHnhso6uhqseqe3vM6rpd8DPdt1hR2wbqZapnM8jhDSuKHBf4gZ9Mz9ERbOl5VdzHQjZ+MvUOXDwHttPlhDxdYGc7W9Aglrcl1fT09jz7yesPXQxm/NV3aVgoNnf/Y4CHM6SRLEWonG7KqzjY=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:51 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:51 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 15/20] fuzz: add fuzzer skeleton
Thread-Topic: [PATCH v5 15/20] fuzz: add fuzzer skeleton
Thread-Index: AQHVmnTMSEvDABApckONK/1ZlUi2Zw==
Date: Wed, 13 Nov 2019 22:50:51 +0000
Message-ID: <20191113225030.17023-16-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 6b5b2a92-e394-41a6-b395-08d7688beec2
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB502418653293D5A7BD3E6E3ABA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4tWmJf7DNIv8BWN9RGLOvnbnJgpm1EjRfLqJYEu5246gk+CSTOpsEzsub3Ppde+s5QsRkP3hD6bdef2VEL0M5Vf1BaWRpxuIucGFbaMUL31PBQkxqaLKfY9Zh3EpSe6HPXzEGTc2v6pEofnfyATAEITuPs38nYOOyIN6Ra/ach9HIC1tOLi8a+fK/Ho4xqwEMgL1W3FSCB/WUmFeHDE8T7j0+uqnonB5dLjpxUQgnKq6DTQrk6luq45nQeVLtvhB3+k8daedCSeghEcVgUBTilTbQryF0m/iLo/9lWnMiVeYh2jwenMNqHnUeG9v2LRDC3tJNDfkuF0/d7ZVUIBaMPTGxto/VKr7j7rafO7YORQgeRs2e3d5a6BC2td8fFfRv+cHH7dJdWGR4AemZJvIpa78JE4OYcOg6OQWfjOopdr3tzgG9WaUAY8AalW/b5oN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5b2a92-e394-41a6-b395-08d7688beec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:51.4942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frK7eNYlQUelnVjdkhrdFdomKxHfWcXgmd+feHfIh8rt7unfxwEGRjyGFmKWiKfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::72d
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

tests/fuzz/fuzz.c serves as the entry point for the virtual-device
fuzzer. Namely, libfuzzer invokes the LLVMFuzzerInitialize and
LLVMFuzzerTestOneInput functions, both of which are defined in this
file. This change adds a "FuzzTarget" struct, along with the
fuzz_add_target function, which should be used to define new fuzz
targets.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/fuzz/Makefile.include |   4 +-
 tests/fuzz/fuzz.c           | 179 ++++++++++++++++++++++++++++++++++++
 tests/fuzz/fuzz.h           |  94 +++++++++++++++++++
 3 files changed, 275 insertions(+), 2 deletions(-)
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
index 0000000000..f4abaa3484
--- /dev/null
+++ b/tests/fuzz/fuzz.c
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
+#include "tests/libqtest.h"
+#include "tests/libqos/qgraph.h"
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
+    return qtest_inproc_init(&fuzz_qts, false fuzz_arch,
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
diff --git a/tests/fuzz/fuzz.h b/tests/fuzz/fuzz.h
new file mode 100644
index 0000000000..5135b252bf
--- /dev/null
+++ b/tests/fuzz/fuzz.h
@@ -0,0 +1,94 @@
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
+    const char *name;         /* command-line option(FUZZ_TARGET) for the =
target */
+    const char *description;  /* help text */
+
+
+    /* returns the arg-list that is passed to qemu/softmmu init()
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


