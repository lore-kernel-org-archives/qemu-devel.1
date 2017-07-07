Received: from eggs.gnu.org ([2001:4830:134:3::10]:46030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTXtH-00036x-Ey
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTXtG-0001Qy-Bs
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:22:07 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 13:21:51 -0500
Message-Id: <20170707182151.29872-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Promote NBD to supported,
 with new maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

We are promising more than just odd fixes, and Paolo is hoping
to offload the pull requests to me.  Also, enough of NBD is related
to the block layer that it is worth including qemu-block on patches.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

If there are no objections, I'll include this patch and Vladimir's
series in my first NBD pull request.

 MAINTAINERS | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e17216..beaba51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1348,15 +1348,6 @@ W: http://info.iet.unipi.it/~luigi/netmap/
 S: Maintained
 F: net/netmap.c

-Network Block Device (NBD)
-M: Paolo Bonzini <pbonzini@redhat.com>
-S: Odd Fixes
-F: block/nbd*
-F: nbd/
-F: include/block/nbd*
-F: qemu-nbd.c
-T: git git://github.com/bonzini/qemu.git nbd-next
-
 NUMA
 M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
@@ -1710,6 +1701,17 @@ S: Supported
 F: block/iscsi.c
 F: block/iscsi-opts.c

+Network Block Device (NBD)
+M: Eric Blake <eblake@redhat.com>
+M: Paolo Bonzini <pbonzini@redhat.com>
+L: qemu-block@nongnu.org
+S: Maintained
+F: block/nbd*
+F: nbd/
+F: include/block/nbd*
+F: qemu-nbd.c
+T: git git://repo.or.cz/qemu/ericb.git nbd
+
 NFS
 M: Jeff Cody <jcody@redhat.com>
 M: Peter Lieven <pl@kamp.de>
-- 
2.9.4
