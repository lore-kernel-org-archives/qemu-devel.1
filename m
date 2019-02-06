Received: from eggs.gnu.org ([209.51.188.92]:48322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grQSK-0000zV-CZ
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grQSJ-00027U-Lx
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:53:48 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  6 Feb 2019 19:53:40 +0300
Message-Id: <20190206165342.219192-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/2] block: local qiov helper: part I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com

Hi all!

Here is a proposal for a new simple helper for a very often patter
around qemu_iovec_init_external, when we need simple qiov with only
one iov, initialized from external buffer.

Here only block/io.c updated to use new helper, I'll update other
things on top of this separately.

v2:
   - smarter padding for @size and changed structure
   - other fixes (described in each patch in Notes)

Vladimir Sementsov-Ogievskiy (2):
  block: enhance QEMUIOVector structure
  block/io: use qemu_iovec_init_buf

 include/qemu/iov.h | 47 ++++++++++++++++++++++--
 block/io.c         | 90 +++++++++++-----------------------------------
 2 files changed, 66 insertions(+), 71 deletions(-)

-- 
2.18.0
