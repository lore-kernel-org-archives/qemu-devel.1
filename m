Received: from eggs.gnu.org ([209.51.188.92]:38634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYSC-0007Tj-MD
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYS6-0002xy-ON
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:01:56 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  1 Feb 2019 16:01:32 +0300
Message-Id: <20190201130138.94525-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 0/6] NBD reconnect: prep. refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com

Hi all.

Here is most of preparatory refactoring for NBD reconnect, rebased
on master. Let's push it.

Sorry for a long delay in answering on v4 review and for v4 which
I pinged a lot can't be applied on master directly :(

v5:
02: rebased on master, object_unref() moved to fail: block
05: tiny fixes in commit message [Eric]

Vladimir Sementsov-Ogievskiy (6):
  block/nbd-client: split channel errors from export errors
  block/nbd: move connection code from block/nbd to block/nbd-client
  block/nbd-client: split connection from initialization
  block/nbd-client: fix nbd_reply_chunk_iter_receive
  block/nbd-client: don't check ioc
  block/nbd-client: rename read_reply_co to connection_co

 block/nbd-client.h |   6 +-
 block/nbd-client.c | 196 +++++++++++++++++++++++++++++----------------
 block/nbd.c        |  40 +--------
 3 files changed, 131 insertions(+), 111 deletions(-)

-- 
2.18.0
