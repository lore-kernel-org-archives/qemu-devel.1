Received: from eggs.gnu.org ([2001:4830:134:3::10]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHy5-0004ri-Aj
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZHxz-0001aZ-Vx
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:11:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZHxz-0001aD-Ls
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:11:31 -0500
Date: Tue, 18 Dec 2018 11:11:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218161008.3882-6-mst@redhat.com>
References: <20181218161008.3882-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/30] tests: Remove unused include
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
index 41dc1ea9b4..297af55d39 100644
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
