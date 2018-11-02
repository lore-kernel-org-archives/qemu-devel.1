Received: from eggs.gnu.org ([2001:4830:134:3::10]:51141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId6F-0002GP-0Z
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gId6C-0004Qv-5k
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:19:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gId6B-0002Zn-Ix
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:19:07 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gId3q-0003ZO-HO
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 17:16:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Nov 2018 17:16:29 +0000
Message-Id: <20181102171638.24069-2-peter.maydell@linaro.org>
In-Reply-To: <20181102171638.24069-1-peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/10] hw/arm/virt: Set VIRT_COMPAT_3_0 compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

We are missing the VIRT_COMPAT_3_0 definition and setting.
Let's add them.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20181024085602.16611-1-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9f677825f9f..a2b8d8f7c2c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1871,6 +1871,9 @@ static void virt_machine_3_1_options(MachineClass *mc)
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
 
+#define VIRT_COMPAT_3_0 \
+    HW_COMPAT_3_0
+
 static void virt_3_0_instance_init(Object *obj)
 {
     virt_3_1_instance_init(obj);
@@ -1879,6 +1882,7 @@ static void virt_3_0_instance_init(Object *obj)
 static void virt_machine_3_0_options(MachineClass *mc)
 {
     virt_machine_3_1_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_0);
 }
 DEFINE_VIRT_MACHINE(3, 0)
 
-- 
2.19.1
