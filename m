Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF6C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CFA206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="X0EkA7Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CFA206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cVS-0002WG-Ih
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cG2-0006cZ-JM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFz-0008TC-Ad
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:46 -0500
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com
 ([40.107.243.92]:50848 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFy-0008HE-WF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYgPzVH3dJDymN+rClSqNFvjJpjhiSR7edTAVOG6qKopBMwVB1etQzB88HVQdmS1Lbx0/mIkysQ+ahhxVVDb7il1LUTinPQjYP3Z74RWnMQkLHT9kOpzhj/wrLj3qTLm2UK7iYtbiQervWC7dsEp+PnmzkljZL7e8ipy5As3UxSRHAKPK6YnhUk3yFZsCl2w0slPt8xMhI4p48Kkk3u4rfq910dbj/oc1sQ+fFRzTPrQ1BBKrrfJaSQT4lofBry2CCoRispBce5XQ2DPCS/a0T4hdrKcdRYMvh8Xsj5ur7eMaDlEKv0CHcRAhlIQaFrjnMZPide3ym0gs11qMZFtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBeT1i7EFoLuNeX3ijuHxlFAa7ma81S31ZdABHnJlg8=;
 b=TX8GBByOMhBvb1armCQDf9HBSQIG2FiyOxfmr5K4+rAQSxVBBT9FvJT9UYd8/fo4xruhsvcB0q0U02OwtayuRuVYk6Zl/4IrF31SsQk3HYkk9bJ2ufbRyEmVxNAqRpdHOF82PHW6Gxh8+t6aoxdSG4gjQQRgTVrkMGE45BqBEXpdnSTvWaFFyZ4q6QuYG6FpK+mSdq8AB6xWjR786LmuH8k065KhV55R0I1yqHJdfaaxCYVjH1cN599gOkggilDT0mMtagxM0rbc4FG74qHwwD1/ggvtBCiwl6pcjDnLZObhIdK1M6r/7/MI+5s0LlV5hCEXDTjJLxQIeoUVZBYUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBeT1i7EFoLuNeX3ijuHxlFAa7ma81S31ZdABHnJlg8=;
 b=X0EkA7TbmAbrIJz3TEC05Mon2mlzaguQ9zOWm9ApUw0ujkUzRU0F8OOgv7fZJTK9i6zIee1joYPPXA2sK9nYXmEXclLzOvqLxhmhzcClvIJ4RNGzCFWGQ/XdECJDUUDtIn6xOV1RnYGt/us20fJ+aX+8VOdsJPRm9dcP7MYoHbE=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:37 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:37 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 17/23] fuzz: add support for qos-assisted fuzz targets
Date: Tue, 11 Feb 2020 15:35:04 -0500
Message-ID: <20200211203510.3534-18-alxndr@bu.edu>
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
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:36 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b70e04dc-d254-4277-d8f5-08d7af31f39d
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4336A364866000419AF1AA25BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(54906003)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zja5Ep53NOOUeIzbDTbZUOguQQXJbkCybNNxsKCsudC8uCtlZ2nbLXFMUGq2tM0MIYQ7X9S7hVOnlyJhRnl8exUmycwF2I3f9/6CRpSyU2kl9NpFbmpyNsMwtRxlhF026GFmMF6sUNgPaNgoQ4Gx9/zNYGCFepDzSAsbtqSnObo283553IHG6tJ7V1TXtTlJ8TqnKVjgqAGlcVb5y13KdqpFkrosQ7r2xHtilqpf/zZeX1vwrrgbJmuEEtWeidqoCh6Mq39r8LUOVFr345Dvy28R1C6xQDIhb+NVJVd46NcfI1p4v8MIfR6vBbrdJ37BQUlO1zCqbCnA42BWEkJM2+FYgai/3rbER2Tq1vDDSIQNjTxh2WW/3601w770lkvqjBg1s75sIf805jv5XIMGbzIgOIOGsOjg8MlQNNIBXpUrmcBMT4j5oCQ2BzSkpS1SZPT2qifSnZzx9Zwvs/Xpo9ykCSDLIhlu/xr8y5jnuYPs65Zx62aindmeby7iDRPp5bGiwsqracmGApB1PNZ8mZFANXn8ferwNTAdzTqs0FsNuemwWwGOqmCIa4X5eJGM
X-MS-Exchange-AntiSpam-MessageData: F6oyO+DH6eoucDKwAHZqjCuZSAaJNDr5miA/xVqhzRWpJBCScJ1/NrBVm4yZymE4RF2VYEQPVaM5Bqpi2HNE8jifD0abUzCqn9OTnEcUG5L2vSUxhNXy9Ujp006grY5qpj/62PV5LFPAbsEHaKJptA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b70e04dc-d254-4277-d8f5-08d7af31f39d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:37.3280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYTL8AFOK8iq8rA740ZLlesQNiWxrbNYT4vigZ8kYGAI71pDmG1/Yv0LgSIHsvuL
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/fuzz/Makefile.include |   2 +
 tests/qtest/fuzz/qos_fuzz.c       | 234 ++++++++++++++++++++++++++++++
 tests/qtest/fuzz/qos_fuzz.h       |  33 +++++
 3 files changed, 269 insertions(+)
 create mode 100644 tests/qtest/fuzz/qos_fuzz.c
 create mode 100644 tests/qtest/fuzz/qos_fuzz.h

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.=
include
index a90915d56d..e3bdd33ff4 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -1,8 +1,10 @@
 QEMU_PROG_FUZZ=3Dqemu-fuzz-$(TARGET_NAME)$(EXESUF)
=20
 fuzz-obj-y +=3D tests/qtest/libqtest.o
+fuzz-obj-y +=3D $(libqos-obj-y)
 fuzz-obj-y +=3D tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
 fuzz-obj-y +=3D tests/qtest/fuzz/fork_fuzz.o
+fuzz-obj-y +=3D tests/qtest/fuzz/qos_fuzz.o
=20
 FUZZ_CFLAGS +=3D -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
=20
diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
new file mode 100644
index 0000000000..bbb17470ff
--- /dev/null
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -0,0 +1,234 @@
+/*
+ * QOS-assisted fuzzing helpers
+ *
+ * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail=
.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+
+#include "tests/qtest/libqtest.h"
+#include "tests/qtest/libqos/malloc.h"
+#include "tests/qtest/libqos/qgraph.h"
+#include "tests/qtest/libqos/qgraph_internal.h"
+#include "tests/qtest/libqos/qos_external.h"
+
+#include "fuzz.h"
+#include "qos_fuzz.h"
+
+#include "qapi/qapi-commands-machine.h"
+#include "qapi/qapi-commands-qom.h"
+#include "qapi/qmp/qlist.h"
+
+
+void *fuzz_qos_obj;
+QGuestAllocator *fuzz_qos_alloc;
+
+static const char *fuzz_target_name;
+static char **fuzz_path_vec;
+
+/*
+ * Replaced the qmp commands with direct qmp_marshal calls.
+ * Probably there is a better way to do this
+ */
+static void qos_set_machines_devices_available(void)
+{
+    QDict *req =3D qdict_new();
+    QObject *response;
+    QDict *args =3D qdict_new();
+    QList *lst;
+    Error *err =3D NULL;
+
+    qmp_marshal_query_machines(NULL, &response, &err);
+    assert(!err);
+    lst =3D qobject_to(QList, response);
+    apply_to_qlist(lst, true);
+
+    qobject_unref(response);
+
+
+    qdict_put_str(req, "execute", "qom-list-types");
+    qdict_put_str(args, "implements", "device");
+    qdict_put_bool(args, "abstract", true);
+    qdict_put_obj(req, "arguments", (QObject *) args);
+
+    qmp_marshal_qom_list_types(args, &response, &err);
+    assert(!err);
+    lst =3D qobject_to(QList, response);
+    apply_to_qlist(lst, false);
+    qobject_unref(response);
+    qobject_unref(req);
+}
+
+static char **current_path;
+
+void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
+{
+    return allocate_objects(qts, current_path + 1, p_alloc);
+}
+
+static const char *qos_build_main_args(void)
+{
+    char **path =3D fuzz_path_vec;
+    QOSGraphNode *test_node;
+    GString *cmd_line =3D g_string_new(path[0]);
+    void *test_arg;
+
+    if (!path) {
+        fprintf(stderr, "QOS Path not found\n");
+        abort();
+    }
+
+    /* Before test */
+    current_path =3D path;
+    test_node =3D qos_graph_get_node(path[(g_strv_length(path) - 1)]);
+    test_arg =3D test_node->u.test.arg;
+    if (test_node->u.test.before) {
+        test_arg =3D test_node->u.test.before(cmd_line, test_arg);
+    }
+    /* Prepend the arguments that we need */
+    g_string_prepend(cmd_line,
+            TARGET_NAME " -display none -machine accel=3Dqtest -m 64 ");
+    return cmd_line->str;
+}
+
+/*
+ * This function is largely a copy of qos-test.c:walk_path. Since walk_pat=
h
+ * is itself a callback, its a little annoying to add another argument/lay=
er of
+ * indirection
+ */
+static void walk_path(QOSGraphNode *orig_path, int len)
+{
+    QOSGraphNode *path;
+    QOSGraphEdge *edge;
+
+    /* etype set to QEDGE_CONSUMED_BY so that machine can add to the comma=
nd line */
+    QOSEdgeType etype =3D QEDGE_CONSUMED_BY;
+
+    /* twice QOS_PATH_MAX_ELEMENT_SIZE since each edge can have its arg */
+    char **path_vec =3D g_new0(char *, (QOS_PATH_MAX_ELEMENT_SIZE * 2));
+    int path_vec_size =3D 0;
+
+    char *after_cmd, *before_cmd, *after_device;
+    GString *after_device_str =3D g_string_new("");
+    char *node_name =3D orig_path->name, *path_str;
+
+    GString *cmd_line =3D g_string_new("");
+    GString *cmd_line2 =3D g_string_new("");
+
+    path =3D qos_graph_get_node(node_name); /* root */
+    node_name =3D qos_graph_edge_get_dest(path->path_edge); /* machine nam=
e */
+
+    path_vec[path_vec_size++] =3D node_name;
+    path_vec[path_vec_size++] =3D qos_get_machine_type(node_name);
+
+    for (;;) {
+        path =3D qos_graph_get_node(node_name);
+        if (!path->path_edge) {
+            break;
+        }
+
+        node_name =3D qos_graph_edge_get_dest(path->path_edge);
+
+        /* append node command line + previous edge command line */
+        if (path->command_line && etype =3D=3D QEDGE_CONSUMED_BY) {
+            g_string_append(cmd_line, path->command_line);
+            g_string_append(cmd_line, after_device_str->str);
+            g_string_truncate(after_device_str, 0);
+        }
+
+        path_vec[path_vec_size++] =3D qos_graph_edge_get_name(path->path_e=
dge);
+        /* detect if edge has command line args */
+        after_cmd =3D qos_graph_edge_get_after_cmd_line(path->path_edge);
+        after_device =3D qos_graph_edge_get_extra_device_opts(path->path_e=
dge);
+        before_cmd =3D qos_graph_edge_get_before_cmd_line(path->path_edge)=
;
+        edge =3D qos_graph_get_edge(path->name, node_name);
+        etype =3D qos_graph_edge_get_type(edge);
+
+        if (before_cmd) {
+            g_string_append(cmd_line, before_cmd);
+        }
+        if (after_cmd) {
+            g_string_append(cmd_line2, after_cmd);
+        }
+        if (after_device) {
+            g_string_append(after_device_str, after_device);
+        }
+    }
+
+    path_vec[path_vec_size++] =3D NULL;
+    g_string_append(cmd_line, after_device_str->str);
+    g_string_free(after_device_str, true);
+
+    g_string_append(cmd_line, cmd_line2->str);
+    g_string_free(cmd_line2, true);
+
+    /*
+     * here position 0 has <arch>/<machine>, position 1 has <machine>.
+     * The path must not have the <arch>, qtest_add_data_func adds it.
+     */
+    path_str =3D g_strjoinv("/", path_vec + 1);
+
+    /* Check that this is the test we care about: */
+    char *test_name =3D strrchr(path_str, '/') + 1;
+    if (strcmp(test_name, fuzz_target_name) =3D=3D 0) {
+        /*
+         * put arch/machine in position 1 so run_one_test can do its work
+         * and add the command line at position 0.
+         */
+        path_vec[1] =3D path_vec[0];
+        path_vec[0] =3D g_string_free(cmd_line, false);
+
+        fuzz_path_vec =3D path_vec;
+    } else {
+        g_free(path_vec);
+    }
+
+    g_free(path_str);
+}
+
+static const char *qos_get_cmdline(FuzzTarget *t)
+{
+    /*
+     * Set a global variable that we use to identify the qos_path for our
+     * fuzz_target
+     */
+    fuzz_target_name =3D t->name;
+    qos_set_machines_devices_available();
+    qos_graph_foreach_test_path(walk_path);
+    return qos_build_main_args();
+}
+
+void fuzz_add_qos_target(
+        FuzzTarget *fuzz_opts,
+        const char *interface,
+        QOSGraphTestOptions *opts
+        )
+{
+    qos_add_test(fuzz_opts->name, interface, NULL, opts);
+    fuzz_opts->get_init_cmdline =3D qos_get_cmdline;
+    fuzz_add_target(fuzz_opts);
+}
+
+void qos_init_path(QTestState *s)
+{
+    fuzz_qos_obj =3D qos_allocate_objects(s , &fuzz_qos_alloc);
+}
diff --git a/tests/qtest/fuzz/qos_fuzz.h b/tests/qtest/fuzz/qos_fuzz.h
new file mode 100644
index 0000000000..477f11b02b
--- /dev/null
+++ b/tests/qtest/fuzz/qos_fuzz.h
@@ -0,0 +1,33 @@
+/*
+ * QOS-assisted fuzzing helpers
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
+#ifndef _QOS_FUZZ_H_
+#define _QOS_FUZZ_H_
+
+#include "tests/qtest/fuzz/fuzz.h"
+#include "tests/qtest/libqos/qgraph.h"
+
+int qos_fuzz(const unsigned char *Data, size_t Size);
+void qos_setup(void);
+
+extern void *fuzz_qos_obj;
+extern QGuestAllocator *fuzz_qos_alloc;
+
+void fuzz_add_qos_target(
+        FuzzTarget *fuzz_opts,
+        const char *interface,
+        QOSGraphTestOptions *opts
+        );
+
+void qos_init_path(QTestState *);
+
+#endif
--=20
2.25.0


