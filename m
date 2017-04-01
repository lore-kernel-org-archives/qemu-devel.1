Received: from eggs.gnu.org ([2001:4830:134:3::10]:51591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Bx-0004f1-Td
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Bw-000638-Vi
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:09 -0300
Message-Id: <20170401004624.30886-5-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 04/19] fdc: Remove user_creatable flag from
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
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

sysbus-fdc and SUNW,fdtwo devices need to be wired by the fdc
initialization code, and can't be used with -device. Unset
user_creatable on their device classes.

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/block/fdc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index a06c8e358c..a328693d15 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2880,11 +2880,6 @@ static void sysbus_fdc_class_init(ObjectClass *klass, void *data)
 
     dc->props = sysbus_fdc_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo sysbus_fdc_info = {
@@ -2911,11 +2906,6 @@ static void sun4m_fdc_class_init(ObjectClass *klass, void *data)
 
     dc->props = sun4m_fdc_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo sun4m_fdc_info = {
-- 
2.11.0.259.g40922b1
