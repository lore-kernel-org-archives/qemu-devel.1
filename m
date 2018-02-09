Received: from eggs.gnu.org ([2001:4830:134:3::10]:34518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA5n-0002md-As
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA5m-0005sh-G4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:55:59 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekA5m-0005sb-Bk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:55:58 -0500
Received: by mail-qt0-x244.google.com with SMTP id f4so10832325qtj.6
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 06:55:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Feb 2018 11:54:28 -0300
Message-Id: <20180209145430.26007-29-f4bug@amsat.org>
In-Reply-To: <20180209145430.26007-1-f4bug@amsat.org>
References: <20180209145430.26007-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v12 28/30] sdhci: check Spec v3 capabilities
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
---
 tests/sdhci-test.c     | 12 ++++++++++++
 tests/Makefile.include |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 898c43ff4f..39d0f87788 100644
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
 
 typedef struct QSDHCI {
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 52be9b3fa5..278c13aa93 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -371,6 +371,7 @@ check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
-- 
2.16.1
