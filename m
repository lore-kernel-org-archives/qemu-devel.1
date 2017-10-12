Received: from eggs.gnu.org ([2001:4830:134:3::10]:59845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2dvX-0007xR-G7
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2dvW-0004vp-PB
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:4619 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2dvW-0004v7-DQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 16:53:08 +0300
Message-Id: <20171012135313.227864-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/5] backup improvements part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all. Here is a continuation of my "new backup architecture" series,
The very first part, but it is meaningful itself.

v2: rebase on master
01: add test and fix bug
02: move commit about NONE mode to this patch, add John's r-b (hope,
     you are OK with this tiny change)
03: tiny refactor (John)
04: improve commit message, add John's r-b
05: add John's r-b

Vladimir Sementsov-Ogievskiy (5):
  hbitmap: add next_zero function
  backup: move from done_bitmap to copy_bitmap
  backup: init copy_bitmap from sync_bitmap for incremental
  backup: simplify non-dirty bits progress processing
  backup: use copy_bitmap in incremental backup

 include/block/dirty-bitmap.h |   1 +
 include/qemu/hbitmap.h       |   8 +++
 block/backup.c               | 118 ++++++++++++++++++++++++-------------------
 block/dirty-bitmap.c         |   5 ++
 tests/test-hbitmap.c         |  61 ++++++++++++++++++++++
 util/hbitmap.c               |  39 ++++++++++++++
 6 files changed, 180 insertions(+), 52 deletions(-)

-- 
2.11.1
