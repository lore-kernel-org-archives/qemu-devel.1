Received: from eggs.gnu.org ([2001:4830:134:3::10]:57895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Hc-0004SG-Ei
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Hb-0006HF-K5
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:56:04 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:50 +0200
Message-Id: <20170830165252.13421-43-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 42/44] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

The commit 198c0d1f9df8c4 s390x/css: check ccw address validity
exposes an alignment issue in ccw bios.

According to PoP the CCW must be doubleword aligned. Let's fix
this in the bios.

Cc: qemu-stable@nongnu.org
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/cio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index f5b4549ea3..55eaeee4b6 100644
--- a/pc-bios/s390-ccw/cio.h
+++ b/pc-bios/s390-ccw/cio.h
@@ -133,7 +133,7 @@ struct ccw1 {
     __u8 flags;
     __u16 count;
     __u32 cda;
-} __attribute__ ((packed));
+} __attribute__ ((packed, aligned(8)));
 
 #define CCW_FLAG_DC              0x80
 #define CCW_FLAG_CC              0x40
-- 
2.13.5
