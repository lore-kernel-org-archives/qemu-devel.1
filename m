Received: from eggs.gnu.org ([209.51.188.92]:33257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2GT-0001Sg-P4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hL2Bg-0000M9-0A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:03:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hL2Bf-0000L5-MK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:02:59 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3T8rfCI018987
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:02:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s5vpxbrkg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:02:57 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Apr 2019 10:02:56 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Apr 2019 05:02:42 -0400
In-Reply-To: <20190429090250.7648-1-borntraeger@de.ibm.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
Message-Id: <20190429090250.7648-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/9] linux header sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>

to be replaced by a proper one

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 linux-headers/asm-s390/kvm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 0265482f8f..03ab5968c7 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -152,7 +152,10 @@ struct kvm_s390_vm_cpu_subfunc {
 	__u8 pcc[16];		/* with MSA4 */
 	__u8 ppno[16];		/* with MSA5 */
 	__u8 kma[16];		/* with MSA8 */
-	__u8 reserved[1808];
+	__u8 kdsa[16];		/* with MSA9 */
+	__u8 sortl[32];		/* with STFLE.150 */
+	__u8 dfltcc[32];	/* with STFLE.151 */
+	__u8 reserved[1728];
 };
 
 /* kvm attributes for crypto */
-- 
2.17.1
