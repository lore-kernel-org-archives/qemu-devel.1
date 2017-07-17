Received: from eggs.gnu.org ([2001:4830:134:3::10]:57693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dX9M0-0008Qv-2i
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dX9Lv-0005E7-6R
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dX9Lu-0005DI-TH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:58:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6HGn45M118829
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 12:58:33 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2brqy9sbtg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 12:58:33 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 17 Jul 2017 17:58:30 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Jul 2017 18:58:25 +0200
In-Reply-To: <1500310706-36211-1-git-send-email-borntraeger@de.ibm.com>
References: <1500310706-36211-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500310706-36211-2-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] linux header sync against v4.13-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

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
