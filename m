Received: from eggs.gnu.org ([2001:4830:134:3::10]:49077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euK1p-0003Wn-Lw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euK1m-0006LI-H0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:33:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  9 Mar 2018 18:33:45 +0300
Message-Id: <20180309153347.62552-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nshirokovskiy@virtuozzo.com

v4:

Move block_latency_histogram_set from block/accounting.c to
blockdev.c, as it uses qapi type uint64List and this fact breaks
build.


v3:

- semantics, naming and wording changed a lot
- x prefixes added to new qapi names
- bug fixed about calculation of new_size (new_nbins now)
- drop g_renew
- in _clear() set nbinst to zero too

v2:

01: add block_latency_histogram_clear()
02: fix spelling (sorry =()
    some rewordings
    remove histogram if latency parameter unspecified

Vladimir Sementsov-Ogievskiy (2):
  block/accounting: introduce latency histogram
  qapi: add block latency histogram interface

 qapi/block-core.json       | 111 ++++++++++++++++++++++++++++++++++++++++++++-
 include/block/accounting.h |  32 +++++++++++++
 block/accounting.c         |  59 ++++++++++++++++++++++++
 block/qapi.c               |  41 +++++++++++++++++
 blockdev.c                 |  76 +++++++++++++++++++++++++++++++
 5 files changed, 318 insertions(+), 1 deletion(-)

-- 
2.11.1
