Received: from eggs.gnu.org ([209.51.188.92]:45611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gi1Cg-0008QB-3i
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gi1Ce-0002dU-3N
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:46 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gi1Cc-0002Xx-2k
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:06:43 -0500
Received: by mail-pf1-x442.google.com with SMTP id w73so7289766pfk.10
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:06:37 -0800 (PST)
Date: Fri, 11 Jan 2019 10:06:26 -0800
Message-Id: <20190111180630.6433-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL] RISC-V Updates for 3.2, Part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-request' into staging (2019-01-08 16:07:32 +0000)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-3.2-part2

for you to fetch changes up to f7cdfa38f37e0985457ac03c3238861144a58b4c:

  default-configs: Enable USB support for RISC-V machines (2019-01-09 17:34:10 -0800)

----------------------------------------------------------------
RISC-V Updates for 3.2, Part 2

This patch set contains a handful of Michael's CSR-related cleanups,
which should allow us to proceed with more outstanding bug fixes that
depend on them.

Additionally, there is a patch that turns on USB.  This works for me
when the kernel has the appropriate drivers (which will soon be in
defconfig) and I pass

    -device usb-ehci
    -drive id=my_usb_disk,file=usbdisk.img,if=none,format=raw
    -device usb-storage,drive=my_usb_disk

to QEMU.

----------------------------------------------------------------
Alistair Francis (1):
      default-configs: Enable USB support for RISC-V machines

Michael Clark (3):
      RISC-V: Implement modular CSR helper interface
      RISC-V: Implement atomic mip/sip CSR updates
      RISC-V: Implement existential predicates for CSRs

 default-configs/riscv32-softmmu.mak |   1 +
 default-configs/riscv64-softmmu.mak |   1 +
 target/riscv/Makefile.objs          |   2 +-
 target/riscv/cpu.c                  |   6 +
 target/riscv/cpu.h                  |  41 +-
 target/riscv/cpu_helper.c           |   7 +-
 target/riscv/csr.c                  | 863 ++++++++++++++++++++++++++++++++++++
 target/riscv/gdbstub.c              |  10 +-
 target/riscv/op_helper.c            | 613 +------------------------
 9 files changed, 935 insertions(+), 609 deletions(-)
 create mode 100644 target/riscv/csr.c
