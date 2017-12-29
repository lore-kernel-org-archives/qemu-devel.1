Received: from eggs.gnu.org ([2001:4830:134:3::10]:57798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyof-0004CJ-Nn
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyof-0007sS-25
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:33 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:43340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyoe-0007rw-V7
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:33 -0500
Received: by mail-qk0-x244.google.com with SMTP id j137so35736703qke.10
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:51:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:27 -0300
Message-Id: <20171229174933.1781-37-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 36/42] sdhci: check Spec v3 capabilities
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Clement Deschamps <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/sdhci-test.c     | 12 ++++++++++++
 tests/Makefile.include |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 200d7bcee2..f7487808af 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -29,9 +29,21 @@ static const struct sdhci_t {
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
 
 static uint32_t sdhci_readl(uintptr_t base, uint32_t reg_addr)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2d7058ca4c..0cf327425e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -360,6 +360,7 @@ gcov-files-arm-y += hw/timer/arm_mptimer.c
 check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
-- 
2.15.1
