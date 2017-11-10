Received: from eggs.gnu.org ([2001:4830:134:3::10]:52722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDI12-0006bu-Tv
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDI12-0000m3-40
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:43:12 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 23:42:58 +0100
Message-Id: <20171110224302.14424-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/4] blockdev: Mark BD-{remove,
 insert}-medium stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

Berto's "Test I/O limits with removable media" patch proves that
throttling survives a blockdev-remove-medium/blockdev-insert-medium pair
now, so let's mark them stable (because that was the reason they were
considered experimental, see commit
6e0abc251dd4f8eba1f53656dfede12e5840e83b for more).

But before we do that, let's use the chance and drop the @device
parameter.


Based-on: <cover.1510339534.git.berto@igalia.com>
("Fix throttling crashes in BlockBackend with no BlockDriverState",
 because of the test case added there)


Max Reitz (4):
  iotests: Make BD-{remove,insert}-medium use @id
  tests/ahci: Switch tray and medium commands to @id
  blockdev: Drop BD-{remove,insert}-medium's @device
  blockdev: Mark BD-{remove,insert}-medium stable

 qapi/block-core.json   |  42 ++++-------
 blockdev.c             |  30 ++++++--
 tests/ahci-test.c      |  16 ++---
 tests/qemu-iotests/093 |   6 +-
 tests/qemu-iotests/118 | 184 +++++++++++++++++++++++--------------------------
 tests/qemu-iotests/139 |   2 +-
 tests/qemu-iotests/155 |  60 ++++++++--------
 7 files changed, 163 insertions(+), 177 deletions(-)

-- 
2.13.6
