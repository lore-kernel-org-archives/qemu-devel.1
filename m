Received: from eggs.gnu.org ([209.51.188.92]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODm-0007J3-PE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODk-0003fI-Ns
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODh-0003Zq-3L
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:56:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id e74so5328380wmg.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:56:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:31 +0100
Message-Id: <1552323335-46779-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 27/31] lsi: 810/895A are always little endian
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190218175529.11237-1-svens@stackframe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index bf6b6a5..da7239d 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2084,14 +2084,13 @@ static uint64_t lsi_mmio_read(void *opaque, hwaddr addr,
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
@@ -2115,7 +2114,7 @@ static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps lsi_ram_ops = {
     .read = lsi_ram_read,
     .write = lsi_ram_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint64_t lsi_io_read(void *opaque, hwaddr addr,
@@ -2135,7 +2134,7 @@ static void lsi_io_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps lsi_io_ops = {
     .read = lsi_io_read,
     .write = lsi_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
-- 
1.8.3.1
