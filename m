Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446BAC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFBF2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFBF2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihYR-0001WH-7O
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hihTt-0006Uy-KY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hihTp-0003rP-Pl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hihTp-0003r6-Fl
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:47:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C02F53087931
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 15:47:27 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FA528CBBF;
 Wed,  3 Jul 2019 15:47:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 11:47:23 -0400
Message-Id: <20190703154723.7327-1-imammedo@redhat.com>
In-Reply-To: <20190702215726.23661-1-ehabkost@redhat.com>
References: <20190702215726.23661-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 03 Jul 2019 15:47:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] tests: numa-test: use -numa memdev option
 instead of legacy 'mem' option
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

it drops testing of deprecated 'mem' option and will test preferred memdev
option instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - make backend size depend on initial RAM size and a number of backends
    fixes test faulure with spapr machine (Eduardo Habkost <ehabkost@redhat.com>)

 tests/numa-test.c | 85 +++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 8de8581231..e102b3b70f 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -14,9 +14,28 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 
-static char *make_cli(const char *generic_cli, const char *test_cli)
+typedef struct {
+    const char *args;
+    int ram_size; /* size in MB */
+} TestData;
+
+static char *make_cli(const TestData *data, int memdev_count,
+                      const char *test_cli)
 {
-    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
+    int i;
+    char *tmp = NULL;
+    char *cli = g_strdup_printf("%s -m %d", data->args ? : "", data->ram_size);
+
+    for (i = 0; memdev_count && (i < memdev_count); i++) {
+        tmp = g_strdup_printf("%s -object memory-backend-ram,id=r%d,size=%dM",
+                              cli, i, data->ram_size / memdev_count);
+        g_free(cli);
+        cli = tmp;
+    }
+    tmp = g_strdup_printf("%s %s", cli, test_cli);
+    g_free(cli);
+    cli = tmp;
+    return cli;
 }
 
 static void test_mon_explicit(const void *data)
@@ -25,9 +44,8 @@ static void test_mon_explicit(const void *data)
     char *cli;
     QTestState *qts;
 
-    cli = make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=0,cpus=0-3 "
-                   "-numa node,nodeid=1,cpus=4-7 ");
+    cli = make_cli(data, 2, "-smp 8 -numa node,nodeid=0,cpus=0-3,memdev=r0 "
+                   "-numa node,nodeid=1,cpus=4-7,memdev=r1 ");
     qts = qtest_init(cli);
 
     s = qtest_hmp(qts, "info numa");
@@ -45,7 +63,7 @@ static void test_mon_default(const void *data)
     char *cli;
     QTestState *qts;
 
-    cli = make_cli(data, "-smp 8 -numa node -numa node");
+    cli = make_cli(data, 2, "-smp 8 -numa node,memdev=r0 -numa node,memdev=r1");
     qts = qtest_init(cli);
 
     s = qtest_hmp(qts, "info numa");
@@ -63,9 +81,8 @@ static void test_mon_partial(const void *data)
     char *cli;
     QTestState *qts;
 
-    cli = make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=0,cpus=0-1 "
-                   "-numa node,nodeid=1,cpus=4-5 ");
+    cli = make_cli(data, 2, "-smp 8 -numa node,nodeid=0,cpus=0-1,memdev=r0 "
+                   "-numa node,nodeid=1,cpus=4-5,memdev=r1");
     qts = qtest_init(cli);
 
     s = qtest_hmp(qts, "info numa");
@@ -93,7 +110,8 @@ static void test_query_cpus(const void *data)
     QObject *e;
     QTestState *qts;
 
-    cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
+    cli = make_cli(data, 2, "-smp 8 -numa node,cpus=0-3,memdev=r0 "
+                   "-numa node,cpus=4-7,memdev=r1");
     qts = qtest_init(cli);
     cpus = get_cpus(qts, &resp);
     g_assert(cpus);
@@ -131,8 +149,8 @@ static void pc_numa_cpu(const void *data)
     QObject *e;
     QTestState *qts;
 
-    cli = make_cli(data, "-cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+    cli = make_cli(data, 2, "-cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
+        "-numa node,nodeid=0,memdev=r0 -numa node,nodeid=1,memdev=r1 "
         "-numa cpu,node-id=1,socket-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=1,thread-id=0 "
@@ -185,8 +203,8 @@ static void spapr_numa_cpu(const void *data)
     QObject *e;
     QTestState *qts;
 
-    cli = make_cli(data, "-smp 4,cores=4 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+    cli = make_cli(data, 2, "-smp 4,cores=4 "
+        "-numa node,nodeid=0,memdev=r0 -numa node,nodeid=1,memdev=r1 "
         "-numa cpu,node-id=0,core-id=0 "
         "-numa cpu,node-id=0,core-id=1 "
         "-numa cpu,node-id=0,core-id=2 "
@@ -231,8 +249,8 @@ static void aarch64_numa_cpu(const void *data)
     QObject *e;
     QTestState *qts;
 
-    cli = make_cli(data, "-smp 2 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+    cli = make_cli(data, 2, "-smp 2 "
+        "-numa node,nodeid=0,memdev=r0 -numa node,nodeid=1,memdev=r1 "
         "-numa cpu,node-id=1,thread-id=0 "
         "-numa cpu,node-id=0,thread-id=1");
     qts = qtest_init(cli);
@@ -272,16 +290,14 @@ static void pc_dynamic_cpu_cfg(const void *data)
     QObject *e;
     QDict *resp;
     QList *cpus;
-    QTestState *qs;
-
-    qs = qtest_initf("%s -nodefaults --preconfig -smp 2",
-                     data ? (char *)data : "");
+    char *cli = make_cli(data, 2, "-nodefaults --preconfig -smp 2");
+    QTestState *qs = qtest_init(cli);
 
     /* create 2 numa nodes */
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
-        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
+        " 'arguments': { 'type': 'node', 'nodeid': 0, 'memdev': 'r0' } }")));
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
-        " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
+        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': 'r1' } }")));
 
     /* map 2 cpus in non default reverse order
      * i.e socket1->node0, socket0->node1
@@ -325,35 +341,38 @@ static void pc_dynamic_cpu_cfg(const void *data)
     qobject_unref(resp);
 
     qtest_quit(qs);
+    g_free(cli);
 }
 
 int main(int argc, char **argv)
 {
-    const char *args = NULL;
     const char *arch = qtest_get_arch();
+    TestData data = { .ram_size = 128 };
 
-    if (strcmp(arch, "aarch64") == 0) {
-        args = "-machine virt";
+    if (!strcmp(arch, "aarch64")) {
+        data.args = "-machine virt";
+    } else if (!strcmp(arch, "ppc64")) {
+        data.ram_size = 512;
     }
 
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_data_func("/numa/mon/default", args, test_mon_default);
-    qtest_add_data_func("/numa/mon/cpus/explicit", args, test_mon_explicit);
-    qtest_add_data_func("/numa/mon/cpus/partial", args, test_mon_partial);
-    qtest_add_data_func("/numa/qmp/cpus/query-cpus", args, test_query_cpus);
+    qtest_add_data_func("/numa/mon/default", &data, test_mon_default);
+    qtest_add_data_func("/numa/mon/cpus/explicit", &data, test_mon_explicit);
+    qtest_add_data_func("/numa/mon/cpus/partial", &data, test_mon_partial);
+    qtest_add_data_func("/numa/qmp/cpus/query-cpus", &data, test_query_cpus);
 
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
-        qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
-        qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_cfg);
+        qtest_add_data_func("/numa/pc/cpu/explicit", &data, pc_numa_cpu);
+        qtest_add_data_func("/numa/pc/dynamic/cpu", &data, pc_dynamic_cpu_cfg);
     }
 
     if (!strcmp(arch, "ppc64")) {
-        qtest_add_data_func("/numa/spapr/cpu/explicit", args, spapr_numa_cpu);
+        qtest_add_data_func("/numa/spapr/cpu/explicit", &data, spapr_numa_cpu);
     }
 
     if (!strcmp(arch, "aarch64")) {
-        qtest_add_data_func("/numa/aarch64/cpu/explicit", args,
+        qtest_add_data_func("/numa/aarch64/cpu/explicit", &data,
                             aarch64_numa_cpu);
     }
 
-- 
2.18.1


