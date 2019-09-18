Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B48AC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D6C218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="6GPZrRNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D6C218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAja8-0005Ti-5n
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEd-0000Sa-QC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEb-0002b3-Jf
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:43 -0400
Received: from mail-eopbgr700132.outbound.protection.outlook.com
 ([40.107.70.132]:29345 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEb-0002aR-8h
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQnnJGHWM8AkQT47FzzVvfHwdFDRci21096smhJjxDF3R9r8n6yacatHp1hoI0LKafXNZgWBxdFxXpXMphHNKTU+BBTStr7gMd6GeJe7ivelmqZeno4vqvrvEtMDHJ8NkOoqNZPsVguP4Y8m7ZtPDzaaMfYJ4ROyp1KJD02R7e2D0PEAWRoQ0kD3HKctc+X2HgFsPw+YwcBVnOnvSm3q8DdzUinX/zXYhwCgVEqG+daal8jJQQtrB2foox4UAhrJVSsMGXCD5obWTjv5nDKX9jNnXRl52ZEHW2xSZchTMzorV3arZa7YW0W2QoC26YeuRP+h8yGBAvYBye6hnQKZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V202iJQp77pChCocg07QgPebNBz9532Mcc0r1oChQpw=;
 b=WDakjJGaHmYiw3GL7TPOcJ34kimNO4LL7q+dBT9j0PrZqR9+v8WPX8Rb3bJThBuDOSiGOyphxaQR6oGDHY0djpD2HKqzCE4vcydPAzK2PFZywdju0X1J9eubSfxxidjcgCpvdmDo3kBxpuomAl3IKl4uQ470qX89W3QAjd0UkZIpUXWTh53iny8Z54g+fRerZ2W7MBodxBB3sHUh3quEdkgJ833g3BxafWuoxB8AO+qBnrmucXqFAQY//z3HHJicLufxLokF0iyVpJzatrNrUUX+syamhyTwsurw5KTL6zi2I0rWRdIDBamqCG1jAvErXnLHiqvS3qZmHCmTeOG2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V202iJQp77pChCocg07QgPebNBz9532Mcc0r1oChQpw=;
 b=6GPZrRNHWD3CaxbQPEsaVfsk57u04gJTxFkVIOYmE+//bJvApZ6bOIsnYy+hSs60XCrzWIm7zs/yzZc7m56LL0dV6jqcRmrufHR8ZViM32Fdq5yslNa4zOgYj/6ATrzywtg3yGbQkkAdUSqmUGjxw0ETTCtwkGItWA0g790tQHw=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:39 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:39 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 12/22] libqos: move useful qos-test funcs to
 qos_external
Thread-Index: AQHVbneLLqfcLBcduEiaVsWLhAfCLQ==
Date: Wed, 18 Sep 2019 23:19:39 +0000
Message-ID: <20190918231846.22538-13-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 313c0602-24cf-41d5-7c4f-08d73c8eadb6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB30165587E2273D5AF6DE3132BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(14444005)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(30864003)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GsTuX2PKo39tKF55JvfRRZ1XOeLOOMsMRWhXdLMHYkPDw+qEImk4rwj+HeQIpu12JLjCHkNES17YB6n/EgGBkFtuIyFwyUcR6byYKEerkW3nOWc9aRP0vtUQp3cW43tSFQbdDbic/SBlgsjT5vQCon1zaUd6zkvINQ0yASeXgTLtnizJaQZEceviA0xnJVALtBB+A2y8hMbn+5NkgRf0UaNd8SxTuF8pmXeIcWz8raDmjjNt23vt5J8Zm9FJul+r8UdEDRWNp457Ve99+EkXWBWNpzeD9T3/BHHgYaeb0yix5tgfAkUcZ9UIneNOnYoQijep8/fb5KwAhEEGI/+eqx7MOEjlViZ5QDkU6SsuC5Aw6wL+X4003lzeal0aMK0264QLQuZ32qJXoEGe8DXka+C66Y9LfFIs1rbhRkh69rQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 313c0602-24cf-41d5-7c4f-08d73c8eadb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:39.5304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e198AlPuVHnsEdSmefjJ7okoON9Ekwn3f3N028KcIsIc//9USTdCnenfjq7YSXEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.132
Subject: [Qemu-devel] [PATCH v3 12/22] libqos: move useful qos-test funcs to
 qos_external
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

The moved functions are not specific to qos-test and might be useful
elsewhere. For example the virtual-device fuzzer makes use of them for
qos-assisted fuzz-targets.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/Makefile.include      |   1 +
 tests/libqos/qos_external.c | 151 ++++++++++++++++++++++++++++++++++++
 tests/libqos/qos_external.h |  10 +++
 tests/qos-test.c            | 140 ++-------------------------------
 4 files changed, 167 insertions(+), 135 deletions(-)
 create mode 100644 tests/libqos/qos_external.c
 create mode 100644 tests/libqos/qos_external.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index da665ca7eb..5d4d12503a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -703,6 +703,7 @@ libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-=
obj-y) tests/libqos/usb.o
 libqos-obj-y =3D $(libqos-core-obj-y)
 libqos-obj-y +=3D $(libqgraph-obj-y)
 libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+libqos-obj-y +=3D tests/libqos/qos_external.o
 libqos-obj-y +=3D tests/libqos/e1000e.o
 libqos-obj-y +=3D tests/libqos/i2c.o
 libqos-obj-y +=3D tests/libqos/i2c-imx.o
diff --git a/tests/libqos/qos_external.c b/tests/libqos/qos_external.c
new file mode 100644
index 0000000000..81d1a50c8c
--- /dev/null
+++ b/tests/libqos/qos_external.c
@@ -0,0 +1,151 @@
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
+
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
index 0000000000..1c5bbae814
--- /dev/null
+++ b/tests/libqos/qos_external.h
@@ -0,0 +1,10 @@
+#ifndef QOS_EXTERNAL_H
+#define QOS_EXTERNAL_H
+#include "libqos/qgraph.h"
+
+void apply_to_node(const char *name, bool is_machine, bool is_abstract);
+void apply_to_qlist(QList *list, bool is_machine);
+QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
+void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p_a=
lloc);
+
+#endif
diff --git a/tests/qos-test.c b/tests/qos-test.c
index fd70d73ea5..9d02b83e24 100644
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
@@ -239,14 +109,14 @@ static void *allocate_objects(QTestState *qts, char *=
*path, QGuestAllocator **p_
  */
 static char **current_path;
=20
-const char *qos_get_current_command_line(void)
+void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
 {
-    return current_path[0];
+    return allocate_objects(qts, current_path + 1, p_alloc);
 }
=20
-void *qos_allocate_objects(QTestState *qts, QGuestAllocator **p_alloc)
+const char *qos_get_current_command_line(void)
 {
-    return allocate_objects(qts, current_path + 1, p_alloc);
+    return current_path[0];
 }
=20
 /**
--=20
2.23.0


