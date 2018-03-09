Received: from eggs.gnu.org ([2001:4830:134:3::10]:35915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqg-0007Le-LC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euPqf-0000sF-QI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:46:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 22:46:04 +0100
Message-Id: <20180309214611.19122-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] block: .bdrv_co_create for format drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This series adds a .bdrv_co_create implementation to almost all format
drivers that support creating images where its still missing. The only
exception is VMDK because its support for extents will make the QAPI
design a bit more complicated.

The other format driver not covered in this series are qcow2 (already
merged) and luks (already posted in a separate series).

Kevin Wolf (7):
  parallels: Support .bdrv_co_create
  qemu-iotests: Enable write tests for parallels
  qcow: Support .bdrv_co_create
  qed: Support .bdrv_co_create
  vdi: Support .bdrv_co_create
  vhdx: Support .bdrv_co_create
  vpc: Support .bdrv_co_create

 qapi/block-core.json     | 155 +++++++++++++++++++++++++++++++++--
 block/parallels.c        | 199 ++++++++++++++++++++++++++++++++++-----------
 block/qcow.c             | 196 ++++++++++++++++++++++++++++++---------------
 block/qed.c              | 204 ++++++++++++++++++++++++++++++++---------------
 block/vdi.c              | 169 +++++++++++++++++++++++++++++----------
 block/vhdx.c             | 174 ++++++++++++++++++++++++++++++----------
 block/vpc.c              | 152 ++++++++++++++++++++++++++---------
 tests/qemu-iotests/181   |   2 +-
 tests/qemu-iotests/check |   1 -
 9 files changed, 943 insertions(+), 309 deletions(-)

-- 
2.13.6
