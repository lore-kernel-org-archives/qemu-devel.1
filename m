Received: from eggs.gnu.org ([2001:4830:134:3::10]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cgKiD-0000VE-2S
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 19:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cgKi8-0002WY-Vv
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 19:23:17 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:49118)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cgKi8-0002VK-QA
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 19:23:12 -0500
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id 1A439ED66E605
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 00:23:04 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Wed, 22 Feb 2017 00:21:00 +0000
Message-ID: <1487722868-9111-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/8] target-mips queue
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

This is the v2 of the pull-req for target-mips.
The warning treated as error has been fixed and the file is now isolated =
for mips64el only.
Boston has further update to have default -drive to if=3Dide.=20

Regards,
Yongbok

The following changes since commit 796b288f7be875045670f963ce99991b3c8e96=
ac:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2017-02-21 15:48:22 +0000)

are available in the git repository at:

  git://github.com/yongbok/upstream-qemu.git tags/mips-20170222

for you to fetch changes up to d3473e147a754e999718bf6fcb015d9978c6a1ee:

  hw/mips: MIPS Boston board support (2017-02-21 23:49:30 +0000)

----------------------------------------------------------------
MIPS patches 2017-02-22

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
 default-configs/mips64el-softmmu.mak |   3 +
 dtc                                  |   2 +-
 hw/core/Makefile.objs                |   1 +
 hw/core/loader-fit.c                 | 325 ++++++++++++++++++++
 hw/core/loader.c                     |   7 +-
 hw/intc/mips_gic.c                   |  56 ++--
 hw/mips/Makefile.objs                |   1 +
 hw/mips/boston.c                     | 577 +++++++++++++++++++++++++++++=
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
 20 files changed, 1425 insertions(+), 36 deletions(-)
 create mode 100644 hw/core/loader-fit.c
 create mode 100644 hw/mips/boston.c
 create mode 100644 hw/pci-host/xilinx-pcie.c
 create mode 100644 include/hw/loader-fit.h
 create mode 100644 include/hw/pci-host/xilinx-pcie.h

--=20
2.7.4
