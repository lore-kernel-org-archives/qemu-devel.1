Received: from eggs.gnu.org ([2001:4830:134:3::10]:41709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqhOD-0000wb-NT
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqhOC-0006zM-Uw
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:14:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqhOC-0006rY-LJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:14:16 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 17:14:04 +0100
Message-Id: <20180817161404.9420-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] tests/boot-serial-test: Bump timeout to 6
 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On a SPARC host that I'm using as a build test machine, the
boot-serial-test for the SPARC guest machines takes about 65
seconds to execute. This means that it hits the current
60 second timer on these tests. Push the timeout up so
that it doesn't trigger spuriously on slow hosts like this one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/boot-serial-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 1355df924dd..fca5f2f5da9 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -116,8 +116,8 @@ static bool check_guest_output(const testdef_t *test, int fd)
     int i, nbr = 0, pos = 0, ccnt;
     char ch;
 
-    /* Poll serial output... Wait at most 60 seconds */
-    for (i = 0; i < 6000; ++i) {
+    /* Poll serial output... Wait at most 360 seconds */
+    for (i = 0; i < 36000; ++i) {
         ccnt = 0;
         while (ccnt++ < 512 && (nbr = read(fd, &ch, 1)) == 1) {
             if (ch == test->expect[pos]) {
-- 
2.18.0
