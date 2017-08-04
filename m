Received: from eggs.gnu.org ([2001:4830:134:3::10]:54655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UT-PP
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007FM-VC
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:27544 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJL-0007Bz-HS
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:23 +0300
Message-Id: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 00/17] nbd client refactoring and fixing
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

A bit more refactoring and fixing before BLOCK_STATUS series.
I've tried to make individual patches simple enough, so there are
a lot of them.

Vladimir Sementsov-Ogievskiy (17):
  nbd/client: fix nbd_opt_go
  nbd/client: refactor nbd_read_eof
  nbd/client: refactor nbd_receive_reply
  nbd/client: fix nbd_send_request to return int
  block/nbd-client: get rid of ssize_t
  block/nbd-client: fix nbd_read_reply_entry
  block/nbd-client: refactor request send/receive
  block/nbd-client: rename nbd_recv_coroutines_enter_all
  block/nbd-client: move nbd_co_receive_reply content into
    nbd_co_request
  block/nbd-client: move nbd_coroutine_end content into nbd_co_request
  block/nbd-client: fix nbd_co_request: set s->reply.handle to 0 on
    error
  block/nbd-client: refactor nbd_co_request
  block/nbd-client: refactor NBDClientSession.recv_coroutine
  block/nbd-client: exit reply-reading coroutine on incorrect handle
  block/nbd-client: refactor reading reply
  block/nbd-client: drop reply field from NBDClientSession
  block/nbd-client: always return EIO on and after the first io channel
    error

 block/nbd-client.h         |   9 ++-
 include/block/nbd.h        |   4 +-
 nbd/nbd-internal.h         |  34 ++++++---
 block/nbd-client.c         | 173 ++++++++++++++++++---------------------------
 nbd/client.c               |  21 +++---
 tests/qemu-iotests/083.out |   4 +-
 6 files changed, 115 insertions(+), 130 deletions(-)

-- 
2.11.1
