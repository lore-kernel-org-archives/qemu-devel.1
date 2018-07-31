Received: from eggs.gnu.org ([2001:4830:134:3::10]:42869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkQed-00072c-U8
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkQeZ-0000ew-0Y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:09:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkQeY-0000eP-Lg
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:09:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6V94l91147257
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:09:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kjjfb64fv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 05:09:13 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Tue, 31 Jul 2018 10:09:11 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 31 Jul 2018 10:08:59 +0100
In-Reply-To: <20180731090900.187430-1-frankja@linux.ibm.com>
References: <20180731090900.187430-1-frankja@linux.ibm.com>
Message-Id: <20180731090900.187430-2-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/2] kvm: sync linux headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com

Import KVM_CAP_S390_HPAGE.
Placeholder for proper sync.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 linux-headers/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 98f389a5a3..e3b1e3070c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_S390_HPAGE 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.14.3
