Received: from eggs.gnu.org ([2001:4830:134:3::10]:52691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNGw-0001FE-F1
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gaNGv-0003xc-KD
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:34 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gaNGv-0003xD-Fu
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:03:33 -0500
Received: by mail-qt1-x833.google.com with SMTP id k12so6181895qtf.7
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 08:03:33 -0800 (PST)
Date: Fri, 21 Dec 2018 08:02:53 -0800
Message-Id: <20181221160307.14819-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PR RFC] RISC-V Changes for 3.2, Part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org

The following changes since commit b72566a4ffaddbc0c0c1f6f5ee91b42ab13ff429:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2018-12-19 15:31:02 +0000)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-3.2-part1

for you to fetch changes up to 7b91ae7d7944056c5e8045342e4039e978e43c82:

  MAINTAINERS: Mark RISC-V as Supported (2018-12-21 07:57:15 -0800)

----------------------------------------------------------------
RISC-V Changes for 3.2, Part 1

This pull request contains the first set of RISC-V patches I'd like to
target for the 3.2 development cycle.  It's really just a collection of
bug fixes with one major new feature: PCIe can now be attached to RISC-V
guests.

This has passed my usual test of booting the latest Linux RC into a
Fedora disk image on the virt machine.

----------------------------------------------------------------
Alistair Francis (4):
      hw/riscv/virt: Increase the number of interrupts
      hw/riscv/virt: Adjust memory layout spacing
      hw/riscv/virt: Connect the gpex PCIe
      riscv: Enable VGA and PCIE_VGA

Anup Patel (3):
      sifive_u: Add clock DT node for GEM ethernet
      sifive_u: Set 'clock-frequency' DT property for SiFive UART
      target/riscv/pmp.c: Fix pmp_decode_napot()

Mao Zhongyi (1):
      riscv/cpu: use device_class_set_parent_realize

Michael Clark (4):
      RISC-V: Add hartid and \n to interrupt logging
      RISC-V: Fix CLINT timecmp low 32-bit writes
      RISC-V: Fix PLIC pending bitfield reads
      RISC-V: Enable second UART on sifive_e and sifive_u

Nathaniel Graff (1):
      sifive_uart: Implement interrupt pending register

Palmer Dabbelt (1):
      MAINTAINERS: Mark RISC-V as Supported

 MAINTAINERS                         |   2 +-
 default-configs/riscv32-softmmu.mak |   8 +-
 default-configs/riscv64-softmmu.mak |   8 +-
 hw/riscv/sifive_clint.c             |   8 +-
 hw/riscv/sifive_e.c                 |   5 +-
 hw/riscv/sifive_plic.c              |   2 +-
 hw/riscv/sifive_u.c                 |  25 +++++-
 hw/riscv/sifive_uart.c              |  24 ++++--
 hw/riscv/virt.c                     | 147 +++++++++++++++++++++++++++++++++---
 include/hw/riscv/sifive_u.h         |   3 +-
 include/hw/riscv/sifive_uart.h      |   3 +
 include/hw/riscv/virt.h             |  15 +++-
 target/riscv/cpu.c                  |   4 +-
 target/riscv/cpu_helper.c           |  18 +++--
 target/riscv/pmp.c                  |   2 +-
 15 files changed, 231 insertions(+), 43 deletions(-)
