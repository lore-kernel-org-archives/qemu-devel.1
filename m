Received: from eggs.gnu.org ([209.51.188.92]:41398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB458-0001sK-6C
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB456-0003mQ-Rb
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB456-0003fW-E9
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1qBG062115
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:49 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s2k8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:48 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:47 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:41 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-68-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 67/97] i2c: Move typedef of
 bitbang_i2c_interface to i2c.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>

From: BALATON Zoltan <balaton@eik.bme.hu>

Clang 3.4 considers duplicate typedef in ppc4xx_i2c.h and
bitbang_i2c.h an error even if they are identical. Move it to a common
place to allow building with this clang version.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 2b4c1125ac3db2734222ff43c25388a16aca4a99)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
=20
 #include "hw/i2c/i2c.h"
=20
-typedef struct bitbang_i2c_interface bitbang_i2c_interface;
-
 #define BITBANG_I2C_SDA 0
 #define BITBANG_I2C_SCL 1
=20
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 5dc166158b..cf4c45a98f 100644
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
index 0891a9c948..b3450bacf7 100644
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
2.17.1
