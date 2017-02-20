Received: from eggs.gnu.org ([2001:4830:134:3::10]:35889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucE-00084e-AV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucB-0004ah-6Q
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:22 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:64223)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucB-0004Zy-0Y
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:19 -0500
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id EA016CA9D01D2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:31:10 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Feb 2017 20:30:54 +0000
Message-ID: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

This is pull-req for target-mips.

Regards,
Yongbok

The following changes since commit 56f9e46b841c7be478ca038d8d4085d776ab4b=
0d:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-20'=
 into staging (2017-02-20 17:42:47 +0000)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170220

for you to fetch changes up to 0a1fdcc94338ea12f7deba71e795c01989152752:

  hw/mips: MIPS Boston board support (2017-02-20 19:37:28 +0000)

----------------------------------------------------------------
MIPS patches 2017-02-20

Changes:
* Add MIPS Boston board support

----------------------------------------------------------------

Paul Burton (8):
  hw/mips_cmgcr: allow GCR base to be moved
  hw/mips_gictimer: provide API for retrieving frequency
  hw/mips_gic: Update pin state on mask changes
  target-mips: Provide function to test if a CPU supports an ISA
  dtc: Update requirement to v1.4.2
  loader: Support Flattened Image Trees (FIT images)
  hw: xilinx-pcie: Add support for Xilinx AXI PCIe Controller
  hw/mips: MIPS Boston board support

 configure                            |   8 +-
 default-configs/mips64el-softmmu.mak |   2 +
 dtc                                  |   2 +-
 hw/core/Makefile.objs                |   1 +
 hw/core/loader-fit.c                 | 325 ++++++++++++++++++++
 hw/core/loader.c                     |   7 +-
 hw/intc/mips_gic.c                   |  56 ++--
 hw/mips/Makefile.objs                |   1 +
 hw/mips/boston.c                     | 576 +++++++++++++++++++++++++++++=
++++++
 hw/misc/mips_cmgcr.c                 |  17 ++
 hw/pci-host/Makefile.objs            |   1 +
 hw/pci-host/xilinx-pcie.c            | 328 ++++++++++++++++++++
 hw/timer/mips_gictimer.c             |   5 +
 include/hw/loader-fit.h              |  41 +++
 include/hw/loader.h                  |   6 +
 include/hw/misc/mips_cmgcr.h         |   3 +
 include/hw/pci-host/xilinx-pcie.h    |  68 +++++
 include/hw/timer/mips_gictimer.h     |   1 +
 target/mips/cpu.h                    |   1 +
 target/mips/translate.c              |  10 +
 20 files changed, 1423 insertions(+), 36 deletions(-)
 create mode 100644 hw/core/loader-fit.c
 create mode 100644 hw/mips/boston.c
 create mode 100644 hw/pci-host/xilinx-pcie.c
 create mode 100644 include/hw/loader-fit.h
 create mode 100644 include/hw/pci-host/xilinx-pcie.h

--=20
2.7.4
