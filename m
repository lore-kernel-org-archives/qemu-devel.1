Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE0FC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C96920659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="yLcbSYUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C96920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cMB-0007mf-DV
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG1-0006aI-AM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFy-0008P8-1k
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:45 -0500
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com
 ([40.107.243.92]:50848 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFw-0008HE-Gc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Au+/ZP8QBPu87LcsbSkoqXWwfb3z+kjciFMXT4DM2AwdpTMRr9UpNYTdSzEcioAwokJ/ZyfVzJrvqNkN/1kko+LTOq3aq5p4u7NAUymRLxnYGGl+eWcNn8yhioOGaccuGxpBjUvmD6drsdkytJfM7o+n34mUPYfmiLE4FtiSBl/8dXYI+VkTTInDvjc0yhNEqs57JlUfiHJ0cLG1WlJofr3ZeKXbVgV7IZg2eojoK3dpB7uzsahucDRB5aEennZ3UACJDywB2BvhFtm6IcQ9ecz+0q1Mf1m/uA6RGWOQqQghFgFU5w3Pgx5K/KNIHeyTAe5VlOSSKSceaTm8xIqH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W51U/mRMhOqJUVCnkw55JJ/yY5ywTkjuJvqMbOArqhg=;
 b=b97Wkxd7fvWOQdOa0BgYe3Sa9amjBuH6934conzJ3hoWjd0SaH79MU9+FLgxTM2T1GNSMuxp3VwjojrnyGK+hMuRYsI2mNTtYu+GIkrQX0JZvwvB4Zgikogc66l92trq9GXoL8Qnjg3UyyrzxQsWNmwoa4GRQv3uZv3bU4F5iAFZiZ2DlCGbJ63kdI0UntW+a4ShkqowSufnGVMHCWXITDANuAP7rauh/7w6Ip8uprqDTnNerQ6BV/AvcPbKe0OONycmVWJoq73q/5ZhEK+4EdmfqPWJm467O8J/wjVsSccnj70ko6dQYstlpL+P5SJP9fLR33LIzSJ5/Xas2+nxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W51U/mRMhOqJUVCnkw55JJ/yY5ywTkjuJvqMbOArqhg=;
 b=yLcbSYUHQBzWKQ5VmDcGJtUBJ35RXwItZLAIJ0P24lFc3y35AXmLzHqgcySIuXJVDP3FBtqgipykOM6JVZLwedcvMg3q0MZhaIMa9+wrzg61gzO7PXlmtiydjlRv1dmRAETxRAa+DzsVMfANaAniPWtYiF8gZf4IaG+2FujTgwo=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:34 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:34 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 13/23] fuzz: add fuzzer skeleton
Date: Tue, 11 Feb 2020 15:35:00 -0500
Message-ID: <20200211203510.3534-14-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:33 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a2bd1dd-e098-4004-b0b0-08d7af31f181
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4336C74AA31010E6933BF9DBBA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(54906003)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Zbnjw6Awf6KfvZgpxIIaJ4gWjABq0d2LiOQzGCSxlS7hxOPtRkpD5Fe4DOuwnSLkJLBbseSQwooX5Fvf9ZsP6ue6SRrzYKnJfNpHTGE0XAPOk++xptmGPL5eyQg2IgWWQRBHuyskbUwQlY2qVeVB5gJXVB1vDkgXAkFyZfEM9ScjyACIvjVZEeDjNWLqpg74CIMX5fJbw4q1CPKyM5H+59EFY0nsTN4g4d4xj2glfUEqhz/Ht2LvrXiJH3XSZmWAA1a61kg+IaV6MkeD13ZKgyTDMcLJvOihpXfjOqsmWeLvgFiBJMDO8bkaih8Bg2/zkFUjSMWsaSNNv6iLtSYcFgn9kL550NiRgqAAzxz+tmS2ZqMPCwA1wiRpATHnN9B/9co5I5U5V/SmQ0/1pLoZWjwOPpweJer4t5/OW2qqOs3dlIdiMKCwEIkUcb6i5j3
X-MS-Exchange-AntiSpam-MessageData: 6nR8rXZAfvSFny/DbD4X3iyyvmYlqlWtTJeOrCNJPe6uUw8o0J640Y5Vu8sZDI4gSPYcwEw8GOhtAE47z95oYLCQBRXI16WmvWD3Rqvf2k0XFB2xCR01bPAlE6orlSjXXbFGDTIGqBHMFuU2MkJuPA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2bd1dd-e098-4004-b0b0-08d7af31f181
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:33.8000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JGMw9rT56WMDaIP1fg1ooYhxLY+jSs2Lxj2Ue0Kvh4DJbGJcHLzPYha5QG7iXgW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.92
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

tests/fuzz/fuzz.c serves as the entry point for the virtual-device
fuzzer. Namely, libfuzzer invokes the LLVMFuzzerInitialize and
LLVMFuzzerTestOneInput functions, both of which are defined in this
file. This change adds a "FuzzTarget" struct, along with the
fuzz_add_target function, which should be used to define new fuzz
targets.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
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
2.25.0


