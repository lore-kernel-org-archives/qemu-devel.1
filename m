Received: from eggs.gnu.org ([2001:4830:134:3::10]:58940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deYP8-0003gl-Td
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 23:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deYP7-0005px-SD
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 23:08:30 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Sun,  6 Aug 2017 23:08:18 -0400
Message-Id: <cover.1502075213.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] VHDX cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com

Two VHDX items cleaned up:

1. Check for error when calling bdrv_getlength() [Markus]

2. Check for overflow in offset prior to calling bdrv_truncate().

Jeff Cody (2):
  block/vhdx: check error return of bdrv_getlength()
  block/vhdx: check for offset overflow to bdrv_truncate()

 block/vhdx-log.c | 24 ++++++++++++++++++++----
 block/vhdx.c     | 12 +++++++++++-
 2 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.9.4
