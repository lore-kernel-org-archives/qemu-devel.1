Received: from eggs.gnu.org ([2001:4830:134:3::10]:41384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faPiZ-0004XJ-4Q
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faPiV-0006TO-5O
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:07:59 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  3 Jul 2018 21:07:49 +0300
Message-Id: <20180703180751.243496-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] fix image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all.

It's a continuation of discussion under
"[PATCH v2 2/3] block/fleecing-filter: new filter driver for fleecing" [1].

Here is my try to implement Kevin's idea, that all backup writes (for
fleecing case) should be serialized. (However, I've skipped for now
fixing related permissions).

Looks like these patches may replace patch [1], to make fleecing scheme
safe. But I'm not sure, a look by Kevin is necessary.

A test is still needed, to prove that this patch is necessary and that it
works..

Vladimir Sementsov-Ogievskiy (2):
  block: add BDRV_REQ_SERIALISING flag
  block/backup: fix fleecing scheme: use serialized writes

 include/block/block.h |  5 ++++-
 block/backup.c        | 21 ++++++++++++++++++---
 block/io.c            |  4 ++++
 3 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.11.1
