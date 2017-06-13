Received: from eggs.gnu.org ([2001:4830:134:3::10]:52759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dKiGh-00050s-Kw
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dKiGd-0006XC-MP
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:37:47 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:47166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dKiGd-0006Wl-Gf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:37:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORH000OVC2OHI30@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:37:37 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 13 Jun 2017 12:36:31 +0300
Message-id: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170613093736eucas1p17c1164431236b6c0b827e607f8598c27@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v1 0/2] Add bitmap for copied pages in postcopy
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
Cc: Alexey Perevalov <a.perevalov@samsung.com>, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

This is a separate patch set, it derived from
https://www.mail-archive.com/qemu-devel@nongnu.org/msg456004.html

There are several possible use cases:
1. solve issue with postcopy live migration and shared memory.
OVS-VSWITCH requires information about copied pages, to fallocate
newly allocated pages.
2. calculation vCPU blocktime
for more details see
https://www.mail-archive.com/qemu-devel@nongnu.org/msg456004.html
3. Recovery after fail in the middle of postcopy migration 

Declaration is placed in two places include/migration/migration.h and into
migration/postcopy-ram.h, because some functions are required in virtio.

Alexey Perevalov (2):
  migration: postcopy_place_page factoring out
  migration: add bitmap for copied page

 include/exec/ram_addr.h       |  3 +++
 include/migration/migration.h |  3 +++
 migration/postcopy-ram.c      | 20 +++++++++++----
 migration/postcopy-ram.h      |  4 +--
 migration/ram.c               | 58 ++++++++++++++++++++++++++++++++++++++++---
 migration/ram.h               |  5 ++++
 migration/savevm.c            |  1 +
 7 files changed, 84 insertions(+), 10 deletions(-)

-- 
1.9.1
