Received: from eggs.gnu.org ([2001:4830:134:3::10]:50616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbl8-00058D-15
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbl4-0006Fs-4o
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:54 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbl4-0006FR-0H
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:50 -0500
Received: by mail-qk0-x241.google.com with SMTP id o126so15226693qke.12
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:02:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 15:02:28 -0300
Message-Id: <20180108180231.21122-5-f4bug@amsat.org>
In-Reply-To: <20180108180231.21122-1-f4bug@amsat.org>
References: <20180108180231.21122-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/7] net/rocker: move struct rocker_desc to C
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

this is the only user.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/rocker/rocker_hw.h   | 13 -------------
 hw/net/rocker/rocker_desc.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/net/rocker/rocker_hw.h b/hw/net/rocker/rocker_hw.h
index 8b4ce250d5..daaaf4080f 100644
--- a/hw/net/rocker/rocker_hw.h
+++ b/hw/net/rocker/rocker_hw.h
@@ -119,19 +119,6 @@ enum {
  */
 #define ROCKER_RING_INDEX(reg) ((reg >> 5) & 0x7F)
 
-/*
- * Rocker DMA Descriptor
- */
-
-typedef struct rocker_desc {
-    __le64 buf_addr;
-    uint64_t cookie;
-    __le16 buf_size;
-    __le16 tlv_size;
-    __le16 rsvd[5];   /* pad to 32 bytes */
-    __le16 comp_err;
-} QEMU_PACKED QEMU_ALIGNED(8) RockerDesc;
-
 /*
  * Rocker TLV type fields
  */
diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
index b009da4f89..2f2de837f8 100644
--- a/hw/net/rocker/rocker_desc.c
+++ b/hw/net/rocker/rocker_desc.c
@@ -23,6 +23,19 @@
 #include "rocker_hw.h"
 #include "rocker_desc.h"
 
+/*
+ * Rocker DMA Descriptor
+ */
+
+typedef struct rocker_desc {
+    __le64 buf_addr;
+    uint64_t cookie;
+    __le16 buf_size;
+    __le16 tlv_size;
+    __le16 rsvd[5];   /* pad to 32 bytes */
+    __le16 comp_err;
+} QEMU_PACKED QEMU_ALIGNED(8) RockerDesc;
+
 struct desc_ring {
     hwaddr base_addr;
     uint32_t size;
-- 
2.15.1
