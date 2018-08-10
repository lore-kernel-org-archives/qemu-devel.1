Received: from eggs.gnu.org ([2001:4830:134:3::10]:48274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1foAFu-0007e5-4C
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1foAFt-0004wL-EK
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:27:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 10 Aug 2018 18:26:56 +0200
Message-Id: <20180810162658.6562-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Kevin Wolf (2):
  commit: Add top-node/base-node options
  qemu-iotests: Test commit with top-node/base-node

 qapi/block-core.json       | 24 +++++++++++++++------
 blockdev.c                 | 32 ++++++++++++++++++++++++++--
 tests/qemu-iotests/040     | 52 ++++++++++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/040.out |  4 ++--
 4 files changed, 100 insertions(+), 12 deletions(-)

-- 
2.13.6
