Received: from eggs.gnu.org ([2001:4830:134:3::10]:52427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGntW-0005zj-8v
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGntQ-0000ue-A9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 10:21:58 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 20 Nov 2017 16:21:41 +0100
Message-Id: <20171120152145.25853-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.11 0/4] s390x fixes for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 2e02083438962d26ef9dcc7100f3b378104183db:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-11-17 19:08:07 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20171120-v1

for you to fetch changes up to 6cbf1ec85caf8a7d9f2fd829422c9f0a1c8983e1:

  pc-bios/s390-ccw.img: update image (2017-11-20 16:04:11 +0100)

----------------------------------------------------------------
Fix storing cpu status (both kvm and tcg), locking around diag 308
(tcg only) and a non-zero variable in the s390-ccw bios.

----------------------------------------------------------------

Cornelia Huck (1):
  pc-bios/s390-ccw.img: update image

David Hildenbrand (2):
  s390x: fix storing CPU status (again)
  s390x/tcg: fix DIAG 308 with > 1 VCPU (MTTCG)

Thomas Huth (1):
  pc-bios/s390-ccw: Fix problem with invalid virtio-scsi LUN when
    rebooting

 pc-bios/s390-ccw.img           | Bin 30520 -> 26416 bytes
 pc-bios/s390-ccw/virtio-scsi.c |   3 ++-
 target/s390x/helper.c          |   2 +-
 target/s390x/misc_helper.c     |   2 ++
 4 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.13.6
