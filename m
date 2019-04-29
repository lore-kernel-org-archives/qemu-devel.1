Received: from eggs.gnu.org ([209.51.188.92]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hL6h9-0004zj-TM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hL6h8-0007tL-U3
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:51:47 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 29 Apr 2019 15:51:07 +0200
Message-Id: <cover.1556540297.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 0/2] commit: Make base read-only if there is
 an early failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Hi,

Here's v3 of this series, the only changes are the corrections in the
iotest suggested by Max.

Regards,

Berto

v3:
- Patch 2: Use $() instead of backquotes, remove 'here' variable and
  don't use 'sleep' when waiting for block-commit to finish [Max]

v2: https://lists.gnu.org/archive/html/qemu-block/2019-04/msg00334.html
- Patch 2: Added test case

v1: https://lists.gnu.org/archive/html/qemu-block/2019-04/msg00281.html

Output of backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

Alberto Garcia (2):
  commit: Make base read-only if there is an early failure
  iotests: Check that images are in read-only mode after block-commit

 block/commit.c             |   3 ++
 tests/qemu-iotests/249     | 115 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out |  35 ++++++++++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 154 insertions(+)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

-- 
2.11.0
