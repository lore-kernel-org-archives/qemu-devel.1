Received: from eggs.gnu.org ([2001:4830:134:3::10]:35751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEgLU-0001U8-1l
	for qemu-devel@nongnu.org; Fri, 04 May 2018 15:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=655ddeee3=Paul.Durrant@citrix.com>)
	id 1fEgLQ-0006i4-1w
	for qemu-devel@nongnu.org; Fri, 04 May 2018 15:26:20 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 4 May 2018 20:26:05 +0100
Message-ID: <1525461967-32174-7-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 6/8] xen_backend: make the
 xen_feature_grant_copy flag private
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

There is no longer any use of this flag outside of the xen_backend code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>

v2:
 - New in v2
---
 hw/xen/xen_backend.c         | 2 +-
 include/hw/xen/xen_backend.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 3c3fc2c..9a8e877 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -44,9 +44,9 @@ BusState *xen_sysbus;
 /* public */
 struct xs_handle *xenstore = NULL;
 const char *xen_protocol;
-bool xen_feature_grant_copy;
 
 /* private */
+static bool xen_feature_grant_copy;
 static int debug;
 
 int xenstore_write_be_str(struct XenDevice *xendev, const char *node, const char *val)
diff --git a/include/hw/xen/xen_backend.h b/include/hw/xen/xen_backend.h
index 29bf1c3..9c17fdd 100644
--- a/include/hw/xen/xen_backend.h
+++ b/include/hw/xen/xen_backend.h
@@ -16,7 +16,6 @@
 /* variables */
 extern struct xs_handle *xenstore;
 extern const char *xen_protocol;
-extern bool xen_feature_grant_copy;
 extern DeviceState *xen_sysdev;
 extern BusState *xen_sysbus;
 
-- 
2.1.4
