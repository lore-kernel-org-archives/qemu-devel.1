Received: from eggs.gnu.org ([2001:4830:134:3::10]:52924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKWm8-00023v-FI
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKWm7-0007oc-ND
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:21:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40075
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKWm7-0007nr-FS
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 17:21:27 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 12 Jun 2017 22:21:10 +0100
Message-Id: <1497302470-10776-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 4/4] fw_cfg: move QOM type defines into
 fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

This allows the device to be instantiated externally for boards that
wish to wire up the fw_cfg device themselves.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c         |    8 --------
 include/hw/nvram/fw_cfg.h |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 6c21e43..22a8404 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -40,14 +40,6 @@
 #define FW_CFG_NAME "fw_cfg"
 #define FW_CFG_PATH "/machine/" FW_CFG_NAME
 
-#define TYPE_FW_CFG     "fw_cfg"
-#define TYPE_FW_CFG_IO  "fw_cfg_io"
-#define TYPE_FW_CFG_MEM "fw_cfg_mem"
-
-#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
-#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
-#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
-
 /* FW_CFG_VERSION bits */
 #define FW_CFG_VERSION      0x01
 #define FW_CFG_VERSION_DMA  0x02
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b980cba..e515698 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -4,6 +4,14 @@
 #include "exec/hwaddr.h"
 #include "hw/nvram/fw_cfg_keys.h"
 
+#define TYPE_FW_CFG     "fw_cfg"
+#define TYPE_FW_CFG_IO  "fw_cfg_io"
+#define TYPE_FW_CFG_MEM "fw_cfg_mem"
+
+#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
+#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
+#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
+
 typedef struct FWCfgFile {
     uint32_t  size;        /* file size */
     uint16_t  select;      /* write this to 0x510 to read it */
-- 
1.7.10.4
