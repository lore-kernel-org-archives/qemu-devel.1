Received: from eggs.gnu.org ([2001:4830:134:3::10]:52310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjO0S-0002WJ-9K
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjO0P-0006tq-63
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:30:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjO0P-0006tg-0S
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 05:30:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 372863D952
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 10:30:41 +0000 (UTC)
References: <1488341440-4347-1-git-send-email-jasowang@redhat.com>
	<20170302051016.GA3893@redhat.com>
	<3c36e5ad-1244-ca1c-ca3c-5cab9e5cdda4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10909aae-3d0c-71db-2f4c-a51c442d369b@redhat.com>
Date: Thu, 2 Mar 2017 11:30:37 +0100
MIME-Version: 1.0
In-Reply-To: <3c36e5ad-1244-ca1c-ca3c-5cab9e5cdda4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, wexu@redhat.com



On 02/03/2017 08:47, Jason Wang wrote:
>>>
>>> Fixes: c611c76417f5 ("virtio: add MemoryListener to cache ring
>>> translations")
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> This is very ugly. I guess it's better than broken IOMMU ...
>> Paolo?
> 
> Maybe we can delay the registering of memory listener on bus master
> enabling or status setting.

Can we add a callback to PCIDeviceClass, and invoke it from
pci_init_bus_master?

Paolo
