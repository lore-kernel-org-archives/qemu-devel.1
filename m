Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E8C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8895920665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8895920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJUD-0006n4-Q9
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44377)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hiJS1-00055j-7U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hiJRz-00037A-Ka
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:08:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hiJRz-00036M-BN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:08:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D138821EF
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 14:07:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00BAD7D5CF;
 Tue,  2 Jul 2019 14:07:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 10:07:45 -0400
Message-Id: <20190702140745.27767-3-imammedo@redhat.com>
In-Reply-To: <20190702140745.27767-1-imammedo@redhat.com>
References: <CAFEAcA8Jnh=tu8s08Fu6n0sSmJJuVOx7YxyTR_ni5yW3DdMFkQ@mail.gmail.com>
 <20190702140745.27767-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 02 Jul 2019 14:07:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] tests: use -numa memdev option in tests
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

it will test preferred memdev option more extensively and remove
undesired deprecation warnings during 'make check'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 40 ++++++++++++++++++++++++++-----------
 tests/numa-test.c        | 43 +++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 0ce55182f2..d863233fe9 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -688,6 +688,8 @@ static void test_acpi_q35_tcg_mmio64(void)
     };
 
     test_acpi_one("-m 128M,slots=1,maxmem=2G "
+                  "-object memory-backend-ram,id=ram0,size=128M "
+                  "-numa node,memdev=ram0 "
                   "-device pci-testdev,membar=2G",
                   &data);
     free_test_data(&data);
@@ -701,7 +703,9 @@ static void test_acpi_piix4_tcg_cphp(void)
     data.machine = MACHINE_PC;
     data.variant = ".cphp";
     test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
-                  " -numa node -numa node"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
@@ -715,7 +719,9 @@ static void test_acpi_q35_tcg_cphp(void)
     data.machine = MACHINE_Q35;
     data.variant = ".cphp";
     test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
-                  " -numa node -numa node"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
@@ -766,7 +772,9 @@ static void test_acpi_q35_tcg_memhp(void)
     data.machine = MACHINE_Q35;
     data.variant = ".memhp";
     test_acpi_one(" -m 128,slots=3,maxmem=1G"
-                  " -numa node -numa node"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
@@ -780,7 +788,9 @@ static void test_acpi_piix4_tcg_memhp(void)
     data.machine = MACHINE_PC;
     data.variant = ".memhp";
     test_acpi_one(" -m 128,slots=3,maxmem=1G"
-                  " -numa node -numa node"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
@@ -793,7 +803,8 @@ static void test_acpi_q35_tcg_numamem(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_Q35;
     data.variant = ".numamem";
-    test_acpi_one(" -numa node -numa node,mem=128", &data);
+    test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node -numa node,memdev=ram0", &data);
     free_test_data(&data);
 }
 
@@ -804,7 +815,8 @@ static void test_acpi_piix4_tcg_numamem(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_PC;
     data.variant = ".numamem";
-    test_acpi_one(" -numa node -numa node,mem=128", &data);
+    test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node -numa node,memdev=ram0", &data);
     free_test_data(&data);
 }
 
@@ -818,17 +830,21 @@ static void test_acpi_tcg_dimm_pxm(const char *machine)
     test_acpi_one(" -machine nvdimm=on,nvdimm-persistence=cpu"
                   " -smp 4,sockets=4"
                   " -m 128M,slots=3,maxmem=1G"
-                  " -numa node,mem=32M,nodeid=0"
-                  " -numa node,mem=32M,nodeid=1"
-                  " -numa node,mem=32M,nodeid=2"
-                  " -numa node,mem=32M,nodeid=3"
+                  " -object memory-backend-ram,id=ram0,size=32M"
+                  " -object memory-backend-ram,id=ram1,size=32M"
+                  " -object memory-backend-ram,id=ram2,size=32M"
+                  " -object memory-backend-ram,id=ram3,size=32M"
+                  " -numa node,memdev=ram0,nodeid=0"
+                  " -numa node,memdev=ram1,nodeid=1"
+                  " -numa node,memdev=ram2,nodeid=2"
+                  " -numa node,memdev=ram3,nodeid=3"
                   " -numa cpu,node-id=0,socket-id=0"
                   " -numa cpu,node-id=1,socket-id=1"
                   " -numa cpu,node-id=2,socket-id=2"
                   " -numa cpu,node-id=3,socket-id=3"
-                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -object memory-backend-ram,id=ram4,size=128M"
                   " -object memory-backend-ram,id=nvm0,size=128M"
-                  " -device pc-dimm,id=dimm0,memdev=ram0,node=1"
+                  " -device pc-dimm,id=dimm0,memdev=ram4,node=1"
                   " -device nvdimm,id=dimm1,memdev=nvm0,node=2",
                   &data);
     free_test_data(&data);
diff --git a/tests/numa-test.c b/tests/numa-test.c
index 8de8581231..902e8de4d1 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -26,8 +26,10 @@ static void test_mon_explicit(const void *data)
     QTestState *qts;
 
     cli = make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=0,cpus=0-3 "
-                   "-numa node,nodeid=1,cpus=4-7 ");
+                   "-object memory-backend-ram,id=ram0,size=64M "
+                   "-object memory-backend-ram,id=ram1,size=64M "
+                   "-numa node,nodeid=0,cpus=0-3,memdev=ram0 "
+                   "-numa node,nodeid=1,cpus=4-7,memdev=ram1 ");
     qts = qtest_init(cli);
 
     s = qtest_hmp(qts, "info numa");
@@ -45,7 +47,10 @@ static void test_mon_default(const void *data)
     char *cli;
     QTestState *qts;
 
-    cli = make_cli(data, "-smp 8 -numa node -numa node");
+    cli = make_cli(data, "-smp 8 "
+                   "-object memory-backend-ram,id=ram0,size=64M "
+                   "-object memory-backend-ram,id=ram1,size=64M "
+                   "-numa node,memdev=ram0 -numa node,memdev=ram1");
     qts = qtest_init(cli);
 
     s = qtest_hmp(qts, "info numa");
@@ -64,8 +69,10 @@ static void test_mon_partial(const void *data)
     QTestState *qts;
 
     cli = make_cli(data, "-smp 8 "
-                   "-numa node,nodeid=0,cpus=0-1 "
-                   "-numa node,nodeid=1,cpus=4-5 ");
+                   "-object memory-backend-ram,id=ram0,size=64M "
+                   "-object memory-backend-ram,id=ram1,size=64M "
+                   "-numa node,nodeid=0,cpus=0-1,memdev=ram0 "
+                   "-numa node,nodeid=1,cpus=4-5,memdev=ram1");
     qts = qtest_init(cli);
 
     s = qtest_hmp(qts, "info numa");
@@ -93,7 +100,11 @@ static void test_query_cpus(const void *data)
     QObject *e;
     QTestState *qts;
 
-    cli = make_cli(data, "-smp 8 -numa node,cpus=0-3 -numa node,cpus=4-7");
+    cli = make_cli(data, "-smp 8 "
+                   "-object memory-backend-ram,id=ram0,size=64M "
+                   "-object memory-backend-ram,id=ram1,size=64M "
+                   "-numa node,cpus=0-3,memdev=ram0 "
+                   "-numa node,cpus=4-7,memdev=ram1");
     qts = qtest_init(cli);
     cpus = get_cpus(qts, &resp);
     g_assert(cpus);
@@ -132,7 +143,9 @@ static void pc_numa_cpu(const void *data)
     QTestState *qts;
 
     cli = make_cli(data, "-cpu pentium -smp 8,sockets=2,cores=2,threads=2 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-object memory-backend-ram,id=ram0,size=64M "
+        "-object memory-backend-ram,id=ram1,size=64M "
+        "-numa node,nodeid=0,memdev=ram0 -numa node,nodeid=1,memdev=ram1 "
         "-numa cpu,node-id=1,socket-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=0 "
         "-numa cpu,node-id=0,socket-id=1,core-id=1,thread-id=0 "
@@ -186,7 +199,9 @@ static void spapr_numa_cpu(const void *data)
     QTestState *qts;
 
     cli = make_cli(data, "-smp 4,cores=4 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-object memory-backend-ram,id=ram0,size=64M "
+        "-object memory-backend-ram,id=ram1,size=64M "
+        "-numa node,nodeid=0,memdev=ram0 -numa node,nodeid=1,memdev=ram1 "
         "-numa cpu,node-id=0,core-id=0 "
         "-numa cpu,node-id=0,core-id=1 "
         "-numa cpu,node-id=0,core-id=2 "
@@ -232,7 +247,9 @@ static void aarch64_numa_cpu(const void *data)
     QTestState *qts;
 
     cli = make_cli(data, "-smp 2 "
-        "-numa node,nodeid=0 -numa node,nodeid=1 "
+        "-object memory-backend-ram,id=ram0,size=64M "
+        "-object memory-backend-ram,id=ram1,size=64M "
+        "-numa node,nodeid=0,memdev=ram0 -numa node,nodeid=1,memdev=ram1 "
         "-numa cpu,node-id=1,thread-id=0 "
         "-numa cpu,node-id=0,thread-id=1");
     qts = qtest_init(cli);
@@ -274,14 +291,16 @@ static void pc_dynamic_cpu_cfg(const void *data)
     QList *cpus;
     QTestState *qs;
 
-    qs = qtest_initf("%s -nodefaults --preconfig -smp 2",
+    qs = qtest_initf("%s -nodefaults --preconfig -smp 2 "
+                     "-object memory-backend-ram,id=ram0,size=64M "
+                     "-object memory-backend-ram,id=ram1,size=64M",
                      data ? (char *)data : "");
 
     /* create 2 numa nodes */
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
-        " 'arguments': { 'type': 'node', 'nodeid': 0 } }")));
+        " 'arguments': { 'type': 'node', 'nodeid': 0, 'memdev': 'ram0' } }")));
     g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
-        " 'arguments': { 'type': 'node', 'nodeid': 1 } }")));
+        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': 'ram1' } }")));
 
     /* map 2 cpus in non default reverse order
      * i.e socket1->node0, socket0->node1
-- 
2.18.1


