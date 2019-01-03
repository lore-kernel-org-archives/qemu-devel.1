Received: from eggs.gnu.org ([208.118.235.92]:59707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gezTG-0005JO-1m
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gezTB-00079W-Mv
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:39:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gezT7-000754-Qy
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:39:15 -0500
From: P J P <ppandit@redhat.com>
Date: Thu,  3 Jan 2019 15:07:04 +0530
Message-Id: <20190103093704.32635-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] sun4u: add power_mem_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Define skeleton 'power_mem_read' routine. Avoid NULL dereference.

Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/sparc64/sun4u.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index f76b19e4e9..cbdb2bb411 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -214,6 +214,11 @@ typedef struct PowerDevice {
 } PowerDevice;
=20
 /* Power */
+static uint64_t power_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0xffffffff;
+}
+
 static void power_mem_write(void *opaque, hwaddr addr,
                             uint64_t val, unsigned size)
 {
@@ -224,6 +229,7 @@ static void power_mem_write(void *opaque, hwaddr addr=
,
 }
=20
 static const MemoryRegionOps power_mem_ops =3D {
+    .read =3D power_mem_read,
     .write =3D power_mem_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
     .valid =3D {
--=20
2.20.1
