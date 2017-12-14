Received: from eggs.gnu.org ([2001:4830:134:3::10]:36515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1ePKpi-0004WJ-Um
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 23:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1ePKpg-00012C-Ba
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 23:09:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35218
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1ePKpg-0000xo-0A
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 23:09:16 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Thu, 14 Dec 2017 12:08:53 +0800
Message-ID: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RESEND PATCH for-2.12 0/2] ACPI/unit-test: Add a
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, imammedo@redhat.com, mst@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, indou.takao@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

These are the patches left over from the pull request:

  [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05

because of some errors when tested by "make check" command[1].

Now, the QEMU 2.11.0 has been released, rebase/retest/respin them
for v2.12 dev.

Changelog:
  --Rebase and retest this patch in v2.11.0
  --Update the DSDT.numamem:

[1]: http://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01334.html

Dou Liyang (2):
  ACPI/unit-test: Add a testcase for RAM allocation in numa node
  hw/acpi-build: Make next_base easy to follow

 hw/i386/acpi-build.c                  |   2 +-
 tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 5150 bytes
 tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 224 bytes
 tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 7834 bytes
 tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 224 bytes
 tests/bios-tables-test.c              |  24 ++++++++++++++++++++++++
 6 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
 create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
 create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
 create mode 100644 tests/acpi-test-data/q35/SRAT.numamem

-- 
2.14.3
