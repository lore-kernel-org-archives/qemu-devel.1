Received: from eggs.gnu.org ([2001:4830:134:3::10]:44169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpAr8-0006Xf-LC
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpAr3-0003YZ-UR
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51589
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dpAr3-0003Xu-PV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:13:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85A9q6V069102
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 06:13:12 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cssasa3dn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 06:13:12 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 20:13:09 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v85AD6qi34865260
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 20:13:06 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
	by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v85AD6nU011804
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 20:13:06 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue,  5 Sep 2017 12:12:57 +0200
Message-Id: <1504606380-49341-1-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/3] three zpci patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, agraf@suse.de, richard.henderson@linaro.org, zyimin@linux.vnet.ibm.com

This patch set contains three small zpci patches to fixup different issues.
1) remove zpci idx from msix message, instead we could use PCIDevice's id to
   find zpci device in kvm_arch_fixup_msi_route()
2) fixup ind_offset calculation for adapter interrupt routing entry
3) introduce our own iommu_replay callback

Yi Min Zhao (3):
  s390x/pci: remove idx from msix msg data
  s390x/pci: fixup ind_offset of msix routing entry
  s390x/pci: add iommu replay callback

 hw/s390x/s390-pci-bus.c  | 28 +++++++++++++++++-----------
 hw/s390x/s390-pci-bus.h  |  2 ++
 hw/s390x/s390-pci-inst.c | 24 ------------------------
 hw/s390x/s390-pci-stub.c |  3 ++-
 target/s390x/kvm.c       | 14 ++++++++------
 5 files changed, 29 insertions(+), 42 deletions(-)

-- 
Change log:
from v2:
1) Remove s390_pci_find_dev_by_idx() from s390_pci_stub.c
2) Add output message in kvm_arch_fixup_msi_route() for dev argument check.
3) Update the comment for s390_pci_iommu_replay().

from v1:
1) Add s390_pci_find_dev_by_target() in s390_pci_stub.c
2) Remove the accepted patch from the series (Thanks for Conny's help).
3) Fixup typo error.
4) Add more comment for s390_pci_iommu_replay().
