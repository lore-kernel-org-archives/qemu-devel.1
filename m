Received: from eggs.gnu.org ([2001:4830:134:3::10]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWI-00061Y-VW
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWF-0005Nd-Qd
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:46 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  9 Apr 2018 17:15:25 +0200
Message-Id: <20180409151533.2253-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 0/8] s390x fixes for -rc3
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

The following changes since commit 2a6bcfdebe4115993a032395d459f5e0cf27a01e:

  Merge remote-tracking branch 'remotes/famz/tags/testing-pull-request' into staging (2018-04-09 10:21:14 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180409

for you to fetch changes up to b3a184f51fbed3401694a9619e6842f882a64fee:

  s390x: load_psw() should only exchange the PSW for KVM (2018-04-09 13:59:06 +0200)

----------------------------------------------------------------
Fixes for s390x: kvm, vfio-ccw, ipl code, bios. Includes a rebuild
of s390-ccw.img and s390-netboot.img.

----------------------------------------------------------------

Cornelia Huck (1):
  pc-bios/s390: update images

David Hildenbrand (3):
  s390x/kvm: call cpu_synchronize_state() on every
    kvm_arch_handle_exit()
  s390x/mmu: don't overwrite pending exception in mmu translate
  s390x: load_psw() should only exchange the PSW for KVM

Greg Kurz (1):
  vfio-ccw: fix memory leaks in vfio_ccw_realize()

Viktor Mihajlovski (3):
  s390: Refactor IPL parameter block generation
  s390: Ensure IPL from SCSI works as expected
  s390: Do not pass inofficial IPL type to the guest

 hw/s390x/ipl.c             | 112 ++++++++++++++++++++++++++++++++-------------
 hw/vfio/ccw.c              |   2 +
 pc-bios/s390-ccw.img       | Bin 30568 -> 30520 bytes
 pc-bios/s390-ccw/bootmap.c |   7 +++
 pc-bios/s390-ccw/iplb.h    |  15 +++++-
 pc-bios/s390-netboot.img   | Bin 83776 -> 83856 bytes
 target/s390x/helper.c      |  10 ++--
 target/s390x/kvm.c         |   2 +
 target/s390x/mmu_helper.c  |   2 +-
 9 files changed, 111 insertions(+), 39 deletions(-)

-- 
2.14.3
