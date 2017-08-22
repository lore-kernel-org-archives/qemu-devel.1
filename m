Received: from eggs.gnu.org ([2001:4830:134:3::10]:48228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djznz-0000mK-Iw
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djznx-0006qk-3G
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:24:39 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31593
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djznw-0006oB-7o
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:24:37 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Tue, 22 Aug 2017 11:24:10 +0800
Message-ID: <1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/2] ACPI/unit-test: Add a new testcase for
 RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

As QEMU supports the memory-less node, it is possible that there is
no RAM in the first numa node(also be called as node0). eg:
  ... \
  -m 128,slots=3,maxmem=1G \
  -numa node -numa node,mem=128M \

But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
table. Only fixing it is not enough.

Add a testcase for this situation to make sure the ACPI table is
correct for guest.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 6463 bytes
 tests/acpi-test-data/pc/SLIT.numamem  | Bin 0 -> 48 bytes
 tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 264 bytes
 tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 9147 bytes
 tests/acpi-test-data/q35/SLIT.numamem | Bin 0 -> 48 bytes
 tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 264 bytes
 tests/bios-tables-test.c              |  30 ++++++++++++++++++++++++++++++
 7 files changed, 30 insertions(+)
 create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
 create mode 100644 tests/acpi-test-data/pc/SLIT.numamem
 create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
 create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
 create mode 100644 tests/acpi-test-data/q35/SLIT.numamem
 create mode 100644 tests/acpi-test-data/q35/SRAT.numamem

diff --git a/tests/acpi-test-data/pc/DSDT.numamem b/tests/acpi-test-data/pc/DSDT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..53f6d5824359ff0ca20179b19b3b5cb79f017f82
GIT binary patch
literal 6463
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

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/SLIT.numamem b/tests/acpi-test-data/pc/SLIT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..74ec3b4b461ffecca36d8537975c202a5f011185
GIT binary patch
literal 48
scmWIc@eDCwU|?X>aq@Te2v%^42yhMtiZKGkKx`1r1jHb~B`V4V0NaKK0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/pc/SRAT.numamem b/tests/acpi-test-data/pc/SRAT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..f8ec8fa242adc6132ba033bfc13cf7e858ad22cc
GIT binary patch
literal 264
zcmWFzatz^MWME*N>*Vk35v<@85#SsQ6axw|fY=}!gyBE{mCvYwA`4W;1y_nJgHQ)F
m01Q5`!xW;bgNZV5z*$fR4t40tQ1}RY;qLwcQ@{*k0BHdBCkg=o

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/DSDT.numamem b/tests/acpi-test-data/q35/DSDT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..1b7c484a5e31ec456685bc246197252cb48a3adf
GIT binary patch
literal 9147
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
Hwz}-UIV`hz

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SLIT.numamem b/tests/acpi-test-data/q35/SLIT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..74ec3b4b461ffecca36d8537975c202a5f011185
GIT binary patch
literal 48
scmWIc@eDCwU|?X>aq@Te2v%^42yhMtiZKGkKx`1r1jHb~B`V4V0NaKK0RR91

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SRAT.numamem b/tests/acpi-test-data/q35/SRAT.numamem
new file mode 100644
index 0000000000000000000000000000000000000000..f8ec8fa242adc6132ba033bfc13cf7e858ad22cc
GIT binary patch
literal 264
zcmWFzatz^MWME*N>*Vk35v<@85#SsQ6axw|fY=}!gyBE{mCvYwA`4W;1y_nJgHQ)F
m01Q5`!xW;bgNZV5z*$fR4t40tQ1}RY;qLwcQ@{*k0BHdBCkg=o

literal 0
HcmV?d00001

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45..79728c6 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -808,6 +808,34 @@ static void test_acpi_piix4_tcg_memhp(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_numamem(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_Q35;
+    data.variant = ".numamem";
+    test_acpi_one(" -m 128,slots=3,maxmem=1G"
+                  " -numa node -numa node,mem=128"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_piix4_tcg_numamem(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".numamem";
+    test_acpi_one(" -m 128,slots=3,maxmem=1G"
+                  " -numa node -numa node,mem=128"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
+    free_test_data(&data);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -830,6 +858,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/cpuhp", test_acpi_q35_tcg_cphp);
         qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
         qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
+        qtest_add_func("acpi/piix4/numamem", test_acpi_piix4_tcg_numamem);
+        qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.5.5
