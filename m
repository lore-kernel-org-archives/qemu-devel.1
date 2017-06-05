Received: from eggs.gnu.org ([2001:4830:134:3::10]:60986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxE0-0001hs-Of
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dHxDw-0007iS-QR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dHxDw-0007hZ-KN
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 14:59:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Jun 2017 15:59:17 -0300
Message-Id: <20170605185927.12111-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 00/10] x86 and machine queue, 2017-06-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

The following changes since commit cb8b8ef4578dc17c350fd4b27700a9f178e2dad0:

  Merge remote-tracking branch 'remotes/elmarco/tags/chrfe-pull-request' into staging (2017-06-05 10:09:14 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to 23ea4f30320bbd36a5d202ee469374ec3c747286:

  scripts: Test script to look for -device crashes (2017-06-05 14:59:09 -0300)

----------------------------------------------------------------
x86 and machine queue, 2017-06-05

----------------------------------------------------------------

Eduardo Habkost (4):
  pc: Use "min-[x]level" on compat_props
  qemu.py: Don't set _popen=None on error/shutdown
  qemu.py: Add QEMUMachine.exitcode() method
  scripts: Test script to look for -device crashes

Igor Mammedov (6):
  numa: consolidate cpu_preplug fixups/checks for pc/arm/spapr
  numa: move default mapping init to machine
  numa: make sure that all cpus have has_node_id set if numa is enabled
  numa: make hmp 'info numa' fetch numa nodes from qmp_query_cpus()
    result
  numa: move numa_node from CPUState into target specific classes
  spapr: cleanup spapr_fixup_cpu_numa_dt() usage

 scripts/qemu.py               |  17 +-
 include/hw/i386/pc.h          |  42 +--
 include/qom/cpu.h             |   2 -
 include/sysemu/numa.h         |   1 +
 target/arm/cpu.h              |   2 +
 target/i386/cpu.h             |   1 +
 target/ppc/cpu.h              |   1 +
 hw/arm/virt-acpi-build.c      |   4 +-
 hw/arm/virt.c                 |  16 +-
 hw/core/machine.c             |  37 ++-
 hw/i386/acpi-build.c          |   3 +-
 hw/i386/pc.c                  |  21 +-
 hw/ppc/spapr.c                |  41 +--
 hw/ppc/spapr_cpu_core.c       |   4 +-
 monitor.c                     |  11 +-
 numa.c                        |  43 ++-
 target/arm/cpu.c              |   2 +-
 target/i386/cpu.c             |   2 +-
 tests/test-x86-cpuid-compat.c |  38 +++
 scripts/device-crash-test     | 624 ++++++++++++++++++++++++++++++++++++++++++
 20 files changed, 774 insertions(+), 138 deletions(-)
 create mode 100755 scripts/device-crash-test

-- 
2.11.0.259.g40922b1
