Received: from eggs.gnu.org ([2001:4830:134:3::10]:38867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIuKe-0006Lf-QQ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIuKZ-0001f7-PR
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:34:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIuKZ-0001eu-K2
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:34:03 -0500
Date: Mon, 19 Dec 2016 17:33:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161219093357.GC4155@pxdev.xzpeter.org>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/13] VT-d replay and misc cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, alex.williamson@redhat.com, jasowang@redhat.com

On Tue, Dec 06, 2016 at 06:36:15PM +0800, Peter Xu wrote:
> This RFC series is a continue work for Aviv B.D.'s vfio enablement
> series with vt-d. Aviv has done a great job there, and what we still
> lack there are mostly the following:
> 
> (1) VFIO got duplicated IOTLB notifications due to splitted VT-d IOMMU
>     memory region.
> 
> (2) VT-d still haven't provide a correct replay() mechanism (e.g.,
>     when IOMMU domain switches, things will broke).
> 
> Here I'm trying to solve the above two issues.
> 
> (1) is solved by patch 7, (2) is solved by patch 11-12.
> 
> Basically it contains the following:
> 
> patch 1:    picked up from Jason's vhost DMAR series, which is a bugfix
> 
> patch 2-6:  Cleanups/Enhancements for existing vt-d codes (please see
>             specific commit message for details, there are patches
>             that I thought may be suitable for 2.8 as well, but looks
>             like it's too late)
> 
> patch 7:    Solve the issue that vfio is notified more than once for
>             IOTLB notifications with Aviv's patches
> 
> patch 8-10: Some trivial memory APIs added for further patches, and
>             add customize replay() support for MemoryRegion (I see
>             Aviv's latest v7 contains similar replay, I can rebase
>             onto that, merely the same thing)
> 
> patch 11:   Provide a valid vt-d replay() callback, using page walk
> 
> patch 12:   Enable the domain switch support - we replay() when
>             context entry got invalidated
> 
> patch 13:   Enhancement for existing invalidation notification,
>             instead of using translate() for each page, we leverage
>             the new vtd_page_walk() interface, which should be faster.
> 
> I would glad to hear about any review comments for above patches
> (especially patch 8-13, which is the main part of this series),
> especially any issue I missed in the series.

Hi, Michael,

Could you help have a look on this series? Hope we can move this
series forward a bit since it's still lack of review.

Btw, IMHO we can merge patch 1 now since people might encounter issue
without it (and it has been dangling quite a long time upstream).

Thanks,

-- peterx
