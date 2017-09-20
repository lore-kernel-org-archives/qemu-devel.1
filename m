Received: from eggs.gnu.org ([2001:4830:134:3::10]:37011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duf2I-0003QJ-Cs
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duf2H-0004c3-CG
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Sep 2017 15:45:04 +0300
Message-Id: <20170920124507.18841-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 0/3] nbd client refactoring and fixing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

v3: dropped all controversial things. I'll try to implement minimal
structured reply and block status over this small residue.

Vladimir Sementsov-Ogievskiy (3):
  block/nbd-client: refactor nbd_co_receive_reply
  block/nbd-client: simplify check in nbd_co_receive_reply
  block/nbd-client: nbd_co_send_request: fix return code

 block/nbd-client.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

-- 
2.11.1
