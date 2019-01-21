Received: from eggs.gnu.org ([209.51.188.92]:44973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glXNj-0002Va-93
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glXNi-0003sS-Bs
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:04:43 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 21 Jan 2019 12:03:53 +0100
Message-Id: <20190121110354.2247-5-cohuck@redhat.com>
In-Reply-To: <20190121110354.2247-1-cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] s390/cio: export hsch to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

The vfio-ccw code will need this, and it matches treatment of ssch
and csch.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/ioasm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
index 14d328338ce2..08eb10283b18 100644
--- a/drivers/s390/cio/ioasm.c
+++ b/drivers/s390/cio/ioasm.c
@@ -233,6 +233,7 @@ int hsch(struct subchannel_id schid)
 
 	return ccode;
 }
+EXPORT_SYMBOL(hsch);
 
 static inline int __xsch(struct subchannel_id schid)
 {
-- 
2.17.2
