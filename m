Received: from eggs.gnu.org ([2001:4830:134:3::10]:37430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIuAZ-00039P-NZ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIuAW-0005lm-Hz
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:23:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIuAW-0005l0-Bs
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 04:23:40 -0500
Date: Mon, 19 Dec 2016 17:23:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161219092335.GB4155@pxdev.xzpeter.org>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
	<1481020588-4245-4-git-send-email-peterx@redhat.com>
	<20161218083911.GA24337@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161218083911.GA24337@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 03/13] intel_iommu: renaming gpa to
 iova where proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: kevin.tian@intel.com, tianyu.lan@intel.com, jasowang@redhat.com, qemu-devel@nongnu.org, yi.l.liu@intel.com

On Sun, Dec 18, 2016 at 04:39:11PM +0800, Liu, Yi L wrote:

[...]

> > @@ -595,12 +595,12 @@ static uint64_t vtd_get_slpte(dma_addr_t base_addr, uint32_t index)
> >      return slpte;
> >  }
> >  
> > -/* Given a gpa and the level of paging structure, return the offset of current
> > - * level.
> > +/* Given a iova and the level of paging structure, return the offset
> maybe "an iova" instead of "a iova"

Will fix. Thanks,

-- peterx
