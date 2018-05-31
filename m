Received: from eggs.gnu.org ([2001:4830:134:3::10]:43302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fODQf-0003M7-Mp
	for qemu-devel@nongnu.org; Wed, 30 May 2018 22:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fODQe-0001jt-TO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 22:35:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 31 May 2018 10:34:43 +0800
Message-Id: <20180531023445.5923-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

Based-on: <20180529055959.32002-1-famz@redhat.com>
([PATCH v7 00/10] qemu-img convert with copy offloading)

This enhances the backup job to make use of the copy offloading API. It
eliminates the necessity to use the bounce buffer as well as speeding up the
copy operation when the backend supports it.

Fam Zheng (2):
  block: Honour BDRV_REQ_NO_SERIALISING in copy range
  backup: Use copy offloading

 block/backup.c        | 93 +++++++++++++++++++++++++++++++++------------------
 block/io.c            |  6 ++--
 block/trace-events    |  1 +
 include/block/block.h |  5 +--
 4 files changed, 69 insertions(+), 36 deletions(-)

-- 
2.14.3
