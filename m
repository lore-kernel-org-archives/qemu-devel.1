Received: from eggs.gnu.org ([2001:4830:134:3::10]:55515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUtL-0001eY-V3
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ePUtL-0000sc-2d
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 09:53:44 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 14 Dec 2017 06:52:53 -0800
Message-Id: <20171214145255.31545-14-andrew.smirnov@gmail.com>
In-Reply-To: <20171214145255.31545-1-andrew.smirnov@gmail.com>
References: <20171214145255.31545-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/15] hw: i.MX: Convert i.MX6 to use
 TYPE_IMX_USDHC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Convert i.MX6 to use TYPE_IMX_USDHC since that's what real HW comes
with.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/arm/fsl-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 2ed7146c52..b9249dbfc8 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -93,7 +93,7 @@ static void fsl_imx6_init(Object *obj)
     }
 
     for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
-        object_initialize(&s->esdhc[i], sizeof(s->esdhc[i]), TYPE_SYSBUS_SDHCI);
+        object_initialize(&s->esdhc[i], sizeof(s->esdhc[i]), TYPE_IMX_USDHC);
         qdev_set_parent_bus(DEVICE(&s->esdhc[i]), sysbus_get_default());
         snprintf(name, NAME_SIZE, "sdhc%d", i + 1);
         object_property_add_child(obj, name, OBJECT(&s->esdhc[i]), NULL);
-- 
2.14.3
