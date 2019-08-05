Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BD3C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1F7205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="3fT1Cs1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1F7205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXFe-00082s-W6
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9H-0003WG-Pa
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX9G-00021w-1F
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:15 -0400
Received: from mail-eopbgr680093.outbound.protection.outlook.com
 ([40.107.68.93]:54470 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX9F-00021Y-R4
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIeMOk8x1Ks+MxZ708fMOYGdKlfuJaLQvk+ljScoXqq7mGmVTMDgrjtdALJfqpNqWiBQkDs3obALQ+T6bRPx/zh70I8uMyXAS9Q5/ZYCsgTEWOHbGCjf+H6aE+iTznj1NFAGSkTt00MvUD/xlVQHQDddck3go5J77OHRQ9GlARku/NMl5M0DMVJChpinSsQgOnL30vrH9G8wX5vZ/ntFFXFmwaVjC1SYbMa0agDQc+QJ7607ZZpYbFqMaQIn7QEGuIf++QwH+6WhwSAv3ClKiy+cchTAsWUs5pJT8vdvum7WsFduKrrmUWyoW6R9JMnwdDmVvb5MUSKybBkGlayBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwRJgavehGKXUt8uKVg0r+N07Q0H+kzWRsieiYbkis4=;
 b=FkVvBMUFLauQKCkBi3Kvh1ssNK1yGJoodRIWL5YxjCsNGGEOLcnx8t8m51NKpDV4cfGPfWl6ebnLzT/kUWBA4RGeqCpY/x5j0ckwdvKS8qKwljDsr1qMBP5OrqDiezf6n6j22dQMiaH7bBYkmmRxiWdOBd6CVY2qEKOi8FIu9QG0pCA01I3szW/B90ARW0OcWjYQVb1nidxv82HQnjXXqYSO63gEX6Adt6EZH3utgFU86uaDtQIc6KA/FHy6c1yGQ1LtB0XWh62F8HGFmtzIwL0IITYQuW4p1Hiralmyv/MBF2llL17qHZuC1pOysAlUF0c5EL7tNMUAomFnyVgQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwRJgavehGKXUt8uKVg0r+N07Q0H+kzWRsieiYbkis4=;
 b=3fT1Cs1zYQq9r7hXx9H8r7nMT3gieQ9rM++MB4efUbGcyqx6/k7AqEDh6Hg6M+j0FN0eHbINyTnaz3mjgAjAihP4n0wGUxL3WWB6tfzSM/Ow1sgzJRI7YNzxsxFQFR23HsKbZsutIphlTO1XdOP4Bbw38mTHRcCM+iFMONoI9Xo=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:12 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:12 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 11/17] fuzz: Move useful qos functions to separate
 object
Thread-Index: AQHVS1z24ZEN+4y54k+XnPyH7IyGRA==
Date: Mon, 5 Aug 2019 07:11:12 +0000
Message-ID: <20190805071038.32146-12-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 077aaf98-e1e0-49f3-920c-08d719741908
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB2646DC03A787538BED5EA65EBADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(14444005)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JrShOd2R0Z5FiWolVlbM07SZqx2EAIURhrlC63sBeimugMFD51G9dSv3UcVvsikhzqcGxuFcpoRddCaN8p1lBFcDBq4e8mDhdYm9HvT4nKFAbdVoBQvFSetdh6/vM7QSzsp7Zz/qUldCQQv+QI4KIOme8zgej6uR1DVX3OHZuU0N4x3uEi9eiQ0u9fX42v7yS5+72UQUgdakX2xCWoVgrJakPIvzQFkwVFwuiORxYepS5RoeUM0lqCt70Xl78jBMoj8S7AUOt3uXZYNb8GMy2hi7hua3oFV8bbes44hIne/ysbg77WbGUtYjc0DJCsqu6/ZGmj/xpXmH2tlRQjrHK4UigOihHa32eZ6iU257teB6Np9pDa/n4/kIdkwQaYwjD5LdF836GgYQabxJvLaIO8UIOhe6o23xLmXkAu0fW1I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 077aaf98-e1e0-49f3-920c-08d719741908
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:12.5856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.93
Subject: [Qemu-devel] [RFC PATCH v2 11/17] fuzz: Move useful qos functions
 to separate object
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
 "Oleinik, Alexander" <alxndr@bu.edu>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions are used by both qos-test.c, and the fuzzer.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/libqos/qos_external.c | 149 ++++++++++++++++++++++++++++++++++++
 tests/libqos/qos_external.h |   8 ++
 tests/qos-test.c            | 132 +-------------------------------
 3 files changed, 158 insertions(+), 131 deletions(-)
 create mode 100644 tests/libqos/qos_external.c
 create mode 100644 tests/libqos/qos_external.h

diff --git a/tests/libqos/qos_external.c b/tests/libqos/qos_external.c
new file mode 100644
index 0000000000..987123b5cb
--- /dev/null
+++ b/tests/libqos/qos_external.c
@@ -0,0 +1,149 @@
+
+#include "qemu/osdep.h"
+#include <getopt.h>
+#include "libqtest.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qstring.h"
+#include "qemu/module.h"
+#include "qapi/qmp/qlist.h"
+#include "libqos/malloc.h"
+#include "libqos/qgraph.h"
+#include "libqos/qgraph_internal.h"
+#include "libqos/qos_external.h"
+
+void apply_to_node(const char *name, bool is_machine, bool is_abstract)
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
+/**
+ * apply_to_qlist(): using QMP queries QEMU for a list of
+ * machines and devices available, and sets the respective node
+ * as true. If a node is found, also all its produced and contained
+ * child are marked available.
+ *
+ * See qos_graph_node_set_availability() for more info
+ */
+void apply_to_qlist(QList *list, bool is_machine)
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
+QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
+{
+    return obj->get_driver(obj, "memory");
+}
+
+/**
+ * allocate_objects(): given an array of nodes @arg,
+ * walks the path invoking all constructors and
+ * passing the corresponding parameter in order to
+ * continue the objects allocation.
+ * Once the test is reached, return the object it consumes.
+ *
+ * Since the machine and QEDGE_CONSUMED_BY nodes allocate
+ * memory in the constructor, g_test_queue_destroy is used so
+ * that after execution they can be safely free'd.  (The test's
+ * ->before callback is also welcome to use g_test_queue_destroy).
+ *
+ * Note: as specified in walk_path() too, @arg is an array of
+ * char *, where arg[0] is a pointer to the command line
+ * string that will be used to properly start QEMU when executing
+ * the test, and the remaining elements represent the actual objects
+ * that will be allocated.
+ */
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
+        case QEDGE_PRODUCES:
+            obj =3D parent->get_driver(parent, path[current]);
+            break;
+
+        case QEDGE_CONSUMED_BY:
+            edge_arg =3D qos_graph_edge_get_arg(edge);
+            obj =3D qos_driver_new(node, obj, alloc, edge_arg);
+            qos_object_queue_destroy(obj);
+            break;
+
+        case QEDGE_CONTAINS:
+            obj =3D parent->get_device(parent, path[current]);
+            break;
+        }
+    }
+}
+
diff --git a/tests/libqos/qos_external.h b/tests/libqos/qos_external.h
new file mode 100644
index 0000000000..bf3b308501
--- /dev/null
+++ b/tests/libqos/qos_external.h
@@ -0,0 +1,8 @@
+#ifndef QOS_EXTERNAL_H
+#define QOS_EXTERNAL_H
+
+void apply_to_node(const char *name, bool is_machine, bool is_abstract);
+void apply_to_qlist(QList *list, bool is_machine);
+QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
+void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p_a=
lloc);
+#endif
diff --git a/tests/qos-test.c b/tests/qos-test.c
index 3c0071b3b7..c5fa7ff586 100644
--- a/tests/qos-test.c
+++ b/tests/qos-test.c
@@ -27,65 +27,11 @@
 #include "libqos/malloc.h"
 #include "libqos/qgraph.h"
 #include "libqos/qgraph_internal.h"
+#include "libqos/qos_external.h"
=20
 static char *old_path;
=20
-static void apply_to_node(const char *name, bool is_machine, bool is_abstr=
act)
-{
-    char *machine_name =3D NULL;
-    if (is_machine) {
-        const char *arch =3D qtest_get_arch();
-        machine_name =3D g_strconcat(arch, "/", name, NULL);
-        name =3D machine_name;
-    }
-    qos_graph_node_set_availability(name, true);
-    if (is_abstract) {
-        qos_delete_cmd_line(name);
-    }
-    g_free(machine_name);
-}
=20
-/**
- * apply_to_qlist(): using QMP queries QEMU for a list of
- * machines and devices available, and sets the respective node
- * as true. If a node is found, also all its produced and contained
- * child are marked available.
- *
- * See qos_graph_node_set_availability() for more info
- */
-static void apply_to_qlist(QList *list, bool is_machine)
-{
-    const QListEntry *p;
-    const char *name;
-    bool abstract;
-    QDict *minfo;
-    QObject *qobj;
-    QString *qstr;
-    QBool *qbool;
-
-    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
-        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
-        qobj =3D qdict_get(minfo, "name");
-        qstr =3D qobject_to(QString, qobj);
-        name =3D qstring_get_str(qstr);
-
-        qobj =3D qdict_get(minfo, "abstract");
-        if (qobj) {
-            qbool =3D qobject_to(QBool, qobj);
-            abstract =3D qbool_get_bool(qbool);
-        } else {
-            abstract =3D false;
-        }
-
-        apply_to_node(name, is_machine, abstract);
-        qobj =3D qdict_get(minfo, "alias");
-        if (qobj) {
-            qstr =3D qobject_to(QString, qobj);
-            name =3D qstring_get_str(qstr);
-            apply_to_node(name, is_machine, abstract);
-        }
-    }
-}
=20
 /**
  * qos_set_machines_devices_available(): sets availability of qgraph
@@ -129,10 +75,6 @@ static void qos_set_machines_devices_available(void)
     qobject_unref(response);
 }
=20
-static QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
-{
-    return obj->get_driver(obj, "memory");
-}
=20
 static void restart_qemu_or_continue(char *path)
 {
@@ -159,78 +101,6 @@ void qos_invalidate_command_line(void)
     old_path =3D NULL;
 }
=20
-/**
- * allocate_objects(): given an array of nodes @arg,
- * walks the path invoking all constructors and
- * passing the corresponding parameter in order to
- * continue the objects allocation.
- * Once the test is reached, return the object it consumes.
- *
- * Since the machine and QEDGE_CONSUMED_BY nodes allocate
- * memory in the constructor, g_test_queue_destroy is used so
- * that after execution they can be safely free'd.  (The test's
- * ->before callback is also welcome to use g_test_queue_destroy).
- *
- * Note: as specified in walk_path() too, @arg is an array of
- * char *, where arg[0] is a pointer to the command line
- * string that will be used to properly start QEMU when executing
- * the test, and the remaining elements represent the actual objects
- * that will be allocated.
- */
-static void *allocate_objects(QTestState *qts, char **path, QGuestAllocato=
r **p_alloc)
-{
-    int current =3D 0;
-    QGuestAllocator *alloc;
-    QOSGraphObject *parent =3D NULL;
-    QOSGraphEdge *edge;
-    QOSGraphNode *node;
-    void *edge_arg;
-    void *obj;
-
-    node =3D qos_graph_get_node(path[current]);
-    g_assert(node->type =3D=3D QNODE_MACHINE);
-
-    obj =3D qos_machine_new(node, qts);
-    qos_object_queue_destroy(obj);
-
-    alloc =3D get_machine_allocator(obj);
-    if (p_alloc) {
-        *p_alloc =3D alloc;
-    }
-
-    for (;;) {
-        if (node->type !=3D QNODE_INTERFACE) {
-            qos_object_start_hw(obj);
-            parent =3D obj;
-        }
-
-        /* follow edge and get object for next node constructor */
-        current++;
-        edge =3D qos_graph_get_edge(path[current - 1], path[current]);
-        node =3D qos_graph_get_node(path[current]);
-
-        if (node->type =3D=3D QNODE_TEST) {
-            g_assert(qos_graph_edge_get_type(edge) =3D=3D QEDGE_CONSUMED_B=
Y);
-            return obj;
-        }
-
-        switch (qos_graph_edge_get_type(edge)) {
-        case QEDGE_PRODUCES:
-            obj =3D parent->get_driver(parent, path[current]);
-            break;
-
-        case QEDGE_CONSUMED_BY:
-            edge_arg =3D qos_graph_edge_get_arg(edge);
-            obj =3D qos_driver_new(node, obj, alloc, edge_arg);
-            qos_object_queue_destroy(obj);
-            break;
-
-        case QEDGE_CONTAINS:
-            obj =3D parent->get_device(parent, path[current]);
-            break;
-        }
-    }
-}
=20
 /* The argument to run_one_test, which is the test function that is regist=
ered
  * with GTest, is a vector of strings.  The first item is the initial comm=
and
--=20
2.20.1


