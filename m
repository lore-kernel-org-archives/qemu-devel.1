Received: from eggs.gnu.org ([2001:4830:134:3::10]:47496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiKmH-00050D-M6
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiKmE-00006h-MN
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:28:33 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Wed, 25 Jul 2018 17:27:54 +0300
Message-Id: <20180725142758.9980-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 0/4] Introduction of l2-cache-full option
 for qcow2 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

This series introduces an option to calculate and allocate
automatically enough qcow2 L2 cache to cover the entire image.
Using cache that covers the entire image can benefit performance,
while having only a small memory overhead (just 1 MB for every 8 GB
of virtual image size with the default cluster size).

-------------------------
Differences from v1:

1) Documentation fixes in qapi/block-core.json and qemu-options.hx
2) Removal of the patch which was made to fix the default sizes in
   docs/qcow2-cache.txt - it is not needed, as the default sizes imply
   also default cluster sizes.
3) Documentation fixes in docs/qcow2-cache.txt, mentioning mutual
   exclusivity of the options.
4) Squashing the iotests patch into the main feature addition patch

-------------------------
Differences from v2:

1) A separate patch for the grammar fix for 3.0
2) A separate patch for existing documentation fixes for 3.0
3) Separated back the iotests patch, because the grammar fix is separate now

-------------------------
Differences from v3:

1) Grammar change commit message fix
2) Rewording the documentation more concisely
3) Squashing the l2-cache-full docs commit to the one that introduces this
   feature

-------------------------
Differences from v4:

1) l2-cache-full is now a proper boolean option.
2) tests/qemu-iotests/103.out fixed: the grammar fix is now applied to the
   second relevant occurrence.
3) Error messages fixed in iotests for the l2-cache-full tests.

Leonid Bloch (4):
  qcow2: A grammar fix in conflicting cache sizing error message
  qcow2: Options' documentation fixes
  qcow2: Introduce an option for sufficient L2 cache for the entire
    image
  iotests: Add tests for the new l2-cache-full option

 block/qcow2.c              | 37 +++++++++++++++++++++++++++++--------
 block/qcow2.h              |  1 +
 docs/qcow2-cache.txt       | 18 ++++++++++++++----
 qapi/block-core.json       |  8 +++++++-
 qemu-options.hx            | 14 ++++++++++----
 tests/qemu-iotests/103     |  6 ++++++
 tests/qemu-iotests/103.out |  6 ++++--
 tests/qemu-iotests/137     |  2 ++
 tests/qemu-iotests/137.out |  4 +++-
 9 files changed, 76 insertions(+), 20 deletions(-)

-- 
2.14.1
