Received: from eggs.gnu.org ([2001:4830:134:3::10]:33918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejPBW-0002Ga-Ol
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejPBR-0008PX-TH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:50:46 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  7 Feb 2018 15:50:35 +0300
Message-Id: <20180207125037.13510-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/2] block latency histogram
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

v2:

01: add block_latency_histogram_clear()
02: fix spelling (sorry =()
    some rewordings
    remove histogram if latency parameter unspecified

Vladimir Sementsov-Ogievskiy (2):
  block/accounting: introduce latency histogram
  qapi: add block latency histogram interface

 qapi/block-core.json       | 73 +++++++++++++++++++++++++++++++++-
 include/block/accounting.h |  9 +++++
 block/accounting.c         | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 block/qapi.c               | 31 +++++++++++++++
 blockdev.c                 | 19 +++++++++
 5 files changed, 228 insertions(+), 1 deletion(-)

-- 
2.11.1
