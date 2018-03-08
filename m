Received: from eggs.gnu.org ([2001:4830:134:3::10]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0Yu-0004YM-Pd
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0Yp-0003Iz-Rk
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:46:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  8 Mar 2018 21:46:31 +0300
Message-Id: <20180308184636.178534-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/5] nbd server fixing and refactoring before
 BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

01 and 02 are splitted and updated "[PATCH] nbd/server: fix space read",
others are new.

Vladimir Sementsov-Ogievskiy (5):
  nbd/server: move nbd_co_send_structured_error up
  nbd/server: fix sparse read
  nbd/server: fix: check client->closing before reply sending
  nbd/server: refactor nbd_trip: cmd_read and generic reply
  nbd/server: refactor nbd_trip: split out nbd_handle_request

 nbd/server.c | 302 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 165 insertions(+), 137 deletions(-)

-- 
2.11.1
