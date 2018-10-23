Received: from eggs.gnu.org ([2001:4830:134:3::10]:51511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JI-0003EZ-8R
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JF-0008DS-0N
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:03 -0400
Received: from [185.30.24.106] (port=13470
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JD-00089H-FR
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:00 -0400
Date: Tue, 23 Oct 2018 19:41:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-17-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 16/28] MAINTAINERS: list "tests/acpi-test-data"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

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
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40672c4eba..b4d4bd4129 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1113,6 +1113,8 @@ F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
 F: tests/bios-tables-test.c
 F: tests/acpi-utils.[hc]
+F: tests/acpi-test-data/*
+F: tests/acpi-test-data/*/*
 
 ppc4xx
 M: Alexander Graf <agraf@suse.de>
-- 
MST
