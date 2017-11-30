Received: from eggs.gnu.org ([2001:4830:134:3::10]:41095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKnl2-0005SQ-JC
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKnkG-0001Lw-Lm
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:01:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 30 Nov 2017 19:47:48 +0300
Message-Id: <20171130164750.47320-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/2] qcow2: add overlap check for
 bitmap directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com

Add simple constant overlap check.

Vladimir Sementsov-Ogievskiy (2):
  qcow2: add overlap check for bitmap directory
  qcow2: fix indentation after previous patch

 block/qcow2.h          | 45 ++++++++++++++++++++++++---------------------
 block/qcow2-refcount.c | 12 ++++++++++++
 block/qcow2.c          | 22 ++++++++++++++--------
 3 files changed, 50 insertions(+), 29 deletions(-)

-- 
2.11.1
