Received: from eggs.gnu.org ([2001:4830:134:3::10]:49417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eBzSk-00017j-Ef
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eBzSh-0003Fx-9h
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 03:42:26 -0500
References: <1467696699-8941-9-git-send-email-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <52275d2d-0a93-fe92-56ed-7841fa5a79dc@redhat.com>
Date: Tue, 7 Nov 2017 09:42:15 +0100
MIME-Version: 1.0
In-Reply-To: <1467696699-8941-9-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL,
 08/14] spapr_pci/spapr_pci_vfio: Support Dynamic DMA Windows (DDW)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@ozlabs.ru
Cc: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org, agraf@suse.de, qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-ppc@nongnu.org

On 05/07/2016 07:31, David Gibson wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> This adds support for Dynamic DMA Windows (DDW) option defined by
> the SPAPR specification which allows to have additional DMA window(s)
> 
> The "ddw" property is enabled by default on a PHB but for compatibility
> the pseries-2.6 machine and older disable it.
> This also creates a single DMA window for the older machines to
> maintain backward migration.
> 
> This implements DDW for PHB with emulated and VFIO devices. The host
> kernel support is required. The advertised IOMMU page sizes are 4K and
> 64K; 16M pages are supported but not advertised by default, in order to
> enable them, the user has to specify "pgsz" property for PHB and
> enable huge pages for RAM.

Why is it not advirtised by default?

When we start qemu with hugepage memory ("mount -t hugetlbfs none
/mnt/kvm_hugepage" and ".. -mem-path /mnt/kvm_hugepage .."), we have an
ugly message:

"qemu-kvm: System page size 0x1000000 is not enabled in page_size_mask
(0x11000). Performance may be slow"

I understand if we want to use this with VFIO, we need something like
"-global spapr-pci-host-bridge.pgsz=0x1011000".

But is it needed if we don't use VFIO?
Is it a way QEMU adds automatically the 0x1000000 mask to page_size_mask?

Thanks,
Laurent
