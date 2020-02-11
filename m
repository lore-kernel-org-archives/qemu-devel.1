Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4F2C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18D720659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="JGRJvhPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18D720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cLZ-0006pF-SE
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFy-0006Xt-Jt
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFv-0008Lw-Sq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:42 -0500
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com
 ([40.107.243.92]:50848 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFv-0008HE-8J
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPgrVqKKQWO3NUKPJ1kw5mRErVU1K/DSA60/ogtGwl2vZ1g2u3K9/iuSwgxDryt+fA1/e4iQ+SCyHJV9UTpvhKnMVL3ZgQDo8DMU+Ry2pbpF+GanOiVNqKw0ZNhn6Pbd2W+otl9dYlJZ1T2zxN9JDvALsa8HF1uaPV9UYih61hP/1NK86HnYzdJSPl1oRCitdwCNN6wcMJ2fnMMbLxTHu0enF7a2Ys6EWuxOaHXEps3Soz1TavyM3KU9AsXB//SLoC6u8DhxgbgM7kZjnTwzP5Jtwco6AAM1zTOzcjOSRrHlrecTM8q6voW8aci+kevWyy/tKYR/o0NrFcOH82x5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6DjZ5pCytY86TNcPguLvC4URQw1EXIw/v070Xasuh4=;
 b=bWZQQjgk6RdP1o1VzR72Ezr/j3+J2rXnUV2Srjjd2JsHGh/9Vg1tK7PK/BRZDVH1qrrg2YeQrRUOJYn+TpZ4oQ0thNMlvZrpXw3xaMg7xTZr4JteZ1Xl0U8DzOz0QT9Wa35ZI0XFniT1NmSXOL6EtWqIl+juRWVxft/JPLcQdqj1zCkKoJOWbCVO/6mPjoj8EDaOttir3Zey8prZADFHHytrcgTCMhx8AlZkYAfW708L0nC2S3suyq4XeV31o1Zrb0gKXQZHqneYAn74OoTw5lHKo8Bzeo/XVc4lEQhmjsKkzmCrrgTZD3ivWJpttQW29eu7XLkDUH+uCSN2ph0oxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6DjZ5pCytY86TNcPguLvC4URQw1EXIw/v070Xasuh4=;
 b=JGRJvhPwTHSKAJRUUCvxTaMhhHKQiEnnKjQnI+dOsbl/EnEw/nV2x/Upub6NBPSKzgbkCS0umxqVUez6fez2H6em8yXwAcAKe8riekfjC3PSoGWz/Kcj6dzCRnrmRqhbgWVrEbu6+1TTb0hDfWaZrBDSjMyAKYZ5c+QAcYwOw3s=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:33 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:33 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 12/23] libqos: move useful qos-test funcs to qos_external
Date: Tue, 11 Feb 2020 15:34:59 -0500
Message-ID: <20200211203510.3534-13-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:32 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2e2db65-2471-4798-7087-08d7af31f0f8
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4336C8A41FF5ADAB4E299F70BA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(54906003)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(30864003)(956004)(8676002)(26005)(81166006)(81156014)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiJlkn6yYLY6a6q/UUc8e6qMapVzt3gG4I/3McElezDFJCK8PL0fsPuAy7Py3lvIJ8ZXN6xNpsMWCxZieNk+czttlsQstfOg6M7eJarTgnoCKO/csopSw2Xq2Vtru84LmKiohN4yQddI2Ci30d1bAew0EKXON09+3+n/iF+hpecDiOqbELfSbLSmbwmb1atUxKoYSDcNhvJuWUTtNJjUJI+X/7rlvF8Es8xVcA8Vit0y1pSsponu3Ar7OeeedtGr75jk46YdqTFPwwuVDvJ41vzeclbEDwO1dgfuZ1QM4lwFXOwDWLqMTilCHNFsZhKEQSu7VdGXmF51El8DLSe0ANIi2anuEQmQ+37Yg6il2yqQr/tNF+3c8yUk5ZirG2MzCCaSNU96cbYavEPbSlysC9wO7426wCEiUGTeF795HGMeM58ZrQVxCF7eY6uTyiGG1cFxjd3nFEm0KWVnzNnTC4YATqd9nwi9qyHZUo5cACoUkTyUc4H1+z0BJAa2CH6nPq7MtriPUswDXR5zSchCelHyfYPLq4fK9IB1UyG1o4WSAdW3qtAaJU1IwjVdDwf2
X-MS-Exchange-AntiSpam-MessageData: e7rTlTbjEJU9XUHZOcYKMDM/GhnU6tnagzZ6lMbc38iCFSIjE8KfHlldByKkUVxqcxKStuekVRBmBzEsUD2JjgUAVJHi+erMXzxhrzRvZm7THytgBl1Qfv2jGLFFMdhR7ZUVCsVEjQhqFKewFnb30A==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e2db65-2471-4798-7087-08d7af31f0f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:32.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROAiWx67KZD+NBaWeJgNTrninq78wzhaFSbm3Vdg2GXTVKm4VCQw0YoCgj4VTA/7
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
 stefanha@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The moved functions are not specific to qos-test and might be useful
elsewhere. For example the virtual-device fuzzer makes use of them for
qos-assisted fuzz-targets.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/qtest/Makefile.include      |   1 +
 tests/qtest/libqos/qos_external.c | 168 ++++++++++++++++++++++++++++++
 tests/qtest/libqos/qos_external.h |  28 +++++
 tests/qtest/qos-test.c            | 132 +----------------------
 4 files changed, 198 insertions(+), 131 deletions(-)
 create mode 100644 tests/qtest/libqos/qos_external.c
 create mode 100644 tests/qtest/libqos/qos_external.h

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 838618e6f9..e769c1ad70 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -172,6 +172,7 @@ libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-=
obj-y) tests/qtest/libqos/u
 # qos devices:
 libqos-obj-y =3D  $(libqgraph-obj-y)
 libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+libqos-obj-y +=3D tests/qtest/libqos/qos_external.o
 libqos-obj-y +=3D tests/qtest/libqos/e1000e.o
 libqos-obj-y +=3D tests/qtest/libqos/i2c.o
 libqos-obj-y +=3D tests/qtest/libqos/i2c-imx.o
diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_ext=
ernal.c
new file mode 100644
index 0000000000..398556dde0
--- /dev/null
+++ b/tests/qtest/libqos/qos_external.c
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
diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_ext=
ernal.h
new file mode 100644
index 0000000000..7b44930c55
--- /dev/null
+++ b/tests/qtest/libqos/qos_external.h
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
diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index fd70d73ea5..ad193f43a5 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
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
2.25.0


