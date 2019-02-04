Received: from eggs.gnu.org ([209.51.188.92]:59110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6h-0004v6-Lo
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6e-0003Mm-2r
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:34 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj6a-0003Fv-Ox
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:30 -0500
Received: by mail-wr1-x443.google.com with SMTP id f7so992309wrp.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:36:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.36.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:36:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:02 +0100
Message-Id: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/77] Misc patches for 2019-02-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 773c4a6228fd910556cee2d477ee56c591a30000:

  test-filter-mirror: pass UNIX domain socket through fd (2019-02-04 16:03:20 +0000)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 338412de933cfbfe92b6061e53a6bae11b47abb5:

  queue: fix QTAILQ_FOREACH_REVERSE_SAFE (2019-02-04 18:40:56 +0100)

----------------------------------------------------------------
* cpu-exec fixes (Emilio, Laurent)
* TCG bugfix in queue.h (Paolo)
* high address load for linuxboot (Zhijian)
* PVH support (Liam, Stefano)
* misc i386 changes (Paolo, Robert, Doug)
* configure tweak for openpty (Thomas)
* elf2dmp port to Windows (Viktor)
* initial improvements to Makefile infrastructure (Yang + GSoC 2013)

----------------------------------------------------------------
David Hildenbrand (1):
      pc: Use hotplug_handler_(plug|unplug|unplug_request)

Doug Gale (1):
      gdbstub: Fix i386/x86_64 machine description and add control registers

Emilio G. Cota (2):
      cpu-exec: add assert_no_pages_locked() after longjmp
      cpu-exec: reset BQL after longjmp in cpu_exec_step_atomic

Heiher (1):
      i386: hvf: Fix smp boot hangs

Laurent Vivier (3):
      cpus: ignore ESRCH in qemu_cpu_kick_thread()
      scsi-disk: Convert from DPRINTF() macro to trace events
      scsi-generic: Convert from DPRINTF() macro to trace events

Li Zhijian (4):
      unify len and addr type for memory/address APIs
      hw/core/loader.c: Read as long as possible in load_image_size()
      i386: import & use bootparam.h
      i386: allow to load initrd below 4 GB for recent linux

Liam Merwick (4):
      elf: Add optional function ptr to load_elf() to parse ELF notes
      elf-ops.h: Add get_elf_note_type()
      pvh: Add x86/HVM direct boot ABI header file
      pvh: Boot uncompressed kernel using direct boot ABI

Paolo Bonzini (24):
      vhost-user-test: use g_cond_broadcast
      vhost-user-test: signal data_cond when s->rings changes
      vhost-user: support cross-endian vnet headers
      vhost-user-test: support VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
      vhost-user-test: skip if there is no memory at address 0
      vhost-user-test: reduce usage of global_qtest
      tap: flush STDOUT on newline
      i386: remove the 'INTEL_PT' CPUID bit from named CPU models
      target-i386: hvf: remove MPX support
      monitor: do not use QTAILQ_FOREACH_SAFE across critical sections
      crypto: finish removing TABs
      ui: vnc: finish removing TABs
      docker: adjust Xen repository for CentOS 7
      scsi-generic: avoid possible out-of-bounds access to r->buf
      qemu-options: Remove deprecated "-virtioconsole" option
      arm: disable CONFIG_SERIAL_ISA
      ide: split ioport registration to a separate file
      vfio: move conditional up to hw/Makefile.objs
      build: actually use CONFIG_PAM
      hw/i386/Makefile.objs: Build pc_piix* and pc_q35 boards
      hw/s390/Makefile.objs: Create new CONFIG_* variables for s390x boards and devices
      hw/i2c/Makefile.objs: Create new CONFIG_* variables for EEPROM and ACPI controller
      hw/vfio/Makefile.objs: Create new CONFIG_* variables for VFIO core and PCI
      queue: fix QTAILQ_FOREACH_REVERSE_SAFE

Robert Hoo (2):
      i386: remove the new CPUID 'PCONFIG' from Icelake-Server CPU model
      Revert "i386: Add CPUID bit for PCONFIG"

Roman Bolshakov (1):
      i386: hvf: Don't miss 16-bit displacement

Stefano Garzarella (7):
      pvh: load initrd and expose it through fw_cfg
      linuxboot_dma: remove duplicate definitions of FW_CFG
      linuxboot_dma: move common functions in a new header
      optionrom: add new PVH option rom
      hw/i386/pc: use PVH option rom
      optionrom/pvh: load initrd from fw_cfg
      hw/i386/pc: enable PVH only for machine type >= 4.0

Thomas Huth (2):
      configure: Add a proper check for openpty() in libutil
      Remove deprecated -enable-hax option

Viktor Prutyanov (6):
      contrib/elf2dmp: fix elf.h including
      contrib/elf2dmp: use GLib in ELF processing
      contrib/elf2dmp: use GLib in PDB processing
      contrib/elf2dmp: fix structures definitions
      contrib/elf2dmp: fix printf format
      configure: enable elf2dmp build for Windows hosts

Yang Zhong (11):
      hw/pci-host/Makefile.objs: make CONFIGS clear for PCI EXPRESS
      hw/arm/Makefile.objs: CONFIG_ARM_VIRT created for virt board
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
      hw/microblaze/Makefile.objs: Create configs for petalogix and xilinx boards
      hw/mips/Makefile.objs: Create CONFIG_* for r4k, malta, mipssim boards
      hw/ppc/Makefile.objs: Build all boards conditinally with CONFIG_*
      hw/sh4/Makefile.objs: New CONFIG_* varibales created for sh4 boards and device
      hw/sparc/Makefile.objs: CONFIG_* for sun4m and leon3 created
      hw/lm32/Makefile.objs: Conditionally build lm32 and milkmyst
      hw/xtensa/Makefile.objs: Build xtensa_sim and xtensa_fpga conditionally

 .gitignore                                   |   4 +
 Makefile                                     |   6 +-
 accel/tcg/cpu-exec.c                         |   4 +
 configure                                    |  20 +-
 contrib/elf2dmp/kdbg.h                       |  12 +-
 contrib/elf2dmp/main.c                       |  27 +-
 contrib/elf2dmp/pdb.c                        |  33 +-
 contrib/elf2dmp/pdb.h                        |   4 +-
 contrib/elf2dmp/pe.h                         |   6 +-
 contrib/elf2dmp/qemu_elf.c                   |  27 +-
 contrib/elf2dmp/qemu_elf.h                   |  10 +-
 cpus.c                                       |   2 +-
 crypto/aes.c                                 | 414 +++++++++----------
 crypto/desrfb.c                              | 594 +++++++++++++--------------
 default-configs/alpha-softmmu.mak            |   1 +
 default-configs/arm-softmmu.mak              |   9 +-
 default-configs/cris-softmmu.mak             |   1 +
 default-configs/hppa-softmmu.mak             |   1 +
 default-configs/i386-softmmu.mak             |   7 +-
 default-configs/m68k-softmmu.mak             |   2 +
 default-configs/microblaze-softmmu.mak       |   3 +
 default-configs/mips-softmmu-common.mak      |   5 +
 default-configs/mips64el-softmmu.mak         |   2 +-
 default-configs/moxie-softmmu.mak            |   1 +
 default-configs/nios2-softmmu.mak            |   1 +
 default-configs/or1k-softmmu.mak             |   1 +
 default-configs/pci.mak                      |   4 +-
 default-configs/ppc-softmmu.mak              |   8 +-
 default-configs/riscv32-softmmu.mak          |   9 +-
 default-configs/riscv64-softmmu.mak          |   9 +-
 default-configs/s390x-softmmu.mak            |   6 +-
 default-configs/sh4-softmmu.mak              |   2 +
 default-configs/sh4eb-softmmu.mak            |   2 +
 default-configs/sparc-softmmu.mak            |   2 +
 default-configs/sparc64-softmmu.mak          |   2 +
 default-configs/tricore-softmmu.mak          |   1 +
 default-configs/xtensa-softmmu.mak           |   3 +
 default-configs/xtensaeb-softmmu.mak         |   3 +
 docs/qdev-device-use.txt                     |   4 -
 exec.c                                       |  47 ++-
 gdb-xml/i386-32bit-core.xml                  |  65 ---
 gdb-xml/i386-32bit-sse.xml                   |  52 ---
 gdb-xml/i386-32bit.xml                       | 184 ++++++++-
 gdb-xml/i386-64bit-core.xml                  |  73 ----
 gdb-xml/i386-64bit-sse.xml                   |  60 ---
 gdb-xml/i386-64bit.xml                       | 210 +++++++++-
 hw/Makefile.objs                             |   2 +-
 hw/alpha/Makefile.objs                       |   2 +-
 hw/alpha/dp264.c                             |   4 +-
 hw/arm/Makefile.objs                         |   3 +-
 hw/arm/armv7m.c                              |   3 +-
 hw/arm/boot.c                                |   2 +-
 hw/core/generic-loader.c                     |   2 +-
 hw/core/loader.c                             |  35 +-
 hw/cris/Makefile.objs                        |   2 +-
 hw/cris/boot.c                               |   3 +-
 hw/hppa/Makefile.objs                        |   2 +-
 hw/hppa/machine.c                            |   6 +-
 hw/i2c/Makefile.objs                         |   5 +-
 hw/i386/Makefile.objs                        |   4 +-
 hw/i386/multiboot.c                          |   2 +-
 hw/i386/pc.c                                 | 221 ++++++++--
 hw/i386/pc_piix.c                            |   3 +
 hw/i386/pc_q35.c                             |   3 +
 hw/ide/Makefile.objs                         |   4 +-
 hw/ide/core.c                                |  25 --
 hw/ide/ioport.c                              |  66 +++
 hw/lm32/Makefile.objs                        |   4 +-
 hw/lm32/lm32_boards.c                        |   6 +-
 hw/lm32/milkymist.c                          |   3 +-
 hw/m68k/Makefile.objs                        |   4 +-
 hw/m68k/an5206.c                             |   2 +-
 hw/m68k/mcf5208.c                            |   2 +-
 hw/microblaze/Makefile.objs                  |   6 +-
 hw/microblaze/boot.c                         |   7 +-
 hw/mips/Makefile.objs                        |   5 +-
 hw/mips/mips_fulong2e.c                      |   5 +-
 hw/mips/mips_malta.c                         |   5 +-
 hw/mips/mips_mipssim.c                       |   5 +-
 hw/mips/mips_r4k.c                           |   5 +-
 hw/moxie/Makefile.objs                       |   2 +-
 hw/moxie/moxiesim.c                          |   2 +-
 hw/net/Makefile.objs                         |   4 +-
 hw/nios2/Makefile.objs                       |   3 +-
 hw/nios2/boot.c                              |   7 +-
 hw/openrisc/Makefile.objs                    |   2 +-
 hw/openrisc/openrisc_sim.c                   |   2 +-
 hw/pci-host/Makefile.objs                    |  10 +-
 hw/pci-host/prep.c                           |   2 +-
 hw/ppc/Makefile.objs                         |  11 +-
 hw/ppc/e500.c                                |   3 +-
 hw/ppc/mac_newworld.c                        |   5 +-
 hw/ppc/mac_oldworld.c                        |   5 +-
 hw/ppc/ppc440_bamboo.c                       |   2 +-
 hw/ppc/sam460ex.c                            |   3 +-
 hw/ppc/spapr.c                               |   7 +-
 hw/ppc/virtex_ml507.c                        |   2 +-
 hw/riscv/Makefile.objs                       |  22 +-
 hw/riscv/sifive_e.c                          |   2 +-
 hw/riscv/sifive_u.c                          |   2 +-
 hw/riscv/spike.c                             |   2 +-
 hw/riscv/virt.c                              |   2 +-
 hw/s390x/Makefile.objs                       |   2 +-
 hw/s390x/ipl.c                               |   9 +-
 hw/scsi/scsi-disk.c                          | 103 +++--
 hw/scsi/scsi-generic.c                       |  74 ++--
 hw/scsi/trace-events                         |  40 ++
 hw/sh4/Makefile.objs                         |   4 +-
 hw/sparc/Makefile.objs                       |   4 +-
 hw/sparc/leon3.c                             |   3 +-
 hw/sparc/sun4m.c                             |   6 +-
 hw/sparc64/Makefile.objs                     |   6 +-
 hw/sparc64/sun4u.c                           |   4 +-
 hw/tricore/Makefile.objs                     |   2 +-
 hw/tricore/tricore_testboard.c               |   2 +-
 hw/vfio/Makefile.objs                        |   9 +-
 hw/xtensa/Makefile.objs                      |   4 +-
 hw/xtensa/sim.c                              |  12 +-
 hw/xtensa/xtfpga.c                           |   2 +-
 include/elf.h                                |  10 +
 include/exec/cpu-all.h                       |   2 +-
 include/exec/cpu-common.h                    |   8 +-
 include/exec/memory.h                        |  22 +-
 include/hw/boards.h                          |   1 -
 include/hw/elf_ops.h                         |  77 ++++
 include/hw/i386/pc.h                         |   3 +
 include/hw/loader.h                          |   9 +-
 include/hw/xen/start_info.h                  | 146 +++++++
 include/qemu/queue.h                         |   2 +-
 include/standard-headers/asm-x86/bootparam.h |  34 ++
 monitor.c                                    |   5 +-
 net/vhost-user.c                             |  13 +
 pc-bios/optionrom/Makefile                   |   5 +-
 pc-bios/optionrom/linuxboot_dma.c            | 114 +----
 pc-bios/optionrom/optrom.h                   | 110 +++++
 pc-bios/optionrom/optrom_fw_cfg.h            |  92 +++++
 pc-bios/optionrom/pvh.S                      | 200 +++++++++
 pc-bios/optionrom/pvh_main.c                 | 133 ++++++
 pc-bios/pvh.bin                              | Bin 0 -> 1536 bytes
 qemu-deprecated.texi                         |  10 -
 qemu-options.hx                              |  21 -
 scripts/tap-driver.pl                        |   1 +
 scripts/tap-merge.pl                         |   1 +
 scripts/update-linux-headers.sh              |   6 +
 target/i386/cpu.c                            |  17 +-
 target/i386/cpu.h                            |   1 -
 target/i386/gdbstub.c                        | 193 ++++++++-
 target/i386/hvf/hvf.c                        |   5 -
 target/i386/hvf/x86_cpuid.c                  |  18 +-
 target/i386/hvf/x86_decode.c                 |   2 +-
 tests/Makefile.include                       |   4 -
 tests/docker/dockerfiles/centos7.docker      |   5 +-
 tests/vhost-user-test.c                      | 104 +++--
 ui/vnc-enc-hextile-template.h                | 268 ++++++------
 ui/vnc-enc-zywrle.h                          | 394 +++++++++---------
 vl.c                                         |  66 +--
 156 files changed, 3109 insertions(+), 1782 deletions(-)
 delete mode 100644 gdb-xml/i386-32bit-core.xml
 delete mode 100644 gdb-xml/i386-32bit-sse.xml
 delete mode 100644 gdb-xml/i386-64bit-core.xml
 delete mode 100644 gdb-xml/i386-64bit-sse.xml
 create mode 100644 hw/ide/ioport.c
 create mode 100644 include/hw/xen/start_info.h
 create mode 100644 include/standard-headers/asm-x86/bootparam.h
 create mode 100644 pc-bios/optionrom/optrom.h
 create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h
 create mode 100644 pc-bios/optionrom/pvh.S
 create mode 100644 pc-bios/optionrom/pvh_main.c
 create mode 100644 pc-bios/pvh.bin
-- 
1.8.3.1
