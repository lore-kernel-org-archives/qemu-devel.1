Received: from eggs.gnu.org ([2001:4830:134:3::10]:34756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBf-0008LY-4Q
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBe-0004We-Bn
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:23 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBe-0004W8-4j
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:30:22 -0500
Received: by mail-qt0-x242.google.com with SMTP id g14so10490995qti.2
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:30:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:55 -0300
Message-Id: <20180215042900.16078-26-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/30] hw/scsi: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/scsi/scsi-disk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 49d2559d93..bfdb34a71c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -44,13 +44,13 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #include <scsi/sg.h>
 #endif
 
-#define SCSI_WRITE_SAME_MAX         524288
-#define SCSI_DMA_BUF_SIZE           131072
+#define SCSI_WRITE_SAME_MAX         (512 * K_BYTE)
+#define SCSI_DMA_BUF_SIZE           (128 * K_BYTE)
 #define SCSI_MAX_INQUIRY_LEN        256
 #define SCSI_MAX_MODE_LEN           256
 
-#define DEFAULT_DISCARD_GRANULARITY 4096
-#define DEFAULT_MAX_UNMAP_SIZE      (1 << 30)   /* 1 GB */
+#define DEFAULT_DISCARD_GRANULARITY (4 * K_BYTE)
+#define DEFAULT_MAX_UNMAP_SIZE      (1 * G_BYTE)
 #define DEFAULT_MAX_IO_SIZE         INT_MAX     /* 2 GB - 1 block */
 
 #define TYPE_SCSI_DISK_BASE         "scsi-disk-base"
-- 
2.16.1
