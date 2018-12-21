Received: from eggs.gnu.org ([2001:4830:134:3::10]:40451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gaO3b-0002EY-Ew
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gaO3X-0007TR-E2
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:53:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 21 Dec 2018 19:53:39 +0300
Message-Id: <20181221165341.23736-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 0/2] improve block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com
Cc: pizhenwei@bytedance.com

Support QOM path for block-latency-histogram-set and drop x- prefix.

Libvirt discussion (not yet updated for using id instead of device):
https://www.redhat.com/archives/libvir-list/2018-September/msg00011.html

v3: rebase on master, s/3.1/4.0.

v2: id,device -> id (with fall back to device name)
    fix versions and all remaining x_ prefixes

Vladimir Sementsov-Ogievskiy (2):
  qapi: move to QOM path for x-block-latency-histogram-set
  qapi: drop x- from x-block-latency-histogram-set

 qapi/block-core.json | 24 ++++++++++++------------
 block/qapi.c         | 12 ++++++------
 blockdev.c           | 24 ++++++++++++++++--------
 3 files changed, 34 insertions(+), 26 deletions(-)

-- 
2.18.0
