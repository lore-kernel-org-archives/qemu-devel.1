Received: from eggs.gnu.org ([2001:4830:134:3::10]:44004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYfX-0005p0-Hf
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYfU-0002fM-Ck
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:43:27 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Aug 2018 15:43:18 +0300
Message-Id: <20180814124320.39481-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] block: make .bdrv_close optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, jcody@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Several block drivers have to define empty .bdrv_close handler. Let's
instead make it optional.

Vladimir Sementsov-Ogievskiy (2):
  block: make .bdrv_close optional
  block: drop empty .bdrv_close handlers

 block.c              | 4 +++-
 block/blkreplay.c    | 5 -----
 block/commit.c       | 5 -----
 block/copy-on-read.c | 6 ------
 block/mirror.c       | 5 -----
 block/null.c         | 6 ------
 block/raw-format.c   | 5 -----
 block/snapshot.c     | 4 +++-
 8 files changed, 6 insertions(+), 34 deletions(-)

-- 
2.11.1
