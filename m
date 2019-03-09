Received: from eggs.gnu.org ([209.51.188.92]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wia-0003qR-8g
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2WiW-0000Mw-Lx
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:26 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2WiU-0000JL-H0
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:24 -0500
Received: by mail-wr1-x431.google.com with SMTP id o7so3555001wrp.12
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id 11sm5252294wmg.27.2019.03.08.23.48.19
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 08 Mar 2019 23:48:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:47:53 +0100
Message-Id: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/25] Misc patches for QEMU 4.0 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 62cfabb52210139843e26c95434356f73a0631b9:

  Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20190307' into staging (2019-03-08 15:17:01 +0000)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to d7fa7c30d45c375fb7d9ad6f58462a64c3317037:

  exec: streamline flatview_add_to_dispatch (2019-03-09 08:46:56 +0100)

----------------------------------------------------------------
* allow building QEMU without TCG or KVM support (Anthony)
* update AMD IOMMU copyright (David)
* compilation fixes for GCC and BSDs (Alexey, David, Paolo, Philippe)
* coalesced I/O bugfix (Jagannathan)
* Processor Tracing cpuid fix (Luwei)
* Kconfig fix (Paolo)
* Cleanups (Paolo)
* PVH vs. multiboot fix (Stefano)
* LSI bugfixes (Sven)
* elf2dmp Coverity fix (Victor)
* scsi-disk fix (Zhengui)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      configure: Enable werror for git worktrees

Anthony PERARD (1):
      accel: Allow to build QEMU without TCG or KVM support

David Kiarie (1):
      update copyright notice

Greg Kurz (1):
      virtio-scsi: Fix build with gcc 9

Jagannathan Raman (1):
      memory: Do not update coalesced IO range in the case of NOP

Luwei Kang (1):
      i386: extended the cpuid_level when Intel PT is enabled

Paolo Bonzini (6):
      vfio-pci: enable by default
      target-i386: add kvm stubs to user-mode emulators
      build: get rid of target-obj-y
      build: remove unnecessary assignments from Makefile.target
      build: clean trace/generated-helpers.c
      exec: streamline flatview_add_to_dispatch

Philippe Mathieu-Daudé (3):
      block/iscsi: Restrict Linux-specific code
      oslib-posix: Ignore fcntl("/dev/null", F_SETFL, O_NONBLOCK) failure
      configure: Disable W^X on OpenBSD

Stefano Garzarella (1):
      hw/i386/pc: run the multiboot loader before the PVH loader

Sven Schnelle (7):
      lsi: implement basic SBCL functionality
      lsi: check if SIGP bit is already set in Wait reselect
      lsi: use ldn_le_p()/stn_le_p()
      lsi: use enum type for s->waiting
      lsi: use enum type for s->msg_action
      lsi: use SCSI phase names instead of numbers in trace
      lsi: return dfifo value

Viktor Prutyanov (1):
      contrib/elf2dmp: add kernel start address checking

Zhengui Li (1):
      scsi-disk: Fix crash if request is invaild or disk is no medium

 Makefile.objs             |   3 +-
 Makefile.target           |  11 +---
 accel/accel.c             |   4 +-
 block/iscsi.c             |   7 ++
 configure                 |  13 +++-
 contrib/elf2dmp/main.c    |   6 ++
 exec.c                    |  34 +++++-----
 hw/i386/amd_iommu.c       |   2 +-
 hw/i386/amd_iommu.h       |   2 +-
 hw/i386/pc.c              |  18 +++--
 hw/scsi/lsi53c895a.c      | 163 ++++++++++++++++++++++++++++------------------
 hw/scsi/scsi-disk.c       |  37 +++++++----
 hw/scsi/trace-events      |   6 +-
 hw/scsi/virtio-scsi.c     |   8 ++-
 hw/vfio/Kconfig           |   3 +-
 memory.c                  |   5 +-
 target/i386/Makefile.objs |   2 +-
 target/i386/cpu.c         |   9 +++
 target/i386/cpu.h         |   3 +
 trace/Makefile.objs       |   4 +-
 util/oslib-posix.c        |  12 ++++
 21 files changed, 227 insertions(+), 125 deletions(-)
-- 
1.8.3.1
