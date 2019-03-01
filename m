Received: from eggs.gnu.org ([209.51.188.92]:51531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznOM-0006Qv-7P
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznO1-0003sb-VH
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:00:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gznNx-0003iH-8z
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 13:59:55 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21Ixk8q007069
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 13:59:51 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qyaegr64x-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 13:59:50 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 1 Mar 2019 18:59:44 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri,  1 Mar 2019 13:59:29 -0500
In-Reply-To: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1551466776-29123-10-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 09/16] s390-bios: ptr2u32 and u32toptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Introduce inline functions to convert between pointers and unsigned 32-bit
ints. These are used to hide the ugliness required to  avoid compiler
warnings.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/helper.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 pc-bios/s390-ccw/helper.h

diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
new file mode 100644
index 0000000..b8bc61b
--- /dev/null
+++ b/pc-bios/s390-ccw/helper.h
@@ -0,0 +1,16 @@
+#ifndef S390_CCW_HELPER_H
+#define S390_CCW_HELPER_H
+
+/* Avoids compiler warnings when casting a pointer to a u32 */
+static inline uint32_t ptr2u32(void *ptr)
+{
+    return (uint32_t)(uint64_t)ptr;
+}
+
+/* Avoids compiler warnings when casting a u32 to a pointer */
+static inline void *u32toptr(uint32_t n)
+{
+    return (void *)(uint64_t)n;
+}
+
+#endif
-- 
2.7.4
