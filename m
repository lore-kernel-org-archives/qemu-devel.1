Received: from eggs.gnu.org ([2001:4830:134:3::10]:42534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOR-0007Y2-FZ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmON-00070x-4X
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:27 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:32 +0100
Message-Id: <20181211180352.19644-11-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/30] MAINTAINERS: Fix ACPI tests data files
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Missed while moving those files in 438c78dab75.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20181125205000.10324-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ef20d359..59233c2139 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1252,8 +1252,7 @@ F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
 F: tests/bios-tables-test.c
 F: tests/acpi-utils.[hc]
-F: tests/acpi-test-data/*
-F: tests/acpi-test-data/*/*
+F: tests/data/acpi/
 
 ppc4xx
 M: David Gibson <david@gibson.dropbear.id.au>
-- 
2.19.2
