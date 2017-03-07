Received: from eggs.gnu.org ([2001:4830:134:3::10]:43017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1clBHJ-000416-CU
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1clBHG-000686-8F
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:19:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1clBHG-000672-2D
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:19:30 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A8F04E4C8
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 09:19:29 +0000 (UTC)
Date: Tue, 7 Mar 2017 17:19:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170307091923.GA31585@pxdev.xzpeter.org>
References: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V3] virtio: do not require IOMMU to be
 created in advance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Mar 07, 2017 at 05:09:11PM +0800, Jason Wang wrote:
> After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
> after caching ring translations"), IOMMU was required to be created in
> advance. This is because we can only get the correct dma_as after pci
> IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
> inconvenient for user. This patch releases this by:
> 
> - introduce a bus_master_ready method for PCIDeviceClass and trigger
>   this during pci_init_bus_master
> - implement virtio-pci method and 1) reset the dma_as 2) re-register
>   the memory listener to the new dma_as
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>
