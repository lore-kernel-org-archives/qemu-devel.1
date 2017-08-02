Received: from eggs.gnu.org ([2001:4830:134:3::10]:59925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dckJC-0004Bh-De
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dckJ9-0001Nb-4E
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:26:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dckJ8-0001N6-Tm
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 23:26:51 -0400
Date: Wed, 2 Aug 2017 11:20:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170802032043.GA15080@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-5-git-send-email-peterx@redhat.com>
	<20170731171155.GE2122@work-vm>
	<20170801024319.GC15697@pxdev.xzpeter.org>
	<20170801084009.GA2079@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170801084009.GA2079@work-vm>
Subject: Re: [Qemu-devel] [RFC 04/29] bitmap: introduce bitmap_invert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Tue, Aug 01, 2017 at 09:40:09AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Mon, Jul 31, 2017 at 06:11:56PM +0100, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > It is used to invert the whole bitmap.
> > > 
> > > Would it be easier to change bitmap_complement to use ^
> > > in it's macro and slow_bitmap_complement, and then you could call it
> > > with src==dst  to do the same thing with just that small change?
> > 
> > Or, I can directly use that and drop this patch. :-)
> 
> Yes, that's fine - note the only difference I see is what happens to the
> bits in the last word after the end of the count; your code leaves them
> as is, the complement code will zero them on the destination I think.

I see.  I believe both should work since bitmap users should not
use those bits after all (considering those bits are outside range of
valid bits when declaring the bitmap).  Thanks,

-- 
Peter Xu
