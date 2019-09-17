Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D50C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D5F214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D5F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADDY-0000kI-DL
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iADCW-00006r-DM
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iADCU-0002ZW-0L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iADCT-0002ZO-PU
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:07:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 007E510F2E81;
 Tue, 17 Sep 2019 13:07:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8879519C4F;
 Tue, 17 Sep 2019 13:07:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 09:07:08 -0400
Message-Id: <20190917130708.10281-3-imammedo@redhat.com>
In-Reply-To: <20190917130708.10281-1-imammedo@redhat.com>
References: <20190917130708.10281-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 17 Sep 2019 13:07:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] tests: q35: MCH: add default SMBASE SMRAM
 lock test
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 alex.williamson@redhat.com, jiewen.yao@intel.com, jun.nakajima@intel.com,
 michael.d.kinney@intel.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 rfc@edk2.groups.io, lersek@redhat.com, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

test lockable SMRAM at default SMBASE feature introduced by
commit "q35: implement 128K SMRAM at default SMBASE address"

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/q35-test.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tests/q35-test.c b/tests/q35-test.c
index a68183d513..dd02660303 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -186,6 +186,109 @@ static void test_tseg_size(const void *data)
     qtest_quit(qts);
 }
 
+#define SMBASE 0x30000
+#define SMRAM_TEST_PATTERN 0x32
+#define SMRAM_TEST_RESET_PATTERN 0x23
+
+static void test_smram_smbase_lock(void)
+{
+    QPCIBus *pcibus;
+    QPCIDevice *pcidev;
+    QDict *response;
+    QTestState *qts;
+    int i;
+
+    qts = qtest_init("-M q35");
+
+    pcibus = qpci_new_pc(qts, NULL);
+    g_assert(pcibus != NULL);
+
+    pcidev = qpci_device_find(pcibus, 0);
+    g_assert(pcidev != NULL);
+
+    /* check that SMRAM is not enabled by default */
+    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
+    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
+    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
+
+    /* check that writinng junk to 0x9c before before negotiating is ignorred */
+    for (i = 0; i < 0xff; i++) {
+        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
+        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
+    }
+
+    /* enable SMRAM at SMBASE */
+    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0xff);
+    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x01);
+    /* lock SMRAM at SMBASE */
+    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0x02);
+    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x02);
+
+    /* check that SMRAM at SMBASE is locked and can't be unlocked */
+    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, 0xff);
+    for (i = 0; i <= 0xff; i++) {
+        /* make sure register is immutable */
+        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
+        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x02);
+
+        /* RAM access should go inot black hole */
+        qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
+        g_assert_cmpint(qtest_readb(qts, SMBASE), ==, 0xff);
+    }
+
+    /* reset */
+    response = qtest_qmp(qts, "{'execute': 'system_reset', 'arguments': {} }");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    /* check RAM at SMBASE is available after reset */
+    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
+    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
+    qtest_writeb(qts, SMBASE, SMRAM_TEST_RESET_PATTERN);
+    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_RESET_PATTERN);
+
+    g_free(pcidev);
+    qpci_free_pc(pcibus);
+
+    qtest_quit(qts);
+}
+
+static void test_without_smram_base(void)
+{
+    QPCIBus *pcibus;
+    QPCIDevice *pcidev;
+    QTestState *qts;
+    int i;
+
+    qts = qtest_init("-M pc-q35-4.1");
+
+    pcibus = qpci_new_pc(qts, NULL);
+    g_assert(pcibus != NULL);
+
+    pcidev = qpci_device_find(pcibus, 0);
+    g_assert(pcidev != NULL);
+
+    /* check that RAM accessible */
+    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
+    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
+
+    /* check that writing to 0x9c succeeds */
+    for (i = 0; i <= 0xff; i++) {
+        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
+        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == i);
+    }
+
+    /* check that RAM is still accessible */
+    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN + 1);
+    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, (SMRAM_TEST_PATTERN + 1));
+
+    g_free(pcidev);
+    qpci_free_pc(pcibus);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -197,5 +300,7 @@ int main(int argc, char **argv)
     qtest_add_data_func("/q35/tseg-size/8mb", &tseg_8mb, test_tseg_size);
     qtest_add_data_func("/q35/tseg-size/ext/16mb", &tseg_ext_16mb,
                         test_tseg_size);
+    qtest_add_func("/q35/smram/smbase_lock", test_smram_smbase_lock);
+    qtest_add_func("/q35/smram/legacy_smbase", test_without_smram_base);
     return g_test_run();
 }
-- 
2.18.1


