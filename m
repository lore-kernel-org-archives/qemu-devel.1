Received: from eggs.gnu.org ([2001:4830:134:3::10]:59317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmdEJ-0002mi-NA
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmdEE-00079a-PN
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:54:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmdEE-00079G-HA
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:54:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T9sYsU115150
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 05:54:36 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cn4e6n5ar-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 05:54:34 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 03:53:41 -0600
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828175722.0b54b59a.cohuck@redhat.com>
	<498a00ca-ea1a-ae09-0772-4a25c729841e@linux.vnet.ibm.com>
	<20170829100746.66c47fd8.cohuck@redhat.com>
	<0d7cc071-cebe-82d5-90da-9737a5f0733e@linux.vnet.ibm.com>
	<20170829113353.0a13f88a.cohuck@redhat.com>
	<20170829114920.48eb459b.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 17:53:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170829114920.48eb459b.cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <e91231bb-f670-6dd1-0ec7-60b7e1c1b539@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] s390x/pci: add iommu replay callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org



=E5=9C=A8 2017/8/29 =E4=B8=8B=E5=8D=885:49, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Tue, 29 Aug 2017 11:33:53 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> My question was whether virtio-pci works with your patches on top at
>> all - last time I checked on master, virtio-pci devices failed to
>> realize with a "msi-x is mandatory" message.
> Just checked again, I still get
>
> qemu-system-s390x: -device virtio-rng-pci: MSI-X support is mandatory i=
n the S390 architecture
>
> Any clue to what is missing?
>
>
virtio-rng-pci doesn't support msix. But msix is required on s390 arch.
So we avoid plugging any pci device without msix support.
