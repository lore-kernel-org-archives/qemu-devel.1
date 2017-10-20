Received: from eggs.gnu.org ([2001:4830:134:3::10]:33265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5U0D-0002uU-FM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5U07-0006AU-MT
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:54:05 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 20 Oct 2017 11:53:53 +0200
Message-Id: <1508493233-1166-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/display/sm501: Fix comment in
 sm501_sysbus_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>

The "cannot_instantiate_with_device_add_yet" flag has been renamed
to "user_creatable" a while ago.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/sm501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6eddac9..7f18224 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1758,7 +1758,7 @@ static void sm501_sysbus_class_init(ObjectClass *klass, void *data)
     dc->reset = sm501_reset_sysbus;
     dc->vmsd = &vmstate_sm501_sysbus;
     /* Note: pointer property "chr-state" may remain null, thus
-     * no need for dc->cannot_instantiate_with_device_add_yet = true;
+     * no need for dc->user_creatable = false;
      */
 }
 
-- 
1.8.3.1
