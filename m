Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7720BC76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F85022AED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0zt0/Keg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F85022AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUNb-0000zB-Ha
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1hqUMC-0003xZ-4Y
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1hqUMA-0001oG-8R
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:52 -0400
Received: from mail-eopbgr810120.outbound.protection.outlook.com
 ([40.107.81.120]:6127 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1hqUMA-0001mt-1R
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:23:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVQBxMyzYDvd0s/TSDtS+4b4Vf0SaDDhJVUisdy+npjSHFleIEbx6LAo7rKKdjnibqwrP5N2OGHKabRlQCAnqMZpFeNMgMzyhz7p8v1qa+B0oroz1REYRvQ7O6H3N53IDeLUnOIvNTB+oSHlmlXkCBIw5gNeJ+XOKntMwpqSvLfEjzvmrRnvumYEnXPgIKqzRhnj3BqIZcmZVLNkcWEh9scA3ziqMquQHndDPzGdmKNnoK6c6mvnZFHZ/SOZrPhzGgzytbdJyKu/XqF5sh5LvEJKdsX5mI3z/kIvD5YWOylmL1CBboqf8yN2GjgYuRbMoRXd1COHgR6473hG63nWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgidbaewQfCf2H4YUDCcF3On0/PUCSa44DgV7VJV9BE=;
 b=SUAySksbIecas85pErVSeL43BJ6ep2cgnRV0vwGK10vb0WXaTp+8XCUC/GH1Cn5X6Tceo8T1yzcswIlRGxssT02dW7VsRIPEbd2BR32zxhbUg4qO92CAtjo0K7hSAbVAUAi0nop2idGX1SYJNhNFal2M74e2E7djrs63/eXss/B8NCfjaiVy5xQSTZfTIX5843JIWHyMc3SQXMuBR92p8I5NqfQgPKXiVK+vjW27aZxyyP4QajvBwP6n1JLnoGWwzO7nDZB9cokqlDpRh9KTDN5dfD5oJqjgQb6r4J7zrLPgreV9N22rzT6GpTM1d+VGTad8xN3U8SYYLPdoy+iong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgidbaewQfCf2H4YUDCcF3On0/PUCSa44DgV7VJV9BE=;
 b=0zt0/KegQTmCyt5mBYpaEnYb9LBnhQlEpxafvjb1wGHZjvUF+rEu9OjQnVon3G+RrumBNbFz9XautKFXWrty5vX+BktcmLD3ISsLy7dvDHiJbzWumUyJdUOJm9rlYSOzELAf4ffFSZZ+uLeEXBq0Td80AgnhrY/cjkKYly/tig0=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2726.namprd03.prod.outlook.com (10.173.40.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 03:23:47 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::25e1:d1e3:2ad8:e6b5%5]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 03:23:47 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC 04/19] fuzz: Add qos support to fuzz targets
Thread-Index: AQHVQpheQ2EbGD7lCUGbe2mab4yRYA==
Date: Thu, 25 Jul 2019 03:23:47 +0000
Message-ID: <20190725032321.12721-5-alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35f78d3a-b0d9-4409-f2b9-08d710af814b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2726; 
x-ms-traffictypediagnostic: CY4PR03MB2726:
x-microsoft-antispam-prvs: <CY4PR03MB2726CEED7B58E771CD1F1FE3BAC10@CY4PR03MB2726.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(3846002)(53936002)(6512007)(14454004)(66066001)(5660300002)(6116002)(25786009)(68736007)(316002)(99286004)(54906003)(1076003)(2351001)(2501003)(2616005)(75432002)(7736002)(76176011)(52116002)(305945005)(14444005)(6436002)(71200400001)(6506007)(26005)(6916009)(478600001)(8936002)(5640700003)(786003)(86362001)(4326008)(256004)(88552002)(71190400001)(386003)(2906002)(476003)(66946007)(446003)(11346002)(8676002)(81156014)(81166006)(66476007)(66446008)(30864003)(36756003)(6486002)(66556008)(64756008)(486006)(186003)(102836004)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2726;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GKgi+F8gPsjTU0ktLL97NBwkGpEhsIGiUgfWxVMhT0jJi20mhn4p6mPnHOv/BhX0Iwk/TZDj1/KoY2qDQjL+51/MZ4mje0y/HLYcyIGEtHy6GnE5kGMemO/mPmqzkznrrVXtJjlawJ/imPYHYWZ+8u9TWbKxbinBZ4X/33vnQfLmENlogTYR/iFGd3jsxqXe7NB9HoC2Mf45mnb2Rd4iUMtU2haKWpwv9yqH8Dbi4fJRH1BvzkauKNz+zrcpTBNuS1Ptn+o88u+Uzasy6fXy/8+1s+O+2s9r6xe0nVGHbxDNh6kYqp4R5cHMcwsgGm/76i7L3e15CyjyA7XhDIEHfJbLRX8nQjJRlba1EBW4vembx3yOO/6OHlkZMTQNYfOSspa7qg6wM2vyIpm+PYm9jR2iavsxKxzuiEGDdNxv7/s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f78d3a-b0d9-4409-f2b9-08d710af814b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 03:23:47.3352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2726
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.120
Subject: [Qemu-devel] [RFC 04/19] fuzz: Add qos support to fuzz targets
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
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qos_helpers.c is largely a copy of tests/qos-test.c

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/fuzz/qos_fuzz.c    |  63 +++++++++
 tests/fuzz/qos_fuzz.h    |  29 ++++
 tests/fuzz/qos_helpers.c | 295 +++++++++++++++++++++++++++++++++++++++
 tests/fuzz/qos_helpers.h |  17 +++
 4 files changed, 404 insertions(+)
 create mode 100644 tests/fuzz/qos_fuzz.c
 create mode 100644 tests/fuzz/qos_fuzz.h
 create mode 100644 tests/fuzz/qos_helpers.c
 create mode 100644 tests/fuzz/qos_helpers.h

diff --git a/tests/fuzz/qos_fuzz.c b/tests/fuzz/qos_fuzz.c
new file mode 100644
index 0000000000..ac7bb735ac
--- /dev/null
+++ b/tests/fuzz/qos_fuzz.c
@@ -0,0 +1,63 @@
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
+uint64_t total_io_mem =3D 0;
+uint64_t total_ram_mem =3D 0;
+
+
+//TODO: Put arguments in a neater struct
+void fuzz_add_qos_target(const char* name,
+		const char* description,
+		const char* interface,
+		QOSGraphTestOptions* opts,
+		void(*init_pre_main)(void),
+		void(*init_pre_save)(void),
+		void(*save_state)(void),
+		void(*reset)(void),
+		void(*pre_fuzz)(void),
+		void(*fuzz)(const unsigned char*, size_t),
+		void(*post_fuzz)(void))
+{
+	qos_add_test(name, interface, NULL, opts);
+	fuzz_add_target(name, description, init_pre_main, init_pre_save,
+			save_state, reset, pre_fuzz, fuzz, post_fuzz, &qos_argc, &qos_argv);
+}
+
+
+// Do what is normally done in qos_test.c:main
+void qos_setup(void){
+	qtest_setup();
+	qos_set_machines_devices_available();
+	qos_graph_foreach_test_path(walk_path);
+	qos_build_main_args();
+}
+
+void qos_init_path(void)
+{
+	qos_obj =3D qos_allocate_objects(global_qtest, &qos_alloc);
+}
diff --git a/tests/fuzz/qos_fuzz.h b/tests/fuzz/qos_fuzz.h
new file mode 100644
index 0000000000..098f81f570
--- /dev/null
+++ b/tests/fuzz/qos_fuzz.h
@@ -0,0 +1,29 @@
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
+extern void* qos_obj;
+extern QGuestAllocator *qos_alloc;
+
+
+void fuzz_add_qos_target(const char* name,
+		const char* description,
+		const char* interface,
+		QOSGraphTestOptions* opts,
+		void(*init_pre_main)(void),
+		void(*init_pre_save)(void),
+		void(*save_state)(void),
+		void(*reset)(void),
+		void(*pre_fuzz)(void),
+		void(*fuzz)(const unsigned char*, size_t),
+		void(*post_fuzz)(void));
+
+void qos_init_path(void);
+#endif
diff --git a/tests/fuzz/qos_helpers.c b/tests/fuzz/qos_helpers.c
new file mode 100644
index 0000000000..79523c0552
--- /dev/null
+++ b/tests/fuzz/qos_helpers.c
@@ -0,0 +1,295 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qos_helpers.h"
+#include "fuzz.h"
+#include "qapi/qmp/qlist.h"
+#include "libqtest.h"
+#include "sysemu/qtest.h"
+#include "libqos/qgraph.h"
+#include "libqos/qgraph_internal.h"
+#include "./qapi/qapi-commands-machine.h"
+#include "./qapi/qapi-commands-misc.h"
+#include "./qapi/qapi-commands-qom.h"
+#include <wordexp.h>
+#include "sysemu/sysemu.h"
+#include "sysemu/cpus.h"
+
+
+/*=20
+ * This file is almost completely copied from tests/qos-test.c
+ * TODO: Find a way to re-use the code in tests/qos-test.c
+ */
+
+static void apply_to_node(const char *name, bool is_machine, bool is_abstr=
act)
+{
+    char *machine_name =3D NULL;
+    if (is_machine) {
+        const char *arch =3D qtest_get_arch();
+        machine_name =3D g_strconcat(arch, "/", name, NULL);
+        name =3D machine_name;
+    }
+    qos_graph_node_set_availability(name, true);
+    if (is_abstract) {
+        qos_delete_cmd_line(name);
+    }
+    g_free(machine_name);
+}
+
+static void apply_to_qlist(QList *list, bool is_machine)
+{
+    const QListEntry *p;
+    const char *name;
+    bool abstract;
+    QDict *minfo;
+    QObject *qobj;
+    QString *qstr;
+    QBool *qbool;
+
+    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
+        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
+        qobj =3D qdict_get(minfo, "name");
+        qstr =3D qobject_to(QString, qobj);
+        name =3D qstring_get_str(qstr);
+
+        qobj =3D qdict_get(minfo, "abstract");
+        if (qobj) {
+            qbool =3D qobject_to(QBool, qobj);
+            abstract =3D qbool_get_bool(qbool);
+        } else {
+            abstract =3D false;
+        }
+
+        apply_to_node(name, is_machine, abstract);
+        qobj =3D qdict_get(minfo, "alias");
+        if (qobj) {
+            qstr =3D qobject_to(QString, qobj);
+            name =3D qstring_get_str(qstr);
+            apply_to_node(name, is_machine, abstract);
+        }
+    }
+}
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
+    Error *err =3DNULL;=20
+
+    qmp_marshal_query_machines(NULL,&response, &err);
+    assert(!err);
+    lst =3D qobject_to(QList, response);
+    apply_to_qlist(lst, true);
+
+    qobject_unref(response);
+
+
+    qdict_put_str(req, "execute", "qom-list-types" );
+    qdict_put_str(args, "implements", "device" );
+    qdict_put_bool(args, "abstract", true);
+    qdict_put_obj(req, "arguments", (QObject*) args);
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
+static QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
+{
+    return obj->get_driver(obj, "memory");
+}
+
+void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
+{
+    return allocate_objects(qts, current_path + 1, p_alloc);
+}
+
+void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p_a=
lloc)
+{
+    int current =3D 0;
+    QGuestAllocator *alloc;
+    QOSGraphObject *parent =3D NULL;
+    QOSGraphEdge *edge;
+    QOSGraphNode *node;
+    void *edge_arg;
+    void *obj;
+
+    node =3D qos_graph_get_node(path[current]);
+    g_assert(node->type =3D=3D QNODE_MACHINE);
+
+    obj =3D qos_machine_new(node, qts);
+    qos_object_queue_destroy(obj);
+
+    alloc =3D get_machine_allocator(obj);
+    if (p_alloc) {
+        *p_alloc =3D alloc;
+    }
+
+    for (;;) {
+        if (node->type !=3D QNODE_INTERFACE) {
+            qos_object_start_hw(obj);
+            parent =3D obj;
+        }
+
+        /* follow edge and get object for next node constructor */
+        current++;
+        edge =3D qos_graph_get_edge(path[current - 1], path[current]);
+        node =3D qos_graph_get_node(path[current]);
+
+        if (node->type =3D=3D QNODE_TEST) {
+            g_assert(qos_graph_edge_get_type(edge) =3D=3D QEDGE_CONSUMED_B=
Y);
+            return obj;
+        }
+
+        switch (qos_graph_edge_get_type(edge)) {
+            case QEDGE_PRODUCES:
+                obj =3D parent->get_driver(parent, path[current]);
+                break;
+
+            case QEDGE_CONSUMED_BY:
+                edge_arg =3D qos_graph_edge_get_arg(edge);
+                obj =3D qos_driver_new(node, obj, alloc, edge_arg);
+                qos_object_queue_destroy(obj);
+                break;
+
+            case QEDGE_CONTAINS:
+                obj =3D parent->get_device(parent, path[current]);
+                break;
+        }
+    }
+}
+
+char **fuzz_path_vec;
+void* qos_obj;
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
+    g_string_prepend(cmd_line, "qemu-system-i386 -display none -machine ac=
cel=3Dfuzz -m 3 ");
+    wordexp_t result;
+    wordexp (cmd_line->str, &result, 0);
+    qos_argc =3D result.we_wordc;
+    qos_argv =3D result.we_wordv;
+
+    g_string_free(cmd_line, true);
+}
+
+
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
+    /* here position 0 has <arch>/<machine>, position 1 has <machine>.
+     * The path must not have the <arch>, qtest_add_data_func adds it.
+     */
+    path_str =3D g_strjoinv("/", path_vec + 1);
+
+    // Check that this is the test we care about:
+    char *test_name =3D strrchr(path_str, '/')+1;
+    if(strcmp(test_name, fuzz_target->name->str) =3D=3D 0)
+    {
+        /* put arch/machine in position 1 so run_one_test can do its work
+         * and add the command line at position 0.
+         */
+        path_vec[1] =3D path_vec[0];
+        path_vec[0] =3D g_string_free(cmd_line, false);
+        printf("path_str: %s path_vec[0]: %s [1]: %s\n", path_str, path_ve=
c[0], path_vec[1]);
+
+        fuzz_path_vec =3D path_vec;
+    }=20
+    else {
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


