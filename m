Received: from eggs.gnu.org ([2001:4830:134:3::10]:47931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gV255-0007nM-Uv
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gV24x-00036W-R4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55566
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gV24x-00035t-DP
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 17:25:07 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB6MIx5l039671
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 17:25:07 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p7bddbg70-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 17:25:06 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 6 Dec 2018 22:25:06 -0000
From: Collin Walling <walling@linux.ibm.com>
Date: Thu,  6 Dec 2018 17:24:16 -0500
In-Reply-To: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
References: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
Message-Id: <1544135058-21380-2-git-send-email-walling@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/3] s390: linux header sync for diagnose 318
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, borntraeger@de.ibm.com, thuth@redhat.com

Introduce VM group, attribute, and CPU feat defines for
diagnose 318.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 linux-headers/asm-s390/kvm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 0265482..4b655e3 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_CRYPTO		2
 #define KVM_S390_VM_CPU_MODEL		3
 #define KVM_S390_VM_MIGRATION		4
+#define KVM_S390_VM_MACHINE		5
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -130,6 +131,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_DIAG318	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
@@ -168,6 +170,9 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_MIGRATION_START	1
 #define KVM_S390_VM_MIGRATION_STATUS	2
 
+/* kvm attributes for KVM_S390_VM_MACHINE */
+#define KVM_S390_VM_MACHINE_CPC	0
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
-- 
2.7.4
