Received: from eggs.gnu.org ([2001:4830:134:3::10]:37229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eNL01-0006UT-NC
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1eNL01-0000Zt-36
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:55:41 -0500
From: Mark Kanda <mark.kanda@oracle.com>
Date: Fri,  8 Dec 2017 09:57:25 -0600
Message-Id: <cover.1512748083.git.mark.kanda@oracle.com>
In-Reply-To: <cover.1512589016.git.mark.kanda@oracle.com>
References: <cover.1512589016.git.mark.kanda@oracle.com>
Subject: [Qemu-devel] [PATCH v2 0/2] virtio-blk: miscellaneous changes
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

v2: add check for maximum queue size [Stefan]

This series is for two minor virtio-blk changes. The first patch
makes the virtio-blk queue size user configurable. The second patch
rejects logical block size > physical block configurations (similar
to a recent change in virtio-scsi).

Mark Kanda (2):
  virtio-blk: make queue size configurable
  virtio-blk: reject configs with logical block size > physical block
    size

 hw/block/virtio-blk.c          | 17 ++++++++++++++++-
 include/hw/virtio/virtio-blk.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
1.8.3.1
