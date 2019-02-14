Received: from eggs.gnu.org ([209.51.188.92]:43718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1guCcr-0007LB-Ac
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1guCcn-00049k-0I
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:44:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1guCcm-00048Y-Jz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:44:04 -0500
Date: Thu, 14 Feb 2019 16:43:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190214084354.GC9932@xz-x1>
References: <20190212062728.GK1011@xz-x1> <20190213090041.GF16968@yi.y.sun>
	<20190213104224.GA4405@xz-x1> <20190214015204.GG16968@yi.y.sun>
	<20190214032435.GA3197@xz-x1> <20190214062730.GH16968@yi.y.sun>
	<20190214071330.GA9932@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C9402DA@SHSMSX104.ccr.corp.intel.com>
	<20190214081305.GB9932@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C9403C2@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C9403C2@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [RFC v1 2/3] intel_iommu: add 256 bits qi_desc
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>

On Thu, Feb 14, 2019 at 08:22:05AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Thursday, February 14, 2019 4:13 PM
> > 
> > On Thu, Feb 14, 2019 at 07:35:20AM +0000, Tian, Kevin wrote:
> > > > From: Peter Xu [mailto:peterx@redhat.com]
> > > > Sent: Thursday, February 14, 2019 3:14 PM
> > > >
> > > > >
> > > > > > When 256 bits invalidation descriptor is used, the guest driver
> > > > > > should be responsible to fill in zeros into reserved fields.
> > > > > >
> > > > > > Another question: is val[2] & val[3] used in any place even with
> > > > > > 256bits mode?  From what I see from the spec (chap 6.5.2), all of
> > them
> > > > > > seems to be reserved as zeros, then I don't understand why bother
> > > > > > extending this to 256bits...  Did I miss something?
> > > > > >
> > >
> > > PRQ is extended to carry larger private data which requires 256bits
> > > mode. You can take a look at 7.5.1.1 Page Request Descriptor.
> > 
> > But we are talking about IQ (Invalidation Queue), not PRQ, right?
> > 
> > I see that Page Request Queue seems to always have 256bits descriptors
> > (chap 10.4.32, there is no Descriptor Width field, and I think it
> > means DW==1 always), however the Invalidation Queue seems to support
> > both modes (chap 10.4.23, there is Descriptor Width field, DW==0
> > should be the legacy mode, and DW==1 should be the new mode).  While,
> > none of the invalidate descriptors described in chap 6.5.2 is using
> > the upper 128bits even if 256bits mode is supported.
> > 
> 
> Page Group Response descriptor is composed by software through
> invalidation queue, which needs to carry same private data back
> (as in page request descriptor). it's described in 7.7.1.

I see the point.  Thanks, Kevin.

Regards,

-- 
Peter Xu
