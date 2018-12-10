Received: from eggs.gnu.org ([2001:4830:134:3::10]:59214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWQAl-0001Wl-PP
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWQAj-0006NT-Ld
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWQAj-0006KR-BU
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 13:20:49 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 10 Dec 2018 19:10:07 +0100
Message-Id: <1544465415-207855-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
References: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] tests: acpi: remove not used
 ACPI_READ_GENERIC_ADDRESS macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/acpi-utils.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 4f4899d..c8844a2 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -70,14 +70,6 @@ typedef struct {
     g_assert_cmpstr(ACPI_ASSERT_CMP_str, ==, expected); \
 } while (0)
 
-#define ACPI_READ_GENERIC_ADDRESS(field, addr)       \
-    do {                                             \
-        ACPI_READ_FIELD((field).space_id, addr);     \
-        ACPI_READ_FIELD((field).bit_width, addr);    \
-        ACPI_READ_FIELD((field).bit_offset, addr);   \
-        ACPI_READ_FIELD((field).access_width, addr); \
-        ACPI_READ_FIELD((field).address, addr);      \
-    } while (0)
 
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
-- 
2.7.4
