Received: from eggs.gnu.org ([2001:4830:134:3::10]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dkkZ7-0008SZ-Ja
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dkkZ4-0004Fr-Cn
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:20:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46808
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dkkZ4-0004Fi-7v
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:20:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7O5IkQ1002582
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 01:20:19 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2chjey6vft-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 01:20:19 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 01:20:19 -0400
References: <20170823072656.3352-1-zyimin@linux.vnet.ibm.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 13:20:12 +0800
MIME-Version: 1.0
In-Reply-To: <20170823072656.3352-1-zyimin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <871ef0e3-ea8b-df59-0eeb-8019b350f1d2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] four zpci patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, agraf@suse.de, richard.henderson@linaro.org

Why can't I receive [Qemu-devel] prefixed patches?


=D4=DA 2017/8/23 =CF=C2=CE=E73:26, Yi Min Zhao =D0=B4=B5=C0:
> This patch set contains four small zpci patches to fixup different issu=
es.
> 1) fixup calculation of msix boundary
> 2) remove zpci idx from msix message, instead we could use PCIDevice's =
id to
>     find zpci device in kvm_arch_fixup_msi_route()
> 3) fixup ind_offset calculation for adapter interrupt routing entry
> 4) introduce our own iommu_replay callback
>
> Yi Min Zhao (4):
>    s390x/pci: fixup trap_msix()
>    s390x/pci: remove idx from msix msg data
>    s390x/pci: fixup ind_offset of msix routing entry
>    s390x/pci: add iommu replay callback
>
>   hw/s390x/s390-pci-bus.c  | 24 +++++++++++++-----------
>   hw/s390x/s390-pci-bus.h  |  2 ++
>   hw/s390x/s390-pci-inst.c | 28 ++--------------------------
>   target/s390x/kvm.c       | 11 ++++++-----
>   4 files changed, 23 insertions(+), 42 deletions(-)
>
