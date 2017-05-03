Received: from eggs.gnu.org ([2001:4830:134:3::10]:54336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d610k-0002Js-OQ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d610j-0001ry-Dd
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d610j-0001rI-7b
	for qemu-devel@nongnu.org; Wed, 03 May 2017 16:36:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  3 May 2017 17:35:46 -0300
Message-Id: <20170503203604.31462-4-ehabkost@redhat.com>
In-Reply-To: <20170503203604.31462-1-ehabkost@redhat.com>
References: <20170503203604.31462-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND v2 03/21] xen-backend: Remove FIXME
 comment about user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Juergen Gross <jgross@suse.com>, sstabellini@kernel.org

xen-backend can be plugged/unplugged dynamically when using the
Xen accelerator, so keep the user_creatable flag on the device
class and remove the FIXME comment.

Cc: Juergen Gross <jgross@suse.com>,
Cc: Peter Maydell <peter.maydell@linaro.org>,
Cc: Thomas Huth <thuth@redhat.com>
Cc: sstabellini@kernel.org
Cc: Markus Armbruster <armbru@redhat.com>,
Cc: Marcel Apfelbaum <marcel@redhat.com>,
Cc: Laszlo Ersek <lersek@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2:
* (New patch added to series)
---
 hw/xen/xen_backend.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index 67cb4cb9f0..2b91d2d458 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -619,10 +619,7 @@ static void xendev_class_init(ObjectClass *klass, void *data)
 
     dc->props = xendev_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
+    /* xen-backend devices can be plugged/unplugged dynamically */
     dc->user_creatable = true;
 }
 
-- 
2.11.0.259.g40922b1
