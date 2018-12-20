Received: from eggs.gnu.org ([2001:4830:134:3::10]:58966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Ct-0003jR-Gz
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Cs-0006y3-SY
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:38:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3Cr-0006lF-Es
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:38:02 -0500
Date: Thu, 20 Dec 2018 13:37:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-6-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 05/44] tests: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The "hw/smbios/smbios.h" include is not used, remove it.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index 6dc8ca1a8c..7b444a7453 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 #include "qemu-common.h"
-#include "hw/smbios/smbios.h"
 #include "qemu/bitmap.h"
 #include "acpi-utils.h"
 #include "boot-sector.h"
--=20
MST
