Received: from eggs.gnu.org ([209.51.188.92]:57032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h19ZT-00026h-2X
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h19ZS-0006Tt-5s
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:53:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  5 Mar 2019 15:53:15 +0300
Message-Id: <20190305125317.607155-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/2] improve block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

Move to QOM path for block-latency-histogram-set and drop x- prefix.

v4:
01: update definition of @id [Markus]
    go only through qmp_get_blk [Kevin]

Vladimir Sementsov-Ogievskiy (2):
  qapi: move to QOM path for x-block-latency-histogram-set
  qapi: drop x- from x-block-latency-histogram-set

 qapi/block-core.json | 24 ++++++++++++------------
 block/qapi.c         | 12 ++++++------
 blockdev.c           | 14 +++++++-------
 3 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.18.0
