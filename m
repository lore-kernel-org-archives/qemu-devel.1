Received: from eggs.gnu.org ([2001:4830:134:3::10]:42784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZcG-00035i-PX
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZcF-0000DV-Tn
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:45:36 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:58 -0300
Message-Id: <20180108154303.6522-27-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 26/31] sdhci: remove the deprecated
 'capareg' property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Sai Pavan Boddu <saipava@xilinx.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

All SDHCI consumers have been upgraded to set correct properties.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 34bda73b66..ae914a6ef9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1194,9 +1194,7 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     }
     s->version = (SDHC_HCVER_VENDOR << 8) | (s->spec_version - 1);
 
-    if (s->capareg == UINT64_MAX) {
-        sdhci_init_capareg(s, errp);
-    }
+    sdhci_init_capareg(s, errp);
 }
 
 static void sdhci_initfn(SDHCIState *s)
@@ -1345,9 +1343,6 @@ static Property sdhci_properties[] = {
     DEFINE_PROP_UINT8("bus-speed", SDHCIState, cap.sdr, 0),
     DEFINE_PROP_UINT8("driver-strength", SDHCIState, cap.strength, 0),
 
-    /* capareg: deprecated */
-    DEFINE_PROP_UINT64("capareg", SDHCIState, capareg, UINT64_MAX),
-
     DEFINE_PROP_UINT64("maxcurr", SDHCIState, maxcurr, 0),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
-- 
2.15.1
