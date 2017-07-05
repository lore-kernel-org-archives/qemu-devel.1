Received: from eggs.gnu.org ([2001:4830:134:3::10]:43407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dSklB-0001sR-SU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dSkl7-000449-0N
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:54:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40601
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dSkl6-00043p-Q7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:54:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v65DsHAZ076752
	for <qemu-devel@nongnu.org>; Wed, 5 Jul 2017 09:54:23 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bgvxxutfd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 09:54:23 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 5 Jul 2017 14:54:21 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  5 Jul 2017 15:54:07 +0200
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-4-git-send-email-borntraeger@de.ibm.com>
	<20170704163103.4d6670a9@dhcp-192-215.str.redhat.com>
	<3200e2c0-8ffe-2f6d-b7a8-049352851c96@linux.vnet.ibm.com>
	<87aeaca3-5261-91c9-506b-eded3dededb4@linux.vnet.ibm.com>
	<20170704185924.3eb7171d@dhcp-192-215.str.redhat.com>
	<0a35bfd4-b1d1-ce6c-19e0-4aea225c4406@de.ibm.com>
In-Reply-To: <0a35bfd4-b1d1-ce6c-19e0-4aea225c4406@de.ibm.com>
Message-Id: <20170705135407.6221-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390x: fixup for "fix error propagation in
 kvm-flic..."
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

My patch "s390x: fix error propagation in kvm-flic's realize" accidentally
replaced with. That's wrong! So please apply this fixup before including
that patch into mainline (or any other repo).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---

Hope this is appropriate.
---
 hw/intc/s390_flic_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 88f1555121..a587ace3df 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -467,7 +467,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, Error **errp)
     ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
     if (ret < 0) {
         error_setg_errno(&errp_local, errno, "Creating the KVM device failed");
-        trace_flic_no_device_api(errno);
+        trace_flic_create_device(errno);
         goto fail;
     }
     flic_state->fd = cd.fd;
-- 
2.11.2
