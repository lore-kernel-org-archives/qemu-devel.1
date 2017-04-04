Received: from eggs.gnu.org ([2001:4830:134:3::10]:43684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV1K-0002PP-9Y
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvV1J-0003EQ-5e
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvV1J-0003EB-0L
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 16:25:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  4 Apr 2017 17:24:22 -0300
Message-Id: <20170404202429.14643-15-ehabkost@redhat.com>
In-Reply-To: <20170404202429.14643-1-ehabkost@redhat.com>
References: <20170404202429.14643-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/21] fw_cfg: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Gabriel L . Somlo" <somlo@cmu.edu>

fw_cfg won't work with -device, as:
* fw_cfg_init1() won't get called for the device;
* The device won't appear at /machine/fw_cfg, and won't work with
  the -fw_cfg command-line option.

Remove the user_creatable flag from the device class.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gabriel L. Somlo <somlo@cmu.edu>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* (none)
---
 hw/nvram/fw_cfg.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7993aea792..316fca9bc1 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1101,11 +1101,6 @@ static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
 
     dc->realize = fw_cfg_io_realize;
     dc->props = fw_cfg_io_properties;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo fw_cfg_io_info = {
@@ -1172,11 +1167,6 @@ static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
 
     dc->realize = fw_cfg_mem_realize;
     dc->props = fw_cfg_mem_properties;
-    /*
-     * FIXME: Set only because we are not sure yet if this device
-     * will be outside the q35 sysbus whitelist.
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo fw_cfg_mem_info = {
-- 
2.11.0.259.g40922b1
