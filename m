Received: from eggs.gnu.org ([2001:4830:134:3::10]:57144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLkO-0003G4-Gb
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLkN-0004LL-M4
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:12:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:38 -0300
Message-Id: <20170718061005.29518-3-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/29] pci: remove superfluous parenthesis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/pci-testdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 7d5990213e..b928ce7e84 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -63,8 +63,8 @@ static const char *iotest_type[] = {
 
 #define IOTEST_TEST(i) (iotest_test[((i) % ARRAY_SIZE(iotest_test))])
 #define IOTEST_TYPE(i) (iotest_type[((i) / ARRAY_SIZE(iotest_test))])
-#define IOTEST_MAX_TEST (ARRAY_SIZE(iotest_test))
-#define IOTEST_MAX_TYPE (ARRAY_SIZE(iotest_type))
+#define IOTEST_MAX_TEST ARRAY_SIZE(iotest_test)
+#define IOTEST_MAX_TYPE ARRAY_SIZE(iotest_type)
 #define IOTEST_MAX (IOTEST_MAX_TEST * IOTEST_MAX_TYPE)
 
 enum {
-- 
2.13.2
