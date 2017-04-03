Received: from eggs.gnu.org ([2001:4830:134:3::10]:36153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv691-0002XG-R8
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv691-000496-6i
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:51:59 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 19:51:48 +0200
Message-Id: <20170403175150.15253-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/2] block/mirror: Fix use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

And the exciting 2.9 ride continues!

When mirroring from a BDS with no parents at all (such as those added
with -blockdev or blockdev-add), we have a use-after-free in mirror's
error path. The first patch of this series fixes that, the other adds a
patch so we don't regress.

What issue will we find next? Stay tuned!


Max Reitz (2):
  block/mirror: Fix use-after-free
  iotests: Add mirror tests for orphaned source

 block/mirror.c                | 12 +++++++++--
 tests/qemu-iotests/041        | 46 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out    |  4 ++--
 tests/qemu-iotests/iotests.py | 15 ++++++++++++++
 4 files changed, 73 insertions(+), 4 deletions(-)

-- 
2.12.1
