Received: from eggs.gnu.org ([2001:4830:134:3::10]:41301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1erbf5-0000c9-Tr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1erbf1-0000zb-Ui
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:11 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:47326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1erbf1-0000z2-L9
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:07 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  1 Mar 2018 22:46:34 -0500
Message-Id: <ee94e55496562390786ad924f750de1cf3472644.1519961667.git.jbaron@akamai.com>
In-Reply-To: <cover.1519961667.git.jbaron@akamai.com>
References: <cover.1519961667.git.jbaron@akamai.com>
In-Reply-To: <cover.1519961667.git.jbaron@akamai.com>
References: <cover.1519961667.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH 2/4] rocker: drop local duplex definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, virtio-dev@lists.oasis-open.org

Make use of duplex definitions from net/eth.h.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: virtio-dev@lists.oasis-open.org
---
 hw/net/rocker/rocker_fp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 4b3c984..13a14a0 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -16,17 +16,13 @@
 
 #include "qemu/osdep.h"
 #include "net/clients.h"
+#include "net/eth.h"
 
 #include "rocker.h"
 #include "rocker_hw.h"
 #include "rocker_fp.h"
 #include "rocker_world.h"
 
-enum duplex {
-    DUPLEX_HALF = 0,
-    DUPLEX_FULL
-};
-
 struct fp_port {
     Rocker *r;
     World *world;
-- 
2.7.4
