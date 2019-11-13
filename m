Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CE8C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9199E206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="p2En2H2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9199E206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1iS-0005sP-OE
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TS-00084x-32
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-0007g3-7t
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from mail-dm3nam03on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::72d]:36592
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007S1-VL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcPlX708d1A3Ee1BsnaSdU8MFZXt7AC9GnUGV9JOWXP4rKQCzhU5x7g+SfHwFYMbiiXiw6UNMATkJaWD6o/2bA6X3gj9/uKk1kgwxiafDBBj/KX54OZX6zaJTc2v4JdpGeG6X9pqD6L3a/JT2V2bPXLnmlJKjELaWrHUcIssn5GxAt7IWaHIhxKD85op2reQFtLqjFCKvhW+nJ8swUbaFpi8/jD1E3LF97bG2+jEOIuB19MA2JpHXTFVv6e7tbL8MJNzdntprIB2DD3fS7n88sxDOOMYkmxEOpy5ipCnsZQMoT/gOpxKWd3pPhMAHXTxeTe1AdeE64gMEaIMffkx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U1PC3qI1lwJQUGzoD3QVQW4zmZuUTXMrTLtqM1G0X4=;
 b=M3ilfnFMTWQ5G4zjyy5ibiDJKpgk1VTbTwQYpBGaIM6Hpkl27MMtLm25o+q3gfjkx6q/WxZ/gyO1E0rJoU7ogkeO+1u5SQUi66pQiwhGlloEwsyuYQsfFRttmrgRzh1Oqlkq1frzZJYXoA31RR6jMO4tdg25YoCsOHpzgDkWMz89l3SKe8HMn6L4RjexyR6K6j1KTcGURVqBnsroKFtp+epixTkmvZWMiPAiSQL7NsN1I4UaUsR7jPZ3tADj8B1d9V2LmmpIoZNUNioSUInOOKM/5SAz6t5di13/HD4IeCe/Ao08fjnvdjb76k/murUC1UnjKrVO3+KqcW7OPzc21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U1PC3qI1lwJQUGzoD3QVQW4zmZuUTXMrTLtqM1G0X4=;
 b=p2En2H2Tt1ncOOW+IVLWB/rl/cHz0ejpM9ZILxgfU8Jm82EdiF4hs41oNfi6k0RQVgVo+3Y8vAiokhnHK6HjYb36lY1dgqswOJb07fWD1iPZMh3YOa+hEUlkOe0BCCn8qJ6NOnwvqsDsAmm0hE+Sjva1dKLWGyDtC+B6yXsweds=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:48 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:48 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 10/20] libqos: move useful qos-test funcs to qos_external
Thread-Topic: [PATCH v5 10/20] libqos: move useful qos-test funcs to
 qos_external
Thread-Index: AQHVmnTKKhcLRd26TUijeYmAsvu8CQ==
Date: Wed, 13 Nov 2019 22:50:47 +0000
Message-ID: <20191113225030.17023-11-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: b1868056-b696-430e-efd4-08d7688beca5
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024795084424EC64E1D83D7BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6306002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(30864003)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OBYqvc9Vv2AlT0e8ygch5uRPaMAkU+Uew7mjJqs99sooxvoVCxTUYLJY8LrgDj5KFS5Sn8JoNZxD8/m9LsIpJGK0MgAnvbmcC1hbxIq3kNsBLSXVF/UvCPCIyEigpOJNNpppqKAMBddlSsCfbU71UfRNR8+lpPIOqD+oSOCJupbZ105pPh64VZntf6JV6ytIff1BcxQXfe6f31jHbFT9ozo4dozY0mp6pF0TIx9vWTsfP5lq8sRYLHQBR4YWIMsFmLgvnLItMw8Otb4aMeonxdgSYNN77iKHg3WJAxHN7f7MMoNVef0IRYnFzSELALEd6sPLM47HACsKgA+it6v4G17MWfx5isYednum+l4Fq/wNoK24CMj+2kdJIuOs2O63ESj0bADTPWOcPqh+9fvkh4CZ0dV5koIzWrLPmjVi2f6Yu1fD1Mz1OH8eHLqaOOp5IyfdqnCrO5a2dIGPU4CY2mTHHcGloKA+66ZdBecWJPY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b1868056-b696-430e-efd4-08d7688beca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:47.9353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzGWbdOutJx4ZP+DFKsLL071rRD0dujq92GKNcgN3JvI1bHVaZoOeYn72g2/wwyf
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
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


