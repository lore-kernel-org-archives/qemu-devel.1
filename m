Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE622CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F49420874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="ODeS/a2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F49420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpZb-0001qs-LO
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIR-00052Y-2n
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIO-0007I4-Hk
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
Received: from mail-eopbgr800135.outbound.protection.outlook.com
 ([40.107.80.135]:59246 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIO-0006yI-BM
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXlayDltMn/kCSydVI+ZUqt0O8UAwO59782LX7tWWORltYKti4VjCpoIt3dICfdnDz3TFwBLLkPrvaFBZJ7RiyQ4t2/TSC+Va/18/aNfACeSN4TEpX/o1vCVH8tCcmLrAO/Q7YieIDcGom5BqaY10v2dY7ZYTZ695gsp/uGrUNRddiLBEsdqS3WyQsPwiUNTd/fxRaSJXwAtgRDT9KkOE5IQ2ooKzIGQufkBUkFXcwT1nXQRmfeTratHbVnJcO92mqbiyjdOdAaZF1Q8qT5jHW/G9vN3JU8AQ3XUYbkshMK+2D4pWMYqko/aGAwl2fXksCatPD+iWdFIEJ9nCi0haA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9T/dDNyviwcPhgBIk7eJ6pidTIJm05I1fA/CvUnnZw=;
 b=cIW+M/dT9IwXjEsldthrVrjFWAixu5CVaMzHSFhMVW3fDHn2w+g57pY2HR90TZZ4MjLArvbwx1qtGs56iANEtI1EbQuMRRUAhwrOUehYx7bLr+Q2/3NG/UYke1bpomjE0DIsxB1IP3aEzu9IY7qagAmX03wEqoRaeCOg7Irz8TDP7axvTJlPRdaXuq8/UGEdHUiBwJyODizWNpV7J0ROMqeXMqaeb51ag9nxkNcoaZbCFLcE4oavB7MHuQD6GBJK4RriSXITuWPpNqAJFHYx2dQLWyDttN1iHIeCLXEP7NmECrGwlTfs/uKbpwxKKeczNua64luufcbX3vuhhFJoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9T/dDNyviwcPhgBIk7eJ6pidTIJm05I1fA/CvUnnZw=;
 b=ODeS/a2JLbCebyEF+D/lH4GlvAFFQk+QGRweAnjqLgyPrZz5CBwyjZyJgnnQdZzfrA14Jz735QD2vip2A9p0cx60F2Cak0RTNwMssMApIKub9kZOvcNuupMUoxvfQdJEKsPQveSxL1sucPbhIPXNTRFFOvfBKsvDysyBEFJvX38=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:56 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:56 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 10/20] libqos: move useful qos-test funcs to qos_external
Thread-Topic: [PATCH v4 10/20] libqos: move useful qos-test funcs to
 qos_external
Thread-Index: AQHVjzFL0KZhv7FtpkGReI4t3z43QQ==
Date: Wed, 30 Oct 2019 14:49:56 +0000
Message-ID: <20191030144926.11873-11-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 1a2a1361-f224-4efc-ee5c-08d75d486e23
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5054B114FD0963424073E419BA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(6306002)(88552002)(386003)(256004)(316002)(14444005)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(11346002)(6506007)(4326008)(54906003)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(446003)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(30864003)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002)(76176011)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sougyyVk1fFYrsjB2YPENHYiB26CBkr7uRTq33tk2Dzoil0jjRrBd9wzNunzSXmqSGHGBUw4jU6frlgEnl6l890i4cSVya26tU4SiYZy30I2u3XUoZRhgdWMrYjcLmunfEeKRgvU7F3TVfecA05/pkk9bW55hEqsNM6inN/ZzcjrX/KHdnrT7Vhgkrt/7o4u7CWUPb05gANbADN1AZltKqN/bgiEJ3vHk4aXQbqemJJZpI7wnwm/S1OGU5Z52DM0wNT/ifHxe0m7jnIlsFlCIJ9FJV0+td1OZ3H2+M4eA5c2SUlwPrqOqO5HhCJU6gnzep1kLtlvXLb84pL2/3JvpyzPzCaSGH8hE1yXbCM41+X3xXJtquWxfUEFwClZhzMEZbC63KgVvkVJMPH//4hf+nbdYASUKBIyB21xSWfdUYNXsqp1Q9Qsvu9MF9tRLAtkhm8OvDhfJvyodH6+Xda7rSJwr9HMefTr32JAyFbdyIA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2a1361-f224-4efc-ee5c-08d75d486e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:56.6019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6GX8AsV8geYhfEomnEfSH41/83n7H2j46NRE+Y5vNNdULO+IJlBpwqbSrtbd2US
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.135
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

The moved functions are not specific to qos-test and might be useful
elsewhere. For example the virtual-device fuzzer makes use of them for
qos-assisted fuzz-targets.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/Makefile.include      |   1 +
 tests/libqos/qos_external.c | 168 ++++++++++++++++++++++++++++++++++++
 tests/libqos/qos_external.h |  28 ++++++
 tests/qos-test.c            | 140 ++----------------------------
 4 files changed, 202 insertions(+), 135 deletions(-)
 create mode 100644 tests/libqos/qos_external.c
 create mode 100644 tests/libqos/qos_external.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1517c4817e..2cccc05ae1 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -714,6 +714,7 @@ libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-=
obj-y) tests/libqos/usb.o
 # Devices
 libqos-obj-y =3D $(libqgraph-obj-y)
 libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+libqos-obj-y +=3D tests/libqos/qos_external.o
 libqos-obj-y +=3D tests/libqos/e1000e.o
 libqos-obj-y +=3D tests/libqos/i2c.o
 libqos-obj-y +=3D tests/libqos/i2c-imx.o
diff --git a/tests/libqos/qos_external.c b/tests/libqos/qos_external.c
new file mode 100644
index 0000000000..398556dde0
--- /dev/null
+++ b/tests/libqos/qos_external.c
@@ -0,0 +1,168 @@
+/*
+ * libqos driver framework
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
index 0000000000..7b44930c55
--- /dev/null
+++ b/tests/libqos/qos_external.h
@@ -0,0 +1,28 @@
+/*
+ * libqos driver framework
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


