Received: from eggs.gnu.org ([2001:4830:134:3::10]:57228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fafsL-0007OK-50
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fafsI-0004eS-17
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:23:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  4 Jul 2018 14:23:00 +0300
Message-Id: <20180704112302.471456-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] nbd base:allocation several extents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

Patch 01 is a fix an should definitely go to 3.0. Patch 02 is an
improvement, so as you want, 3.1 is ok.

The idea is send more than one extent of base:allocation context, if
possible, which is necessary for efficient block-status export, for
clients which support it.

Vladimir Sementsov-Ogievskiy (2):
  nbd/server: fix nbd_co_send_block_status
  nbd/server: send more than one extent of base:allocation context

 nbd/server.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 18 deletions(-)

-- 
2.11.1
