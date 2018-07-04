Received: from eggs.gnu.org ([2001:4830:134:3::10]:44032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1faj4Y-0002MV-I9
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1faj4X-00080a-Vl
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:47:58 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  4 Jul 2018 16:47:49 +0200
Message-Id: <20180704144751.28527-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] file-posix: Fix creation locking
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

This series fixes two bugs Kevin spotted in file-posix's creation
locking.


Max Reitz (2):
  file-posix: Fix creation locking
  file-posix: Unlock FD after creation

 block/file-posix.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.17.1
