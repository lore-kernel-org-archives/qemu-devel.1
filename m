Received: from eggs.gnu.org ([2001:4830:134:3::10]:46224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dALsZ-0001oh-9B
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dALsW-0005pg-5v
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:42:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dALsV-0005pR-T6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 15:42:00 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 15 May 2017 14:41:44 -0500
Message-Id: <20170515194149.16288-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v8 0/5] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com

v6 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01380.html
v7 was here:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01848.html

Since then:
- reorder the series [Markus]
- tweak some comments [Markus]
- add helper function in patch 5 [Markus]

001/5:[----] [--] 'shutdown: Simplify shutdown_signal'
002/5:[0011] [FC] 'shutdown: Prepare for use of an enum in reset/shutdown_request'
003/5:[0009] [FC] 'shutdown: Preserve shutdown cause through replay'
004/5:[0014] [FC] 'shutdown: Add source information to SHUTDOWN and RESET'
005/5:[0010] [FC] 'shutdown: Expose bool cause in SHUTDOWN and RESET events'

Eric Blake (5):
  shutdown: Simplify shutdown_signal
  shutdown: Prepare for use of an enum in reset/shutdown_request
  shutdown: Preserve shutdown cause through replay
  shutdown: Add source information to SHUTDOWN and RESET
  shutdown: Expose bool cause in SHUTDOWN and RESET events

 qapi/event.json             | 17 ++++++++---
 include/sysemu/replay.h     |  3 +-
 include/sysemu/sysemu.h     | 31 +++++++++++++++-----
 replay/replay-internal.h    |  3 +-
 vl.c                        | 69 ++++++++++++++++++++++++++-------------------
 hw/acpi/core.c              |  4 +--
 hw/arm/highbank.c           |  4 +--
 hw/arm/integratorcp.c       |  2 +-
 hw/arm/musicpal.c           |  2 +-
 hw/arm/omap1.c              | 10 ++++---
 hw/arm/omap2.c              |  2 +-
 hw/arm/spitz.c              |  2 +-
 hw/arm/stellaris.c          |  2 +-
 hw/arm/tosa.c               |  2 +-
 hw/i386/pc.c                |  2 +-
 hw/i386/xen/xen-hvm.c       |  9 ++++--
 hw/input/pckbd.c            |  4 +--
 hw/ipmi/ipmi.c              |  4 +--
 hw/isa/lpc_ich9.c           |  2 +-
 hw/mips/boston.c            |  2 +-
 hw/mips/mips_malta.c        |  2 +-
 hw/mips/mips_r4k.c          |  4 +--
 hw/misc/arm_sysctl.c        |  8 +++---
 hw/misc/cbus.c              |  2 +-
 hw/misc/macio/cuda.c        |  4 +--
 hw/misc/slavio_misc.c       |  4 +--
 hw/misc/zynq_slcr.c         |  2 +-
 hw/pci-host/apb.c           |  4 +--
 hw/pci-host/bonito.c        |  2 +-
 hw/pci-host/piix.c          |  2 +-
 hw/ppc/e500.c               |  2 +-
 hw/ppc/mpc8544_guts.c       |  2 +-
 hw/ppc/ppc.c                |  2 +-
 hw/ppc/ppc405_uc.c          |  2 +-
 hw/ppc/spapr_hcall.c        |  2 +-
 hw/ppc/spapr_rtas.c         |  4 +--
 hw/s390x/ipl.c              |  2 +-
 hw/sh4/r2d.c                |  2 +-
 hw/timer/etraxfs_timer.c    |  2 +-
 hw/timer/m48t59.c           |  4 +--
 hw/timer/milkymist-sysctl.c |  4 +--
 hw/timer/pxa2xx_timer.c     |  2 +-
 hw/watchdog/watchdog.c      |  2 +-
 hw/xenpv/xen_domainbuild.c  |  2 +-
 hw/xtensa/xtfpga.c          |  2 +-
 kvm-all.c                   |  6 ++--
 migration/colo.c            |  2 +-
 migration/savevm.c          |  2 +-
 os-win32.c                  |  2 +-
 qmp.c                       |  4 +--
 replay/replay.c             |  9 +++---
 target/alpha/sys_helper.c   |  4 +--
 target/arm/psci.c           |  4 +--
 target/i386/excp_helper.c   |  2 +-
 target/i386/hax-all.c       |  6 ++--
 target/i386/helper.c        |  2 +-
 target/i386/kvm.c           |  2 +-
 target/s390x/helper.c       |  2 +-
 target/s390x/kvm.c          |  4 +--
 target/s390x/misc_helper.c  |  4 +--
 target/sparc/int32_helper.c |  2 +-
 ui/sdl.c                    |  2 +-
 ui/sdl2.c                   |  4 +--
 tests/qemu-iotests/071.out  |  4 +--
 tests/qemu-iotests/081.out  |  2 +-
 tests/qemu-iotests/087.out  | 12 ++++----
 tests/qemu-iotests/094.out  |  2 +-
 tests/qemu-iotests/117.out  |  2 +-
 tests/qemu-iotests/119.out  |  2 +-
 tests/qemu-iotests/120.out  |  2 +-
 tests/qemu-iotests/140.out  |  2 +-
 tests/qemu-iotests/143.out  |  2 +-
 tests/qemu-iotests/156.out  |  2 +-
 trace-events                |  2 +-
 ui/cocoa.m                  |  2 +-
 75 files changed, 195 insertions(+), 150 deletions(-)

-- 
2.9.4
