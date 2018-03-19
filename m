Received: from eggs.gnu.org ([2001:4830:134:3::10]:49754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzc1-0002Mw-HZ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzc0-0007iB-MZ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1exzc0-0007gJ-G5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbz-000325-A6
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:34:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:34:10 +0000
Message-Id: <20180319183415.1976-9-peter.maydell@linaro.org>
In-Reply-To: <20180319183415.1976-1-peter.maydell@linaro.org>
References: <20180319183415.1976-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/13] hw/arm/bcm2386: Fix parent type of bcm2386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The TypeInfo and state struct for bcm2386 disagree about what the
parent class is -- the TypeInfo says it's TYPE_SYS_BUS_DEVICE,
but the BCM2386State struct only defines the parent_obj field
as DeviceState. This would have caused problems if anything
actually tried to treat the object as a TYPE_SYS_BUS_DEVICE.
Fix the TypeInfo to use TYPE_DEVICE as the parent, since we don't
need any of the additional functionality TYPE_SYS_BUS_DEVICE
provides.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180313153458.26822-5-peter.maydell@linaro.org
---
 hw/arm/bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 40e8b25a46..9266f27c14 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -165,7 +165,7 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo bcm2836_type_info = {
     .name = TYPE_BCM2836,
-    .parent = TYPE_SYS_BUS_DEVICE,
+    .parent = TYPE_DEVICE,
     .instance_size = sizeof(BCM2836State),
     .instance_init = bcm2836_init,
     .class_init = bcm2836_class_init,
-- 
2.16.2
