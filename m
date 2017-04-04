Received: from eggs.gnu.org ([2001:4830:134:3::10]:43409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV0l-0001pR-Ki
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV0k-0002vI-Ng
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  4 Apr 2017 17:24:13 -0300
Message-Id: <20170404202429.14643-6-ehabkost@redhat.com>
In-Reply-To: <20170404202429.14643-1-ehabkost@redhat.com>
References: <20170404202429.14643-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/21] fdc: Remove user_creatable flag from
 sysbus-fdc & SUNW, fdtwo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

sysbus-fdc and SUNW,fdtwo devices need IRQs to be wired and mmio
to be mapped, and can't be used with -device. Unset
user_creatable on their device classes.

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Commit message rewrite only
---
 hw/block/fdc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 3d05565628..a328693d15 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2880,11 +2880,6 @@ static void sysbus_fdc_class_init(ObjectClass *klass, void *data)
 
     dc->props = sysbus_fdc_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo sysbus_fdc_info = {
@@ -2911,11 +2906,6 @@ static void sun4m_fdc_class_init(ObjectClass *klass, void *data)
 
     dc->props = sun4m_fdc_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo sun4m_fdc_info = {
-- 
2.11.0.259.g40922b1
