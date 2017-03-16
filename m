Received: from eggs.gnu.org ([2001:4830:134:3::10]:40933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cocsL-0005B9-RT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cocsL-0002as-0K
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 17:24:01 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 16 Mar 2017 17:23:48 -0400
Message-Id: <20170316212351.13797-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] block: pause block jobs for
 bdrv_drain_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Reference: https://bugzilla.redhat.com/show_bug.cgi?id=1367369#c8

It's possible to wedge QEMU if the guest tries to reset a virtio-pci
device as QEMU is also using the drive for a blockjob. This patchset
aims to allow us to safely pause/resume jobs attached to individual
nodes in a manner similar to how bdrv_drain_all_begin/end do.

John Snow (3):
  blockjob: add block_job_start_shim
  block-backend: add drained_begin / drained_end ops
  blockjob: add devops to blockjob backends

 block/block-backend.c          | 24 ++++++++++++++++--
 blockjob.c                     | 55 +++++++++++++++++++++++++++++++++---------
 include/sysemu/block-backend.h |  8 ++++++
 3 files changed, 73 insertions(+), 14 deletions(-)

-- 
2.9.3
