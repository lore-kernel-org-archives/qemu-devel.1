Received: from eggs.gnu.org ([2001:4830:134:3::10]:55916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOD-0007Zd-K8
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOA-0003Y1-Go
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyOA-0003XY-82
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB1khk100825
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:01 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmjb1e2v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:00 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:03:58 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:41:04 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-38-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 37/40] s390x/kvm: Enable KSS facility for nested
 virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

If the host supports keyless subset (KSS) then first level
guest (G2) should enable KSS facility as well.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 8c6cc0a..c773bd6 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2508,6 +2508,7 @@ static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_CMMA, S390_FEAT_SIE_CMMA },
     { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
     { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
+    { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
 };
 
 static int query_cpu_feat(S390FeatBitmap features)
-- 
2.7.4
