Received: from eggs.gnu.org ([209.51.188.92]:60066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvn98-0006dh-NW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvn93-0004Fr-16
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:55:58 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:43702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gvn8x-00047A-EX
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:55:53 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 18 Feb 2019 18:55:28 +0100
Message-Id: <20190218175529.11237-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] lsi: 810/895A are always little endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Sven Schnelle <svens@stackframe.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/scsi/lsi53c895a.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index bcff859bac..c493e3c4c7 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2061,14 +2061,13 @@ static uint64_t lsi_mmio_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
     LSIState *s = opaque;
-
     return lsi_reg_readb(s, addr & 0xff);
 }
 
 static const MemoryRegionOps lsi_mmio_ops = {
     .read = lsi_mmio_read,
     .write = lsi_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -2107,7 +2106,7 @@ static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps lsi_ram_ops = {
     .read = lsi_ram_read,
     .write = lsi_ram_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint64_t lsi_io_read(void *opaque, hwaddr addr,
@@ -2127,7 +2126,7 @@ static void lsi_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps lsi_io_ops = {
     .read = lsi_io_read,
     .write = lsi_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
-- 
2.20.1
