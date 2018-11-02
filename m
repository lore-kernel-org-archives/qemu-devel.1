Received: from eggs.gnu.org ([2001:4830:134:3::10]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIb7C-0004b6-UI
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIb77-0003J2-Rd
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:12:02 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Nov 2018 18:11:49 +0300
Message-Id: <20181102151152.288399-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/3] nbd-client: drop extra error noise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

It was discussed, that error messages, produced by error_reprt_err's,
added in f140e300 are
1. not really needed
2. subject to race conditions

And it was decided to drop them (switch to trace-points), look thread
https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00833.html

So, I've also dropped error_report_err, added earlier in be41c100c0d
and later in 78a33ab5878.

Hmm, I've tried to run 83 iotest in a loop, and it didn't fail, even
before these patches.

Vladimir Sementsov-Ogievskiy (3):
  error: add error_get_hint
  nbd: publish _lookup functions
  block/nbd-client: use traces instead of noisy error_report_err

 include/block/nbd.h        |  5 +++++
 include/qapi/error.h       |  5 +++++
 nbd/nbd-internal.h         |  5 -----
 block/nbd-client.c         | 27 +++++++++++++++++++++++----
 util/error.c               |  5 +++++
 block/trace-events         |  4 ++++
 tests/qemu-iotests/083.out | 28 ----------------------------
 7 files changed, 42 insertions(+), 37 deletions(-)

-- 
2.18.0
