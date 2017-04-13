Received: from eggs.gnu.org ([2001:4830:134:3::10]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyhGe-0006HL-7T
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyhGd-00049t-BO
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:06:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 13 Apr 2017 18:06:23 +0200
Message-Id: <20170413160625.27719-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] block: An empty filename counts
 as no filename
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

See patch 1 for what is happening when you try "qemu-img info ''" and
for the fix.

(Patch 2 just adds a simple test.)


Max Reitz (2):
  block: An empty filename counts as no filename
  iotests/051: Add test for empty filename

 block.c                       | 2 +-
 tests/qemu-iotests/051        | 1 +
 tests/qemu-iotests/051.out    | 3 +++
 tests/qemu-iotests/051.pc.out | 3 +++
 4 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.12.2
