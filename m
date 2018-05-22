Received: from eggs.gnu.org ([2001:4830:134:3::10]:50749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ9-0001fE-2I
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ6-0007SE-VR
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fLCJ6-0007Rj-Pk
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:48 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 22 May 2018 11:46:40 -0700
Message-Id: <1527014802-11289-13-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL v2 13/15] xen_backend: make the
 xen_feature_grant_copy flag private
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

There is no longer any use of this flag outside of the xen_backend code.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony Perard <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
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
1.9.1
