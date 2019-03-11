Received: from eggs.gnu.org ([209.51.188.92]:60522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODE-0006hw-NU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODD-0002mL-PG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:40 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODD-0002jn-GA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id p8so4332902wrq.6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:39 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e12sm6484836wrs.91.2019.03.11.09.55.36 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Mar 2019 09:55:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:04 +0100
Message-Id: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/31] Misc patches for 2019-03-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 79d8b1dc5b44d806d9700f2e8a8028075a8ff2b2:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190311-v2-pull-request' into staging (2019-03-11 12:52:44 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 328eb60dc1a19448b36eb63901ca0b8f87ed6f57:

  qemugdb: fix licensing (2019-03-11 16:55:52 +0100)

----------------------------------------------------------------
* allow building QEMU without TCG or KVM support (Anthony)
* update AMD IOMMU copyright (David)
* compilation fixes for GCC and BSDs (Alexey, David, Paolo, Philippe)
* coalesced I/O bugfix (Jagannathan)
* Processor Tracing cpuid fix (Luwei)
* Kconfig fixes (Paolo, David)
* Cleanups (Paolo, Wei)
* PVH vs. multiboot fix (Stefano)
* LSI bugfixes (Sven)
* elf2dmp Coverity fix (Victor)
* scsi-disk fix (Zhengui)
* authorization support for chardev TLS (Daniel)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      configure: Enable werror for git worktrees

Anthony PERARD (1):
      accel: Allow to build QEMU without TCG or KVM support

Daniel P. Berrangé (1):
      chardev: add support for authorization for TLS clients

David Abdurachmanov (1):
      riscv/Kconfig: enable PCI_DEVICES

David Kiarie (1):
      update copyright notice

Greg Kurz (1):
      virtio-scsi: Fix build with gcc 9

Jagannathan Raman (1):
      memory: Do not update coalesced IO range in the case of NOP

Li Qiang (2):
      tests: test-qgraph: fix a memory leak
      qom: cpu: destroy work_mutex in cpu_common_finalize

Luwei Kang (1):
      i386: extended the cpuid_level when Intel PT is enabled

Paolo Bonzini (6):
      vfio-pci: enable by default
      target-i386: add kvm stubs to user-mode emulators
      build: get rid of target-obj-y
      build: remove unnecessary assignments from Makefile.target
      build: clean trace/generated-helpers.c
      qemugdb: fix licensing

Philippe Mathieu-Daudé (3):
      block/iscsi: Restrict Linux-specific code
      oslib-posix: Ignore fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
      configure: Disable W^X on OpenBSD

Stefano Garzarella (1):
      hw/i386/pc: run the multiboot loader before the PVH loader

Sven Schnelle (8):
      lsi: implement basic SBCL functionality
      lsi: check if SIGP bit is already set in Wait reselect
      lsi: use ldn_le_p()/stn_le_p()
      lsi: use enum type for s->waiting
      lsi: use enum type for s->msg_action
      lsi: use SCSI phase names instead of numbers in trace
      lsi: return dfifo value
      lsi: 810/895A are always little endian

Viktor Prutyanov (1):
      contrib/elf2dmp: add kernel start address checking

Wei Yang (1):
      exec.c: refactor function flatview_add_to_dispatch()

Zhengui Li (1):
      scsi-disk: Fix crash if request is invaild or disk is no medium

 Makefile.objs                |   3 +-
 Makefile.target              |  11 +--
 accel/accel.c                |   4 +-
 block/iscsi.c                |   7 ++
 chardev/char-socket.c        |  12 ++-
 chardev/char.c               |   3 +
 configure                    |  13 +++-
 contrib/elf2dmp/main.c       |   6 ++
 exec.c                       |  48 +++++++-----
 hw/i386/amd_iommu.c          |   2 +-
 hw/i386/amd_iommu.h          |   2 +-
 hw/i386/pc.c                 |  18 +++--
 hw/riscv/Kconfig             |   3 +
 hw/scsi/lsi53c895a.c         | 170 +++++++++++++++++++++++++------------------
 hw/scsi/scsi-disk.c          |  37 ++++++----
 hw/scsi/trace-events         |   6 +-
 hw/scsi/virtio-scsi.c        |   8 +-
 hw/vfio/Kconfig              |   3 +-
 memory.c                     |   5 +-
 qapi/char.json               |   6 ++
 qemu-options.hx              |  10 ++-
 qom/cpu.c                    |   3 +
 scripts/qemu-gdb.py          |   7 +-
 scripts/qemugdb/coroutine.py |   7 +-
 scripts/qemugdb/mtree.py     |   7 +-
 scripts/qemugdb/tcg.py       |   7 +-
 target/i386/Makefile.objs    |   2 +-
 target/i386/cpu.c            |   9 +++
 target/i386/cpu.h            |   3 +
 tests/test-qgraph.c          |   3 +-
 trace/Makefile.objs          |   4 +-
 util/oslib-posix.c           |  12 +++
 32 files changed, 286 insertions(+), 155 deletions(-)
-- 
1.8.3.1
