Received: from eggs.gnu.org ([209.51.188.92]:56380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3G2b-0005Pr-Ie
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3G2a-00084V-3t
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:12:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 11:12:00 +0300
Message-Id: <20190311081202.13079-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 0/2] improve block-latency-histogram-set
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

v5:
01: fix parameter name s/id/device/ in qapi description
    and examples [Kevin]

v4:
01: update definition of @id [Markus]
    go only through qmp_get_blk [Kevin]

Vladimir Sementsov-Ogievskiy (2):
  qapi: move to QOM path for x-block-latency-histogram-set
  qapi: drop x- from x-block-latency-histogram-set

 qapi/block-core.json | 34 +++++++++++++++++-----------------
 block/qapi.c         | 12 ++++++------
 blockdev.c           | 14 +++++++-------
 3 files changed, 30 insertions(+), 30 deletions(-)

-- 
2.18.0
