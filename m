Received: from eggs.gnu.org ([2001:4830:134:3::10]:51312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWR-0004Yi-Mr
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWQ-0007XY-TB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWQ-0007Ts-MK
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:46 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWP-0007aE-4c
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:45 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:02 +0000
Message-Id: <1513188761-20784-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/43] m25p80: Add support for n25q512a11 and
 n25q512a13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Francisco Iglesias <frasse.iglesias@gmail.com>

Add support for Micron (Numonyx) n25q512a11 and n25q512a13 flashes.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20171126231634.9531-5-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 35efdf0..ea14216 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -240,6 +240,8 @@ static const FlashPartInfo known_devices[] = {
     { INFO("n25q128a13",  0x20ba18,      0,  64 << 10, 256, ER_4K) },
     { INFO("n25q256a11",  0x20bb19,      0,  64 << 10, 512, ER_4K) },
     { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K) },
+    { INFO("n25q512a11",  0x20bb20,      0,  64 << 10, 1024, ER_4K) },
+    { INFO("n25q512a13",  0x20ba20,      0,  64 << 10, 1024, ER_4K) },
     { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
     { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
     { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
-- 
2.7.4
