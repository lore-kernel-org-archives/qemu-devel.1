Received: from eggs.gnu.org ([2001:4830:134:3::10]:60735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLt5-0002Fd-Ip
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLt4-0001dk-Rb
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:10:00 -0300
Message-Id: <20170718061005.29518-25-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 24/29] tests/acpi: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acpi-utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index f8d87236c6..91ee0a273d 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -58,7 +58,7 @@ typedef struct {
     } while (0);
 
 #define ACPI_READ_ARRAY(arr, addr)                               \
-    ACPI_READ_ARRAY_PTR(arr, sizeof(arr) / sizeof(arr[0]), addr)
+    ACPI_READ_ARRAY_PTR(arr, ARRAY_SIZE(arr), addr)
 
 #define ACPI_READ_TABLE_HEADER(table, addr)                      \
     do {                                                         \
-- 
2.13.2
