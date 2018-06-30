Received: from eggs.gnu.org ([2001:4830:134:3::10]:37843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ964-00045l-Ad
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ95z-0001r0-BN
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:00 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:56114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ95z-0001pL-4E
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:10:55 -0400
Received: by mail-wm0-x22f.google.com with SMTP id v16-v6so4105790wmv.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:10:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:04 +0200
Message-Id: <20180630061040.6018-12-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/47] hw/scsi: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-10-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 55a34b3..32f3f96 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -29,6 +29,7 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #endif
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/scsi/scsi.h"
@@ -44,13 +45,13 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #include <scsi/sg.h>
 #endif
 
-#define SCSI_WRITE_SAME_MAX         524288
-#define SCSI_DMA_BUF_SIZE           131072
+#define SCSI_WRITE_SAME_MAX         (512 * KiB)
+#define SCSI_DMA_BUF_SIZE           (128 * KiB)
 #define SCSI_MAX_INQUIRY_LEN        256
 #define SCSI_MAX_MODE_LEN           256
 
-#define DEFAULT_DISCARD_GRANULARITY 4096
-#define DEFAULT_MAX_UNMAP_SIZE      (1 << 30)   /* 1 GB */
+#define DEFAULT_DISCARD_GRANULARITY (4 * KiB)
+#define DEFAULT_MAX_UNMAP_SIZE      (1 * GiB)
 #define DEFAULT_MAX_IO_SIZE         INT_MAX     /* 2 GB - 1 block */
 
 #define TYPE_SCSI_DISK_BASE         "scsi-disk-base"
-- 
1.8.3.1
