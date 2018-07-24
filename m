Received: from eggs.gnu.org ([2001:4830:134:3::10]:35687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhwGv-00052V-Qm
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fhwGs-0006GP-L8
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:18:33 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Tue, 24 Jul 2018 15:17:49 +0300
Message-Id: <20180724121753.5753-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] Introduction of l2-cache-full option for
 qcow2 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This series introduces an option to calculate and allocate
automatically enough qcow2 L2 cache to cover the entire image.
Using cache that covers the entire image can benefit performance,
while having only a small memory overhead (just 1 MB for every 8 GB
of virtual image size with the default cluster size).

Leonid Bloch (4):
  qcow2: Introduce an option for sufficient L2 cache for the entire
    image
  docs: Fix an inaccuracy due to recent changes
  docs: Document the l2-cache-full option
  iotests: Add tests for the new l2-cache-full option

 block/qcow2.c              | 37 +++++++++++++++++++++++++++++--------
 block/qcow2.h              |  1 +
 docs/qcow2-cache.txt       | 18 +++++++++++-------
 qapi/block-core.json       |  4 ++++
 qemu-options.hx            |  4 ++++
 tests/qemu-iotests/103     |  6 ++++++
 tests/qemu-iotests/103.out |  4 +++-
 tests/qemu-iotests/137     |  2 ++
 tests/qemu-iotests/137.out |  4 +++-
 9 files changed, 63 insertions(+), 17 deletions(-)

-- 
2.14.1
