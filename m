Received: from eggs.gnu.org ([2001:4830:134:3::10]:50688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXOYY-0000Ma-SR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXOYT-0002Lo-OZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52664
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXOYT-0002LV-Is
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:12:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I99MhB036968
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 05:12:33 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bsbdf2byv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 05:12:32 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 18 Jul 2017 10:12:29 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Jul 2017 11:12:23 +0200
In-Reply-To: <1500369144-143949-1-git-send-email-borntraeger@de.ibm.com>
References: <1500369144-143949-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500369144-143949-2-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 1/2] linux header sync against v4.13-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 linux-headers/asm-x86/kvm_para.h | 1 +
 linux-headers/linux/kvm.h        | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-x86/kvm_para.h b/linux-headers/asm-x86/kvm_para.h
index 3a53979..cefa127 100644
--- a/linux-headers/asm-x86/kvm_para.h
+++ b/linux-headers/asm-x86/kvm_para.h
@@ -67,6 +67,7 @@ struct kvm_clock_pairing {
 
 #define KVM_ASYNC_PF_ENABLED			(1 << 0)
 #define KVM_ASYNC_PF_SEND_ALWAYS		(1 << 1)
+#define KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT	(1 << 2)
 
 /* Operations for KVM_HC_MMU_OP */
 #define KVM_MMU_OP_WRITE_PTE            1
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 43e2d82..7971a4f 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -927,6 +927,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_CMMA_MIGRATION 145
 #define KVM_CAP_PPC_FWNMI 146
 #define KVM_CAP_PPC_SMT_POSSIBLE 147
+#define KVM_CAP_HYPERV_SYNIC2 148
+#define KVM_CAP_HYPERV_VP_INDEX 149
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1351,7 +1353,7 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_X86_SMM */
 #define KVM_SMI                   _IO(KVMIO,   0xb7)
 /* Available with KVM_CAP_S390_CMMA_MIGRATION */
-#define KVM_S390_GET_CMMA_BITS      _IOW(KVMIO, 0xb8, struct kvm_s390_cmma_log)
+#define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
 
 #define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
-- 
2.7.4
