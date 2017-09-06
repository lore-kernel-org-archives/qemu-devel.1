Received: from eggs.gnu.org ([2001:4830:134:3::10]:36279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpSPN-00069x-Q6
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 00:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpSPK-0004RQ-Ov
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 00:57:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50222
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dpSPK-0004QR-JH
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 00:57:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v864rswI108762
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 00:57:45 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ct1s8sqf1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 00:57:45 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 14:57:42 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v864veDt33161298
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 14:57:40 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v864veSq016488
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 14:57:40 +1000
Received: from zyimindembp.cn.ibm.com (zyimindembp.cn.ibm.com [9.115.193.63])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	v864vdKq016469
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 14:57:40 +1000
References: <1504606380-49341-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170905135832.70a0397c.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 12:57:38 +0800
MIME-Version: 1.0
In-Reply-To: <20170905135832.70a0397c.cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <e699648a-f5d8-42b2-1698-06683c062b46@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] three zpci patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thank you very much!


=D4=DA 2017/9/5 =CF=C2=CE=E77:58, Cornelia Huck =D0=B4=B5=C0:
> On Tue,  5 Sep 2017 12:12:57 +0200
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> This patch set contains three small zpci patches to fixup different is=
sues.
>> 1) remove zpci idx from msix message, instead we could use PCIDevice's=
 id to
>>     find zpci device in kvm_arch_fixup_msi_route()
>> 2) fixup ind_offset calculation for adapter interrupt routing entry
>> 3) introduce our own iommu_replay callback
>>
>> Yi Min Zhao (3):
>>    s390x/pci: remove idx from msix msg data
>>    s390x/pci: fixup ind_offset of msix routing entry
>>    s390x/pci: add iommu replay callback
>>
>>   hw/s390x/s390-pci-bus.c  | 28 +++++++++++++++++-----------
>>   hw/s390x/s390-pci-bus.h  |  2 ++
>>   hw/s390x/s390-pci-inst.c | 24 ------------------------
>>   hw/s390x/s390-pci-stub.c |  3 ++-
>>   target/s390x/kvm.c       | 14 ++++++++------
>>   5 files changed, 29 insertions(+), 42 deletions(-)
>>
> Thanks, applied.
>
>
