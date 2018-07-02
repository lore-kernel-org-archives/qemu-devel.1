Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwq6-0001vJ-Kg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwq4-0005xi-0K
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:17:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:22 +0200
Message-Id: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 00/15] s390x patches for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 281bd281222776229d5dbf84d1a5c6d8d9d2a34b:

  Merge remote-tracking branch 'remotes/xtensa/tags/20180630-xtensa' into staging (2018-06-30 22:23:51 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180702

for you to fetch changes up to 30c8db0e219a3c1d8b39c19e8b858830cb141738:

  s390x/tcg: fix locking problem with tcg_s390_tod_updated (2018-07-02 10:37:38 +0200)

----------------------------------------------------------------
s390x updates:
- add bpb/ppa15 features to default cpu model for z196 and later
- rework TOD handling and fix cpu hotplug under tcg
- various fixes

----------------------------------------------------------------

Christian Borntraeger (2):
  s390/ipl: fix ipl with -no-reboot
  s390x/cpumodel: default enable bpb and ppa15 for z196 and later

David Hildenbrand (12):
  s390x/tcg: avoid overflows in time2tod/tod2time
  s390x/kvm: pass values instead of pointers to kvm_s390_set_clock_*()
  s390x/tod: factor out TOD into separate device
  s390x/tcg: drop tod_basetime
  s390x/tcg: properly implement the TOD
  s390x/tcg: SET CLOCK COMPARATOR can clear CKC interrupts
  s390x/tcg: implement SET CLOCK
  s390x/tcg: rearm the CKC timer during migration
  s390x/tcg: fix CPU hotplug with single-threaded TCG
  s390x/kvm: legacy_s390_alloc() only supports one allocation
  s390x/kvm: indicate alignment in legacy_s390_alloc()
  s390x/tcg: fix locking problem with tcg_s390_tod_updated

Thomas Huth (1):
  loader: Check access size when calling rom_ptr() to avoid crashes

 hw/core/loader.c            |  10 ++--
 hw/mips/mips_malta.c        |   6 +-
 hw/s390x/Makefile.objs      |   3 +
 hw/s390x/ipl.c              |  26 ++++++---
 hw/s390x/s390-virtio-ccw.c  |  59 ++------------------
 hw/s390x/tod-kvm.c          |  64 ++++++++++++++++++++++
 hw/s390x/tod-qemu.c         |  87 +++++++++++++++++++++++++++++
 hw/s390x/tod.c              | 130 ++++++++++++++++++++++++++++++++++++++++++++
 hw/sparc/sun4m.c            |   4 +-
 hw/sparc64/sun4u.c          |   4 +-
 include/hw/loader.h         |   2 +-
 include/hw/s390x/tod.h      |  65 ++++++++++++++++++++++
 include/sysemu/sysemu.h     |   4 ++
 target/arm/cpu.c            |   2 +-
 target/s390x/Makefile.objs  |   1 +
 target/s390x/cpu.c          |  57 ++++---------------
 target/s390x/cpu.h          |   4 --
 target/s390x/gen-features.c |   2 +
 target/s390x/helper.h       |   1 +
 target/s390x/insn-data.def  |   3 +-
 target/s390x/internal.h     |  15 -----
 target/s390x/kvm-stub.c     |   4 +-
 target/s390x/kvm.c          |  27 ++++++---
 target/s390x/kvm_s390x.h    |   6 +-
 target/s390x/machine.c      |   6 ++
 target/s390x/misc_helper.c  |  66 ++++++++++++++++++----
 target/s390x/tcg-stub.c     |  20 +++++++
 target/s390x/tcg_s390x.h    |  18 ++++++
 target/s390x/translate.c    |   9 +++
 vl.c                        |   4 +-
 30 files changed, 543 insertions(+), 166 deletions(-)
 create mode 100644 hw/s390x/tod-kvm.c
 create mode 100644 hw/s390x/tod-qemu.c
 create mode 100644 hw/s390x/tod.c
 create mode 100644 include/hw/s390x/tod.h
 create mode 100644 target/s390x/tcg-stub.c
 create mode 100644 target/s390x/tcg_s390x.h

-- 
2.14.4
