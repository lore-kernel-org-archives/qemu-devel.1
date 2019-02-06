Received: from eggs.gnu.org ([209.51.188.92]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grUmq-0002ja-GO
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grUmo-00046R-HP
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:16 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41962
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1grUmm-00041F-Ha
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:12 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  6 Feb 2019 21:30:41 +0000
Message-Id: <20190206213042.12537-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
References: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 2/3] sun4u: add power_mem_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Prasad J Pandit <pjp@fedoraproject.org>

Define skeleton 'power_mem_read' routine. Avoid NULL dereference.

Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 37ecc14c6d..518d695de3 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -214,6 +214,11 @@ typedef struct PowerDevice {
 } PowerDevice;
 
 /* Power */
+static uint64_t power_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
 static void power_mem_write(void *opaque, hwaddr addr,
                             uint64_t val, unsigned size)
 {
@@ -224,6 +229,7 @@ static void power_mem_write(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps power_mem_ops = {
+    .read = power_mem_read,
     .write = power_mem_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
-- 
2.11.0
