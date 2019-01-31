Received: from eggs.gnu.org ([209.51.188.92]:35616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qC-0005yk-6z
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6qB-0002ZB-6X
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:60053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6qA-0002Vv-TO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:32:51 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:07 +0800
Message-Id: <20190131073234.18037-1-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 00/27] make qemu configurable for Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

This patch set is part of Kconfig task, and our target is to make
all platform's code file configurable for Kconfig, which is suitable
for add "config XXX" for all platforms.

As for Kconfig patch set(RFC v5), please ref below thread:
http://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg06466.html

The change list:

non-rfc v5 --> v1:
       patch 1 : update the commit message(Thomas Huth)
       patch 2 : add ioport.o to ide isa and ide piix(Thomas Huth)
       patch 7 : CONFIG_ARM_VIRT to replace CONFIG_VIRT(Thomas Huth)
       patch 13: CONFIG_S390_CCW_VIRTIO is only for s390-virtio-ccw.o(Thomas Huth)
       patch 23: CONFIG_MOXIESIM to replace CONFIG_MOXIE(Thomas Huth)
       patch 24: CONFIG_OR1K_SIM to replace CONFIG_OPENRISC(Thomas Huth)

Paolo Bonzini (8):
  arm: disable CONFIG_SERIAL_ISA
  ide: split ioport registration to a separate file
  vfio: move conditional up to hw/Makefile.objs
  build: actually use CONFIG_PAM
  hw/i386/Makefile.objs: Build pc_piix* and pc_q35 boards
  hw/s390/Makefile.objs: Create new CONFIG_* variables for s390x boards
    and devices
  hw/i2c/Makefile.objs: Create new CONFIG_* variables for EEPROM and
    ACPI controller
  hw/vfio/Makefile.objs: Create new CONFIG_* variables for VFIO core and
    PCI

Yang Zhong (11):
  hw/pci-host/Makefile.objs: make CONFIGS clear for PCI EXPRESS
  hw/arm/Makefile.objs: CONFIG_VIRT created for virt board
  hw/nios2/Makefile.objs: Conditionally build nios2
  hw/riscv/Makefile.objs: Create CONFIG_* for riscv boards
  hw/sparc64/Makefile.objs: Create CONFIG_* for sparc64
  hw/alpha/Makefile.objs: Create CONFIG_* for alpha
  hw/cris/Makefile.objs: Create CONFIG_* for cris
  hw/hppa/Makefile.objs: Create CONFIG_* for hppa
  hw/moxie/Makefile.objs: Conditionally build moxie
  hw/openrisc/Makefile.objs: Create CONFIG_* for openrisc
  hw/tricore/Makefile.objs: Create CONFIG_* for tricore

Ákos Kovács (8):
  hw/m68k/Makefile.objs: Conditionally build boards
  hw/microblaze/Makefile.objs: Create configs for petalogix and xilinx
    boards
  hw/mips/Makefile.objs: Create CONFIG_* for r4k, malta, mipssim boards
  hw/ppc/Makefile.objs: Build all boards conditinally with CONFIG_*
  hw/sh4/Makefile.objs: New CONFIG_* varibales created for sh4 boards
    and device
  hw/sparc/Makefile.objs: CONFIG_* for sun4m and leon3 created
  hw/lm32/Makefile.objs: Conditionally build lm32 and milkmyst
  hw/xtensa/Makefile.objs: Build xtensa_sim and xtensa_fpga
    conditionally

 default-configs/alpha-softmmu.mak       |  1 +
 default-configs/arm-softmmu.mak         |  9 ++--
 default-configs/cris-softmmu.mak        |  1 +
 default-configs/hppa-softmmu.mak        |  1 +
 default-configs/i386-softmmu.mak        |  7 ++-
 default-configs/m68k-softmmu.mak        |  2 +
 default-configs/microblaze-softmmu.mak  |  3 ++
 default-configs/mips-softmmu-common.mak |  5 ++
 default-configs/mips64el-softmmu.mak    |  2 +-
 default-configs/moxie-softmmu.mak       |  1 +
 default-configs/nios2-softmmu.mak       |  1 +
 default-configs/or1k-softmmu.mak        |  1 +
 default-configs/pci.mak                 |  4 +-
 default-configs/ppc-softmmu.mak         |  8 ++-
 default-configs/ppc64-softmmu.mak       |  1 +
 default-configs/riscv32-softmmu.mak     |  9 +++-
 default-configs/riscv64-softmmu.mak     |  9 +++-
 default-configs/s390x-softmmu.mak       |  6 ++-
 default-configs/sh4-softmmu.mak         |  2 +
 default-configs/sh4eb-softmmu.mak       |  2 +
 default-configs/sparc-softmmu.mak       |  2 +
 default-configs/sparc64-softmmu.mak     |  2 +
 default-configs/tricore-softmmu.mak     |  1 +
 default-configs/xtensa-softmmu.mak      |  3 ++
 default-configs/xtensaeb-softmmu.mak    |  3 ++
 hw/Makefile.objs                        |  2 +-
 hw/alpha/Makefile.objs                  |  2 +-
 hw/arm/Makefile.objs                    |  3 +-
 hw/cris/Makefile.objs                   |  2 +-
 hw/hppa/Makefile.objs                   |  2 +-
 hw/i2c/Makefile.objs                    |  5 +-
 hw/i386/Makefile.objs                   |  4 +-
 hw/ide/Makefile.objs                    |  4 +-
 hw/ide/core.c                           | 25 ----------
 hw/ide/ioport.c                         | 66 +++++++++++++++++++++++++
 hw/lm32/Makefile.objs                   |  4 +-
 hw/m68k/Makefile.objs                   |  4 +-
 hw/microblaze/Makefile.objs             |  6 +--
 hw/mips/Makefile.objs                   |  5 +-
 hw/moxie/Makefile.objs                  |  2 +-
 hw/net/Makefile.objs                    |  4 +-
 hw/nios2/Makefile.objs                  |  3 +-
 hw/openrisc/Makefile.objs               |  2 +-
 hw/pci-host/Makefile.objs               | 10 ++--
 hw/ppc/Makefile.objs                    | 11 +++--
 hw/riscv/Makefile.objs                  | 22 ++++-----
 hw/s390x/Makefile.objs                  |  2 +-
 hw/sh4/Makefile.objs                    |  4 +-
 hw/sparc/Makefile.objs                  |  4 +-
 hw/sparc64/Makefile.objs                |  6 +--
 hw/tricore/Makefile.objs                |  2 +-
 hw/vfio/Makefile.objs                   |  9 ++--
 hw/xtensa/Makefile.objs                 |  4 +-
 53 files changed, 208 insertions(+), 97 deletions(-)
 create mode 100644 hw/ide/ioport.c

-- 
2.17.1
