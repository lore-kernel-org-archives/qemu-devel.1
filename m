Received: from eggs.gnu.org ([2001:4830:134:3::10]:41449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fqXcN-0005Mp-Gp
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fqXcM-000336-Rf
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:48:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 17 Aug 2018 13:47:55 +0800
Message-Id: <20180817054758.14515-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] file-posix: Simplifications on image
 locking
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

The first patch reduces chances of QEMU crash in unusual (but not unlikely)
cases especially when used by Libvirt (see commit message).

The second patch halves fd for images.

The third adds some more test for patch one (would have caught the regression
caused by v2).

Fam Zheng (3):
  file-posix: Skip effectiveless OFD lock operations
  file-posix: Drop s->lock_fd
  tests: Add unit tests for image locking

 block/file-posix.c         |  83 ++++++++++++--------
 tests/Makefile.include     |   2 +
 tests/test-image-locking.c | 152 +++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+), 30 deletions(-)
 create mode 100644 tests/test-image-locking.c

-- 
2.17.1
