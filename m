Received: from eggs.gnu.org ([2001:4830:134:3::10]:50934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1e7hWz-0006lF-77
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1e7hWu-0004eF-8d
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1e7hWu-0004cs-2L
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 08:45:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 131C2D9651
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 12:44:59 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Thu, 26 Oct 2017 14:44:24 +0200
Message-Id: <20171026124425.17957-2-jfreimann@redhat.com>
In-Reply-To: <20171026124425.17957-1-jfreimann@redhat.com>
References: <20171026124425.17957-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [v3 1/2] tests/vhost-user-bridge: disable debug output
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

From: Jens Freimann <jfreiman@redhat.com>

vhost-user-bridge prints out a lot of information, including dumps
of all transmitted data. When called from a testcase this output
clutters the actual test results, so let's make the default no debug
output.

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Jens Freimann <jfreiman@redhat.com>
---
 tests/vhost-user-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index d820033a72..4b18e84b42 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -34,7 +34,7 @@
 #include "standard-headers/linux/virtio_net.h"
 #include "contrib/libvhost-user/libvhost-user.h"
 
-#define VHOST_USER_BRIDGE_DEBUG 1
+#define VHOST_USER_BRIDGE_DEBUG 0
 
 #define DPRINT(...) \
     do { \
-- 
2.13.6
