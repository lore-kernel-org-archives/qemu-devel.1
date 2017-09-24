Received: from eggs.gnu.org ([2001:4830:134:3::10]:57538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbE-0002pO-0N
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbA-00082r-3j
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:47 +0300
Message-Id: <e2a74ec97837bdb45c773ea5e6fcf26db6b0338b.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 29/31] tests/boot-sector: Increase timeout to
 600 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

If QEMU has been compiled with the flags --enable-tcg-interpreter and
--enable-debug, the guest is running incredibly slow. The pxe boot test
can take up to 400 seconds when testing the pseries ppc64 machine. While
we should still look for ways to speed up the test on the pseries machine,
it's better to increase the timeout in this test to 600 seconds anyway to
allow the test to pass successfully now with this unusal configuration
already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/boot-sector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/boot-sector.c b/tests/boot-sector.c
index 9ee85370b0..be29d5bb9b 100644
--- a/tests/boot-sector.c
+++ b/tests/boot-sector.c
@@ -137,9 +137,9 @@ void boot_sector_test(void)
     uint16_t signature;
     int i;
 
-    /* Wait at most 90 seconds */
+    /* Wait at most 600 seconds (test is slow with TCI and --enable-debug) */
 #define TEST_DELAY (1 * G_USEC_PER_SEC / 10)
-#define TEST_CYCLES MAX((90 * G_USEC_PER_SEC / TEST_DELAY), 1)
+#define TEST_CYCLES MAX((600 * G_USEC_PER_SEC / TEST_DELAY), 1)
 
     /* Poll until code has run and modified memory.  Once it has we know BIOS
      * initialization is done.  TODO: check that IP reached the halt
-- 
2.11.0
