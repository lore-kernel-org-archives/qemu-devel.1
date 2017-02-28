Received: from eggs.gnu.org ([2001:4830:134:3::10]:45120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibfq-00079Z-S4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibfn-0005sn-Qb
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:54:14 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:52 +0300
Message-Id: <6b591ad613010f136dec4657f3c8ed6b051802c8.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 09/14] tests/prom-env: Enable the test for the
 sun4u machine, too
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

The 32-bit TCG bug has been fixed a while ago, so we can enable
this test for sparc64 now, too. Unfortunately, OpenBIOS does not
work with the sun4v machine anymore (it needs to catch up with the
improved emulation), so we can only enable this test for the sun4u
machine right now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/Makefile.include | 3 +--
 tests/prom-env-test.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e60bb6c..3310c17 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -308,8 +308,7 @@ check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
 #check-qtest-sparc64-y += tests/m48t59-test$(EXESUF)
 #gcov-files-sparc64-y += hw/timer/m48t59.c
-#Disabled for now, triggers a TCG bug on 32-bit hosts
-#check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
+check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 
 check-qtest-arm-y = tests/tmp105-test$(EXESUF)
 check-qtest-arm-y += tests/ds1338-test$(EXESUF)
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index bd33bc3..eac207b 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -76,7 +76,7 @@ static void add_tests(const char *machines[])
 int main(int argc, char *argv[])
 {
     const char *sparc_machines[] = { "SPARCbook", "Voyager", "SS-20", NULL };
-    const char *sparc64_machines[] = { "sun4u", "sun4v", NULL };
+    const char *sparc64_machines[] = { "sun4u", NULL };
     const char *ppc_machines[] = { "mac99", "g3beige", NULL };
     const char *ppc64_machines[] = { "mac99", "g3beige", "pseries", NULL };
     const char *arch = qtest_get_arch();
-- 
2.1.4
