Received: from eggs.gnu.org ([2001:4830:134:3::10]:42149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6EpJ-0003kl-7r
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6EpG-0002vV-50
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 08:26:13 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 11 Apr 2018 15:26:04 +0300
Message-Id: <20180411122606.367301-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/2] bitmaps persistent and migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, jsnow@redhat.com

v2:

01: new, proposed by Max
02: fix leaving cat processes

Vladimir Sementsov-Ogievskiy (2):
  qcow2: try load bitmaps only once
  iotests: fix 169

 block/qcow2.h          |  1 +
 block/qcow2.c          | 16 ++++++++--------
 tests/qemu-iotests/169 | 48 +++++++++++++++++++++++++++---------------------
 3 files changed, 36 insertions(+), 29 deletions(-)

-- 
2.11.1
