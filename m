Received: from eggs.gnu.org ([2001:4830:134:3::10]:49715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cHOuq-0007B7-Lj
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cHOun-0003Jr-4u
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40461
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cHOum-0003Jb-UJ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:13 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF5mf2p142376
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 00:49:12 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm41tp5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 00:49:11 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Thu, 15 Dec 2016 15:49:07 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Thu, 15 Dec 2016 16:48:09 +1100
In-Reply-To: <20161215054812.12602-1-alastair@au1.ibm.com>
References: <20161215054812.12602-1-alastair@au1.ibm.com>
Message-Id: <20161215054812.12602-6-alastair@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v4 5/8] hw/i2c: Tidy up NULL check for i2c
 slave init callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

From: Alastair D'Silva <alastair@d-silva.org>

Remove unnecessary syntax

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 hw/i2c/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index ae3ca94..e40781e 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -262,9 +262,9 @@ static int i2c_slave_qdev_init(DeviceState *dev)
 
     if (sc->init) {
         return sc->init(s);
-    } else {
-        return 0;
     }
+
+    return 0;
 }
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
-- 
2.9.3
