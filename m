Received: from eggs.gnu.org ([2001:4830:134:3::10]:51460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBi-00005J-8C
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBh-0000Ou-E4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:42 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:20 +0100
Message-Id: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 00/12] block: Follow-up for
 .bdrv_co_create (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

This series adds qemu-iotests for a few more block drivers (yet more to
come in another series) and fixes a few things that previous review and
these tests brought up.

The only major design change is that I converted the vdi block driver
from a boolean 'static' create option to the standard 'preallocation'
one that other drivers are using. This seems like a good move to make
while the interface isn't stable yet.

Kevin Wolf (12):
  vdi: Change 'static' create option to 'preallocation' in QMP
  vdi: Fix build with CONFIG_VDI_DEBUG
  qemu-iotests: Test vdi image creation with QMP
  qemu-iotests: Enable 025 for luks
  luks: Turn another invalid assertion into check
  qemu-iotests: Test invalid resize on luks
  parallels: Check maximum cluster size on create
  qemu-iotests: Test parallels image creation with QMP
  vhdx: Require power-of-two block size on create
  vhdx: Don't use error_setg_errno() with constant errno
  vhdx: Check for 4 GB maximum log size on creation
  qemu-iotests: Test vhdx image creation with QMP

 qapi/block-core.json       |   6 +-
 block/crypto.c             |   6 +-
 block/parallels.c          |   5 +
 block/vdi.c                |  46 ++++--
 block/vhdx.c               |  17 ++-
 tests/qemu-iotests/025     |   9 +-
 tests/qemu-iotests/210     |  37 +++++
 tests/qemu-iotests/211     | 256 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/211.out |  98 +++++++++++++
 tests/qemu-iotests/212     | 326 ++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/212.out | 111 ++++++++++++++
 tests/qemu-iotests/213     | 349 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/213.out | 121 ++++++++++++++++
 tests/qemu-iotests/group   |   3 +
 14 files changed, 1365 insertions(+), 25 deletions(-)
 create mode 100755 tests/qemu-iotests/211
 create mode 100644 tests/qemu-iotests/211.out
 create mode 100755 tests/qemu-iotests/212
 create mode 100644 tests/qemu-iotests/212.out
 create mode 100755 tests/qemu-iotests/213
 create mode 100644 tests/qemu-iotests/213.out

-- 
2.13.6
