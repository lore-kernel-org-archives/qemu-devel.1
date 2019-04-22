Received: from eggs.gnu.org ([209.51.188.92]:51085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP5-0000nm-Ms
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00037z-KZ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 17:58:29 +0300
Message-Id: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/9] block: buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all!

We often need to do read/write with buffer, not qiov. Instead of
creating qiov in such cases, let's introduce corresponding helpers.

Vladimir Sementsov-Ogievskiy (9):
  block: introduce byte-based io helpers
  block/qcow2: use buffer-based io
  block/qcow: use buffer-based io
  block/qed: use buffer-based io
  block/parallels: use buffer-based io
  block/backup: use buffer-based io
  block/commit: use buffer-based io
  block/stream: use buffer-based io
  qemu-img: use buffer-based io

 include/block/block_int.h      | 16 ++++++++++++++++
 include/sysemu/block-backend.h | 19 +++++++++++++++++++
 block/backup.c                 | 14 ++++++--------
 block/commit.c                 |  5 ++---
 block/parallels.c              | 14 ++++++--------
 block/qcow.c                   | 19 ++++++-------------
 block/qcow2.c                  |  9 ++-------
 block/qed-table.c              | 12 +++++-------
 block/qed.c                    |  6 ++----
 block/stream.c                 |  4 +---
 qemu-img.c                     | 13 ++++---------
 11 files changed, 69 insertions(+), 62 deletions(-)

-- 
2.18.0
