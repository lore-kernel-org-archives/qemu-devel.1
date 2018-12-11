Received: from eggs.gnu.org ([2001:4830:134:3::10]:38797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkzx-000349-MK
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWkzt-0006lr-M9
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:35:05 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 11 Dec 2018 17:34:04 +0100
Message-Id: <20181211163406.3322-3-philmd@redhat.com>
In-Reply-To: <20181211163406.3322-1-philmd@redhat.com>
References: <20181211163406.3322-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/4] hw/smbios: Restrict access to
 "hw/smbios/ipmi.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>

All the consumers of "hw/smbios/ipmi.h" are located in hw/smbios/.
There is no need to have this include publicly exposed,
reduce the visibility by moving it in hw/smbios/.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/smbios/smbios.c                                  | 2 +-
 include/hw/smbios/ipmi.h =3D> hw/smbios/smbios_ipmi.h | 0
 hw/smbios/smbios_type_38-stub.c                     | 2 +-
 hw/smbios/smbios_type_38.c                          | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/hw/smbios/ipmi.h =3D> hw/smbios/smbios_ipmi.h (100%)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 920939454e..30bd4731cf 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -28,7 +28,7 @@
 #include "hw/loader.h"
 #include "exec/cpu-common.h"
 #include "smbios_build.h"
-#include "hw/smbios/ipmi.h"
+#include "smbios_ipmi.h"
=20
 /* legacy structures and constants for <=3D 2.0 machines */
 struct smbios_header {
diff --git a/include/hw/smbios/ipmi.h b/hw/smbios/smbios_ipmi.h
similarity index 100%
rename from include/hw/smbios/ipmi.h
rename to hw/smbios/smbios_ipmi.h
diff --git a/hw/smbios/smbios_type_38-stub.c b/hw/smbios/smbios_type_38-s=
tub.c
index 5b83c9b1f1..fc4516bc8a 100644
--- a/hw/smbios/smbios_type_38-stub.c
+++ b/hw/smbios/smbios_type_38-stub.c
@@ -8,7 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/smbios/ipmi.h"
+#include "smbios_ipmi.h"
=20
 void smbios_build_type_38_table(void)
 {
diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
index 56e8609c00..d84e87d608 100644
--- a/hw/smbios/smbios_type_38.c
+++ b/hw/smbios/smbios_type_38.c
@@ -9,10 +9,10 @@
=20
 #include "qemu/osdep.h"
 #include "hw/ipmi/ipmi.h"
-#include "hw/smbios/ipmi.h"
 #include "hw/smbios/smbios.h"
 #include "qemu/error-report.h"
 #include "smbios_build.h"
+#include "smbios_ipmi.h"
=20
 /* SMBIOS type 38 - IPMI */
 struct smbios_type_38 {
--=20
2.17.2
