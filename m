Received: from eggs.gnu.org ([2001:4830:134:3::10]:56211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFQ-00029w-Jc
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFQ-00025D-2A
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFP-00024z-Tx
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:35 -0400
Date: Thu, 3 May 2018 22:50:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-12-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 11/67] rocker: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>

We don't use net/clients.h, drop that include.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/rocker/rocker_fp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 27b17c8..4aa7da7 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -15,7 +15,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "net/clients.h"
 #include "qapi/qapi-types-rocker.h"
 #include "rocker.h"
 #include "rocker_hw.h"
-- 
MST
