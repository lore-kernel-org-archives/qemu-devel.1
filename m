Received: from eggs.gnu.org ([2001:4830:134:3::10]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePkzM-0007De-Qt
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePkzM-0001Jn-1j
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:05:00 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Dec 2017 16:04:44 +0800
Message-Id: <20171215080446.10671-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: Fix qemu-img creating overlay when
 guest running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Shared write lock is not strictly necessary for creating the overlay image, if
all what we want is to probe the size.

Fam Zheng (2):
  block: Open backing image in force share mode for size probe
  iotests: Test creating overlay when guest running

 block.c                    | 3 ++-
 tests/qemu-iotests/153     | 4 ++++
 tests/qemu-iotests/153.out | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.14.3
