Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwQXj-00050R-Ab
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dwQXf-0003U6-SI
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50166
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dwQXf-0003TR-Mq
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:23:11 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PAJkZU084572
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:23:08 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d6w3vk4qy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:23:08 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Sep 2017 11:23:06 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Sep 2017 12:23:01 +0200
In-Reply-To: <20170925102302.60587-1-borntraeger@de.ibm.com>
References: <20170925102302.60587-1-borntraeger@de.ibm.com>
Message-Id: <20170925102302.60587-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] linux-headers: Update linux headers for
 extended TOD-Clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

Conny: to be replaced with 4.14-rc*.

Adds KVM_S390_VM_TOD_EXT attribute for the extended TOD-Clock
attribute and kvm_s390_vm_tod_clock struct for TOD-Clock data.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 linux-headers/asm-s390/kvm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 8387d71..7b750ef 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -88,6 +88,12 @@ struct kvm_s390_io_adapter_req {
 /* kvm attributes for KVM_S390_VM_TOD */
 #define KVM_S390_VM_TOD_LOW		0
 #define KVM_S390_VM_TOD_HIGH		1
+#define KVM_S390_VM_TOD_EXT		2
+
+struct kvm_s390_vm_tod_clock {
+	__u8  epoch_idx;
+	__u64 tod;
+};
 
 /* kvm attributes for KVM_S390_VM_CPU_MODEL */
 /* processor related attributes are r/w */
-- 
2.9.4
