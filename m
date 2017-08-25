Received: from eggs.gnu.org ([2001:4830:134:3::10]:38508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dlEbd-0007Xd-FZ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dlEba-0003UZ-BF
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:25:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44005
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dlEba-0003UN-5S
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:24:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7PDOvvi127197
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 09:24:57 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cjgt80au9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 09:24:56 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 25 Aug 2017 09:24:49 -0400
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 25 Aug 2017 09:24:46 -0400
In-Reply-To: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
Message-Id: <3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, farman@linux.vnet.ibm.com, walling@linux.vnet.ibm.com

The commit 198c0d1f9df8c4 s390x/css: check ccw address validity
exposes an alignment issue in ccw bios.

According to PoP the CCW must be doubleword aligned. Let's fix
this in the bios.

Cc: qemu-stable@nongnu.org
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 pc-bios/s390-ccw/cio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
index f5b4549..55eaeee 100644
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
1.9.1
