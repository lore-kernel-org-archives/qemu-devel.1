Received: from eggs.gnu.org ([2001:4830:134:3::10]:59762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d6OP2-00037K-E7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d6OP1-0008NS-QZ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:35:12 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Thu,  4 May 2017 17:34:59 -0400
Message-Id: <cover.1493933558.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] Minor VXHS fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, ashmit602@gmail.com, stefanha@redhat.com

This fixes a couple of small issues with VXHS; modularization, and improved
error messaging.

Jeff Cody (2):
  block/vxhs: Allow VXHS to be built as a module
  block/vxhs: set errp on iio_init() failure

 block/vxhs.c | 1 +
 configure    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.9.3
