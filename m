Received: from eggs.gnu.org ([2001:4830:134:3::10]:38222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofW-0008MO-2F
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofS-0004B6-SI
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:21 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofS-0004Ae-Jn
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:18 -0500
Received: by mail-wr1-x42d.google.com with SMTP id c14so5699429wrr.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.16
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:41:52 +0000
Message-Id: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/22] misc queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is a colletion of miscellaneous patches (mostly mine),
which fix minor bugs or do some refactoring/cleanup.
No user-visible changes in here.

thanks
-- PMM

The following changes since commit 0f98c9945899c5dfacd5a410ff04178eda605a16:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-12-12' into staging (2018-12-14 10:19:47 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-misc-20181214

for you to fetch changes up to bbac02f1e8edfd0663543f6fdad1e7094d860b29:

  virt: Fix broken indentation (2018-12-14 13:30:55 +0000)

----------------------------------------------------------------
miscellaneous patches:
 * checkpatch.pl: Enforce multiline comment syntax
 * Rename cpu_physical_memory_write_rom() to address_space_write_rom()
 * disas, monitor, elf_ops: Use address_space_read() to read memory
 * Remove load_image() in favour of load_image_size()
 * Fix some minor memory leaks in arm boards/devices
 * virt: fix broken indentation

----------------------------------------------------------------
Eduardo Habkost (1):
      virt: Fix broken indentation

Peter Maydell (21):
      scripts/checkpatch.pl: Enforce multiline comment syntax
      exec.c: Rename cpu_physical_memory_write_rom_internal()
      Rename cpu_physical_memory_write_rom() to address_space_write_rom()
      disas.c: Use address_space_read() to read memory
      monitor: Use address_space_read() to read memory
      elf_ops.h: Use address_space_write() to write memory
      hw/ppc/mac_newworld, mac_oldworld: Don't use load_image()
      hw/ppc/ppc405_boards: Don't use load_image()
      hw/smbios/smbios.c: Don't use load_image()
      hw/pci/pci.c: Don't use load_image()
      hw/i386/pc.c: Don't use load_image()
      hw/i386/multiboot.c: Don't use load_image()
      hw/block/tc58128.c: Don't use load_image()
      device_tree.c: Don't use load_image()
      hw/core/loader.c: Remove load_image()
      include/hw/loader.h: Document load_image_size()
      target/arm: Free name string in ARMCPRegInfo hashtable entries
      hw/arm/mps2-tz.c: Free mscname string in make_dma()
      hw/sd/sdhci: Don't leak memory region in sdhci_sysbus_realize()
      tests/test-arm-mptimer: Don't leak string memory
      target/arm: Create timers in realize, not init

 include/exec/cpu-common.h   |   2 -
 include/exec/memory.h       |  26 ++++++++
 include/hw/elf_ops.h        |   4 +-
 include/hw/loader.h         |  17 ++++-
 device_tree.c               |   2 +-
 disas.c                     |   5 +-
 exec.c                      |  30 +++++----
 hw/arm/mps2-tz.c            |   1 +
 hw/arm/virt.c               |   2 +-
 hw/block/tc58128.c          |   3 +-
 hw/core/loader.c            |  29 +--------
 hw/i386/multiboot.c         |   6 +-
 hw/i386/pc.c                |  22 ++++---
 hw/intc/apic.c              |   7 +-
 hw/misc/tz-mpc.c            |   2 +-
 hw/pci/pci.c                |   6 +-
 hw/ppc/mac_newworld.c       |  10 ++-
 hw/ppc/mac_oldworld.c       |  10 ++-
 hw/ppc/ppc405_boards.c      |  12 ++--
 hw/sd/sdhci.c               |   5 +-
 hw/smbios/smbios.c          |   2 +-
 hw/sparc/sun4m.c            |   5 +-
 monitor.c                   |   8 ++-
 target/arm/cpu.c            |  33 +++++++---
 tests/test-arm-mptimer.c    | 153 ++++++++++++++++++++------------------------
 docs/devel/loads-stores.rst |  35 +++++-----
 scripts/checkpatch.pl       |  48 ++++++++++++++
 27 files changed, 287 insertions(+), 198 deletions(-)
