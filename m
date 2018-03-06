Received: from eggs.gnu.org ([2001:4830:134:3::10]:52302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et6W7-0000gC-Ae
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et6W4-0006y2-6c
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:56:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et6W4-0006xh-0y
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:56:04 -0500
Date: Tue, 6 Mar 2018 14:55:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180306065545.GE3615@xz-mi>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Introduce new iommu notifier
 framework for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com

On Thu, Mar 01, 2018 at 06:33:23PM +0800, Liu, Yi L wrote:
> This patchset is to introduce a notifier framework for virt-SVA.
> You may find virt-SVA design details from the link below.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04925.html
> 
> SVA is short for Shared Virtual Addressing. This is also called Shared
> Virtual Memory in previous patchsets. However, SVM is confusing as it
> can also be short for Secure Virtual Machine. So this patchset use
> Shared Virtual Addressing instead of Shared Virtual Memory. And it
> would be applied in future (SVA)related patch series as well.
> 
> Qemu has an existing notifier framework based on MemoryRegion, which
> are used for MAP/UNMAP. However, it is not well suited for virt-SVA.
> Reasons are as below:
> - virt-SVA works along with PT = 1
> - if PT = 1 IOMMU MR are disabled so MR notifier are not registered
> - new notifiers do not fit nicely in this framework as they need to be
>   registered even if PT = 1
> - need a new framework to attach the new notifiers
> - Additional background can be got from:
>   https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04931.html
> 
> So a new iommu notifier framework is needed. This patchset introduces
> a notifier framework based on IOMMUSVAContext. IOMMUSVAContext is
> introduced to be an abstract of virt-SVA operations in Qemu.
> 
> Patch Overview:
> * 1 - 2: rename existing naming, the IOMMU MemoryRegion Notifier
>          framework
> * 3 - 4: introduce SVA notifier framework based on IOMMUSVAContext
> * 5 - 7: introduce PCISVAOps and expose the SVA notfier framework
>          through hw/pci layer
> * 8 - 12: show the usage of SVA notifier in Intel vIOMMU emulator

Do you have online branch so that I can check out?

The patches are a bit scattered and it's really hard for me to
reference things within it... So a complete tree to read would be
nice.

I roughly went over most of the patches, and the framework you
introduced is still not that clear to me.  For now I feel like it can
be simplified somehow, but I'll hold and speak after I read the whole
tree again.

Also, it'll be good too if you can always provide some status update
of the kernel-counterpart it.

Thanks,

-- 
Peter Xu
