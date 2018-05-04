Received: from eggs.gnu.org ([2001:4830:134:3::10]:47664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <johnnymarler@gmail.com>) id 1fEfah-0005iV-6b
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <johnnymarler@gmail.com>) id 1fEfag-0000JS-Ay
	for qemu-devel@nongnu.org; Fri, 04 May 2018 14:37:59 -0400
MIME-Version: 1.0
From: Jonathan Marler <johnnymarler@gmail.com>
Date: Fri, 4 May 2018 12:37:56 -0600
Message-ID: <CACKT+Ap2MHCrSCT-0_=KG9UrGAtO7F3EGue6-63-XJxry9=C=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] handle all fdt_get_phandle_errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: crosthwaite.peter@gmail.com, agraf@suse.de, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
---
 device_tree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/device_tree.c b/device_tree.c
index 52c3358..2b75905 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -379,8 +379,12 @@ uint32_t qemu_fdt_get_phandle(void *fdt, const char
*path)

     r = fdt_get_phandle(fdt, findnode_nofail(fdt, path));
     if (r == 0) {
-        error_report("%s: Couldn't get phandle for %s: %s", __func__,
-                     path, fdt_strerror(r));
+        error_report("%s: Node %s does not have a 'phandle'", __func__,
+                     path);
+        exit(1);
+    }
+    if (r == -1) {
+        error_report("%s: Couldn't get phandle for %s", __func__, path);
         exit(1);
     }

-- 
2.1.4
