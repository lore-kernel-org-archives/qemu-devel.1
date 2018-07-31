Received: from eggs.gnu.org ([2001:4830:134:3::10]:46749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkTT0-0005ef-4D
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1fkTSv-0005UQ-56
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51054
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1fkTSu-0005UG-VG
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:09:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6VC4KEA117799
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 08:09:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kjq5a92bw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 08:09:23 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Tue, 31 Jul 2018 13:09:22 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 31 Jul 2018 13:09:07 +0100
In-Reply-To: <20180731120908.9202-1-frankja@linux.ibm.com>
References: <20180731120908.9202-1-frankja@linux.ibm.com>
Message-Id: <20180731120908.9202-2-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/2] kvm: sync linux headers
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

Import KVM_CAP_S390_HPAGE_1M
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
