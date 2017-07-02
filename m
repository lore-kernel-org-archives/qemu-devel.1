Received: from eggs.gnu.org ([2001:4830:134:3::10]:41339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dRgR7-00030e-SD
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 11:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dRgR6-0001nz-SA
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 11:05:21 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sun,  2 Jul 2017 17:05:08 +0200
Message-Id: <20170702150510.23276-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/2] iotests: Add test for colon handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

v3 of v3 of "iotests: Add test for colon handling"; thus, basically, v5.

This adds an iotest for the original series "block: Fix backing paths
for filenames with colons" and fixes common.config so it works if you
have specified the qemu binaries through relative paths. As a bonus, it
makes symlinked binaries work for out-of-tree builds.


v5: Don't try to resolve QEMU_VXHS_PROG if it is empty (which it may be)
    [Eric]


git-backport-diff against v4:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/2:[0007] [FC] 'iotests: Use absolute paths for executables'
002/2:[----] [--] 'iotests: Add test for colon handling'


Max Reitz (2):
  iotests: Use absolute paths for executables
  iotests: Add test for colon handling

 tests/qemu-iotests/126           | 105 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/126.out       |  23 +++++++++
 tests/qemu-iotests/common.config |  11 ++++
 tests/qemu-iotests/group         |   1 +
 4 files changed, 140 insertions(+)
 create mode 100755 tests/qemu-iotests/126
 create mode 100644 tests/qemu-iotests/126.out

-- 
2.9.4
