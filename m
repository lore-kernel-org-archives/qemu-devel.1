Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d63Qi-0001yz-Kg
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d63Qh-0005vs-RE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:11:32 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  4 May 2017 01:11:16 +0200
Message-Id: <20170503231120.23507-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] qcow2: Some fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This series contains some fixes for issues reported by Eric.


Max Reitz (4):
  qcow2: Fix preallocation size formula
  qcow2: Reuse preallocated zero clusters
  qcow2: Discard preallocated zero clusters
  iotests: Extend test 066

 block/qcow2.h              |   3 ++
 block/qcow2-cluster.c      |  83 ++++++++++++++++++++---------
 block/qcow2.c              |   9 ++--
 tests/qemu-iotests/066     | 128 ++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/066.out |  46 ++++++++++++++++
 5 files changed, 239 insertions(+), 30 deletions(-)

-- 
2.12.2
