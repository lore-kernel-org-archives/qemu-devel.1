Received: from eggs.gnu.org ([2001:4830:134:3::10]:45818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1deofS-0007Au-DH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1deofN-0003zh-Nv
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:30:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  7 Aug 2017 15:30:03 -0500
Message-Id: <20170807203007.19033-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/4] More blk_getlength() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org

Thanks again to Markus for catching these spots.

Eric Blake (4):
  vpc: Check failure of bdrv_getlength()
  qcow: Check failure of bdrv_getlength() and bdrv_truncate()
  qcow2: Drop debugging dump_refcounts()
  qcow2: Check failure of bdrv_getlength()

 block/qcow.c  | 64 +++++++++++++++++++++++++++++++++++++++++------------------
 block/qcow2.c | 26 ++++--------------------
 block/vpc.c   |  9 ++++++++-
 3 files changed, 57 insertions(+), 42 deletions(-)

-- 
2.13.4
