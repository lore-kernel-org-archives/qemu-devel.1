Received: from eggs.gnu.org ([2001:4830:134:3::10]:39818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkr2K-0003cB-98
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkr2I-0001Rk-0f
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkr2H-0001PS-Na
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:19:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w71DIr7b140679
	for <qemu-devel@nongnu.org>; Wed, 1 Aug 2018 09:19:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kkbm3dj6x-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 09:19:20 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Wed, 1 Aug 2018 14:19:18 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed,  1 Aug 2018 14:19:04 +0100
In-Reply-To: <20180801131905.148778-1-frankja@linux.ibm.com>
References: <20180801131905.148778-1-frankja@linux.ibm.com>
Message-Id: <20180801131905.148778-2-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 1/2] kvm: sync linux headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org

Import KVM_CAP_S390_HPAGE_1M.
Placeholder for proper sync.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 linux-headers/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 98f389a5a3..2aae948219 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_S390_HPAGE_1M 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.14.3
