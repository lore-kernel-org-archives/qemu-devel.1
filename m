Received: from eggs.gnu.org ([209.51.188.92]:40933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtMTk-0003Tm-Kk
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtMTi-0007vK-7x
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 20:03:16 -0500
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Feb 2019 20:02:43 -0500
Message-Id: <20190212010248.11056-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] dirty-bitmaps: deprecate @status field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, eblake@redhat.com, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

The current internal meanings of "locked", "user_locked",
"qmp_locked", "frozen", "enabled", and "disabled" are all
a little muddled.

Deprecate the @status field in favor of two new booleans
that carry very specific meanings. Then, rename and rework
some of the internal semantics to help make the API a bit
more clear and easier to read.

Well, in my opinion.

Based on my current bitmaps branch (includes Eric's patch
and my documentation update patch.)

John Snow (5):
  block/dirty-bitmap: add recording and busy properties
  block/dirty-bitmaps: rename frozen predicate helper
  block/dirty-bitmap: change semantics of enabled predicate
  block/dirty-bitmap: explicitly lock bitmaps with successors
  block/dirty-bitmaps: unify qmp_locked and user_locked calls

 block/dirty-bitmap.c           | 74 +++++++++++++++++++---------------
 blockdev.c                     | 18 ++++-----
 include/block/dirty-bitmap.h   |  7 ++--
 migration/block-dirty-bitmap.c |  8 ++--
 nbd/server.c                   |  6 +--
 qapi/block-core.json           |  9 ++++-
 tests/qemu-iotests/236.out     | 28 +++++++++++++
 7 files changed, 96 insertions(+), 54 deletions(-)

-- 
2.17.2
