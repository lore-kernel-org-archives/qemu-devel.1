Received: from eggs.gnu.org ([2001:4830:134:3::10]:40787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fC4EN-0003p4-P7
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fC4EI-0003gF-9v
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:20:11 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 27 Apr 2018 17:20:00 +0300
Message-Id: <20180427142002.21930-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] fix coverity bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, peter.maydell@linaro.org

Hi all.

Here are two bug fixes, thanks to Peter for reporting.

Both are introduced in 2.12.

Vladimir Sementsov-Ogievskiy (2):
  nbd/client: fix nbd_negotiate_simple_meta_context
  migration/block-dirty-bitmap: fix memory leak in
    dirty_bitmap_load_bits

 migration/block-dirty-bitmap.c | 1 +
 nbd/client.c                   | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.11.1
