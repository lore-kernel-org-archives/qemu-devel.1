Received: from eggs.gnu.org ([2001:4830:134:3::10]:46357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNfiQ-0003te-Sv
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNfiN-0006k1-Kk
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:30:38 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 15:30:21 +0200
Message-Id: <20170621133023.27627-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] iotests: Add test for colon handling
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

v2 of v3 of "iotests: Add test for colon handling"; thus, basically, v4.

This adds an iotest for the original series "block: Fix backing paths
for filenames with colons" and fixes common.config so it works if you
have specified the qemu binaries through relative paths. As a bonus, it
makes symlinked binaries work for out-of-tree builds.


v4: Use `type -p` instead of `which`, and use -- before the realpath
    FILE argument [Eric]


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/2:[0010] [FC] 'iotests: Use absolute paths for executables'
002/2:[----] [--] 'iotests: Add test for colon handling'


Max Reitz (2):
  iotests: Use absolute paths for executables
  iotests: Add test for colon handling

 tests/qemu-iotests/126           | 105 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/126.out       |  23 +++++++++
 tests/qemu-iotests/common.config |   6 +++
 tests/qemu-iotests/group         |   1 +
 4 files changed, 135 insertions(+)
 create mode 100755 tests/qemu-iotests/126
 create mode 100644 tests/qemu-iotests/126.out

-- 
2.9.4
