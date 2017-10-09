Received: from eggs.gnu.org ([2001:4830:134:3::10]:36274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1b1G-0005C5-Ht
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1b1F-00023N-SK
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:35:06 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  9 Oct 2017 18:34:54 +0200
Message-Id: <20171009163456.485-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] iotests: Add _filter_actual_image_size
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

The actual size of an image depends on the host filesystem.  Therefore,
it should be filtered from the test output if it's not part of the test
itself (and if it is, the test should take extra care, like 106 does).

So let's put the filtering sed line from 067 and 087 into a common
filter function and use it in 184 and 191.


Max Reitz (2):
  iotests: Pull _filter_actual_image_size from 67/87
  iotests: Filter actual image size in 184 and 191

 tests/qemu-iotests/067           |  2 +-
 tests/qemu-iotests/087           |  2 +-
 tests/qemu-iotests/184           |  3 ++-
 tests/qemu-iotests/184.out       |  6 +++---
 tests/qemu-iotests/191           |  4 ++--
 tests/qemu-iotests/191.out       | 46 ++++++++++++++++++++--------------------
 tests/qemu-iotests/common.filter |  6 ++++++
 7 files changed, 38 insertions(+), 31 deletions(-)

-- 
2.13.6
