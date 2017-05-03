Received: from eggs.gnu.org ([2001:4830:134:3::10]:34237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1d5qP6-0007iv-Ue
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1d5qP3-00016B-QI
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:17:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:65530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <he.chen@linux.intel.com>)
	id 1d5qP3-00010x-GP
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:16:57 -0400
From: He Chen <he.chen@linux.intel.com>
Date: Wed,  3 May 2017 17:17:16 +0800
Message-Id: <1493803036-4048-1-git-send-email-he.chen@linux.intel.com>
Subject: [Qemu-devel] [PATCH] tests: acpi: extend cphp and memhp testcase
 with numa distance check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrew Jones <drjones@redhat.com>

Signed-off-by: He Chen <he.chen@linux.intel.com>
---
 tests/bios-tables-test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 88dbf97..c593165 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -710,7 +710,8 @@ static void test_acpi_piix4_tcg_cphp(void)
     data.machine = MACHINE_PC;
     data.variant = ".cphp";
     test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
-                  " -numa node -numa node",
+                  " -numa node -numa node"
+                  " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
 }
@@ -723,7 +724,8 @@ static void test_acpi_q35_tcg_cphp(void)
     data.machine = MACHINE_Q35;
     data.variant = ".cphp";
     test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
-                  " -numa node -numa node",
+                  " -numa node -numa node"
+                  " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
 }
@@ -772,7 +774,10 @@ static void test_acpi_q35_tcg_memhp(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_Q35;
     data.variant = ".memhp";
-    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
+    test_acpi_one(" -m 128,slots=3,maxmem=1G"
+                  " -numa node -numa node"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
     free_test_data(&data);
 }
 
@@ -783,7 +788,10 @@ static void test_acpi_piix4_tcg_memhp(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_PC;
     data.variant = ".memhp";
-    test_acpi_one(" -m 128,slots=3,maxmem=1G -numa node", &data);
+    test_acpi_one(" -m 128,slots=3,maxmem=1G"
+                  " -numa node -numa node"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
     free_test_data(&data);
 }
 
-- 
2.7.4
