Received: from eggs.gnu.org ([2001:4830:134:3::10]:54664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcoq-0006JN-Ug
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus.walleij@linaro.org>) id 1eqcop-0004AI-RU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:12 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:46635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
	id 1eqcop-00049V-Jx
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:49:11 -0500
Received: by mail-lf0-x241.google.com with SMTP id r80so26801411lfe.13
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:49:11 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Feb 2018 11:48:59 +0100
Message-Id: <20180227104903.21353-2-linus.walleij@linaro.org>
In-Reply-To: <20180227104903.21353-1-linus.walleij@linaro.org>
References: <20180227104903.21353-1-linus.walleij@linaro.org>
Subject: [Qemu-devel] [PATCH 1/5] i2c: Fix some brace style issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Corey Minyard <cminyard@mvista.com>, Linus Walleij <linus.walleij@linaro.org>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 hw/i2c/core.c        | 3 +--
 include/hw/i2c/i2c.h | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 59068f157eb5..9a54b61c1dbd 100644
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
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 24e95d015589..8fd449f645f0 100644
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
-- 
2.14.3
