Received: from eggs.gnu.org ([2001:4830:134:3::10]:55371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2i-0007yX-H5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmF2c-000611-Ll
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmF2c-00060F-DX
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:05:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7S84fmI099942
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:00 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmagbbdmt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 04:05:00 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:04:58 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v7S84tb338469762
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:04:55 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v7S84kAN025716
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 18:04:46 +1000
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 10:04:43 +0200
Message-Id: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] four zpci patches
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

This patch set contains four small zpci patches to fixup different issues.
1) fixup calculation of msix boundary
2) remove zpci idx from msix message, instead we could use PCIDevice's id to
   find zpci device in kvm_arch_fixup_msi_route()
3) fixup ind_offset calculation for adapter interrupt routing entry
4) introduce our own iommu_replay callback

Yi Min Zhao (4):
  s390x/pci: fixup trap_msix()
  s390x/pci: remove idx from msix msg data
  s390x/pci: fixup ind_offset of msix routing entry
  s390x/pci: add iommu replay callback

 hw/s390x/s390-pci-bus.c  | 24 +++++++++++++-----------
 hw/s390x/s390-pci-bus.h  |  2 ++
 hw/s390x/s390-pci-inst.c | 28 ++--------------------------
 target/s390x/kvm.c       | 11 ++++++-----
 4 files changed, 23 insertions(+), 42 deletions(-)

-- 
2.11.0 (Apple Git-81)
