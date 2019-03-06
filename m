Received: from eggs.gnu.org ([209.51.188.92]:35890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UQ6-0005jj-RX
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UQ0-0002gA-9s
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:09:06 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Mar 2019 12:07:02 +0100
Message-Id: <20190306110711.309-2-laurent@vivier.eu>
In-Reply-To: <20190306110711.309-1-laurent@vivier.eu>
References: <20190306110711.309-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/10] tests: Remove (mostly) useless
 architecture checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-s390x@nongnu.org, Corey Minyard <minyard@acm.org>, Pierre Morel <pmorel@linux.ibm.com>, Corey Minyard <cminyard@mvista.com>

From: Thomas Huth <thuth@redhat.com>

These checks at the beginning of some of the tests are mostly useless:
We only run the tests on x86 anyway, and g_test_message() does not
print anything unless you call g_test_init() first.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-Id: <1551456970-463-1-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/fdc-test.c      | 7 -------
 tests/ide-test.c      | 7 -------
 tests/ipmi-bt-test.c  | 7 -------
 tests/ipmi-kcs-test.c | 7 -------
 4 files changed, 28 deletions(-)

diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 88f1abfa10e2..31cd3295c102 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -548,16 +548,9 @@ static void fuzz_registers(void)
 
 int main(int argc, char **argv)
 {
-    const char *arch = qtest_get_arch();
     int fd;
     int ret;
 
-    /* Check architecture */
-    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
-        g_test_message("Skipping test for non-x86\n");
-        return 0;
-    }
-
     /* Create a temporary raw image */
     fd = mkstemp(test_image);
     g_assert(fd >= 0);
diff --git a/tests/ide-test.c b/tests/ide-test.c
index f0280e636b5d..300d64e77ddf 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -1009,16 +1009,9 @@ static void test_cdrom_dma(void)
 
 int main(int argc, char **argv)
 {
-    const char *arch = qtest_get_arch();
     int fd;
     int ret;
 
-    /* Check architecture */
-    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
-        g_test_message("Skipping test for non-x86\n");
-        return 0;
-    }
-
     /* Create temporary blkdebug instructions */
     fd = mkstemp(debug_path);
     g_assert(fd >= 0);
diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index f4a81b526505..fc4c83b5db7c 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
@@ -400,15 +400,8 @@ static void open_socket(void)
 
 int main(int argc, char **argv)
 {
-    const char *arch = qtest_get_arch();
     int ret;
 
-    /* Check architecture */
-    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
-        g_test_message("Skipping test for non-x86\n");
-        return 0;
-    }
-
     open_socket();
 
     /* Run the tests */
diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
index 178ffc179734..a2354c10c7fe 100644
--- a/tests/ipmi-kcs-test.c
+++ b/tests/ipmi-kcs-test.c
@@ -263,16 +263,9 @@ static void test_enable_irq(void)
 
 int main(int argc, char **argv)
 {
-    const char *arch = qtest_get_arch();
     char *cmdline;
     int ret;
 
-    /* Check architecture */
-    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
-        g_test_message("Skipping test for non-x86\n");
-        return 0;
-    }
-
     /* Run the tests */
     g_test_init(&argc, &argv, NULL);
 
-- 
2.20.1
