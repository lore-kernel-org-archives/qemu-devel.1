Received: from eggs.gnu.org ([2001:4830:134:3::10]:52967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkVvv-0004Hy-2D
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkVvu-0001wc-BW
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:42:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 23 Aug 2017 21:42:38 +0800
Message-Id: <20170823134242.12080-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/4] block: Fix non-shared storage
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This fixes the issue reported as https://bugs.launchpad.net/bugs/1711602

Fam Zheng (3):
  block-backend: Refactor inactivate check
  block-backend: Allow more "can inactivate" cases
  mirror: Mark target BB as "force allow inactivate"

Stefan Hajnoczi (1):
  block: Update open_flags after ->inactivate() callback

 block.c                        |  7 +++----
 block/block-backend.c          | 30 +++++++++++++++++++++++++-----
 block/mirror.c                 | 14 ++++++++++++--
 include/sysemu/block-backend.h |  1 +
 4 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.13.5
