Received: from eggs.gnu.org ([2001:4830:134:3::10]:33250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEDSy-0001f4-Ri
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEDSy-0001ny-3y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:59:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cEDSx-0001mX-UK
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:59:20 -0500
Date: Tue, 6 Dec 2016 18:59:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161206105914.GB3469@pxdev.xzpeter.org>
References: <1480348315-13332-1-git-send-email-bd.aviv@gmail.com>
	<8188dd5e-2c71-dbd0-9a1a-9c8af6f74b96@intel.com>
	<20161202065214.GF21601@pxdev.xzpeter.org>
	<088c2afd-575e-99af-1686-023c116352ab@intel.com>
	<20161206065155.GB4344@pxdev.xzpeter.org>
	<6d37d046-8e5a-7662-baa6-445d3985fde7@intel.com>
	<20161206072228.GC4344@pxdev.xzpeter.org>
	<f9f9daab-519d-381b-c9e8-c6dcc139f1d3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9f9daab-519d-381b-c9e8-c6dcc139f1d3@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/5] IOMMU: intel_iommu support map and
 unmap notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Aviv B.D" <bd.aviv@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>

On Tue, Dec 06, 2016 at 04:27:39PM +0800, Lan Tianyu wrote:

[...]

> > 
> >> User space driver(E.G DPDK) also can enable/disable
> >> IOVA for device dynamically.
> > 
> > Could you provide more detailed (or any pointer) on how to do that? I
> > did try to find it myself, I see an VFIO_IOMMU_ENABLE ioctl, but looks
> > like it is for ppc only.
> 
> No, I just give an example that user space may do that but no more
> research. But since Qemu already can enable device's IOVA, other user
> application also should can do that with the same VFIO interface, right?

AFAIU we can't do that at least on x86. We can use vfio interface to
bind group into container, but we should not be able to dynamically
disable IOMMU protection. IIUC That needs to taint the kernel.

The only way I know is that we probe vfio-pci with no-iommu mode, in
that case, we disabled IOMMU, but we can never dynamically enable it
as well.

Please correct me if I am wrong.

Thanks,

-- peterx
