Received: from eggs.gnu.org ([2001:4830:134:3::10]:48213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djzny-0000ls-MF
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djznv-0006qE-FP
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:24:38 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31593
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1djznv-0006oB-46
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:24:35 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Tue, 22 Aug 2017 11:24:08 +0800
Message-ID: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/2] hw/acpi-build: Fix ACPI SRAT Memory
 Affinity building
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

V3 --> v4:
  -add a new testcase.

This patchset fixs an ACPI building bug which caused by no RAM
in the first NUAM node. and also add a new testcase for the bug.

Dou Liyang (2):
  hw/acpi-build: Fix SRAT memory building when there is no memory in
    node0
  ACPI/unit-test: Add a new testcase for RAM allocation in numa node

 hw/i386/acpi-build.c                  |  78 ++++++++++++++++++++++------------
 tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 6463 bytes
 tests/acpi-test-data/pc/SLIT.numamem  | Bin 0 -> 48 bytes
 tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 264 bytes
 tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 9147 bytes
 tests/acpi-test-data/q35/SLIT.numamem | Bin 0 -> 48 bytes
 tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 264 bytes
 tests/bios-tables-test.c              |  30 +++++++++++++
 8 files changed, 80 insertions(+), 28 deletions(-)
 create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
 create mode 100644 tests/acpi-test-data/pc/SLIT.numamem
 create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
 create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
 create mode 100644 tests/acpi-test-data/q35/SLIT.numamem
 create mode 100644 tests/acpi-test-data/q35/SRAT.numamem

-- 
2.5.5
