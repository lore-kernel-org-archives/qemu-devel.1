Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87C0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C97321736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C97321736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabSW-0004r6-RL
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iab9V-0000Zm-HF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iab9C-0001fK-CD
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:57:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:7634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iab9A-0000gL-D0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:57:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Nov 2019 23:56:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,256,1571727600"; d="scan'208";a="207273388"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga008.fm.intel.com with ESMTP; 28 Nov 2019 23:56:53 -0800
From: Tao Xu <tao3.xu@intel.com>
To: mst@redhat.com, imammedo@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 sw@weilnetz.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com,
 lvivier@redhat.com
Subject: [PATCH v20 7/8] tests/numa: Add case for QMP build HMAT
Date: Fri, 29 Nov 2019 15:56:33 +0800
Message-Id: <20191129075634.682-8-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129075634.682-1-tao3.xu@intel.com>
References: <20191129075634.682-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check configuring HMAT usecase

Acked-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v20:
    - Use g_assert_true and g_assert_false to replace g_assert
      (Thomas and Markus)

Changes in v19:
    - Add some fail cases for hmat-cache when level=0

Changes in v18:
    - Rewrite the lines over 80 characters

Chenges in v17:
    - Add some fail test cases (Igor)
---
 tests/numa-test.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 8de8581231..da1c19ef74 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -327,6 +327,216 @@ static void pc_dynamic_cpu_cfg(const void *data)
     qtest_quit(qs);
 }
 
+static void pc_hmat_build_cfg(const void *data)
+{
+    QTestState *qs = qtest_initf("%s -nodefaults --preconfig -machine hmat=on "
+                     "-smp 2,sockets=2 "
+                     "-m 128M,slots=2,maxmem=1G "
+                     "-object memory-backend-ram,size=64M,id=m0 "
+                     "-object memory-backend-ram,size=64M,id=m1 "
+                     "-numa node,nodeid=0,memdev=m0 "
+                     "-numa node,nodeid=1,memdev=m1,initiator=0 "
+                     "-numa cpu,node-id=0,socket-id=0 "
+                     "-numa cpu,node-id=0,socket-id=1",
+                     data ? (char *)data : "");
+
+    /* Fail: Initiator should be less than the number of nodes */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 2, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")));
+
+    /* Fail: Target should be less than the number of nodes */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 2,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")));
+
+    /* Fail: Initiator should contain cpu */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 1, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")));
+
+    /* Fail: Data-type mismatch */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"write-latency\","
+        " 'bandwidth': 524288000 } }")));
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"read-bandwidth\","
+        " 'latency': 5 } }")));
+
+    /* Fail: Bandwidth should be 1MB (1048576) aligned */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 1048575 } }")));
+
+    /* Configuring HMAT bandwidth and latency details */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 1 } }")));    /* 1 ns */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 5 } }")));    /* Fail: Duplicate configuration */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 68717379584 } }")));    /* 65534 MB/s */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 65534 } }")));    /* 65534 ns */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 34358689792 } }")));    /* 32767 MB/s */
+
+    /* Fail: node_id should be less than the number of nodes */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 2, 'size': 10240,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));
+
+    /* Fail: level should be less than HMAT_LB_LEVELS (4) */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 4, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));
+
+    /* Fail: associativity option should be 'none', if level is 0 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 0, 'associativity': \"direct\", 'policy': \"none\","
+        " 'line': 0 } }")));
+    /* Fail: policy option should be 'none', if level is 0 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 0, 'associativity': \"none\", 'policy': \"write-back\","
+        " 'line': 0 } }")));
+    /* Fail: line option should be 0, if level is 0 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 0, 'associativity': \"none\", 'policy': \"none\","
+        " 'line': 8 } }")));
+
+    /* Configuring HMAT memory side cache attributes */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));    /* Fail: Duplicate configuration */
+    /* Fail: The size of level 2 size should be small than level 1 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 2, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));
+    /* Fail: The size of level 0 size should be larger than level 1 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 0, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 1, 'size': 10240,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));
+
+    /* let machine initialization to complete and run */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
+        "{ 'execute': 'x-exit-preconfig' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    qtest_quit(qs);
+}
+
+static void pc_hmat_off_cfg(const void *data)
+{
+    QTestState *qs = qtest_initf("%s -nodefaults --preconfig "
+                     "-smp 2,sockets=2 "
+                     "-m 128M,slots=2,maxmem=1G "
+                     "-object memory-backend-ram,size=64M,id=m0 "
+                     "-object memory-backend-ram,size=64M,id=m1 "
+                     "-numa node,nodeid=0,memdev=m0",
+                     data ? (char *)data : "");
+
+    /*
+     * Fail: Enable HMAT with -machine hmat=on
+     * before using any of hmat specific options
+     */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': \"m1\","
+        " 'initiator': 0 } }")));
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': \"m1\" } }")));
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 1 } }")));
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));
+
+    /* let machine initialization to complete and run */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
+        "{ 'execute': 'x-exit-preconfig' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    qtest_quit(qs);
+}
+
+static void pc_hmat_erange_cfg(const void *data)
+{
+    QTestState *qs = qtest_initf("%s -nodefaults --preconfig -machine hmat=on "
+                     "-smp 2,sockets=2 "
+                     "-m 128M,slots=2,maxmem=1G "
+                     "-object memory-backend-ram,size=64M,id=m0 "
+                     "-object memory-backend-ram,size=64M,id=m1 "
+                     "-numa node,nodeid=0,memdev=m0 "
+                     "-numa node,nodeid=1,memdev=m1,initiator=0 "
+                     "-numa cpu,node-id=0,socket-id=0 "
+                     "-numa cpu,node-id=0,socket-id=1",
+                     data ? (char *)data : "");
+
+    /* Can't store the compressed latency */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 1 } }")));    /* 1 ns */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 65535 } }")));    /* 65535 ns */
+
+    /* Test the 0 input (bandwidth not provided) */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 0 } }")));    /* 0 MB/s */
+    /* Fail: bandwidth should be provided before memory side cache attributes */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
+        " 'line': 8 } }")));
+
+    /* Can't store the compressed bandwidth */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 68718428160 } }")));    /* 65535 MB/s */
+
+    /* let machine initialization to complete and run */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
+        "{ 'execute': 'x-exit-preconfig' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    qtest_quit(qs);
+}
+
 int main(int argc, char **argv)
 {
     const char *args = NULL;
@@ -346,6 +556,9 @@ int main(int argc, char **argv)
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
         qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
         qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_cfg);
+        qtest_add_data_func("/numa/pc/hmat/build", args, pc_hmat_build_cfg);
+        qtest_add_data_func("/numa/pc/hmat/off", args, pc_hmat_off_cfg);
+        qtest_add_data_func("/numa/pc/hmat/erange", args, pc_hmat_erange_cfg);
     }
 
     if (!strcmp(arch, "ppc64")) {
-- 
2.20.1


