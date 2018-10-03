Received: from eggs.gnu.org ([2001:4830:134:3::10]:57154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7kXk-0001aC-8E
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7kXh-0001do-1i
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  3 Oct 2018 20:02:26 +0300
Message-Id: <20181003170228.95973-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] nbd server: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, rjones@redhat.com, berrange@redhat.com

It's unexpected behavior that without -x option qemu-nbd do old-style
negotiation. Let's use "" as a default name instead (as it is already
done if tls is used) and therefore, drop old-style negotiation from
Qemu NBD server.

Vladimir Sementsov-Ogievskiy (2):
  qemu-nbd: drop old-style negotiation
  nbd/server: drop old-style negotiation

 include/block/nbd.h |  3 +--
 blockdev-nbd.c      |  2 +-
 nbd/server.c        | 53 +++++++++++++--------------------------------
 qemu-nbd.c          | 25 +++++----------------
 4 files changed, 23 insertions(+), 60 deletions(-)

-- 
2.18.0
