Received: from eggs.gnu.org ([2001:4830:134:3::10]:38650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cE5Ym-00048G-8D
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cE5Yl-0006eJ-HF
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cE5Yl-0006e7-Bl
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:32:47 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  6 Dec 2016 10:32:32 +0800
Message-Id: <1480991552-14360-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
References: <1480991552-14360-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 3/3] fsl_etsec: Fix various small problems in
 hexdump code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Fix various small problems in hexdump code, such as:
    - Reference to non-existing field etsec->nic->nc.name is replaced
    with nc->name

    - Type mismatch warnings

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/fsl_etsec/etsec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 951c5f0..fadf9c8 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -348,8 +348,8 @@ static ssize_t etsec_receive(NetClientState *nc,
     eTSEC *etsec = qemu_get_nic_opaque(nc);
 
 #if defined(HEX_DUMP)
-    fprintf(stderr, "%s receive size:%d\n", etsec->nic->nc.name, size);
-    qemu_hexdump(buf, stderr, "", size);
+    fprintf(stderr, "%s receive size:%zd\n", nc->name, size);
+    qemu_hexdump((void *)buf, stderr, "", size);
 #endif
     /* Flush is unnecessary as are already in receiving path */
     etsec->need_flush = false;
-- 
2.7.4
