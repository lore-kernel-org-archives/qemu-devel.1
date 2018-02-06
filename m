Received: from eggs.gnu.org ([2001:4830:134:3::10]:43699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej3uE-00038y-NQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej3uA-0004F7-PY
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:07:30 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  6 Feb 2018 17:07:20 +0300
Message-Id: <20180206140722.10110-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, vsementsov@virtuozzo.com

Vladimir Sementsov-Ogievskiy (2):
  block/accounting: introduce latency histogram
  qapi: add block latency histogram interface

 qapi/block-core.json       | 62 +++++++++++++++++++++++++++++++++-
 include/block/accounting.h |  8 +++++
 block/accounting.c         | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 block/qapi.c               | 31 +++++++++++++++++
 blockdev.c                 | 15 +++++++++
 5 files changed, 198 insertions(+), 1 deletion(-)

-- 
2.11.1
