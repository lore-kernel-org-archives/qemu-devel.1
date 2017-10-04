Received: from eggs.gnu.org ([2001:4830:134:3::10]:55423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzk3f-00066W-BZ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dzk3b-0003ji-EC
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48228
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dzk3b-0003iv-7n
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:49:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94Dn2nN005747
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 09:49:47 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dcxvfftf9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 09:49:46 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 14:49:45 +0100
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 15:49:35 +0200
In-Reply-To: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1507124979-8880-2-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/5] s390x/kvm: Enable AIS from CPU model
 always
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

As this patchset will introduce AIS emulation, we always enable
Adapter Interrupt Suppression, depending only from the CPU model.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 target/s390x/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 931b85f..06fe56d 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2807,6 +2807,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     if (pci_available) {
         set_bit(S390_FEAT_ZPCI, model->features);
     }
+    set_bit(S390_FEAT_ADAPTER_INT_SUPPRESSION, model->features);
     set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
 
     if (s390_known_cpu_type(cpu_type)) {
-- 
2.3.0
