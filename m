Received: from eggs.gnu.org ([2001:4830:134:3::10]:43563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejHIE-00007Q-SR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejHID-00037w-Ty
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 23:25:10 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue,  6 Feb 2018 20:24:26 -0800
Message-Id: <20180207042438.15422-3-andrew.smirnov@gmail.com>
In-Reply-To: <20180207042438.15422-1-andrew.smirnov@gmail.com>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 02/14] hw: i.MX: Convert i.MX6 to use
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

Convert i.MX6 to use TYPE_IMX_USDHC since that's what real HW comes
with.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/arm/fsl-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index b0d4088290..e6559a8b12 100644
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
