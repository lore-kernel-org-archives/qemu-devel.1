Received: from eggs.gnu.org ([2001:4830:134:3::10]:59077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDH-0005QV-J9
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDE-0004E3-FY
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dAzDE-0004Dh-9I
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:39:55 -0300
Message-Id: <20170517134003.17110-15-ehabkost@redhat.com>
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
References: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 14/22] fw_cfg: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Gabriel L . Somlo" <somlo@cmu.edu>

fw_cfg won't work with -device, as:
* fw_cfg_init1() won't get called for the device;
* The device won't appear at /machine/fw_cfg, and won't work with
  the -fw_cfg command-line option.

Remove the user_creatable flag from the device class.

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gabriel L. Somlo <somlo@cmu.edu>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170503203604.31462-15-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
