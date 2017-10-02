Received: from eggs.gnu.org ([2001:4830:134:3::10]:52164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sZ-0001ZW-2N
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sT-00030a-Jb
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:4944 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dz1sT-0002z5-7C
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:25 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  2 Oct 2017 17:39:14 +0300
Message-Id: <20171002143919.207741-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/5] backup improvements part 1
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
List-ID: <qemu-devel.nongnu.org>

Hi all. Here is a continuation of my "new backup architecture" series,
The very first part, but it is meaningful itself.

01: was previously sent in other my series, but here is more correct
    version, one mistake is fixed.
02: only rebased to new byte-based interfaces (by Eric), r-bs saved
03: changed to use hbitmap_next_zero, also a comment added to
    none-mode (Fam)
04: commit message rewritten. The patch was controversial, but I need
    it for further backup enhancement, so, let's continue the
    discussion.
05: rebased, logic is not changed, r-bs saved


Vladimir Sementsov-Ogievskiy (5):
  hbitmap: add next_zero function
  backup: move from done_bitmap to copy_bitmap
  backup: init copy_bitmap from sync_bitmap for incremental
  backup: simplify non-dirty bits progress processing
  backup: use copy_bitmap in incremental backup

 include/block/dirty-bitmap.h |   1 +
 include/qemu/hbitmap.h       |   8 +++
 block/backup.c               | 117 ++++++++++++++++++++++++-------------------
 block/dirty-bitmap.c         |   5 ++
 util/hbitmap.c               |  29 +++++++++++
 5 files changed, 108 insertions(+), 52 deletions(-)

-- 
2.11.1
