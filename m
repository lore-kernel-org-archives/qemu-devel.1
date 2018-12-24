Received: from eggs.gnu.org ([208.118.235.92]:55974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gbJnL-00050U-8W
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 01:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gbJnK-0007Bt-Hh
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 01:32:55 -0500
From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Mon, 24 Dec 2018 14:35:23 +0800
Message-Id: <1545633323-10818-1-git-send-email-dongli.zhang@oracle.com>
Subject: [Qemu-devel] [PATCH 1/1] qdev: rename qdev_create() argument to
 sync with qdev_try_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru, armbru@redhat.com

The second argument used by qdev_create() is typename and 'name' is very
confusing. Rename it from 'name' to 'type', which is the same used by
qdev_try_create().

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/core/qdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 6b3cc55..1d65e8f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -113,17 +113,17 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
 /* Create a new device.  This only initializes the device state
    structure and allows properties to be set.  The device still needs
    to be realized.  See qdev-core.h.  */
-DeviceState *qdev_create(BusState *bus, const char *name)
+DeviceState *qdev_create(BusState *bus, const char *type)
 {
     DeviceState *dev;
 
-    dev = qdev_try_create(bus, name);
+    dev = qdev_try_create(bus, type);
     if (!dev) {
         if (bus) {
-            error_report("Unknown device '%s' for bus '%s'", name,
+            error_report("Unknown device '%s' for bus '%s'", type,
                          object_get_typename(OBJECT(bus)));
         } else {
-            error_report("Unknown device '%s' for default sysbus", name);
+            error_report("Unknown device '%s' for default sysbus", type);
         }
         abort();
     }
-- 
2.7.4
