Received: from eggs.gnu.org ([2001:4830:134:3::10]:34980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQa6c-0006BY-Pj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQa6b-000708-L7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:38 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60701
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dQa6b-0006zn-E4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:07:37 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 29 Jun 2017 15:07:17 +0100
Message-Id: <1498745240-30658-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv7 3/6] fw_cfg: switch fw_cfg_find() to locate
 the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

This will enable the fw_cfg device to be placed anywhere within the QOM tree
regardless of its machine location.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nvram/fw_cfg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 99bdbc2..0fe7404 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1017,7 +1017,7 @@ FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
 
 FWCfgState *fw_cfg_find(void)
 {
-    return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
+    return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
 }
 
 static void fw_cfg_class_init(ObjectClass *klass, void *data)
-- 
1.7.10.4
