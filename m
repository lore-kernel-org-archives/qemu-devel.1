Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D3FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 01:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8607E206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 01:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8607E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifZh1-0003H7-5h
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 20:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ifZce-0006Pv-Hi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 20:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ifZcc-0007SV-TR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 20:20:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:9651)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ifZcc-0006sk-FO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 20:19:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Dec 2019 17:19:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,307,1571727600"; d="scan'208";a="216480569"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by orsmga003.jf.intel.com with ESMTP; 12 Dec 2019 17:19:55 -0800
From: Tao Xu <tao3.xu@intel.com>
To: mst@redhat.com, imammedo@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 sw@weilnetz.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com,
 lvivier@redhat.com
Subject: [PATCH RESEND v20 8/8] tests/bios-tables-test: add test cases for
 ACPI HMAT
Date: Fri, 13 Dec 2019 09:19:29 +0800
Message-Id: <20191213011929.2520-9-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213011929.2520-1-tao3.xu@intel.com>
References: <20191213011929.2520-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: Jingqi Liu <Jingqi.liu@intel.com>, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, Daniel Black <daniel@linux.ibm.com>,
 jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ACPI table HMAT has been introduced, QEMU now builds HMAT tables for
Heterogeneous Memory with boot option '-numa node'.

Add test cases on PC and Q35 machines with 2 numa nodes.
Because HMAT is generated when system enable numa, the
following tables need to be added for this test:
    tests/data/acpi/pc/APIC.acpihmat
    tests/data/acpi/pc/SRAT.acpihmat
    tests/data/acpi/pc/HMAT.acpihmat
    tests/data/acpi/pc/DSDT.acpihmat
    tests/data/acpi/q35/APIC.acpihmat
    tests/data/acpi/q35/SRAT.acpihmat
    tests/data/acpi/q35/HMAT.acpihmat
    tests/data/acpi/q35/DSDT.acpihmat

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Daniel Black <daniel@linux.ibm.com>
Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v20.

Changes in v18:
    - Remove unit "ns".

Changes in v17:
    - Update the latency and bandwidth

Changes in v15:
    - Make tests without breaking CI (Michael)

Changes in v13:
    - Use decimal notation with appropriate suffix for cache size
---
 tests/bios-tables-test-allowed-diff.h |  8 +++++
 tests/bios-tables-test.c              | 44 +++++++++++++++++++++++++++
 tests/data/acpi/pc/APIC.acpihmat      |  0
 tests/data/acpi/pc/DSDT.acpihmat      |  0
 tests/data/acpi/pc/HMAT.acpihmat      |  0
 tests/data/acpi/pc/SRAT.acpihmat      |  0
 tests/data/acpi/q35/APIC.acpihmat     |  0
 tests/data/acpi/q35/DSDT.acpihmat     |  0
 tests/data/acpi/q35/HMAT.acpihmat     |  0
 tests/data/acpi/q35/SRAT.acpihmat     |  0
 10 files changed, 52 insertions(+)
 create mode 100644 tests/data/acpi/pc/APIC.acpihmat
 create mode 100644 tests/data/acpi/pc/DSDT.acpihmat
 create mode 100644 tests/data/acpi/pc/HMAT.acpihmat
 create mode 100644 tests/data/acpi/pc/SRAT.acpihmat
 create mode 100644 tests/data/acpi/q35/APIC.acpihmat
 create mode 100644 tests/data/acpi/q35/DSDT.acpihmat
 create mode 100644 tests/data/acpi/q35/HMAT.acpihmat
 create mode 100644 tests/data/acpi/q35/SRAT.acpihmat

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
index dfb8523c8b..3c9e0c979b 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1 +1,9 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/APIC.acpihmat",
+"tests/data/acpi/pc/SRAT.acpihmat",
+"tests/data/acpi/pc/HMAT.acpihmat",
+"tests/data/acpi/pc/DSDT.acpihmat",
+"tests/data/acpi/q35/APIC.acpihmat",
+"tests/data/acpi/q35/SRAT.acpihmat",
+"tests/data/acpi/q35/HMAT.acpihmat",
+"tests/data/acpi/q35/DSDT.acpihmat",
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 79f5da092f..9823820043 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -947,6 +947,48 @@ static void test_acpi_virt_tcg_numamem(void)
 
 }
 
+static void test_acpi_tcg_acpi_hmat(const char *machine)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = machine;
+    data.variant = ".acpihmat";
+    test_acpi_one(" -machine hmat=on"
+                  " -smp 2,sockets=2"
+                  " -m 128M,slots=2,maxmem=1G"
+                  " -object memory-backend-ram,size=64M,id=m0"
+                  " -object memory-backend-ram,size=64M,id=m1"
+                  " -numa node,nodeid=0,memdev=m0"
+                  " -numa node,nodeid=1,memdev=m1,initiator=0"
+                  " -numa cpu,node-id=0,socket-id=0"
+                  " -numa cpu,node-id=0,socket-id=1"
+                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=1"
+                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=65534M"
+                  " -numa hmat-lb,initiator=0,target=1,hierarchy=memory,"
+                  "data-type=access-latency,latency=65534"
+                  " -numa hmat-lb,initiator=0,target=1,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=32767M"
+                  " -numa hmat-cache,node-id=0,size=10K,level=1,"
+                  "associativity=direct,policy=write-back,line=8"
+                  " -numa hmat-cache,node-id=1,size=10K,level=1,"
+                  "associativity=direct,policy=write-back,line=8",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_q35_tcg_acpi_hmat(void)
+{
+    test_acpi_tcg_acpi_hmat(MACHINE_Q35);
+}
+
+static void test_acpi_piix4_tcg_acpi_hmat(void)
+{
+    test_acpi_tcg_acpi_hmat(MACHINE_PC);
+}
+
 static void test_acpi_virt_tcg(void)
 {
     test_data data = {
@@ -991,6 +1033,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
         qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm);
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+        qtest_add_func("acpi/piix4/acpihmat", test_acpi_piix4_tcg_acpi_hmat);
+        qtest_add_func("acpi/q35/acpihmat", test_acpi_q35_tcg_acpi_hmat);
     } else if (strcmp(arch, "aarch64") == 0) {
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
         qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/pc/APIC.acpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/pc/HMAT.acpihmat b/tests/data/acpi/pc/HMAT.acpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/pc/SRAT.acpihmat b/tests/data/acpi/pc/SRAT.acpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/q35/APIC.acpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/HMAT.acpihmat b/tests/data/acpi/q35/HMAT.acpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/SRAT.acpihmat b/tests/data/acpi/q35/SRAT.acpihmat
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.20.1


