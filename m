Received: from eggs.gnu.org ([2001:4830:134:3::10]:36022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gS5yM-0004kv-8I
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gS5yH-0003sq-AP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:58:10 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 28 Nov 2018 20:27:06 +0100
Message-Id: <20181128195802.B6A6C7456B9@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] i2c: Move typedef of bitbang_i2c_interface to
 i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

Clang 3.4 considers duplicate typedef in ppc4xx_i2c.h and
bitbang_i2c.h an error even if they are identical. Move it to a common
place to allow building with this clang version.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/i2c/bitbang_i2c.h        | 2 --
 include/hw/i2c/i2c.h        | 2 ++
 include/hw/i2c/ppc4xx_i2c.h | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/i2c/bitbang_i2c.h b/hw/i2c/bitbang_i2c.h
index 3a7126d5de..9443021710 100644
--- a/hw/i2c/bitbang_i2c.h
+++ b/hw/i2c/bitbang_i2c.h
@@ -3,8 +3,6 @@
 
 #include "hw/i2c/i2c.h"
 
-typedef struct bitbang_i2c_interface bitbang_i2c_interface;
-
 #define BITBANG_I2C_SDA 0
 #define BITBANG_I2C_SCL 1
 
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 5dc166158b..cf4c45a98f 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -82,6 +82,8 @@ int i2c_recv(I2CBus *bus);
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
 
+typedef struct bitbang_i2c_interface bitbang_i2c_interface;
+
 /* lm832x.c */
 void lm832x_key_event(DeviceState *dev, int key, int state);
 
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 0891a9c948..b3450bacf7 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -31,9 +31,6 @@
 #include "hw/sysbus.h"
 #include "hw/i2c/i2c.h"
 
-/* from hw/i2c/bitbang_i2c.h */
-typedef struct bitbang_i2c_interface bitbang_i2c_interface;
-
 #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
 #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_I2C)
 
-- 
2.13.7
