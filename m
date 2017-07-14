Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOD-0007Yz-Ef
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOC-0003YX-4K
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyOB-0003YG-QC
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB3bj1059053
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:02 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpvrc80jc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:02 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:04:00 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:27 +0200
Message-Id: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 00/40] s390x: fixes,
 enhancements for 2.10 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter, 

this should be the last big chunk for s390/kvm related changes
for 2.10.
Patch 2 does a header sync against a kernel version from Linus tree, 
which already  contains the KVM changes for 4.13. Please note that 
one fix in linux/kvm.h is pending for 4.13. I will submit a followup
patch as soon as this hits the kernel.


The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)

are available in the git repository at:

  git://github.com/borntraeger/qemu.git tags/s390x-20170714

for you to fetch changes up to 86158a2a2b81f075c84d0b95c6d72b98dbf1dc61:

  s390x/gdb: add gs registers (2017-07-14 12:29:49 +0200)

----------------------------------------------------------------
s390x/kvm/migration/cpumodel: fixes, enhancements and cleanups

- add a network boot rom for s390 (Thomas Huth)
- migration of storage attributes like the CMMA used/unused state
- PCI related enhancements - full support for aen, ais and zpci
- migration support for css with vmstates (Halil Pasic)
- cpu model enhancements for cpu features
- guarded storage support

----------------------------------------------------------------
Christian Borntraeger (5):
      linux-headers: update to 4.13-rc0
      pc-bios/s390: add s390-netboot.img
      pc-bios/s390: rebuild s390-ccw.img
      s390x/arch_dump: also dump guarded storage control block
      s390x/gdb: add gs registers

Claudio Imbrenda (2):
      s390x/migration: Storage attributes device
      s390x/migration: Monitor commands for storage attributes

Fan Zhang (1):
      s390x/kvm: enable guarded storage

Farhan Ali (1):
      s390x/kvm: Enable KSS facility for nested virtualization

Fei Li (3):
      s390x: add flags field for registering I/O adapter
      s390x/flic: introduce modify_ais_mode callback
      s390x/sic: realize SIC handling

Halil Pasic (6):
      s390x: add helper get_machine_class
      s390x: add css_migration_enabled to machine class
      s390x/css: add missing css state conditionally
      s390x/css: add ORB to SubchDev
      s390x/css: activate ChannelSubSys migration
      s390x/css: use SubchDev.orb

Janosch Frank (1):
      s390x/kvm: Rework cmma management

Jason J. Herne (5):
      s390x/cpumodel: clean up spacing and comments
      s390x/cpumodel: provide compat handling for new cpu features
      s390x/cpumodel: wire up new hardware features
      s390x/cpumodel: we are always in zarchitecture mode
      s390x/cpumodel: add esop/esop2 to z12 model

Thomas Huth (11):
      pc-bios/s390-ccw: Move libc functions to separate header
      pc-bios/s390-ccw: Move ebc2asc to sclp.c
      pc-bios/s390-ccw: Move virtio-block related functions into a separate file
      pc-bios/s390-ccw: Add a write() function for stdio
      pc-bios/s390-ccw: Move byteswap functions to a separate header
      pc-bios/s390-ccw: Remove unused structs from virtio.h
      pc-bios/s390-ccw: Add code for virtio feature negotiation
      roms/SLOF: Update submodule to latest status
      pc-bios/s390-ccw: Add core files for the network bootloading program
      pc-bios/s390-ccw: Add virtio-net driver code
      pc-bios/s390-ccw: Link libnet into the netboot image and do the TFTP load

Yi Min Zhao (5):
      s390x/flic: introduce inject_airq callback
      s390x/css: update css_adapter_interrupt
      s390x: initialize cpu firstly
      s390x/cpumodel: add zpci, aen and ais facilities
      s390x/flic: migrate ais states

 Makefile                                           |   2 +-
 configure                                          |   2 +-
 gdb-xml/s390-gs.xml                                |  14 +
 hmp-commands-info.hx                               |  16 +
 hmp-commands.hx                                    |  16 +
 hw/intc/s390_flic.c                                | 107 +++++-
 hw/intc/s390_flic_kvm.c                            | 137 ++++++-
 hw/intc/trace-events                               |   4 +
 hw/s390x/Makefile.objs                             |   2 +
 hw/s390x/css-bridge.c                              |   2 +-
 hw/s390x/css.c                                     | 196 +++++++++-
 hw/s390x/s390-pci-bus.c                            |   5 +-
 hw/s390x/s390-stattrib-kvm.c                       | 190 ++++++++++
 hw/s390x/s390-stattrib.c                           | 404 +++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c                         |  90 +++--
 hw/s390x/trace-events                              |   1 +
 hw/s390x/virtio-ccw.c                              |   2 +-
 include/elf.h                                      |   1 +
 include/hw/s390x/css.h                             |  23 +-
 include/hw/s390x/s390-virtio-ccw.h                 |  10 +
 include/hw/s390x/s390_flic.h                       |  14 +-
 include/hw/s390x/sclp.h                            |   3 +-
 include/hw/s390x/storage-attributes.h              |  81 +++++
 include/standard-headers/asm-x86/hyperv.h          |  21 +-
 include/standard-headers/linux/input-event-codes.h |   1 +
 include/standard-headers/linux/pci_regs.h          |   1 +
 linux-headers/asm-arm/kvm.h                        |   8 +
 linux-headers/asm-arm64/kvm.h                      |   3 +
 linux-headers/asm-powerpc/kvm.h                    |   6 +
 linux-headers/asm-s390/kvm.h                       |  12 +
 linux-headers/linux/kvm.h                          |  35 ++
 monitor.c                                          |   1 +
 pc-bios/s390-ccw.img                               | Bin 26480 -> 30520 bytes
 pc-bios/s390-ccw/Makefile                          |  13 +-
 pc-bios/s390-ccw/bootmap.c                         |   2 +
 pc-bios/s390-ccw/bootmap.h                         |  26 --
 pc-bios/s390-ccw/bswap.h                           |  30 ++
 pc-bios/s390-ccw/libc.h                            |  45 +++
 pc-bios/s390-ccw/main.c                            |  14 +-
 pc-bios/s390-ccw/netboot.mak                       |  59 +++
 pc-bios/s390-ccw/netmain.c                         | 361 ++++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h                        |  33 +-
 pc-bios/s390-ccw/sclp.c                            |  37 +-
 pc-bios/s390-ccw/virtio-blkdev.c                   | 296 +++++++++++++++
 pc-bios/s390-ccw/virtio-net.c                      | 135 +++++++
 pc-bios/s390-ccw/virtio-scsi.c                     |   1 +
 pc-bios/s390-ccw/virtio.c                          | 306 ++--------------
 pc-bios/s390-ccw/virtio.h                          |  46 +--
 pc-bios/s390-netboot.img                           | Bin 0 -> 83864 bytes
 roms/SLOF                                          |   2 +-
 target/s390x/arch_dump.c                           |  18 +
 target/s390x/cpu.h                                 |   8 +
 target/s390x/cpu_features.c                        |  52 ++-
 target/s390x/cpu_features.h                        |   4 +
 target/s390x/cpu_features_def.h                    |  77 ++++
 target/s390x/cpu_models.c                          |  51 +++
 target/s390x/cpu_models.h                          |   2 +
 target/s390x/gdbstub.c                             |  24 ++
 target/s390x/gen-features.c                        | 105 +++++-
 target/s390x/kvm.c                                 | 169 ++++++---
 target/s390x/machine.c                             |  17 +
 61 files changed, 2833 insertions(+), 510 deletions(-)
 create mode 100644 gdb-xml/s390-gs.xml
 create mode 100644 hw/s390x/s390-stattrib-kvm.c
 create mode 100644 hw/s390x/s390-stattrib.c
 create mode 100644 include/hw/s390x/storage-attributes.h
 create mode 100644 pc-bios/s390-ccw/bswap.h
 create mode 100644 pc-bios/s390-ccw/libc.h
 create mode 100644 pc-bios/s390-ccw/netboot.mak
 create mode 100644 pc-bios/s390-ccw/netmain.c
 create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c
 create mode 100644 pc-bios/s390-ccw/virtio-net.c
 create mode 100755 pc-bios/s390-netboot.img
