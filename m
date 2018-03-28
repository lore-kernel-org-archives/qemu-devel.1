Received: from eggs.gnu.org ([2001:4830:134:3::10]:56619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1D4a-0003Al-6W
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1D4X-0007dM-2x
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:33:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57192 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f1D4W-0007cj-W4
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:33:09 -0400
Date: Wed, 28 Mar 2018 18:33:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180328183159-mutt-send-email-mst@kernel.org>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
	<20180322181952-mutt-send-email-mst@kernel.org>
	<20180328122407.gc6yba26gijlm5g6@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328122407.gc6yba26gijlm5g6@debian>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Extend vhost-user to support VFIO
 based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Wed, Mar 28, 2018 at 08:24:07PM +0800, Tiwei Bie wrote:
> > > Update notes
> > > ============
> > > 
> > > IOMMU feature bit check is removed in this version, because:
> > > 
> > > The IOMMU feature is negotiable, when an accelerator is used and
> > > it doesn't support virtual IOMMU, its driver just won't provide
> > > this feature bit when vhost library querying its features. And if
> > > it supports the virtual IOMMU, its driver can provide this feature
> > > bit. It's not reasonable to add this limitation in this patch set.
> > 
> > Fair enough. Still:
> > Can hardware on intel platforms actually support IOTLB requests?
> > Don't you need to add support for vIOMMU shadowing instead?
> > 
> 
> For the hardware I have, I guess they can't for now.

So VFIO in QEMU has support for vIOMMU shadowing.
Can you use that somehow?

Ability to run dpdk within guest seems important.

-- 
MST
