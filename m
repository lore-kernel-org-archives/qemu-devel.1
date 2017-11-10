Received: from eggs.gnu.org ([2001:4830:134:3::10]:36875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDESO-0000m8-TO
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eDESK-0001tA-Vg
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:55:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 10 Nov 2017 20:54:45 +0200
Message-Id: <cover.1510339534.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/3] Fix throttling crashes in BlockBackend
 with no BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

Hi,

this series fixes the problems reported by Sochin Jiang in
BlockBackend when there's a valid throttling configuration but the BDS
has been removed.

The patches apply on top of Li Zhengui's "all I/O should be completed
before removing throttle timers" and I tested this on top of Stefan's
block branch (commit 900276cf24589596296d3d099fe609ad5c182ac9).

Regards,

Berto

Alberto Garcia (3):
  block: Check for inserted BlockDriverState in blk_io_limits_disable()
  block: Leave valid throttle timers when removing a BDS from a backend
  qemu-iotests: Test I/O limits with removable media

 block/block-backend.c      | 30 +++++++++++++---------
 tests/qemu-iotests/093     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/093.out |  4 +--
 3 files changed, 82 insertions(+), 14 deletions(-)

-- 
2.11.0
