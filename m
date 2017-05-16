Received: from eggs.gnu.org ([2001:4830:134:3::10]:54477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZ3S-0001bG-Hr
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dAZ3Q-0004z2-NI
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:10 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:40976 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dAZ3Q-0004yQ-C8
	for qemu-devel@nongnu.org; Tue, 16 May 2017 05:46:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 May 2017 12:45:28 +0300
Message-Id: <20170516094533.6160-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/5] nbd: error path refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all. There are several patches, as preparation for v2 of my
NBD BLOCK_STATUS series.

patch 0001 was sent earlier and unchanged here.

Vladimir Sementsov-Ogievskiy (5):
  nbd: strict nbd_wr_syncv
  nbd: read_sync and friends: return 0 on success
  nbd: add errp parameter to nbd_wr_syncv()
  nbd: add errp to read_sync, write_sync and drop_sync
  nbd/client.c: use errp instead of LOG

 block/nbd-client.c  |  11 +++--
 include/block/nbd.h |   8 ++--
 nbd/client.c        | 121 ++++++++++++++++++++++++----------------------------
 nbd/common.c        |  23 +++++-----
 nbd/nbd-internal.h  |  40 ++++++++++++++---
 nbd/server.c        |  92 ++++++++++++++++-----------------------
 qemu-nbd.c          |   3 +-
 7 files changed, 153 insertions(+), 145 deletions(-)

-- 
2.11.1
