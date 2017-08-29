Received: from eggs.gnu.org ([2001:4830:134:3::10]:60699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmdJp-0005nK-Nd
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dmdJk-0001BH-Mj
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:00:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52315
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dmdJk-0001B9-Hw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:00:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T9x9qN118263
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 06:00:19 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cn1hyrntw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 06:00:17 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 04:00:15 -0600
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-5-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170828175722.0b54b59a.cohuck@redhat.com>
	<498a00ca-ea1a-ae09-0772-4a25c729841e@linux.vnet.ibm.com>
	<20170829100746.66c47fd8.cohuck@redhat.com>
	<0d7cc071-cebe-82d5-90da-9737a5f0733e@linux.vnet.ibm.com>
	<20170829113353.0a13f88a.cohuck@redhat.com>
	<8f60cc33-8438-9d5a-56bd-7b56c8abee4e@linux.vnet.ibm.com>
	<20170829115727.4dacb471.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 18:00:08 +0800
MIME-Version: 1.0
In-Reply-To: <20170829115727.4dacb471.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <394b275f-e840-d608-491a-84248ee3964d@linux.vnet.ibm.com>
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



=E5=9C=A8 2017/8/29 =E4=B8=8B=E5=8D=885:57, Cornelia Huck =E5=86=99=E9=81=
=93:
> On Tue, 29 Aug 2017 17:51:43 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> =E5=9C=A8 2017/8/29 =E4=B8=8B=E5=8D=885:33, Cornelia Huck =E5=86=99=E9=
=81=93:
>>> My question was whether virtio-pci works with your patches on top at
>>> all - last time I checked on master, virtio-pci devices failed to
>>> realize with a "msi-x is mandatory" message.
>>>
>>>  =20
>> I tested. virtio-pci works fine. The message "msix is mandatory" means
>> we only support
>> msix interrupt. If virtio-pci device (like virtio-rng) doesn't support
>> msix, we don't allow it
>> to plug.
> Ah, that's it (it's a bit strange that not all virtio-pci devices
> support msi-x). I can add a virtio-net-pci device just fine.
>
> (Maybe we can enhance the message so that it is clear that it refers to
> that particular device?)
Hum, I think so. But it's not urgent. I could post another patch for=20
message enhancement
after this series review. Do you agree?
>
>> I thinik this is not related to iommu replay.
> This question was unrelated to this particular patch, more to the whole
> series :)
>
>
Yup.
