Received: from eggs.gnu.org ([2001:4830:134:3::10]:39749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnbPi-0004Z7-B1
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 22:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnbPf-0007Gp-3r
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 22:10:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10698
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dnbPe-0007GD-P8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 22:10:27 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Fri, 1 Sep 2017 10:10:01 +0800
Message-ID: <1504231805-30957-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 0/4]ACPI: NUMA: Fix ACPI SRAT Memory
 Affinity building
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, mst@redhat.com, rth@twiddle.net, Dou Liyang <douly.fnst@cn.fujitsu.com>

v5 --> v6:
  - Split the unrelated code into a separate patch [2/4]

v4 --> v5:
  - Replace the original way with Eduardo's method.
  - Rewrite the testcase.
  - Drop the SLIT date
  - 2.11 develop tree is opened, So, Add the third patch for re-posting it. 

v3 --> v4:
  -add a new testcase.

This patchset fixs an ACPI building bug which caused by no RAM
in the first NUAM node. and also add a new testcase for the bug.

Dou Liyang (3):
  hw/acpi-build: Make assignment statement of next_base easy to read
  ACPI/unit-test: Add a new testcase for RAM allocation in numa node
  NUMA: Replace MAX_NODES with nb_numa_nodes in for loop

Eduardo Habkost (1):
  hw/acpi-build: Fix SRAT memory building in case of node 0 without RAM

 hw/i386/acpi-build.c                  |  30 +++++++++++++++++++++++-------
 numa.c                                |   2 +-
 tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 5104 bytes
 tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 7788 bytes
 tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 224 bytes
 tests/bios-tables-test.c              |  24 ++++++++++++++++++++++++
 7 files changed, 48 insertions(+), 8 deletions(-)
 create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
 create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
 create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
 create mode 100644 tests/acpi-test-data/q35/SRAT.numamem

-- 
2.5.5
