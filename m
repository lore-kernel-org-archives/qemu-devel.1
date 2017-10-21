Received: from eggs.gnu.org ([2001:4830:134:3::10]:60023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <francisco.iglesias@feimtech.se>) id 1e5wxv-0003jp-9h
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <francisco.iglesias@feimtech.se>) id 1e5wxu-0005CS-JE
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:49:39 -0400
Received: from ec2-52-28-205-119.eu-central-1.compute.amazonaws.com
	([52.28.205.119]:57302
	helo=ip-172-31-28-221.eu-central-1.compute.internal)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <francisco.iglesias@feimtech.se>)
	id 1e5wxu-00057W-DB
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 12:49:38 -0400
From: Francisco Iglesias <francisco.iglesias@feimtech.se>
Date: Sat, 21 Oct 2017 16:35:13 +0200
Message-Id: <20171021143521.31685-5-francisco.iglesias@feimtech.se>
In-Reply-To: <20171021143521.31685-1-francisco.iglesias@feimtech.se>
References: <20171021143521.31685-1-francisco.iglesias@feimtech.se>
Subject: [Qemu-devel] [PATCH 04/12] m25p80: Add support for n25q512a11 and
 n25q512a13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, francisco.iglesias@feimtech.se
Cc: edgari@xilinx.com, alistai@xilinx.com

Add support for Micron (Numonyx) n25q512a11 and n25q512a13 flashes.

Signed-off-by: Francisco Iglesias <francisco.iglesias@feimtech.se>
---
 hw/block/m25p80.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 3d2975c..7f3fcc4 100644
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
