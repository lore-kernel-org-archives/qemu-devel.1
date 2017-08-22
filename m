Received: from eggs.gnu.org ([2001:4830:134:3::10]:48977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dk91n-0008Su-66
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dk91j-00033V-4a
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:15:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 Aug 2017 15:15:12 +0200
Message-Id: <1503407712-9894-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/digic: Mark device with user_creatable
 = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Antony Pavlov <antonynpavlov@gmail.com>

QEMU currently hangs completely when the user is trying to do a
"device_add digic" on an unrelated ARM machine like integratorcp.
Looks like this device is not meant to be hot-pluggable at all, so
let's simply mark it with "user_creatable = false" to avoid the hang.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/digic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 94f3263..208dfb3 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -101,6 +101,8 @@ static void digic_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = digic_realize;
+    /* Reason: Hangs QEMU when trying to device_add this directly */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo digic_type_info = {
-- 
1.8.3.1
