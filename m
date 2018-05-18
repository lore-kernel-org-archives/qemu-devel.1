Received: from eggs.gnu.org ([2001:4830:134:3::10]:34629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYrD-00034h-1i
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYr8-0003pt-BL
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:27:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJYr8-0003pf-6c
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:27:10 -0400
Date: Fri, 18 May 2018 14:26:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180518062659.GI2569@xz-mi>
References: <20180517085927.24925-1-peterx@redhat.com>
	<CAHyh4xhP+ERYmSee+ybFtFEKyiHTUcEnUviCDRtKAXebancKLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHyh4xhP+ERYmSee+ybFtFEKyiHTUcEnUviCDRtKAXebancKLw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] intel-iommu: nested vIOMMU,
 cleanups, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>

On Thu, May 17, 2018 at 03:49:05PM -0400, Jintack Lim wrote:
> On Thu, May 17, 2018 at 4:59 AM, Peter Xu <peterx@redhat.com> wrote:
> > (Hello, Jintack, Feel free to test this branch again against your scp
> >  error case when you got free time)
> 
> Hi Peter,
> 
> >
> > I rewrote some of the patches in V3.  Major changes:
> >
> > - Dropped mergable interval tree, instead introduced IOVA tree, which
> >   is even simpler.
> >
> > - Fix the scp error issue that Jintack reported.  Please see patches
> >   for detailed information.  That's the major reason to rewrite a few
> >   of the patches.  We use replay for domain flushes are possibly
> >   incorrect in the past.  The thing is that IOMMU replay has an
> >   "definition" that "we should only send MAP when new page detected",
> >   while for shadow page syncing we actually need something else than
> >   that.  So in this version I started to use a new
> >   vtd_sync_shadow_page_table() helper to do the page sync.
> 
> I checked that the scp problem I had (i.e. scp from the host to the
> guest having virtual IOMMU and an assigned network device) was gone
> with this patch series. Cool!
> 
> Please feel free to move this tag if this is not the right place!
> Tested-by: Jintack Lim <jintack@cs.columbia.edu>

Thanks for the quick feedback!

I'll temporarily consider putting it at the last patch of series if no
one jumps out and tells me another more correct way.  Also I'll
possibly make bold to append your suggested-by too to further claim
your contribution to this problem.

Regards,

-- 
Peter Xu
