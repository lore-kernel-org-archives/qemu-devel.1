Received: from eggs.gnu.org ([2001:4830:134:3::10]:54240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fxRcp-0002YG-IV
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fxRcm-0005AS-Dj
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:49:15 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fxRck-00058C-Fi
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:49:12 -0400
Received: by mail-pg1-x542.google.com with SMTP id s7-v6so2942649pgc.0
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 23:49:09 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue,  4 Sep 2018 23:49:01 -0700
Message-Id: <1536130141-2742-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] qdev: fix a typo in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, armbru@redhat.com, f4bug@amsat.org
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Found by reading code.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/core/qdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 529b82de18..7e4bfcb8f7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -643,7 +643,7 @@ static void qdev_get_legacy_property(Object *obj, Visitor *v,
  * the string depends on the property type.  Legacy properties are only
  * needed for "info qtree".
  *
- * Do not use this is new code!  QOM Properties added through this interface
+ * Do not use this in new code!  QOM Properties added through this interface
  * will be given names in the "legacy" namespace.
  */
 static void qdev_property_add_legacy(DeviceState *dev, Property *prop,
-- 
2.11.0
