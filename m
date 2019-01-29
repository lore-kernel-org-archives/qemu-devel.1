Received: from eggs.gnu.org ([209.51.188.92]:53221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goVAQ-0001pI-Ac
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goVA7-0001T5-O8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:19:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 29 Jan 2019 17:37:58 +0300
Message-Id: <20190129143800.88563-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] block: local qiov helper: part I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com

Hi all!

Here is a proposal for a new simple helper for a very often patter
around qemu_iovec_init_external, when we need simple qiov with only
one iov, initialized from external buffer.

Here only block/io.c updated to use new helper, I'll update other
things on top of this separately.

Vladimir Sementsov-Ogievskiy (2):
  block: enhance QEMUIOVector structure
  block/io: use qemu_iovec_init_buf

 include/qemu/iov.h | 41 ++++++++++++++++++++-
 block/io.c         | 89 +++++++++++-----------------------------------
 2 files changed, 60 insertions(+), 70 deletions(-)

-- 
2.18.0
