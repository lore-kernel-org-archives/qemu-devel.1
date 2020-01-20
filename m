Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E8EC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81B82073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 06:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="d5veXLEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81B82073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itQHt-0000dP-FP
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 01:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1itQ1h-0007Hf-3U
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1itQ1f-0006Sv-22
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:04 -0500
Received: from mail-bn7nam10on2122.outbound.protection.outlook.com
 ([40.107.92.122]:57128 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1itQ1e-0006Sd-Sn
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 00:55:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut4Cru+uWTe3eh5CFMqZgvz2pvi/2BxSeEQYA5rREkl30im2/2Gja1gg5YlP2zb0rILI/JX0UDUSZZqfz1SjaU+GMPxa1PV2oeBbYqoOG0XpTRUTy70BIM4DDfMJlEcrI07oFFMmilBS8NoSecGz964qpttGNA5WwaR4yzXYzgaWSCqv8jruM7GhDdx5gxBs5w1dEhJCEqoHn+mYex+FzIzueLt7OMYDF3a6IX0bZS69lYFayE6YP7sdmqdFtcmn3dy+74E9iVJjFpflTbvfzOcV8i1dR68tESE9qqg+56xITgG7fgs0uPeXia75tw9FjrbScSBAh+iZDWeDYJ68tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3/v88HWAuWAPx4PQlybO5l5a9/rWxQ9WHHkxquveJY=;
 b=alx7jJtK8TVbhi0rVbuHjSmpZzoDCOfOnhmALX2syN/Y8CMtqeWDWGS0ciNICqDITVF5Ih6Ek4knGV9eDwU+myRGsQxBFGwCAuUEyoLIJW+JpiipraEgUxLex2ZYHqM6eLqMlDH0gAGRLk2T/cEmHPfDQhf9OcANPFyY+QO1AA2BHkkpxTsejr/kuXbyY5HwfjVYlB7+wSglF6wcSEibUxPBvhCanXbvIj2Qjh6KsiSuwjutnEk/DMCFyAnVqdVWFI6dJxB9XWc6Wfc+zSBMdXAIRGogLxqHVsLzLd+KdTca9ctWkV5vhgt0LyQI9TpW2t5gCzGqtXXlrcGpJMcm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3/v88HWAuWAPx4PQlybO5l5a9/rWxQ9WHHkxquveJY=;
 b=d5veXLEuMetrN6xxyfYd+2y2Ue8WnVRU/y0kUVp3zML6vux5isrDgm8h7QdibnGBQ/lHKs6o/pDb5/w4+XXzyrBGaoFYby3yw9bjriW/GKzRIYc2NV4Fwm7tTuVrsyVoStJrpR+Pkdf7vCcX2Z8r338nQjjxwPJh+wHn6BdeBGE=
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4399.namprd03.prod.outlook.com (20.178.6.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Mon, 20 Jan 2020 05:55:01 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 05:55:01 +0000
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 05:55:01 +0000
From: "Bulekov, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v7 14/20] fuzz: add support for qos-assisted fuzz targets
Thread-Topic: [PATCH v7 14/20] fuzz: add support for qos-assisted fuzz targets
Thread-Index: AQHVz1YnOj+xCYNAl06oCwVpnFIxuw==
Date: Mon, 20 Jan 2020 05:55:01 +0000
Message-ID: <20200120055410.22322-20-alxndr@bu.edu>
References: <20200120055410.22322-1-alxndr@bu.edu>
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 790c33d7-1d84-4395-b163-08d79d6d49f9
x-ms-traffictypediagnostic: SN6PR03MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR03MB4399F15537C5CD2CD489AC0BBA320@SN6PR03MB4399.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(5660300002)(956004)(2616005)(8936002)(86362001)(6916009)(6486002)(7696005)(1076003)(52116002)(316002)(71200400001)(16526019)(186003)(786003)(478600001)(2906002)(26005)(81166006)(66946007)(66476007)(64756008)(36756003)(8676002)(75432002)(81156014)(66446008)(4326008)(66556008)(54906003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4399;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: so09w5CLEzUTWc0oz94NVd5WAOzoqC8c0B3hIlEzzwNxFzW99+xSCK5xsPZ+/GakCoPaYRV9v5ddBfls4sAWEDN5Bzwj3N7G24ixUjYVa12lrZUNBZZzkNm1qzS6UqDl9CQ36w7tTpIqYADPX7DtFa8mcD/NxObpV+s5TVdfhw1KJcSdNSs0YQrnJhbf8Y+888DO+/j2dCO1iVYQvw72QysqeT+3Wd0NUX7roWtVB9Uo135pNh8UsvKRb3O94kwu77fT2W3CAj7CWZQI8DMYIzAcQiVV/MhT5y857aVf3/Q37CTOecsmDsu/ZhCDkDnEnGrZKaWk0qaxqalx/u/Kz45M1pdddQWg7sQJWwKUumkNVUvJf9h1Z/R/OwmdrB5YU7hrPoCeeJvrr9cLm8I+tYNibafQlP8V05bygFXNrRUfcYjc66ZOjbVIgibvSrWdpQeK2j6Eaq+PeCDbxMjBvJ+2MnTuAFRGjhCLtZUos1k8REDnM3rIPtnvKRhom4mOXS0cHmCQNgQeU9SJOaDXRwERNPTN8EMihVfYLsFruMb+FUmkBH66qACEoHyu7Jc1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 790c33d7-1d84-4395-b163-08d79d6d49f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 05:55:01.7279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4ANWNvcaDrrXurlV1L+YVfnoatiTJuyfyiGl6f3HoBEqL6Yl1RHcnQtJ71EJn3z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4399
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.122
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/fuzz/Makefile.include |   2 +
 tests/qtest/fuzz/qos_fuzz.c       | 229 ++++++++++++++++++++++++++++++
 tests/qtest/fuzz/qos_fuzz.h       |  33 +++++
 3 files changed, 264 insertions(+)
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
index 0000000000..efdcc6e9d3
--- /dev/null
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -0,0 +1,229 @@
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
2.23.0


