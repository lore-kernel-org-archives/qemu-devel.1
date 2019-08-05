Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296A1C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E842182B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="7LBZvZLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E842182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXEk-0006oK-1l
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9J-0003bn-GV
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9H-00022X-P1
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:17 -0400
Received: from mail-eopbgr680101.outbound.protection.outlook.com
 ([40.107.68.101]:34519 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9H-00022H-IW
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzmWmKdEByMPjJnR22GPi4BxZmvxwn+DUM1inWYH3EXFzqHHkPA1DhGpqHlakAA0YM2q6n7QVjWPv8O9DirqxbyBbOcKoLt/JugJ7vUqxSszj8Lsmhmcfix8/4s2FLsEfAwVHuN4BTV1+Z3I9MdPN4tZxWHGQ2a73F+DrXlMCKTKOBvWp5IrRYRh0Qfu/seDX7z62LU/wLPdKcQedVc96Vycai6i6ysA5O1disSPAXtOCotcIBkktCPjFrwgP9KsfXuDej1HquEamWFNebBAcUsNirTZo57x5F5tTGTL4Q4OfTrtWT4eBImAQks1d4a+odhMdk51u1qWKvx5vxQHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG7Ozow/ssM5Yv5IG0nkr4jt9M91oaRoTimntWMrJi4=;
 b=DFO4/I0g1rbbCRHrkDvSq5+aVMBZpiAXTy1rXaruyKOrRYGJc/T8qX2l6uBlhP5pAKFTzVHIXigxT3Hh30a6m9g+G/NlI1z+Sa24Rt7nFakYXFdw+v5ttlVM1VoOVyhFHwmY4gyZIhpubXH9zqmVdDZFhjp2Cv6mlqlc+evOdkP4IZ5GzKElyDzFFbc6dEIolVQ5I4eQoTwLruf77noBe/09KmnEOjrnFrQl5uyO1fPHyJjPS7ghVxWN48ZI6NfOY1VX2OT9ZX2WAgotlB7en1uOZZrcfz1VEq9lvURTiJxx4aCvsXK+Z4PJJ+2VawNqH3W8RdcoDbWuQmeQkIhs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG7Ozow/ssM5Yv5IG0nkr4jt9M91oaRoTimntWMrJi4=;
 b=7LBZvZLpYWBbl2p8r0MdB4sMbLvTdxo6LlM1tLqYDf8TgyXL8EHHtThHX8A4H7G8KRGZwKW/vHbCwun+TcQzyS7FfJtSV4jo1T2GpJBOyPa1XImTgGDvVNRAnZW7E0aXU2OqBvcXWwj1pbPfRYnTDYwYJ5lbkI4BptdS/0p9wCI=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:14 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:14 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 13/17] fuzz: Add libqos support to the fuzzer
Thread-Index: AQHVS1z3x4d02ytB7ECpRSkQohtLTQ==
Date: Mon, 5 Aug 2019 07:11:14 +0000
Message-ID: <20190805071038.32146-14-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dfd2089-ff41-4e7b-2d44-08d719741a13
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB26469E08999B219C744C42F6BADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s+htWAEHlypk+MzlHl1IUfi+ZYZzhKcMqfW9Fy1D946k0eS1bBkyFgbiQDDvpPTJcBAiHGanuxsIRtSY/9USengWHBLh3xkuJ07SW5F7nV4hkvbsA40BbJUqRoH6aD3snN33NmKNs3ZC6BrG6lYbpa+gtdOl8rto09GuyejXDOltzmsdkd0h6R2MnQAB75SvsVEXmaxGRChXTkJIfntKaZLrZoCsILSPP1bAgSkLmbVm+Q2e/xrH1xaptiSs7uo5XQy8NcZyp+Uft4f3ODXvgIfsZzQkltyCZflHT/nmUvuAhrvH6HsZE+6oSdwxYiErCdnMcIss0HCcIVdW7l6/j44fI2ONYNMUNJrHjPnXsPx/n1+5YTBzspACaxW1dwTIlEVJUrBzDaBDULDg76EASY1OcaxYIGSCcS0ok4HTx0A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfd2089-ff41-4e7b-2d44-08d719741a13
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:14.2818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.101
Subject: [Qemu-devel] [RFC PATCH v2 13/17] fuzz: Add libqos support to the
 fuzzer
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/qos_fuzz.c    |  58 ++++++++++++
 tests/fuzz/qos_fuzz.h    |  23 +++++
 tests/fuzz/qos_helpers.c | 190 +++++++++++++++++++++++++++++++++++++++
 tests/fuzz/qos_helpers.h |  17 ++++
 4 files changed, 288 insertions(+)
 create mode 100644 tests/fuzz/qos_fuzz.c
 create mode 100644 tests/fuzz/qos_fuzz.h
 create mode 100644 tests/fuzz/qos_helpers.c
 create mode 100644 tests/fuzz/qos_helpers.h

diff --git a/tests/fuzz/qos_fuzz.c b/tests/fuzz/qos_fuzz.c
new file mode 100644
index 0000000000..80a22793d6
--- /dev/null
+++ b/tests/fuzz/qos_fuzz.c
@@ -0,0 +1,58 @@
+
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
+#include "libqos/malloc.h"
+#include "libqos/qgraph.h"
+#include "libqos/qgraph_internal.h"
+
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio.h"
+#include "libqos/virtio-net.h"
+#include "fuzz.h"
+#include "qos_fuzz.h"
+#include "qos_helpers.h"
+#include "tests/libqos/qgraph.h"
+#include "tests/libqtest.h"
+
+
+fuzz_memory_region *fuzz_memory_region_head;
+fuzz_memory_region *fuzz_memory_region_tail;
+
+uint64_t total_io_mem;
+uint64_t total_ram_mem;
+
+
+void fuzz_add_qos_target(const char *name,
+        const char *description,
+        const char *interface,
+        QOSGraphTestOptions *opts,
+        FuzzTarget *fuzz_opts
+        )
+{
+    qos_add_test(name, interface, NULL, opts);
+    fuzz_opts->main_argc =3D &qos_argc;
+    fuzz_opts->main_argv =3D &qos_argv;
+    fuzz_add_target(name, description, fuzz_opts);
+}
+
+
+/* Do what is normally done in qos_test.c:main */
+void qos_setup(void){
+    qtest_setup();
+    qos_set_machines_devices_available();
+    qos_graph_foreach_test_path(walk_path);
+    qos_build_main_args();
+}
+
+void qos_init_path(void)
+{
+    qos_obj =3D qos_allocate_objects(global_qtest, &qos_alloc);
+}
diff --git a/tests/fuzz/qos_fuzz.h b/tests/fuzz/qos_fuzz.h
new file mode 100644
index 0000000000..68d0684a7c
--- /dev/null
+++ b/tests/fuzz/qos_fuzz.h
@@ -0,0 +1,23 @@
+#ifndef _QOS_FUZZ_H_
+#define _QOS_FUZZ_H_
+
+#include "tests/libqos/qgraph.h"
+
+int qos_fuzz(const unsigned char *Data, size_t Size);
+void qos_setup(void);
+
+extern char **fuzz_path_vec;
+extern int qos_argc;
+extern char **qos_argv;
+extern void *qos_obj;
+extern QGuestAllocator *qos_alloc;
+
+
+void fuzz_add_qos_target(const char *name,
+        const char *description,
+        const char *interface,
+        QOSGraphTestOptions *opts,
+        FuzzTarget *fuzz_opts);
+
+void qos_init_path(void);
+#endif
diff --git a/tests/fuzz/qos_helpers.c b/tests/fuzz/qos_helpers.c
new file mode 100644
index 0000000000..c65f32e78b
--- /dev/null
+++ b/tests/fuzz/qos_helpers.c
@@ -0,0 +1,190 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qos_helpers.h"
+#include "fuzz.h"
+#include "qapi/qmp/qlist.h"
+#include "libqtest.h"
+#include "sysemu/qtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/qgraph_internal.h"
+#include "libqos/qos_external.h"
+#include "qapi/qapi-commands-machine.h"
+#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-qom.h"
+#include <wordexp.h>
+#include "sysemu/sysemu.h"
+#include "sysemu/cpus.h"
+
+
+
+/*
+ * Replaced the qmp commands with direct qmp_marshal calls.
+ * Probably there is a better way to do this
+ */
+void qos_set_machines_devices_available(void)
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
+
+void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
+{
+    return allocate_objects(qts, current_path + 1, p_alloc);
+}
+
+
+char **fuzz_path_vec;
+void *qos_obj;
+QGuestAllocator *qos_alloc;
+
+int qos_argc;
+char **qos_argv;
+
+void qos_build_main_args()
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
+
+    /* Prepend the arguments that we need */
+    g_string_prepend(cmd_line,
+            "qemu-system-i386 -display none -machine accel=3Dfuzz -m 16 ")=
;
+    wordexp_t result;
+    wordexp(cmd_line->str, &result, 0);
+    qos_argc =3D result.we_wordc;
+    qos_argv =3D result.we_wordv;
+
+    g_string_free(cmd_line, true);
+}
+
+/*
+ * This function is largely a copy of qos-test.c:
+ * TODO: Possibly add a callback argument to walk_path to use one function
+ * for both fuzzing and normal testing
+ */
+void walk_path(QOSGraphNode *orig_path, int len)
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
+    if (strcmp(test_name, fuzz_target->name->str) =3D=3D 0) {
+        /*
+         * put arch/machine in position 1 so run_one_test can do its work
+         * and add the command line at position 0.
+         */
+        path_vec[1] =3D path_vec[0];
+        path_vec[0] =3D g_string_free(cmd_line, false);
+        printf("path_str: %s path_vec[0]: %s [1]: %s\n", path_str, path_ve=
c[0],
+                path_vec[1]);
+
+        fuzz_path_vec =3D path_vec;
+    } else {
+        g_free(path_vec);
+    }
+
+    g_free(path_str);
+}
diff --git a/tests/fuzz/qos_helpers.h b/tests/fuzz/qos_helpers.h
new file mode 100644
index 0000000000..baf9b49e9c
--- /dev/null
+++ b/tests/fuzz/qos_helpers.h
@@ -0,0 +1,17 @@
+#ifndef QOS_HELPERS_H
+#define QOS_HELPERS_H
+
+#include "qemu/osdep.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qstring.h"
+#include "libqtest.h"
+#include "qapi/qmp/qlist.h"
+#include "libqos/qgraph_internal.h"
+
+
+void qos_set_machines_devices_available(void);
+void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p_a=
lloc);
+void walk_path(QOSGraphNode *orig_path, int len);
+void qos_build_main_args(void);
+#endif
--=20
2.20.1


