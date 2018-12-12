Received: from eggs.gnu.org ([2001:4830:134:3::10]:43978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gX31T-0003hf-LE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gX31S-0004FA-Br
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:49:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gX31S-0004Eh-5l
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:49:50 -0500
From: P J P <ppandit@redhat.com>
Date: Wed, 12 Dec 2018 17:17:26 +0530
Message-Id: <20181212114726.24060-7-ppandit@redhat.com>
In-Reply-To: <20181212114726.24060-1-ppandit@redhat.com>
References: <20181212114726.24060-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 6/6] rdma: remove unused VENDOR_ERR_NO_SGE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Replace VENDOR_ERR_NO_SGE macro with VENDOR_ERR_INV_NUM_SGE
to indicate invalid number of scatter/gather elements.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/rdma_backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index bd4710d16f..c28bfbd44d 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -37,12 +37,11 @@
 #define VENDOR_ERR_TOO_MANY_SGES    0x202
 #define VENDOR_ERR_NOMEM            0x203
 #define VENDOR_ERR_QP0              0x204
-#define VENDOR_ERR_NO_SGE           0x205
+#define VENDOR_ERR_INV_NUM_SGE      0x205
 #define VENDOR_ERR_MAD_SEND         0x206
 #define VENDOR_ERR_INVLKEY          0x207
 #define VENDOR_ERR_MR_SMALL         0x208
 #define VENDOR_ERR_INV_MAD_BUFF     0x209
-#define VENDOR_ERR_INV_NUM_SGE      0x210
=20
 #define THR_NAME_LEN 16
 #define THR_POLL_TO  5000
--=20
2.19.2
