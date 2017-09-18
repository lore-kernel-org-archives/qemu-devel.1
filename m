Received: from eggs.gnu.org ([2001:4830:134:3::10]:38476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaS-0001jT-GH
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaR-0001Sy-Ko
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:48 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:22398 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dtwaR-0001Rg-9I
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Sep 2017 16:59:28 +0300
Message-Id: <20170918135935.255591-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/7] nbd client refactoring and fixing
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

v2: Actually - tail of v1 series, with changes, additions and rebased
  on recent work in upstream (which includes some patches from v1 too)

Vladimir Sementsov-Ogievskiy (7):
  block/nbd-client: refactor nbd_co_receive_reply
  block/nbd-client: exit reply-reading coroutine on incorrect handle
  block/nbd-client: refactor reading reply
  block/nbd-client: drop reply field from NBDClientSession
  block/nbd-client: nbd_co_send_request: return -EIO if s->quit was set
    in parallel
  block/nbd-client: early fail nbd_read_reply_entry if s->quit is set
  block/nbd-client: do not yield from nbd_read_reply_entry

 block/nbd-client.h |   4 ++-
 block/nbd-client.c | 103 ++++++++++++++++++++++++++---------------------------
 2 files changed, 54 insertions(+), 53 deletions(-)

-- 
2.11.1
