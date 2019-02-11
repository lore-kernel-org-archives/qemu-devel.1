Received: from eggs.gnu.org ([209.51.188.92]:48140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB82-0001x0-OL
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB81-0007RH-Pu
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 15:55:57 +0300
Message-Id: <20190211125601.86533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/4] nbd: non-blocking negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

Here is a try of moving to non-blocking negotiation in nbd
code, proposed by Deniel in
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03817.html

in thread "[PATCH v4 00/10] NBD reconnect"
https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg05973.html

Vladimir Sementsov-Ogievskiy (4):
  io/channel: add qio_channel_get_attached_aio_context()
  nbd/client: do negotiation in coroutine
  nbd: do qemu_coroutine_yield during tls handshake
  block/nbd-client: use non-blocking io channel for nbd negotiation

 include/io/channel.h |   9 +++
 block/nbd-client.c   |  10 +--
 io/channel.c         |   5 ++
 nbd/client.c         | 149 ++++++++++++++++++++++++++++++++++---------
 nbd/common.c         |   6 +-
 nbd/server.c         |  45 +++++--------
 nbd/trace-events     |  15 ++---
 7 files changed, 161 insertions(+), 78 deletions(-)

-- 
2.18.0
