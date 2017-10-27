Received: from eggs.gnu.org ([2001:4830:134:3::10]:50701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7xd2-0005YJ-P8
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e7xd2-0007oN-1s
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:24 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:46272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e7xd1-0007mL-Qx
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 01:56:23 -0400
Received: by mail-lf0-x242.google.com with SMTP id g70so6144019lfl.3
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 22:56:23 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Fri, 27 Oct 2017 07:56:03 +0200
Message-Id: <20171027055612.2488-5-frasse.iglesias@gmail.com>
In-Reply-To: <20171027055612.2488-1-frasse.iglesias@gmail.com>
References: <20171027055612.2488-1-frasse.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 04/13] m25p80: Add support for n25q512a11
 and n25q512a13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se, mar.krzeminski@gmail.com

Add support for Micron (Numonyx) n25q512a11 and n25q512a13 flashes.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
---
 hw/block/m25p80.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index cf39e36..054dc6f 100644
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
2.9.3
