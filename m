Received: from eggs.gnu.org ([2001:4830:134:3::10]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZau-0001jG-3O
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYZaq-0007Ql-Pz
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:44:12 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 12:42:41 -0300
Message-Id: <20180108154303.6522-10-f4bug@amsat.org>
In-Reply-To: <20180108154303.6522-1-f4bug@amsat.org>
References: <20180108154303.6522-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 09/31] sdhci: add a common class
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

so this class can be inherited.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 4a9c3e9175..a80b7c0424 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -124,4 +124,16 @@ typedef struct SDHCIState {
 #define SYSBUS_SDHCI(obj)                               \
      OBJECT_CHECK(SDHCIState, (obj), TYPE_SYSBUS_SDHCI)
 
+typedef struct {
+    /*< private >*/
+    BusClass parent_class;
+    /*< public >*/
+    DeviceRealize parent_realize;
+} SDHCICommonClass;
+
+#define SYSBUS_SDHCI_COMMON_CLASS(klass) \
+        OBJECT_CLASS_CHECK(SDHCICommonClass, (klass), TYPE_SYSBUS_SDHCI)
+#define SYSBUS_SDHCI_COMMON_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(SDHCICommonClass, (obj), TYPE_SYSBUS_SDHCI)
+
 #endif /* SDHCI_H */
-- 
2.15.1
