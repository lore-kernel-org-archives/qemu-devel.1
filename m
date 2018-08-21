Received: from eggs.gnu.org ([2001:4830:134:3::10]:34190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frv77-0001Ig-Uq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 21:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1frv0a-0000q6-6E
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 20:58:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Aug 2018 08:58:40 +0800
Message-Id: <20180821005843.5146-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/3] file-posix: Simplifications on image
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

v4: Fix test on systems without OFD. [Patchew]

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
 tests/test-image-locking.c | 154 +++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 30 deletions(-)
 create mode 100644 tests/test-image-locking.c

-- 
2.17.1
