Received: from eggs.gnu.org ([2001:4830:134:3::10]:45038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0B-0000cO-EX
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0A-0007bH-P9
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:35 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:40939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0A-0007b0-KN
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:34 -0500
Received: by mail-qt0-x244.google.com with SMTP id s39so16481815qth.7
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:41:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 17:40:51 -0300
Message-Id: <20180118204058.5768-8-f4bug@amsat.org>
In-Reply-To: <20180118204058.5768-1-f4bug@amsat.org>
References: <20180118204058.5768-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 07/14] sdhci: check Spec v3 capabilities
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdhci-test.c     | 12 ++++++++++++
 tests/Makefile.include |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 44ee5651c4..dd01a47839 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -42,9 +42,21 @@ static const struct sdhci_t {
     { "arm",    "smdkc210",
         {0x12510000, 2, 0, {1, 0x5e80080} } },
 
+    /* i.MX 6 */
+    { "arm",    "sabrelite",
+        {0x02190000, 3, 0, {1, 0x057834b4} } },
+
+    /* BCM2835 */
+    { "arm",    "raspi2",
+        {0x3f300000, 3, 52, {0, 0x52034b4} } },
+
     /* Zynq-7000 */
     { "arm",    "xilinx-zynq-a9",
         {0xe0100000, 2, 0, {1, 0x01790080} } },
+
+    /* ZynqMP */
+    { "aarch64", "xlnx-zcu102",
+        {0xff160000, 3, 0, {1, 0x7715e80080} } },
 };
 
 static struct {
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 756725b0f9..74cae947cb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -367,6 +367,7 @@ check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
-- 
2.15.1
