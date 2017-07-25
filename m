Received: from eggs.gnu.org ([2001:4830:134:3::10]:46389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1Vo-00023F-3E
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1da1Vn-0007Ld-9C
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:12:40 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 25 Jul 2017 17:12:30 +0200
Message-Id: <20170725151233.26077-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Block patches for 2.10-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

The following changes since commit 4c4414a4388f902b7ae2814f9a64898dd0e426a5:

  hw/display/sm501: Don't use vmstate_register_ram_global() (2017-07-25 13:04:28 +0100)

are available in the git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2017-07-25

for you to fetch changes up to bd998d7cc8ced211def90e4225042d63dddecc54:

  qemu-iotests: Fix reference output for 186 (2017-07-25 16:33:58 +0200)

----------------------------------------------------------------
Block patches for 2.10-rc0

----------------------------------------------------------------
Daniel P. Berrange (1):
  qcow: fix memory leaks related to encryption

Kevin Wolf (1):
  qemu-iotests: Fix reference output for 186

Vladimir Sementsov-Ogievskiy (1):
  qcow2-bitmap: fix bitmap_free

 block/qcow.c               | 5 +++--
 block/qcow2-bitmap.c       | 4 ++++
 block/qcow2.c              | 7 ++++---
 tests/qemu-iotests/186.out | 6 +++---
 4 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.9.4
