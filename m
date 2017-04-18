Received: from eggs.gnu.org ([2001:4830:134:3::10]:37215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0UA6-0002F1-Cn
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0UA5-0005ut-LE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:31:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 18 Apr 2017 22:30:42 +0800
Message-Id: <20170418143044.12187-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9-rc5 v4 0/2] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jcody@redhat.com

v4: Split patch, and fix the unsafe bdrv_unref. [Paolo]

Fam Zheng (2):
  block: Walk bs->children carefully in bdrv_drain_recurse
  block: Drain BH in bdrv_drained_begin

 block/io.c            | 23 ++++++++++++++++++++---
 include/block/block.h | 22 ++++++++++++++--------
 2 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.9.3
