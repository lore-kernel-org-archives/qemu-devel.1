Received: from eggs.gnu.org ([2001:4830:134:3::10]:49679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFMVx-0005EV-Vx
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFMVx-0002o9-4C
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:23:26 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 29 May 2017 17:23:14 +0200
Message-Id: <20170529152316.27647-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] iotests: Add test for colon handling
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

This is a v3 for "block: Fix backing paths for filenames with colons".
Kevin reported that the test added there does not work if the test
programs are specified with relative paths (because the new test changes
its working directory), so we/I dropped the test from the queue and here
it is again.

The test itself is unchanged (except for the comment fixed as requested
by Eric), there is just a new patch here to make it work even if you
specify the test programs with relative paths. Bonus: It makes symlinked
programs work with out-of-tree builds.


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/2:[down] 'iotests: Use absolute paths for executables'
002/2:[0006] [FC] 'iotests: Add test for colon handling'


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
