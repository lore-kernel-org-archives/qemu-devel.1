Received: from eggs.gnu.org ([2001:4830:134:3::10]:38549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVvig-0006cJ-OT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVvid-00043X-JT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:40:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVvid-00041r-Dk
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:40:43 -0500
Date: Tue, 24 Jan 2017 15:40:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170124074039.GB16400@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<20170123175422-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170123175422-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH RFC v4 00/20] VT-d: vfio enablement and
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

On Mon, Jan 23, 2017 at 05:55:51PM +0200, Michael S. Tsirkin wrote:
> On Fri, Jan 20, 2017 at 09:08:36PM +0800, Peter Xu wrote:
> > This is v4 of vt-d vfio enablement series.
> > 
> > Sorry that v4 growed to 20 patches. Some newly added patches (which
> > are quite necessary):
> > 
> > [01/20] vfio: trace map/unmap for notify as well
> > [02/20] vfio: introduce vfio_get_vaddr()
> > [03/20] vfio: allow to notify unmap for very large region
> > 
> >   Patches from RFC series:
> > 
> >   "[PATCH RFC 0/3] vfio: allow to notify unmap for very big region"
> > 
> >   Which is required by patch [19/20].
> > 
> > [11/20] memory: provide IOMMU_NOTIFIER_FOREACH macro
> > 
> >   A helper only.
> > 
> > [19/20] intel_iommu: unmap existing pages before replay
> > 
> >   This solves Alex's concern that there might have existing mappings
> >   in previous domain when replay happens.
> > 
> > [20/20] intel_iommu: replay even with DSI/GLOBAL inv desc
> > 
> >   This solves Jason/Kevin's concern by handling DSI/GLOBAL
> >   invalidations as well.
> > 
> > Each individual patch will have more detailed explanation on itself.
> > Please refer to each of them.
> > 
> > Here I did separate work on patch 19/20 rather than squashing them
> > into patch 18 for easier modification and review. I prefer we have
> > them separately so we can see each problem separately, after all,
> > patch 18 survives in most use cases. Please let me know if we want to
> > squash them in some way. I can respin when necessary.
> > 
> > Besides the big things, lots of tiny tweaks as well. Here's the
> > changelog.
> 
> It would be nice to add to the log
> - known issues / missing features, if any

Sure. Will add them in next post.

> - are there patches ready to be merged here?
>   if yes pls post them without the rfc tag

The series (since V1) should have passed compilation test and simple
functional test (though only with my tiny C program to torture it).
Since I have got lots of review comments, and looks like the whole
thing is acceptable in general, I'll repost with a non-rfc version
with some tweaks upon this one.

Michael, please feel free to pick any of them which you think are
applicable and safe (e.g., the iommu cleanups).

Thanks,

-- peterx
