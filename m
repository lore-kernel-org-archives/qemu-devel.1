Received: from eggs.gnu.org ([2001:4830:134:3::10]:60792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLtB-0002M1-G0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLtA-0001ls-O6
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:10:02 -0300
Message-Id: <20170718061005.29518-27-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 26/29] tests/tcg: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/tcg/alpha/test-cond.c | 2 +-
 tests/tcg/alpha/test-ovf.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/alpha/test-cond.c b/tests/tcg/alpha/test-cond.c
index 74adffaa69..e5596f10b8 100644
--- a/tests/tcg/alpha/test-cond.c
+++ b/tests/tcg/alpha/test-cond.c
@@ -77,7 +77,7 @@ int main (void)
 {
   int i;
 
-  for (i = 0; i < sizeof (vectors)/sizeof(vectors[0]); i++)
+  for (i = 0; i < ARRAY_SIZE(vectors); i++)
     if ((*vectors[i].func)(vectors[i].v) != vectors[i].r) {
       write(1, "Failed\n", 7);
       return 1;
diff --git a/tests/tcg/alpha/test-ovf.c b/tests/tcg/alpha/test-ovf.c
index 01c80e7525..43fc6ebb2e 100644
--- a/tests/tcg/alpha/test-ovf.c
+++ b/tests/tcg/alpha/test-ovf.c
@@ -20,7 +20,7 @@ int main (void)
 {
   int i;
 
-  for (i = 0; i < sizeof (vectors)/sizeof(vectors[0]); i++)
+  for (i = 0; i < ARRAY_SIZE(vectors); i++)
     if ((*vectors[i].func)(vectors[i].a, vectors[i].b) != vectors[i].r) {
       write(1, "Failed\n", 7);
     }
-- 
2.13.2
