Received: from eggs.gnu.org ([2001:4830:134:3::10]:53927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccFqY-0007Gu-UW
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccFqV-0002Q7-QI
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:23:02 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 10 Feb 2017 19:22:57 +0100
Message-Id: <1486750977-15211-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/prom-env: Enable the test for the sun4u
 machine, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-trivial@nongnu.org

The 32-bit TCG bug has been fixed a while ago, so we can enable
this test for sparc64 now, too. Unfortunately, OpenBIOS does not
work with the sun4v machine anymore (it needs to catch up with the
improved emulation), so we can only enable this test for the sun4u
machine right now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 3 +--
 tests/prom-env-test.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 634394a..af99696 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -304,8 +304,7 @@ check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
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
1.8.3.1
