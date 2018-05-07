Received: from eggs.gnu.org ([2001:4830:134:3::10]:44811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fFiK4-0006OZ-I6
	for qemu-devel@nongnu.org; Mon, 07 May 2018 11:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fFiJz-0005pY-Ky
	for qemu-devel@nongnu.org; Mon, 07 May 2018 11:45:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  7 May 2018 18:44:53 +0300
Message-Id: <20180507154458.73945-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/5] NBD reconnect: preliminary refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

Here are some preliminary refactoring patches, before NBD reconnect
series.

Vladimir Sementsov-Ogievskiy (5):
  block/nbd-client: split channel errors from export errors
  block/nbd: move connection code from block/nbd to block/nbd-client
  block/nbd-client: split connection from initialization
  block/nbd-client: fix nbd_reply_chunk_iter_receive
  block/nbd-client: don't check ioc

 block/nbd-client.h |   2 +-
 block/nbd-client.c | 163 ++++++++++++++++++++++++++++++++++-------------------
 block/nbd.c        |  41 +-------------
 3 files changed, 107 insertions(+), 99 deletions(-)

-- 
2.11.1
