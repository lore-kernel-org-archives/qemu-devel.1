Received: from eggs.gnu.org ([2001:4830:134:3::10]:51272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cjJAk-0007Gh-Uu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cjJAh-0005Ak-Os
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:21:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cjJAh-0005AD-JN
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 00:20:59 -0500
Date: Thu, 2 Mar 2017 13:20:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170302052053.GN13926@pxdev.xzpeter.org>
References: <1488425538-13785-1-git-send-email-peterx@redhat.com>
	<20170302071100-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302071100-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Thu, Mar 02, 2017 at 07:13:08AM +0200, Michael S. Tsirkin wrote:
> On Thu, Mar 02, 2017 at 11:32:18AM +0800, Peter Xu wrote:
> > Intel vIOMMU devices are created with "-device" parameter, while here
> > actually we need to make sure the dmar device be created before other
> > PCI devices (like vfio-pci, virtio-pci ones) so that we know iommu_fn
> > will be setup correctly before realizations of those PCI devices (it is
> > legal that PCI device fetch these info during its realization). Now this
> > ordering yet cannot be achieved elsewhere, and devices will be created
> > in the order that user specified. We need to avoid that.
> > 
> > This patch tries to detect this kind of misordering issue during init of
> > VT-d device, then report to guest if misordering happened. In the
> > future, we can provide something better to solve it, e.g., to support
> > device init ordering, then we can live without this patch.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Unfortunately with virtio it's a regression, as it used to
> work with iommu. So I'm afraid we need to look into supporting
> arbitrary order right now :(

No problem.

But do you think that would be a possible material for 2.9?

Thanks,

-- peterx
