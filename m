Received: from eggs.gnu.org ([2001:4830:134:3::10]:56047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7Ivn-0005YN-Ur
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7Ivk-00017u-PR
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:33:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  2 Oct 2018 14:33:23 +0300
Message-Id: <20181002113325.12911-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] improve block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com, jsnow@redhat.com

Support QOM path for block-latency-histogram-set and drop x- prefix.

Libvirt discussion:
https://www.redhat.com/archives/libvir-list/2018-September/msg00011.html

Vladimir Sementsov-Ogievskiy (2):
  qapi: support device id for x-block-latency-histogram-set
  qapi: drop x- from x-block-latency-histogram-set

 qapi/block-core.json | 10 ++++++----
 blockdev.c           | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.18.0
