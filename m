Received: from eggs.gnu.org ([2001:4830:134:3::10]:44718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfYcD-0006Ed-RZ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfYc8-0000lq-SB
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:34:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dfYc8-0000lg-M6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:34:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3FA91FE333
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 21:34:03 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
Date: Wed,  9 Aug 2017 23:33:36 +0200
Message-Id: <20170809213337.3013-2-jfreimann@redhat.com>
In-Reply-To: <20170809213337.3013-1-jfreimann@redhat.com>
References: <20170809213337.3013-1-jfreimann@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] tests/vhost-user-bridge: disable debug
 output by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mst@redhat.com, victork@redhat.com, maxime.coquelin@redhat.com, jasowang@redhat.com, stefanha@redhat.com

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
index 1e5b5ca3da..93d95353d7 100644
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
2.13.3
