Received: from eggs.gnu.org ([2001:4830:134:3::10]:58265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fj3XE-0005Ku-2s
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fj3XD-00038S-5P
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:16:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 27 Jul 2018 16:15:36 +0200
Message-Id: <20180727141539.506-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 0/3] Fix query-blockstats with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (3):
  block/qapi: Add 'qdev' field to query-blockstats result
  block/qapi: Include anonymous BBs in query-blockstats
  qemu-iotests: Test query-blockstats with -drive and -blockdev

 qapi/block-core.json       |   5 ++-
 block/qapi.c               |  16 ++++++-
 tests/qemu-iotests/227     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/227.out |  42 +++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 5 files changed, 163 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/227
 create mode 100644 tests/qemu-iotests/227.out

-- 
2.13.6
