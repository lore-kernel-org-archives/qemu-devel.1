Received: from eggs.gnu.org ([2001:4830:134:3::10]:60279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edovf-00012N-82
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edove-000503-7R
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:19 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edove-0004zk-35
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:18 -0500
Received: by mail-qt0-x242.google.com with SMTP id s39so26394403qth.7
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 19:07:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:06:28 -0300
Message-Id: <20180123030630.26613-13-f4bug@amsat.org>
In-Reply-To: <20180123030630.26613-1-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 12/14] sdhci: check Spec v3 capabilities
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
index aae2cfc1b5..56eefdafd8 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -42,10 +42,22 @@ static const struct sdhci_t {
     { "arm",    "smdkc210",
         {0x12510000, 2, 0,  {1, 0x5e80080} } },
 
+    /* i.MX 6 */
+    { "arm",    "sabrelite",
+        {0x02190000, 3, 0,  {1, 0x057834b4} } },
+
+    /* BCM2835 */
+    { "arm",    "raspi2",
+        {0x3f300000, 3, 52, {0, 0x052134b4} } },
+
     /* Zynq-7000 */
     { "arm",    "xilinx-zynq-a9",   /* Datasheet: UG585 (v1.12.1) */
         {0xe0100000, 2, 0,  {1, 0x69ec0080} } },
 
+    /* ZynqMP */
+    { "aarch64", "xlnx-zcu102",     /* Datasheet: UG1085 (v1.7) */
+        {0xff160000, 3, 0,  {1, 0x280737ec6481} } },
+
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
