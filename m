Received: from eggs.gnu.org ([2001:4830:134:3::10]:47042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5jd-00036P-6B
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5jc-0000rb-GE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:47:05 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:45 -0500
Message-Id: <20180619014319.28272-80-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 079/113] qdev: rename typedef qdev_resetfn() ->
 DeviceReset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

following the DeviceRealize and DeviceUnrealize typedefs,
this unify a bit the new QOM API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180114020412.26160-2-f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b850f664a1dbbc1ea27bef12cd251ee5da0bfe05)
*prereq for 0c53057adb
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/hw/qdev-core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0a71bf83f0..83db53b3f5 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -32,9 +32,9 @@ typedef enum DeviceCategory {
 
 typedef int (*qdev_initfn)(DeviceState *dev);
 typedef int (*qdev_event)(DeviceState *dev);
-typedef void (*qdev_resetfn)(DeviceState *dev);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
+typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus, Error **errp);
 
@@ -117,7 +117,7 @@ typedef struct DeviceClass {
     bool hotpluggable;
 
     /* callbacks */
-    void (*reset)(DeviceState *dev);
+    DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
 
-- 
2.11.0
