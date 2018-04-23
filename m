Received: from eggs.gnu.org ([2001:4830:134:3::10]:41582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAk1y-0006PQ-P3
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 18:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAk1x-0005d0-Pj
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 18:33:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 23 Apr 2018 17:33:32 -0500
Message-Id: <20180423223337.82366-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/5] minor qcow2 compression improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com

Another attempt at this series; v4 was over a month ago:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06780.html

Since then: add R-b, and another round of wording tweaks [Berto, Max],
emphasizing that refcount table is not the limiting factor and that
other limits like ext4 are more likely to hit first

001/5:[----] [--] 'qcow2: Prefer byte-based calls into bs->file'
002/5:[0020] [FC] 'qcow2: Document some maximum size constraints'
003/5:[----] [--] 'qcow2: Reduce REFT_OFFSET_MASK'
004/5:[----] [--] 'qcow2: Don't allow overflow during cluster allocation'
005/5:[----] [--] 'qcow2: Avoid memory over-allocation on compressed images'

Eric Blake (5):
  qcow2: Prefer byte-based calls into bs->file
  qcow2: Document some maximum size constraints
  qcow2: Reduce REFT_OFFSET_MASK
  qcow2: Don't allow overflow during cluster allocation
  qcow2: Avoid memory over-allocation on compressed images

 docs/interop/qcow2.txt | 40 +++++++++++++++++++++++++++++++++++++---
 block/qcow2.h          |  8 +++++++-
 block/qcow2-cluster.c  | 32 ++++++++++++++++++++------------
 block/qcow2-refcount.c | 27 +++++++++++++++++----------
 block/qcow2.c          |  2 +-
 5 files changed, 82 insertions(+), 27 deletions(-)

-- 
2.14.3
