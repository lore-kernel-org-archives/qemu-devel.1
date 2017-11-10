Received: from eggs.gnu.org ([2001:4830:134:3::10]:56867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDG43-0006j6-RB
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDG43-0007ht-5R
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:38:11 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 21:37:58 +0100
Message-Id: <20171110203759.14018-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/1] qcow2: Repair unaligned
 preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This is a follow-up to patch 2 of my "qcow2: Unaligned zero cluster in
handle_alloc()" series.  That patch adds a way to correctly deal with
such clusters, this patch here adds a way to repair them.

Naturally, this patch is therefore based on that series:

Based-on: <20171110203111.7666-1-mreitz@redhat.com>


Max Reitz (1):
  qcow2: Repair unaligned preallocated zero clusters

 block/qcow2-refcount.c     | 70 ++++++++++++++++++++++++++++++++++++++--------
 tests/qemu-iotests/060     |  3 +-
 tests/qemu-iotests/060.out |  9 ++++++
 3 files changed, 69 insertions(+), 13 deletions(-)

-- 
2.13.6
