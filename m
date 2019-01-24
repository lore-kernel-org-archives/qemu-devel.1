Received: from eggs.gnu.org ([209.51.188.92]:59035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmdbL-0006p2-Nu
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmdbH-0007j8-Nv
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:55:17 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmdbH-0007fz-Ez
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:55:15 -0500
Received: by mail-ot1-x341.google.com with SMTP id e12so4978352otl.5
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:55:13 -0800 (PST)
MIME-Version: 1.0
References: <1548205322-36101-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548205322-36101-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 11:55:01 +0000
Message-ID: <CAFEAcA91mX80Aqi7-rkKSRh20U1Mt_=rSa_yDWYYsRaOzeyxkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/51] Misc patches for 2019-01-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 23 Jan 2019 at 01:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit cce871c504694cf1034adf525556e3ca3c7eebb6:
>
>   hw/block/xen: use proper format string for printing sectors (2019-01-21 14:45:49 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3cf01054d896fa88ea0dd31c5abb605c2e68bb29:
>
>   docker: disable Xen on CentOS 7 (2019-01-23 01:40:47 +0100)
>
> ----------------------------------------------------------------
> * cpu-exec fixes (Emilio, Laurent)
> * high address load for linuxboot (Zhijian)
> * PVH support (Liam, Stefano)
> * Linux header update (Paolo)
> * enable vhost-net for all targets that have virtio-net (Paolo)
> * vhost-user-test cleanups (Paolo)
> * misc i386 changes (Paolo, Robert)
> * hexloader-test change to avoid O_NONBLOCK on stdin (Peter)
> * configure tweak for openpty (Thomas)
> * elf2dmp port to Windows (Viktor)
>
> ----------------------------------------------------------------
> v1->v2: clang fixes, new patch to tie PVH support to the machine type
>
> Emilio G. Cota (2):
>       cpu-exec: add assert_no_pages_locked() after longjmp
>       cpu-exec: reset BQL after longjmp in cpu_exec_step_atomic
>
> Laurent Vivier (1):
>       cpus: ignore ESRCH in qemu_cpu_kick_thread()
>
> Li Zhijian (4):
>       unify len and addr type for memory/address APIs
>       hw/core/loader.c: Read as long as possible in load_image_size()
>       i386: import & use bootparam.h
>       i386: allow to load initrd below 4 GB for recent linux
>
> Liam Merwick (4):
>       elf: Add optional function ptr to load_elf() to parse ELF notes
>       elf-ops.h: Add get_elf_note_type()
>       pvh: Add x86/HVM direct boot ABI header file
>       pvh: Boot uncompressed kernel using direct boot ABI
>
> Paolo Bonzini (23):
>       scripts/update-linux-headers.sh: adjust for Linux 4.21-rc1 (or 5.0-rc1)
>       include: update Linux headers to 4.21-rc1/5.0-rc1
>       vhost-net: move stubs to a separate file
>       vhost-net-user: add stubs for when no virtio-net device is present
>       vhost: restrict Linux dependency to kernel vhost
>       vhost-net: compile it on all targets that have virtio-net.
>       vhost-net: revamp configure logic
>       vhost-user-test: use g_cond_broadcast
>       vhost-user-test: signal data_cond when s->rings changes
>       vhost-user: support cross-endian vnet headers
>       vhost-user-test: support VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
>       vhost-user-test: skip if there is no memory at address 0
>       vhost-user-test: reduce usage of global_qtest
>       vhost-user-test: create a main loop per TestServer
>       vhost-user-test: small changes to init_hugepagefs
>       vhost-user-test: create a temporary directory per TestServer
>       tap: flush STDOUT on newline
>       i386: remove the 'INTEL_PT' CPUID bit from named CPU models
>       target-i386: hvf: remove MPX support
>       monitor: do not use QTAILQ_FOREACH_SAFE across critical sections
>       crypto: finish removing TABs
>       ui: vnc: finish removing TABs
>       docker: disable Xen on CentOS 7
>
> Peter Maydell (1):
>       tests/hexloader-test: Don't pass -nographic to the QEMU under test
>
> Robert Hoo (2):
>       i386: remove the new CPUID 'PCONFIG' from Icelake-Server CPU model
>       Revert "i386: Add CPUID bit for PCONFIG"
>
> Stefano Garzarella (7):
>       pvh: load initrd and expose it through fw_cfg
>       linuxboot_dma: remove duplicate definitions of FW_CFG
>       linuxboot_dma: move common functions in a new header
>       optionrom: add new PVH option rom
>       hw/i386/pc: use PVH option rom
>       optionrom/pvh: load initrd from fw_cfg
>       hw/i386/pc: enable PVH only for machine type >= 4.0
>
> Thomas Huth (1):
>       configure: Add a proper check for openpty() in libutil
>
> Viktor Prutyanov (6):
>       contrib/elf2dmp: fix elf.h including
>       contrib/elf2dmp: use GLib in ELF processing
>       contrib/elf2dmp: use GLib in PDB processing
>       contrib/elf2dmp: fix structures definitions
>       contrib/elf2dmp: fix printf format
>       configure: enable elf2dmp build for Windows hosts
>
>  .gitignore                                         |    4 +
>  Makefile                                           |    6 +-
>  accel/tcg/cpu-exec.c                               |    4 +
>  backends/Makefile.objs                             |    5 +-
>  configure                                          |  118 ++-
>  contrib/elf2dmp/kdbg.h                             |   12 +-
>  contrib/elf2dmp/main.c                             |   27 +-
>  contrib/elf2dmp/pdb.c                              |   33 +-
>  contrib/elf2dmp/pdb.h                              |    4 +-
>  contrib/elf2dmp/pe.h                               |    6 +-
>  contrib/elf2dmp/qemu_elf.c                         |   27 +-
>  contrib/elf2dmp/qemu_elf.h                         |   10 +-
>  cpus.c                                             |    2 +-
>  crypto/aes.c                                       |  414 ++++----
>  crypto/desrfb.c                                    |  594 +++++------
>  default-configs/virtio.mak                         |    4 +-
>  exec.c                                             |   47 +-
>  hw/alpha/dp264.c                                   |    4 +-
>  hw/arm/armv7m.c                                    |    3 +-
>  hw/arm/boot.c                                      |    2 +-
>  hw/core/generic-loader.c                           |    2 +-
>  hw/core/loader.c                                   |   35 +-
>  hw/cris/boot.c                                     |    3 +-
>  hw/hppa/machine.c                                  |    6 +-
>  hw/i386/multiboot.c                                |    2 +-
>  hw/i386/pc.c                                       |  191 +++-
>  hw/i386/pc_piix.c                                  |    3 +
>  hw/i386/pc_q35.c                                   |    3 +
>  hw/lm32/lm32_boards.c                              |    6 +-
>  hw/lm32/milkymist.c                                |    3 +-
>  hw/m68k/an5206.c                                   |    2 +-
>  hw/m68k/mcf5208.c                                  |    2 +-
>  hw/microblaze/boot.c                               |    7 +-
>  hw/mips/mips_fulong2e.c                            |    5 +-
>  hw/mips/mips_malta.c                               |    5 +-
>  hw/mips/mips_mipssim.c                             |    5 +-
>  hw/mips/mips_r4k.c                                 |    5 +-
>  hw/moxie/moxiesim.c                                |    2 +-
>  hw/net/Makefile.objs                               |    4 +-
>  hw/net/vhost_net-stub.c                            |   92 ++
>  hw/net/vhost_net.c                                 |   85 +-
>  hw/nios2/boot.c                                    |    7 +-
>  hw/openrisc/openrisc_sim.c                         |    2 +-
>  hw/pci-host/prep.c                                 |    2 +-
>  hw/ppc/e500.c                                      |    3 +-
>  hw/ppc/mac_newworld.c                              |    5 +-
>  hw/ppc/mac_oldworld.c                              |    5 +-
>  hw/ppc/ppc440_bamboo.c                             |    2 +-
>  hw/ppc/sam460ex.c                                  |    3 +-
>  hw/ppc/spapr.c                                     |    7 +-
>  hw/ppc/virtex_ml507.c                              |    2 +-
>  hw/riscv/sifive_e.c                                |    2 +-
>  hw/riscv/sifive_u.c                                |    2 +-
>  hw/riscv/spike.c                                   |    2 +-
>  hw/riscv/virt.c                                    |    2 +-
>  hw/s390x/ipl.c                                     |    9 +-
>  hw/sparc/leon3.c                                   |    3 +-
>  hw/sparc/sun4m.c                                   |    6 +-
>  hw/sparc64/sun4u.c                                 |    4 +-
>  hw/tricore/tricore_testboard.c                     |    2 +-
>  hw/virtio/Makefile.objs                            |    8 +-
>  hw/virtio/vhost-backend.c                          |   12 +-
>  hw/virtio/vhost-user.c                             |   13 +-
>  hw/virtio/vhost.c                                  |    2 +-
>  hw/xtensa/sim.c                                    |   12 +-
>  hw/xtensa/xtfpga.c                                 |    2 +-
>  include/elf.h                                      |   10 +
>  include/exec/cpu-all.h                             |    2 +-
>  include/exec/cpu-common.h                          |    8 +-
>  include/exec/memory.h                              |   22 +-
>  include/exec/poison.h                              |    1 -
>  include/hw/elf_ops.h                               |   77 ++
>  include/hw/i386/pc.h                               |    3 +
>  include/hw/loader.h                                |    9 +-
>  include/hw/xen/start_info.h                        |  146 +++
>  include/standard-headers/asm-x86/bootparam.h       |   34 +
>  include/standard-headers/drm/drm_fourcc.h          |   63 ++
>  include/standard-headers/linux/ethtool.h           |   19 +-
>  include/standard-headers/linux/input-event-codes.h |   17 +
>  include/standard-headers/linux/pci_regs.h          |    1 +
>  include/standard-headers/linux/vhost_types.h       |  128 +++
>  include/standard-headers/linux/virtio_balloon.h    |    8 +
>  include/standard-headers/linux/virtio_blk.h        |   54 +
>  include/standard-headers/linux/virtio_config.h     |    3 +
>  include/standard-headers/linux/virtio_gpu.h        |   18 +
>  include/standard-headers/linux/virtio_ring.h       |   52 +
>  linux-headers/asm-arm/unistd-common.h              |    1 +
>  linux-headers/asm-arm64/unistd.h                   |    1 +
>  linux-headers/asm-generic/unistd.h                 |   10 +-
>  linux-headers/asm-mips/sgidefs.h                   |    8 -
>  linux-headers/asm-mips/unistd.h                    | 1074 +-------------------
>  linux-headers/asm-mips/unistd_n32.h                |  338 ++++++
>  linux-headers/asm-mips/unistd_n64.h                |  334 ++++++
>  linux-headers/asm-mips/unistd_o32.h                |  374 +++++++
>  linux-headers/asm-powerpc/unistd.h                 |  389 +------
>  linux-headers/asm-powerpc/unistd_32.h              |  381 +++++++
>  linux-headers/asm-powerpc/unistd_64.h              |  372 +++++++
>  linux-headers/linux/kvm.h                          |   29 +
>  linux-headers/linux/vfio.h                         |   92 ++
>  linux-headers/linux/vhost.h                        |  113 +-
>  linux-headers/linux/vhost_types.h                  |    1 +
>  monitor.c                                          |    5 +-
>  net/Makefile.objs                                  |    4 +-
>  net/net.c                                          |    2 +-
>  net/vhost-user-stub.c                              |   23 +
>  net/vhost-user.c                                   |   13 +
>  pc-bios/optionrom/Makefile                         |    5 +-
>  pc-bios/optionrom/linuxboot_dma.c                  |  114 +--
>  pc-bios/optionrom/optrom.h                         |  110 ++
>  pc-bios/optionrom/optrom_fw_cfg.h                  |   92 ++
>  pc-bios/optionrom/pvh.S                            |  200 ++++
>  pc-bios/optionrom/pvh_main.c                       |  133 +++
>  pc-bios/pvh.bin                                    |  Bin 0 -> 1536 bytes
>  scripts/tap-driver.pl                              |    1 +
>  scripts/tap-merge.pl                               |    1 +
>  scripts/update-linux-headers.sh                    |   17 +
>  target/i386/cpu.c                                  |   13 +-
>  target/i386/cpu.h                                  |    1 -
>  target/i386/hvf/x86_cpuid.c                        |   18 +-
>  tests/Makefile.include                             |    9 +-
>  tests/docker/dockerfiles/centos7.docker            |    5 +-
>  tests/hexloader-test.c                             |    2 +-
>  tests/vhost-user-test.c                            |  248 +++--
>  ui/vnc-enc-hextile-template.h                      |  268 ++---
>  ui/vnc-enc-zywrle.h                                |  394 +++----
>  125 files changed, 4781 insertions(+), 3002 deletions(-)
>  create mode 100644 hw/net/vhost_net-stub.c
>  create mode 100644 include/hw/xen/start_info.h
>  create mode 100644 include/standard-headers/asm-x86/bootparam.h
>  create mode 100644 include/standard-headers/linux/vhost_types.h
>  create mode 100644 linux-headers/asm-mips/unistd_n32.h
>  create mode 100644 linux-headers/asm-mips/unistd_n64.h
>  create mode 100644 linux-headers/asm-mips/unistd_o32.h
>  create mode 100644 linux-headers/asm-powerpc/unistd_32.h
>  create mode 100644 linux-headers/asm-powerpc/unistd_64.h
>  create mode 100644 linux-headers/linux/vhost_types.h
>  create mode 100644 net/vhost-user-stub.c
>  create mode 100644 pc-bios/optionrom/optrom.h
>  create mode 100644 pc-bios/optionrom/optrom_fw_cfg.h
>  create mode 100644 pc-bios/optionrom/pvh.S
>  create mode 100644 pc-bios/optionrom/pvh_main.c
>  create mode 100644 pc-bios/pvh.bin
> --
> 1.8.3.1
>
>


-- 
12345678901234567890123456789012345678901234567890123456789012345678901234567890
         1         2         3         4         5         6         7         8
