Received: from eggs.gnu.org ([2001:4830:134:3::10]:47952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi5s-0002GF-Jc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi5r-0000dn-Qh
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:29:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gWi5r-0000dP-Ji
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:28:59 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 11 Dec 2018 18:56:39 +0530
Message-Id: <20181211132642.3027-3-ppandit@redhat.com>
In-Reply-To: <20181211132642.3027-1-ppandit@redhat.com>
References: <20181211132642.3027-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] pvrdma: add uar_read routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Define skeleton 'uar_read' routine. Avoid NULL dereference.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/vmw/pvrdma_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index ca5fa8d981..a6211d416d 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -455,6 +455,11 @@ static const MemoryRegionOps regs_ops =3D {
     },
 };
=20
+static uint64_t uar_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
 static void uar_write(void *opaque, hwaddr addr, uint64_t val, unsigned =
size)
 {
     PVRDMADev *dev =3D opaque;
@@ -496,6 +501,7 @@ static void uar_write(void *opaque, hwaddr addr, uint=
64_t val, unsigned size)
 }
=20
 static const MemoryRegionOps uar_ops =3D {
+    .read =3D uar_read,
     .write =3D uar_write,
     .endianness =3D DEVICE_LITTLE_ENDIAN,
     .impl =3D {
--=20
2.19.2
