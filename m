Received: from eggs.gnu.org ([2001:4830:134:3::10]:41228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw9Jo-0002iy-NB
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw9Jl-0005Gk-Jm
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:27:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cw9Jl-0005FY-EX
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:27:25 -0400
Date: Thu, 6 Apr 2017 23:27:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170406152710.GE3981@pxdev.xzpeter.org>
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
	<20170406145841-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170406145841-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v8 0/9] VT-d: vfio enablement and misc
 enhances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, Marcel Apfelbaum <marcel@redhat.com>, jan.kiszka@siemens.com, jasowang@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

On Thu, Apr 06, 2017 at 03:00:28PM +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 06, 2017 at 03:08:35PM +0800, Peter Xu wrote:
> > This is v8 of vt-d vfio enablement series.
> > 
> > v8
> > - remove patches 1-9 since merged already
> > - add David's r-b for all the patches
> > - add Aviv's s-o-b in the last patch
> > - rename iommu to iommu_dmar [Jason]
> > - rename last patch subject to "remote IOTLB" [Jason]
> > - pick up jason's two patches to fix vhost breakage
> > - let vhost leverage the new IOMMU notifier interface
> 
> Looks good to me except I'm still wondering why there's a single patch
> by Jason.

Answered in the other thread (the other one has been picked up
already).

> Marcel - you mentioned that you intend to try to open and
> maintain pci-next.  Would you like to pick this one up?  Otherwise, pls
> repost after 2.10.

Thanks,

-- peterx
