Received: from eggs.gnu.org ([2001:4830:134:3::10]:40638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9X-0004QU-Ic
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9M-0005cA-S2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40720
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9M-0005bd-LS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0i0nG109177
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:00 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3brr6mr0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:59 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 18:45:59 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:11 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20170920004521.9417-3-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 02/12] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

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
(cherry picked from commit 3a1e4561ad63b303b092387ae006bd41468ece63)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.11.0
