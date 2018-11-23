Received: from eggs.gnu.org ([2001:4830:134:3::10]:45772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQ4UT-0005CB-Q3
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQ4UQ-0004mO-LP
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:58:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQ4UQ-0004jY-GM
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 00:58:54 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 23 Nov 2018 06:58:31 +0100
Message-Id: <20181123055831.28003-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Fix ACPI tests data files path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Missed while moving those files in 438c78dab75.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1032406c56..6c4f25fb05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1216,8 +1216,7 @@ F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
 F: tests/bios-tables-test.c
 F: tests/acpi-utils.[hc]
-F: tests/acpi-test-data/*
-F: tests/acpi-test-data/*/*
+F: tests/data/acpi/
=20
 ppc4xx
 M: David Gibson <david@gibson.dropbear.id.au>
--=20
2.17.2
