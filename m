Received: from eggs.gnu.org ([2001:4830:134:3::10]:60458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQf-0007sV-Bp
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQc-00035G-Tv
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQc-00033J-H2
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:46 -0500
Date: Mon, 5 Nov 2018 13:16:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-21-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 20/33] MAINTAINERS: list "tests/acpi-test-data"
 files in ACPI/SMBIOS section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

The "tests/acpi-test-data" files are currently not covered by any section
in MAINTAINERS, and "scripts/checkpatch.pl" complains when new data files
are added.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfabc14b59..c121a99fc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,8 @@ F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
 F: tests/bios-tables-test.c
 F: tests/acpi-utils.[hc]
+F: tests/acpi-test-data/*
+F: tests/acpi-test-data/*/*
 
 ppc4xx
 M: Alexander Graf <agraf@suse.de>
-- 
MST
