Received: from eggs.gnu.org ([2001:4830:134:3::10]:33753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJu-0003i4-AL
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJt-00086n-Al
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJt-00084x-3P
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJj-0000Y1-Al
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:25 +0000
Message-Id: <20180301112403.12487-5-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/42] i2c: Fix some brace style issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Message-id: 20180227104903.21353-2-linus.walleij@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/i2c.h | 6 ++----
 hw/i2c/core.c        | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 24e95d0155..8fd449f645 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -25,8 +25,7 @@ typedef struct I2CSlave I2CSlave;
 #define I2C_SLAVE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(I2CSlaveClass, (obj), TYPE_I2C_SLAVE)
 
-typedef struct I2CSlaveClass
-{
+typedef struct I2CSlaveClass {
     DeviceClass parent_class;
 
     /* Callbacks provided by the device.  */
@@ -50,8 +49,7 @@ typedef struct I2CSlaveClass
     int (*event)(I2CSlave *s, enum i2c_event event);
 } I2CSlaveClass;
 
-struct I2CSlave
-{
+struct I2CSlave {
     DeviceState qdev;
 
     /* Remaining fields for internal use by the I2C code.  */
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 59068f157e..9a54b61c1d 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -19,8 +19,7 @@ struct I2CNode {
 
 #define I2C_BROADCAST 0x00
 
-struct I2CBus
-{
+struct I2CBus {
     BusState qbus;
     QLIST_HEAD(, I2CNode) current_devs;
     uint8_t saved_address;
-- 
2.16.2
