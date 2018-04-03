Received: from eggs.gnu.org ([2001:4830:134:3::10]:34646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3HQe-0004L5-ER
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3HQa-0002ee-Fq
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:36:32 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  3 Apr 2018 10:36:22 +0200
Message-Id: <20180403083625.15297-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 0/3] s390x fixes for -rc2
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

The following changes since commit f184de7553272223d6af731d7d623a7cebf710b5:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critical-fixes' into staging (2018-03-31 09:42:33 +0100)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180403

for you to fetch changes up to d3b6e3bb6dc582099b8572c439fa651b3672de89:

  pc-bios/s390-ccw: update image (2018-04-03 10:03:38 +0200)

----------------------------------------------------------------
- fix a memory leak in the ipl code introduced with this release
- increase timeout in the bios to avoid hangs during migration (and
  rebuild bios to activate the change)

----------------------------------------------------------------

Cornelia Huck (1):
  pc-bios/s390-ccw: update image

Greg Kurz (1):
  hw/s390x: fix memory leak in s390_init_ipl_dev()

Thomas Huth (1):
  pc-bios/s390-ccw: Increase virtio timeout to 30 seconds

 hw/s390x/s390-virtio-ccw.c |   5 ++++-
 pc-bios/s390-ccw.img       | Bin 34568 -> 30568 bytes
 pc-bios/s390-ccw/virtio.c  |   2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.14.3
