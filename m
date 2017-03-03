Received: from eggs.gnu.org ([2001:4830:134:3::10]:50304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjjFB-0008Tb-32
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjjF6-0001jV-0l
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:11:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cjjF5-0001jB-QZ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 04:11:15 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B7DA2E6055
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 09:11:16 +0000 (UTC)
References: <1488341440-4347-1-git-send-email-jasowang@redhat.com>
	<20170302051016.GA3893@redhat.com>
	<3c36e5ad-1244-ca1c-ca3c-5cab9e5cdda4@redhat.com>
	<10909aae-3d0c-71db-2f4c-a51c442d369b@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <23851410-c304-8c77-79b5-a623175f0db3@redhat.com>
Date: Fri, 3 Mar 2017 17:11:07 +0800
MIME-Version: 1.0
In-Reply-To: <10909aae-3d0c-71db-2f4c-a51c442d369b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: unbreak virtio-pci with IOMMU
 after caching ring translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, wexu@redhat.com



On 2017=E5=B9=B403=E6=9C=8802=E6=97=A5 18:30, Paolo Bonzini wrote:
>
> On 02/03/2017 08:47, Jason Wang wrote:
>>>> Fixes: c611c76417f5 ("virtio: add MemoryListener to cache ring
>>>> translations")
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> This is very ugly. I guess it's better than broken IOMMU ...
>>> Paolo?
>> Maybe we can delay the registering of memory listener on bus master
>> enabling or status setting.
> Can we add a callback to PCIDeviceClass, and invoke it from
> pci_init_bus_master?
>
> Paolo
>

This looks pci specific, I post a fix that reset the dma_as during=20
status set which can solve this issue too. Please have a look.

Thanks
