Received: from eggs.gnu.org ([2001:4830:134:3::10]:51958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Ci-0005H7-T0
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Cf-00072X-QP
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7Cf-00071k-KW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:19 -0300
Message-Id: <20170401004624.30886-15-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 14/19] fw_cfg: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Gabriel L . Somlo" <somlo@cmu.edu>

fw_cfg won't work with -device, as:
* fw_cfg_init1() won't get called for the device;
* The device won't appear at /machine/fw_cfg, and won't work with
  the -fw_cfg command-line option.

Remove the user_creatable flag from the device class.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gabriel L. Somlo <somlo@cmu.edu>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/nvram/fw_cfg.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 60bf4fdd2e..316fca9bc1 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1101,11 +1101,6 @@ static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
 
     dc->realize = fw_cfg_io_realize;
     dc->props = fw_cfg_io_properties;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo fw_cfg_io_info = {
@@ -1172,11 +1167,6 @@ static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
 
     dc->realize = fw_cfg_mem_realize;
     dc->props = fw_cfg_mem_properties;
-    /*
-     * FIXME: Set only for compatibility on q35 machine-type.
-     * Probably never meant to be user-creatable
-     */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo fw_cfg_mem_info = {
-- 
2.11.0.259.g40922b1
