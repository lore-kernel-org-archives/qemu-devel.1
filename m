Received: from eggs.gnu.org ([2001:4830:134:3::10]:49556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cWFVm-00044Y-Rq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cWFVi-0005yR-Sk
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:48:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cWFVi-0005yK-NJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:48:42 -0500
Date: Wed, 25 Jan 2017 12:48:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170125044837.GE5151@pxdev.xzpeter.org>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<20170124114910.GD16400@pxdev.xzpeter.org>
	<20170124164751-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124164751-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v5 00/18] VT-d: vfio enablement and misc
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
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Jan 24, 2017 at 04:48:49PM +0200, Michael S. Tsirkin wrote:
> On Tue, Jan 24, 2017 at 07:49:10PM +0800, Peter Xu wrote:
> > On Tue, Jan 24, 2017 at 06:25:53PM +0800, Peter Xu wrote:
> > > This is v5 of vt-d vfio enablement series.
> > > 
> > > Most of the changes in v5 is not functionally, but related to
> > > comments, error_report()s, debugging, squashing patches, etc. (which
> > > are confirmed changes in v4), besides a tiny tweak when unmapping a
> > > whole address space (please see below changelog). There are still
> > > discussions in v4 thread, we can just continue there (or here), and
> > > from this version I'll remove RFC tag.
> > > 
> > > I didn't rebase to master since current master failed to build on my
> > > laptop (with a "vl.c/hax..." error), however this series should be
> > > okay to be applied cleanly upon it.
> > 
> > Sorry I forgot to append the todo list (please help adding in in case
> > I missed anything):
> > 
> > - don't need to notify IOTLB (psi/gsi/global) invalidations to devices
> >   that with ATS enabled
> > - investigate when guest map page while mask contains existing mapped
> >   pages (e.g. map 12k-16k first, then map 0-12k)
> > - coalesce unmap during page walk (currently, we send it once per
> >   page)
> > - when do PSI for unmap, whether we can send one notify directly
> >   instead of walking over the page table?
> > 
> > Above does not contain those that are still during discussion. And,
> > some of the entries still need tests to further prove it's
> > feasibility.
> > 
> > Thanks,
> > 
> > -- peterx
> 
> While valid I don't think above need to block merging.

Sorry for the delay of this series.

Looks like we still need to wait until we got explicit acks for vfio
patch 2-3 from Alex/Paolo/David since that'll be required by the
following series. (I'll address all Jason's new comments as well in
next post)

Do you like to merge the iommu cleanups first? Or you can also wait
for above to be confirmed, and I'll repost for a final version then
(if we don't have further comments).

Thanks,

-- peterx
