Received: from eggs.gnu.org ([209.51.188.92]:44386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h20S3-0000LO-Fl
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h20S1-0002Wu-AY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:21:15 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 21:20:57 +0000
Message-Id: <20190307212058.4890-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190307212058.4890-1-mark.cave-ayland@ilande.co.uk>
References: <20190307212058.4890-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/2] mac_oldworld: use node name instead of
 alias name for hd device in FWPathProvider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, david@gibson.dropbear.id.au

When using -drive to configure the hd drive for the Old World machine, the node
name "disk" should be used instead of the "hd" alias.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_oldworld.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index cc1e463466..460cbc7923 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -402,11 +402,11 @@ static char *heathrow_fw_dev_path(FWPathProvider *p, BusState *bus,
             return g_strdup("cdrom");
         }
 
-        return g_strdup("hd");
+        return g_strdup("disk");
     }
 
     if (!strcmp(object_get_typename(OBJECT(dev)), "ide-hd")) {
-        return g_strdup("hd");
+        return g_strdup("disk");
     }
 
     if (!strcmp(object_get_typename(OBJECT(dev)), "ide-cd")) {
-- 
2.11.0
