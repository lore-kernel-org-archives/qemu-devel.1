Received: from eggs.gnu.org ([2001:4830:134:3::10]:40647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCLTX-0005vt-50
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCLTU-0000RM-1i
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:12:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  8 Nov 2017 19:12:31 +1100
Message-Id: <20171108081232.28322-3-david@gibson.dropbear.id.au>
In-Reply-To: <20171108081232.28322-1-david@gibson.dropbear.id.au>
References: <20171108081232.28322-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/3] hw/display/sm501: Fix comment in
 sm501_sysbus_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The "cannot_instantiate_with_device_add_yet" flag has been renamed
to "user_creatable" a while ago.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6eddac911e..7f1822421a 100644
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
2.13.6
