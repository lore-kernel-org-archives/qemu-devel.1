Received: from eggs.gnu.org ([2001:4830:134:3::10]:45172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRrSw-0006Nf-2j
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRrSs-0005KQ-4C
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:19:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRrSr-0005Jb-Uc
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 21:19:38 -0500
Date: Fri, 13 Jan 2017 10:19:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170113021927.GT4450@pxdev.xzpeter.org>
References: <1483428594-28880-1-git-send-email-peterx@redhat.com>
	<20170112162441-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170112162441-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH RFC v2 00/17] VT-d: vfio enablement and
 misc enhances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Thu, Jan 12, 2017 at 04:27:30PM +0200, Michael S. Tsirkin wrote:
> On Tue, Jan 03, 2017 at 03:29:37PM +0800, Peter Xu wrote:
> > (I renamed the title for this RFC v2, since starting from this version
> >  the series will be based on master, also I picked up some more fixes
> >  for vt-d into this series)
> > 
> > v2:
> > - change comment for "end" parameter in vtd_page_walk() [Tianyu]
> > - change comment for "a iova" to "an iova" [Yi]
> > - fix fault printed val for GPA address in vtd_page_walk_level (debug
> >   only)
> > - rebased to master (rather than Aviv's v6 series) and merged Aviv's
> >   series v6: picked patch 1 (as patch 1 in this series), dropped patch
> >   2, re-wrote patch 3 (as patch 17 of this series).
> > - picked up two more bugfix patches from Jason's DMAR series
> > - picked up the following patch as well:
> >   "[PATCH v3] intel_iommu: allow dynamic switch of IOMMU region"
> > 
> > This RFC series is a re-work for Aviv B.D.'s vfio enablement series
> > with vt-d:
> > 
> >   https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01452.html
> > 
> > Aviv has done a great job there, and what we still lack there are
> > mostly the following:
> > 
> > (1) VFIO got duplicated IOTLB notifications due to splitted VT-d IOMMU
> >     memory region.
> > 
> > (2) VT-d still haven't provide a correct replay() mechanism (e.g.,
> >     when IOMMU domain switches, things will broke).
> > 
> > This series should have solved the above two issues.
> > 
> > Online repo:
> > 
> >   https://github.com/xzpeter/qemu/tree/vtd-vfio-enablement-v2
> > 
> > I would be glad to hear about any review comments for above patches.
> 
> This all looks good to me. The series needs to be
> rebased on top of latest bits.
> In particular, Jason made changes which conflict
> with this.

Michael,

Thanks for your positive feedback.

Could you provide me a branch so that I can rebase this work on? I was
trying to find a good base point in your repo here:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git

but failed to find a suitable branch. Thanks,

-- peterx
