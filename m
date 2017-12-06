Received: from eggs.gnu.org ([2001:4830:134:3::10]:42859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eMfju-0002xB-U2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eMfju-0001B2-7N
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:52:18 -0500
From: Mark Kanda <mark.kanda@oracle.com>
Date: Wed,  6 Dec 2017 13:53:59 -0600
Message-Id: <cover.1512589016.git.mark.kanda@oracle.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-blk: miscellaneous changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, konrad.wilk@oracle.com, martin.petersen@oracle.com, ameya.more@oracle.com, karl.heubaum@oracle.com, Mark Kanda <mark.kanda@oracle.com>

This series is for two minor virtio-blk changes. The first patch
makes the virtio-blk queue size user configurable. The second patch
rejects logical block size > physical block configurations (similar
to a recent change in virtio-scsi).

Mark Kanda (2):
  virtio-blk: make queue size configurable
  virtio-blk: reject configs with logical block size > physical block
    size

 hw/block/virtio-blk.c          | 14 +++++++++++++-
 include/hw/virtio/virtio-blk.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.8.3.1
