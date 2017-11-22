Received: from eggs.gnu.org ([2001:4830:134:3::10]:33928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8Z-0001N3-50
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eHS8U-0004m9-7D
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:11 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:37003 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eHS8T-0004jz-MZ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 05:20:05 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 22 Nov 2017 13:19:53 +0300
Message-Id: <20171122101958.17065-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/5] NBD server refactoring before BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all. Here are some preliminary refactoring before implementing
BLOCK_STATUS extension.

Vladimir Sementsov-Ogievskiy (5):
  nbd/server: refactor negotiation functions parameters
  nbd/server: add nbd_opt_{read,drop} to track client->optlen
  nbd/server: add helper nbd_opt_invalid
  nbd: rename nbd_option and nbd_opt_reply
  nbd/server: structurize option reply sending

 include/block/nbd.h |   8 +-
 nbd/client.c        |  12 +--
 nbd/server.c        | 280 +++++++++++++++++++++++++++-------------------------
 3 files changed, 157 insertions(+), 143 deletions(-)

-- 
2.11.1
