Received: from eggs.gnu.org ([2001:4830:134:3::10]:50673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aZ-0008Uc-8J
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aY-0005aE-Ex
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:07 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ff6aY-0005ZO-7C
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:06 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aX-00010n-71
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:43:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:42:57 +0100
Message-Id: <20180716164300.6731-6-peter.maydell@linaro.org>
In-Reply-To: <20180716164300.6731-1-peter.maydell@linaro.org>
References: <20180716164300.6731-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 5/8] hw/arm/bcm2836: Mark the bcm2836 / bcm2837
 devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

These devices are currently causing some problems when a user is trying
to hot-plug or introspect them during runtime. Since these devices can
not be instantiated by the user at all (they need to be wired up in code
instead), we should mark them with user_creatable = false anyway, then we
avoid at least the crashes with the hot-plugging. The introspection problem
will be handled by a separate patch.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1531415537-26037-1-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2836.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 6805a7d7c81..45d9e40c454 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -185,6 +185,8 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
     bc->info = data;
     dc->realize = bcm2836_realize;
     dc->props = bcm2836_props;
+    /* Reason: Must be wired up in code (see raspi_init() function) */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo bcm283x_type_info = {
-- 
2.17.1
