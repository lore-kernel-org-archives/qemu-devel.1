Received: from eggs.gnu.org ([2001:4830:134:3::10]:58637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0aj-0008CW-E7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0ai-00049s-HG
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:14:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX0ai-00049S-B7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:14:04 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Dec 2018 10:13:52 +0100
Message-Id: <1544606032-16924-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1544606032-16924-1-git-send-email-thuth@redhat.com>
References: <1544606032-16924-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/8] i2c: Move typedef of bitbang_i2c_interface
 to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: BALATON Zoltan <balaton@eik.bme.hu>

Clang 3.4 considers duplicate typedef in ppc4xx_i2c.h and
bitbang_i2c.h an error even if they are identical. Move it to a common
place to allow building with this clang version.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i2c/bitbang_i2c.h        | 2 --
 include/hw/i2c/i2c.h        | 2 ++
 include/hw/i2c/ppc4xx_i2c.h | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/i2c/bitbang_i2c.h b/hw/i2c/bitbang_i2c.h
index 3a7126d..9443021 100644
--- a/hw/i2c/bitbang_i2c.h
+++ b/hw/i2c/bitbang_i2c.h
@@ -3,8 +3,6 @@
=20
 #include "hw/i2c/i2c.h"
=20
-typedef struct bitbang_i2c_interface bitbang_i2c_interface;
-
 #define BITBANG_I2C_SDA 0
 #define BITBANG_I2C_SCL 1
=20
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 5dc1661..cf4c45a 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -82,6 +82,8 @@ int i2c_recv(I2CBus *bus);
=20
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r);
=20
+typedef struct bitbang_i2c_interface bitbang_i2c_interface;
+
 /* lm832x.c */
 void lm832x_key_event(DeviceState *dev, int key, int state);
=20
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 0891a9c..b3450ba 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -31,9 +31,6 @@
 #include "hw/sysbus.h"
 #include "hw/i2c/i2c.h"
=20
-/* from hw/i2c/bitbang_i2c.h */
-typedef struct bitbang_i2c_interface bitbang_i2c_interface;
-
 #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
 #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_=
I2C)
=20
--=20
1.8.3.1
