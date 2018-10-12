Received: from eggs.gnu.org ([2001:4830:134:3::10]:60528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAxHv-0003II-HJ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAxHk-0002FA-8W
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:15:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 12 Oct 2018 16:15:07 +0300
Message-Id: <20181012131509.16370-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/2] improve block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com

Support QOM path for block-latency-histogram-set and drop x- prefix.

Libvirt discussion (not yet updated for using id instead of device):
https://www.redhat.com/archives/libvir-list/2018-September/msg00011.html

v2: id,device -> id (with fall back to device name)
    fix versions and all remaining x_ prefixes

Vladimir Sementsov-Ogievskiy (2):
  qapi: move to QOM path for x-block-latency-histogram-set
  qapi: drop x- from x-block-latency-histogram-set

 qapi/block-core.json | 24 ++++++++++++------------
 block/qapi.c         | 12 ++++++------
 blockdev.c           | 18 +++++++++++++-----
 3 files changed, 31 insertions(+), 23 deletions(-)

-- 
2.18.0
