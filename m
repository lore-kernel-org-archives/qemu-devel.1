Received: from eggs.gnu.org ([2001:4830:134:3::10]:51124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveb-0000fj-Pp
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveY-0000Wx-JL
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:22:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYveY-0000VW-8X
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 781A3A7FE2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:21:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Dec 2018 17:21:29 +0100
Message-Id: <1545063690-10116-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1545063690-10116-1-git-send-email-thuth@redhat.com>
References: <1545063690-10116-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/13] tests: acpi: remove not used
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[thuth: Fixed conflicts with additional "qts" parameter]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/acpi-utils.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index a06a4ed..791bd54 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -70,14 +70,6 @@ typedef struct {
     g_assert_cmpstr(ACPI_ASSERT_CMP_str, =3D=3D, expected); \
 } while (0)
=20
-#define ACPI_READ_GENERIC_ADDRESS(qts, field, addr)       \
-    do {                                                  \
-        ACPI_READ_FIELD(qts, (field).space_id, addr);     \
-        ACPI_READ_FIELD(qts, (field).bit_width, addr);    \
-        ACPI_READ_FIELD(qts, (field).bit_offset, addr);   \
-        ACPI_READ_FIELD(qts, (field).access_width, addr); \
-        ACPI_READ_FIELD(qts, (field).address, addr);      \
-    } while (0)
=20
=20
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
--=20
1.8.3.1
