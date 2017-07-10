Received: from eggs.gnu.org ([2001:4830:134:3::10]:46744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUaF4-0000bT-IK
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUaF3-000873-Du
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dUaF3-00086l-77
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CB707F6A6
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 15:04:52 +0000 (UTC)
Received: from red.redhat.com (ovpn-121-60.rdu2.redhat.com [10.10.121.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D959D7D51D
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 15:04:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 10:04:30 -0500
Message-Id: <20170710150440.11303-2-eblake@redhat.com>
In-Reply-To: <20170710150440.11303-1-eblake@redhat.com>
References: <20170710150440.11303-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL v2 01/11] MAINTAINERS: Promote NBD to supported,
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

We are promising more than just odd fixes, and Paolo is hoping
to offload the pull requests to me.  Also, enough of NBD is related
to the block layer that it is worth including qemu-block on patches.

While at it, include blockdev-nbd.c and qemu-nbd.texi in the set
of maintained files.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707182151.29872-1-eblake@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e17216..9529c94 100644
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
@@ -1710,6 +1701,18 @@ S: Supported
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
+F: qemu-nbd.*
+F: blockdev-nbd.c
+T: git git://repo.or.cz/qemu/ericb.git nbd
+
 NFS
 M: Jeff Cody <jcody@redhat.com>
 M: Peter Lieven <pl@kamp.de>
-- 
2.9.4
