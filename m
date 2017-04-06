Received: from eggs.gnu.org ([2001:4830:134:3::10]:40638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw9IW-0001r3-Gv
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cw9IT-0004Rq-DA
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:26:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cw9IT-0004RW-6k
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:26:05 -0400
Date: Thu, 6 Apr 2017 23:25:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170406152548.GD3981@pxdev.xzpeter.org>
References: <1491462524-1617-1-git-send-email-peterx@redhat.com>
	<20170406115346.GC29884@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170406115346.GC29884@redhat.com>
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

On Thu, Apr 06, 2017 at 02:53:46PM +0300, Michael S. Tsirkin wrote:
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
> 
> I only see one (6/9) - is a patch missing or misattributed?

Oh sorry I should say "jason's one patch". The other patch has already
been merged upstream, which is 375f74f47 ("vhost: generalize iommu
memory region").

> 
> > - let vhost leverage the new IOMMU notifier interface
> 
> Which patch does this?

The first one ("memory: add section range info for IOMMU notifier").

Thanks,

-- peterx
