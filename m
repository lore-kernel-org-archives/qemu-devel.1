Received: from eggs.gnu.org ([2001:4830:134:3::10]:44139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxP2a-0006LB-Vb
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 22:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxP2a-0007W7-6G
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 22:26:52 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Apr 2017 10:26:34 +0800
Message-Id: <20170410022636.29925-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] block: Quiesce old aio context during
 bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v3: Use bdrv_parent_drained_begin/end. [Kevin]
    Do it before releasing new_context. [Stefan]

Fam Zheng (2):
  block: Make bdrv_parent_drained_begin/end public
  block: Quiesce old aio context during bdrv_set_aio_context

 block.c               |  7 +++++--
 block/io.c            |  4 ++--
 include/block/block.h | 16 ++++++++++++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.9.3
