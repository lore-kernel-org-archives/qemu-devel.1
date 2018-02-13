Received: from eggs.gnu.org ([2001:4830:134:3::10]:42209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI5-0004ia-4A
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHv-0007rY-CM
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:29 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHv-0007r7-5y
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:19 -0500
Received: by mail-wr0-x242.google.com with SMTP id v65so11573697wrc.11
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:45 +0100
Message-Id: <1518523252-49106-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 41/48] sdhci: check Spec v3 capabilities qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20180208164818.7961-29-f4bug@amsat.org>
---
 tests/Makefile.include |  1 +
 tests/sdhci-test.c     | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 52be9b3..278c13a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -371,6 +371,7 @@ check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
 
 check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 
diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 18e8965..08bc5cd 100644
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
-- 
1.8.3.1
