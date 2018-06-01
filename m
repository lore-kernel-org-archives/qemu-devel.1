Received: from eggs.gnu.org ([2001:4830:134:3::10]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtX-0002NX-A7
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtW-0007OO-JA
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtW-0007Nk-Fu
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:14 -0400
Date: Fri, 1 Jun 2018 19:27:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-21-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/31] vhost-scsi: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

No reason for vhost-scsi to pull in migration headers directly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/scsi/vhost-scsi-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 77e9897244..e2a5828af1 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -17,7 +17,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "migration/migration.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-scsi-common.h"
 #include "hw/virtio/virtio-scsi.h"
--=20
MST
